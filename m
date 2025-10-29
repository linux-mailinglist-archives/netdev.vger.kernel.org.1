Return-Path: <netdev+bounces-234061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4AAC1C033
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91B405A5C02
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 16:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E0F346E50;
	Wed, 29 Oct 2025 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2G7UJxW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E974346E42;
	Wed, 29 Oct 2025 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753945; cv=none; b=QSAnUhPrDPZQ4Vcp6ZrzFwbp8ut6kOxQ1f+cfICJdzCDObhvZdLj9fhYdgrR5i8Gy5Vp2mUF8jvHa9A4KTqgcHy3zxz5yvB9wqaj9Yx+KsIiSeeT9Nm4fCQI/kt7iMdoXfWAGcbvhFKlQ+Kx2YILeelvIu9vSVpU2iW89F2FfqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753945; c=relaxed/simple;
	bh=8+wXa7M+tLKTBAR1irFMdr2Yj5VB7z4Z70UszIc2pvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E949Qm6uSkdRBSKHlXrU2YZceuYFCgYBCfAfv9EGUX94ZQpCO3L7hbYAFh8iDokbY70SFJi7mvzDVncH+PZ9cE+IEtgXdpMtdyQ7vyRsklC4CriSlU7gmw7XigOoA3C7MClQBFkVdL+InGpR616dlTQGAfSqk2OiReKdyItn3xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2G7UJxW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1806FC4CEF8;
	Wed, 29 Oct 2025 16:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761753944;
	bh=8+wXa7M+tLKTBAR1irFMdr2Yj5VB7z4Z70UszIc2pvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h2G7UJxW0ub/wmdkk2zHv9iMmB3jPT6R0zaR1HGtsSr8dyOIefPcshcxY86ENu8yb
	 NhzWFrL4gkToJ5ck5S3Mzbk+0iTcNUoTeDoS79dT7o60QXPiRqnc+S3dU+HXnBuRPM
	 CP2s2Flyey9OR48k3skIVuJxxAb0/pIGDXtO+XXJjEHIYn9qpiXVRUJ/XwjnQf/tF1
	 4lIWNznEGjNiTnu1Np9rccTP7Hf6ezmj+m+yB9LTxJLUEyQyN7ZvZROUkqYIWa5Twm
	 ac9MmZ+wF5iYHwR0C6/G5ebQu7/+qKkUl7SXiBD0RNuuDD/vhamDirIZ7o8SKI6ws0
	 Qu8+YOCW6suaw==
Date: Wed, 29 Oct 2025 16:05:40 +0000
From: Simon Horman <horms@kernel.org>
To: Harshita V Rajput <harshitha.vr@chelsio.com>
Cc: kuba@kernel.org, davem@davemloft.net, kernelxing@tencent.com,
	imx@lists.linux.dev, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: [PATCH] cxgb4: flower: add support for fragmentation
Message-ID: <aQI7VAXP3XMbYliQ@horms.kernel.org>
References: <20251028075255.1391596-1-harshitha.vr@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028075255.1391596-1-harshitha.vr@chelsio.com>

On Tue, Oct 28, 2025 at 01:22:55PM +0530, Harshita V Rajput wrote:
> This patch adds support for matching fragmented packets in tc flower
> filters.
> 
> Previously, commit 93a8540aac72 ("cxgb4: flower: validate control flags")
> added a check using flow_rule_match_has_control_flags() to reject
> any rules with control flags, as the driver did not support
> fragmentation at that time.
> 
> Now, with this patch, support for FLOW_DIS_IS_FRAGMENT is added:
> - The driver checks for control flags using
>   flow_rule_is_supp_control_flags(), as recommended in
>   commit d11e63119432 ("flow_offload: add control flag checking helpers").
> - If the fragmentation flag is present, the driver sets `fs->val.frag` and
>   `fs->mask.frag` accordingly in the filter specification.
> 
> Since fragmentation is now supported, the earlier check that rejected all
> control flags (flow_rule_match_has_control_flags()) has been removed.
> 
> Signed-off-by: Harshita V Rajput <harshitha.vr@chelsio.com>
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>

Thanks for the comprehensive commit message.

Reviewed-by: Simon Horman <horms@kernel.org>

