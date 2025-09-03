Return-Path: <netdev+bounces-219552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C7FB41E26
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 14:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B531694D1
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 12:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492682E6CC3;
	Wed,  3 Sep 2025 12:01:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C282EC555;
	Wed,  3 Sep 2025 12:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900868; cv=none; b=ndGqkIfpio5lRZuseVU+fZKrKAOiGipeU6qfhdYTxtF7Yk1hFw6XGQQ70TBnKWUwoYcW0cWJerNZ/vi7x/U1MJV3mLBGTPml03bHEA1F7PD5LgOYUoFZP/l27tIFpDQ+xPAwrTAj5poCrxzd5C66+kS1q+tP5Pvn6+Uhi6JZSLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900868; c=relaxed/simple;
	bh=Fbn6GppGy8yBxgfUd1MDljuMgmJusjReJOu+jY8SeA4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=erqDWVmNEtl41L4WbhfExT8tzZAjH+YTgMt5hFN/vTGlrpyJ4U41cWTbwWGjwYr4XxS7rgk7J9GxTwaln+IHpwQ3TwWcSuXCGqmYSThEECz2/SvjY03cKkfHQquwlkcjZVkInmo8Fe0BB/AFva9Cum/jfMsXs3TSZdfI/z6iWYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201614.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202509032000566242;
        Wed, 03 Sep 2025 20:00:56 +0800
Received: from Jtjnmail201618.home.langchao.com (10.100.2.18) by
 Jtjnmail201614.home.langchao.com (10.100.2.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Wed, 3 Sep 2025 20:00:57 +0800
Received: from Jtjnmail201618.home.langchao.com ([fe80::e8a5:9069:4c1e:2304])
 by Jtjnmail201618.home.langchao.com ([fe80::e8a5:9069:4c1e:2304%10]) with
 mapi id 15.01.2507.057; Wed, 3 Sep 2025 20:00:57 +0800
From: =?utf-8?B?R2FyeSBDaHUo5qWa5YWJ5bqGKQ==?= <chuguangqing@inspur.com>
To: "Markus.Elfring@web.de" <Markus.Elfring@web.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "antonio@openvpn.net"
	<antonio@openvpn.net>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"sd@queasysnail.net" <sd@queasysnail.net>, "horms@kernel.org"
	<horms@kernel.org>
Subject: Re: [PATCH v2 1/1] ovpn: use kmalloc_array() for array space
 allocation
Thread-Topic: [PATCH v2 1/1] ovpn: use kmalloc_array() for array space
 allocation
Thread-Index: AdwcyN3LkBtHNNPAvE+aVgfnozl3SA==
Date: Wed, 3 Sep 2025 12:00:57 +0000
Message-ID: <154e91e453c44817abbea33a7fb72e32@inspur.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_0066_01DC1D0D.7594F930"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
tUid: 20259032000564b70b01accfe526d474de3e659ea2449
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

------=_NextPart_000_0066_01DC1D0D.7594F930
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus=EF=BC=8C
	First of all, thank you for your reminder. According to your =
suggestion, the format "Chu Guangqing" should be used. However, in line =
with our company's signature conventions and my previous contributions =
to the kernel community, I have been using "chuguangqing". Therefore, I =
have to continue using this signature. The signature should not be =
changed frequently.

>=20
> > Signed-off-by: chuguangqing <chuguangqing@inspur.com>
>=20
> Would the personal name usually deviate a bit from the email =
identifier
> according to the Developer's Certificate of Origin?
> =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocume
> ntation/process/submitting-patches.rst?h=3Dv6.17-rc4#n436
>=20
> Regards,
> Markus

Best regards,
Chu Guangqing
<chuguangqing@inspur.com>

------=_NextPart_000_0066_01DC1D0D.7594F930
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
SIb3DQMHMB0GA1UdDgQWBBQRC/IegXfBTn5cZmp9COa0bolxUDAfBgNVHSMEGDAWgBReWQOmtExY
YJFO9h61pTmmMsE1ajCCAQ8GA1UdHwSCAQYwggECMIH/oIH8oIH5hoG6bGRhcDovLy9DTj1JTlNQ
VVItQ0EsQ049SlRDQTIwMTIsQ049Q0RQLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNl
cnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9aG9tZSxEQz1sYW5nY2hhbyxEQz1jb20/Y2VydGlm
aWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50
hjpodHRwOi8vSlRDQTIwMTIuaG9tZS5sYW5nY2hhby5jb20vQ2VydEVucm9sbC9JTlNQVVItQ0Eu
Y3JsMIIBLAYIKwYBBQUHAQEEggEeMIIBGjCBsQYIKwYBBQUHMAKGgaRsZGFwOi8vL0NOPUlOU1BV
Ui1DQSxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29u
ZmlndXJhdGlvbixEQz1ob21lLERDPWxhbmdjaGFvLERDPWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/
b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTBkBggrBgEFBQcwAoZYaHR0cDovL0pU
Q0EyMDEyLmhvbWUubGFuZ2NoYW8uY29tL0NlcnRFbnJvbGwvSlRDQTIwMTIuaG9tZS5sYW5nY2hh
by5jb21fSU5TUFVSLUNBKDEpLmNydDApBgNVHSUEIjAgBggrBgEFBQcDAgYIKwYBBQUHAwQGCisG
AQQBgjcKAwQwNQYJKwYBBAGCNxUKBCgwJjAKBggrBgEFBQcDAjAKBggrBgEFBQcDBDAMBgorBgEE
AYI3CgMEMEsGA1UdEQREMEKgJwYKKwYBBAGCNxQCA6AZDBdjaHVndWFuZ3FpbmdAaW5zcHVyLmNv
bYEXY2h1Z3VhbmdxaW5nQGluc3B1ci5jb20wUAYJKwYBBAGCNxkCBEMwQaA/BgorBgEEAYI3GQIB
oDEEL1MtMS01LTIxLTE2MDY5ODA4NDgtNzA2Njk5ODI2LTE4MDE2NzQ1MzEtNTYwNDA2MA0GCSqG
SIb3DQEBCwUAA4IBAQBDRhwc9Cfe5n65yxddOeEDQbNITPIjt/Q+Mf0KqzH+d4IcHt7HNA8ZhrOp
YQJiFgjJY9eOo4+lABBfQTWVK3MrIiBTzf1MB8MRXnLKR1+FhZkDj+NRQdKDV6L1rcO+RsCJrLM2
1MGkhqFlpXCHxlyPt+T18YSXSD0ceJ5QpQ3A+/N2p+OTxezHL5GqPSJT051H43ikZC5xCpZMWafu
B0GyyrLlvvzet4Ko76Y4jWDL61EEakexUR9RgPcPhYFHiNf9f3wi3fc1AW0J1smh+3rm9INI+6Xx
/g6gEHmIeBWZfODTrhP6FGMlMMJlLQoSAZbPBadhUnssKKTWgy5rT4qUMYIDkzCCA48CAQEwcDBZ
MRMwEQYKCZImiZPyLGQBGRYDY29tMRgwFgYKCZImiZPyLGQBGRYIbGFuZ2NoYW8xFDASBgoJkiaJ
k/IsZAEZFgRob21lMRIwEAYDVQQDEwlJTlNQVVItQ0ECE34AAkSWdsZNK1EPE5IAAQACRJYwCQYF
Kw4DAhoFAKCCAfgwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
OTAzMTIwMDU1WjAjBgkqhkiG9w0BCQQxFgQUcqQTxZhBRxH0Xkr+ocWsTEVB1GUwfwYJKwYBBAGC
NxAEMXIwcDBZMRMwEQYKCZImiZPyLGQBGRYDY29tMRgwFgYKCZImiZPyLGQBGRYIbGFuZ2NoYW8x
FDASBgoJkiaJk/IsZAEZFgRob21lMRIwEAYDVQQDEwlJTlNQVVItQ0ECE34AAkSWdsZNK1EPE5IA
AQACRJYwgYEGCyqGSIb3DQEJEAILMXKgcDBZMRMwEQYKCZImiZPyLGQBGRYDY29tMRgwFgYKCZIm
iZPyLGQBGRYIbGFuZ2NoYW8xFDASBgoJkiaJk/IsZAEZFgRob21lMRIwEAYDVQQDEwlJTlNQVVIt
Q0ECE34AAkSWdsZNK1EPE5IAAQACRJYwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYI
KoZIhvcNAwICAUAwBwYFKw4DAhowCwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQCAjALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAM163rdy7QBY4QcH0d+34+Z9/fzNWk+W5FANHajOiJeOBrVaR
tqlb680R7zzdNNNTeI3mXDl1voygUwBFV376V215LSbLwBBqRfOgt6zCZVn/ucr8iwAq8blxcii/
0k5czP8ueJj32Oab+aMS2B2EBSxMHdjGhPEOi2Lbjhlu3uutXe65bZiBoP3cExs7vSgP6BbfPEgR
9xot28ZEtX7lLpJG0hXE1GC6oRJM2ayRTC8E+O7C2wIufPKbkMVLswGwVn7FfvfVFxgfrpDJIbCl
DLobtdXbQUC2iyJ5D258HNC+/El8xfKcyzcS3+x2GRvQSGLvg4hO7jtvlE4RfW8HWgAAAAAAAA==

------=_NextPart_000_0066_01DC1D0D.7594F930--

