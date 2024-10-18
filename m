Return-Path: <netdev+bounces-136987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9549A3DAC
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 13:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1C4DB20BBB
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 11:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70441CFA9;
	Fri, 18 Oct 2024 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ke4YCPRM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7B81B815;
	Fri, 18 Oct 2024 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729252714; cv=none; b=BYpQC0eL2AhfLBX8xPlkk/16j9JB4nFFuwBVv4FTnGy+0HvJ8nXVKRCzPrmbtf8gyV4VuPRWUMs5ZjcRrmyCea3YPMAuQksHHBu4I/sXArJs7HpPKJrsvchBOAAgZyCkQh/Q4NyUoqvPkhaAWZ0pPPiJh8zMiUqArTbopIXiLLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729252714; c=relaxed/simple;
	bh=2R9kXp221amqzMlk3Tqe+eSDtWRSn5J3KYQbdedqztk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Re87A9HSzB+AyosvDGOCuYW/tc+eg9n/UA/tOLQoVMlBMqnvPbkv9/tpAsuRC1eGFhm2vLmEc/Ex6tLXTgCTbvZBFEqdwiogdltVoi711PgbaFspgr4oZKy6Zqos4HOBFHhfRHguw1+Xl0uj0qqKScCC0YlFjFMCdliAdASb5OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ke4YCPRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3B9C4CEC3;
	Fri, 18 Oct 2024 11:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729252714;
	bh=2R9kXp221amqzMlk3Tqe+eSDtWRSn5J3KYQbdedqztk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ke4YCPRMF0bSPH6omEPNLfAhovcElaQeBTX0oJ29HHv+bcxed1G0JMr+7zCltX1P8
	 qz9l2/kBbEz3SBrljcXtMDAWHbJSOo7em001Ab88lZoGj46i4xBhwqebnVJ9XT6vNk
	 HMKq/1wHLUhyzpOsTuQB0EiN8Hk7hhP3BSyftRfZeDQQvtTmRWf1yXlcSylfbu11Yw
	 /qWBwdwRFLZOj3TWZrp/AHQ3M+Q1jd/iUkZhPw9QlQNihgBsV2N3gWmXsqUVcp7x+s
	 C5HOsDoVTZzRUxm95O+Xg+kWzUXI9R5gYr7jADCNrhf+Ft50g1VPIGkBWFiHx6y5VX
	 shilHxfE2AMnQ==
Date: Fri, 18 Oct 2024 12:58:29 +0100
From: Simon Horman <horms@kernel.org>
To: Linu Cherian <lcherian@marvell.com>
Cc: davem@davemloft.net, sgoutham@marvell.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, gakula@marvell.com,
	hkelam@marvell.com, sbhatta@marvell.com, jerinj@marvell.com,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v3 net-next 1/2] octeontx2-af: Refactor few NPC mcam APIs
Message-ID: <20241018115829.GI1697@kernel.org>
References: <20241017084244.1654907-1-lcherian@marvell.com>
 <20241017084244.1654907-2-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017084244.1654907-2-lcherian@marvell.com>

On Thu, Oct 17, 2024 at 02:12:43PM +0530, Linu Cherian wrote:
> Introduce lowlevel variant of rvu_mcam_remove/add_counter_from/to_rule
> for better code reuse, which assumes necessary locks are taken at
> higher level.
> 
> These low level functions would be used for implementing default rule
> counter APIs in the subsequent patch.
> 
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> ---
> Changelog from v2:
> 
> New refactoring patch.

Reviewed-by: Simon Horman <horms@kernel.org>


