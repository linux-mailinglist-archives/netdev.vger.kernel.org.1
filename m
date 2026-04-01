Return-Path: <netdev+bounces-273863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHwJNNOJzGlXTgYAu9opvQ
	(envelope-from <netdev+bounces-273863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:58:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5097037413C
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BF673000731
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 02:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0998636DA03;
	Wed,  1 Apr 2026 02:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyERTVl8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAFF340A47
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 02:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775012042; cv=none; b=AudPFnPRi92zJkXDEXVimhcEqyGTv776WnP4E0I/Hb0J5GxLTrBcJEatjSZHxnfbHk3iO8EM2ObgpHUb/XPsMA/fg5sk03QqJIR6XgLokU8vAltCEJqQion00JA33Xbm8PxZl8ceGzjS+hFBIU48MuJzGGBFNANEpmlCgI9eM40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775012042; c=relaxed/simple;
	bh=24ImIpsLbbAjAX83JfcdZI3Nv0rc4AJg8E6AGIP+RZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S2QnVxPYznGcDK3hStVmlcac2DjHKHM1rtg/ThlQy1cIbeujh3jbKm2h/Zz5COyxxEQnM5q/XrtYu+W3IVaAa9lgviuGXLkDbQEymYBrwMvaKvvIktdyc+7vn0r4nUzyvwRzp6qb61KsTzUDJob5KHukck4Yuj/yzkQtueYJ8RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyERTVl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB60C19423;
	Wed,  1 Apr 2026 02:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775012042;
	bh=24ImIpsLbbAjAX83JfcdZI3Nv0rc4AJg8E6AGIP+RZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uyERTVl8E9psVyEUhUOqeO1/QbrCh3m7OXj7f6YyxyoGHDXP29uwt6TR9uA2ckB7B
	 p9vsJSMjLiAl2tIkHU+qisr2Uqhu+ihLNxTjCx4+G5E/n+Bio87G/uZvwchoo2gCKw
	 msSOOWRgi+/4PKwf+fCHQquBbjN/iTl2Frehp9oLpAwuexJfAgvqg8TU5Om9hM8eRO
	 fVWPrajOj8Ck/dg5vLhsK0gVckSJs1h9DOaTrvd+xc5+djq0TlpsUfF0hpad06G6JE
	 Ge4FSFlKyp7vs8mC7fzVY47rXjJPpFFOoimjLREK6IN8owUNVRUJPSmH/OhEiMhTV3
	 LLfLlwfJMlUQw==
Date: Tue, 31 Mar 2026 19:54:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kevin Hao <haokexin@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: macb: Consolidate
 MACB_CAPS_ISR_CLEAR_ON_WRITE checks in IRQ handler
Message-ID: <20260331195400.16bb697c@kernel.org>
In-Reply-To: <20260328-macb-irq-v1-2-7b3e622fb46c@gmail.com>
References: <20260328-macb-irq-v1-0-7b3e622fb46c@gmail.com>
	<20260328-macb-irq-v1-2-7b3e622fb46c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273863-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5097037413C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 28 Mar 2026 18:17:46 +0800 Kevin Hao wrote:
> Currently, the MACB_CAPS_ISR_CLEAR_ON_WRITE flag is checked in every
> branch of the IRQ handler. This repeated evaluation is unnecessary.
> By consolidating the flag check, we eliminate redundant loads of
> bp->caps when TX and RX events occur simultaneously, a common scenario
> under high network throughput. Additionally, this optimization reduces
> the function size from 0x2e8 to 0x2c4.

feels a bit subjective TBH. An alternative improvement would be to
factor out the conditional to a helper:

static void macb_queue_isr_clear(bp, queue, mask)
{
	if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
		queue_writel(queue, ISR, mask);
}

I'd like an ack one way or the other from someone before merging this

