Return-Path: <netdev+bounces-137117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4118E9A468E
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 21:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD340B24061
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 19:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0572205126;
	Fri, 18 Oct 2024 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojxtue5N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701FB204F67;
	Fri, 18 Oct 2024 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729278639; cv=none; b=TSMhEMsYoRGzZnaloQoFE4SJOx+1G4gF+8BH3d+pdCt5G33sJix08WT8MNrenklrS7smuUF7InejV9zRnlWbXdutmqww+IfZP9PlHpZLwn7dCEzlyQQWidShVZ9bEoQ/78Om1JbE5KygFJQkf9lUa7iyibrnyo9LASWLMQ2Jz94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729278639; c=relaxed/simple;
	bh=JRP3jeY237nDpeaw4Wj/LBFwSiCJxMgEzCgFYb3ZJPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErTs8OEk1BaU27xJYRI9rowlDy/bqDfpBMLuvjgpi3jd4fImYc7D4B/60+ZGuQDSELtmi0W2v3RkXcJJx+HfmaOes4h+C8gE2Kx4c2t6xfWebVN6G7/QBmX+e8RITWyTRJMPY8TIZnjyP9O2/rPC/eu1sh2BdIL7sQWF2ELd8R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojxtue5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCE6C4CEC3;
	Fri, 18 Oct 2024 19:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729278639;
	bh=JRP3jeY237nDpeaw4Wj/LBFwSiCJxMgEzCgFYb3ZJPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ojxtue5NZdr2zZCvzeQd4hULbdlT2iqRTAUd/nEWHkll8EU/tEz8j3QPm2agtZqPt
	 Aa1vw1HSV3ZjQLvtmF2CpUjPK5SIKkG1vG9yqD4YWRTH09aia2d7pkLPE09/lxeimi
	 mEEebXl1OoDRn54W2bTGI9jiU/axZrUESlzX2Cs/tBzNZLjJfjis2vkcFT0WGswPk+
	 nDQHb/oEde8HvgtlLfwfuVkIE/eB4481zlnhtZzhDRrWAnLB1m1hh3BGTxVWwsEf92
	 wZGkuKEnavWWYE+hmgESYsMlz0cV76GmhQ4Cy0THbZtia7cUkybegGKCChjeV6iGrJ
	 Cs9XpuH8VTMtQ==
Date: Fri, 18 Oct 2024 20:10:34 +0100
From: Simon Horman <horms@kernel.org>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/6] octeontx2-pf: handle otx2_mbox_get_rsp errors in
 otx2_dcbnl.c
Message-ID: <20241018191034.GX1697@kernel.org>
References: <20241017185116.32491-1-kdipendra88@gmail.com>
 <20241017191620.33047-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017191620.33047-1-kdipendra88@gmail.com>

On Thu, Oct 17, 2024 at 07:16:16PM +0000, Dipendra Khadka wrote:
> Add error pointer check after calling otx2_mbox_get_rsp().
> 
> Fixes: 8e67558177f8 ("octeontx2-pf: PFC config support with DCBx")
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


