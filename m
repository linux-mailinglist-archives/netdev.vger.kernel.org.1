Return-Path: <netdev+bounces-242481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56950C90A03
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 03:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C6054E68D8
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 02:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB6828A72F;
	Fri, 28 Nov 2025 02:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5xz3475"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4E0288C30
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 02:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764296609; cv=none; b=jXqOkf8U31jcuoXijinwbjEdMwHbBTKjIoJHo+SDfoETpHMIoqMJdPmUgTy4jOTdPH1t+uu012joC6xz58vKux4LKR9YaUaCuCbd9lLhgxMgLcVLizVVAT3Ujcdqz74Gf4UH4tdpqseYOcGrNsJY+hHXwUMozLygYa1jPqOSjs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764296609; c=relaxed/simple;
	bh=FUhaRxnXxUxNE/ZyHqmZ2tKNQvfpkfg9F1oOG/YoFcE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lUrFjnPEJkVTXL00UhE7ShBfcnM9bLPewKIBcNyC2hsasEr07AcvHubmvNNfvP9pmZ0eRWFIDLK5in4gJ7G7GD3mTKcUajKOcbtgPXkGezAmy9y0qW409jxANNPnoFfCmVx8XUcrUHaegT8l9OvL/e00zEmDXqv6D/JFdMdnYbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5xz3475; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13C7C4CEF8;
	Fri, 28 Nov 2025 02:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764296608;
	bh=FUhaRxnXxUxNE/ZyHqmZ2tKNQvfpkfg9F1oOG/YoFcE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o5xz3475Sgzsjl/Oe2COi8lhMczVWqsmUBOyO2HdzTfuQVWJDv8p0rwFzzSIiBO6i
	 g099rBuB4qNiRmX529LpoP6hiSswuspBnaxMtdBrn063QYGgaaTyQsxLj0EPaqR6sA
	 NL72DpR95eEW5d3NYMIJfM5P+mOx+q6kQbm52o+xZLTm6sX2jgwUb5oAfCpG7OdCxq
	 NUd1zskgeQYPVyxixZaf8bFmXkrmPJ/hRrBMH2i6p3VjBkmnxU56TeUC/4z4RrHpjm
	 UgXeownzuygBq5d+w5w/0kDXHkdNKXo9T05ksFZY5qkODrxTaoNhq9BQBBsLHTnhmB
	 AOxgZSzXC0ycw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B7133808204;
	Fri, 28 Nov 2025 02:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: fix rx limit check in
 stmmac_rx_zc()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176429643103.114872.3644233989627611671.git-patchwork-notify@kernel.org>
Date: Fri, 28 Nov 2025 02:20:31 +0000
References: <20251126104327.175590-1-aleksei.kodanev@bell-sw.com>
In-Reply-To: <20251126104327.175590-1-aleksei.kodanev@bell-sw.com>
To: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, rmk+kernel@armlinux.org.uk, 0x1207@gmail.com,
 hayashi.kunihiko@socionext.com, vladimir.oltean@nxp.com,
 boon.leong.ong@intel.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, jh@henneberg-systemdesign.com,
 piotr.raczynski@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Nov 2025 10:43:27 +0000 you wrote:
> The extra "count >= limit" check in stmmac_rx_zc() is redundant and
> has no effect because the value of "count" doesn't change after the
> while condition at this point.
> 
> However, it can change after "read_again:" label:
> 
>         while (count < limit) {
>             ...
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: fix rx limit check in stmmac_rx_zc()
    https://git.kernel.org/netdev/net-next/c/8048168df56e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



