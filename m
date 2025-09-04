Return-Path: <netdev+bounces-219961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF76B43EB8
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 16:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59D561C874E7
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 14:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3274C3090CC;
	Thu,  4 Sep 2025 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlqtHD48"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082AD30147F;
	Thu,  4 Sep 2025 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995888; cv=none; b=pZglBn80k3O1l5lT/wjr+PEiPZxDDP52dXzy71LHROAaIKJYqVFSQqGgefHHqBNWWLVUgp6smVQBM1eWG3h0t5QyuP7INnXY6Ofss/wc5VFFxIiAc+DI6S8Vp1o435RjShfCLPgIDuX5DzKihOPzS2NNjVMnK3fq5OCjaEGdxxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995888; c=relaxed/simple;
	bh=TMSFhLV/1wYkSJ97dKJw6ufL7BjjXw84F1bCscmJTtw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qWaxr7N4WLphvlJ5p78TPp9xC+HCmHf/WA4D6bcc6qJ+om3LhuVucDPp3fJHW3tKUZUDFlajoG3Fv64gn9SPw2YmL910cNHivxXyJOX5KnRXhK9F0vitM5XPDOn5co5e5Q4ynNy9flZ9VSa6tLB7tp4baSiBSy30qCmPtY+8CMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlqtHD48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C5BC4CEF0;
	Thu,  4 Sep 2025 14:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756995887;
	bh=TMSFhLV/1wYkSJ97dKJw6ufL7BjjXw84F1bCscmJTtw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DlqtHD48YgV+PrFaJtWEk60ZfwIQ08DvnfwAInRIuLG13x92gTVjBWU1ChjPa5ahM
	 AEfSxcERFIS0Bs97NAUWZWUTIwGlv2eYFuVR2yelqCz1QWzLpTkDg2D5icoi0KAGG9
	 yTckK9cFA9Y4cWB9YaTPF9yEtvFZyCc0XJjavWv8FghE6w7hVGkbhPRQRVHvoK9wp5
	 B5sB20in+GorY/jpsQzG7oZYykD4wAASJ5jCdivS3FYuEfoFT6LcTAt5g7SYN6ip4p
	 c22q959WzyTU7ib43O7cvcVLeTYiSJWxTtGJSpDjT0HTGuyHqnbDLn6Ggt40q7yFZo
	 gMd/Mh/odYsEA==
Date: Thu, 4 Sep 2025 07:24:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Conley Lee <conleylee@foxmail.com>
Cc: davem@davemloft.net, wens@csie.org, mripard@kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: sun4i-emac: free dma descriptor
Message-ID: <20250904072446.5563130d@kernel.org>
In-Reply-To: <tencent_160BBED8A83CECDE110A344B51B6229B1209@qq.com>
References: <20250902155731.05a198d7@kernel.org>
	<tencent_160BBED8A83CECDE110A344B51B6229B1209@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Sep 2025 15:49:39 +0800 Conley Lee wrote:
> In the current implementation of the sun4i-emac driver, when using DMA to
> receive data packets, the descriptor for the current DMA request is not
> released in the rx_done_callback.
> 
> Fix this by properly releasing the descriptor.

Reading the docs, it appears that the need to free the desc is tied to
setting descriptor reuse flag. Which this driver does not do. So I'm
unclear why this is needed, maybe the dma engine driver is doing
something strange?

Could you repost this, CC the dmaengine ML, Vinod and the appropriate
SoC maintainers?

