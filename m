Return-Path: <netdev+bounces-225286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C3BB91DFC
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3C984E261F
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 15:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B242737E1;
	Mon, 22 Sep 2025 15:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QX+wc9+i"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2229C2DEA86;
	Mon, 22 Sep 2025 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758554096; cv=none; b=fSdo/BPQk087H331WlcFtSpyX2nhr91W9rvypMFZEVapnj2wkQk/IfUivTmrW5652yZyoEY+tIZO1VgUEPLKD3+20W57lt3rH0LUevb7F4udX3CktnMuodUOgEtF9gMct4tMi9FO96TLNi5qi9RZo9dDLPREyZmEYpzQU2DXsas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758554096; c=relaxed/simple;
	bh=NI6tgrq7jUD35wmlWYWGHy5ZECpqLzlj09aKDBV68Ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qhKtit3D5YECxUgsdvVdBbUh5WMLNkyFWgI0eiL+qol1qo+8PZhEjPaxdL63KOjT8jlpivQMto0MF5/tEIsX+Lwg+5Se6oPiXQzuVH8m8orQvWCWtp5LknBME+DkdKtQlV5Dte2z+JZFoh2FLdvleR9kEdnGbwFHvP78rXqRvKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QX+wc9+i; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 47C98C8EC47;
	Mon, 22 Sep 2025 15:14:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 48C8E60634;
	Mon, 22 Sep 2025 15:14:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BA571102F195F;
	Mon, 22 Sep 2025 17:14:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758554090; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=IWw6WEs28jtdBhuDjcTAkgMv/86GZN35XTiWwpcVsXc=;
	b=QX+wc9+iamsIK8+Z2ZaY9/GovDdyZdChbJhrHaRNhDvTXXFGFd0o+jtVedf28cidP1WUit
	UruHONm5VjhsqokIwKkWkOxMa0TkTEQ6Qsd77E/FBfF/pLSuh48kmHIUNx7IfD2UO0fGFQ
	mVIb3iehxtHdefxoxkJdw5mOvE2drO8p1qEERawkkvLzMMjVIRcQ1h47SIZQWrvpA3xDxI
	4wa0hs4rg3Rkow3RN23+NlEL/lshetn8uJrK03uO8Xet0sACMZTatsoFpnyPI0SptpP7t1
	eccflNBeYaiISJECh4ZJDjukcEs7Tia8E3S2MoLZpDlgsub0QyWnktWb+6ubiQ==
Message-ID: <9e837217-3f93-402d-a6e6-02c419618ca5@bootlin.com>
Date: Mon, 22 Sep 2025 20:44:27 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Query regarding Phy loopback support
To: Andrew Lunn <andrew@lunn.ch>, Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, naveenm@marvell.com, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, bbhushan2@marvell.com
References: <aMlHoBWqe8YOwnv8@test-OptiPlex-Tower-Plus-7010>
 <3b76cc60-f0c5-478b-b26c-e951a71d3d0b@lunn.ch>
 <aNA5l3JEl5JMHfZM@test-OptiPlex-Tower-Plus-7010>
 <defa4c07-0f8f-43cc-ba8d-0450998a8598@lunn.ch>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <defa4c07-0f8f-43cc-ba8d-0450998a8598@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 22/09/2025 00:12, Andrew Lunn wrote:
> On Sun, Sep 21, 2025 at 11:14:55PM +0530, Hariprasad Kelam wrote:
>> On 2025-09-16 at 22:13:20, Andrew Lunn (andrew@lunn.ch) wrote:
>>> On Tue, Sep 16, 2025 at 04:48:56PM +0530, Hariprasad Kelam wrote:
>>>> We're looking for a standard way to configure PHY loopback on a network
>>>> interface using common Linux tools like ethtool, ip, or devlink.
>>>>
>>>> Currently, ethtool -k eth0 loopback on enables a generic loopback, but it
>>>> doesn't specify if it's an internal, external, or PHY loopback.
>>>> Need suggestions to implement this feature in a standard way.
>>>
>>> What actually do you mean by PHY loopback?
>>
>> The Octeon silicon series supports both MAC (RPM) and PHY (GSERM) loopback
>> modes for testing.
>>
>> We are seeking a solution to support the following loopback types:
>>
>> MAC Level
>>
>> Far-end loopback: Ingress data is routed back to egress data (MAC-to-MAC).
>>
>> Near-end external loopback: Egress traffic is routed back to ingress traffic at the PCS layer.
>>
>> PHY Level
>>
>> Near-end digital loopback
>>
>> Near-end analog loopback
>>
>> Far-end digital loopback
>>
>> Far-end analog loopback
>>
>> We need suggestions on how to enable and manage these specific modes.
> 
> Whatever you put in place, it needs to be generic to support other
> modes. So you need some sort of enum which can be extended. When
> describing the different modes, please try to reference 802.3, so it
> is clear what each actually means. And if it is a vendor mode, please
> describe it well, so other vendors know what it is, and can match
> their vendor names to it.
> 
> Frames received on the Media loopback vs host transmitted frames
> should be another property.
> 
> Are you wanting to use this with ethtool --test? That operation is
> still using IOCTL. So you will want to add netlink support, both in
> ethtool(1) and net/ethtool/netlink.c, so you can add the extra
> optional parameters to indicate where loopback should be
> performed. And them plumb this through the MAC ethtool to phylink and
> phylib, and maybe the PCS layer, if you have a linux PCS involved.

There were some previous discussions here [1] and [2] for more pointers 
on what to support with such a loopback feature. I'd be happy to help 
testing that work should you send any series.

[1]: https://lore.kernel.org/netdev/20240913093453.30811cb3@fedora.home/
[2]: https://lore.kernel.org/netdev/ZuJyJT-HgXJFe5ul@pengutronix.de/

Thanks,

Maxime

