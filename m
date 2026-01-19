Return-Path: <netdev+bounces-251208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30685D3B4FA
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AAD9D3008CAB
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 17:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B9432E721;
	Mon, 19 Jan 2026 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="mPvIMiYO"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B9132B9A6;
	Mon, 19 Jan 2026 17:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768845476; cv=none; b=RERYH08vSvbbtRwajUIVYHg0N3QDVRw75EyD6ZURYzhG/TFp76vJdJHQXDzOAeRkLIUKWyh/qyB5tE0+yc8KimUHQUHUFWaggd6mjV6WI5I3zmTmtBykUxziX5GhTfJ29apXDf91SaWbVXHPV8KKHYLFjeJ3nd+IIuzcOOBf/mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768845476; c=relaxed/simple;
	bh=aeAMwDy300xtVjO1yTpgW+rQwqZyPI7I8i814Kjmu6k=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=nFy2e3+AAddj9yX8BBuIbGkWlmF0YJKzy7WxywoKvl1LJaj+hr16qKpRwF44DkoUDaiS84QE/WgaRfizu0Wza8C9XJ1aCfr/oh83mZAhzJQXNpS9b8Td4/PbJx34fdmBM4GE/+r+ea02UChS4v2/WYwZoiuJueVzy+9wb47MG8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=mPvIMiYO; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.178.76] (business-24-134-207-61.pool2.vodafone-ip.de [24.134.207.61])
	(Authenticated sender: g.gottleuber@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 0507B2FC0052;
	Mon, 19 Jan 2026 18:57:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1768845469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9neysObSDag5TO86XuxLkbvz/mjlkH1pwb0MRj36kJY=;
	b=mPvIMiYOzVg0ObOlBlitMjIQzlqSrkFae/PwrieuBn0X2NJJRz/UDThIQAeOstVZQ5MBFJ
	nA2zlPShY78k5srUy8PBEdJ5iRBbNCRyKAgcIwtPmom1dHgO4z2NJXIGIpL/DZpBe1Dpjt
	V1EaGyMPowt52U6J1za5tU2Wt6ETfn0=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=g.gottleuber@tuxedocomputers.com smtp.mailfrom=ggo@tuxedocomputers.com
Content-Type: multipart/mixed; boundary="------------eBBAZgy1CXJ4IyGkpFjVDyhb"
Message-ID: <24cfefff-1233-4745-8c47-812b502d5d19@tuxedocomputers.com>
Date: Mon, 19 Jan 2026 18:57:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v6 0/3] Add DWMAC glue driver for
 Motorcomm YT6801
To: Georg Gottleuber <ggo@tuxedocomputers.com>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Yao Zi <me@ziyao.cc>, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Frank.Sae@motor-comm.com, hkallweit1@gmail.com, vladimir.oltean@nxp.com,
 wens@csie.org, jszhang@kernel.org, 0x1207@gmail.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jeffbai@aosc.io,
 kexybiscuit@aosc.io, Christoffer Sandberg <cs@tuxedocomputers.com>
References: <20260109093445.46791-2-me@ziyao.cc>
 <176827502141.1659151.5259885987231026081.git-patchwork-notify@kernel.org>
 <147b700c-cae2-4286-b532-ec408e00b004@tuxedocomputers.com>
 <aW5RMKqwpYTZ9uFH@shell.armlinux.org.uk>
 <be9b5704-ac9c-4cd5-aead-37433c4305a8@tuxedocomputers.com>
Content-Language: en-US
From: Georg Gottleuber <ggo@tuxedocomputers.com>
In-Reply-To: <be9b5704-ac9c-4cd5-aead-37433c4305a8@tuxedocomputers.com>

This is a multi-part message in MIME format.
--------------eBBAZgy1CXJ4IyGkpFjVDyhb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 19.01.26 um 18:45 schrieb Georg Gottleuber:
> Hi,
> 
> thanks for the quick reply.
> 
> Am 19.01.26 um 16:43 schrieb Russell King (Oracle):
>> On Mon, Jan 19, 2026 at 04:33:17PM +0100, Georg Gottleuber wrote:
>>> Hi,
>>>
>>> I tested this driver with our TUXEDO InfinityBook Pro AMD Gen9. Iperf
>>> revealed that tx is only 100Mbit/s:
>>>
> ...
>>>
>>> With our normally used DKMS module, Ethernet works with full-duplex and
>>> gigabit. Attached are some logs from lspci and dmesg. Do you have any
>>> idea how I can debug this further?
>>
>> My suggestion would be:
>>
>> - Look at the statistics, e.g.
>>
>>    ip -s li sh dev enp2s0
> 
> That looks good (after iperf):
> 
> 2: enp2s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
> mode DEFAULT group default qlen 1000
>     link/ether ba:90:88:24:49:4f brd ff:ff:ff:ff:ff:ff
>     RX:  bytes packets errors dropped  missed   mcast
>        2091654   31556      0       0       0       0
>     TX:  bytes packets errors dropped carrier collsns
>       88532451    1518      0       0       0       0
> 
> 
>> - apply
>>   https://lore.kernel.org/r/E1vgtBc-00000005D6v-040n@rmk-PC.armlinux.org.uk
>>   to enable more statistics to work, and check the network driver
>>   statistics:
>>
>>    ethtool --statistics enp2s0
>>
>> to see if there's any clues for what is going on.
> 
> That looks also good, I think. I saved it before and after the test with
> iperf. See attachments.

Oh, there was something else interesting in dmesg. See attachment.

> Regards,
> Georg

--------------eBBAZgy1CXJ4IyGkpFjVDyhb
Content-Type: text/plain; charset=UTF-8; name="dmesg_motorcomm.txt"
Content-Disposition: attachment; filename="dmesg_motorcomm.txt"
Content-Transfer-Encoding: base64

WyAgICAwLjkzMzQ4MF0gZHdtYWMtbW90b3Jjb21tIDAwMDA6MDI6MDAuMDogZXJyb3IgLUVO
T0VOVDogZmFpbGVkIHRvIHJlYWQgbWFjYTBsciBmcm9tIGVGdXNlClsgICAgMC45MzM0ODNd
IGR3bWFjLW1vdG9yY29tbSAwMDAwOjAyOjAwLjA6IGVGdXNlIGNvbnRhaW5zIG5vIHZhbGlk
IE1BQyBhZGRyZXNzClsgICAgMC45MzM0ODVdIGR3bWFjLW1vdG9yY29tbSAwMDAwOjAyOjAw
LjA6IGZhbGxiYWNrIHRvIHJhbmRvbSBNQUMgYWRkcmVzcwpbICAgIDAuOTMzOTQxXSBkd21h
Yy1tb3RvcmNvbW0gMDAwMDowMjowMC4wOiBVc2VyIElEOiAweDEwLCBTeW5vcHN5cyBJRDog
MHg1MgpbICAgIDAuOTMzOTQzXSBkd21hYy1tb3RvcmNvbW0gMDAwMDowMjowMC4wOiAJRFdN
QUM0LzUKWyAgICAwLjkzMzk1NV0gZHdtYWMtbW90b3Jjb21tIDAwMDA6MDI6MDAuMDogRE1B
IEhXIGNhcGFiaWxpdHkgcmVnaXN0ZXIgc3VwcG9ydGVkClsgICAgMC45MzM5NTZdIGR3bWFj
LW1vdG9yY29tbSAwMDAwOjAyOjAwLjA6IFJYIENoZWNrc3VtIE9mZmxvYWQgRW5naW5lIHN1
cHBvcnRlZApbICAgIDAuOTMzOTU3XSBkd21hYy1tb3RvcmNvbW0gMDAwMDowMjowMC4wOiBU
WCBDaGVja3N1bSBpbnNlcnRpb24gc3VwcG9ydGVkClsgICAgMC45MzM5NThdIGR3bWFjLW1v
dG9yY29tbSAwMDAwOjAyOjAwLjA6IFdha2UtVXAgT24gTGFuIHN1cHBvcnRlZApbICAgIDAu
OTMzOTYxXSBkd21hYy1tb3RvcmNvbW0gMDAwMDowMjowMC4wOiBUU08gc3VwcG9ydGVkClsg
ICAgMC45MzM5NjJdIGR3bWFjLW1vdG9yY29tbSAwMDAwOjAyOjAwLjA6IEVuYWJsZSBSWCBN
aXRpZ2F0aW9uIHZpYSBIVyBXYXRjaGRvZyBUaW1lcgpbICAgIDAuOTMzOTY0XSBkd21hYy1t
b3RvcmNvbW0gMDAwMDowMjowMC4wOiBFbmFibGVkIEwzTDQgRmxvdyBUQyAoZW50cmllcz0y
KQpbICAgIDAuOTMzOTY1XSBkd21hYy1tb3RvcmNvbW0gMDAwMDowMjowMC4wOiBFbmFibGVk
IFJGUyBGbG93IFRDIChlbnRyaWVzPTEwKQpbICAgIDAuOTMzOTY2XSBkd21hYy1tb3RvcmNv
bW0gMDAwMDowMjowMC4wOiBUU08gZmVhdHVyZSBlbmFibGVkClsgICAgMC45MzM5NjddIGR3
bWFjLW1vdG9yY29tbSAwMDAwOjAyOjAwLjA6IFNQSCBmZWF0dXJlIGVuYWJsZWQKWyAgICAw
LjkzMzk2OF0gZHdtYWMtbW90b3Jjb21tIDAwMDA6MDI6MDAuMDogVXNpbmcgNDgvNDggYml0
cyBETUEgaG9zdC9kZXZpY2Ugd2lkdGgKWyAgICAxLjMwMjAxNF0gZHdtYWMtbW90b3Jjb21t
IDAwMDA6MDI6MDAuMCBlbnAyczA6IHJlbmFtZWQgZnJvbSBldGgwClsgICAgNS43NTMyNTld
IGR3bWFjLW1vdG9yY29tbSAwMDAwOjAyOjAwLjAgZW5wMnMwOiBSZWdpc3RlciBNRU1fVFlQ
RV9QQUdFX1BPT0wgUnhRLTAKWyAgICA1Ljc1NzUyOV0gZHdtYWMtbW90b3Jjb21tIDAwMDA6
MDI6MDAuMCBlbnAyczA6IFBIWSBbc3RtbWFjLTIwMDowMF0gZHJpdmVyIFtZVDg1MzFTIEdp
Z2FiaXQgRXRoZXJuZXRdIChpcnE9UE9MTCkKWyAgICA1Ljc2ODQ0Ml0gZHdtYWMtbW90b3Jj
b21tIDAwMDA6MDI6MDAuMCBlbnAyczA6IEVuYWJsaW5nIFNhZmV0eSBGZWF0dXJlcwpbICAg
IDUuNzY4NjY5XSBkd21hYy1tb3RvcmNvbW0gMDAwMDowMjowMC4wIGVucDJzMDogUFRQIG5v
dCBzdXBwb3J0ZWQgYnkgSFcKWyAgICA1Ljc2ODY3M10gZHdtYWMtbW90b3Jjb21tIDAwMDA6
MDI6MDAuMCBlbnAyczA6IGNvbmZpZ3VyaW5nIGZvciBwaHkvZ21paSBsaW5rIG1vZGUKWyAg
ICA4Ljg0NzAwOV0gZHdtYWMtbW90b3Jjb21tIDAwMDA6MDI6MDAuMCBlbnAyczA6IExpbmsg
aXMgVXAgLSAxR2Jwcy9GdWxsIC0gZmxvdyBjb250cm9sIHJ4L3R4Cg==

--------------eBBAZgy1CXJ4IyGkpFjVDyhb--

