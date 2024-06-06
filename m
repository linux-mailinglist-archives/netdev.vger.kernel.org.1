Return-Path: <netdev+bounces-101390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13488FE59B
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 13:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E59DB23678
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F36F1957FC;
	Thu,  6 Jun 2024 11:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxAPjwCd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5782313D2A2;
	Thu,  6 Jun 2024 11:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717674031; cv=none; b=Ss71LC+MS7VkftXUpUaGxHdlqeXcLRvQMRyFcq8ixq0mFuOX2VhzXrjbukrL6qW+az3e8LhA2ZU3jmNrBObc6MkzPaiaGASM4xZFdm4IqDO/9yXawlxnIH0QGQI2S+Ocs7XZ+XxgMipe0BrEC1chFV3IkGbDzptj9Vtwz2Re+6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717674031; c=relaxed/simple;
	bh=aGnlINQZ7i3g921rtkuSNbz/2AJPPOBSiliF5MFlN1c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=af2zcBxmijNWRL1QnS+pwFcyqk1qkP/bBjlImWVIDiAkjVSU3AP/Ptv0XuMQ9hDSpNAQvBd52SZZIpCBJmmY7+wyzdwPRlls/LEZBkQvG/UgZyz/gaHViX4e9I1qXY/XWjZjktjraClYg0qGsdqac4Q4nWK/nfcleb5KQ55ZpfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxAPjwCd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5C5FC4AF08;
	Thu,  6 Jun 2024 11:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717674030;
	bh=aGnlINQZ7i3g921rtkuSNbz/2AJPPOBSiliF5MFlN1c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mxAPjwCdXGHOa6qAR1ARgkitGjl2+LiVNYRw169W9erePhsPdm55nvzpcuqfeRIRX
	 /dsMFFtBHezRgVUWxCo062Gywikc25yjPHBfkIo3hYS4bIITu3UziguRYMYlZiW/jC
	 bBuUGAaV9K7mobpXikOT3cqPbzPFLfBzBWN2dnf+wqk3Wh6obvH2+iM0Y4Hy/rSEag
	 aci+f3hB8D5CxBZbHPdn4b7IkMcf/QrDzHW6HenVymdmDeHcfnNJUsrxAljVqbbqO2
	 Ine2NkEi+OgCmlQ9GY9vFpFVSK7guoM9zu03Tbu+mQMrAF328Z1cxo/QPY88fNTIx4
	 kUKCXVa+dlJGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3892D2039E;
	Thu,  6 Jun 2024 11:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethtool: fix the error condition in
 ethtool_get_phy_stats_ethtool()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171767403079.12695.6034347075508573945.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jun 2024 11:40:30 +0000
References: <20240605034742.921751-1-suhui@nfschina.com>
In-Reply-To: <20240605034742.921751-1-suhui@nfschina.com>
To: Su Hui <suhui@nfschina.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, nathan@kernel.org, ndesaulniers@google.com,
 morbo@google.com, justinstitt@google.com, andrew@lunn.ch,
 ahmed.zaki@intel.com, hkallweit1@gmail.com, justin.chen@broadcom.com,
 jdamato@fastly.com, gerhard@engleder-embedded.com, d-tatianin@yandex-team.ru,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  5 Jun 2024 11:47:43 +0800 you wrote:
> Clang static checker (scan-build) warning:
> net/ethtool/ioctl.c:line 2233, column 2
> Called function pointer is null (null dereference).
> 
> Return '-EOPNOTSUPP' when 'ops->get_ethtool_phy_stats' is NULL to fix
> this typo error.
> 
> [...]

Here is the summary with links:
  - [net] net: ethtool: fix the error condition in ethtool_get_phy_stats_ethtool()
    https://git.kernel.org/netdev/net/c/0dcc53abf58d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



