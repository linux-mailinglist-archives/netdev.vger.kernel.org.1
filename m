Return-Path: <netdev+bounces-304242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TZtACrGsRmqlbQsAu9opvQ
	(envelope-from <netdev+bounces-304242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:23:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F146FBFCE
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:23:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b="Kc/AXq//";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304242-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304242-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48E52315CDC8
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 17:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A0F35AC1B;
	Thu,  2 Jul 2026 17:30:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B868E3090F5;
	Thu,  2 Jul 2026 17:30:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783013458; cv=none; b=mzx6lXrEGrHUbSh74jkqycmoKOnuVaItYMdl0VHuQ3SrWWIqYTyNQ3qDefmFsegSjKWtqcmEhoKnHgFG7Azv9FivQd1vNRKRhuNXyPxHOpikXUsu+C1oHaqhOydQ2i305vIYWlmtn5beGCM8o/3Kil55LpdM/7WfwJlTqvbc0pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783013458; c=relaxed/simple;
	bh=GOLu9EwugKwD5dHd/BXtOeFYvm1vRZTvHK3DBcGINDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2qVrywqRIySuraN7bJIKhdj7Qco3BjZzQYnd4HcVfJHutKQWVRuLn6QvCkP5jdLQs9hu3LdR3OijN/c+1VATEZGRspQ0Dxxh0EQhIX/1S61Pe9XJSyQ6njalwk7RuZp0mlu12eJjRHvT0kPyN009DFs6czosdPmGd5ujz9M3f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Kc/AXq//; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9DA59C4FEE7;
	Thu,  2 Jul 2026 17:31:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F2B02602EE;
	Thu,  2 Jul 2026 17:30:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 90FCB104C958B;
	Thu,  2 Jul 2026 19:30:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783013447; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=nqmuPPmfP9VFcLThHSDeBnpXUiiV8nG4V34GV0c7hOk=;
	b=Kc/AXq//tuSUAOD406+lAEEvx3VeHJAeHfcb4ALztzre2D+frAtf/I9C8kI5ykr6SF4pX3
	t7zLeeL/l4zixdSRttiAuF9YAtkQ5hiy22Uf5zn9epnwzhpVxJMKg0uxtsgwtsEEtwsMav
	O4JKcL2oVvBd9siz6dqEeUE3qf6bnnUaiIhDU2x0uHEvmFfwgcVVn3V4kAqosy1fnYUVck
	SA9jk5Z8+R6OWunRDah0pF4wi98UWDkdhvt0dSdjB52eeZOE8jDqVd+E7JcO2GYU5lqdrh
	qfnTzmPblF7shcNYUFTE+7DtEUERRUPfMZ8BVIady+0xAyOsNBOZDPySMExAWA==
Message-ID: <7576597d-6910-4d58-95b3-28ca64f42b57@bootlin.com>
Date: Thu, 2 Jul 2026 19:30:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 07/14] net: enetc: differentiate phylink
 capabilities for pseudo-MAC and standalone MAC
To: wei.fang@oss.nxp.com, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
 xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, wei.fang@nxp.com, chleroy@kernel.org
Cc: imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
References: <20260702025714.456233-1-wei.fang@oss.nxp.com>
 <20260702025714.456233-8-wei.fang@oss.nxp.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260702025714.456233-8-wei.fang@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:wei.fang@oss.nxp.com,m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:chleroy@kernel.org,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-arm-kernel@lists.infradead.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304242-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88F146FBFCE

Hi,

On 7/2/26 04:57, wei.fang@oss.nxp.com wrote:
> From: Claudiu Manoil <claudiu.manoil@nxp.com>
> 
> The ENETC pseudo-MACs are proprietary internal links that do not
> implement any standard MII interface, so restrict their supported PHY
> interface modes to PHY_INTERFACE_MODE_INTERNAL only.
> 
> Since pseudo-MACs can operate at any speed between 10Mbps and 25Gbps
> in multiples of 10Mbps, set their MAC capabilities to cover the full
> range of standard full-duplex speeds: 10/100/1000/2500/5000/10000/
> 20000/25000 Mbps.
> 
> For standalone ENETC, expand the supported interface modes to include
> 10GBASER and XGMII in addition to the existing RGMII, SGMII, 1000BASEX,
> 2500BASEX and USXGMII modes, with MAC capabilities up to 10G. MAC_1000
> is replaced with MAC_1000FD to explicitly exclude 1000M half-duplex,
> which is not supported.
> 
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


