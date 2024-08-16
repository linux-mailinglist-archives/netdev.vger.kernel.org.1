Return-Path: <netdev+bounces-119029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC3D953E4A
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 02:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B7A288BA1
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 00:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7009910FF;
	Fri, 16 Aug 2024 00:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuPDTMF4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EC310E4;
	Fri, 16 Aug 2024 00:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723768158; cv=none; b=AYO+/gaIzkoUc96uCZuMEcs5CSOjLAkg6FN1tDca45ruKahjuMLdg2pTThIxQo2VRpJX9Y9veRgZFr8hwMT2xJtKaBOHVmlE5oLka7CzQJeuM9Suedmb6LFqkTTcv6U7EfPkn+05bkFa/kuGexvskqlO+ebdMf3EVgmaxVu2cIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723768158; c=relaxed/simple;
	bh=O+Sd2MWOnr5NJTgvYNtdWZBZ6/GH4gLkufhqIXqOLHY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9Ip1OWc8aeMz5nBEk5BpSzNIyqVVzepN7XCNXj2QDqrabxKAKpd0Vy754fQ7Ksu0pUDsOzdP7FHdktUfhCi6qS9T3thhXpLwh1AJRg7dgorUZ1LCYSJ45oXdkU+I7ddmsvxgAmxS7L+2xju+BLyYh94piEtCiLdw1tFUkk8Ek0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuPDTMF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79934C32786;
	Fri, 16 Aug 2024 00:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723768157;
	bh=O+Sd2MWOnr5NJTgvYNtdWZBZ6/GH4gLkufhqIXqOLHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XuPDTMF4BxRKgelD87yEpQpi5rjmels+lSRcTgbJ4t7quIWZ5SR4ru4r01STP30XH
	 OM5Rvz4x2rfriNcnaNl+Q/639Nz2BZrSTC8S99eBiH5+z7AIL7bVzcdgfWRsEyrz+i
	 is4Jvn/tu9yvw5CqrDOEG6fTw9YvGJWMyaEe+aQuwlRUzuZ1jSqRe+LfCKy+Mrye3F
	 lvnfWYQdS9HwBL07E7+YKUSmfCPVjZFXrPspNEHqM4BWLag+LQYxCh+tNAsUW5JnSw
	 OaEcdO07phvpU6kD01NeBVYFWnzcutt/ylJhA+xgGlKcF+Qrk+FX2J1UPNFgni2vt9
	 lipYxU2zYsCng==
Date: Thu, 15 Aug 2024 17:29:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Moon Yeounsu <yyyynoom@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: dlink: replace deprecated macro
Message-ID: <20240815172916.555a992a@kernel.org>
In-Reply-To: <20240810141502.175877-1-yyyynoom@gmail.com>
References: <20240810141502.175877-1-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Aug 2024 23:15:02 +0900 Moon Yeounsu wrote:
> Macro `SIMPLE_DEV_PM_OPS()` is deprecated.
> This patch replaces `SIMPLE_DEV_PM_OPS()` with
> `DEFINE_SIMPLE_DEV_PM_OPS()` currently used.
> 
> Expanded results are the same since remaining
> member is initialized as zero (NULL):

FTR this has been merged, commit 2984e69a24af ("net: ethernet: dlink:
replace deprecated macro") in net-next. Thank you!

