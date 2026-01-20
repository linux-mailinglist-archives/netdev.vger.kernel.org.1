Return-Path: <netdev+bounces-251420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C504D3C469
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F177252929C
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 09:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8617E3D6666;
	Tue, 20 Jan 2026 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="gTQHtTy1"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6DB3D667B;
	Tue, 20 Jan 2026 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768902158; cv=none; b=Q8vv5u2aH9xFGxUV7wSNJeXTaZZVXwDaj+O3wBgQJVW6TdCvTuXDVZZLGsS4ArGX6oIXQ53Cy9k452pAzpUWXwdIBrjAHMMFb0EtWuIYnevPfCnnJuT2hCoH2JkKdl5Ed7Tkh27aGjcRwiA1NLGHAmQOqEzfD3TsGhfGERTK10Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768902158; c=relaxed/simple;
	bh=m/Rm4Z1i+hXaPuyBGKr5un226xoXe2uru+r1u2Qz+rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OmYykW4GdZ0uN1s8oI0vMA6ovPTziH2L4aTRfov8YLnLnFFJ8BD8sEcNgQpU+Ko66ZRdXSSwqdTeO3Ogx1jT7AAUj2qev91SQ7IwpyhcJbLqq9+ySaGU7AyyOVR2XCn0nAEA6UlYDH7izHE83FHoU000M7PBpbFfMD5gkhAZUnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=gTQHtTy1; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.178.76] (business-24-134-207-61.pool2.vodafone-ip.de [24.134.207.61])
	(Authenticated sender: g.gottleuber@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 9594F2FC0059;
	Tue, 20 Jan 2026 10:42:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1768902150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LCzxEb+8ueeOySlg2UP4MwhwZpBa7+sdZeU/qKjCHNU=;
	b=gTQHtTy1KnJqFDTw7HSdWYwz5u4qpI3RvpMTkOxpilHtpNbGsFn+B7muvDK+vORTC7G0qX
	zWcK57ONMW77KQtcfIOkXbYfB8HbH4mmvbe9+MI/LbEwYQigY3vYD8u9yzAvM9TROZTtC3
	5zBU1nk2OOahoYifL2zo75U/eZNrF0o=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=g.gottleuber@tuxedocomputers.com smtp.mailfrom=ggo@tuxedocomputers.com
Message-ID: <1be6caa4-abbd-4f3b-8c63-b637f0f9ed15@tuxedocomputers.com>
Date: Tue, 20 Jan 2026 10:42:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v6 0/3] Add DWMAC glue driver for
 Motorcomm YT6801
To: Yao Zi <me@ziyao.cc>, Georg Gottleuber <ggo@tuxedocomputers.com>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Frank.Sae@motor-comm.com,
 hkallweit1@gmail.com, vladimir.oltean@nxp.com, wens@csie.org,
 jszhang@kernel.org, 0x1207@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, jeffbai@aosc.io, kexybiscuit@aosc.io,
 Christoffer Sandberg <cs@tuxedocomputers.com>
References: <20260109093445.46791-2-me@ziyao.cc>
 <176827502141.1659151.5259885987231026081.git-patchwork-notify@kernel.org>
 <147b700c-cae2-4286-b532-ec408e00b004@tuxedocomputers.com>
 <aW5RMKqwpYTZ9uFH@shell.armlinux.org.uk>
 <be9b5704-ac9c-4cd5-aead-37433c4305a8@tuxedocomputers.com>
 <24cfefff-1233-4745-8c47-812b502d5d19@tuxedocomputers.com>
 <aW7sW91DrgZ6FMrv@pie>
Content-Language: en-US
From: Georg Gottleuber <ggo@tuxedocomputers.com>
Autocrypt: addr=g.gottleuber@tuxedocomputers.com; keydata=
 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
 bsxTTcOuRnk=
In-Reply-To: <aW7sW91DrgZ6FMrv@pie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



Am 20.01.26 um 03:45 schrieb Yao Zi:
> On Mon, Jan 19, 2026 at 06:57:48PM +0100, Georg Gottleuber wrote:
>> Am 19.01.26 um 18:45 schrieb Georg Gottleuber:
>>> Hi,
>>>
>>> thanks for the quick reply.
>>>
>>> Am 19.01.26 um 16:43 schrieb Russell King (Oracle):
>>>> On Mon, Jan 19, 2026 at 04:33:17PM +0100, Georg Gottleuber wrote:
>>>>> Hi,
>>>>>
>>>>> I tested this driver with our TUXEDO InfinityBook Pro AMD Gen9. Iperf
>>>>> revealed that tx is only 100Mbit/s:
>>>>>
>>> ...
>>>>>
>>>>> With our normally used DKMS module, Ethernet works with full-duplex and
>>>>> gigabit. Attached are some logs from lspci and dmesg. Do you have any
>>>>> idea how I can debug this further?
>>>>
>>>> My suggestion would be:
>>>>
>>>> - Look at the statistics, e.g.
>>>>
>>>>    ip -s li sh dev enp2s0
>>>
>>> That looks good (after iperf):
>>>
>>> 2: enp2s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
>>> mode DEFAULT group default qlen 1000
>>>     link/ether ba:90:88:24:49:4f brd ff:ff:ff:ff:ff:ff
>>>     RX:  bytes packets errors dropped  missed   mcast
>>>        2091654   31556      0       0       0       0
>>>     TX:  bytes packets errors dropped carrier collsns
>>>       88532451    1518      0       0       0       0
>>>
>>>
>>>> - apply
>>>>   https://lore.kernel.org/r/E1vgtBc-00000005D6v-040n@rmk-PC.armlinux.org.uk
>>>>   to enable more statistics to work, and check the network driver
>>>>   statistics:
>>>>
>>>>    ethtool --statistics enp2s0
>>>>
>>>> to see if there's any clues for what is going on.
>>>
>>> That looks also good, I think. I saved it before and after the test with
>>> iperf. See attachments.
>>
>> Oh, there was something else interesting in dmesg. See attachment.
>>
>>> Regards,
>>> Georg
> 
>> [    0.933480] dwmac-motorcomm 0000:02:00.0: error -ENOENT: failed to read maca0lr from eFuse
>> [    0.933483] dwmac-motorcomm 0000:02:00.0: eFuse contains no valid MAC address
>> [    0.933485] dwmac-motorcomm 0000:02:00.0: fallback to random MAC address
> 
> Some vendors didn't write a MAC address to the eFuse. With these YT6801
> chips, the failure is expected.

I believe we have a fixed address, as our DKMS driver always uses it (it
is also displayed in the BIOS).

> Which DKMS driver do you use? Could you read out a permanent address
> with your DKMS driver? If not, this piece of log should have nothing to
> do with the rate problem.

DKMS module we use:
https://gitlab.com/tuxedocomputers/development/packages/tuxedo-yt6801

Apparently, your driver can also read the permanent address. I rebooted
nine times to test it, and it worked nine times. So it was probably a
glitch that doesn't occur very often.

Do you have any ideas on how I can further debug the rate problem?

> Note some out-of-tree driver derived from the vendor one fallback to a
> static MAC address[1], so it doesn't mean your eFuse has MAC address
> written if you only observe the MAC address doesn't change between
> reboots.
> 
> Best regards,
> Yao Zi
> 
> [1]: https://github.com/ziyao233/yt6801-vendor-driver/blob/0efb3e86702ad2b19e7f9d19172a8e1df143e8c7/fuxi-gmac-common.c#L17-L32


