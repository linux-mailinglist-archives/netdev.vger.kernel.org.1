Return-Path: <netdev+bounces-277028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KoiDiK812l0SAgAu9opvQ
	(envelope-from <netdev+bounces-277028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 16:48:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BF03CC308
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 16:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9ECA230125BF
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 14:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FE62C0F81;
	Thu,  9 Apr 2026 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hct1Ub0c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8072E8B67;
	Thu,  9 Apr 2026 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746014; cv=none; b=EEGM+VyBvf3ys2P16d793djWN5THC3/xnrKErzPVFtjxlvfJfvDm9I7mo8m61sxbgtrbsCx0LFkJIrH3s6btxEVN31ieqEqTOOl6dQvc27zoa8sgEO9pwxUsVaoYXccycO7TEi9DOM4sWP/ukJha9g2n5yI0EdCgY/qQOi78btc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746014; c=relaxed/simple;
	bh=MWRPvqWJE3xA2jJ4RD9qh5JQEBLPLrluDPO+EOqmsyU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sv3Pq+E+T2aVAzIdZ8KEOkPoKDDorcRuZ4SwGD9hB835I6Scm/I2ZRnLjTn519HNDQI+I1xJJ2lwOlT8wbT0GQdF+H9nxce/Ajw/Mn4uMTa8TuUicr6m1ifngIHkXmWp3/B9wC4i5K9iXzoCsX/LkVgiYR866/5nEXaKP8YXFSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hct1Ub0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0620AC4CEF7;
	Thu,  9 Apr 2026 14:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775746012;
	bh=MWRPvqWJE3xA2jJ4RD9qh5JQEBLPLrluDPO+EOqmsyU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hct1Ub0cUqGtcoDmroWTiH9bQTyxS0NmRBoS9S2fQsDOfQVvVaOyoDBqKduJlkNLM
	 PvP7ah94baRd9SYPjM042a/d9WZizYNn0YCxPhMxTfQ4II5pdefm4yM4hJkXSN81OT
	 sploUQ5KcsitLKWIWqIKeaKXJTG5eUDcF57DNTVrF+S+4PBKomZUTGvUkpwkUgwlTE
	 qA6LwFZkZxESWmMLike75gMvhkB0bbjXKL9eJTpsFh7SE3ATOqjFgWeaVMsvNcvO0H
	 w1Oh8v8pnusJQoebbIxLSWD8fzVRQ7I+8+y4n9QXab8X6Q5/SN2poTWrF5b9MJwLTU
	 TRK9DOM0udX2Q==
Date: Thu, 9 Apr 2026 07:46:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v11 03/14] net: Add lease info to queue-get
 response
Message-ID: <20260409074651.2e58b3dd@kernel.org>
In-Reply-To: <5a5feea9-7675-4ccf-aa8e-3a2e476ce8f5@iogearbox.net>
References: <20260402231031.447597-1-daniel@iogearbox.net>
	<20260402231031.447597-4-daniel@iogearbox.net>
	<20260407204017.3fc79d1b@kernel.org>
	<b9a046f8-cb02-4d54-9a7e-e8213339d720@iogearbox.net>
	<20260408151251.72bd2482@kernel.org>
	<731d2749-abf6-403c-a1f4-ffe9c8d1e8ad@iogearbox.net>
	<5a5feea9-7675-4ccf-aa8e-3a2e476ce8f5@iogearbox.net>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277028-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,davidwei.uk,bytedance.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 33BF03CC308
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 9 Apr 2026 15:52:42 +0200 Daniel Borkmann wrote:
> >> Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> > Thanks for looking into it! That looks good to me. I've also retested that
> > it still works.
> > 
> > Maybe small nits could be below to move the netif_is_queue_leasee into the
> > netdev_rx_queue.h header since its used outside of core and it might be
> > worth to also have the lock assertion in netdev_queue_get_dma_dev.

I suspected it may irk you :) No strong preference on the placement.
We do include the ../core/dev.h in a couple of places but agreed that
it is slightly ugly.

> > Do you want me to add your patch on top for a v12 of the series?

Yes, please. Let's get it into 7.1. 

I think the test has to be reworked but of the available options seems
like merging it as is and following up quickly is the best. I've only
set up the container testing in our CI yesterday anyway so there may
be more things that need changing in the test as we gain experience :S


