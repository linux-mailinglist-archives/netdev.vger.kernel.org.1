Return-Path: <netdev+bounces-105611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B410C912031
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 11:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D5F1C23012
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 09:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CA516D9AE;
	Fri, 21 Jun 2024 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1PI06Lx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632691C02;
	Fri, 21 Jun 2024 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718961030; cv=none; b=EsEjE0B+9XhoXRLxZhLo0vrjPLQ43x9cOze0QMBRBXqdp77HDgCaACOy1InOnATBZRybe8tDeoLUzQPc95vYtrGd8dB/O5EzLQt0EkOUn1ehLEayAE31Bm9veVxrFl8GAWrIFGsjCM5jYiFQmE/kpKL+GR5mobPQO9DSs9c8N5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718961030; c=relaxed/simple;
	bh=dtNamkEHpUtPZU65QnkGixC6WZbt3TIA8r+pccjArFA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qFJGA3eUiPL1qhpqHd7soEPys/UN1f1mrRWrPJexTTG5yMv7vZRYu7MQoKfa1hhva95QTotX9+WHpJ6vO3F9ezEH9Ym+G+z+GlCRzT+C85jPJNOoGCglhwGyUlP9aIvQ3s5t67mtMpp6DAew6zmNdY71CckuAD9z9ammuCsnvJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1PI06Lx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3107C32781;
	Fri, 21 Jun 2024 09:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718961029;
	bh=dtNamkEHpUtPZU65QnkGixC6WZbt3TIA8r+pccjArFA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U1PI06Lx5vb8BQ15ziyZT7ferY0gRjZsLwdE8yrSGWKapNGOBigxYv65Fb2FTVUVf
	 fUmgfd5Ap62KFdpXtDhS8x+HSwhnglTyFK9PVU2WWcCtF/S5Cl1995aw6EJ5ERmeN3
	 fPBosWtN6+4/CdVvABZsweTgUK+hMnGJ2Xz3bQu0T9dKBltW9JCgDUXe6PVZx3cl85
	 h8ou/zmcOr0/lHrtOMr990qd4DNg0N3kgZt4KtbXXJflLzKfRWm0J07WSTFlW6QYt+
	 KD41A5zCUmFwZX1FygPsz9XkVsAAHme3PVWu9VS2opdV90UtP1//wRup/UbOTdVp/C
	 o05Wx6EGoVhOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C18E6C4332D;
	Fri, 21 Jun 2024 09:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 0/3] cleanup arc emac
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171896102978.12983.298145904993537431.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 09:10:29 +0000
References: <0b889b87-5442-4fd4-b26f-8d5d67695c77@gmail.com>
In-Reply-To: <0b889b87-5442-4fd4-b26f-8d5d67695c77@gmail.com>
To: Johan Jonker <jbx6244@gmail.com>
Cc: heiko@sntech.de, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 18 Jun 2024 18:11:49 +0200 you wrote:
> The Rockchip emac binding for rk3036/rk3066/rk3188 has been converted to YAML
> with the ethernet-phy node in a mdio node. This requires some driver fixes
> by someone that can do hardware testing.
> 
> In order to make a future fix easier make the driver 'Rockchip only'
> by removing the obsolete part of the arc emac driver.
> 
> [...]

Here is the summary with links:
  - [v1,1/3] ARM: dts: rockchip: rk3xxx: fix emac node
    (no matching commit)
  - [v1,2/3] net: ethernet: arc: remove emac_arc driver
    (no matching commit)
  - [v1,3/3] dt-bindings: net: remove arc_emac.txt
    https://git.kernel.org/netdev/net-next/c/8a3913c8e05b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



