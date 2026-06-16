Return-Path: <netdev+bounces-299862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 37N0HSFYMWpdhQUAu9opvQ
	(envelope-from <netdev+bounces-299862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:05:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C639A69035A
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:05:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IFaeXyhR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299862-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299862-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 559DC3024971
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D930528640B;
	Tue, 16 Jun 2026 14:02:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B543328FC
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 14:02:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781618535; cv=none; b=Liep5+ZDt6KW6CW3sWWrSr6//fBBEUy/Au+mIWBMvSBZW6lXFlUTCgfC6Tc17pC35NZg/Fvz1k4rjpJQf0jSz2kA/Qk4SMth0rO9gQWQmcUhY2wDbwWxUjLJZRUethYfLc7OXdrjR+AWpmAZHerBaaiy52pILUNSzxM2Wsod2c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781618535; c=relaxed/simple;
	bh=Gd9q8wjKBTahx8WZncyILkvuRQkf0BqNHTBqV+puh1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/yvCGltijIRbueOdYezo9lCBb7nnFGldepETd4Lr9HeJNByK7yBzIl02+r7zNg+TlJYgsIIq7e1rFCnZSXD7ss4l9/aWxJxADBX8zkgOofs6q97fqlvgqzEws7cSQB3FrhLl+b71S11zcELbVdhe44bF0gn1+hPGFvQjiyS42Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFaeXyhR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CB61F000E9;
	Tue, 16 Jun 2026 14:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781618533;
	bh=eEpsFP/xXpUPXqRf7uvxwII+CqHgphXobFe5PBEJlno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IFaeXyhRPGrBUQBqCVYlNH7iAweOxU5c1t/1ev/pwXEUnVcWauzsDZEsMzRZb6CHG
	 EdxPI6Rxg1cFf6j0V/wcAioluDrgwaZp8rXapY6LHqMnmsIql2lZWjNjrXiW2PZFUy
	 Byn5ojJn5QQ6J63L72udHlH7idKNw9dDcgnNtNepmepQKhUrunAcEtjJps80FqMyjv
	 6QAsSNedSJ0x2p19ddyJDmOQyhjOL/NIx2QLQFQaLWf7lBEi/4ibn0d2Ix4/NMsEZy
	 D+FJCwLanFgh2IwJsz7Vkp7DC7Szc+RLT0nOd1KRx5bh+r8iMyXJV20yP4ZEL/8FI0
	 RC21UYKnsGWRA==
Date: Tue, 16 Jun 2026 15:02:09 +0100
From: Simon Horman <horms@kernel.org>
To: Yinhao Hu <dddddd@hust.edu.cn>
Cc: netdev@vger.kernel.org, David Heidelberg <david+nfc@ixit.cz>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Dan Carpenter <error27@gmail.com>,
	dzm91@hust.edu.cn, hust-os-kernel-patches@googlegroups.com
Subject: Re: [PATCH net] nfc: pn533: prevent division by zero in the listen
 mode timer
Message-ID: <20260616140209.GU712698@horms.kernel.org>
References: <20260615103547.1599528-1-dddddd@hust.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615103547.1599528-1-dddddd@hust.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299862-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:dddddd@hust.edu.cn,m:netdev@vger.kernel.org,m:david+nfc@ixit.cz,m:krzk@kernel.org,m:kuba@kernel.org,m:error27@gmail.com,m:dzm91@hust.edu.cn,m:hust-os-kernel-patches@googlegroups.com,m:david@ixit.cz,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,ixit.cz,kernel.org,gmail.com,hust.edu.cn,googlegroups.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,nfc];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C639A69035A

On Mon, Jun 15, 2026 at 03:35:47AM -0700, Yinhao Hu wrote:
> The listen-mode timer handler advances the polling state machine through
> pn533_poll_next_mod(), which computes:
> 
> dev->poll_mod_curr = (dev->poll_mod_curr + 1) % dev->poll_mod_count;
> 
> pn533_poll_reset_mod_list() clears dev->poll_mod_count without first
> stopping that timer: pn533_dep_link_down() deletes no timer at all, and
> pn533_stop_poll() uses timer_delete(), which does not wait for a handler
> already running on another CPU. When the handler runs after the count
> has been zeroed, it divides by zero:
> 
> Oops: divide error: 0000 [#1] SMP
> RIP: 0010:pn533_listen_mode_timer+0x9b/0x110
> 
> Delete the timer synchronously in pn533_poll_reset_mod_list(), the single
> place that clears the list, so the handler can no longer run past a reset.
> Also return early when poll_mod_count is already zero, covering the window
> where pn533_wq_poll() re-arms the timer just before a reset.
> 
> Fixes: 6fbbdc16be38 ("NFC: Implement pn533 polling loop")
> Signed-off-by: Yinhao Hu <dddddd@hust.edu.cn>
> ---
>  drivers/nfc/pn533/pn533.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
> index d7bdbc82e2ba..88df99001b4a 100644
> --- a/drivers/nfc/pn533/pn533.c
> +++ b/drivers/nfc/pn533/pn533.c
> @@ -951,6 +951,7 @@ static inline void pn533_poll_next_mod(struct pn533 *dev)
>  
>  static void pn533_poll_reset_mod_list(struct pn533 *dev)
>  {
> +	timer_delete_sync(&dev->listen_timer);
>  	dev->poll_mod_count = 0;
>  }
>  
> @@ -1235,6 +1236,10 @@ static void pn533_listen_mode_timer(struct timer_list *t)
>  {
>  	struct pn533 *dev = timer_container_of(dev, t, listen_timer);
>  
> +	/* Polling may have been stopped while the timer was pending. */
> +	if (!dev->poll_mod_count)
> +		return;
> +

I am concerned that access to poll_mod_count is not synchronised and thus
this may not work as intended.

>  	dev->cancel_listen = 1;
>  
>  	pn533_poll_next_mod(dev);
> -- 
> 2.43.0
> 

