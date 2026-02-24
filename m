Return-Path: <netdev+bounces-260307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DQ2LFkInWk7MgQAu9opvQ
	(envelope-from <netdev+bounces-260307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 03:09:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA8A180DA0
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 03:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D7B13034B1A
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 02:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B9423C51D;
	Tue, 24 Feb 2026 02:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="YLGrRVTY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m32108.qiye.163.com (mail-m32108.qiye.163.com [220.197.32.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA2319E97F;
	Tue, 24 Feb 2026 02:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771898904; cv=none; b=LuYjaFNwpiGhgQXS2pC7RvVnEvRiXwMXMXbX0nEhkYT8VREi7nxwHkbW9RocHmPp2IlpIz3wPhucqBtElNWnY2cRd7oC+xHOIUZ6YQ2aPR2oigy+mJJIEPFti72ZFpEHKvkyY7/3y8XPJa3L1pSMLGLAql8xS2x+Zg/Dc2juoxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771898904; c=relaxed/simple;
	bh=JQzQNaW8wVS2tK/GeYgPpo5RHMXOBYjCt3d20K4coM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwZMI2y8UeNyLrO4AlRzBLBdU4MWcySgSk719Pjioa0jROKrwnmMZdUe/6SXK2EpB4omfOXM7OcBaYHGSYFT24kHCzOtP0Q09ThbERIvQOtNr6NtyuL5VBPbr+klI0HE25lcm1R1WGalYea9JbsZ4gc6o+71ieXNga1Mu1WzRIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=YLGrRVTY; arc=none smtp.client-ip=220.197.32.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [127.0.0.1] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34bd766c9;
	Tue, 24 Feb 2026 10:08:16 +0800 (GMT+08:00)
Message-ID: <e0c180ae-22b7-4151-a655-74f83161deb8@rock-chips.com>
Date: Tue, 24 Feb 2026 10:08:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problematic understanding of phy-mode in Rockchip DWMAC driver
To: Diederik de Haas <diederik@cknow-tech.com>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>
Cc: Yao Zi <me@ziyao.cc>, Heiko Stuebner <heiko@sntech.de>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
References: <aY9s5PXP4zZ7R6fa@pie> <aY9xsslT56D9LGLe@shell.armlinux.org.uk>
 <f1e047e1-3f1c-4562-ab43-af2fe358fe04@lunn.ch>
 <aZDGsJNLZIty0242@shell.armlinux.org.uk>
 <a4aebacc-c273-4e42-97ff-0cdd88d771dd@lunn.ch>
 <aZMxKdkl2Qa7e1WU@shell.armlinux.org.uk>
 <DGGK56T574F0.TJSLQL9P1SM@cknow-tech.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <DGGK56T574F0.TJSLQL9P1SM@cknow-tech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9c8d677e7303abkunm282acd41e78e52
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhpDT1ZCQh1LQxlLGkkaQ05WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=YLGrRVTYXYwJ78iiZ/DQI2fHLRiYr025TGHy3A3AHdE80kecqRFIsnllhhGoByhzUL5aPHOlAcb34VOOcpOOk4xagSKOFFoHtm5VN9dMan8jLwXRHM9lMM64M1RQFiG5po0AiS8Z7/N/zQZ4T0iovsY4S6BMJwQHXcrVVmbcPP4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=7X1iUhAUWuFURylZjRz/UYuilzjOVBho6gFijhNRoZI=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rock-chips.com,none];
	R_DKIM_ALLOW(-0.20)[rock-chips.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260307-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rock-chips.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chaoyi.chen@rock-chips.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[ziyao.cc,sntech.de,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rock-chips.com:mid,rock-chips.com:dkim,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5DA8A180DA0
X-Rspamd-Action: no action

Hi all,

On 2/17/2026 1:21 AM, Diederik de Haas wrote:
> On Mon Feb 16, 2026 at 4:00 PM CET, Russell King (Oracle) wrote:
>> On Mon, Feb 16, 2026 at 02:57:48AM +0100, Andrew Lunn wrote:
>>> On Sat, Feb 14, 2026 at 07:02:08PM +0000, Russell King (Oracle) wrote:
>>>> On Sat, Feb 14, 2026 at 05:50:15PM +0100, Andrew Lunn wrote:
>>>>> Rockchip have recently started adding support for a new version, and
>>>>> appear to of listened to what we have been saying. So it could be the
>>>>> next generation of chips get this correct.
>>>>
>>>> Have you seen any proposed code from Rockchip for their new scheme?
>>>
>>> There was a patch, including a rather odd formulae to convert register
>>> value to delay. I gave some feedback, but it has been silence
>>> afterwards.
>>
>> Searching lore's netdev archive doesn't seem to bring anything up.
> 
> https://patch.msgid.link/b25d6eb2-e105-4060-86fa-c1a06396ca92@lunn.ch/
> 

I am the author of this patch series. My understanding is that
"rgmii-id" should be adopted first, and for any delays that may
need to be introduced, they should be implemented in the PHY rather
than in the GMAC, although I did try to do so. 

Did I miss something?

-- 
Best, 
Chaoyi

