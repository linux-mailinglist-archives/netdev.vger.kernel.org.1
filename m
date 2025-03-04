Return-Path: <netdev+bounces-171576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25505A4DB33
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 11:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025433B12B2
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 10:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85BF1FE45C;
	Tue,  4 Mar 2025 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5bxKDlG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9001FE44C
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084798; cv=none; b=u7P3hpnPNBAxZpqXJyMJfvQWIcL1v6obHtNs3Bqmc6/YCOWeWIGeElddMUmDeFkH7hAWOaF3AYaflzVPVIhhbn0QnzgfguXBL3N/CfxpBhLZCCJPvvPS4g2LdA531qJZuiAiCczeM38T6SMoyqPg6afc6J0VSsYXq19g+UQnc30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084798; c=relaxed/simple;
	bh=49bWFLzCeNNKn3pAtNmFVpEeQ772PFXbWnlthQVAvtw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oAZyxnGzb3I9FulDlMkC7SmyHALREB0H0LVm0MLMLztQd2jpEfnLYClYJABp5HY+mRYWFQjh8thRmp7R6Z3yQyNR1n1KCQg4sOTMXo0JfAXyzNDzeNWq7X2eg8PELG9syRcWa0TxTh3Y4my2Xewto+7owfzm4yYcG7HQenbA2PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5bxKDlG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D09C4CEE5;
	Tue,  4 Mar 2025 10:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741084798;
	bh=49bWFLzCeNNKn3pAtNmFVpEeQ772PFXbWnlthQVAvtw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j5bxKDlGFLrD/ntlrOp6Xe8VkLumoS2hf82je26XubmCi3YP5T2Z7M49r/bCdX4hy
	 pybWnbSfEPqOwsYC0eWuBxps9FfaM3sP6RFLBWt5HxMOyQ+YdghscLgu4XqQU4o5ZL
	 ugOilf1N8BwjXn4FAQQjtGgw0OR+M6uZVvYFZov+Hq+5esLXt545nOl84UNbuAejF5
	 bRFJi+P+EYFp6HbqqMv4XB3FfYv9qus7ZQUQga2sLoGuvYmYsjUsEy4b2o0uF8n6K3
	 ORWulRO7iieDzUe54FJyjr5kh/U5v4u8ue8iUlGvqjftZU+QM/cWNlqfyMdX/fMk88
	 IeomRq/nxf8oA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E0B380AA7F;
	Tue,  4 Mar 2025 10:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] be2net: fix sleeping while atomic bugs in
 be_ndo_bridge_getlink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174108483104.90135.4605054466207568405.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 10:40:31 +0000
References: <20250227164129.1201164-1-razor@blackwall.org>
In-Reply-To: <20250227164129.1201164-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, ajit.khaparde@broadcom.com,
 sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ian.kumlien@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 27 Feb 2025 18:41:29 +0200 you wrote:
> Partially revert commit b71724147e73 ("be2net: replace polling with
> sleeping in the FW completion path") w.r.t mcc mutex it introduces and the
> use of usleep_range. The be2net be_ndo_bridge_getlink() callback is
> called with rcu_read_lock, so this code has been broken for a long time.
> Both the mutex_lock and the usleep_range can cause the issue Ian Kumlien
> reported[1]. The call path is:
> be_ndo_bridge_getlink -> be_cmd_get_hsw_config -> be_mcc_notify_wait ->
> be_mcc_wait_compl -> usleep_range()
> 
> [...]

Here is the summary with links:
  - [net] be2net: fix sleeping while atomic bugs in be_ndo_bridge_getlink
    https://git.kernel.org/netdev/net/c/1a82d19ca2d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



