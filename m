Return-Path: <netdev+bounces-138581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCCD9AE33A
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 13:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E31361F2319D
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 11:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEB91C174A;
	Thu, 24 Oct 2024 11:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n54lsoti"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9AF1B3954
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 11:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767735; cv=none; b=K6vOmU+F93HS+1Ej8ffUVVh/15jw64l9libdIhTtBoD/v264dn9eijzXEV2Qued/D0VLcwHhOd2O0qY1+vTie5taUL0iP6UU1qcJwr/9FoDGeg2W8pGVkTzpKxyG5mULpoD2mvsHUGEOfJTuytBRh+cunBc8PQK80t33bmJjeWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767735; c=relaxed/simple;
	bh=X7ALf/7jO6mxXtlnsi2jMka+ACsTXoH81UhBpVUUKK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDoTd6t6/JHlyveYAIZUMdCbgGyrt5ZLVTYdxb/FDl/RY2aWWX3aYJlrpD0/3dxmezZUOMPDs8isvEAyZEUJVySGIYNKy+Bvj9pkf/YLqDYB78SS7GHyhJzbszx+B1MJx4NEySoH8M1NQouNq7mkqKYzvCK3nNntNgCLNSau85Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n54lsoti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AACC4CEC7;
	Thu, 24 Oct 2024 11:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729767735;
	bh=X7ALf/7jO6mxXtlnsi2jMka+ACsTXoH81UhBpVUUKK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n54lsotiBPxAIdeDnhBHvcxJTUXJluMn6PUN7tImW9WXhTiHmCSguyzWmcsQiXE5+
	 VvZv3H4JXJ+I5O1+f6CiW1GZr/jk86aSqJqMor1SbvagLhNy+A5nLA2diBuSiU2GUU
	 MlmzGQHol+/s8ws6cP6bsYoXcCzXcZxoUZaVlCUI7QqStxCUTX0Y1CLCgLeeSc8dI8
	 AZ6bgtIBfRL2T39HiMh8MkVev0U5Il+kqgo5o9p3fZjN9hU0+2Slx6mfY+k/L9WV0l
	 61L1iBBioxxpRRWNFJ1ctQNi+5rgNUiFzPWUANXwrTeUJzdebTgUCUOjWwzfRc0pSI
	 4Zmuoff17U9/A==
Date: Thu, 24 Oct 2024 12:02:11 +0100
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next] rtnetlink: Fix kdoc of rtnl_af_register().
Message-ID: <20241024110211.GB1202098@kernel.org>
References: <20241022210320.86111-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022210320.86111-1-kuniyu@amazon.com>

On Tue, Oct 22, 2024 at 02:03:20PM -0700, Kuniyuki Iwashima wrote:
> The cited commit made rtnl_af_register() return int again,
> and kdoc needs to be fixed up.
> 
> Fixes: 26eebdc4b005 ("rtnetlink: Return int from rtnl_af_register().")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Simon Horman <horms@kernel.org>

