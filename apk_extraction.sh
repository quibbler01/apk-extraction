#Copyright [2021] [Quibbler.cn]
#
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.


#current focused App, output: mCurrentFocus=Window{c053bb9 u0 com.ss.android.ugc.aweme/com.ss.android.ugc.aweme.splash.SplashActivity}
focus=`adb shell dumpsys window | findStr mCurrentFocus`


#extract out {package/class}, output: com.ss.android.ugc.aweme/com.ss.android.ugc.aweme.splash.SplashActivity
classpath=`echo ${focus#*{} | awk '{print $3}'`


#crop string extract package name, output: com.ss.android.ugc.aweme
package=`echo ${classpath%/*}`


#figure out this package install path, output: package:/data/app/com.ss.android.ugc.aweme-bWD-6eHGY_JWxoiHreHc5A==/base.apk
path=`adb shell pm path $package`
#sub path from pm output's, output: data/app/com.ss.android.ugc.aweme-bWD-6eHGY_JWxoiHreHc5A==/base.apk
path=`echo ${path#*/}`
#and replace '/' with '//' if path include '/base.apk',E.g: data/app/com.vivo.easyshare-Q46ic5yVLxvgkiPRkB318Q==//base.apk
if [[ $path =~ /base.apk ]]; then
	path=`echo ${path///base.apk///base.apk}`
fi


#pull apk out renanme with package name
adb pull $path  $package.apk

