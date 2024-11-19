Return-Path: <netdev+bounces-146070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AD89D1E6C
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 03:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C03F9B22861
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 02:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F8A142903;
	Tue, 19 Nov 2024 02:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnKZ+gNN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BE333F7;
	Tue, 19 Nov 2024 02:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731984633; cv=none; b=laGQhN1tXfTTd/zTOsic0C0iXVrYs+nLDf0gbdiXtFRcDzTPDuaQjr/HfsjtxNl1jJLdWpot8YMdKbj+fPMAej/BNaQW+cAsGOjB22v/qrR8Rv9dMLv70/X7yV/k+SVMT3nnCAm2QBBwOqtNdmom9Wg2v5qIuL2ziHTlyOQBzoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731984633; c=relaxed/simple;
	bh=13d8QrR93Xb4ZQ44j39gzsQ5AXUFt1ZlAqqHY9Q8ARg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C0J+QnZZ5h7jbi7HhtQ+7By9nleRp8aHLvKiITCsOlAxcfs8kS8V/BHzRVSXj5jVJqIN16QgzzyraK+1+bi3BYUDN2EvWE7T3r/4VTDazjMjUCcRQ8Bwz09tTiXlwjUiCejHNRtQ7hNi0etPEzA/5LbvdMwqUEK+yC8YWwZydCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnKZ+gNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E893C4CECC;
	Tue, 19 Nov 2024 02:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731984633;
	bh=13d8QrR93Xb4ZQ44j39gzsQ5AXUFt1ZlAqqHY9Q8ARg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CnKZ+gNNPFD/CdCGXL5bkDftnMtFHXGeumq6PLPjAL3h5x335XvfvbzKcSYrszVAJ
	 hSF78ESWyj65dZjHhhQMU8fCAvf6dPt3Fcu1fyGqMtrEwyr8fsEucjr+xgMJhFIvrc
	 hUw3t4yIATy0GDAfMQshFeQldQBIuR+crhH72z4NBqvqnS4ZvDnQ+REGi+jBCvmHGF
	 0UW/78XQRI6zva6y0fAOZahxATwaDf0lPdbn5KJg6B44LoztOIrI65E34yS8EHHCAU
	 APckt8hPdiIgkO4jySDhMVr/4rh+UxK0UtKQbuc/tBvbF+XTSM/yyHC4eHSncWa41U
	 2eOqNlN70bPxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD143809A80;
	Tue, 19 Nov 2024 02:50:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/2] binder: report txn errors via generic netlink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173198464425.82509.5510498635851366417.git-patchwork-notify@kernel.org>
Date: Tue, 19 Nov 2024 02:50:44 +0000
References: <20241113193239.2113577-1-dualli@chromium.org>
In-Reply-To: <20241113193239.2113577-1-dualli@chromium.org>
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 donald.hunter@gmail.com, gregkh@linuxfoundation.org, arve@android.com,
 tkjos@android.com, maco@android.com, joel@joelfernandes.org,
 brauner@kernel.org, cmllamas@google.com, surenb@google.com, arnd@arndb.de,
 masahiroy@kernel.org, bagasdotme@gmail.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, hridya@google.com, smoreland@google.com,
 kernel-team@android.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Nov 2024 11:32:37 -0800 you wrote:
> From: Li Li <dualli@google.com>
> 
> It's a known issue that neither the frozen processes nor the system
> administration process of the OS can correctly deal with failed binder
> transactions. The reason is that there's no reliable way for the user
> space administration process to fetch the binder errors from the kernel
> binder driver.
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/2] tools: ynl-gen: allow uapi headers in sub-dirs
    https://git.kernel.org/netdev/net-next/c/6204656478be
  - [net-next,v8,2/2] binder: report txn errors via generic netlink
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



