Return-Path: <netdev+bounces-233376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B2BC128DA
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB381A66A0F
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D41242D99;
	Tue, 28 Oct 2025 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXdJxKfr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629D624291E;
	Tue, 28 Oct 2025 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761615033; cv=none; b=qu/blZ2CaaBc5QhEN+/W5qkapR/UmfzaL38LtfamGJX2ZVaA7BUaa8Q9uTwRwDNDa8TzAKkhjfNMb23zVO4QguD8getAQ2btIPKwUwS7z1XDf4+6PHHpMbMRsncFgcn18rt41Q/73pzwgAw+wu2SqctaUDNfToWGft589C8Un/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761615033; c=relaxed/simple;
	bh=o3kCu3EuhOIPjiF/VpH1qDgmw5lE/WjtvwGR/PMy/yc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JLZcIBg4JJPjFzC7GXYOOweGY2RAdoWJhw9xqDV8Wn+MV3cC8tYGsm0LO0UmxQQWC9CdrIynxXXt8sZY6rWllXmTT07cOzsrujG9+GdGAcZUksVTmMV9YSGCBEwPFuQkDpQPE95JPg8tovOxoHp6vnum/Urr37DX4tVu+/bfrgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXdJxKfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0771C116B1;
	Tue, 28 Oct 2025 01:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761615032;
	bh=o3kCu3EuhOIPjiF/VpH1qDgmw5lE/WjtvwGR/PMy/yc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WXdJxKfrjpY1Q579EbyfGRsyA+UO7lrxqVGN2JZ/iHfG/P8i04RQoOWu7+dWZ49vM
	 RQ1pan8usfQY/ppspEmHk2KgoE08ebWB88tKqiH4BnNMKJisWNxU8x2ZebLJhBp5li
	 ywHvFg71rWm3ggMApoGzf3/FLkRiv4dACTv/3vzUewFePb3ol3qYE5sqVgqqWCWNFo
	 /UmFmoGwWxK+1qrrIkc4C1xyKC9hlnUF7jswkNjn1S6ymRltdoBau8KFF8qtDbvo+q
	 5Mor7easUFxkucLz/IDRpvftwjnOJmawuZFIv62FT7WG3VjHE/ExBHZS6NPZ+jmUQ7
	 bTpIL4IUh1PBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E8E39D60B9;
	Tue, 28 Oct 2025 01:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dpll: spec: add missing module-name and clock-id to
 pin-get reply
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176161501100.1653952.3250284969978682466.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 01:30:11 +0000
References: <20251024185512.363376-1-poros@redhat.com>
In-Reply-To: <20251024185512.363376-1-poros@redhat.com>
To: Petr Oros <poros@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, donald.hunter@gmail.com,
 jiri@resnulli.us, vadim.fedorenko@linux.dev, milena.olech@intel.com,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com,
 michal.michalik@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, mschmidt@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Oct 2025 20:55:12 +0200 you wrote:
> The dpll.yaml spec incorrectly omitted module-name and clock-id from the
> pin-get operation reply specification, even though the kernel DPLL
> implementation has always included these attributes in pin-get responses
> since the initial implementation.
> 
> This spec inconsistency caused issues with the C YNL code generator.
> The generated dpll_pin_get_rsp structure was missing these fields.
> 
> [...]

Here is the summary with links:
  - [net] dpll: spec: add missing module-name and clock-id to pin-get reply
    https://git.kernel.org/netdev/net/c/520ad9e96937

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



