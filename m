Return-Path: <netdev+bounces-123602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3E59658AD
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 09:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2938FB24D0C
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 07:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4248B13632B;
	Fri, 30 Aug 2024 07:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZt//oXf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199EE56440;
	Fri, 30 Aug 2024 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003342; cv=none; b=W+NPH28L4ITO8fYNCnQZy1nbFWQCugu0qdBAONt6axFIn7q7ScIgPBHTbImUANY9YKvxbXG2SOJpxpSXG2OS9LP9RKCe3R+1x9uJ6IB6jNyRUXPI/OuRWM7wEjzKk9+t3bmaaQbOC2GgzMXhBClqdHd1zB78P1IkP+UU/WEcu18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003342; c=relaxed/simple;
	bh=xHquYzTQF6jiRAzKURhriE4TbVpZm1HhvOv+un2SS7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abCmFbujRDuIdDpGR98Pj+swcMTf3avJtHDDKFRZ3wsMWas4WQZ32xhspzRKRcDkJ+08rkWnuT40lnKbb1CdpKlJikPhsklW9z/J3b4Pflhk86dibsiNWiQrmzGh7Wxks234LpFs9Be5YEzi3IWsZJx30cqKr6ARgE7pZKgYbTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZt//oXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AF5C4CEC2;
	Fri, 30 Aug 2024 07:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725003341;
	bh=xHquYzTQF6jiRAzKURhriE4TbVpZm1HhvOv+un2SS7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EZt//oXfnedPEgwiEFfGD0kXsW4/VyTymxgT2L7dVDMZjLeJHLYxH4v/UyVisGIBD
	 JONhr9jntp4rVJfjojjamdp8qUerJBbOR3vIBdoP4e5q5NObqCdHvlTwdrg181cFyS
	 V2LgrPie6fLm3O8LizKOSEOqyEBfj5Xg14+b5ZwDitIwTeFXkSRn9kx5enDJtcm0Rh
	 lJnkv0wCJodTOseITsA31x4H3eAgHobKE+9+mn+lCtFzu/i8ciVXLBkThavNrXgxIe
	 t927KhuejR3G5vjmUWIjE4b/pakcp9tFvVSKRQymretja89kwldtOlJpUVGAzOxsSF
	 25fnfxtVZQxzg==
Date: Fri, 30 Aug 2024 08:35:37 +0100
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: bharat@chelsio.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] cxgb3: Remove unused declarations
Message-ID: <20240830073537.GE1368797@kernel.org>
References: <20240829123707.2276148-1-yuehaibing@huawei.com>
 <20240829123707.2276148-2-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829123707.2276148-2-yuehaibing@huawei.com>

On Thu, Aug 29, 2024 at 08:37:05PM +0800, Yue Haibing wrote:
> Commit 4d22de3e6cc4 ("Add support for the latest 1G/10G Chelsio adapter,
> T3.") declared but never implemented these.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Thanks, I agree with your analysis.

Reviewed-by: Simon Horman <horms@kernel.org>


