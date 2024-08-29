Return-Path: <netdev+bounces-123013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23D8963704
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 02:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E561E1C211EE
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F4C610B;
	Thu, 29 Aug 2024 00:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcedJsvo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41C923A9
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 00:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724892440; cv=none; b=Jo4h2gbOmz9kMTFEywlb8domtqdPDnT47xKDrUBldEWY9BRHh2GKSnb+9OixqenK9szR+pFH+H+PgoqxYKNEPJAe2QTJN3W2Tn3tWuRAKRrA4j2f+qVL9FA2bB7Ddtz8T2zXL9ENC2p5v3EjwWj9ut7BSFYJPZ7BkT/hBNCu+w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724892440; c=relaxed/simple;
	bh=agwahG9SWFJbdqkVgoGHMaPbzF2pR9nCaT6Ck1JfUr4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AwitadZsAx+3PCA2QljOOnx35DvvzYrR0+pueyZXxU1/R5cV/uNa5mXo82fFGchSvVh9TOobIfHAUV3jquHY/PwwMrbqMugYhgTclDfh9BVZzM9xAmAn/y7NfUi6RbjtaWY3LWzjACDf5OlVbimDjIDlT0t263Wg56V4IM9yZFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcedJsvo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF80C4CEC0;
	Thu, 29 Aug 2024 00:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724892440;
	bh=agwahG9SWFJbdqkVgoGHMaPbzF2pR9nCaT6Ck1JfUr4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qcedJsvoJzuXiF9KxC61HBeG7RsO0Ft/p/2a1PIEu8yMYj4RuwYEhPa0hw1+FwXSf
	 LAfV4g4GmTXalRCHHwP7CWfo+X3M0PXdS3PVlk7f2NxA3dQZNALCQ5pvnedb/rl/bJ
	 GpUjzmGH29nURNevRYgDJEa0y+GDmdWLsyuAt6C7XMth+LJ3cbc07aCd12XT/BK4og
	 BZ7RXlOJ+bOeQuVROrwFWQPZO4K/SmBg37WfrNiwxbGvNsHJZeMlH7qU3gITbAYtuO
	 OVGYWsKwbi8IO37CaFE2HEB0fDOs4hl0Tb0dKtYdCH+xuI5eqyhQN3nT4LlGcGD75i
	 0iD0a6P7RD+tg==
Date: Wed, 28 Aug 2024 17:47:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <edward.cree@amd.com>
Cc: <linux-net-drivers@amd.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, Edward Cree
 <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 3/6] sfc: add n_rx_overlength to ethtool stats
Message-ID: <20240828174719.5c38dad5@kernel.org>
In-Reply-To: <e3cdc60663b414d24120cfd2c65b4df500a4037c.1724852597.git.ecree.xilinx@gmail.com>
References: <cover.1724852597.git.ecree.xilinx@gmail.com>
	<e3cdc60663b414d24120cfd2c65b4df500a4037c.1724852597.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 14:45:12 +0100 edward.cree@amd.com wrote:
> This counter is the main difference between the old and new locations
>  of the rx_packets increment (the other is scatter errors which
>  produce a WARN_ON).  It previously was not reported anywhere; add it
>  to ethtool -S output to ensure users still have this information.

What is it tho? Not IEEE 802.3 30.3.1.1.25 aFrameTooLongErrors ?

