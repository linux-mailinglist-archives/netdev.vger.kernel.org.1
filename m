Return-Path: <netdev+bounces-267589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLJELqZ0tGmUoQAAu9opvQ
	(envelope-from <netdev+bounces-267589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:33:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D931289C4A
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A836309944F
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581DD29C325;
	Fri, 13 Mar 2026 20:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="nO8a2CeD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F0F18027
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773433912; cv=none; b=Tejo1TY7BScJwqFIM6rgROyAxI/j70vqAcYCqE+j24XNXlCY+C/NVo1qOWq/AbEzZ/bVc8sXX82ukmSV39M+3oAEdWhBCbRLDciFBKeMw5HiFImAo5Ucl3cyGOgqFOLrJEwoimr60saazyPhF8PUypnlggowHuL61kNbXhAzOZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773433912; c=relaxed/simple;
	bh=3nZ6M+FEfD8PlgZEwLClh8SYtEq7DwgwR9EVMrJ6e8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqNeHVu7lIUP2AOjvfKl/keKtVOGIIiupjpiAMjBHQCMNBbiAcRD0vIbn9KahlA2Pmatu72w0lp5DzoSzsctHauMxQT08sFasOIW0fT/WZoQqAsyNvgNqOCd/Vx9Uc63pURvT0Lenvdw7GD6Er/kEx7XTGClAOFzyz7CXGgAYuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=nO8a2CeD; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35a07c4b17dso1182223a91.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773433910; x=1774038710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRHJyuMSqu8nwmLN9Y4FORoeONmtNATza0VZdK2MFcA=;
        b=nO8a2CeDtb4DkiMGvGkPOw6I2dXrupmqCpzRVijONll7qV6xaZ7eG8FuDEP0texX1o
         p+P1KoXrBbyonv1A9+P7DegaeLsIFXyZpEA5jEe9RQJjqsEidiWWeQtQcAZCV8LGkfSJ
         kgQYd/+Q11GK9h8hfCUlbTCODjvrK2NTN7D61hM+ELTnAvOKT7JLZo63g61La7x0kWsP
         3VhJ4S3PfPmmMJ0Wn+EIuOXflVXg27NyH13oyfBN0FofShL89yBeibFEIJ27GvHDND4J
         21VyPAC7S9AqrQrYmFAhZ2SvupzkQOGvTnjP279EVA8qZetf2+FdAwc8Fwvmsduq7EgH
         +bcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773433910; x=1774038710;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRHJyuMSqu8nwmLN9Y4FORoeONmtNATza0VZdK2MFcA=;
        b=N6sHdrs0M8J0ve5MlPyQNkwFyH+T6aZcV/GZDyH089QgrAZ6xPKB1Qaqn1B7WRsnvL
         sEXqn9pnyddto9MnRVZo4EoKubM6I192MA7xYe+4T6LxzlnPPTAT6nUqvTRDbBnaS3Rx
         LjzR1UHpktlGP01GxTwIx9Hm0z0KJdDuuKkRSapoeNZSui/CmetYfz+Yv+xJJEG7ng4b
         5cDQvdg0xtmxkYUM26FmGr7ZbUo2Dkk62gPUa/mu/0AMRQQOlUCh5Ef6RM4YtYKwT9Mg
         OPYzbzNT2pCvDAn0a6BqRkvi2ZTENlJLrftm9XA3EN5778Zuv7nQEc0wMKpgRk5+Jk7q
         ypEA==
X-Gm-Message-State: AOJu0YwJxu3blFJtfGsQEdloTP1PUVOoy3I0RMVmwZePqId2wVmI1Hcf
	OVF99LXmtrBzvyWIjq40eohwDkUPGDo1fI68PvjxEopdK/r6GVUmPopWTPmHADASyBQ=
X-Gm-Gg: ATEYQzxL1efr7GHQNd42i3NY/zZzpIMzKyy+yh6W3siMXOYprZ3qQGyLKWzr/gyS5WV
	+b51I3qDIgOILmR7UmPFTQABQ6JU0njq00A0BvL5e0yJBu64ej8Fsxd/ixoWryLYHwsNpUuOlxp
	b7fbnTsdcW4G8YAY1fN6fjTjPs9O0T1RuldKaiGKFNoqo+VGdSyEGSq1mHq6rzhJuUbtSvgWLyC
	fTWch1s4TO51HkRwlt8LgOBSpqA9BmTWJn6DR5fYBWGrUbrkr6ifdx+jfG4pF8BAmfTal0l06It
	evVERACap8K/97cNHLQIYBFfuJxFTA7flra55YIsyJpgBS6aZpPpzY4O8s2696vkoM4MGk8wP64
	AQ6Yb/dbN1Dqtx7CXrnIa91CFS1gj/7dVKKuExYQb9O48UUUrIfKomaJgiF7mria8WioyUAppce
	OVkXW7eLp7fqc=
X-Received: by 2002:a17:90b:4ace:b0:359:9bad:13d9 with SMTP id 98e67ed59e1d1-35a21eb1b9dmr4226225a91.15.1773433910565;
        Fri, 13 Mar 2026 13:31:50 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a0bc58b44sm7670770a91.3.2026.03.13.13.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 13:31:50 -0700 (PDT)
Date: Fri, 13 Mar 2026 13:31:49 -0700
From: Joe Damato <joe@dama.to>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] octeontx2-af: CGX: use kzalloc_flex for name
Message-ID: <abR0NRpkL+3yPIIC@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, Rosen Penev <rosenp@gmail.com>,
	netdev@vger.kernel.org, Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20260313003240.123975-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313003240.123975-1-rosenp@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	TAGGED_FROM(0.00)[bounces-267589-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,dama-to.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devvm20253.cco0.facebook.com:mid]
X-Rspamd-Queue-Id: 1D931289C4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 05:32:40PM -0700, Rosen Penev wrote:
> Don't bother allocating separately. There's no good reason to do so for
> a small string like this.
> 
> Remove name kfrees as a result.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/cgx.c     | 13 +++----------
>  .../net/ethernet/marvell/octeontx2/af/lmac_common.h |  2 +-
>  2 files changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> index 4f33a816bc7a..0750fb696c90 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> @@ -1725,14 +1725,10 @@ static int cgx_lmac_init(struct cgx *cgx)
>  		cgx->lmac_count = cgx->max_lmac_per_mac;
> 
>  	for (i = 0; i < cgx->lmac_count; i++) {
> -		lmac = kzalloc_obj(struct lmac);
> +		lmac = kzalloc_flex(struct lmac, name, sizeof("cgx_fwi_xxx_yyy"));

Seems fine overall, I guess a minor nit is that I thought the typical style of
kzalloc_flex usage would be kzalloc_flex(*lmac, ....

idk if it's really worth a respin just for that, so:

Reviewed-by: Joe Damato <joe@dama.to>

