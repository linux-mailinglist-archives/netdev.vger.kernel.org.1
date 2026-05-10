Return-Path: <netdev+bounces-286374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNhnAj7UAGp8NAEAu9opvQ
	(envelope-from <netdev+bounces-286374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 20:53:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 645E8505CA6
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 20:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CE5F3007E37
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009CF318EFF;
	Sun, 10 May 2026 18:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poSG8M5S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9333168E1;
	Sun, 10 May 2026 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778439215; cv=none; b=Ck/zk5drIfBnEoQCia3mfYDKihsDgXVQy7cREJoWbH7cSY49DpXLmluZkuJKlQ05bgjMiNLXByRcgydP+mrsb46RT0cPhUEa22kh2rBe+bXwAvUNDp8/Jt264KDXWTLS0ZkaNJIdUL/nXVerWVAXFGzxf2wCIbLAmUXQN6iKR9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778439215; c=relaxed/simple;
	bh=ZOEE1q5jZK4w0HN4IQjlwUvlFi7z4Tb9M/FxJIyJhPc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Op+KLE694InLrKhZ1oWLqaSQLVlLcRdVl7yIQZyUjAHA2JAFUNdZJp5Z57iSoHy/wxePraVmXuShdNLKZMvav0V4sACMyOhA0CPq8aXOVx4mDgVVSgMZy37mMYVYi5TPVez2+tF4RhdmafAnzhcgUAyQY2FYd4g9e+aimfGOrN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poSG8M5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1C0C2BCB8;
	Sun, 10 May 2026 18:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778439215;
	bh=ZOEE1q5jZK4w0HN4IQjlwUvlFi7z4Tb9M/FxJIyJhPc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=poSG8M5SiY6HAaXp/gialgSemofT1m8orolg4ghpoxr+jPv0tdMhFi+oXWM6e7RjY
	 s3d9yUtvIJ11wzKqxUBEizpKwZ+d9XKK2w86VA1ZtDs52T9oY/N78Y80yuTjmFnj+b
	 Xn89RMakHKa+7h0jAXujB2/eISiCCjd4e8Tu/VpSVG996Y41cSWrXrqgy1ljOMy2UI
	 CKGIwlieJ2DFLILnZxrBAnB9TDYwCNibTFS0MF1mS0JpEGzJUNEbroeU4oEomUrpCL
	 3pq1J13pEhwtbG45vPFy36C7EFfPeuNTh7nAUOqf8oPKK2DGASKwRgfdGeg4TkBx2i
	 zLjhMU63nnJ9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CC3380A977;
	Sun, 10 May 2026 18:52:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net/mlx5: Steering misc enhancements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177843916254.1446496.10907261827888769318.git-patchwork-notify@kernel.org>
Date: Sun, 10 May 2026 18:52:42 +0000
References: <20260507173443.320465-1-tariqt@nvidia.com>
In-Reply-To: <20260507173443.320465-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: cpaasch@openai.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 saeedm@nvidia.com, leon@kernel.org, mbloch@nvidia.com, kliteyn@nvidia.com,
 vdogaru@nvidia.com, horms@kernel.org, kees@kernel.org, valex@nvidia.com,
 erezsh@nvidia.com, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, gal@nvidia.com, dtatulea@nvidia.com
X-Rspamd-Queue-Id: 645E8505CA6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286374-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 7 May 2026 20:34:40 +0300 you wrote:
> Hi,
> 
> This small series by Yevgeny contains a few steering enhancements /
> cleanups.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net/mlx5: HWS, Check if device is down while polling for completion
    https://git.kernel.org/netdev/net-next/c/e3ec1570895b
  - [net-next,2/3] net/mlx5: HWS, Handle destroying table that has a miss table
    https://git.kernel.org/netdev/net-next/c/60e9e82f162a
  - [net-next,3/3] net/mlx5: DR, Remove unused field of struct mlx5dr_matcher_rx_tx
    https://git.kernel.org/netdev/net-next/c/6316d40b8509

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



