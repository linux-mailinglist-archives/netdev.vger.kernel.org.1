Return-Path: <netdev+bounces-188823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C86B0AAF056
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 02:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 181457BB469
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 00:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C6486358;
	Thu,  8 May 2025 00:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/de3aVF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F375D28F4;
	Thu,  8 May 2025 00:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746665702; cv=none; b=K7andJbmvzanjYRZarGEtmewcOfUVF9uzg3hMhPEI/mDqCBHE6NPJab+WPaNzsmmNsc9siScmZzWQoI4vVCBk46xjZDYlB5Mntu9gjTCAZLB6O2mTI9HU5/0gSD20dAvX3I42nd3TVIXCPtg9yrWii8RBgYf5SolNpoffK0wISY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746665702; c=relaxed/simple;
	bh=rjrC7dJ3QkqnJj+EnaYNx/UunbgEx4/CmVt3XquJksc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=An11eJfHipapcuam5Q1kipKYs2IgoYW/mkO1fNFsd+ZcCnqToatiliGuq6+vKdFbKsaEr3ptz2PuQQhw4I/1DeEeRYyojJC+uvmq2Q2bFx1Fx3BotPa0l5Y3Zce0b9zqEkV9E052njn3WPiGwtRerM25BNRypKOxIuOd+xjRulU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/de3aVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB7BC4CEE2;
	Thu,  8 May 2025 00:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746665701;
	bh=rjrC7dJ3QkqnJj+EnaYNx/UunbgEx4/CmVt3XquJksc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M/de3aVFaYcX4xM9agszODj+hreJQr6uHVyc6WFNRKYQl3x20pQC18PbeEWxzGcsv
	 Li/qMrwiw6cswaPxN7iAqGWY88+DR6PodwepJ3Sg9AMJTDOQZwdpRO2e6Q+sXuDOKA
	 jFmiZDXy+LwSDRzMMpfrhUVJy55bgfVY3TGDLQ4YWT5u/QAhDfItmbXFKY2OZ2+XH8
	 7W+9kt0bwuljO6vRTRs64dNpdhmFzQMn601QiAIdmlpcsBv47/4co0i0eTT/P6k2Ig
	 nKBE2sGF+pFEid3Bi3d7mbrhNmPnPMzWq5UbAEQMH9AYo0zm9PWhAcbFl9c/9ysqv6
	 +ri/ITg2ZMGfg==
Date: Wed, 7 May 2025 17:55:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2025-05-07
Message-ID: <20250507175500.2d725b00@kernel.org>
In-Reply-To: <20250507170320.277453-1-luiz.dentz@gmail.com>
References: <20250507170320.277453-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 May 2025 13:03:20 -0400 Luiz Augusto von Dentz wrote:
> bluetooth pull request for net:
> 
>  - MGMT: Fix MGMT_OP_ADD_DEVICE invalid device flags
>  - hci_event: Fix not using key encryption size when its known

Looks like we have a tatty Fixes tag in here:

Commit: 9840f8ecc910 ("Bluetooth: hci_event: Fix not using key encryption size when its known") Fixes tag: Fixes: 50c1241e6a8a ("Bluetooth: l2cap: Check encryption key size on incoming connection")
	Has these problem(s):
		- Target SHA1 does not exist

