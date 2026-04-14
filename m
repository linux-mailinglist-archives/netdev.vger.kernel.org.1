Return-Path: <netdev+bounces-278588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBUoBaHM3mnnIQAAu9opvQ
	(envelope-from <netdev+bounces-278588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 01:24:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC003FF051
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 01:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DCB930103BE
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 23:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BEC39903C;
	Tue, 14 Apr 2026 23:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.com header.i=benoit.dufour@mail.com header.b="GBnZd59U"
X-Original-To: netdev@vger.kernel.org
Received: from mout.mail.com (mout.mail.com [74.208.4.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5125338837A
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 23:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776209003; cv=none; b=tvMErMYzk7iUlMiAr8VallLF8W+rYScgLZ9YkrEBeerFdpEy2EtxxGpMZPacuYLhF7YnyVIb65JG2Es4K/Lu3bjlFtQbesQbZFTSJnS9u5dVk0mM12cYc6AMOyvaP0P4T2HKVH9iAB/xSD3UpVFuc3GMBwR329ZymNbLpHx2k4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776209003; c=relaxed/simple;
	bh=UbqQFmCeQ8Rs7hB+/3U3rGOvMUxGuc0SbNVE1r182l4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=MkChAGjtjmXrQeIjvnSvWPyGCQpLf/JrEKzkgVDhSMEABFK3L2/CgbyMDAyCmA7FwT2wnEUlF0XtOTyY/ctgxskFAAfUpAeQtHlMO9nAkKBJB06VT6oW9WJTXGYg7yt9eRZtgrMzHKbpjtm/WADpOzaOdk8SYidP87RLsAPOuI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.com; spf=pass smtp.mailfrom=mail.com; dkim=pass (2048-bit key) header.d=mail.com header.i=benoit.dufour@mail.com header.b=GBnZd59U; arc=none smtp.client-ip=74.208.4.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.com;
	s=s1089575; t=1776209000; x=1776813800; i=benoit.dufour@mail.com;
	bh=L7lUIckYV6t/9SxcMAOtP4Cdtnf7mS4kLRhABh8xT+4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=GBnZd59U4S7I0rbf0QiICiFDJfUrrv+DhA5rA3YZ+J33m+xxvCTEWXauKRasezAi
	 sPsYUXwTS2a/dZ9pgy3Yjid6INdzBKylb1g65Gi8e1O1ojx635Egtadnf9aaqJZgN
	 MB45i0Dm7o9P7xQYFiYc0s27xTMCGebXgSfTrwRS0qp1b8OOPWdaIeq4uDIwl86XF
	 RBYxqk8REwz28aSALrdt+vzW5iY6Zm7XXm2WMVNRscJQyMWOTbwD2/lBBiLzR9gya
	 jhq88nsZ2/MCbHd6OrlrPkZJfn5TJNpCUNivqVyMGNY8p1G0AEQbh4Mdy4HvnSnNX
	 VagsekMeihtDfqikDg==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from client.hidden.invalid by smtp.mail.com (mrgmxus004
 [74.208.5.15]) with ESMTPSA (Nemesis) id 0LonEb-1vWarT1Icd-00nbSW; Wed, 15
 Apr 2026 01:23:20 +0200
Message-ID: <9df653d6-d7f8-4b36-87de-65daf28635dd@mail.com>
Date: Tue, 14 Apr 2026 19:23:17 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
From: =?UTF-8?Q?Beno=C3=AEt_Dufour?= <benoit.dufour@mail.com>
Subject: DMA issues with the SKGE drivers
Autocrypt: addr=benoit.dufour@mail.com; keydata=
 xsFNBGmlBagBEADC+mB+ljUVdIPDgU+cNqVliKXYGkqiXmQ2xGO5RtCakbUidnPGTxbnC5Zk
 vgZMzwdRj7j2sFyf5H9Bpk64566QIiH1wK39l47gtPI8ykgOkfWQbWVhSg4H60taN99Q3UAx
 StUEVBIvXCJykouIPKkvl9ngmgqEwkY+yYmRV1l55QN4bcH9E/3x9YPANF8CMy8nXE8pkkoh
 JKRC4nMyKuijzgxUPLlwp9DoMdJodS4dC2Fwzwi9ey/WU6+k35xxk1jcQvOQul+Z4wXWEqkv
 krNw1rTLxi6o8T5GsxGFDB5gcWUZ/wyM2om4IVHvmxQRVXlfMG8za+q9HaG8FwwZ6DEd90CA
 8JUX3ssc+pZiWqQZyoa4MoouxTf9Krj4G1RIf5dzNGlp8R1ubE33Pdu7ahmpErf/mhiVCFLX
 hxrNwQ3aTK6k2ecMpJ+RlbbppnlgPxNiMfbkwcI6QI1PdYCzZ6wdI+PCEz4DNPFp4Ve1A2aR
 8aZ9Pg7+N1RrhYnWlvUHTRcCy4aCsg+aJ8/y/GRlXOsHbyp1+4sJURvJhET8R2AqoYCcYuNa
 kS4wPj67lOTmkRgnHjscH3rsoWpHARZNIdECqHN0Uw669eWHirUdqdmvd7oclgcqdVlHiATi
 ijhE3BX+2UpsRNez0vhfWGCQFByNkEb0D1Dq5b3o4XfwGEoDNwARAQABzUhCZW5vw650IER1
 Zm91ciAoYmVub2l0LmR1Zm91ckBtYWlsLmNvbSAtIEVNQUlMKSA8YmVub2l0LmR1Zm91ckBt
 YWlsLmNvbT7Cwa0EEwEIAFcWIQRhNxuBW225fNbJOW2m5JTP9taF7wUCaaUFqBsUgAAAAAAE
 AA5tYW51MiwyLjUrMS4xMSwyLDICGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 puSUz/bWhe9Ewg/8CXuOHT/uYZwMBKR2GQHInuK+kQZ0qHEc+tMnNAM3x8w1B6+htQfnpCb1
 1O4KMyHrPAujT2hPaGScqXZqsG2/1xpyk0u56bEes1XR08M8JIrl+S2kx+rkcGSIG3UrPEW7
 vXa7bWczaGXLxf92djtdXeT38hNCFxP6v49IqEhwQePf5nFNhDO2IxsJcsB51MX8vWCnW53M
 ShAGOOV7YwFUN0BdpfnTFVy1XaLddbzuq0h3Eww243QLMCKMY3ZB4NdNm5ZcH88bf42RHsvD
 pX/uSn/Y4H6rQ64I3PaoiTlUJYHhxIAXMCAB8tUW8xTjLqN2IjuH5Ab/UDVHEh1TTcbVOtrn
 lv4xlUqcpzHcT9ZEA1nATsRa87nAuOKMdAoE4eC6Il/8iIDrd0QTYtvAQbF4AGetMK+yyJLh
 68ErIFBWKlhX0K/SjVzFnE6cTaGlMFm9uImX4RYMLcYDegc/KoTPq6w3/I6bdRx+9J7vMFtf
 whL8jj7SXDZzpKon00xlsT5muXWqmb05P06XBZ+gKG0EiPSOwX9zE9lQ4lIL3fZjmBQ8YOqw
 u8KFfJt8l6Ronz6dPr319IAAFZFAptNePPKc538C8HgmvJCbe0FiBuJSAXQvtjp2ykmQqc3P
 Re0swVC7kzu7IEdh63e2tZbxy71wIGRQI3rwhV/8YYZhzbSfbtrOwU0EaaUFqAEQALRPVBuM
 e+jQyEn/erc2s01VwLK6JrqVs2lt+18n5saATOiEmjHZPCM49qQNLWYnmCRt1M0ML15Npnii
 OIdulr+MEB0L4BKXsrPkCcQpwccCLU0n39kFdNKw+OI4elgkZ8qW3DVyIMXAMahysQUN3XwW
 q2mzM7LgSIJQGxeFILvMBXSA9AZQqY7dWBEEpl7DcP/PMels2PLUhzxKgA1BRlnHHeqSF1Re
 8NFEp4UAkX++nUl6cfdgl/rLgyDv9BekOBkkEWTPm0XrN69IhTDPDOLNxM0etKCoI5gEMBSi
 xg5sHsQlJn0yudKlUUE6qbI6BGe+PyOZcZsRRiWI8OoW/Mo0CiQlkzCNxYcpDxntfni2JiOP
 P8aVH6Rz1VrdNslrqLDG7uFCW5GaXygQp962RfG4rLPooqPcIDg7qfLfwGshFGMAs3HppudE
 MVJlxcvcJ9JZW6BhTreH4m5CquAZvtjU+HBLECE26hSZblmg4y2V4nIEuqMcvQAFTrYZL9RG
 ABodPzJRlKCZmoxN36ZtO1Btox7SlPArfMl7WwarU+ZZzBD9C21seSEYnxAYzDNaClzknGyo
 JyL1yBWYN1yyH454bwF0JY8pg+iwR687iLc9hGHpq2wTUnBZTKl73RqQlFXI0kCgapL6gauv
 CDwQRgG1v5b9YToN9YnLHeUc2Cs9ABEBAAHCwZIEGAEIADwWIQRhNxuBW225fNbJOW2m5JTP
 9taF7wUCaaUFqBsUgAAAAAAEAA5tYW51MiwyLjUrMS4xMSwyLDICGwwACgkQpuSUz/bWhe/o
 UxAAssz1tod2gTB7NjqlMkuUsKvWQqDxitRDEeSc764HFkAVnufMZ/BSfjQOFMjCCJ07Sqyp
 qyX9Qf8Y4tcUCj/FebVoSKS9KoUIW2nmI+bHxlOXWBRVGc/7tSKT+Dmq09IW7911J/xwYZmO
 vbwI0J3L+Z+0qzTuZv1fblEk1BH5Z9l7H7ukeWgXpTf8RsJY02p9jjtoKewDqg3QXhDbh5DA
 DtS5eX/YzOfGxkB2pCJvpyK91+Bkq0GU18njIV8rUpa0+3Sk4P+pYCCD3qeCk9oEcYiDyASU
 eeDDLQaoxktCbEdyFPMNjF8t3QObTsWMf4jVNDAvwLysOjXe2RCwhyijFrrE1DGUh64+iklD
 rZ2L7kst/Jt1E/xD6v4dd41odsT+p95K3mDObVuRnAFKw1SyBRQFSWW3YukLH5lrBhoL+rjm
 N4bMOwRD1Q/m5FFbT0OYtXalDtPmSrtSWOWeVrD6RcWRT8nwZT8POXk2par0Wezhe+BtnJ7F
 RThMvDYOYDTKKf805jSAM6B8c851w9TeU3UWbhb19PuFpz/wZ2L6Gk/hLCHLoVaxASOGE/e2
 /0AzlnBldo0Q4dX/eq71lWvnh2T4Sj1yNOcLBd5oDqnk+VM3SoYabPTosqNPYTyGt4QNdfln
 9+VMTFFmtZldddzyju2amRgGS9sW0eEMfseKnXs=
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------FJEhWjyj5wqSzuLfAP7FpnAa"
X-Provags-ID: V03:K1:FXtgKwMeCA/GHHttic07b1xEKjqQC/1ktxLFsPlHPl7qUAOAsna
 TXfgB8zpM1W4qgu7hpO3FlmZnboTanf52yED5cfEEufQwejULdP5wmMps8B9hoVPEeQoAjh
 8vWjXKauF1anUam+VZMFs89oi2SfcUbqdPLIHyCr/RW7QKB+r/SfCqkjBkjWMbwLIliKv6r
 8TahqQtbytdwznYr2Ztwg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SXVYy/VXut8=;Cr+TsO5wl3/O0PCRDVaUdckha5j
 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
X-Spamd-Result: default: False [-3.50 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[mail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mail.com:s=s1089575];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,multipart/alternative,text/plain];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278588-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mail.com:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:+,5:~,6:~,7:~];
	RCPT_COUNT_ONE(0.00)[1];
	HAS_ATTACHMENT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benoit.dufour@mail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[mail.com];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 7FC003FF051
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------FJEhWjyj5wqSzuLfAP7FpnAa
Content-Type: multipart/mixed; boundary="------------wECZ30CwuJ5zLSzUKH0i6F1k";
 protected-headers="v1"
From: =?UTF-8?Q?Beno=C3=AEt_Dufour?= <benoit.dufour@mail.com>
To: netdev@vger.kernel.org
Message-ID: <9df653d6-d7f8-4b36-87de-65daf28635dd@mail.com>
Subject: DMA issues with the SKGE drivers

--------------wECZ30CwuJ5zLSzUKH0i6F1k
Content-Type: multipart/mixed; boundary="------------b752zhTF9d6OrjjpRj2Wy07f"

--------------b752zhTF9d6OrjjpRj2Wy07f
Content-Type: multipart/alternative;
 boundary="------------Lzq0UiGzhbU3nEeJmbKBCQuc"

--------------Lzq0UiGzhbU3nEeJmbKBCQuc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SW4gMjAyNCwgSSByZXBvcnRlZCBhIGJ1ZyBhYm91dCB0aGUgU0tHRSBkcml2ZXIsIHlvdSBj
YW4gc2VlIGl0IGhlcmU6DQpodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcu
Y2dpP2lkPTIxOTI3MA0KDQpCYXNpY2FsbHksIHRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlIE1h
cnZlbGwgODhFODAwMSBvbiBteSBBU1VTIEE4ViANCm1vdGhlcmJvYXJkIGNhbiBvbmx5IHdv
cmsgd2l0aCAzMmJpdCBETUEsIGFuZCBpZiB0cnlpbmcgdG8gdXNlIDY0Yml0IA0KRE1BLCB0
aGUgTklDIHdvbid0IHdvcmsgYXQgYWxsIGFuZCBhZnRlciBzb21lIHRpbWUsIHRoZSBvcGVy
YXRpbmcgc3lzdGVtIA0Kd2lsbCBiZWNvbWUgY29tcGxldGVseSB1bnJlc3BvbnNpdmUgKG9u
IHNjcmVlbiB0dHkgd2lsbCBzdG9wIHJlZnJlc2gsIA0Ka2V5Ym9hcmQgYW5kIG1vdXNlIGlu
cHV0IHdpbGwgc3RvcCB3b3JraW5nIHRvbykuDQoNClRoZSBmaXggaXMgcXVpdGUgZWFzeToN
Cg0KQXQgdGhlIHZlcnkgZW5kIG9mIHRoZSBTS0dFIGRyaXZlciBzb3VyY2UgY29kZSwgdGhl
IEFTVVMgQThWIG1vdGhlcmJvYXJkIA0KKGFzIHdlbGwgYXMgbWFueSBvdGhlciBib2FyZHMg
bGlrZSB0aGUgQVNVUyBBOFYgRGVsdXhlKSBzaG91bGQgYmUgYWRkZWQgDQp0byB0aGUgbGlz
dCBvZiAzMmJpdCBETUEgYm9hcmRzOg0KaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xp
bnV4L2Jsb2IvNTA4ZmVkNjc5NTQxMWY1YWIyNzdmZDFlZGMwZDdhZGNhNDk0NmYyMy9kcml2
ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL3NrZ2UuYyNMNDE1MA0KDQpJbiB0aGUgYnVnIHJl
cG9ydCBJIHBvc3RlZCBpbiAyMDI0LCBJIGFsc28gcG9zdGVkIGEgdGVzdCBjYXNlOg0KaHR0
cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL2F0dGFjaG1lbnQuY2dpP2lkPTMwNjg3MyZhY3Rp
b249ZGlmZg0KDQpidXQgYWN0dWFsbHkgSSBndWVzcyBhIGJldHRlciBmaXggd291bGQgYmUg
dG8gZHluYW1pY2FsbHkgdGVzdGluZyBpZiB0aGUgDQpOSUMgc3VwcG9ydCBvbmx5IDMyYml0
IG9yIDY0Yml0IERNQSB0b28uIElmIDY0Yml0IHdvdWxkbid0IGJlIHN1cHBvcnRlZCwgDQp0
aGlzIGVycm9yIChvciBhIHNpbWlsYXIgb25lKSBzaG91bGQgYmUgcmVwb3J0ZWQgYnkgdGhl
IGNhcmQ6DQpQQ0kgZXJyb3IgY21kPTB4MTE3IHN0YXR1cz0weDIyYjANCg0KRG8geW91IHRo
aW5rIGl0IHdvdWxkIGJlIGRvYWJsZT8NCg0KcC5zLjoNCkkga25vdyB0aGF0IE5JQyBhbmQg
dGhvc2UgbW90aGVyYm9hcmRzIGFyZSB2ZXJ5IG9sZCwgYnV0IEkgcmVhbGx5IHdpc2ggDQp0
aG9zZSBraW5kcyBvZiBidWdzIHNob3VsZCBiZSBmaXhlZCBhdCBzb21lIHBvaW50Lg0KDQot
LSANCkJlbm/DrnQgRHVmb3VyDQoNClVuZm9ydHVuYXRlbHkgc3RpbGwgYSBzdHVkZW50IGlu
IENvbXB1dGVyIFNjaWVuY2UNCg0K
--------------Lzq0UiGzhbU3nEeJmbKBCQuc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html data-lt-installed=3D"true">
  <head>

    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body style=3D"padding-bottom: 1px;">
    <p>In 2024, I reported a bug about the SKGE driver, you can see it
      here:<br>
      <a class=3D"moz-txt-link-freetext" href=3D"https://bugzilla.kernel.=
org/show_bug.cgi?id=3D219270">https://bugzilla.kernel.org/show_bug.cgi?id=
=3D219270</a><br>
    </p>
    <p>Basically, the problem is that the Marvell 88E8001 on my ASUS A8V
      motherboard can only work with 32bit DMA, and if trying to use
      64bit DMA, the NIC won't work at all and after some time, the
      operating system will become completely unresponsive (on screen
      tty will stop refresh, keyboard and mouse input will stop working
      too).</p>
    <p>The fix is quite easy:<br>
      <br>
      At the very end of the SKGE driver source code, the ASUS A8V
      motherboard (as well as many other boards like the ASUS A8V
      Deluxe) should be added to the list of 32bit DMA boards:<br>
<a class=3D"moz-txt-link-freetext" href=3D"https://github.com/torvalds/li=
nux/blob/508fed6795411f5ab277fd1edc0d7adca4946f23/drivers/net/ethernet/ma=
rvell/skge.c#L4150">https://github.com/torvalds/linux/blob/508fed6795411f=
5ab277fd1edc0d7adca4946f23/drivers/net/ethernet/marvell/skge.c#L4150</a><=
br>
      <br>
      In the bug report I posted in 2024, I also posted a test case:<br>
<a class=3D"moz-txt-link-freetext" href=3D"https://bugzilla.kernel.org/at=
tachment.cgi?id=3D306873&amp;action=3Ddiff">https://bugzilla.kernel.org/a=
ttachment.cgi?id=3D306873&amp;action=3Ddiff</a><br>
      <br>
      but actually I guess a better fix would be to dynamically testing
      if the NIC support only 32bit or 64bit DMA too. If 64bit wouldn't
      be supported, this error (or a similar one) should be reported by
      the card:<br>
      PCI error cmd=3D0x117 status=3D0x22b0<br>
      <br>
      Do you think it would be doable?<br>
      <br>
      p.s.:<br>
      I know that NIC and those motherboards are very old, but I really
      wish those kinds of bugs should be fixed at some point.</p>
    <pre class=3D"moz-signature" cols=3D"72">--=20
Beno=C3=AEt Dufour

Unfortunately still a student in Computer Science</pre>
    <div id=3D"grammalecte_menu_main_button_shadow_host"
      style=3D"width: 0px; height: 0px;"></div>
  </body>
  <lt-container></lt-container>
</html>

--------------Lzq0UiGzhbU3nEeJmbKBCQuc--

--------------b752zhTF9d6OrjjpRj2Wy07f
Content-Type: application/pgp-keys; name="OpenPGP_0xA6E494CFF6D685EF.asc"
Content-Disposition: attachment; filename="OpenPGP_0xA6E494CFF6D685EF.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3Dd8Sn
-----END PGP PUBLIC KEY BLOCK-----

--------------b752zhTF9d6OrjjpRj2Wy07f--

--------------wECZ30CwuJ5zLSzUKH0i6F1k--

--------------FJEhWjyj5wqSzuLfAP7FpnAa
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEYTcbgVttuXzWyTltpuSUz/bWhe8FAmnezGUFAwAAAAAACgkQpuSUz/bWhe/M
UxAAklDEc+CzB7+gjgCLU2gaLXSyb2BvcbctNwH4KqAV5pqBCi1qtNyDY1T5+mPrYfqqRQYBbtN1
cpIv5rKgo3s/DhZfrEYhQ4Xji+xQncsYVw1/YjAxwOadJCrzSJTEOHoGnxOcWdjvDrVOVK7XyTRv
XsvRfMBkMbtjTzr6Zhv+BSE8DbHztucbTFbi74EyWI0m5cgCjQVAADHD29B57QUBw2tCOhNc0JPR
WRQwKHb8e74T+9CrhGv5HrlBqYufVv+LKwXkB4LwwL+gkjqoyv/+JnoNrYAvtcWx1O0AGjtBTKcr
jt7dXS2SQl5PeHHwvl9dU3h9wqVBaZARj+6P3cWNsXjdu49xA2uhh67BKOkOZLT0m9eO0Hv5g8aa
/Z5Ws0E6yjcbE2yyyF+LNESy4TBIJODhdNmUifKWOMtGd+cBRTupncdAFOV1ERNIINZmrN0hHLp8
p8+uOjcLhamod/R47T5EWDGHdLK4bvLpkHfFVlmvAgKmAhrxEogGdfvLoHBCvCVIa1d57MCkATVI
/h4Ujn9FNXH9wY+SXKoBUBrcJsJa5JImmm1pho6Q4gFyeb5lDNFGJKRaNaiwGzBAk+quMpUbhyj2
04XJcfUCZJ2wm4k1NjUtUWHxbmAJIpYnb+I6aW2IfZUv/ZTp/RiG5ltpwfWJl/RQx2giB4Huoose
Gyw=
=+nny
-----END PGP SIGNATURE-----

--------------FJEhWjyj5wqSzuLfAP7FpnAa--

