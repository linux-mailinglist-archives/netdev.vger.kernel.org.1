Return-Path: <netdev+bounces-81361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDDA887653
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 02:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18B5D1F23460
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 01:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9303A1362;
	Sat, 23 Mar 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCsQDd+M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D733EDE
	for <netdev@vger.kernel.org>; Sat, 23 Mar 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711156229; cv=none; b=ZWQrgDkRRG98oIcFN1Of2w615gEGTrV+3F7G3XRCpAWIugKn85eVg9QVX5eLPy4jPABVYjwgvZVKli6lZ4wTkzO1SToAYv5o1GD+k+I9c3ZzWszFkhwBQadyVZ23Le3og5BvSCLzZKCqhovFuxUs4uoRN2h5gXYJfLHLdclwi1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711156229; c=relaxed/simple;
	bh=810ZtMthCMFTLFIr4zM5sYjE7po9AbiIt9AbkIl7xUo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dFjc9oWo1pIUPppV9YCwP006etfnST186pt64mtUEMdWisGWiFYUalF3+FdSYpSthMv+3+r7SP09EDrp46wpaKzWmomsbuPxeGQysmVXG4NYdDIWCjaj2MC2FeffVQhn9iM816JjsbtUok3Ulhnyd9aE+MPkwEy0lekWj09lNYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCsQDd+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF319C43390;
	Sat, 23 Mar 2024 01:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711156228;
	bh=810ZtMthCMFTLFIr4zM5sYjE7po9AbiIt9AbkIl7xUo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fCsQDd+MXVz4416Nfg7aN3CIHqeVCnIr97PYTi3fDMXIJVtuLqifbFR1nYGwegbNC
	 nILXN0dzukamSCFI5eiYoWC4scLJj1R4UiUudO/1zbEjY8n75LXj1xoOaMj33KTL2X
	 fQnlK9BwZ/oj58tlQUzczTflWN5v4Vn72oGDhljF1Z4R7WbUE4SeQN+rx2Y4uOrucO
	 9dgFpqMDFmfnk5ku/TpvfqqzFq8Ff6DkfSiEd4VmrjssBE7RVXqq6dmWyL3O0mF+vd
	 5QgaWiTIPynFU3ujo/bWWnBiPhdwUppIUUK3Sn6G20nbOr5nBz6LR2QCLnwUdy68Xb
	 Wy+tnUs0XbyEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6E03D8BCE2;
	Sat, 23 Mar 2024 01:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tools: ynl: fix setting presence bits in simple nests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171115622880.16003.8021813998406967782.git-patchwork-notify@kernel.org>
Date: Sat, 23 Mar 2024 01:10:28 +0000
References: <20240321020214.1250202-1-kuba@kernel.org>
In-Reply-To: <20240321020214.1250202-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, sdf@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 Mar 2024 19:02:14 -0700 you wrote:
> When we set members of simple nested structures in requests
> we need to set "presence" bits for all the nesting layers
> below. This has nothing to do with the presence type of
> the last layer.
> 
> Fixes: be5bea1cc0bf ("net: add basic C code generators for Netlink")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] tools: ynl: fix setting presence bits in simple nests
    https://git.kernel.org/netdev/net/c/f6c8f5e8694c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



