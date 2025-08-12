Return-Path: <netdev+bounces-213099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6F6B23A86
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 23:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15ED66E508F
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 21:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFDA270EBA;
	Tue, 12 Aug 2025 21:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+6srMj6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B369F1E5B7A;
	Tue, 12 Aug 2025 21:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755033614; cv=none; b=IpaZXjr60ePwWHKF9TCLrr+S2DacETsjWBnzSRe5uvy+CAoHJffCcdrpb4+0+Pm1yqyVXJUXlC2Yy0JrKBO+8Qag78VRI+COtuH3jyJkF3MLngjXZNT2ZsczePslcQlH6HlrSab9P55Y7xyu0cz/1tuUxllRGNZDIobtLIFfosw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755033614; c=relaxed/simple;
	bh=coaleDkEw2ri40zMf0iBd5QOXvs/OQOHQ7AAZgHkX3g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HH3lLIXAfWvuI3OxQcunBpy+Y+r5+cZVJNEsx8F+09iJ82ah6EtBzV8IkpKfAqNTFoTUcNrra/HqsSZ+1Ld3u/P5CZgPlzuyTa6eOgd4VBSWH66aEvrBqO8TB+2zp8VPV35Uz6tovihmNSt3VVa1Hru07Y/Pt1gi7AL3vIUq0co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+6srMj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F4CC4CEF0;
	Tue, 12 Aug 2025 21:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755033614;
	bh=coaleDkEw2ri40zMf0iBd5QOXvs/OQOHQ7AAZgHkX3g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D+6srMj6RQUdBm/eEwEuvGo5CanVDw95qZeJkB2llEU87IEDO7Ufes75U15DWr1kL
	 xno7pVgUhvpqg5pezP0yKUZ4k02aDrAyVKslLrXTxiFJzrejnE+iisSuLfiNM+cHap
	 bM3JtTtZtPtvYT6uF6zNhI/4AiVBpRCuACoJbWj+9Lj4obeREh7F2d/BIC7CjxPStK
	 p7M7ujXf8RgO1tmSaLrLGsQFUgnURx23151+WWFzJcx8RfhpYGGULadM4pXvinZIT8
	 htQRSCaKGz2IPPZsGR3a8RJmZ4EEKPsPAO9Qa+W9b0Ew8lfBjZ5RZR0NUGM5BelP04
	 6BwyEvJkXEO0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DC1383BF51;
	Tue, 12 Aug 2025 21:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: stmmac: make variable data a u32
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175503362599.2827924.4642075233156887123.git-patchwork-notify@kernel.org>
Date: Tue, 12 Aug 2025 21:20:25 +0000
References: <20250811111211.1646600-1-colin.i.king@gmail.com>
In-Reply-To: <20250811111211.1646600-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Aug 2025 12:12:11 +0100 you wrote:
> Make data a u32 instead of an unsigned long, this way it is
> explicitly the same width as the operations performed on it
> and the same width as a writel store, and it cleans up sign
> extention warnings when 64 bit static analysis is performed
> on the code.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> [...]

Here is the summary with links:
  - net: stmmac: make variable data a u32
    https://git.kernel.org/netdev/net-next/c/11b99886d194

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



