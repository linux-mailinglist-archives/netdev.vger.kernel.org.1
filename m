Return-Path: <netdev+bounces-180382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F31A8129B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F2F07A9F5F
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776D222DFBC;
	Tue,  8 Apr 2025 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doZ9qgp7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EAB1D54E9
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744130458; cv=none; b=OTQOcnEnZ587IJqh9SSV3Nfbyrvbrw4y4Qfz0bZB7HWDkOH0lXlgiDr7uXCEmyo3EjvQJVO/BdqnX5A+tZKflryHGQ81rKlO0Wa2BYQXfvnTM0VPOZbvUMjjawWbaSFIf+yuLTmaea360d8cFxeIBafLYVzE07FO1lZpojRIB/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744130458; c=relaxed/simple;
	bh=buefAf7n0XkuIiZhpxHwM4GX2tX3lacg88/S4nXGjro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhXIj5ePI2SFc2OU7oQ2ybmITI09PD2GCahsD28cnlcCWyFSxlplzLaOQCFoxy7ebQucmXU//KobTatvTeoijZA30/QXZruzlfUodysFgXmN7L029YuNwLQAAtWlmXo4mBMEAk/N5x/lqf7o+bfCP8Riik1NTFz4D5NjcY0vr/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doZ9qgp7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4837EC4CEE9;
	Tue,  8 Apr 2025 16:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744130457;
	bh=buefAf7n0XkuIiZhpxHwM4GX2tX3lacg88/S4nXGjro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=doZ9qgp75xV/3b2KG3jjUWp7ULo4vbXpFxCDKSacMkWg60jhM+MCnthsweOQLKDRt
	 Aqf0sfOI3E0JvMxloOOyHgpmO7QdLlWB4GTZiUA23ok+tWE6L06n/r+GkKYPiudnZd
	 iKPUt5Tdiuzg37Ul85Kqb0vdt+V5koC4NoR8PPeWnqUhPRmQ3GGtEBUaGWu6AT7AHx
	 t061/ixx/yTu90sv12GU9LUyN4H1dlIyusvFS/a+jhWVQEcCE7xJw7RIn5JG2mkbpt
	 grqX7VIWJSSy6ASMQaoedkp/2yqexId4fAw8hfykDfpKXeSiMt5TJi8tU9Za73WQ9W
	 /ETbffOZ9xtFw==
Date: Tue, 8 Apr 2025 17:40:53 +0100
From: Simon Horman <horms@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, suhui@nfschina.com, sanman.p211993@gmail.com,
	vadim.fedorenko@linux.dev, kalesh-anakkur.purayil@broadcom.com,
	kernel-team@meta.com
Subject: Re: [PATCH net-next 2/5] eth: fbnic: add coverage for hw queue stats
Message-ID: <20250408164053.GB395307@horms.kernel.org>
References: <20250407172151.3802893-1-mohsin.bashr@gmail.com>
 <20250407172151.3802893-3-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407172151.3802893-3-mohsin.bashr@gmail.com>

On Mon, Apr 07, 2025 at 10:21:48AM -0700, Mohsin Bashir wrote:
> This patch provides support for hardware queue stats and covers
> packet errors for RX-DMA engine, RCQ drops and BDQ drops.
> 
> The packet errors are also aggregated with the `rx_errors` stats in the
> `rtnl_link_stats` as well as with the `hw_drops` in the queue API.
> 
> The RCQ and BDQ drops are aggregated with `rx_over_errors` in the
> `rtnl_link_stats` as well as with the `hw_drop_overruns` in the queue API.
> 
> ethtool -S eth0 | grep -E 'rde'
>      rde_0_pkt_err: 0
>      rde_0_pkt_cq_drop: 0
>      rde_0_pkt_bdq_drop: 0
>      ---
>      ---
>      rde_127_pkt_err: 0
>      rde_127_pkt_cq_drop: 0
>      rde_127_pkt_bdq_drop: 0
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


