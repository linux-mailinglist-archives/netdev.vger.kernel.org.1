Return-Path: <netdev+bounces-229825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 590C8BE116B
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 02:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C230E188ED37
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 00:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C95E35963;
	Thu, 16 Oct 2025 00:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UttoW3+v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186331C69D
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 00:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760574023; cv=none; b=mCstWq1dyEkCVLkhvidVJo24no7Y2f3baAIgf5SFexESiaKDTbVKQ26xezfzTB2RqeMw3CdVQj1ucJYz1TfBdTl15taf99XzJel5If3plRX9HBf9AnqYyLB1eoCItwVGUigE+a1WzXddAI7renixAHfaV15sd6hcz9zJHn3fGes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760574023; c=relaxed/simple;
	bh=HPrFIhKsSlN3OYAlTariYStgZXKXq9CcfaSSL5cQLPY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tllkvp6k0hop+gboCNH+IPEpI22oYXUm9jxO+sDf+xdWZNvGYaPlmf/AVEAvZQ+nRfjof8kZi2NG0UcD1EPFh6DKoPH6giEAr/0szLSJdi7VMSHF3AavNBAGogvQGuBwpNqZhwhRBkNMUfvXAhLFhI0KJWyjlzzcYyGP0iSdle0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UttoW3+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0454C4CEF8;
	Thu, 16 Oct 2025 00:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760574022;
	bh=HPrFIhKsSlN3OYAlTariYStgZXKXq9CcfaSSL5cQLPY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UttoW3+vriCuG4eDd4sCIkrfjpy6/7Edrj6ky3w/EDVP0amxlWMGZYWEM1QuTc7rC
	 ool7UBqoFqzsb4UK25T4GQGUdg1A6lUEHP4Jn9yQUhx2r0F01rfhhiYffyveZgmgrM
	 GVuts/T24Cyy3wbLNHEr2wgiqAVp6RY61yUTZMhbv3/UdxJE1NRuPhdlZ42XiDOxh7
	 yrlr4+R6mSSpEd9kKa60qpmxj/36HYPK+fW5QeFwMyHyVvPiwR/0cyXLtcIc662o/H
	 GOHyrx5spMsX8Q9YaSeGd7yE9KxMY1ZeHJmulYNm1eovT2HVvSWd3yRlnJdz/UevKA
	 qv5ekpKizEjlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0EC380DBE9;
	Thu, 16 Oct 2025 00:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: new entry for IPv6 IOAM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176057400750.1105273.8956164739252488577.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 00:20:07 +0000
References: <20251014170650.27679-1-justin.iurman@uliege.be>
In-Reply-To: <20251014170650.27679-1-justin.iurman@uliege.be>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Oct 2025 19:06:50 +0200 you wrote:
> Create a maintainer entry for IPv6 IOAM. Add myself as I authored most
> if not all of the IPv6 IOAM code in the kernel and actively participate
> in the related IETF groups.
> 
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
> 
> [...]

Here is the summary with links:
  - [net-next] MAINTAINERS: new entry for IPv6 IOAM
    https://git.kernel.org/netdev/net/c/bc384963bc18

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



