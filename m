Return-Path: <netdev+bounces-172710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 738A9A55C49
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4523A3C76
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721587DA8C;
	Fri,  7 Mar 2025 00:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrpItbRe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409DB1E868;
	Fri,  7 Mar 2025 00:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741308915; cv=none; b=h522Np4KPooqJhkgXZq5UstIp+LGhOHwsbVO/pTBVFsljBBGUw+c+7Zuj8BMdHciO+RLjRXYKrh7mYjmKUoeXxmpkjlSgn1D1jQY7iIvCJWdKO4xAgSLNT8Daf/iTthNG7MWYep3WKQxEOIYH1F0JBSRBbe6Pn3PKOefxawaC7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741308915; c=relaxed/simple;
	bh=xek2BHPVZ26qJOlIwvynXxMSgyWkeMn3liBIClkp3lI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4/yeyKO0VJek+5gHXcoMgDrY5yItiqfROE7NagW4d4MxElJMYZ402ivbKa+hpj0gW4sgNtEgLXwtPDjU3Hq+etqF7HluTxI0Z5a29tDREduUGT5MlnQ458EPWwYfQBpJxd/dbAXQLWA0lwhZszSkFHvKOyAXIEVJisQ3D1gRB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrpItbRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F97C4CEE0;
	Fri,  7 Mar 2025 00:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741308914;
	bh=xek2BHPVZ26qJOlIwvynXxMSgyWkeMn3liBIClkp3lI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QrpItbReJvXV4f5NgW5mLT6raAXR9ILcWXRqNJek5KIcTTvGN4K/B/vomAxa0s7LW
	 u4aZDEn0nSrDXhaoRTqiVXvn3VaThme6YX8s6fmORw6eDBPiM8AqInegTSJnIygUbN
	 kmkzeTMC5o/97KmCJg36JTQAlrvaMcAxFirIDLb5xVmPAOJVe3jVwL0fCb3/QRj3A+
	 wH5k2Okk0ScuJX1DrWC0/L8AYVJCKq8PdMiLFuNuJ8B4IhoS4LvwUN5iu2xUu8z5hV
	 86lbzUFCHlPP2SMdOd/H4zSLjWAQwKdWKWfq348B2QMnnbe/oMlMH5KgNaN3ZRDPCA
	 yO7SLVnzsbOzA==
Date: Thu, 6 Mar 2025 16:55:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Meghana Malladi
 <m-malladi@ti.com>, Diogo Ivo <diogo.ivo@siemens.com>, Lee Trager
 <lee@trager.us>, Andrew Lunn <andrew+netdev@lunn.ch>, Roger Quadros
 <rogerq@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Simon Horman
 <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>
Subject: Re: [PATCH net-next v2] net: ti: icssg-prueth: Add ICSSG FW Stats
Message-ID: <20250306165513.541ff46e@kernel.org>
In-Reply-To: <20250305111608.520042-1-danishanwar@ti.com>
References: <20250305111608.520042-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Mar 2025 16:46:08 +0530 MD Danish Anwar wrote:
> + - ``FW_RTU_PKT_DROP``: Diagnostic error counter which increments when RTU drops a locally injected packet due to port being disabled or rule violation.
> + - ``FW_Q0_OVERFLOW``: TX overflow counter for queue0
> + - ``FW_Q1_OVERFLOW``: TX overflow counter for queue1
> + - ``FW_Q2_OVERFLOW``: TX overflow counter for queue2
> + - ``FW_Q3_OVERFLOW``: TX overflow counter for queue3
> + - ``FW_Q4_OVERFLOW``: TX overflow counter for queue4
> + - ``FW_Q5_OVERFLOW``: TX overflow counter for queue5
> + - ``FW_Q6_OVERFLOW``: TX overflow counter for queue6
> + - ``FW_Q7_OVERFLOW``: TX overflow counter for queue7
...

Thanks for the docs, it looks good. Now, do all of these get included
in the standard stats returned by icssg_ndo_get_stats64 ?
That's the primary source of information for the user regarding packet
loss.

>  	if (prueth->pa_stats) {
>  		for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++) {
> -			reg = ICSSG_FW_STATS_BASE +
> -			      icssg_all_pa_stats[i].offset *
> -			      PRUETH_NUM_MACS + slice * sizeof(u32);
> +			reg = icssg_all_pa_stats[i].offset +
> +			      slice * sizeof(u32);
>  			regmap_read(prueth->pa_stats, reg, &val);
>  			emac->pa_stats[i] += val;

This gets called by icssg_ndo_get_stats64() which is under RCU 
protection and nothing else. I don't see any locking here, and
I hope the regmap doesn't sleep. cat /proc/net/dev to test.
You probably need to send some fixes to net.
-- 
pw-bot: cr

