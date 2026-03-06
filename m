Return-Path: <netdev+bounces-264853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKZqA+LzqmncYwEAu9opvQ
	(envelope-from <netdev+bounces-264853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:33:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA68223DE2
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0145301876E
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 15:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E8A341AB6;
	Fri,  6 Mar 2026 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hZr0iB5V"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD0D36BCFE
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772811214; cv=none; b=GEaSIh6RGDjKNuiQ8spAayP6JTsqPDldwPzfzXV89ThvYw2HU2ISujR+q8cV/wKLpePHdRaLT36Zg1CKJ1PpSYJHWpXGI0sg0E7o/vCvogu7h66HUTF4RcKhec9d7EDxG/1B+OuYLJCPU7jU9jTJJasSsayxyMouj6/ZsNIwbhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772811214; c=relaxed/simple;
	bh=YiXqqHWmefqoQSXj8Opan5TSSiIGJDgwQYjHVOdGuP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TnA64mxOWBAO0usA0zlco8qIxwt60bfLYZzATzdoWXb6ftSOvP0j4C1kpfzHE1i31ZKZr8jjOmLok/isgaSxOSxSRKtBEH4fs1E8a/3nNaMVBJaOTfC4TMemWHaVT3k2c3kW8HyUywQ7HG9GDkJxVq+n5ocGScu0tt5B9UYh8VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hZr0iB5V; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CFEED4E42592;
	Fri,  6 Mar 2026 15:33:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 930225FF92;
	Fri,  6 Mar 2026 15:33:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9762B10369A2D;
	Fri,  6 Mar 2026 16:33:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772811208; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=/nXhRTeVhihY6vsbnPaQHy+Hqs2mX4QAL/NrHpd3jfQ=;
	b=hZr0iB5VTapf4M5T+doeTXT2CNMNh1hCVC6yDoi2FC1cW5RhyJ8eaEgD0aL+OIgnwExBj/
	h3rUQ5BNvV73NLVmslzb3vsxpjZabFRPMK0EKHHnqg/qpBbg2Kx/SD58COBaRUFb8RfmIF
	8TaBagYT3MN6Roc+qRtnHoZa419mk7i0uQaV1CF/izGm+TKEC0Neq0I3lz7iaAhwAIi5yF
	CJymefm1wx3f3lr68kFgzGgVmxwMpqugA5CHIBgaAUcE/9XumihDsC1/hSeulRq9Ar3089
	1097LUsAIRnb19/1N9lszD2/fic3w7k6pk5Bjlk8KEWWUaAYIdscYGb3wqpwQA==
Message-ID: <32aeef59-d8f3-4634-b365-06cc805eff3b@bootlin.com>
Date: Fri, 6 Mar 2026 16:33:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v6,10/10] net: ethtool: Introduce ethtool command to
 list ports
To: Simon Horman <horms@kernel.org>
Cc: edumazet@google.com, davem@davemloft.net, pabeni@redhat.com,
 vladimir.oltean@nxp.com, daniel@makrotopia.org, kabel@kernel.org,
 nicveronese@gmail.com, mwojtas@chromium.org, romain.gantois@bootlin.com,
 herve.codina@bootlin.com, netdev@vger.kernel.org, kuba@kernel.org,
 dimitri.fedrau@liebherr.com, andrew@lunn.ch, o.rempel@pengutronix.de,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
 kory.maincent@bootlin.com, hkallweit1@gmail.com,
 thomas.petazzoni@bootlin.com, christophe.leroy@csgroup.eu,
 f.fainelli@gmail.com
References: <20260304145444.442334-11-maxime.chevallier@bootlin.com>
 <20260306135854.492356-1-horms@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260306135854.492356-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 7DA68223DE2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264853-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,redhat.com,nxp.com,makrotopia.org,kernel.org,gmail.com,chromium.org,bootlin.com,vger.kernel.org,liebherr.com,lunn.ch,pengutronix.de,armlinux.org.uk,csgroup.eu];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi

On 06/03/2026 14:58, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: ethtool: Introduce ethtool command to list ports
> 
> This commit introduces a new ethtool netlink command to expose phy_port
> information to userspace, allowing enumeration of available ports and
> their capabilities on a given interface.
> 

> 
>> +static int port_dump_one(struct sk_buff *skb, struct net_device *dev,
>> +			 struct netlink_callback *cb)
>> +{
>> +	struct port_dump_ctx *ctx = port_dump_ctx_get(cb);
>> +	void *ehdr;
>> +	int ret;
>> +
>> +	ehdr = ethnl_dump_put(skb, cb, ETHTOOL_A_PORT_HEADER);
>> +	if (!ehdr)
>> +		return -EMSGSIZE;
> 
> Is ETHTOOL_A_PORT_HEADER the correct constant here?
> 
> The third parameter to ethnl_dump_put() should be the genetlink command
> ID that gets stored in the message header's cmd field. Looking at other
> dump implementations in net/ethtool/:
> 
> net/ethtool/tunnels.c:
>     ehdr = ethnl_dump_put(skb, cb, ETHTOOL_MSG_TUNNEL_INFO_GET_REPLY);
> 
> net/ethtool/tsinfo.c:
>     ehdr = ethnl_dump_put(skb, cb, ETHTOOL_MSG_TSINFO_GET_REPLY);
> 
> net/ethtool/rss.c:
>     ehdr = ethnl_dump_put(skb, cb, ETHTOOL_MSG_RSS_GET_REPLY);
> 
> These all pass ETHTOOL_MSG_*_GET_REPLY command constants, not
> ETHTOOL_A_* attribute constants.
> 
> ETHTOOL_A_PORT_HEADER is a netlink attribute with value 1 (from
> include/uapi/linux/ethtool_netlink.h). Meanwhile, this file's
> ethnl_port_request_ops structure correctly uses
> ETHTOOL_MSG_PORT_GET_REPLY for .reply_cmd, suggesting the same
> constant should be used here. Can this cause the wrong command ID
> to be sent in every dump response message?

hmmm true indeed, however ethtool did show me the replies. I'll fix that
though.

Thanks !

Maxime


