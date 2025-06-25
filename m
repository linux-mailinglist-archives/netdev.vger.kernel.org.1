Return-Path: <netdev+bounces-201350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16311AE9155
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 00:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A617F1C279E8
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 22:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EED2F533D;
	Wed, 25 Jun 2025 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvRNwwXw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5E52F531C;
	Wed, 25 Jun 2025 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750891829; cv=none; b=rHqGQvT58y19+nH89zeBq2ENimQJQsZ73ZOQnc8bgVTl95QW3mFrupEyJMMcehzMFjbhXMRJOGo+kvMETM5PL+Eu5UCtE+MO6X257u41A0Rt6Qiplpna57scGtGcKh8Yuc6wUKvQVbZDR7yK+KNu/L+BP5vpEe7D1/gE9xvuPEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750891829; c=relaxed/simple;
	bh=FT21782BgGq6b28t9oTv5V3syYC1vBZKY4HikPiL8MQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BqkUtB3tawMRlv+Xu+v+kOd092jWCDGNl/1zy49xh772QJRCjfvYNOwNfbidIUvzetc3CnTNoq5Giktlg81n0LFFoNBmD5AkmgThJqPVBazhM+dGT7z06ZvGqr81amjs3NOiHAxaRC2DwCkjLE4534Ct4ioE2l7xu36NQFJpjFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvRNwwXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A448C4CEF1;
	Wed, 25 Jun 2025 22:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750891829;
	bh=FT21782BgGq6b28t9oTv5V3syYC1vBZKY4HikPiL8MQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GvRNwwXwqyw7tg6uw+JODa+GadjYIlrGYXWpiTuUEz35qTZ+7fCoZVTPseir6Sple
	 E4PreJtc6cH5hCGw8sSKfXC7YD0mSmmJnS7cDtdU8826iVO83DwvHfNX4AiVjj8soE
	 HO00UeMYlbOO1ThDzghiMWwOZhZhgy3yGr2PfSTEUu00HBHxRZXa1bEmC9pcT+vDb0
	 k1YGLfiKLAyQzJPro+KNoxKZJ87fG1cUfI3zm8zRVv4wHrkcB/vjttQ57vV1CWUpI7
	 rnnlW+wRvzBxSc1KINerBWeSCmmJUyaDPe4Xl7euyqE3nQwGQL65BTD8fNwrXtGIB8
	 EuYb6EqMXWxrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADAA3A40FCB;
	Wed, 25 Jun 2025 22:50:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] uapi: net_dropmon: drop unused is_drop_point_hw macro
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175089185549.646343.1625769414535488237.git-patchwork-notify@kernel.org>
Date: Wed, 25 Jun 2025 22:50:55 +0000
References: <20250624165711.1188691-1-rubenkelevra@gmail.com>
In-Reply-To: <20250624165711.1188691-1-rubenkelevra@gmail.com>
To: RubenKelevra <rubenkelevra@gmail.com>
Cc: nhorman@tuxdriver.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Jun 2025 18:57:11 +0200 you wrote:
> Commit 4ea7e38696c7 ("dropmon: add ability to detect when hardware
> drops rx packets") introduced is_drop_point_hw, but the symbol was
> never referenced anywhere in the kernel tree and is currently not used
> by dropwatch. I could not find, to the best of my abilities, a current
> out-of-tree user of this macro.
> 
> The definition also contains a syntax error in its for-loop, so any
> project that tried to compile against it would fail. Removing the
> macro therefore eliminates dead code without breaking existing
> users.
> 
> [...]

Here is the summary with links:
  - uapi: net_dropmon: drop unused is_drop_point_hw macro
    https://git.kernel.org/netdev/net-next/c/2855e43c6bb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



