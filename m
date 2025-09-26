Return-Path: <netdev+bounces-226820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 080CBBA5663
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 01:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5413A10F6
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 23:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9555F279DA3;
	Fri, 26 Sep 2025 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNPVabof"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F92686359
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758930611; cv=none; b=H/huULKoxQWe6+gNxazm6SvcwB1WigPwAt/NJBG2TUz3YE3x2C9AROfubYo7hGsDsDT/+zK32BXlm1pEQU9FC1kttgxWnRs0/Dzv2rfgxgp07wD7fOhh30OABwSso5+ESa4KxUSUtkuTIviG3iJD1n0S29H3MkZszP/QDkThKV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758930611; c=relaxed/simple;
	bh=DlvFdsCAEkcHdv5QrcNnA1hqQWhv/YStw8xSN0uMUf8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eh10ymJVm1nCmcrRchDO03zm+5aIda3UkJaT5dmkeHW/MP/oBcytKTCQts0krp6CA2mPTSR04VyH+kS2dGdn/AsB01b1M9ex4aC7Ss5LKosK1eB6ado3wzbTd2QKav4kxNmWLA66MYniSUELuh1pxU27BY3ZqmSyROMV6QIdI/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNPVabof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077A2C4CEF4;
	Fri, 26 Sep 2025 23:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758930611;
	bh=DlvFdsCAEkcHdv5QrcNnA1hqQWhv/YStw8xSN0uMUf8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aNPVabofyQCXWqNW4iJ4XllTIv0yQ61Z5bgb0c1u+pRM4CLoas0Bg20X5FvSXm7Ai
	 fsqprVZoDGuHEx0Eva/Cw3DfdRSFcpH1HeLecd0BH33Qu4O2StYZKEn4Zd6/xz3Wtk
	 1M+ksNNeu9lTlhpbGqAah4CF8Y2R9BbIIIx7OPF/BNszAjtBy1wBGWnJGTa/E0pmG3
	 tSPDYQ+ZDKI9QKAhAPjxkSIG6oP3er9TYgUowRMcb1nc+Wt62lh+f/xNlsrR2CoEsw
	 s2unEFtk0QOOwZu3t4yi3TlpXj3yeWErCBn6DvOFjEEejerdicjKYjwbf8qbgKpt0S
	 HDghMfWmjhVhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DF239D0C3F;
	Fri, 26 Sep 2025 23:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: qed: Remove redundant NULL checks after
 list_first_entry()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175893060627.97160.14363249061224646644.git-patchwork-notify@kernel.org>
Date: Fri, 26 Sep 2025 23:50:06 +0000
References: <20250924030219.1252773-1-zhen.ni@easystack.cn>
In-Reply-To: <20250924030219.1252773-1-zhen.ni@easystack.cn>
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: manishc@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Sep 2025 11:02:19 +0800 you wrote:
> list_first_entry() never returns NULL — if the list is empty, it still
> returns a pointer to an invalid object, leading to potential invalid
> memory access when dereferenced.
> The calls to list_first_entry() are always guarded by !list_empty(),
> which guarantees a valid entry is returned. Therefore, the additional
> `if (!p_buffer) break;` checks in qed_ooo_release_connection_isles(),
> qed_ooo_release_all_isles(), and qed_ooo_free() are redundant and
> unreachable.
> 
> [...]

Here is the summary with links:
  - net: qed: Remove redundant NULL checks after list_first_entry()
    https://git.kernel.org/netdev/net-next/c/fbb8bc408027

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



