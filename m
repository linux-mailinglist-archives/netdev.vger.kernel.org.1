Return-Path: <netdev+bounces-124180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF8096867F
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 13:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8EC1C21C68
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 11:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7074E1D6195;
	Mon,  2 Sep 2024 11:44:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8DE1D6184;
	Mon,  2 Sep 2024 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277476; cv=none; b=B1nTHhxqmwESIbXipZAxdhRaVXcDhb1sgCNR6RneEr/y3mC4PuHXahJrikZiUokd5xztg81LDoToc70nMASOKoEjK64+wp+RQ6X9EJq6jEvT6cI0xtHBdCy/ito4xTj0pVyhf/gn1xIOvuoFWsIMH9cgUEDRnuH93heeDqE6nic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277476; c=relaxed/simple;
	bh=uTSWWEcMWHAb3DoesgJoSb8LvIGywPMBaKl0Srbj/XY=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=f+qFhZDgZAekiRWIZ6MzDidWT4QvPHr2FCJPMON/E9+Gd3z7eZhhZLt2mmEgMJCJg1X68AzI/WwPq65wHfPRm+rQrJnZ913pdutaYyUDSE/1u0JXTwkHHe4lL+elkqbkLxFedP0jqQDd8uv+z7XSuYHBqBZwz/EVRFj+HoJYVZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
X-QQ-GoodBg: 2
X-QQ-SSF: 0040000000000000
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-XMAILINFO: OSjQccS6YHkHb45SII8Ftfw23r+kCfO1I9L8eJcWUl+ckgWG6oPRWtux
	e+7bIjnoXJ2mzekK2Al88AZlfoA/y3jIj6f1+DIn/wNJk71a5ye4d07PVLU1E+rsVZI/ecG
	FvtIzxnKgPep4H05cwPfiHgnIj5QGHv2kcWcQprG3WTdVePrXzwpQpuNfj9Tl5LTv4VyzBd
	tFgm+PZwCcOWiZ6O1zdpgJBixSYHOGqlBZe8DPsl06tmrqGEyjX9PeixTfYd6TghTyGD4fp
	icXVXw3/azIrkbSQectKiSV5baOcxBekkgEEo0/hI8WiLid7R0Gd66LmJZhcZ84eaKuMRoM
	BKI/DkdU9xue92oUV6VAtnXDEmENEnvlKY5bpDpYcbb2dh0zAnh59yMLYyn4iuRBHc55on3
	z7CUMQcxp2CqxxalmC956MZcDBR1j5ADkbRAJqh1fDYUP0NHpgBpDupKlfIAH8kS9muQIRX
	8rDzwtCfknshhZ1KU/wm7GmEsXeC9QgF6EWexaa1IxqUfWrJ2BFHXZKM8ENh88dEQdpsIFH
	SlaEOOVx36PKsv8r92VThmh/bxcjhkM1mnFtsDdRGA1ES4lYpQEOmYH7+SfbxsPUO5n1ZyW
	qy5b+T9jsjQzGKOGieZgGMUQpAuvUWKIoq/wiarN3ohw+5xQYkE+OcLw76QnrgMMxhPwQHV
	fk1cNDevyW8l3k5Oc66Y/6XG5WJtsIEyhTquWNrd1MWqdpsqkdjX+eH8sS7YQJ23c6UMci9
	0HPPbVfRDOKzChldWb7JclTphfHaPm0T4zquRr1RzHBvMiDKTnXqwkNFbrcA2npt4Q+Vg1O
	3ul3Ay4+GPoW3JlYaDvOiF3Z2Wqg3oPNQfogqJGssBy/iQMY75gYOoOf3aCrgn3hrZVZ3MG
	EvMruvbJwYqY80bpivhSJ7uJp4JygN/0tC0ECm3zyV0B0Z+y9BNUkcIjot8V9IaPyZuQclH
	Uh4/MSLFEaweM6g==
X-QQ-FEAT: 2Rmh/KmsIngruwTONLJY3WAWKAdbrRsw
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: dmuZ05ao3G3kluBycU5Jr9cTKcstfsVjiTFlSQbb574=
X-QQ-STYLE: 
X-QQ-mid: t6sz3a-0t1725277376t9055661
From: "=?utf-8?B?V2VudGFpIERlbmc=?=" <wtdeng24@m.fudan.edu.cn>
To: "=?utf-8?B?bGludXg=?=" <linux@armlinux.org.uk>
Cc: "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?ZWR1bWF6ZXQ=?=" <edumazet@google.com>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>, "=?utf-8?B?cGFiZW5p?=" <pabeni@redhat.com>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?5p2c6Zuq55uI?=" <21210240012@m.fudan.edu.cn>
Subject: [BUG] Possible Use-After-Free Vulnerability in ether3 Driver Due to Race Condition
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Mon, 2 Sep 2024 19:42:55 +0800
X-Priority: 1
Message-ID: <tencent_48E7914150CBB05A03CD68C4@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 10923399988514903829
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Mon, 02 Sep 2024 19:42:57 +0800 (CST)
Feedback-ID: t:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz7a-0

T3VyIHRlYW0gcmVjZW50bHkgZGV2ZWxvcGVkIGEgdnVsbmVyYWJpbGl0eSBkZXRlY3Rpb24g
dG9vbCwgYW5kIHdlIGhhdmUgZW1wbG95ZWQgaXQgdG8gc2NhbiB0aGUgTGludXggS2VybmVs
ICh2ZXJzaW9uIDYuOS42KS4gQWZ0ZXIgbWFudWFsIHJldmlldywgd2UgZm91bmQgc29tZSBw
b3RlbnRpYWxseSB2dWxuZXJhYmxlIGNvZGUgc25pcHBldHMgd2hpY2ggbWF5IGhhdmUgdXNl
LWFmdGVyLWZyZWUgYnVncyBkdWUgdG8gcmFjZSBjb25kaXRpb25zLiBUaGVyZWZvcmUsIHdl
IHdvdWxkIGFwcHJlY2lhdGUgeW91ciBleHBlcnQgaW5zaWdodCB0byBjb25maXJtIHdoZXRo
ZXIgdGhlc2UgdnVsbmVyYWJpbGl0aWVzIGNvdWxkIGluZGVlZCBwb3NlIGEgcmlzayB0byB0
aGUgc3lzdGVtLg0KDQpWdWxuZXJhYmlsaXR5IERlc2NyaXB0aW9uOg0KDQpGaWxlOiAvZHJp
dmVycy9uZXQvZXRoZXJuZXQvc2VlcS9ldGhlcjMuYw0KDQpJbiB0aGUgZXRoZXIzX3Byb2Jl
IGZ1bmN0aW9uLCBhIHRpbWVyIGlzIGluaXRpYWxpemVkIHdpdGggYSBjYWxsYmFjayBmdW5j
dGlvbiBldGhlcjNfbGVkb2ZmLCBib3VuZCB0byAmcHJldihkZXYpLT50aW1lci4gT25jZSB0
aGUgdGltZXIgaXMgc3RhcnRlZCwgdGhlcmUgaXMgYSByaXNrIG9mIGEgcmFjZSBjb25kaXRp
b24gaWYgdGhlIG1vZHVsZSBvciBkZXZpY2UgaXMgcmVtb3ZlZCwgdHJpZ2dlcmluZyB0aGUg
ZXRoZXIzX3JlbW92ZSBmdW5jdGlvbiB0byBwZXJmb3JtIGNsZWFudXAuIFRoZSBzZXF1ZW5j
ZSBvZiBvcGVyYXRpb25zIHRoYXQgbWF5IGxlYWQgdG8gYSBVQUYgYnVnIGlzIGFzIGZvbGxv
d3M6DQoNCkNQVTAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQ1BVMQ0KDQogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIGV0aGVyM19sZWRvZmYNCmV0aGVyM19yZW1vdmUg
ICAgICAgICAgICAgICB8DQogICAgZnJlZV9uZXRkZXYoZGV2KTsgICAgICAgfA0KICAgIHB1
dF9kZXZpY2UgICAgICAgICAgICAgIHwNCiAgICBrZnJlZShkZXYpOyAgICAgICAgICAgICB8
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICBldGhlcjNfb3V0dyhwcml2
KGRldiktPnJlZ3MuY29uZmlnMiB8PSBDRkcyX0NUUkxPLCBSRUdfQ09ORklHMik7DQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAvLyB1c2UgZGV2DQoNClByb3Bvc2Vk
IEZpeDoNCg0KVGhlIGlzc3VlIGNhbiBiZSByZXNvbHZlZCBieSBlbnN1cmluZyB0aGF0IHRo
ZSB0aW1lciBpcyBjYW5jZWxlZCBiZWZvcmUgcHJvY2VlZGluZyB3aXRoIHRoZSBjbGVhbnVw
IGluIGV0aGVyM19yZW1vdmUgb3IgZXRoZXIzX2Nsb3NlLiBUaGlzIHdpbGwgcHJldmVudCBh
bnkgcGVuZGluZyBvciBhY3RpdmUgdGltZXIgZnVuY3Rpb25zIGZyb20gYWNjZXNzaW5nIG1l
bW9yeSB0aGF0IGhhcyBhbHJlYWR5IGJlZW4gZnJlZWQuDQoNClJlbGV2YW50IENWRSBhbmQg
UmVmZXJlbmNlOg0KDQpUaGlzIGlzc3VlIGlzIHNpbWlsYXIgdG8gdGhlIHZ1bG5lcmFiaWxp
dHkgZG9jdW1lbnRlZCBpbiBDVkUtMjAyMy0zMTQxLCBhbmQgYSByZWxhdGVkIGZpeCB3YXMg
aW1wbGVtZW50ZWQgYXMgc2hvd24gaW4gdGhlIGZvbGxvd2luZyBjb21taXQ6DQoNCm1lbXN0
aWNrOiByNTkyOiBGaXggVUFGIGJ1ZyBpbiByNTkyX3JlbW92ZSBkdWUgdG8gcmFjZSBjb25k
aXRpb24gKGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPTYzMjY0NDIyNzg1MDIxNzA0YzM5YjM4
ZjY1YTc4YWI5ZTRhMTg2ZDcpDQoNClJlcXVlc3QgZm9yIFJldmlldzoNCg0KV2Ugd291bGQg
YXBwcmVjaWF0ZSB5b3VyIGV4cGVydCBpbnNpZ2h0IHRvIGNvbmZpcm0gd2hldGhlciB0aGlz
IHZ1bG5lcmFiaWxpdHkgaW5kZWVkIHBvc2VzIGEgcmlzayB0byB0aGUgc3lzdGVtIGFuZCBp
ZiB0aGUgcHJvcG9zZWQgZml4IGlzIGFwcHJvcHJpYXRlLg0KDQpUaGFuayB5b3UgZm9yIHlv
dXIgdGltZSBhbmQgY29uc2lkZXJhdGlvbi4NCg0KQmVzdCByZWdhcmRzLA0KV2VudGFpIERl
bmcNCnd0ZGVuZzI0QG0uZnVkYW4uZWR1LmNu


