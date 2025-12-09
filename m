Return-Path: <netdev+bounces-244154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFEFCB0A9B
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 18:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 912DC30F6770
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 16:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4AD3002B0;
	Tue,  9 Dec 2025 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DADOQeit"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AB8288537;
	Tue,  9 Dec 2025 16:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765299593; cv=none; b=TwFOjdKDFqCcJb1aDZPVj+V9clAlkCRUa7A9bY5Hq+2AfMQ1Nx7uGK8cR5oI7jdc1osQfTcOeGlGUQmQFtcnLpTkrj6cd3e1c80U26A2gA9kTXg0yNIz1vvbPrkjgpZhosE97rE2jj4FfT9Dfp/aP0aWavjEU4WID/nwSe44g9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765299593; c=relaxed/simple;
	bh=oQeCQBqvczPrbkwcSpEGBVgCAauVVeb6dy/UD8J/4KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVoBvBZr2ibLK5Mh9XTapXRfAU/RIm3vzYeyp1BTnvugmXe4Yra5birIB6c1Zo+faUA4fHPSMtkSGSCsv5/1oqQ3k3VGj6SGMTLbunI/RLI2Av5XM2DfMpt96fhYOxcoJCeix6ohFycwknbaJGvVha8Rj6DFRE13EwjEWpbGg74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DADOQeit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09E8C4CEF5;
	Tue,  9 Dec 2025 16:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765299592;
	bh=oQeCQBqvczPrbkwcSpEGBVgCAauVVeb6dy/UD8J/4KY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DADOQeitRhHQHmCZcbx7np0iolU2r1y9zEii1d0EZsGr4NxvyrvSy4p+ybXImjH2O
	 MQ5PRu9r2j8UN/Xsrkc/6qzxY4ulBQvPIjmseKMPO15AHJ4b7/Yyl5S9cglLSzv+ZG
	 cQrF9P/bh+E9/WaWUyQTIbuWLLq0j/drGS3vb1j2H1z4yJpZtnXKDngdQz3GBZmix0
	 2yMVHnAd91Tp/R6LxTzSqNMlW8sKBvuDN484iRONyHQTno2quwGeIyw9I1/LVG5CJ5
	 z89X06tuyGlp60pJd+ZzDtNa83ro/GmayC1WJ1y4HL/Z2QORGUPbJZTQs5hSanXU0C
	 1oPf0/PadBVvA==
Date: Tue, 9 Dec 2025 16:59:47 +0000
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com, lantao5@huawei.com,
	huangdonghua3@h-partners.com, yangshuaisong@h-partners.com,
	jonathan.cameron@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/3] net: hns3: using the num_tqps to check whether
 tqp_index is out of range when vf get ring info from mbx
Message-ID: <aThVg5BQW_StnV6K@horms.kernel.org>
References: <20251209133825.3577343-1-shaojijie@huawei.com>
 <20251209133825.3577343-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209133825.3577343-3-shaojijie@huawei.com>

On Tue, Dec 09, 2025 at 09:38:24PM +0800, Jijie Shao wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> Currently, rss_size = num_tqps / tc_num. If tc_num is 1, then num_tqps
> equals rss_size. However, if the tc_num is greater than 1, then rss_size
> will be less than num_tqps, causing the tqp_index check for subsequent TCs
> using rss_size to always fail.
> 
> This patch uses the num_tqps to check whether tqp_index is out of range,
> instead of rss_size.
> 
> Fixes: 326334aad024 ("net: hns3: add a check for tqp_index in hclge_get_ring_chain_from_mbx()")
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


