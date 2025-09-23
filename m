Return-Path: <netdev+bounces-225445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E90B93AA7
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 02:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C70E171491
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 00:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE9F1DFFD;
	Tue, 23 Sep 2025 00:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVoQBDYD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA77DAD4B
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 00:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758586211; cv=none; b=gBhNm/eNxS6/vLdbn920rzbH5yf+9Z+jdikxwSfidkjhy4E0817ojrh6V0erougSr4yQv+Epn3Ezr/mB06FDQJpH40KeNa9U8reLZN5I54oQhEmgJzhqkIm3hfi40yJ7yddSoSedQPl+SzmNRYRy521tLP6RkqZNmXHoWoPLNic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758586211; c=relaxed/simple;
	bh=M/2g3gV7thIWEXLgt0tmJevc7CcRyVSYblAWfMoDuyM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q0nBqBM2VmgIBfK2lidJ1y08Xse7RRk4n9ZFavlDcSpbV8spgzx0/+s0OfJwuKG3AAphE5EG3h+P6UnwV73iFgnNDcLMjfKnD27+O+RxLdFwjSueSIrKYZ/N/Gpd5zFPmUWqgoNJUlPUh30r5Ilru8FPRwToorKuQ3X4xqp1JjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVoQBDYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D899C4CEF0;
	Tue, 23 Sep 2025 00:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758586210;
	bh=M/2g3gV7thIWEXLgt0tmJevc7CcRyVSYblAWfMoDuyM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bVoQBDYD//EFLgzkIe+RygBq2yd9dI9qi93UyqJsa+pWuIGq4ldo+GKWeer1a0pt7
	 KIHGZ9JeZ3/PxTiDFGQAY1QvKWr1ePSEx9gYBu1wqmAAaBhmpbhgWXXgl6BCvZLO6R
	 sO9bpzTaC7JWAT31bbhgv1z3TnAAMR5vNVBMbmJ2+jE8P41RwGa47fqIlyokC2m6OY
	 AiqdkFcLnszrnvzLT5VgZEK6XzJtAG5odLxG8ejBvKmOisxvSnv9cS5Az9i3xTc2hu
	 nNHrsvrL0pvSmZCUfLtx2ajL/Hw9iTVRu7ot/TFEwrSzbxj4Fpa09wWHK4H9f4NUtV
	 ekSjTiMPOao1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C1B39D0C20;
	Tue, 23 Sep 2025 00:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] xfrm: xfrm_alloc_spi shouldn't use 0 as SPI
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175858620800.1201993.18439475539235124519.git-patchwork-notify@kernel.org>
Date: Tue, 23 Sep 2025 00:10:08 +0000
References: <20250922073512.62703-2-steffen.klassert@secunet.com>
In-Reply-To: <20250922073512.62703-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Mon, 22 Sep 2025 09:34:52 +0200 you wrote:
> From: Sabrina Dubroca <sd@queasysnail.net>
> 
> x->id.spi == 0 means "no SPI assigned", but since commit
> 94f39804d891 ("xfrm: Duplicate SPI Handling"), we now create states
> and add them to the byspi list with this value.
> 
> __xfrm_state_delete doesn't remove those states from the byspi list,
> since they shouldn't be there, and this shows up as a UAF the next
> time we go through the byspi list.
> 
> [...]

Here is the summary with links:
  - [1/2] xfrm: xfrm_alloc_spi shouldn't use 0 as SPI
    https://git.kernel.org/netdev/net/c/cd8ae32e4e46
  - [2/2] xfrm: fix offloading of cross-family tunnels
    https://git.kernel.org/netdev/net/c/91d8a53db219

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



