Return-Path: <netdev+bounces-307404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zzq8Ftb+VWpRxgAAu9opvQ
	(envelope-from <netdev+bounces-307404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:18:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B85E2752BD7
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:18:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=vVpMQ8aI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307404-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307404-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84F0D3063180
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 09:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B09B43F8B0;
	Tue, 14 Jul 2026 09:16:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EE343FD0C
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 09:16:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020616; cv=none; b=IiaZPN69dP1XwcR+spp7DTQPdwWhuG8r7QoMZoUlVosUXjz7F28DkwblH79jn70lzLmAslTizsteUf07SB+CIRlDxtM+VmIAFBZD2wswVnROQyYPE39KKq7rMhK+8r2JitUyO6vhL4eTaCOWPxGZA6MMyH9pIDqQ2ysQlYd6IRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020616; c=relaxed/simple;
	bh=g3LxXL/bvX2bnISy9b4ZFDkVoL1rBQWGDWX5ygHH/3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d8SpCKHymswxvH7xgOpualY2zaRueSc5B93fJtBe1X1NTXsySLkuTQ2KFIlOy6gLuALjR1TjBEfuYtvVKov8rS817+Rf2gSb4b5fwJX27LU/vRoHRdZxePwdeembBPPMEApZCEAyav+cANj28CqKQQWuKBuEFcVoMF7x8V8CalQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vVpMQ8aI; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 70EC41A0FC7;
	Tue, 14 Jul 2026 09:16:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2D19660346;
	Tue, 14 Jul 2026 09:16:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9B25A11BD3A89;
	Tue, 14 Jul 2026 11:16:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784020610; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=+igQ6FzMbOLztFG+oaE9DCg38qBYL0qFipuVHL6mZH4=;
	b=vVpMQ8aIRCtPeKC/dS6IOaTvt1L4dVPjdFph3JZii8GgqDGHklhF5hmXhlcPwy56jhHlug
	jk09GLxzL3G/+C2VKRzxIGRX/r3lTKohAGbTQDOsufGfVEzDVyzmiWL6lQ8E8elJ/0pUSq
	jCri259fW7OSNo/lWnFtTjPTHLIc9b56tgJOJ2qYYE2l0g6fJ9wEhBBF84jHnFrhNIdATA
	0vcrihtoTiisjN+JCp3wIUbFqyI2OmX/W8jy6LZVp1wM1S2tAmUtCIwik2fXspXhqXkdUX
	eVulAx37xz/WMGlyRrrdZ71pzPb6w9PKfZgo/hgQ56b2rKHVtAqu0rjWP+VmYw==
Message-ID: <044a9996-1cd0-49c4-892b-fb267037c568@bootlin.com>
Date: Tue, 14 Jul 2026 11:16:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/7] net: phy: phylink: add helper to modify
 pause
To: Javen <javen_xu@realsil.com.cn>,
 "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
 "nic_swsd@realtek.com" <nic_swsd@realtek.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "daniel@makrotopia.org" <daniel@makrotopia.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "enelsonmoore@gmail.com" <enelsonmoore@gmail.com>,
 "daniel@thingy.jp" <daniel@thingy.jp>
References: <20260709100237.541-1-javen_xu@realsil.com.cn>
 <20260709100237.541-3-javen_xu@realsil.com.cn>
 <0c188a7d-3637-4e08-9ac8-c1d824b461ed@bootlin.com>
 <aeed474059bc4fd7b9c5e3074ef591a4@realsil.com.cn>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aeed474059bc4fd7b9c5e3074ef591a4@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307404-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[realsil.com.cn,gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,makrotopia.org,armlinux.org.uk,gmail.com,thingy.jp];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:linux@armlinux.org.uk,m:enelsonmoore@gmail.com,m:daniel@thingy.jp,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:from_mime,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B85E2752BD7

Hi Javen,

On 7/13/26 09:51, Javen wrote:
> Hi,
> 
>> There's a change in the MAC's ability to support Pause, so we should :
>>
>> - Recompute the pl->supported field. Update the config.mac_capabilities with
>> the
>>   new pause settings, calling phylink_validate() should do the trick I think, this
>>   will rebuild the capability list:
>>
>>   phylink_validate(pl, pl->supported, &pl->link_config);
>>
>> - Then update the pl->link_config.pause,
>>
>> - Then update the pause advertising, like done in phylink_setpauseparam
>>   ( I think, everything that comes after pl->state_mutex gets released in
>>    phylink_ethtool_set_pauseparam)
>>
>> Ideally, the logic to update the advertising and re-trigger a negociation should
>> be factored out in a private helper, then reused from both this path (MAC
>> updates pause support) and the phylink_ethtool_set_pauseparam path.
>>
>> Maxime
> 
> Thanks for review and helpful suggestions.
> 
> I agree with your suggestion to factor out the logic into a private helper and reuse it for both phylink_ethtool_set_pauseparam() and phylink_update_mac_pause_capabilities().
> 
> Here is the refactored logic. I want to share this specific part with you for a quick check before I submit v7 patch.

I'm currently attending the netdev conference, It'll take a few days for me to
look at this, sorry about that :/

Maxime


