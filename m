Return-Path: <netdev+bounces-79787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D0A87B5E7
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 01:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1945B22291
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 00:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEE77FD;
	Thu, 14 Mar 2024 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFOsIlCc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F47A31
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710377431; cv=none; b=UtIOUT4OEXH2lIUREDGL/jfSNT1ARAzD08hDbDoCQMi9xg3F8h/mId+s4ieCTXLO6G43NO5/7hkBq3LfrCHCY4SRCcEjvcqoa9NqRkK/B8WvPcn9Kj1mRHu2tzogDEKfIsp+vhafac76QTCP21Bc7wFinPV+iclBPpXBX4Yjt98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710377431; c=relaxed/simple;
	bh=n4fFCWkR4BLa8H0jY4rCqi/q/CFCUAwF04zFqYkGeyM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j54pQKQgb6tmNCzW4/ZMHVm23Idmk9/3ZsR67MNDDah6ruk3PUFRjceLJHr8BQUunGlUB44B9vO9cxDzqsGsVjBQdiiUwueYtsoXF11ZwIgpFYP0Ib9vdXhBv4tA6MBab4CQQp+qH8f7B2YW9bqaFX04auohPpSFwqdPnSH/WIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFOsIlCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 330E8C43390;
	Thu, 14 Mar 2024 00:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710377431;
	bh=n4fFCWkR4BLa8H0jY4rCqi/q/CFCUAwF04zFqYkGeyM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WFOsIlCckRbJ+xLH1ajkz/d8TAzAut+YVhLYdTfz30SQ24U+OwazdTfetlufHjVIe
	 Cu/9QkXcjZagO7FGKH35zL5MHsZFIV84n/Uquq97hwdayHStRX5I6pmcMMxc4ZFmi4
	 Wtqi0QW3w88CmvmVd17F+5BndJDp5DWCYY+fA8y/tDaiFHPSz5gxzDwvXgc3sH6ow+
	 ZV+t/Kj6Kb06N4QccK0w4yK/FF7r/Zkel4GNZfQVTAEsXhw0q8TXS+RB2Mw+IuNQAk
	 jbVqI36ZgeB6KbMWAsp5DpFoLLnLeB07eS0yP5wCPgZOA4AomoNzh+v6pAru2xkXok
	 vAchLTST2Naww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B3CED95060;
	Thu, 14 Mar 2024 00:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 0/5] tc: more JSON fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171037743110.4840.5612842404494622727.git-patchwork-notify@kernel.org>
Date: Thu, 14 Mar 2024 00:50:31 +0000
References: <20240312225456.87937-1-stephen@networkplumber.org>
In-Reply-To: <20240312225456.87937-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue, 12 Mar 2024 15:53:27 -0700 you wrote:
> Some more places in TC where JSON output is missing or could
> be corrupted. And some things found while reviewing tc-simple
> man page.
> 
> Stephen Hemminger (5):
>   tc: support JSON for legacy stats
>   pedit: log errors to stderr
>   skbmod: support json in print
>   simple: support json output
>   tc-simple.8: take Jamal's prompt off examples
> 
> [...]

Here is the summary with links:
  - [iproute2,1/5] tc: support JSON for legacy stats
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=fc4226d2475a
  - [iproute2,2/5] pedit: log errors to stderr
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=ba52b3d4dd4f
  - [iproute2,3/5] skbmod: support json in print
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=af0ddbfa51f9
  - [iproute2,4/5] simple: support json output
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=69d55c213da8
  - [iproute2,5/5] tc-simple.8: take Jamal's prompt off examples
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=11740815bfe6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



