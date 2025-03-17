Return-Path: <netdev+bounces-175219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB050A646AC
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 10:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F381894919
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 09:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA83221F1B;
	Mon, 17 Mar 2025 09:09:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A53221F15;
	Mon, 17 Mar 2025 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742202565; cv=none; b=C+je3R5wm8KbB+i7yzu4aJx/eYTMl16zg6+3GFFq1kjN+/ukOEhW1try/4b9qH0UDw3LHK0HxhdCjUKb9TOjntXr/Q9dYowfz2aG/uBGPOx+LGrRu4qP6aLXQed+CZovgPj8ahbRTP8d0QKHogbR2vHo+2AzBlUsTUjLtcmc0q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742202565; c=relaxed/simple;
	bh=A58IKkT2v4JxafP4IjCwILzRT1z9Vw+XfcSbYNDROaE=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=bIdubHFPn+dXoe9wwuyckKE2gLLvTZK7XjFOZq59dglcZdznMO7rR/aRLhwFaRrt76lRXu58MszQnv/S39qx2l/zMX8oToos9Fi7gyQNlgsb8njEhcKeIlI+smtp42U+L2eWP56PjoEbFFk+pJNw/oGsVqTm3j3QKcISf7fbJHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZGTgH3yMRz501gV;
	Mon, 17 Mar 2025 17:09:15 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 52H98xbl059278;
	Mon, 17 Mar 2025 17:08:59 +0800 (+08)
	(envelope-from tang.dongxing@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 17 Mar 2025 17:09:02 +0800 (CST)
Date: Mon, 17 Mar 2025 17:09:02 +0800 (CST)
X-Zmail-TransId: 2af967d7e6ae63b-29978
X-Mailer: Zmail v1.0
Message-ID: <20250317170902154iQh7_gBiO8KjCrFrhnAqn@zte.com.cn>
In-Reply-To: <e0204a28-7e3a-48f9-aea9-20b35294ada6@kernel.org>
References: 20250317155102808MZdMkiovw52X0oY7n47wI@zte.com.cn,e0204a28-7e3a-48f9-aea9-20b35294ada6@kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <tang.dongxing@zte.com.cn>
To: <krzk@kernel.org>
Cc: <davem@davemloft.net>, <feng.wei8@zte.com.cn>, <shao.mingyin@zte.com.cn>,
        <xie.ludan@zte.com.cn>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yang.guang5@zte.com.cn>,
        <yang.yang29@zte.com.cn>, <ye.xingchen@zte.com.cn>,
        <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gbmV0OiBhdG06IHVzZSBzeXNmc19lbWl0X2F0KCkgaW5zdGVhZCBvZiBzY25wcmludGYoKQ==?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl1.zte.com.cn 52H98xbl059278
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D7E6BB.000/4ZGTgH3yMRz501gV



--=====_001_next=====
Content-Type: multipart/related;
	boundary="=====_002_next====="


--=====_002_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

Pk9uIDE3LzAzLzIwMjUgMDg6NTEsIHRhbmcuZG9uZ3hpbmdAenRlLmNvbS5jbiB3cm90ZTo+IEZy
b206IFRhbmdEb25neGluZyA8dGFuZy5kb25neGluZ0B6dGUuY29tLmNuPg0KPj4gDQo+PiBGb2xs
b3cgdGhlIGFkdmljZSBpbiBEb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL3N5c2ZzLnJzdDoNCj4+
IHNob3coKSBzaG91bGQgb25seSB1c2Ugc3lzZnNfZW1pdCgpIG9yIHN5c2ZzX2VtaXRfYXQoKSB3
aGVuIGZvcm1hdHRpbmcNCj4+IHRoZSB2YWx1ZSB0byBiZSByZXR1cm5lZCB0byB1c2VyIHNwYWNl
Lg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBUYW5nIERvbmd4aW5nIDx0YW5nLmRvbmd4aW5nQHp0
ZS5jb20uY24+RGVhciBaVEUsDQo+DQo+Q2FuIHlvdSBzbG93IGRvd24/IFlvdSBzZW50IGEgYnVu
Y2ggb2YgZW1haWxzIHdpdGggc2ltaWxhciBpc3N1ZXMgd2hpY2gNCj5tZWFucyB0aGF0IGRvemVu
IG9mIG1haW50YWluZXJzIHdpbGwgZGVhbCB3aXRoIHRoZSBzYW1lIGlzc3Vlcw0KPmluZGVwZW5k
ZW50bHkuIFRoaXMgbG9va3MgbGlrZSBhbm90aGVyIHZpdm8gb3IgaHVhd2VpIHN0eWxlIHN1Ym1p
c3Npb24sDQo+bGVhZGluZyB0byBidWdzIHNuZWFrZWQgdmlhIGZsb29kIG9mIHBhdGNoZXMuDQo+
DQo+Rmlyc3QsIGZpeCB0aGUgbmFtZSB1c2VkIGluIHRoZSBTb0IgKHNlZSBzdWJtaXR0aW5nIHBh
dGNoZXMpIHRvIG1hdGNoDQo+TGF0aW4gdHJhbnNjcmlwdGlvbi4NCj4NCj5TZWNvbmQsIHVzZSBw
cm9wZXIgU29CIGNoYWluLCBzZWUgc3VibWl0dGluZyBwYXRjaGVzLg0KPg0KPlRoaXJkLCByZWFs
bHksIHJlYWxseSBiZSBzdXJlIHRoYXQgd2hhdCB5b3Ugc2VuZCBpcyBjb3JyZWN0LiBZb3UgYWxy
ZWFkeQ0KPmdvdCBxdWl0ZSByZXNwb25zZXMsIGJ1dCB5b3Ugc3RpbGwga2VlcCBzZW5kaW5nIHBh
dGNoZXMuDQo+DQo+Rm91cnRoLCByZXNwb25kIHRvIHJlY2VpdmVkIGZlZWRiYWNrIGluc3RlYWQg
b2YgZmxvb2RpbmcgdXMgd2l0aCBtb3JlIG9mDQo+dGhpcyENCg0KRGVhciBLcnp5c3p0b2YsDQpU
aGFuayB5b3UgZm9yIHlvdXIgZmVlZGJhY2suIEkgYXBvbG9naXplIGZvciBteSBwcmV2aW91cyBz
dWJtaXNzaW9ucy4NClJlZ2FyZGluZyB0aGUgaXNzdWVzIHlvdSd2ZSBwb2ludGVkIG91dDoNCkkg
d2lsbCBjb3JyZWN0IHRoZSBuYW1lIHVzZWQgaW4gdGhlIFNvQiB0byBlbnN1cmUgaXQgbWF0Y2hl
cyB0aGUgTGF0aW4gdHJhbnNjcmlwdGlvbiBhcyByZXF1aXJlZC4NCkkgd2lsbCBkb3VibGUtY2hl
Y2sgbXkgd29yayBiZWZvcmUgc2VuZGluZyBhbnkgZnVydGhlciB1cGRhdGVzLg0KSSBhcHByZWNp
YXRlIHlvdXIgZ3VpZGFuY2UgYW5kIHdpbGwgZm9sbG93IHRoZSBzdWJtaXNzaW9uIGd1aWRlbGlu
ZXMgbW9yZSBjYXJlZnVsbHkgZ29pbmcgZm9yd2FyZC4gSWYgeW91IGhhdmUgYW55IGZ1cnRoZXIg
YWR2aWNlIG9yIHJlc291cmNlcyB0byBoZWxwIG1lIGltcHJvdmUgbXkgc3VibWlzc2lvbnMsIEkg
d291bGQgYmUgZ3JhdGVmdWwgZm9yIHlvdXIgaW5wdXQuDQpCZXN0IHJlZ2FyZHMsIA0KVGFuZyBE
b25neGluZw==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxwPiZndDtPbiAxNy8wMy8yMDI1IDA4OjUxLCB0YW5n
LmRvbmd4aW5nQHp0ZS5jb20uY24gd3JvdGU6Jmd0OyBGcm9tOiBUYW5nRG9uZ3hpbmcgJmx0O3Rh
bmcuZG9uZ3hpbmdAenRlLmNvbS5jbiZndDs8L3A+PHA+Jmd0OyZndDsmbmJzcDs8L3A+PHA+Jmd0
OyZndDsgRm9sbG93IHRoZSBhZHZpY2UgaW4gRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9zeXNm
cy5yc3Q6PC9wPjxwPiZndDsmZ3Q7IHNob3coKSBzaG91bGQgb25seSB1c2Ugc3lzZnNfZW1pdCgp
IG9yIHN5c2ZzX2VtaXRfYXQoKSB3aGVuIGZvcm1hdHRpbmc8L3A+PHA+Jmd0OyZndDsgdGhlIHZh
bHVlIHRvIGJlIHJldHVybmVkIHRvIHVzZXIgc3BhY2UuPC9wPjxwPiZndDsmZ3Q7Jm5ic3A7PC9w
PjxwPiZndDsmZ3Q7IFNpZ25lZC1vZmYtYnk6IFRhbmcgRG9uZ3hpbmcgJmx0O3RhbmcuZG9uZ3hp
bmdAenRlLmNvbS5jbiZndDtEZWFyIFpURSw8L3A+PHA+Jmd0OzwvcD48cD4mZ3Q7Q2FuIHlvdSBz
bG93IGRvd24/IFlvdSBzZW50IGEgYnVuY2ggb2YgZW1haWxzIHdpdGggc2ltaWxhciBpc3N1ZXMg
d2hpY2g8L3A+PHA+Jmd0O21lYW5zIHRoYXQgZG96ZW4gb2YgbWFpbnRhaW5lcnMgd2lsbCBkZWFs
IHdpdGggdGhlIHNhbWUgaXNzdWVzPC9wPjxwPiZndDtpbmRlcGVuZGVudGx5LiBUaGlzIGxvb2tz
IGxpa2UgYW5vdGhlciB2aXZvIG9yIGh1YXdlaSBzdHlsZSBzdWJtaXNzaW9uLDwvcD48cD4mZ3Q7
bGVhZGluZyB0byBidWdzIHNuZWFrZWQgdmlhIGZsb29kIG9mIHBhdGNoZXMuPC9wPjxwPiZndDs8
L3A+PHA+Jmd0O0ZpcnN0LCBmaXggdGhlIG5hbWUgdXNlZCBpbiB0aGUgU29CIChzZWUgc3VibWl0
dGluZyBwYXRjaGVzKSB0byBtYXRjaDwvcD48cD4mZ3Q7TGF0aW4gdHJhbnNjcmlwdGlvbi48L3A+
PHA+Jmd0OzwvcD48cD4mZ3Q7U2Vjb25kLCB1c2UgcHJvcGVyIFNvQiBjaGFpbiwgc2VlIHN1Ym1p
dHRpbmcgcGF0Y2hlcy48L3A+PHA+Jmd0OzwvcD48cD4mZ3Q7VGhpcmQsIHJlYWxseSwgcmVhbGx5
IGJlIHN1cmUgdGhhdCB3aGF0IHlvdSBzZW5kIGlzIGNvcnJlY3QuIFlvdSBhbHJlYWR5PC9wPjxw
PiZndDtnb3QgcXVpdGUgcmVzcG9uc2VzLCBidXQgeW91IHN0aWxsIGtlZXAgc2VuZGluZyBwYXRj
aGVzLjwvcD48cD4mZ3Q7PC9wPjxwPiZndDtGb3VydGgsIHJlc3BvbmQgdG8gcmVjZWl2ZWQgZmVl
ZGJhY2sgaW5zdGVhZCBvZiBmbG9vZGluZyB1cyB3aXRoIG1vcmUgb2Y8L3A+PHA+Jmd0O3RoaXMh
PC9wPjxwPjxicj48L3A+PHA+RGVhciBLcnp5c3p0b2YsPC9wPjxwPlRoYW5rIHlvdSBmb3IgeW91
ciBmZWVkYmFjay4gSSBhcG9sb2dpemUgZm9yIG15IHByZXZpb3VzIHN1Ym1pc3Npb25zLjwvcD48
cD5SZWdhcmRpbmcgdGhlIGlzc3VlcyB5b3UndmUgcG9pbnRlZCBvdXQ6PC9wPjxwPkkgd2lsbCBj
b3JyZWN0IHRoZSBuYW1lIHVzZWQgaW4gdGhlIFNvQiB0byBlbnN1cmUgaXQgbWF0Y2hlcyB0aGUg
TGF0aW4gdHJhbnNjcmlwdGlvbiBhcyByZXF1aXJlZC48L3A+PHA+SSB3aWxsIGRvdWJsZS1jaGVj
ayBteSB3b3JrIGJlZm9yZSBzZW5kaW5nIGFueSBmdXJ0aGVyIHVwZGF0ZXMuPC9wPjxwPkkgYXBw
cmVjaWF0ZSB5b3VyIGd1aWRhbmNlIGFuZCB3aWxsIGZvbGxvdyB0aGUgc3VibWlzc2lvbiBndWlk
ZWxpbmVzIG1vcmUgY2FyZWZ1bGx5IGdvaW5nIGZvcndhcmQuIElmIHlvdSBoYXZlIGFueSBmdXJ0
aGVyIGFkdmljZSBvciByZXNvdXJjZXMgdG8gaGVscCBtZSBpbXByb3ZlIG15IHN1Ym1pc3Npb25z
LCBJIHdvdWxkIGJlIGdyYXRlZnVsIGZvciB5b3VyIGlucHV0LjwvcD48cD5CZXN0IHJlZ2FyZHMs
Jm5ic3A7PC9wPjxwPlRhbmcgRG9uZ3hpbmc8L3A+PHA+PGJyPjwvcD48L2Rpdj4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


