Return-Path: <netdev+bounces-186372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8668AA9EAC4
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 10:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C97B9189C0AA
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 08:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA72125E800;
	Mon, 28 Apr 2025 08:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="D8FWCU0c"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83100153808
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745828940; cv=none; b=UaIDrq5ccjc4GCBfAhD1Q7qMON1K+Oo1FSOVG8qWfW3T5Jkgfx3T5onIfQqLEjyBq+RSEYdJMay075J+bdO+8s/0b3+Fmp8vF0Sp56d10lMz+zEPXeEnuhPKy7piXSFpB33NGXswJGRE7JvViPn4pPTSfwREKQQaIj25P6+q5fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745828940; c=relaxed/simple;
	bh=LA6YWk/FwxgJOnHO6SWjWLjgLu4FGGfD2LgNdRTvgF8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=VP1OOsbMzDNw3Eopv2r0pXhXeIm/4yw65UJAHC8Wh98hHkC43Vt9/wvyPnB4Jc2JG8TpsTHF5J3b2YI2OfXnbYod6+kNlL7azbZBYP0NRYt47etgv1cyVjPvXfwNEX3KWeskrT1w0dK7tpqy+NXMPs7i9/DVez5eHekqNi7jlqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=D8FWCU0c reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=febKnsQvUL31LL2nqJry0elpDgUwb0Ic6nsa3a9b+3U=; b=D
	8FWCU0cFIFVLk7zy9cSnyjcfuqFf0Y8PebxJLbKTm/WqNddUJwqTUDO7eQOrnExS
	JeTFueE5g7AM1NNklSAFt5b/biN9h2eNErvjczdDt2f3W7n26ehNUI1VzWncBpZF
	x1fbzztiX4IFKNG0YrOIbN29r9VqCY1l9fSWx+jw/k=
Received: from slark_xiao$163.com (
 [2408:8459:3811:ccaf:abaf:dcda:e5a9:4bdd] ) by ajax-webmail-wmsvr-40-111
 (Coremail) ; Mon, 28 Apr 2025 16:27:41 +0800 (CST)
Date: Mon, 28 Apr 2025 16:27:41 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Sergey Ryazanov" <ryazanov.s.a@gmail.com>
Cc: "Loic Poulain" <loic.poulain@oss.qualcomm.com>,
	"Johannes Berg" <johannes@sipsolutions.net>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>,
	"Eric Dumazet" <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>, netdev@vger.kernel.org,
	"Muhammad Nuzaihan" <zaihan@unrealasia.net>,
	"Qiang Yu" <quic_qianyu@quicinc.com>,
	"Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
	"Johan Hovold" <johan@kernel.org>
Subject: Re:Re:Re:[RFC PATCH 4/6] net: wwan: add NMEA port support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <E0D733BB-34CB-47A4-9871-D7F0B2B47DD7@gmail.com>
References: <20250408233118.21452-1-ryazanov.s.a@gmail.com>
 <20250408233118.21452-5-ryazanov.s.a@gmail.com>
 <2fb6c2fd.451c.19618afb36b.Coremail.slark_xiao@163.com>
 <16135e8d.86f9.19619ac8560.Coremail.slark_xiao@163.com>
 <E0D733BB-34CB-47A4-9871-D7F0B2B47DD7@gmail.com>
X-NTES-SC: AL_Qu2fB/SZt0At5yieY+kfmkkXg+c4XsW5vfwu1IVRPJp+jDjp2Cs/WG96DWHE8uOCEg+yuyGuWSJD9MZHf7N6RassZf/32DBBmYjh0pOvbYsKsQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7aed94ce.2dca.1967b8257af.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:bygvCgA3fzL9Ow9oVgKgAA--.10387W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiMA48ZGgORGw0sgADst
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjUtMDQtMDkgMTg6NDI6NTksICJTZXJnZXkgUnlhemFub3YiIDxyeWF6YW5vdi5zLmFA
Z21haWwuY29tPiB3cm90ZToKPk9uIEFwcmlsIDksIDIwMjUgMTE6MzA6NTggQU0gR01UKzAzOjAw
LCBTbGFyayBYaWFvIDxzbGFya194aWFvQDE2My5jb20+IHdyb3RlOgo+Pgo+PkhpIFNlcmdleSwK
Pj5EZXZpY2UgcG9ydCAvZGV2L2duc3MwIGlzIGVudW1lcmF0ZWQgLiBEb2VzIGl0IGJlIGV4cGVj
dGVkPwo+PkkgY2FuIGdldCB0aGUgTk1FQSBkYXRhIGZyb20gdGhpcyBwb3J0IGJ5IGNhdCBvciBt
aW5pY29tIGNvbW1hbmQuCj4+QnV0IHRoZSBncHNkLnNlcnZpY2UgYWxzbyBjYW4gbm90IGJlIGlu
aXRpYWxpemVkIG5vcm1hbGx5LiBJdCByZXBvcnRzOgo+Pgo+PlRyaWdnZXJlZEJ5OiCh8SBncHNk
LnNvY2tldAo+PiAgICBQcm9jZXNzOiAzODI0IEV4ZWNTdGFydFByZT0vYmluL3N0dHkgc3BlZWQg
MTE1MjAwIC1GICRERVZJQ0VTIChjb2RlPWV4aXRlZCwgc3RhdHVzPTEvRkFJTFVSRSkKPj4gICAg
ICAgIENQVTogN21zCj4+Cj4+NNTCIDA5IDE2OjA0OjE2IGpiZCBzeXN0ZW1kWzFdOiBTdGFydGlu
ZyBHUFMgKEdsb2JhbCBQb3NpdGlvbmluZyBTeXN0ZW0pIERhZW1vbi4uLgo+PjTUwiAwOSAxNjow
NDoxNyBqYmQgc3R0eVszODI0XTogL2Jpbi9zdHR5OiAvZGV2L2duc3MwOiBJbmFwcHJvcHJpYXRl
IGlvY3RsIGZvciBkZXZpY2UKPj401MIgMDkgMTY6MDQ6MTcgamJkIHN5c3RlbWRbMV06IGdwc2Qu
c2VydmljZTogQ29udHJvbCBwcm9jZXNzIGV4aXRlZCwgY29kZT1leGl0ZWQsIHN0YXR1cz0xL0ZB
SUxVUkUKPj401MIgMDkgMTY6MDQ6MTcgamJkIHN5c3RlbWRbMV06IGdwc2Quc2VydmljZTogRmFp
bGVkIHdpdGggcmVzdWx0ICdleGl0LWNvZGUnLgo+PjTUwiAwOSAxNjowNDoxNyBqYmQgc3lzdGVt
ZFsxXTogRmFpbGVkIHRvIHN0YXJ0IEdQUyAoR2xvYmFsIFBvc2l0aW9uaW5nIFN5c3RlbSkgRGFl
bW9uLgo+Pgo+PlNlZW1zIGl0J3Mgbm90IGEgc2VyaWFsIHBvcnQuCj4KPkl0IGlzIGEgY2hhciBk
ZXYgbGFja2luZyBzb21lIElPQ1RMcyBzdXBwb3J0LiBZZWFoLgo+Cj4+QW55IGFkdmljZT8KPgo+
WWVwLiBSZW1vdmUgdGhhdCBzdHR5IGludm9jYXRpb24gZnJvbSB0aGUgc2VydmljZSBkZWZpbml0
aW9uLiBGb3IgbWUsIGdwc2Qgd29ya3MgZmxhd2xlc3NseS4gWW91IGNhbiB0cnkgdG8gc3RhcnQg
aXQgbWFudWFsbHkgZnJvbSBhIHRlcm1pbmFsLgo+Cj4tLQo+U2VyZ2V5CkhpIFNlcmdleSwKTXkg
ZGV2aWNlIGNvdWxkIG91dHB1dCB0aGUgTk1FQSBkYXRhIGJ5IHBvcnQgL2Rldi9nbnNzMC4gU29t
ZXRoaW5nIGxpa2UgYmVsb3c6CgokR1BSTUMsMDcxNjM0LjAwLEEsMjIzOS4zNzIwNjcsTiwxMTQw
Mi42NTMwNDgsRSwsLDI4MDQyNSwsLEEsVioyRAokR0FSTUMsMDcxNjM0LjAwLEEsMjIzOS4zNzIw
NjcsTiwxMTQwMi42NTMwNDgsRSwsLDI4MDQyNSwsLEEsViozQwokR0JSTUMsMDcxNjM0LjAwLEEs
MjIzOS4zNzIwNjcsTiwxMTQwMi42NTMwNDgsRSwsLDI4MDQyNSwsLEEsViozRgokR05STUMsMDcx
NjM0LjAwLEEsMjIzOS4zNzIwNjcsTiwxMTQwMi42NTMwNDgsRSwsLDI4MDQyNSwsLEEsViozMwok
R05HTlMsMDcxNjM0LjAwLDIyMzkuMzcyMDY3LE4sMTE0MDIuNjUzMDQ4LEUsTkFBTk5OLDAyLDUw
MC4wLCwsLCxWKjE1CiRHUEdHQSwwNzE2MzQuMDAsMjIzOS4zNzIwNjcsTiwxMTQwMi42NTMwNDgs
RSwxLDAwLDUwMC4wLCwsLCwsKjU5CiRHQUdHQSwwNzE2MzQuMDAsMjIzOS4zNzIwNjcsTiwxMTQw
Mi42NTMwNDgsRSwxLDAxLDUwMC4wLCwsLCwsKjQ5CiRHQkdHQSwwNzE2MzQuMDAsMjIzOS4zNzIw
NjcsTiwxMTQwMi42NTMwNDgsRSwxLDAwLDUwMC4wLCwsLCwsKjRCCiRHTkdHQSwwNzE2MzQuMDAs
MjIzOS4zNzIwNjcsTiwxMTQwMi42NTMwNDgsRSwxLDAyLDUwMC4wLCwsLCwsKjQ1CiRHUEdTViw0
LDEsMTMsMDQsMDAsMDM4LCwwNSwzMywyNDAsLDA2LDQxLDAzMywsMDksMjUsMDU4LCwxKjZGCiRH
UEdTViw0LDIsMTMsMTEsNDcsMzQ0LCwxMiwzMywyODYsLDEzLDA5LDE4NSwsMTcsMjksMTI4LCwx
KjZFCiRHUEdTViw0LDMsMTMsMTksNTQsMTEzLCwyMCw2MiwyODQsLDIyLDE1LDE3NCwsMjUsMDks
MzExLCwxKjY4CiRHUEdTViw0LDQsMTMsNDAsMDAsMDAwLDI4LDEqNTgKJEdMR1NWLDMsMSwwOSwx
MCwxOSwyNDUsLDA2LDM4LDE4NSwsMDksMDYsMjAzLCwxMSwxMywyOTYsLDEqNzkKJEdMR1NWLDMs
MiwwOSwwNSw2MCwwNjQsLDIwLDM5LDAxMywsMTksMTcsMDg0LCwyMSwxNSwzMjEsLDEqN0UKJEdM
R1NWLDMsMywwOSwwNCwxNiwwMzAsLDEqNDEKJEdBR1NWLDMsMSwxMSwwMiwzMCwyOTcsLDA0LDMy
LDA3NiwsMDUsMTAsMTg4LCwwNiw0MSwxMDcsLDcqNzgKJEdBR1NWLDMsMiwxMSwwOSwzOSwxNDAs
LDEwLDI2LDA1NSwsMTEsNDIsMDI3LCwxMiwwOSwwNzEsLDcqN0UKJEdBR1NWLDMsMywxMSwxNiwz
NiwxOTgsLDI0LDE5LDE3NiwsMzYsMzksMzE3LCw3KjQ1CiRHQkdTViw0LDEsMTUsMDEsNDcsMTIy
LCwwMiw0NiwyMzQsLDAzLDYzLDE4OSwsMDQsMzQsMTA4LCwxKjdECiRHQkdTViw0LDIsMTUsMDUs
MjMsMjUzLCwwNiwwNCwxODcsLDA3LDg2LDE5NCwsMDgsNjgsMjg0LCwxKjc1CiRHQkdTViw0LDMs
MTUsMDksMDMsMjAxLCwxMCw3OCwyOTksLDExLDU2LDAyNSwsMTIsMjksMDk0LCwxKjcxCgpCdXQg
dGhlIGdwc2QgcHJvZ3Jlc3Mgd2VyZSBzdHVjayB3aXRoIGJlbG93IGVycm9yczoKofEgZ3BzZC5z
ZXJ2aWNlIC0gR1BTIChHbG9iYWwgUG9zaXRpb25pbmcgU3lzdGVtKSBEYWVtb24KICAgICBMb2Fk
ZWQ6IGxvYWRlZCAoL2xpYi9zeXN0ZW1kL3N5c3RlbS9ncHNkLnNlcnZpY2U7IGVuYWJsZWQ7IHZl
bmRvciBwcmVzZXQ6IGVuYWJsZWQpCiAgICAgQWN0aXZlOiBhY3RpdmUgKHJ1bm5pbmcpIHNpbmNl
IE1vbiAyMDI1LTA0LTI4IDIzOjE2OjQ3IENTVDsgMjBzIGFnbwpUcmlnZ2VyZWRCeTogofEgZ3Bz
ZC5zb2NrZXQKICAgIFByb2Nlc3M6IDUyODEgRXhlY1N0YXJ0PS91c3Ivc2Jpbi9ncHNkICRHUFNE
X09QVElPTlMgJE9QVElPTlMgJERFVklDRVMgKGNvZGU9ZXhpdGVkLCBzdGF0dXM9MC9TVUNDRVNT
KQogICBNYWluIFBJRDogNTI4MyAoZ3BzZCkKICAgICAgVGFza3M6IDEgKGxpbWl0OiAzNzI3MikK
ICAgICBNZW1vcnk6IDY1Mi4wSwogICAgICAgIENQVTogMTBtcwogICAgIENHcm91cDogL3N5c3Rl
bS5zbGljZS9ncHNkLnNlcnZpY2UKICAgICAgICAgICAgIKm4qaQ1MjgzIC91c3Ivc2Jpbi9ncHNk
IC1GIC92YXIvcnVuL2dwc2Quc29jayAvZGV2L2duc3MwCgo01MIgMjggMjM6MTY6NDcgamJkIHN5
c3RlbWRbMV06IFN0YXJ0aW5nIEdQUyAoR2xvYmFsIFBvc2l0aW9uaW5nIFN5c3RlbSkgRGFlbW9u
Li4uCjTUwiAyOCAyMzoxNjo0NyBqYmQgc3lzdGVtZFsxXTogU3RhcnRlZCBHUFMgKEdsb2JhbCBQ
b3NpdGlvbmluZyBTeXN0ZW0pIERhZW1vbi4KNNTCIDI4IDIzOjE3OjAyIGpiZCBncHNkWzUyODNd
OiBncHNkOkVSUk9SOiBTRVI6IGRldmljZSBvcGVuIG9mIC9kZXYvZ25zczAgZmFpbGVkOiBQZXJt
aXNzaW9uIGRlbmllZCAtIHJldHJ5aW5nIHJlYWQtb25seQo01MIgMjggMjM6MTc6MDIgamJkIGdw
c2RbNTI4M106IGdwc2Q6RVJST1I6IFNFUjogcmVhZC1vbmx5IGRldmljZSBvcGVuIG9mIC9kZXYv
Z25zczAgZmFpbGVkOiBQZXJtaXNzaW9uIGRlbmllZAo01MIgMjggMjM6MTc6MDIgamJkIGdwc2Rb
NTI4M106IGdwc2Q6RVJST1I6IC9kZXYvZ25zczA6IGRldmljZSBhY3RpdmF0aW9uIGZhaWxlZCwg
ZnJlZWluZyBkZXZpY2UuCgpBbmQgSSBjaGVja2VkIHRoZSBnbnNzIGRldmljZSBhdHRyaWJ1dGUs
IGl0IHJlcG9ydHM6CmNydy0tLS0tLS0gMSByb290IHJvb3QgMjM3LCAwICA01MIgMjggIDIwMjUg
L2Rldi9nbnNzMAoKTWF5IEkga25vdyBob3cgZG8geW91IGZpeCB0aGlzPwoKVGhhbmtzCgoK

