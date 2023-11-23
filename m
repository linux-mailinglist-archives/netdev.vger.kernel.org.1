Return-Path: <netdev+bounces-50364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1347F5718
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 04:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49851C20A5D
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 03:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D706D8C1A;
	Thu, 23 Nov 2023 03:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bH1MFVVM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4998F59
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 03:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6DFC433C7;
	Thu, 23 Nov 2023 03:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700711614;
	bh=sPU8LaXBokpjRLLdNLc7piWjZkk6xJIANQ2OGdHCOGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bH1MFVVMOlG/PCj0l4nX/Cg/fDJjW3c0oXB+HZBXubVWwg3pbppqDX/bhMP0vQp6W
	 ed7x9LHlxdm3kArR+xszTuRsiYtqu8EdlCmKJcWTb+gT5WgTWt6wsCeqNrdcZ4ExQs
	 YEx3DoYEVwO1V0siloyPCUw+gqtnD/BbA8GpreAsPt/dWpUKxvxhFWr7xSDDlr8uXF
	 em97oQphwdun0/TEBsSZDea1t7no1JMZ2Dx28qpAnZB4gUQSi66n5IFZiunH+NjLJ9
	 BEWJNO0Ozqjto5uFHzEzhmz4gs7BvlNl+12zHNLbeufxts5b8Rpa/IC0njTvHaXaVH
	 OAgAMbxvhPrBg==
Date: Wed, 22 Nov 2023 19:53:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Saeed Mahameed <saeed@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu
 <jianbol@nvidia.com>
Subject: Re: [net 09/15] net/mlx5e: Forbid devlink reload if IPSec rules are
 offloaded
Message-ID: <20231122195332.1eb22597@kernel.org>
In-Reply-To: <20231122112832.GB4760@unreal>
References: <20231122014804.27716-1-saeed@kernel.org>
	<20231122014804.27716-10-saeed@kernel.org>
	<ZV3GSeNC0Pe3ubhB@nanopsycho>
	<20231122093546.GA4760@unreal>
	<ZV3O7dwQMLlNFZp3@nanopsycho>
	<20231122112832.GB4760@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Nov 2023 13:28:32 +0200 Leon Romanovsky wrote:
> Unfortunately not, we (mlx5) were forced by employer of one of
> the netdev maintainers to keep uplink netdev in devlink reload
> while we are in eswitch.

The way you phrased this makes it sound like employers of netdev
maintainers get to exert power over this community.

This is an unacceptable insinuation.

DEVLINK_RELOAD_LIMIT_NO_RESET should not cause link loss, sure.
Even if Meta required that you implemented that (which it does
not, AFAIK) - it's just an upstream API.

