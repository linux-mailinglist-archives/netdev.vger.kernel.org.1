Return-Path: <netdev+bounces-191495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E3AABBA39
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 11:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F6C1702E3
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 09:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C39526F460;
	Mon, 19 May 2025 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b90oko50"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633831C84B8
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747648001; cv=none; b=LSxoHhAMkjsgO976eI3YyVsRPgv+x12BzlUZbC8h5XyjbBf8NLSSXa6exdJUeFeQFW+82ByWiwUJfW1Uo84NGJoORxs45QHxD4Qyj0RecNKkaeybnue0C5zU1l1jgqE3lM3d1Ud9buv4xdy/WwBJAhwbfCNgo2lbhjTePgtWJ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747648001; c=relaxed/simple;
	bh=2566Xddhp+2kdnOn/l4udtTcEt2bYPi0/sg2riddGRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7ALMVzXTmOw4oQVsoY0OwESf4ka6BbGukMyYqxACnnaj58ib+m1K2QxBeTDaPBjZAZOUj73BnzVFxBkZa9QZlmjRes+zbSzRDPLTS1e/FKbiFsPEzpR7IimZksdf14hRBFTd8FfS2X7SCFIumR9KfHU3T17D76BiS5QgNRgGdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b90oko50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9D2C4CEE4;
	Mon, 19 May 2025 09:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747648001;
	bh=2566Xddhp+2kdnOn/l4udtTcEt2bYPi0/sg2riddGRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b90oko50aXGaf1Q8ETiIK2dYmNDCXFGts/uAJN1PMybJmWkn+tEt5qu6UwkZNY9PO
	 RCPTvvIpK1w0Nn77RbVAp+NLUGpR+H57bNzmK4dqAiNX0jxGRFSghAw8mJlzQW6fDu
	 UVPYBGttHNPYcMibYBKQjW1dgIFTndIYQKGb5LsyNJ4xPi8Dfeoe8llhH4x3gDW+hN
	 Nu4r6h8xUGaaqt7Rt1HTW3TRzY2TWB2XM38Tej4XXqfkL+Bep21P85mBoJ0MgRB7Gl
	 tFSot9VQaCXAWjkFIQ/8DEi4oZOmdeGkRYJ2i6wGUW3XDqhrLiKSe84x0R2G3nkpEd
	 hnTLobvTlgfiQ==
Date: Mon, 19 May 2025 10:46:37 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: airoha: Add FLOW_CLS_STATS callback
 support
Message-ID: <20250519094637.GE365796@horms.kernel.org>
References: <20250516-airoha-en7581-flowstats-v2-0-06d5fbf28984@kernel.org>
 <20250516-airoha-en7581-flowstats-v2-2-06d5fbf28984@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516-airoha-en7581-flowstats-v2-2-06d5fbf28984@kernel.org>

On Fri, May 16, 2025 at 10:00:00AM +0200, Lorenzo Bianconi wrote:

...

> @@ -1027,6 +1255,15 @@ int airoha_ppe_init(struct airoha_eth *eth)
>  	if (!ppe->foe_flow)
>  		return -ENOMEM;
>  
> +	foe_size = PPE_STATS_NUM_ENTRIES * sizeof(*ppe->foe_stats);
> +	if (foe_size) {

Hi Lorenzo,

It's unclear to me how foe_size can be zero.

> +		ppe->foe_stats = dmam_alloc_coherent(eth->dev, foe_size,
> +						     &ppe->foe_stats_dma,
> +						     GFP_KERNEL);
> +		if (!ppe->foe_stats)
> +			return -ENOMEM;
> +	}
> +
>  	err = rhashtable_init(&eth->flow_table, &airoha_flow_table_params);
>  	if (err)
>  		return err;

...

