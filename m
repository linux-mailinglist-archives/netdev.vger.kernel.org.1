Return-Path: <netdev+bounces-145466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8809CFA79
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C171BB3B1CA
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 22:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30D01FF60A;
	Fri, 15 Nov 2024 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DanHg6V7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0461FB8BD;
	Fri, 15 Nov 2024 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706825; cv=none; b=CWe5/uQDq1yhMZQqRPMkvCd32z/iEX9zevucSKsutxWNy8c5NV+NRB3GSTnmgMI0itpXho++uUT6pHgfyvashVLPgW89ITxG7Uyi6i22oNlNtf3/EwC1rSnCV+rsk1Ej07vwQA7o9yNO7MLo/kw1g1mEYrIxA+znaUG8fh6YDG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706825; c=relaxed/simple;
	bh=QAvCBPaByMr33bUm9bnL0za3lGLaZ2aRJXUXtkldGDs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tf4typXnno5N2EE7s8uvpACo4ILBD2sX0a6wJ8Fg3pFndWW1xXmr/fHFB5BmVzIFW0gbaPWIKxlRS/xoSwsmSqrZYh1ealbmGvmvAwm36FPHcUPP0ivHN9VwAkTuM+PuAgRflTOYopw2TwQatK0lebiwiAdu8tyu7fRyJYVTyUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DanHg6V7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9724FC4CECF;
	Fri, 15 Nov 2024 21:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731706825;
	bh=QAvCBPaByMr33bUm9bnL0za3lGLaZ2aRJXUXtkldGDs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DanHg6V7l3zbjCDuoFnSQVlV/KY/w06f88xvA88b2MdLexQkTbm7BCXlo+/u54u6k
	 yRizheDpOd5UZxttTv0QL54Gp9Xo86w90x3a9tsQREuCVesH9GEBM/bxWvVZFMe7By
	 PpW04bqaAgS1kwVeXTSpAtVTaAqUJSFDdkidI9nLf81SFV9oac7fyJ0EJftbxGbRZc
	 JWmYtlOogVg/IvW8new2en82T/db7GwK6Uo4B6niIOWsGM6JNL7PMq9q4pE76ojU3s
	 LVsQqPoZTszBN+RTk5CqJ7taS8YfR1506x0G/z1pcbWZI9XN3s4aGLetPBWydd6iKf
	 UI41Hf0mSDaMw==
Date: Fri, 15 Nov 2024 13:40:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 donald.hunter@gmail.com, horms@kernel.org, corbet@lwn.net,
 andrew+netdev@lunn.ch, kory.maincent@bootlin.com
Subject: Re: [PATCH net-next v2 7/8] ethtool: remove the comments that are
 not gonna be generated
Message-ID: <20241115134023.6b451c18@kernel.org>
In-Reply-To: <20241115193646.1340825-8-sdf@fomichev.me>
References: <20241115193646.1340825-1-sdf@fomichev.me>
	<20241115193646.1340825-8-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 11:36:45 -0800 Stanislav Fomichev wrote:
> -/* MAC Merge (802.3) */
> -
>  enum {
>  	ETHTOOL_A_MM_STAT_UNSPEC,
>  	ETHTOOL_A_MM_STAT_PAD,
> +	ETHTOOL_A_MM_STAT_REASSEMBLY_ERRORS,
> +	ETHTOOL_A_MM_STAT_SMD_ERRORS,
> +	ETHTOOL_A_MM_STAT_REASSEMBLY_OK,
> +	ETHTOOL_A_MM_STAT_RX_FRAG_COUNT,
> +	ETHTOOL_A_MM_STAT_TX_FRAG_COUNT,
> +	ETHTOOL_A_MM_STAT_HOLD_COUNT,
>  
> -	/* aMACMergeFrameAssErrorCount */
> -	ETHTOOL_A_MM_STAT_REASSEMBLY_ERRORS,	/* u64 */
> -	/* aMACMergeFrameSmdErrorCount */
> -	ETHTOOL_A_MM_STAT_SMD_ERRORS,		/* u64 */
> -	/* aMACMergeFrameAssOkCount */
> -	ETHTOOL_A_MM_STAT_REASSEMBLY_OK,	/* u64 */
> -	/* aMACMergeFragCountRx */
> -	ETHTOOL_A_MM_STAT_RX_FRAG_COUNT,	/* u64 */
> -	/* aMACMergeFragCountTx */
> -	ETHTOOL_A_MM_STAT_TX_FRAG_COUNT,	/* u64 */
> -	/* aMACMergeHoldCount */
> -	ETHTOOL_A_MM_STAT_HOLD_COUNT,		/* u64 */

These comments could be useful to cross reference with the IEEE spec.
Can we add them as doc: ?

