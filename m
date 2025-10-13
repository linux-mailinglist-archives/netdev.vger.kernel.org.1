Return-Path: <netdev+bounces-228982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F55BD6C65
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 01:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0892A3E0D8B
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 23:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFC12BF016;
	Mon, 13 Oct 2025 23:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxC3ChJx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F8F271459;
	Mon, 13 Oct 2025 23:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760399255; cv=none; b=mT3MmEiI60kryCv7aOnvMn4/1NorbaVGRWbTvbJKQRxAeDGp/oBV/KT0LzRX5fFa7irX8II3SljLCjeTWzj1npi8J8WocBqBPaN7TjmXg29QbouEez4DPxjrUt3RliH2vk9yg03CgspjvSjQXAtPl4zLVSkqV2tH4sLBTLZXjpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760399255; c=relaxed/simple;
	bh=Sl2tk/9/AqiOWYU/msCSVJQ1Lbarkup5I3dDrIt8sCc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hmY2DYx9RWCwxBg2arANxBYzKYinjfS1XmE/Pii9cz1QzOPCQvauYqsUSoUBjS6BSrnMdAMjl9UvqpfUq0nbDh+2t42F3gVMvdOL5JLnEW6dRy+qrvBGRu0O1Ru6nZuUmPzLQk/ykBxlj+qoZB0CfQwINsUonrwj81X5/Gm1pNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxC3ChJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F966C4CEE7;
	Mon, 13 Oct 2025 23:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760399255;
	bh=Sl2tk/9/AqiOWYU/msCSVJQ1Lbarkup5I3dDrIt8sCc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hxC3ChJx96E2y1LRbrCJyX41csL5GS3Y4lRalsVb8kFgNgbWMgr++h3wXdhuQ0s9G
	 ZeOVAdp9oadk2DoaaGvU0KALZB2n6nzWIKbF8jCnxIZnA07vrU6D7ZFYTYZs/5C1PG
	 9lKsx/nM75OQenmOywGERoSKKzblQwAaYCFxvBPDv4sVKniDXoY76EgD+BxeKWASft
	 1o2KZkyv2AdJpvLeHE3lsTQrYhywwUr2qSL76bGLv4X4VEt3AZWhG8wl5KAPeruj/A
	 vPV4sGHwRsIPU6fvw7Wld0YxZK438NE8D9CkqKvDblAjnst1vbHpFkeNDcvjjgLZ9e
	 UreqrSfpO8Ixg==
Date: Mon, 13 Oct 2025 16:47:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Frank.Li@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: enetc: correct the value of ENETC_RXB_TRUESIZE
Message-ID: <20251013164733.65ff67d2@kernel.org>
In-Reply-To: <20251010092608.2520561-1-wei.fang@nxp.com>
References: <20251010092608.2520561-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Oct 2025 17:26:08 +0800 Wei Fang wrote:
> ENETC_RXB_TRUESIZE indicates the size of half a page, but the page size
> is adjustable, for ARM64 platform, the PAGE_SIZE can be 4K, 16K and 64K,
> so a fixed value '2048' is not correct when the PAGE_SIZE is 16K or 64K.

I'm expecting an updated commit msg here, so dropping v1 from pw

