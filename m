Return-Path: <netdev+bounces-287354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KB66MdjOA2p6+wEAu9opvQ
	(envelope-from <netdev+bounces-287354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:07:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2939452BBE4
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB1AD3061CB5
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 01:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81567356A0A;
	Wed, 13 May 2026 01:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAx04tkf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF18351C11;
	Wed, 13 May 2026 01:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778634393; cv=none; b=h1BIOjbBZrn764HKS+5GxJmreRvlmbBg/sip0VFzMSJc8BwFVqleGE0Vyuc+C2OBAuu/R3rhR/BVzJMQqSzr+LFBhn0nhOhRasIwuh4j3QMd/84Y9+VRQGEBl2r+coCpwCbZDddtxMgE2doKoSfetO5PTsc3H0GdWwFsjYezRjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778634393; c=relaxed/simple;
	bh=MKOlR0CS3ivkFfr1AO1Gtey/K8HXVBOdoGLufg3xubs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kEoGzk9k4U+gawM1C61sum2CKmVz9ijIGaanXhyVcurQoGIL3RTVwxT1JRwIpeT6tTXeg/4INrQBdfAAuM8rExFdpeEhRVQi2WL+5GPURJ3IZGbvfHuQtfY4s9M+Cqop7sy859fZILjbGLI4sRL+BAZMWApap7XyhVXkh7IYvAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAx04tkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284CFC2BCB0;
	Wed, 13 May 2026 01:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778634392;
	bh=MKOlR0CS3ivkFfr1AO1Gtey/K8HXVBOdoGLufg3xubs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fAx04tkf/FHbPYi/qDBrfLNYm+w9oJ4d6nWQ+Bo9qK3gfolr5egFeaGNCbXl3oGvi
	 SXiZEMATuoK/IiIBaVbQS2X4lUpb9dsruxwrPR8AFLZITs5Zh0eLXqV2JCllGFh0E5
	 qzVHnxeyTMNbL6RNiYWddSoLRrvzmH/JHW1Ha+zyCQ3vDuJunsl+jC3jwZvwNkmSq9
	 F4YFET69k1rAgYK5ek//PZD3d/Xl8nZCr+QhuRkc48Fh9V6epPUs1hLU65i/cKfcrg
	 wl9VUNx05HlSXBaG5Fy8Iq2sh/LxSCV87lmT23QqtnT8l277jrxOaOI9OeG9O+GMj2
	 GishuMiukiPwQ==
Date: Tue, 12 May 2026 18:06:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] FDDI: defza: Sanitise the reset safety timer
Message-ID: <20260512180631.7c50adff@kernel.org>
In-Reply-To: <alpine.DEB.2.21.2605061216430.46195@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2605061216430.46195@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2939452BBE4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287354-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat, 9 May 2026 22:04:50 +0100 (BST) Maciej W. Rozycki wrote:
>  		case FZA_STATE_UNINITIALIZED:
>  			netif_carrier_off(dev);
> -			timer_delete_sync(&fp->reset_timer);
> +			timer_delete_sync_try(&fp->reset_timer);
>  			fp->ring_cmd_index = 0;
>  			fp->ring_uns_index = 0;
>  			fp->ring_rmc_tx_index = 0;
> @@ -1018,7 +1018,9 @@ static irqreturn_t fza_interrupt(int irq
>  			fp->queue_active = 0;
>  			netif_stop_queue(dev);
>  			pr_debug("%s: queue stopped\n", fp->name);
> -			timer_delete_sync(&fp->reset_timer);
> +
> +			spin_lock(&fp->lock);
> +			timer_delete(&fp->reset_timer);

Noob q, why use timer_delete_sync_try() above ?

