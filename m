Return-Path: <netdev+bounces-205981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C660FB01034
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 02:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9934C3ACB74
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 00:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309808F6C;
	Fri, 11 Jul 2025 00:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDXgPd56"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F383A46BF;
	Fri, 11 Jul 2025 00:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752193842; cv=none; b=sEugg0s+snYVtV4Ni7kX7xN6L3RKNVTTOK/t1vYLjOI5hVB4LIxQxZ21XqDlPSrEBWcBtCJzW6tlDu2Wp+NRR6tV5iNSdBjLhUrYUmbz6aRaXZBYLLCTuNaZCpzFJ7aitakOxz0irBb4HACs2MBNlJyl2fkXji7iYf0e6iD1NMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752193842; c=relaxed/simple;
	bh=EUY3LTEqVfnyft6jycovUuD3pKLNok7s/ZTVTtqQMRI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z90G4YHd4Sayd18QL6Ex7P3cWJ0QYTiREmNfBiwV5ajff4UQB6+YkWbKQ8IO2i4xAwELLUytvRz2MnM8FlGHbz+aPvm4Txw8PQmYqahsyatdaRjDXhjloEbbUdgY6X+0KViqDK0sX4Rp+W1rXJqmxJ9cpmUvAesj2wR01zLVjhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDXgPd56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA6FC4CEE3;
	Fri, 11 Jul 2025 00:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752193841;
	bh=EUY3LTEqVfnyft6jycovUuD3pKLNok7s/ZTVTtqQMRI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qDXgPd5682nZ7FxAb4YqDdWOGHXZssyZ1ldAX7Z5B3DUTn9/3iaDtxIGl+IU25+/6
	 lCszKV01HyORq6wQmXt1o3uXd1KhkRXh5SXKFDB0hrzfQQBQ8ZapuKqBDA93f85QFc
	 26fFctGAWw/B1xy0XKWQ9VkKYx78xtROUAJZkcmN3OzZOyZJZVMe2vVjYwaOqoSblB
	 v2XnV+3u2o//Jcy4jn/7uzkGWOWL3IRyDiTnp183+Q3udj7HgOZYITzn1+F0vX0JT9
	 C4DtjnvVrsqV6x3f7tIZFUbLHaRVg333LZU2L+hV6FrTFfigtTI771vxvSIJZIQfIN
	 B+p/Kkkq6AYSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CE0383B266;
	Fri, 11 Jul 2025 00:31:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] riscv: sophgo: Add ethernet support for
 SG2042
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175219386374.1715084.5771017921965824302.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 00:31:03 +0000
References: <20250708064052.507094-1-inochiama@gmail.com>
In-Reply-To: <20250708064052.507094-1-inochiama@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, unicorn_wang@outlook.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, rmk+kernel@armlinux.org.uk,
 prabhakar.mahadev-lad.rj@bp.renesas.com, joe@pf.is.s.u-tokyo.ac.jp,
 l.rubusch@gmail.com, quentin.schulz@cherry.de, peppe.cavallaro@st.com,
 joabreu@synopsys.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, sophgo@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 dlan@gentoo.org, looong.bin@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Jul 2025 14:40:48 +0800 you wrote:
> The ethernet controller of SG2042 is Synopsys DesignWare IP with
> tx clock. Add device id for it.
> 
> This patch can only be tested on a SG2042 evb board, as pioneer
> does not expose this device.
> 
> The user dts patch link:
> https://lore.kernel.org/linux-riscv/cover.1751700954.git.rabenda.cn@gmail.com
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] dt-bindings: net: sophgo,sg2044-dwmac: Add support for Sophgo SG2042 dwmac
    https://git.kernel.org/netdev/net-next/c/e281c48a7336
  - [net-next,v2,2/3] net: stmmac: dwmac-sophgo: Add support for Sophgo SG2042 SoC
    https://git.kernel.org/netdev/net-next/c/543009e2d4cd
  - [net-next,v2,3/3] net: stmmac: platform: Add snps,dwmac-5.00a IP compatible string
    https://git.kernel.org/netdev/net-next/c/d40c1ddd9b4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



