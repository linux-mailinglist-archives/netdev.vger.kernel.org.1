Return-Path: <netdev+bounces-96222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF4F8C4AB3
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 03:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E6328464A
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 01:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468C11878;
	Tue, 14 May 2024 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGE1wHwa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1474115CE;
	Tue, 14 May 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715648430; cv=none; b=h71Js85x0JvIjhKhcJbNazCmmRn+vULpJNbccICXBLLAgiZOnrExZivHsgvkxTwxbuU0cG63jnnxus/Vo86MAPs9jztDnqwvBS7rnYtOwqDdNVL35ehxFmyplBxKJvf8lOrtPzpcfZsq5T3rzbNhnuqeGtkzmc/65iiCJLTMiM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715648430; c=relaxed/simple;
	bh=tex67ROWkh4NHwRY33hOc+4fTpPBuNxAxyVsPksJt+8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XKjn1RS9oulKJa5eUdkhIZakDOnt2Db3Kr9dMO1SlYBabkz8PBd4kco2w2n/fKWPSpeqWHXnIRT9QpJV3ndQRIb0wByu/uthF1QA1tSgmZD2k1InlZZVv8C4ipbKcpRthDTa0Bxt5wHGS4N6R1ec1TgTPhx5qxXjG1iE5x6EsII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGE1wHwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4B56C4AF0A;
	Tue, 14 May 2024 01:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715648429;
	bh=tex67ROWkh4NHwRY33hOc+4fTpPBuNxAxyVsPksJt+8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tGE1wHwavggZavCmGTnx5msI7xOUslc0bp0dW48tmm6zZo0xgP+lE//lcsOscCdlz
	 f83uKG0CxpPDFhM2UL6GMEbIhychYBELNM0J9K+VO63JkXayas5dA6UyAZ0IC2Bv9o
	 m1ota997x9ZwsFbAWesfloUcc23tGhiz8FL/zNxwka8i5JYQmqUy/VY5vcbTwpql1e
	 Tf0ZZQegypp5g4LWxWYYf2PkFvvoryPjD+UpmzM5rctMDbPgLFXMqAEPP4XEv3ti6m
	 4eKnimz9XNUAVhxivW5xsyRQSNboNCidFYwZLUk6smEZqtL5IlpBoxz55edkO008t0
	 6fwMRl9iMahLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A4F5C43443;
	Tue, 14 May 2024 01:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: prestera: Add flex arrays to some structs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171564842962.4255.15459497362848751312.git-patchwork-notify@kernel.org>
Date: Tue, 14 May 2024 01:00:29 +0000
References: <AS8PR02MB7237E8469568A59795F1F0408BE12@AS8PR02MB7237.eurprd02.prod.outlook.com>
In-Reply-To: <AS8PR02MB7237E8469568A59795F1F0408BE12@AS8PR02MB7237.eurprd02.prod.outlook.com>
To: Erick Archer <erick.archer@outlook.com>
Cc: taras.chornyi@plvision.eu, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, keescook@chromium.org,
 gustavoars@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
 morbo@google.com, justinstitt@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 12 May 2024 18:10:27 +0200 you wrote:
> The "struct prestera_msg_vtcam_rule_add_req" uses a dynamically sized
> set of trailing elements. Specifically, it uses an array of structures
> of type "prestera_msg_acl_action actions_msg".
> 
> The "struct prestera_msg_flood_domain_ports_set_req" also uses a
> dynamically sized set of trailing elements. Specifically, it uses an
> array of structures of type "prestera_msg_acl_action actions_msg".
> 
> [...]

Here is the summary with links:
  - net: prestera: Add flex arrays to some structs
    https://git.kernel.org/netdev/net-next/c/86348d217661

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



