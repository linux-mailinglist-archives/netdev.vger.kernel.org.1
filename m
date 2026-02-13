Return-Path: <netdev+bounces-258581-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMmkNdjjjmnRFgEAu9opvQ
	(envelope-from <netdev+bounces-258581-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 09:42:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F0E134270
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 09:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 924C93002F76
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 08:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7727433E357;
	Fri, 13 Feb 2026 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xxhsMwya"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201FC33D6C9
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770972116; cv=none; b=qr6xKgo9DsoD+w/l0zO/vZulDJPSEhNH+DYD/2jmqog8FNFU6N4myF+jIvLgq7bdMyiRiAAD3DUid+F5h4d2PP2GoCG5aTkerY/msL87eckxFoBVKBlDlb8gVfEIzDD+Ke+n1O/WNttnyyIVpxyBj81cts926xT3kyZXxnCbzVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770972116; c=relaxed/simple;
	bh=E3LQ5ZFVArR9lZe4erXpxXHAKe8XagXYmrkRVdu1S2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8CZbl4ysuV84sNfHHN7EweQU9YDNWVV2AK6De1DeivcYMvRCxSMvhFBspyhZHjxolwiSV59ql49wbfs/g1NPIRKZOXY/0O2WSTLdMniB0xg72NKl/a9VyxCHJpUP4xmHAri1SyrvvAngGm/L50N773Icv24EuSgYFq2PlxgkMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xxhsMwya; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7BFF31A0E95;
	Fri, 13 Feb 2026 08:41:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 509E6606CC;
	Fri, 13 Feb 2026 08:41:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D431B10368E10;
	Fri, 13 Feb 2026 09:41:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770972110; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=hutYKT6SnDLL+y4HjgBZlrR496llLh4ROI4w2VaBdVU=;
	b=xxhsMwyaTZf4hM7j9poWeNprt9CRmu/Wd2AWPqAOc+AXBXK3qUN1m50C3I+aR3h1wvc+fF
	TioxZG9t02zhQB43H6ElhLl07RPZalfp34VSHYQdjK+MO6NkfYymCTMSf8Xvfwq1+Oj+hP
	/6bT5POqEl3Ekkzup5Oz36cHuR/Ppwe2/4ct+lb7oJfsHBz7vCC+YiZgo2DQAFInIPfyDh
	DAIeIrgkNtBHgZrMmY8GfW/lbtFywY77KRMEyfbuDxLRMGHkv93CHU+05BpSrYcTs5CY++
	y5+zMBZuxswLVPNFX0zdJsYxIGt0jpi4rxq1Z7vE8tAMK3IK/36lvz2+gg2plg==
Message-ID: <18657687-343f-4197-bdab-0eb0bed96964@bootlin.com>
Date: Fri, 13 Feb 2026 09:41:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/6] net: phylink: Allow more interfaces in SFP
 interface selection
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jonas Jelonek <jelonek.jonas@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, bcm-kernel-feedback-list@broadcom.com
References: <20260114225731.811993-1-maxime.chevallier@bootlin.com>
 <20260114225731.811993-3-maxime.chevallier@bootlin.com>
 <aWgnHo01j38TF3lp@shell.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aWgnHo01j38TF3lp@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258581-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org,bootlin.com,broadcom.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: 06F0E134270
X-Rspamd-Action: no action

Hi Russell,

On 15/01/2026 00:30, Russell King (Oracle) wrote:
> On Wed, Jan 14, 2026 at 11:57:24PM +0100, Maxime Chevallier wrote:
>> When phylink handles an SFP module that contains a PHY, it selects a
>> phy_interface to use to communicate with it. This selection ensures that
>> the highest speed gets achieved, based on the linkmodes we want to
>> support in the module.
>>
>> This approach doesn't take into account the supported interfaces
>> reported by the module
> 
> This is intentional by design, because the capabilities of the PHY
> override in this case. Unfortunately, as I've said previously, the
> rush to throw in a regurgitated version of my obsoleted
> "host_interfaces" rather messed up my replacement patch set which
> had the PHY driver advertising the interface capabilities of the
> PHY, which were then going to be used to make the PHY interface
> selection when attaching the PHY.
> 
> I've still got the code, but I can't now push it into mainline
> because, with the obsolete host_interfaces stuff merged, we will end
> up with two competing solutions.
> 
> In any case, I really would appreciate people looking through
> http://git.armlinux.org.uk/cgit/linux-arm.git/log/?h=net-queue
> 
> before doing development on SFP and phylink to see whether I've
> already something that solves their issue. Quite simply, I don't have
> the time to push every patch out that I have, especially as I'm up to
> my eyeballs with the crappy stmmac driver now, but also because I
> have work items from Oracle that reduce the time I can work on
> mainline.

net-next being closed, I was going through my backlog and I was thinking
about giving this series another go after net-next re-opens, I'd like to
sync with you about the way forward.

In your tree there's :

net: phylink: use phy interface mode bitmaps for SFP PHYs	
net: phy: add supported_interfaces to Aquantia AQR113C
net: phy: add supported_interfaces to marvell10g PHYs
net: phy: add supported_interfaces to marvell PHYs
net: phy: add supported_interfaces to bcm84881
net: phy: add supported_interfaces to phylib

These would be pre-requisites for the 100FX-SGMII SFP support, as the
interface resolution currently doesn't elect SGMII for 100FX modules.

That would require some changes to the current host_interfaces API as
well, potentially replacing it altogether.

Is this something you can do, or can I get your permission to submit
these (ofc maybe with more stuff to deal with host_interfaces)

Thanks,

Maxime

