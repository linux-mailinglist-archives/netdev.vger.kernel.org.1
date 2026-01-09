Return-Path: <netdev+bounces-248313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D49D06D33
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 03:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FED230471AC
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 02:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37D027465C;
	Fri,  9 Jan 2026 02:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUfh2kBz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A172526B764
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 02:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767924815; cv=none; b=gOA4vQP4L1+3v8PkYN54FQGJM40B4R93Da+VAaw66oiD2ydKGyJBRXINGypdM8S5GLcI/Hre0q3dHd2B+T5eCD0OFLQL4m7ky+GTRmbfJwhHKnHzKPSqlw6xaxXbGKNVe91r6YnkAG6h2AMSIQO4KgL/dMy6wAOrCwD5B4r1598=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767924815; c=relaxed/simple;
	bh=SAKQ1VPavVHsMEUfkmhRssZ+RMlwfS2NXSsoht0DGCQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qnoM71gQjSFXDD9aIpSIJnw5ltaDgXCcdQQVvCWG2RBENI1eqv8rjhQyTmC6Wz+pwFwFq8ajvbb2zyE6hNwljmV2NzI7smtOeuv7hKmvSV8bXKD8L519zP4pSvA69qmkWDJHe7WRtPZEs6DT29HqdUrp+4JxZS0VVapG2mEuJfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUfh2kBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4151AC116C6;
	Fri,  9 Jan 2026 02:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767924815;
	bh=SAKQ1VPavVHsMEUfkmhRssZ+RMlwfS2NXSsoht0DGCQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dUfh2kBz5yi++MALNn1BtKmUoUXTPmHTnRkKwFrBRe3VxPhQMqMjsf3qd/LG0zEuj
	 ZUjsZlN5yhW0HuVQprxWNYX2Khu0F9nJ7uJSyWuaBXxdh0ODODoyzsF2Eoi73B0tvc
	 XKD3ksk8Vm0QBy5DsjKEDR0BsKyr6rRYlTgQnwIhea/MzKp6OoP63q9HALelv/cBro
	 sfhG4af2Z49T4etBGz4ZH9AVfRJeEUeLn6SWzWxWs90L0szQiOO0BGTJxwG0fOX/QV
	 RFIGJRike5ExWyCp/yayM0WHjG2u6Q/7NnGIuxAz0fN5D6j9TOiHsXN0UWBqPZbBn+
	 Y57/jS8XaSeFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5B603A8D145;
	Fri,  9 Jan 2026 02:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] sfc: correct kernel-doc complaints
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176792461127.3867254.13954177894691629878.git-patchwork-notify@kernel.org>
Date: Fri, 09 Jan 2026 02:10:11 +0000
References: <20260106173224.2010703-1-rdunlap@infradead.org>
In-Reply-To: <20260106173224.2010703-1-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, ecree.xilinx@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-net-drivers@amd.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Jan 2026 09:32:24 -0800 you wrote:
> Fix kernel-doc warnings by adding 3 missing struct member descriptions
> in struct efx_ef10_nic_data and removing preprocessor directives (which
> are not handled by kernel-doc).
> 
> Fixes these 5 warnings:
> Warning: drivers/net/ethernet/sfc/nic.h:158 bad line: #ifdef CONFIG_SFC_SRIOV
> Warning: drivers/net/ethernet/sfc/nic.h:160 bad line: #endif
> Warning: drivers/net/ethernet/sfc/nic.h:204 struct member 'port_id'
>  not described in 'efx_ef10_nic_data'
> Warning: drivers/net/ethernet/sfc/nic.h:204 struct member 'vf_index'
>  not described in 'efx_ef10_nic_data'
> Warning: drivers/net/ethernet/sfc/nic.h:204 struct member 'licensed_features'
>  not described in 'efx_ef10_nic_data'
> 
> [...]

Here is the summary with links:
  - [v3,net-next] sfc: correct kernel-doc complaints
    https://git.kernel.org/netdev/net-next/c/a45ed8db62f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



