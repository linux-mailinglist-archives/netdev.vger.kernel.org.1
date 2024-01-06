Return-Path: <netdev+bounces-62145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0AD825E1A
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 04:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3212A285193
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 03:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E705115B1;
	Sat,  6 Jan 2024 03:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcjEgHW+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97B315AB;
	Sat,  6 Jan 2024 03:32:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2D7C433C7;
	Sat,  6 Jan 2024 03:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704511973;
	bh=1u32dTC0eH/V7kWdeW575b47WixVYNPhXK1f2z3ilxk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EcjEgHW+7rAprJzaq4UfsGOfOl9q4bUrTKlmPdlDkeeDN6+ORWTkHUOWpZj55/sVy
	 Arq/IABOnLBaAI0YHsWI7T6QCC30lhxhDLd1/oMrC3z+r1DtVmSqQeslMVShfhrhrZ
	 +JtTOrMd0fpA/hZ9aVfvYum193VD0KRuPzI+MzOJMy07tGZus+4AA5eIzqAT6Fxi16
	 XMA9DlUW4mMcQIrqd8vC5p54fPPK13yxGP+grp+TRO621wN10C3T9uio/o62CoTaWA
	 +gIDFWRD+YmTIIifyA7wgkPTM7d5Pnw+DiPxqaGmqyry/W7aitmBqjgH7ALBsUKQ3F
	 vwG/CUgh/qLiw==
Date: Fri, 5 Jan 2024 19:32:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <hgani@marvell.com>, <vimleshk@marvell.com>, <sedara@marvell.com>,
 <egallen@redhat.com>, <mschmidt@redhat.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <wizhao@redhat.com>, <kheib@redhat.com>,
 <konguyen@redhat.com>, Veerasenareddy Burru <vburru@marvell.com>, Satananda
 Burla <sburla@marvell.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v3 7/8] octeon_ep_vf: add ethtool support
Message-ID: <20240105193251.028e8eb5@kernel.org>
In-Reply-To: <20240105203823.2953604-8-srasheed@marvell.com>
References: <20240105203823.2953604-1-srasheed@marvell.com>
	<20240105203823.2953604-8-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jan 2024 12:38:22 -0800 Shinas Rasheed wrote:
> +	"rx_dropped",
> +	"tx_dropped",

Please take a close look at rtnl_link_stats64.
Anything that fits should really go to standard interface stats.
This will benefit the piles of monitoring SW which gather standard
stats.

> +	"rx_dropped_pkts_fifo_full",

This one is probably rx_missed_errors

