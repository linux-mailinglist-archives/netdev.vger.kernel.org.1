Return-Path: <netdev+bounces-153241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EFA9F7531
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 08:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C9216C9ED
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 07:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FAC216E3E;
	Thu, 19 Dec 2024 07:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="nadw9C5N"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BD815AD9C
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734592419; cv=none; b=etsH2OIjZFbYo/Q0MbXOhAXt11o0YVzuBiTi4pzkilQBKpw2uScqLqubb6MqGmDeEa6zb4i1bBYgLR2ye1hCHgsh2yPU1B4ka+n9Cgn5FWlLv2QJ1+P7H1YZnu3wIfu4Ez+RfQOAT/Q+7CeM7gyYhKgeAYrPNkkyQZLb6dg4Ecs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734592419; c=relaxed/simple;
	bh=VVmsLsYLgJ6dfYR63bJCgBlqhF8GN4cvCDdBn4Ry0xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QnD9yA770w9WERO0E34dyIVHfvROfMUKU/vwQTgFDF5wBQBANycCTqIgXuCw5+WGUsuqPcVQU7X/N/mE2RKz1rQzcEucev5wdtexD3l6hQLsBcy1jSROiw4FT83mIWoITRtChDKpfHONw7mUn6vD2xrkuRpI8i+Pkm7xfIsPh+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=nadw9C5N; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1734592335;
	bh=+MEAUGGXL0Erz0WkbnodWUkGrFLvVkbl1vv6+fCRWH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=nadw9C5N50EYCmEPuefl3Rqm5ak+Z8zeBHRBXtljQLvZNu2Hy8AigV7WWMegjzmrL
	 lBSQ4C8mfeIDzdlpt2JAXIpI2ykdjxYGG8pd7gKuw82LLXDI1UZvUFt+9keYEIs4W1
	 VkYMFrW2sl/khC5sQfRBCMkxs98JdL9S6/qZL5sw=
X-QQ-mid: bizesmtpip4t1734592290tjr7r2n
X-QQ-Originating-IP: l6hQyAfuhMYTk+SclTpaR6OaKpjGMSd86SRP/orbWPg=
Received: from [IPV6:240e:668:120a::253:10f] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 19 Dec 2024 15:11:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16436400738179319441
Message-ID: <5DB5DA2260D540B9+359f8cbf-e560-495d-8afe-392573f1171b@uniontech.com>
Date: Thu, 19 Dec 2024 15:11:24 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND. PATCH] mt76: mt76u_vendor_request: Do not print error
 messages when -EPROTO
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
 shayne.chen@mediatek.com, sean.wang@mediatek.com, kvalo@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, alexander.deucher@amd.com,
 gregkh@linuxfoundation.org, rodrigo.vivi@intel.com,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 raoxu@uniontech.com, guanwentao@uniontech.com, zhanjun@uniontech.com,
 cug_yangyuancong@hotmail.com, lorenzo.bianconi@redhat.com,
 kvalo@codeaurora.org, sidhayn@gmail.com, lorenzo.bianconi83@gmail.com,
 sgruszka@redhat.com, keescook@chromium.org, markus.theil@tu-ilmenau.de,
 gustavoars@kernel.org, stf_xl@wp.pl, romain.perier@gmail.com,
 apais@linux.microsoft.com, mrkiko.rs@gmail.com, oliver@neukum.org,
 woojung.huh@microchip.com, helmut.schaa@googlemail.com,
 mailhol.vincent@wanadoo.fr, dokyungs@yonsei.ac.kr, deren.wu@mediatek.com,
 daniel@makrotopia.org, sujuan.chen@mediatek.com,
 mikhail.v.gavrilov@gmail.com, stern@rowland.harvard.edu,
 linux-usb@vger.kernel.org, leitao@debian.org, dsahern@kernel.org,
 weiwan@google.com, netdev@vger.kernel.org, horms@kernel.org, andrew@lunn.ch,
 leit@fb.com, wang.zhao@mediatek.com, chui-hao.chiu@mediatek.com,
 lynxis@fe80.eu, mingyen.hsieh@mediatek.com, yn.chen@mediatek.com,
 quan.zhou@mediatek.com, dzm91@hust.edu.cn, gch981213@gmail.com,
 git@qrsnap.io, jiefeng_li@hust.edu.cn, nelson.yu@mediatek.com,
 rong.yan@mediatek.com, Bo.Jiao@mediatek.com, StanleyYP.Wang@mediatek.com
References: <1E6ABDEA91ADAB1A+20241218090833.140045-1-wangyuli@uniontech.com>
 <a2bbdfb4-19ed-461e-a14b-e91a5636cc77@intel.com>
Content-Language: en-US
From: WangYuli <wangyuli@uniontech.com>
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <a2bbdfb4-19ed-461e-a14b-e91a5636cc77@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------lzZ32JdsjGIy0QqsKa26e0mC"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N0JG5d2dvsRDZrFOWdicm9YxypA1VUqzgskXmkpuX4P+Rlz55V30y8pg
	cpWs7Jrbr7Lj2NWYMQjSfaGTNGnkhOKgev1tqOvy2zz7hdWgI8Ipf+mEe8EymFR7VuJ59Xd
	Kopz6QCvVxYX4YdHEthfBAp0Cx9ylpLSQEZLjiK6cm719hCCb9Mwxw8EPVIidyqPqx6Z/um
	2fVqR7dzotqGWM2QniXIaT9tMByqxd6Ebq2DPBZCHJhJ9BPzHD57vs6iXyoXxobnow2F3e0
	DpmDNH8QZVUvaHjUCNt/wTmqVyoNdIH4VG/G2wzZ/hOT+AYMwHJGkKhTaXQxejq7BStHh43
	znGx4abpM7//F8x9fPnCpXcva3+BxtVgS7In2cpHZlGlSqCkmJIbtC/uB/i1rBstBiod4l+
	l/suOCPEBxAAyCntc63M5KBfT+0z/K3B3LaxhFIaghSXjOPtcB0fjyhgpSWR8xSLaEhGII2
	XjgcEx4DUGteDPGuQN7klpfkqRQ//XEV0Y8/JC6WLOKPsL2jQXts32n0HydOITTQbizi9+V
	11QoZlCks5ZUOrQoWh7Vi9xAa8heJpNCxIu7WL4rrfEj8CFjJaHERhPxH9T3zpJZvpXfFMd
	Qpxppc58jtWhUFMcdKzzs8TeqwabhqQBwdsmB6FcnIzOrkfbsBMWiAcLRTCkn89fXFwzjkC
	HQYxNBuWEQ6YvMRUqJBcAvvvv5T7sQZW9PLXFHpbH84zG7oRjpuaDUx3/CDH1CY/r87cbGc
	77ITiC8+07NDUZ7eqrnbctN8Xp97/xmlqP76DrxjrSG1ZyJqcjRh0MZnQYt7Tp0aobKDH8V
	w35vVspbILE37h/rY72DWNGKKUGQPHoZoKQxtQR6MY7+yuDg1OdhsvfVHabNjFy76qrTrVx
	1noRaK8yJk7Zxj8GSyYu47H/Uavu3ZDlaJgSU5EMAJ5AIqydD1yn6r9iqVZjy9Znw/gNSV6
	UDzSz3pWwatD6EsGW69UbSAe+l4GSFr4UNmPsdF1Jcl609vXXKNwGvkg2SKzxrBOaJUY7NY
	V1t45q+yqMIxwtgfAsaKpmCN2Ujmo1dG64wcO8Z63t7bpPoWrjOCU60dmIHoUmij0NJ0xf6
	QsLIpYZEa0b
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------lzZ32JdsjGIy0QqsKa26e0mC
Content-Type: multipart/mixed; boundary="------------t9kOQFUFBryxJS1kEc7YATUG";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
 shayne.chen@mediatek.com, sean.wang@mediatek.com, kvalo@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, alexander.deucher@amd.com,
 gregkh@linuxfoundation.org, rodrigo.vivi@intel.com,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 raoxu@uniontech.com, guanwentao@uniontech.com, zhanjun@uniontech.com,
 cug_yangyuancong@hotmail.com, lorenzo.bianconi@redhat.com,
 kvalo@codeaurora.org, sidhayn@gmail.com, lorenzo.bianconi83@gmail.com,
 sgruszka@redhat.com, keescook@chromium.org, markus.theil@tu-ilmenau.de,
 gustavoars@kernel.org, stf_xl@wp.pl, romain.perier@gmail.com,
 apais@linux.microsoft.com, mrkiko.rs@gmail.com, oliver@neukum.org,
 woojung.huh@microchip.com, helmut.schaa@googlemail.com,
 mailhol.vincent@wanadoo.fr, dokyungs@yonsei.ac.kr, deren.wu@mediatek.com,
 daniel@makrotopia.org, sujuan.chen@mediatek.com,
 mikhail.v.gavrilov@gmail.com, stern@rowland.harvard.edu,
 linux-usb@vger.kernel.org, leitao@debian.org, dsahern@kernel.org,
 weiwan@google.com, netdev@vger.kernel.org, horms@kernel.org, andrew@lunn.ch,
 leit@fb.com, wang.zhao@mediatek.com, chui-hao.chiu@mediatek.com,
 lynxis@fe80.eu, mingyen.hsieh@mediatek.com, yn.chen@mediatek.com,
 quan.zhou@mediatek.com, dzm91@hust.edu.cn, gch981213@gmail.com,
 git@qrsnap.io, jiefeng_li@hust.edu.cn, nelson.yu@mediatek.com,
 rong.yan@mediatek.com, Bo.Jiao@mediatek.com, StanleyYP.Wang@mediatek.com
Message-ID: <359f8cbf-e560-495d-8afe-392573f1171b@uniontech.com>
Subject: Re: [RESEND. PATCH] mt76: mt76u_vendor_request: Do not print error
 messages when -EPROTO
References: <1E6ABDEA91ADAB1A+20241218090833.140045-1-wangyuli@uniontech.com>
 <a2bbdfb4-19ed-461e-a14b-e91a5636cc77@intel.com>
In-Reply-To: <a2bbdfb4-19ed-461e-a14b-e91a5636cc77@intel.com>

--------------t9kOQFUFBryxJS1kEc7YATUG
Content-Type: multipart/mixed; boundary="------------yW0HEyhQsnN0e7VNb0LN57Ek"

--------------yW0HEyhQsnN0e7VNb0LN57Ek
Content-Type: multipart/alternative;
 boundary="------------v8YpJ2JjzcZFOBmM8z0ncFDr"

--------------v8YpJ2JjzcZFOBmM8z0ncFDr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAyNC8xMi8xOSAwMDoxMCwgQWxleGFuZGVyIExvYmFraW4gd3JvdGU6DQoNCj4gSXMg
aXQgYSBmaXggb3IgYW4gaW1wcm92ZW1lbnQ/DQo+IFlvdSBuZWVkIHRvIHNwZWNpZnkgdGhl
IHRhcmdldCB0cmVlLCBlaXRoZXIgJ1BBVENIIG5ldCcgKGZpeGVzKSBvcg0KPiAnUEFUQ0gg
bmV0LW5leHQnIChpbXByb3ZlbWVudHMpLg0KIMKgSXQgaXMgYSBmaXggbm90IGFuIGltcHJv
dmVtZW50Lg0KPiBIb3cgZG8gb3RoZXIgZHJpdmVycyBoYW5kbGUgdGhpcz8NCj4gQ2FuIC1F
UFJPVE8gaGFwcGVuIGluIG90aGVyIGNhc2VzLCBub3Qgb25seSB1bnBsdWdnaW5nLCB3aGlj
aCB0aGlzIHBhdGNoDQo+IHdvdWxkIGJyZWFrPw0KPg0KV2hlbiBpbml0aWFsaXppbmcgdGhl
IG5ldHdvcmsgY2FyZCwgdW5wbHVnZ2luZyB0aGUgZGV2aWNlIHdpbGwgdHJpZ2dlciANCmFu
IC1FUFJPVE8gZXJyb3IuDQoNClRoZSBleGNlcHRpb24gaXMgcHJpbnRlZCBhcyBmb2xsb3dz
77yaDQoNCg0KIMKgwqDCoMKgwqDCoMKgIG10NzZ4MnUgMi0yLjQ6MS4wOiB2ZW5kb3IgcmVx
dWVzdCByZXE6NDcgb2ZmOjkwMTggZmFpbGVkOi03MQ0KIMKgwqDCoMKgwqDCoMKgIG10NzZ4
MnUgMi0yLjQ6MS4wOiB2ZW5kb3IgcmVxdWVzdCByZXE6NDcgb2ZmOjkwMTggZmFpbGVkOi03
MQ0KIMKgwqDCoMKgwqDCoMKgIC4uLg0KDQpJdCB3aWxsIGNvbnRpbnVlIHRvIHByaW50IG1v
cmUgdGhhbiAyMDAwIHRpbWVzIGZvciBhYm91dCA1IG1pbnV0ZXMsIA0KY2F1c2luZyB0aGUg
dXNiIGRldmljZSB0byBiZSB1bmFibGUgdG8gYmUgZGlzY29ubmVjdGVkLiBEdXJpbmcgdGhp
cyANCnBlcmlvZCwgdGhlIHVzYiBwb3J0IGNhbm5vdCByZWNvZ25pemUgdGhlIG5ldyBkZXZp
Y2UgYmVjYXVzZSB0aGUgb2xkIA0KZGV2aWNlIGhhcyBub3QgZGlzY29ubmVjdGVkLg0KDQpU
aGVyZSBtYXkgYmUgb3RoZXIgb3BlcmF0aW5nIG1ldGhvZHMgdGhhdCBjYXVzZSAtRVBST1RP
LCBidXQgLUVQUk9UTyBpcyANCmEgbG93LWxldmVsIGhhcmR3YXJlIGVycm9yLiBJdCBpcyB1
bndpc2UgdG8gcmVwZWF0IHZlbmRvciByZXF1ZXN0cyANCmV4cGVjdGluZyB0byByZWFkIGNv
cnJlY3QgZGF0YS4gSXQgaXMgYSBiZXR0ZXIgY2hvaWNlIHRvIHRyZWF0IC1FUFJPVE8gDQph
bmQgLUVOT0RFViB0aGUgc2FtZSB3YXnjgIINCg0KU2ltaWxhciB0byBjb21taXQg77yIbXQ3
NjogdXNiOiBwcm9jZXNzIFVSQnMgd2l0aCBzdGF0dXMgRVBST1RPIA0KcHJvcGVybHnvvIlk
byBubyBzY2hlZHVsZSByeF93b3JrZXIgZm9yIHVyYiBtYXJrZWQgd2l0aCBzdGF0dXMgc2V0
IA0KLUVQUk9UTy4gSSBhbHNvIHJlcHJvZHVjZWQgdGhpcyBzaXR1YXRpb24gd2hlbiBwbHVn
Z2luZyBhbmQgdW5wbHVnZ2luZyANCnRoZSBkZXZpY2UsIGFuZCB0aGlzIHBhdGNoIGlzIGVm
ZmVjdGl2ZS4NCg0KSnVzdCBkbyBub3QgdmVuZG9yIHJlcXVlc3QgYWdhaW4gZm9yIHVyYiBt
YXJrZWQgd2l0aCBzdGF0dXMgc2V0IC1FUFJPVE8gLg0KDQoNClRoYW5rcywNCg0KLS0gDQpX
YW5nWXVsaQ0K
--------------v8YpJ2JjzcZFOBmM8z0ncFDr
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <p>On 2024/12/19 00:10, Alexander Lobakin wrote:</p>
    <blockquote type=3D"cite"
      cite=3D"mid:a2bbdfb4-19ed-461e-a14b-e91a5636cc77@intel.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">Is it a fix or an improvemen=
t?
You need to specify the target tree, either 'PATCH net' (fixes) or
'PATCH net-next' (improvements).
</pre>
    </blockquote>
    =C2=A0It is a fix not an improvement.<span style=3D"white-space: pre-=
wrap">
</span>
    <blockquote type=3D"cite"
      cite=3D"mid:a2bbdfb4-19ed-461e-a14b-e91a5636cc77@intel.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">How do other drivers handle =
this?
Can -EPROTO happen in other cases, not only unplugging, which this patch
would break?

</pre>
    </blockquote>
    <p>When initializing the network card, unplugging the device will
      trigger an -EPROTO error.</p>
    <p>The exception is printed as follows=EF=BC=9A</p>
    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0<br>
    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mt76x2u 2-2.4:1.0: vendor =
request req:47 off:9018 failed:-71<br>
    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mt76x2u 2-2.4:1.0: vendor =
request req:47 off:9018 failed:-71<br>
    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...<br>
    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0<br>
    <p>It will continue to print more than 2000 times for about 5
      minutes, causing the usb device to be unable to be disconnected.=C2=
=A0
      During this period, the usb port cannot recognize the new device
      because the old device has not disconnected.</p>
    <p>There may be other operating methods that cause -EPROTO, but
      -EPROTO is a low-level hardware error. It is unwise to repeat
      vendor requests expecting to read correct data. It is a better
      choice to treat -EPROTO and -ENODEV the same way=E3=80=82</p>
    <p>Similar to commit =EF=BC=88mt76: usb: process URBs with status EPR=
OTO
      properly=EF=BC=89do no schedule rx_worker for urb marked with statu=
s set
      -EPROTO. I also reproduced this situation when plugging and
      unplugging the device, and this patch is effective.</p>
    <p>Just do not vendor request again for urb marked with status set
      -EPROTO .</p>
    <p><br>
    </p>
    <p>Thanks,<br>
    </p>
    <div class=3D"moz-signature">-- <br>
      <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DU=
TF-8">
      WangYuli</div>
  </body>
</html>

--------------v8YpJ2JjzcZFOBmM8z0ncFDr--

--------------yW0HEyhQsnN0e7VNb0LN57Ek
Content-Type: application/pgp-keys; name="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSK
P+nX39DNIVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAx
FiEEa1GMzYeuKPkgqDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMB
AAAKCRDF2h8wRvQL7g0UAQCH3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfP
bwD/SrncJwwPAL4GiLPEC4XssV6FPUAY0rA68eNNI9cJLArOOARmgSyJEgorBgEE
AZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7VTL0dvPDofBTjFYDAQgHwngE
GBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIbDAAKCRDF2h8wRvQL
7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkUo9ERi7qS
/hbUdUgtitI89efbY0TVetgDsyeQiwU=3D
=3DBlkq
-----END PGP PUBLIC KEY BLOCK-----

--------------yW0HEyhQsnN0e7VNb0LN57Ek--

--------------t9kOQFUFBryxJS1kEc7YATUG--

--------------lzZ32JdsjGIy0QqsKa26e0mC
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZ2PHHAUDAAAAAAAKCRDF2h8wRvQL7gYX
AP0W8PzI7QVqA+31JnDg1CxYYXzmXk/c3NaAuW8VObPOqQD/ab4eOVfD6UTQ2ZoytfW3G7bDgzc+
vn00zaCUbHdmrA4=
=1v9C
-----END PGP SIGNATURE-----

--------------lzZ32JdsjGIy0QqsKa26e0mC--

