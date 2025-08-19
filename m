Return-Path: <netdev+bounces-214812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D38B2B5A4
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 03:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86C4C7B3A91
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 00:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7651A2C25;
	Tue, 19 Aug 2025 01:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrQTh/9F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AD319CC39;
	Tue, 19 Aug 2025 00:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755565200; cv=none; b=NB2yW4NGML6rthPFzeGB3iHzLzVeIq5W153ziZP+LVY0OCVR221ISdc+a0IlK71HjD9l+3zEGqX69JEqcAJGasVKCzp8nfHPTJMmaGjUcrJ4lgUXcdaRJhWUqw33+NfrkkEacaCEF45a5KD5Hq2w04Dq/4gTO01EF2l42dckTfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755565200; c=relaxed/simple;
	bh=+sfa6t83e14yl9Xt2JNYP1qflvGr43FTmDcm5kBC2fc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hm0ue9wwiK6sE+H2WZefloOD1/PmeTTRz02Kiy3A4BKwyRW96jlW8uazZJasHk6D/ohC5ZW9mniplQ27Gcng+ijUiJNndh3BaPIzjREuScqRZWZwfDloOLf7APofBq//VADMD0HNlRL/RSsMjGFSmRotaKBXBWifNcYsfzh3s4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrQTh/9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FDBC113D0;
	Tue, 19 Aug 2025 00:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755565199;
	bh=+sfa6t83e14yl9Xt2JNYP1qflvGr43FTmDcm5kBC2fc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QrQTh/9FnWoa0R76UqgIaE1thDJoI++FVd/YrR0RUFEkbFzBaldnqh6SCdBvmfymM
	 X7Cyw4Px9hxlcsPXg/USd4XcRK5j+u/iqkBe9hmzxxy2uehC7sVlwBD/Nc4ze4YQgz
	 +35LyjB7nvp8Xfa4TWWUApRBgCquXAxwVzvatWP6MMzxag9fnuyJILJholqgQtYwwC
	 wiI8c5+cihXwS9w0V27GgQ+dsPSxY+irQJBmYmEcaYzx9rQYOTbkuLGp1pjzOX0oej
	 6/wHCjfjRmItCrGHvlZ9M3ZhMfL8QSx28rheB0DuZlyqECXZVveuUz+Y54sQG11TSt
	 hPpHu57MITrzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C97383BF4E;
	Tue, 19 Aug 2025 01:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: b53: fix reserved register access in
 b53_fdb_dump()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175556520899.2966773.10487281916372982476.git-patchwork-notify@kernel.org>
Date: Tue, 19 Aug 2025 01:00:08 +0000
References: <20250815201809.549195-1-jonas.gorski@gmail.com>
In-Reply-To: <20250815201809.549195-1-jonas.gorski@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 noltari@gmail.com, f.fainelli@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 Aug 2025 22:18:09 +0200 you wrote:
> When BCM5325 support was added in c45655386e53 ("net: dsa: b53: add
> support for FDB operations on 5325/5365"), the register used for ARL access
> was made conditional on the chip.
> 
> But in b53_fdb_dump(), instead of the register argument the page
> argument was replaced, causing it to write to a reserved page 0x50 on
> !BCM5325*. Writing to this page seems to completely lock the switch up:
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: b53: fix reserved register access in b53_fdb_dump()
    https://git.kernel.org/netdev/net/c/89eb9a62aed7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



