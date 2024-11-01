Return-Path: <netdev+bounces-140899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4919B891C
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 03:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183D81C2164D
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED2413211F;
	Fri,  1 Nov 2024 02:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXYLeujq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3008C762F7;
	Fri,  1 Nov 2024 02:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730427022; cv=none; b=C59S6mXWk72Iz+Xv6zhK4wLL8rQOYlfAQBAoyQnHHQhTg+4YKhixURKNFlzVHKGNmRIN85nBjIyM2aEmYzMjNbuCwNkHvdUwWv/Ixu2rjQUDaCboEUljv+USml/xcdawquQjBDObqTyqqlzdgPNHJGrCjcRunD4HYaXHrSpG07o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730427022; c=relaxed/simple;
	bh=434GrK+5RrXuOXbsNXdMgMWxvF6vZmC8e5FPvlkKo8M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BsOAMbM9LrF4drSV2LGe8HS3/gZcCzLdnEvVyko1MtrpqqP2GfyzqJ/tR4eiV9gNdmCaHezSSZpTf0Erl60Lt1g9W00ZY9uh0CTVZlLh1VseqRt82yiqTin/7ypCrBncdE4Q1NBW4SHZflV5wkLhgd4IfVtQclJKlHfUPMWPydQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXYLeujq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0F8C4CEC3;
	Fri,  1 Nov 2024 02:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730427021;
	bh=434GrK+5RrXuOXbsNXdMgMWxvF6vZmC8e5FPvlkKo8M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qXYLeujqdnkJj3kQY+Pyk6/5DFITBUaqyYruIFq4zV0Z0dIAEddJ/77X/Q81z5HmU
	 liJECTbdK/LmXTCP2qQQE1JVYJReEW+GWjKBZSGgjWmPJdtmfiwVKU0AA9FVvc6Oq0
	 aoCS69Y+mn0aOF5JMwqi54IJsaGQ/x0/qp+tzM/N53PaIYRo69adLs6yrzK8pDzOHR
	 VmcjEPDhcJ/ZWlKU5zMMgjVTuAQwadLpWSw+wMbg7070DA5opc8Zag4y4rMKFGtJbf
	 iVKkh6vbFNdm0UuyO7HL8/7DoZd/bkC2E3Fhg+xrpXei5cda1NP2ZtIzHr1onO6gis
	 wkxcrPuFc3IgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB57D380AC02;
	Fri,  1 Nov 2024 02:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] netlabel: document doi_remove field of struct
 netlbl_calipso_ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173042702977.2154072.6542843382909285441.git-patchwork-notify@kernel.org>
Date: Fri, 01 Nov 2024 02:10:29 +0000
References: <20241028123435.3495916-1-dongtai.guo@linux.dev>
In-Reply-To: <20241028123435.3495916-1-dongtai.guo@linux.dev>
To: George Guo <dongtai.guo@linux.dev>
Cc: horms@kernel.org, paul@paul-moore.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, guodongtai@kylinos.cn

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Oct 2024 20:34:35 +0800 you wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> Add documentation of doi_remove field to Kernel doc for struct netlbl_calipso_ops.
> 
> Flagged by ./scripts/kernel-doc -none.
> 
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] netlabel: document doi_remove field of struct netlbl_calipso_ops
    https://git.kernel.org/netdev/net-next/c/d86c7a9162ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



