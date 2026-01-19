Return-Path: <netdev+bounces-251165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F20DD3AF21
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD2913007210
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8041D35C18A;
	Mon, 19 Jan 2026 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="IsG+Hivj"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AD23101DB;
	Mon, 19 Jan 2026 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768836806; cv=none; b=nU9ysYh2TTS6mbUd8t8Fam4wsF7BVYBnesMjXXy3+2CmuBnDtyzSDVo0RzG63D9kKSur99qDv8SIMuglARDE2LNlCRLmv+FpJgGzVDTmbKVtdpMTAwg4AmYdJ+puIOAYONHMgtCjSz2eSVfnfmlw7r5McIuR833NVUxbhp5RykY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768836806; c=relaxed/simple;
	bh=ufKNUccJSrzFyk7zWsaZB0bCkL4HAJQgrA6heYbp/RM=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=aQbUlzoVzO//igTnabwxc0iuNA0rysOEnghk/D+17kFBmoPnJSijK6ejjNjFQXxXh3T0wozT4A71/hJvcFpuvL6C2Suw/yWEe0R6q6SXfxZTdUnM+mYSSMF5isUsxasAtaEg1TMeQXKhhtXKJT/I/YLihQwA03WQGECx2vswXRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=IsG+Hivj; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.178.76] (business-24-134-207-61.pool2.vodafone-ip.de [24.134.207.61])
	(Authenticated sender: g.gottleuber@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 71FF92FC0052;
	Mon, 19 Jan 2026 16:33:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1768836800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oLQtlHQouJ0+kewEyqfnvuT+Xm9wn8E2JehCz2FGDk4=;
	b=IsG+Hivjty89yHVSpCX6I3J5aizR/0l5eGDsvlh5b+nEeYZ3mwUGCR6BWFumk+xsm+BPsj
	GSOfZ5eFRBto4QfxSuu9+1ntzvr/Z5nMwhaQhsNABEafR3HWYtFtwPcpYr2lsQAzQoYA/t
	nCwfzgUStnOcswupzX9kF0+MbjoCkTo=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=g.gottleuber@tuxedocomputers.com smtp.mailfrom=ggo@tuxedocomputers.com
Content-Type: multipart/mixed; boundary="------------KGlKmiH0tvnGHyr30jvJ0cjH"
Message-ID: <147b700c-cae2-4286-b532-ec408e00b004@tuxedocomputers.com>
Date: Mon, 19 Jan 2026 16:33:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v6 0/3] Add DWMAC glue driver for
 Motorcomm YT6801
To: Yao Zi <me@ziyao.cc>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Frank.Sae@motor-comm.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk,
 vladimir.oltean@nxp.com, wens@csie.org, jszhang@kernel.org,
 0x1207@gmail.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 jeffbai@aosc.io, kexybiscuit@aosc.io
References: <20260109093445.46791-2-me@ziyao.cc>
 <176827502141.1659151.5259885987231026081.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: Georg Gottleuber <ggo@tuxedocomputers.com>
Autocrypt: addr=g.gottleuber@tuxedocomputers.com; keydata=
 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
 bsxTTcOuRnk=
In-Reply-To: <176827502141.1659151.5259885987231026081.git-patchwork-notify@kernel.org>

This is a multi-part message in MIME format.
--------------KGlKmiH0tvnGHyr30jvJ0cjH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I tested this driver with our TUXEDO InfinityBook Pro AMD Gen9. Iperf
revealed that tx is only 100Mbit/s:

## YT6801 TX

[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  8.75 MBytes  73.3 Mbits/sec    0    164 KBytes

[  5]   1.00-2.00   sec  8.62 MBytes  72.4 Mbits/sec    0    164 KBytes

[  5]   2.00-3.00   sec  8.62 MBytes  72.4 Mbits/sec    0    164 KBytes

[  5]   3.00-4.00   sec  8.12 MBytes  68.2 Mbits/sec    0    164 KBytes

[  5]   4.00-5.00   sec  8.62 MBytes  72.3 Mbits/sec    0    164 KBytes

[  5]   5.00-6.00   sec  8.50 MBytes  71.3 Mbits/sec    0    164 KBytes

[  5]   6.00-7.00   sec  8.25 MBytes  69.2 Mbits/sec    0    164 KBytes

[  5]   7.00-8.00   sec  8.62 MBytes  72.4 Mbits/sec    0    164 KBytes

[  5]   8.00-9.00   sec  8.50 MBytes  71.3 Mbits/sec    0    164 KBytes

[  5]   9.00-10.00  sec  8.62 MBytes  72.3 Mbits/sec    0    164 KBytes

- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  85.2 MBytes  71.5 Mbits/sec    0             sender
[  5]   0.00-10.05  sec  84.4 MBytes  70.5 Mbits/sec
receiver


## YT6801 RX

[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec   112 MBytes   939 Mbits/sec
[  5]   1.00-2.00   sec   112 MBytes   941 Mbits/sec
[  5]   2.00-3.00   sec   112 MBytes   941 Mbits/sec
[  5]   3.00-4.00   sec   112 MBytes   942 Mbits/sec
[  5]   4.00-5.00   sec   112 MBytes   942 Mbits/sec
[  5]   5.00-6.00   sec   112 MBytes   943 Mbits/sec
[  5]   6.00-7.00   sec   112 MBytes   941 Mbits/sec
[  5]   7.00-8.00   sec   112 MBytes   942 Mbits/sec
[  5]   8.00-9.00   sec   112 MBytes   942 Mbits/sec
[  5]   9.00-10.00  sec   112 MBytes   941 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.04  sec  1.10 GBytes   941 Mbits/sec   88             sender
[  5]   0.00-10.00  sec  1.10 GBytes   941 Mbits/sec
receiver

With our normally used DKMS module, Ethernet works with full-duplex and
gigabit. Attached are some logs from lspci and dmesg. Do you have any
idea how I can debug this further?

Regards,
Georg


--------------KGlKmiH0tvnGHyr30jvJ0cjH
Content-Type: text/plain; charset=UTF-8;
 name="dmesg_lspci_motorcomm_ibp14gen9_AMD.txt"
Content-Disposition: attachment;
 filename="dmesg_lspci_motorcomm_ibp14gen9_AMD.txt"
Content-Transfer-Encoding: base64

cm9vdEB0dXhlZG86L2hvbWUvdGVzdCMgdW5hbWUgLWEKTGludXggdHV4ZWRvIDYuMTkuMC1y
YzUtbmV4dC0yMDI2MDExNmxuMDIgIzE0IFNNUCBQUkVFTVBUX0RZTkFNSUMgRnJpIEphbiAx
NiAxOTowMjoxMCBDRVQgMjAyNiB4ODZfNjQgeDg2XzY0IHg4Nl82NCBHTlUvTGludXgKcm9v
dEB0dXhlZG86L2hvbWUvdGVzdCMgbHNwY2kgLW5uCjAwOjAwLjAgSG9zdCBicmlkZ2UgWzA2
MDBdOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTURdIFBob2VuaXggUm9vdCBD
b21wbGV4IFsxMDIyOjE0ZThdCjAwOjAwLjIgSU9NTVUgWzA4MDZdOiBBZHZhbmNlZCBNaWNy
byBEZXZpY2VzLCBJbmMuIFtBTURdIFBob2VuaXggSU9NTVUgWzEwMjI6MTRlOV0KMDA6MDEu
MCBIb3N0IGJyaWRnZSBbMDYwMF06IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FN
RF0gUGhvZW5peCBEdW1teSBIb3N0IEJyaWRnZSBbMTAyMjoxNGVhXQowMDowMS4yIFBDSSBi
cmlkZ2UgWzA2MDRdOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTURdIFBob2Vu
aXggR1BQIEJyaWRnZSBbMTAyMjoxNGVkXQowMDowMi4wIEhvc3QgYnJpZGdlIFswNjAwXTog
QWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EXSBQaG9lbml4IER1bW15IEhvc3Qg
QnJpZGdlIFsxMDIyOjE0ZWFdCjAwOjAyLjEgUENJIGJyaWRnZSBbMDYwNF06IEFkdmFuY2Vk
IE1pY3JvIERldmljZXMsIEluYy4gW0FNRF0gUGhvZW5peCBHUFAgQnJpZGdlIFsxMDIyOjE0
ZWVdCjAwOjAyLjIgUENJIGJyaWRnZSBbMDYwNF06IEFkdmFuY2VkIE1pY3JvIERldmljZXMs
IEluYy4gW0FNRF0gUGhvZW5peCBHUFAgQnJpZGdlIFsxMDIyOjE0ZWVdCjAwOjAyLjMgUENJ
IGJyaWRnZSBbMDYwNF06IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRF0gUGhv
ZW5peCBHUFAgQnJpZGdlIFsxMDIyOjE0ZWVdCjAwOjAzLjAgSG9zdCBicmlkZ2UgWzA2MDBd
OiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTURdIFBob2VuaXggRHVtbXkgSG9z
dCBCcmlkZ2UgWzEwMjI6MTRlYV0KMDA6MDQuMCBIb3N0IGJyaWRnZSBbMDYwMF06IEFkdmFu
Y2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRF0gUGhvZW5peCBEdW1teSBIb3N0IEJyaWRn
ZSBbMTAyMjoxNGVhXQowMDowNC4xIFBDSSBicmlkZ2UgWzA2MDRdOiBBZHZhbmNlZCBNaWNy
byBEZXZpY2VzLCBJbmMuIFtBTURdIEZhbWlseSAxOWggVVNCNC9UaHVuZGVyYm9sdCBQQ0ll
IHR1bm5lbCBbMTAyMjoxNGVmXQowMDowOC4wIEhvc3QgYnJpZGdlIFswNjAwXTogQWR2YW5j
ZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EXSBQaG9lbml4IER1bW15IEhvc3QgQnJpZGdl
IFsxMDIyOjE0ZWFdCjAwOjA4LjEgUENJIGJyaWRnZSBbMDYwNF06IEFkdmFuY2VkIE1pY3Jv
IERldmljZXMsIEluYy4gW0FNRF0gUGhvZW5peCBJbnRlcm5hbCBHUFAgQnJpZGdlIHRvIEJ1
cyBbQzpBXSBbMTAyMjoxNGViXQowMDowOC4yIFBDSSBicmlkZ2UgWzA2MDRdOiBBZHZhbmNl
ZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTURdIFBob2VuaXggSW50ZXJuYWwgR1BQIEJyaWRn
ZSB0byBCdXMgW0M6QV0gWzEwMjI6MTRlYl0KMDA6MDguMyBQQ0kgYnJpZGdlIFswNjA0XTog
QWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EXSBQaG9lbml4IEludGVybmFsIEdQ
UCBCcmlkZ2UgdG8gQnVzIFtDOkFdIFsxMDIyOjE0ZWJdCjAwOjE0LjAgU01CdXMgWzBjMDVd
OiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTURdIEZDSCBTTUJ1cyBDb250cm9s
bGVyIFsxMDIyOjc5MGJdIChyZXYgNzEpCjAwOjE0LjMgSVNBIGJyaWRnZSBbMDYwMV06IEFk
dmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRF0gRkNIIExQQyBCcmlkZ2UgWzEwMjI6
NzkwZV0gKHJldiA1MSkKMDA6MTguMCBIb3N0IGJyaWRnZSBbMDYwMF06IEFkdmFuY2VkIE1p
Y3JvIERldmljZXMsIEluYy4gW0FNRF0gUGhvZW5peCBEYXRhIEZhYnJpYzsgRnVuY3Rpb24g
MCBbMTAyMjoxNGYwXQowMDoxOC4xIEhvc3QgYnJpZGdlIFswNjAwXTogQWR2YW5jZWQgTWlj
cm8gRGV2aWNlcywgSW5jLiBbQU1EXSBQaG9lbml4IERhdGEgRmFicmljOyBGdW5jdGlvbiAx
IFsxMDIyOjE0ZjFdCjAwOjE4LjIgSG9zdCBicmlkZ2UgWzA2MDBdOiBBZHZhbmNlZCBNaWNy
byBEZXZpY2VzLCBJbmMuIFtBTURdIFBob2VuaXggRGF0YSBGYWJyaWM7IEZ1bmN0aW9uIDIg
WzEwMjI6MTRmMl0KMDA6MTguMyBIb3N0IGJyaWRnZSBbMDYwMF06IEFkdmFuY2VkIE1pY3Jv
IERldmljZXMsIEluYy4gW0FNRF0gUGhvZW5peCBEYXRhIEZhYnJpYzsgRnVuY3Rpb24gMyBb
MTAyMjoxNGYzXQowMDoxOC40IEhvc3QgYnJpZGdlIFswNjAwXTogQWR2YW5jZWQgTWljcm8g
RGV2aWNlcywgSW5jLiBbQU1EXSBQaG9lbml4IERhdGEgRmFicmljOyBGdW5jdGlvbiA0IFsx
MDIyOjE0ZjRdCjAwOjE4LjUgSG9zdCBicmlkZ2UgWzA2MDBdOiBBZHZhbmNlZCBNaWNybyBE
ZXZpY2VzLCBJbmMuIFtBTURdIFBob2VuaXggRGF0YSBGYWJyaWM7IEZ1bmN0aW9uIDUgWzEw
MjI6MTRmNV0KMDA6MTguNiBIb3N0IGJyaWRnZSBbMDYwMF06IEFkdmFuY2VkIE1pY3JvIERl
dmljZXMsIEluYy4gW0FNRF0gUGhvZW5peCBEYXRhIEZhYnJpYzsgRnVuY3Rpb24gNiBbMTAy
MjoxNGY2XQowMDoxOC43IEhvc3QgYnJpZGdlIFswNjAwXTogQWR2YW5jZWQgTWljcm8gRGV2
aWNlcywgSW5jLiBbQU1EXSBQaG9lbml4IERhdGEgRmFicmljOyBGdW5jdGlvbiA3IFsxMDIy
OjE0ZjddCjAxOjAwLjAgTm9uLVZvbGF0aWxlIG1lbW9yeSBjb250cm9sbGVyIFswMTA4XTog
U2Ftc3VuZyBFbGVjdHJvbmljcyBDbyBMdGQgTlZNZSBTU0QgQ29udHJvbGxlciA5ODAgKERS
QU0tbGVzcykgWzE0NGQ6YTgwOV0KMDI6MDAuMCBFdGhlcm5ldCBjb250cm9sbGVyIFswMjAw
XTogTW90b3Jjb21tIE1pY3JvZWxlY3Ryb25pY3MuIFlUNjgwMSBHaWdhYml0IEV0aGVybmV0
IENvbnRyb2xsZXIgWzFmMGE6NjgwMV0gKHJldiAwMSkKMDM6MDAuMCBOZXR3b3JrIGNvbnRy
b2xsZXIgWzAyODBdOiBJbnRlbCBDb3Jwb3JhdGlvbiBXaS1GaSA2RSg4MDIuMTFheCkgQVgy
MTAvQVgxNjc1KiAyeDIgW1R5cGhvb24gUGVha10gWzgwODY6MjcyNV0gKHJldiAxYSkKMDQ6
MDAuMCBTRCBIb3N0IGNvbnRyb2xsZXIgWzA4MDVdOiBHZW5lc3lzIExvZ2ljLCBJbmMgR0w5
NzY3IFBDSWUgU0QgVUhTLUlJICYgU0QgRXhwcmVzcyBDYXJkIFJlYWRlciBDb250cm9sbGVy
IFsxN2EwOjk3NjddIChyZXYgMDIpCjY1OjAwLjAgVkdBIGNvbXBhdGlibGUgY29udHJvbGxl
ciBbMDMwMF06IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRC9BVEldIEhhd2tQ
b2ludDEgWzEwMDI6MTkwMF0gKHJldiBjNSkKNjU6MDAuMSBBdWRpbyBkZXZpY2UgWzA0MDNd
OiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTUQvQVRJXSBSYWRlb24gSGlnaCBE
ZWZpbml0aW9uIEF1ZGlvIENvbnRyb2xsZXIgWzEwMDI6MTY0MF0KNjU6MDAuMiBFbmNyeXB0
aW9uIGNvbnRyb2xsZXIgWzEwODBdOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtB
TURdIFBob2VuaXggQ0NQL1BTUCAzLjAgRGV2aWNlIFsxMDIyOjE1YzddCjY1OjAwLjMgVVNC
IGNvbnRyb2xsZXIgWzBjMDNdOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTURd
IERldmljZSBbMTAyMjoxNWI5XQo2NTowMC40IFVTQiBjb250cm9sbGVyIFswYzAzXTogQWR2
YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EXSBEZXZpY2UgWzEwMjI6MTViYV0KNjU6
MDAuNSBNdWx0aW1lZGlhIGNvbnRyb2xsZXIgWzA0ODBdOiBBZHZhbmNlZCBNaWNybyBEZXZp
Y2VzLCBJbmMuIFtBTURdIEF1ZGlvIENvcHJvY2Vzc29yIFsxMDIyOjE1ZTJdIChyZXYgNjMp
CjY1OjAwLjYgQXVkaW8gZGV2aWNlIFswNDAzXTogQWR2YW5jZWQgTWljcm8gRGV2aWNlcywg
SW5jLiBbQU1EXSBSeXplbiBIRCBBdWRpbyBDb250cm9sbGVyIFsxMDIyOjE1ZTNdCjY2OjAw
LjAgTm9uLUVzc2VudGlhbCBJbnN0cnVtZW50YXRpb24gWzEzMDBdOiBBZHZhbmNlZCBNaWNy
byBEZXZpY2VzLCBJbmMuIFtBTURdIFBob2VuaXggRHVtbXkgRnVuY3Rpb24gWzEwMjI6MTRl
Y10KNjY6MDAuMSBTaWduYWwgcHJvY2Vzc2luZyBjb250cm9sbGVyIFsxMTgwXTogQWR2YW5j
ZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EXSBBTUQgSVBVIERldmljZSBbMTAyMjoxNTAy
XQo2NzowMC4wIE5vbi1Fc3NlbnRpYWwgSW5zdHJ1bWVudGF0aW9uIFsxMzAwXTogQWR2YW5j
ZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EXSBQaG9lbml4IER1bW15IEZ1bmN0aW9uIFsx
MDIyOjE0ZWNdCjY3OjAwLjMgVVNCIGNvbnRyb2xsZXIgWzBjMDNdOiBBZHZhbmNlZCBNaWNy
byBEZXZpY2VzLCBJbmMuIFtBTURdIERldmljZSBbMTAyMjoxNWMwXQo2NzowMC40IFVTQiBj
b250cm9sbGVyIFswYzAzXTogQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EXSBE
ZXZpY2UgWzEwMjI6MTVjMV0KNjc6MDAuNiBVU0IgY29udHJvbGxlciBbMGMwM106IEFkdmFu
Y2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRF0gUGluayBTYXJkaW5lIFVTQjQvVGh1bmRl
cmJvbHQgTkhJIGNvbnRyb2xsZXIgIzIgWzEwMjI6MTY2OV0Kcm9vdEB0dXhlZG86L2hvbWUv
dGVzdCMgZG1lc2cgfCBncmVwIG1vdG9yY29tbQpbICAgIDEuMTIyNjU0XSBkd21hYy1tb3Rv
cmNvbW0gMDAwMDowMjowMC4wOiBVc2VyIElEOiAweDEwLCBTeW5vcHN5cyBJRDogMHg1Mgpb
ICAgIDEuMTIyNjYyXSBkd21hYy1tb3RvcmNvbW0gMDAwMDowMjowMC4wOiAgICBEV01BQzQv
NQpbICAgIDEuMTIyNjc1XSBkd21hYy1tb3RvcmNvbW0gMDAwMDowMjowMC4wOiBETUEgSFcg
Y2FwYWJpbGl0eSByZWdpc3RlciBzdXBwb3J0ZWQKWyAgICAxLjEyMjY3N10gZHdtYWMtbW90
b3Jjb21tIDAwMDA6MDI6MDAuMDogUlggQ2hlY2tzdW0gT2ZmbG9hZCBFbmdpbmUgc3VwcG9y
dGVkClsgICAgMS4xMjI2NzldIGR3bWFjLW1vdG9yY29tbSAwMDAwOjAyOjAwLjA6IFRYIENo
ZWNrc3VtIGluc2VydGlvbiBzdXBwb3J0ZWQKWyAgICAxLjEyMjY4MF0gZHdtYWMtbW90b3Jj
b21tIDAwMDA6MDI6MDAuMDogV2FrZS1VcCBPbiBMYW4gc3VwcG9ydGVkClsgICAgMS4xMjI2
ODNdIGR3bWFjLW1vdG9yY29tbSAwMDAwOjAyOjAwLjA6IFRTTyBzdXBwb3J0ZWQKWyAgICAx
LjEyMjY4NF0gZHdtYWMtbW90b3Jjb21tIDAwMDA6MDI6MDAuMDogRW5hYmxlIFJYIE1pdGln
YXRpb24gdmlhIEhXIFdhdGNoZG9nIFRpbWVyClsgICAgMS4xMjI2ODddIGR3bWFjLW1vdG9y
Y29tbSAwMDAwOjAyOjAwLjA6IEVuYWJsZWQgTDNMNCBGbG93IFRDIChlbnRyaWVzPTIpClsg
ICAgMS4xMjI2ODldIGR3bWFjLW1vdG9yY29tbSAwMDAwOjAyOjAwLjA6IEVuYWJsZWQgUkZT
IEZsb3cgVEMgKGVudHJpZXM9MTApClsgICAgMS4xMjI2OTFdIGR3bWFjLW1vdG9yY29tbSAw
MDAwOjAyOjAwLjA6IFRTTyBmZWF0dXJlIGVuYWJsZWQKWyAgICAxLjEyMjY5Ml0gZHdtYWMt
bW90b3Jjb21tIDAwMDA6MDI6MDAuMDogU1BIIGZlYXR1cmUgZW5hYmxlZApbICAgIDEuMTIy
Njk0XSBkd21hYy1tb3RvcmNvbW0gMDAwMDowMjowMC4wOiBVc2luZyA0OC80OCBiaXRzIERN
QSBob3N0L2RldmljZSB3aWR0aApbICAgIDEuMzc4MTI2XSBkd21hYy1tb3RvcmNvbW0gMDAw
MDowMjowMC4wIGVucDJzMDogcmVuYW1lZCBmcm9tIGV0aDAKWyAgICA1LjgwMTA1MV0gZHdt
YWMtbW90b3Jjb21tIDAwMDA6MDI6MDAuMCBlbnAyczA6IFJlZ2lzdGVyIE1FTV9UWVBFX1BB
R0VfUE9PTCBSeFEtMApbICAgIDUuODA1MzU5XSBkd21hYy1tb3RvcmNvbW0gMDAwMDowMjow
MC4wIGVucDJzMDogUEhZIFtzdG1tYWMtMjAwOjAwXSBkcml2ZXIgW1lUODUzMVMgR2lnYWJp
dCBFdGhlcm5ldF0gKGlycT1QT0xMKQpbICAgIDUuODE1NDM4XSBkd21hYy1tb3RvcmNvbW0g
MDAwMDowMjowMC4wIGVucDJzMDogRW5hYmxpbmcgU2FmZXR5IEZlYXR1cmVzClsgICAgNS44
MTU2MjNdIGR3bWFjLW1vdG9yY29tbSAwMDAwOjAyOjAwLjAgZW5wMnMwOiBQVFAgbm90IHN1
cHBvcnRlZCBieSBIVwpbICAgIDUuODE1NjI2XSBkd21hYy1tb3RvcmNvbW0gMDAwMDowMjow
MC4wIGVucDJzMDogY29uZmlndXJpbmcgZm9yIHBoeS9nbWlpIGxpbmsgbW9kZQpbICAgIDgu
OTEwNzI1XSBkd21hYy1tb3RvcmNvbW0gMDAwMDowMjowMC4wIGVucDJzMDogTGluayBpcyBV
cCAtIDFHYnBzL0Z1bGwgLSBmbG93IGNvbnRyb2wgcngvdHgK

--------------KGlKmiH0tvnGHyr30jvJ0cjH--

