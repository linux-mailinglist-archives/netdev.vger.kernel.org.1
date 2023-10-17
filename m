Return-Path: <netdev+bounces-42013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E59057CCA5A
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 20:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41751C20853
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 18:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C7B2D7A5;
	Tue, 17 Oct 2023 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mO2Rr8W0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD1F2D785
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 18:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA915C433C7;
	Tue, 17 Oct 2023 18:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697566068;
	bh=qdp8zt/SyqX84+XEvTR8T4viC6UtPmwaRZ2Nrg4z0jQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mO2Rr8W0FRwgtwYk9Q2HQ/xZQYBklWH5wB3x62OC2ro04OJY+7wE4+ekUyHzbv8Zo
	 nLZqlrdMb5dY0XSu2wRUYv2KjBFYlz0MzhOfDCxST36sj2nWsYwCTV4zQbx0z6/pFD
	 eELYQLOCB4tqvnW22392AIZOtefbrnVfrdM6d4BezoLjgZMFs0irmeCzcjZlc2XxEE
	 xpGiODy/FDT3qxnHA9WSuDYGH6lKKmYfeYJKHVhKXTJz3tkibRGGFuSge18rwjFTrp
	 ZL7nUTVEH/QH95DXCenzXH5XdoyuGMF7HUYZSMSvrH/RsvB6PA9mM6FSzaBQEwUL2h
	 PJxThwcnCpiiA==
Date: Tue, 17 Oct 2023 11:07:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net 3/5] net: avoid UAF on deleted altname
Message-ID: <20231017110746.4f26b779@kernel.org>
In-Reply-To: <ZS630zlfkUGEi5vg@nanopsycho>
References: <20231016201657.1754763-1-kuba@kernel.org>
	<20231016201657.1754763-4-kuba@kernel.org>
	<ZS485sWKKb99KrBx@nanopsycho>
	<20231017075259.5876c644@kernel.org>
	<ZS6yBP+aZk67q8Tc@nanopsycho>
	<ZS630zlfkUGEi5vg@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Oct 2023 18:35:31 +0200 Jiri Pirko wrote:
> >>As I said in the commit message, I prefer the explicit sync.
> >>Re-inserting the device and taking refs already necessitate it.  
> >
> >You don't need any ref, just rcu_dereference() the netdev pointer.  
> 
> Oh wait, you are right. Sorry for the fuzz.
> 
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Thanks! I'll improve the commit message for v2.

