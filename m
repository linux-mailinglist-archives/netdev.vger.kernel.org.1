Return-Path: <netdev+bounces-116905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9AC94C064
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE771C2237A
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023E718C906;
	Thu,  8 Aug 2024 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0EVaw7S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC90274055;
	Thu,  8 Aug 2024 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129137; cv=none; b=DbQ8DgtH0BpOkm0ZBFsrZ7Ezuceeypy66kUSQxS90gxbJKWY8/bewU1B9X58xgtdxFEOmKayKWUk405sfNiSNJbIa0A/BEsuMlr5lVN/YGsvNGs3tYcrCQc24nZKhSoOnKuZp1COXG9p2acvu8YkSpvsMffGPAtPQ6CELtbAUyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129137; c=relaxed/simple;
	bh=1xFpFv0UaX4Qb7zkl3vemSFGJPHGy7R42GvMUgNq5to=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mkYLJ7Uq/C+Ukvy4sZ0+yU4Jvb1ye1PdeR+51JD9VqWFCi4GxxbMTmlBZIePoi4SjovRQkVe10q5M0smKumxac6wUzAq1CRZQTRKIOHeNMoG+jKRRUxdoJ1HqekDSyTwaRW0L6/BdnPJ1KssQiRJKZd8BuNO9MUD2G1Ia0Bt5HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0EVaw7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0669C32782;
	Thu,  8 Aug 2024 14:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723129137;
	bh=1xFpFv0UaX4Qb7zkl3vemSFGJPHGy7R42GvMUgNq5to=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O0EVaw7S1mff7AkH0b+OOHP66PDBpU4gVBYrInsNtozHKeVHsxkdkdCpfxksIugEU
	 TXCMmweBRAq7+EFynetCYN14LvflVcrZSMcSFU62u7nE4rG5Ti+pzFBIdt80JeLw1F
	 vKbGY6QEH6QV0tEAzIDxE6QeoB6stgcC1Se+TEBCtx7gU3+ALGWWmTYicc7o2pVeX5
	 HXJlamNGs2rFgR0TWPDE8WtnU8xVi4oHYXiwxMLVdJk4srRKM6dc3hK/0nUwS/LMGr
	 zZbAJXS29MPlNDAWmeJMo3bEue+/izOOiV2KpMCah6uXy2BRuo8RN6/KYETWduYlLf
	 BOWbCMuThbAEQ==
Date: Thu, 8 Aug 2024 07:58:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, u.kleine-koenig@pengutronix.de,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: moxart_ether: use devm in probe
Message-ID: <20240808075855.33efccbe@kernel.org>
In-Reply-To: <20240808040425.5833-1-rosenp@gmail.com>
References: <20240808040425.5833-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Aug 2024 21:03:54 -0700 Rosen Penev wrote:
> alloc_etherdev and kmalloc_array are called first and destroyed last.
> Safe to use devm to remove frees.

But why? Refactoring old drivers is often more risk than reward.
How did you test this change?
-- 
pw-bot: cr

