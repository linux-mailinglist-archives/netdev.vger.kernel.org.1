Return-Path: <netdev+bounces-254906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPyrMj26e2llIAIAu9opvQ
	(envelope-from <netdev+bounces-254906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:51:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA7EB4186
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFADB300DF48
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 19:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E9B329E67;
	Thu, 29 Jan 2026 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="ITSyv0aF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D462F6562
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769716278; cv=none; b=DF8yB2XHuDrcwV71wkmugfvQsmsbfZ5iGxEK09Nd4sZHx6ijGLcsGqbFCbU35r521RTNSMs4d2oV9wgp6lBVDzWXhVI1mC0Ekh3zbUnbfYHwxMshXavOzKj25v5nVN0BYx/9Jvdh0ap5yGv/HXtbpAovUT7HmaV01l2JbVXSfL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769716278; c=relaxed/simple;
	bh=kz/UmQnF/kQZX0padhdk52aftyV/7o2JgBiZXIT2EDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ST32aopfMpmKFFsnSD20zmImQ3qNWvI6vS9K+6wagcBF2d1owSDQfZ53kt1djPjDJA9roysx+XqGl8xw8BLLedkz3ZxAe1DKoFjhChhBsbcsdFNqtkjdhXc/kSPiUqnzmDun1o6l6I3kPRhGVWa3DGYMOQs0zQd9rvnMtJjPwdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=ITSyv0aF; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-81e8b1bdf0cso815285b3a.3
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 11:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1769716277; x=1770321077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnxwsZAxF8STswOuh2vgfeXNVDToeemAzI/Ew3hWeYM=;
        b=ITSyv0aF7wrRfDHDdQ3a62ddXHRJYVwLBxKF6kH65YqZ/XtdRaYTJLMdikeVBXLd+S
         Z8hQ7W3do45qhiWOkAzbUe6wFpkMKYV5zwVfk/jzvsnYsD59QPdMwBEAmO8S1Rx+QsT2
         CFJECTtRZEkyAlGkYcsKzn++zrZUJSnHIXpwFLDDoN5YNl8/xsxyJo99WIG2Mojo7BHl
         p4kjZM654Vkf42b7/DFutFgH+kFklcf2Z1FQN98RZM7XnA2rikToOD+pgcNMo8T5NE13
         NtyesdcZii/47aFK4dALYPyY1rujf0zk0J0HeqKedfzoeHCD6yrxde6vML1fzLCeef/g
         Zzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769716277; x=1770321077;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnxwsZAxF8STswOuh2vgfeXNVDToeemAzI/Ew3hWeYM=;
        b=QXkDUHAb0CfpT21UxF0jvVfiuwikFwPo4Z72IHJ13IAYztx7tYocacsTZvcpxJPrq+
         bfFZSp/Fso3htgxWLLLN1266Pms2VYfHQbQlVExu0OKBh1+zF2svpUUpYETsLw0aZqkG
         9YW7WtYPsY/8Vqp3IafgnXUaeysqe3eE8svFl3aRL8eRuLsRtC1gHI7Cp0kiHMrxnOQ3
         I4MlYZh60zrDheF9VnnlYnNsyp3XtkkTptAZPVj0/NDZ0IOGaRNf0mW7sL3nx4R+jrqp
         4uqJTxQ1g0hten95gvP4qJxoHRA7OkUaHnJXdpsKBMyf4652fIU7wJCnigNfViyGlykf
         UBxA==
X-Forwarded-Encrypted: i=1; AJvYcCUUkXwpNrwp0Yr3BEZa7lCExCsc83mulFBHFQhzl7Xyn6IYHFq+WeG+IxN4umb8mlZoEZWU0Sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbHpEeo4MPVBAwMrW4M7B0wuZQ+81qpClu42BAf/zWi9UHm3np
	/jHwYoSqCOFU3CK5hjydLtWmXeHLjOS9v09RXgXgXcqH+4Dff2NiC+rGggTUxAa/IUo=
X-Gm-Gg: AZuq6aIQbS5jUR9owIGfX6NjnQ8lY16uPceejqn1FfuBxQXsKloaMUSwDDSmRKNOTq/
	ugQqTuhbl2TgaQFoShmmsxjGmgSiRxYZBiLs5cM1lDjiuLLNWRYxSCKQ4cA+Yjdot1lbJTn1zxT
	DAbqoBJvjY1cAbZ6ZCQnnBeaF3kjj5Lmj4D92gXvm+0G1y8u+doh+h2gr9Jh7H8Scw7qwQPvsmQ
	S16YdbNNv0WUOLYA0qu2hNK9r+JbR7us0P7D14vQ9aRNbjSegBCKtocQir4b+FN85r21X6suZHf
	nxump+0j2D5nk7kHMODBhjEzPUenVxn8ZC7sOBZdqnQT/0S3BifMWntsIPb7a87XYp03lgcYhy4
	4/vFOlyWbtPu1qAR0TSzRbfHnFYb4wkO0xneB4drzQB4Mu+X06kZRhtU0p0GPAV+XIdyR6irHo0
	NkTA==
X-Received: by 2002:a05:6a00:3d42:b0:81e:dcb2:52cb with SMTP id d2e1a72fcca58-823aa3fd50dmr448408b3a.2.1769716276774;
        Thu, 29 Jan 2026 11:51:16 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c54d4dsm7133424b3a.67.2026.01.29.11.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 11:51:16 -0800 (PST)
Date: Thu, 29 Jan 2026 11:51:15 -0800
From: Joe Damato <joe@dama.to>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH net-next] net: stmmac: spelling corrections
Message-ID: <aXu6M3BKyDhJIXIx@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-sunxi@lists.linux.dev
References: <20260129-stmmac-spell-v1-1-c7df9a96e482@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129-stmmac-spell-v1-1-c7df9a96e482@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254906-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,pengutronix.de,sholland.org,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim,devvm20253.cco0.facebook.com:mid]
X-Rspamd-Queue-Id: 1FA7EB4186
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 05:35:03PM +0000, Simon Horman wrote:
> Correct spelling as flagged by codespell.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c        |  4 ++--
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c      |  4 ++--
>  drivers/net/ethernet/stmicro/stmmac/dwmac1000.h        |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c    |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/enh_desc.c         |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/mmc_core.c         |  4 ++--
>  drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c      | 10 +++++-----
>  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c      |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c |  2 +-
>  10 files changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

