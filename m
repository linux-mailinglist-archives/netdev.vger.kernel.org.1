Return-Path: <netdev+bounces-62088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF688825B22
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 20:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB291C2379D
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 19:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F5B1E533;
	Fri,  5 Jan 2024 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ako+xmRc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF1835F05
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 19:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BF9C433C7;
	Fri,  5 Jan 2024 19:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704483406;
	bh=dXi9lRPWm69F0pCZUvJdoTPny5gJO2ky7yLi8v4C4jI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ako+xmRcO7hU2N22QKn/ZTD8ZB7nmuB/qIeaLaHStk9RIkAf4vUpb68NdWvyxjQsN
	 6b3hWp2UhsJg31I/Tdr+OsU/HRCfC1oihFu27GXlcDYWe9umFi4OOdWUGaDJKRs+O6
	 MMFA6MO0bbEVmUDT2XtrxF086FMzgqCU0Kb1y6IBXQa4YI11lpVUZNxPsxrSOO5GqF
	 9aeYfhwmL89IYjtA1YYz8ZMq1Kdg25fbERv2hthvPQPSfz34gKj+ZHJwncNH/EvDcv
	 aS0WXd9eC6kpGGwMdfS12lrvqRFWPKv6w2DNXIxsK4dI9ON/8Fn0Gs/CJgv4DGCZMq
	 qOY3FlJUCG+aQ==
Date: Fri, 5 Jan 2024 19:36:42 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] geneve: use DEV_STATS_INC()
Message-ID: <20240105193642.GZ31813@kernel.org>
References: <20240104163633.2070538-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104163633.2070538-1-edumazet@google.com>

On Thu, Jan 04, 2024 at 04:36:33PM +0000, Eric Dumazet wrote:
> geneve updates dev->stats fields locklessly.
> 
> Adopt DEV_STATS_INC() to avoid races.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


