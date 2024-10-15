Return-Path: <netdev+bounces-135668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 191F099ECF9
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 15:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1CC028559A
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 13:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CFD1D5172;
	Tue, 15 Oct 2024 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpaKVkhw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EF61AF0CE
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998426; cv=none; b=HwZM2TgLSz7dABc9bemT2eVCHPTFmjev0/BHam4wbbkBla8GLeISiknDdCM71h0dWv9r6LAakLg698NU7YH1tyyk6TFDPTyS9vyaM1kq/V97TnwFYGv0Xz7eHwawvwUNuLdmKSm25oc1tZJz4bUzzNvQBC3sTExd6p6/saGSw5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998426; c=relaxed/simple;
	bh=LQlkc1ZFEEgmHa2CUWYOQ7e8ksAPfM1mmw6hQalcXJA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=du7rQLazfOfPvOXU5nbf8HcFpItpI2D0SYIvCsY4L6lg0iqTmCKU1CEfo1Xjj7v6NoK5P9vgRx3tgGneaY+zEmITpydIBM7GIPdNPh87glfsYuyvDOzPp4RDJwaaKjKKIdw2ZQx2UpjnCpwxiVng0bAMlhc5+iNNrtM71U/0Ep0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpaKVkhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FFAC4CEC6;
	Tue, 15 Oct 2024 13:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728998424;
	bh=LQlkc1ZFEEgmHa2CUWYOQ7e8ksAPfM1mmw6hQalcXJA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dpaKVkhwXzJCkz5Aa6XeyhRV3Vbt64YkGtl1NUxXU4cUPf06dFW6cbQenMuNtxuua
	 nzQeKttl3O5VlcvV52wqvTE6tHXAb32upSlCdnoG5N5Vjs0ef20o2UCACWttzMVXcc
	 BKgiQYYgCt7svP9+i4NmRLgkQXt0KEIlorWUTERa5BwZpQqaujGSBx0P2U5UGNBSZ+
	 uVCoolwIN/lJS4pYF/ZNTkfAUEkbaM7/S0hrJQ5KRo2fCQJCs285eFKqfvB7WKd82L
	 gqggU2NVPxNBckGhAR5rpM+9mA5LRt+tdyv18QxE5ToaYPye5gmhv0JisNmtw1qUdG
	 ErGpkfBTn/FBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0563809A8A;
	Tue, 15 Oct 2024 13:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: gianfar: Use __be64 * to store pointers to
 big endian values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172899842976.1158427.6021511104836691488.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 13:20:29 +0000
References: <20241011-gianfar-be64-v1-1-a77ebe972176@kernel.org>
In-Reply-To: <20241011-gianfar-be64-v1-1-a77ebe972176@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: claudiu.manoil@nxp.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 11 Oct 2024 10:20:00 +0100 you wrote:
> Timestamp values are read using pointers to 64-bit big endian values.
> But the type of these pointers is u64 *, host byte order.
> Use __be64 * instead.
> 
> Flagged by Sparse:
> 
> .../gianfar.c:2212:60: warning: cast to restricted __be64
> .../gianfar.c:2475:53: warning: cast to restricted __be64
> 
> [...]

Here is the summary with links:
  - [net-next] net: gianfar: Use __be64 * to store pointers to big endian values
    https://git.kernel.org/netdev/net-next/c/de306f0051ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



