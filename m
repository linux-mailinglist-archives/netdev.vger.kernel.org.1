Return-Path: <netdev+bounces-275134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE91IGLqz2kG1wYAu9opvQ
	(envelope-from <netdev+bounces-275134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 18:27:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9DB3965A3
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 18:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A93330F0849
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 16:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F6234D3B2;
	Fri,  3 Apr 2026 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMdFZk3Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD902BEC41
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775233031; cv=none; b=qtrg55QAcQuKcKrBr3RTYS4koLqQmR46gLdYTYJmCI4bWyVk9+qpAHpsaOIfiRSnxNQBouP72Y8rTekindWBGdiD/dOU1NpE/hO29OcKIxMQkiJUep/hBNw0SFrCxbw6FJihSzm3ypcNp71UFynIvMILY+O2eDL8h1KxIDdA8Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775233031; c=relaxed/simple;
	bh=dszPWaFvEEgSfOdk090ISCqiTWOzjpJpNLJrnyM2IEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVoFt+l7XaAuVQjUJTSS3AsBZrxnLYrISEdpznz66L21FHMT4w7hYBusp0V17l9+qB8uYhY7w+FTbtE6bCGe//NFZ/oNyCsV+gD++XmFbY7qls7sRtr0q3OIFC/Q+lhb13XIat1PHFqRTA7OWej4YJQjs4YTX9XbSNad0nUW8qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMdFZk3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7670C4CEF7;
	Fri,  3 Apr 2026 16:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775233031;
	bh=dszPWaFvEEgSfOdk090ISCqiTWOzjpJpNLJrnyM2IEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CMdFZk3ZJa7s9RipUHciL5wrHDEiW5PMEiWI1TBXhbZ1yrPTqKP2RIGXbQsI9FFyA
	 qlNxjTbUhJiPo8d8gLqDyL8sxUnTHHSw9JEYnDZLA0htge0fzHG9SZDkVvVSyY4Q7H
	 78PvXLsaItg0GhVQXXsKwe2+8V8YPJL55fcy5+TjGeINGx+6UsGE6CsZAiy9bJKUQy
	 X/nlq15rT2u1TQbP0RhO+xZZhgUG9KYx4dIejCvRHMvGSCe0YMTERJCSYHJg9VI5u5
	 009WgklRQvU9wn7yyV9cRkGGmhPikQ8dECkBwdMPTx7Q2vKadNZIsAV2Lwm21gF8Ra
	 O9VC2Pi3LRT7g==
Date: Fri, 3 Apr 2026 17:17:07 +0100
From: Simon Horman <horms@kernel.org>
To: Kevin Hao <haokexin@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] net: macb: Remove dedicated IRQ handler for
 WoL
Message-ID: <20260403161707.GO113102@horms.kernel.org>
References: <20260328-macb-irq-v1-0-7b3e622fb46c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260328-macb-irq-v1-0-7b3e622fb46c@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275134-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF9DB3965A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 28, 2026 at 06:17:44PM +0800, Kevin Hao wrote:
> During debugging of a suspend/resume issue, I observed that the macb driver
> employs a dedicated IRQ handler for Wake-on-LAN (WoL) support. To my knowledge,
> no other Ethernet driver adopts this approach. This implementation unnecessarily
> complicates the suspend/resume process without providing any clear benefit.
> Instead, we can easily modify the existing IRQ handler to manage WoL events,
> avoiding any overhead in the TX/RX hot path.
> 
> I am skeptical that the minor optimizations to the IRQ handler proposed in this
> patch series would yield any measurable performance improvement. However, it
> does appear that the execution time of the macb_interrupt() function is
> slightly reduced.
> 
> The following data(net throughput and execution time of macb_interrupt) were
> collected from my AMD Zynqmp board using the commands:
>   taskset -c 1,2,3 iperf3 -c 192.168.3.4 -t 60 -Z -P 3 -R
>   cat /sys/kernel/debug/tracing/trace_stat/function0

...

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>


