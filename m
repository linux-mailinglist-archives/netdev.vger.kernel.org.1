Return-Path: <netdev+bounces-131423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E5798E7D1
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0C928424F
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 00:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F156DDCD;
	Thu,  3 Oct 2024 00:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIW8vsEt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697BECA6B
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 00:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727916032; cv=none; b=sDoHL8w7s6eWIdkLJwds/IqVu3l2l7LxSo2f3/AFPrglRbHVG1AI4mhVCXCfcVLzZPbpggyoJ9gDUEWfA2BCdAYz2dOQaoGSs9jeZYVZBjSd+wSZDcBjS+ecwoBPc6VPciYagMGMACO/3twxfZ9wtnsSq1BLYuQ6C+GGxmZirb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727916032; c=relaxed/simple;
	bh=4LhuyR+FbNYfgiMXasyjG+XJUzN06tDXS2r5Xhmb1h0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jRzBcwyc28y8kIUZNuOEti4AkgNDIgSl/tLbaQWuCxbrPyj0YeEZqIgDFsZeMh27UnxdWExT1b1OEtnV+lQpMt6vS8RepXJ5helRkx9lu+QGshL3XB0/n6G5t5fgHDr28VtUZJyGJwgacXEl8+QbhM4GHseMq3Ogiu0PpWODRs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIW8vsEt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F67C4CEC2;
	Thu,  3 Oct 2024 00:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727916031;
	bh=4LhuyR+FbNYfgiMXasyjG+XJUzN06tDXS2r5Xhmb1h0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TIW8vsEtnEP8KB6VP+RxZzS4N2BFYNtFKQPED2hQQ4PeX1NE/L+XBlnuTJvJagvtI
	 M05hlU7NyEy7vDvsjn5PeUb5miuYEuP5K49+q0OP30b2mEtiBxMuIlhIzdu/oFjwh/
	 NGcW9xPoPSwMh3WncUI3ALX2f0FOUy9MQp/sKMjTivTuTq8eNhWQCGbq/gvUlRkPIn
	 8gQD+V+7OtkLYsJZjjHANcPNBUEgdZ4N1Sfs2HBcpqYQrzyUhD5Uqid69peLhplkJR
	 PnrdMhyGHzUeVUPQWzYVu0GzoB/btazx0Nr13VLMRGU0KG2V84dxslthiHdPDA6lyu
	 uHF88mbV1lCXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7123A380DBD1;
	Thu,  3 Oct 2024 00:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: test for not too small csum_start in
 virtio_net_hdr_to_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172791603524.1387504.1162630354164198788.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 00:40:35 +0000
References: <20240926165836.3797406-1-edumazet@google.com>
In-Reply-To: <20240926165836.3797406-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, willemb@google.com, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Sep 2024 16:58:36 +0000 you wrote:
> syzbot was able to trigger this warning [1], after injecting a
> malicious packet through af_packet, setting skb->csum_start and thus
> the transport header to an incorrect value.
> 
> We can at least make sure the transport header is after
> the end of the network header (with a estimated minimal size).
> 
> [...]

Here is the summary with links:
  - [net] net: test for not too small csum_start in virtio_net_hdr_to_skb()
    https://git.kernel.org/netdev/net/c/49d14b54a527

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



