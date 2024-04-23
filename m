Return-Path: <netdev+bounces-90571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8F38AE8A2
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 15:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2666B25823
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB9313698B;
	Tue, 23 Apr 2024 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2CYdMDd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19524136989
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880229; cv=none; b=VyRyzlwQXdl4+IVTCQjXEMv/et8HYmaWKGQ44DqlJb16jMCqSzud0eznh3QvkWBJNZ9H5wQLMz52sLaWjJXsN8rLxzLBOd4jUL9NMPYXPEIDgp+wda7ndnb2vkuMldc0AXlEdj++CyCJuvGKp/3eyYCQkChTlMTJvF6P4YHgNMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880229; c=relaxed/simple;
	bh=1GvNI/DgpgoE3hvfJNSzqsrzgjENREL6iWBCPy/Qo3o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ce/f6Wc7XBBu8v5rNhSONPSclwfis32YI0R2e08UFvLoRWU+miUMRczystxu5jtmzc25UQwErrXlXRFNauZzhR5MKUGZryxM6te+LBjm+ENLg3xFXHadwDneukjEZMiAMs5Xw5rB1//65U/9hElK84yL63M9HWMEVLn72N7/YJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2CYdMDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E62AAC3277B;
	Tue, 23 Apr 2024 13:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713880229;
	bh=1GvNI/DgpgoE3hvfJNSzqsrzgjENREL6iWBCPy/Qo3o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W2CYdMDdeBnGZWDX4kSwWwBQzZ9eeI3GXYKdF/U4muiULuqtmL4FKyFrxETbFHLqx
	 k5dMJ51buxpkOp3v8a1Y+uheB7+jx/nkjHw6IQ0CUcNQfHn9lQGNYfxb/kklETSFCn
	 QSAwu60ISiHNdtWZzsU05sL1Qiej1m3jQdBmZn+prZVPy89NBQBSFD73UjMdVxPZhq
	 o/WDlHYftojnZGrDafBkA0JOvCngL6oldZ5irSSCNfAGKrnZ4rQtZv23S2FBTYulAg
	 0947jqERhtXqY/bJKypPdTd1h2DQb6GvjW5zDJG0NWskxgmp4uec67L2OYZ8mbX3QJ
	 bBCX+AXrB/Itg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D416CDEC7DE;
	Tue, 23 Apr 2024 13:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tools: ynl: don't ignore errors in NLMSG_DONE messages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171388022886.4537.17723678422996074724.git-patchwork-notify@kernel.org>
Date: Tue, 23 Apr 2024 13:50:28 +0000
References: <20240420020827.3288615-1-kuba@kernel.org>
In-Reply-To: <20240420020827.3288615-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com, jiri@resnulli.us, sdf@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 19 Apr 2024 19:08:26 -0700 you wrote:
> NLMSG_DONE contains an error code, it has to be extracted.
> Prior to this change all dumps will end in success,
> and in case of failure the result is silently truncated.
> 
> Fixes: e4b48ed460d3 ("tools: ynl: add a completely generic client")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] tools: ynl: don't ignore errors in NLMSG_DONE messages
    https://git.kernel.org/netdev/net/c/a44f2eb106a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



