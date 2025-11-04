Return-Path: <netdev+bounces-235330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F792C2EB42
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 02:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CDE89348448
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 01:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A741E32D3;
	Tue,  4 Nov 2025 01:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoQ1gTeY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C10BD515
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 01:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762218645; cv=none; b=hv8OavKJfWszc+YIq2eUGxIYe2bEtg/6L3HJxIYqAOlStT1Rid7hpV/tJyJhzqXDuEQahpZIUgPG2YCLLJxZMLkqs8Ov//ZSOnL1DGEFB6dfIxamuL1LdqNtRrtldUNTzitaexILd9BL1jsI0/fyw538LVOulIRolCglapiwGUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762218645; c=relaxed/simple;
	bh=lqCnxzWe9F9EXaJmKQK7WhbD3i1TbOUfvx6g1g2+F1s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s8Md4ZFBDH0LtTfelEraBTYWeft0HuRlRn5gvcjIMRhNXYzq6J3tQrAunnqP8fl4QXvFpqcXqNVILzYGU//eW6IEIjVfN7G55xYb9DnEacyDlazh5Ikws6c95v6fh2fiI+lQUOdHUBWI/2tShV1qXB8wPxTSG9MM7za6+1yHIkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoQ1gTeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B092BC4CEE7;
	Tue,  4 Nov 2025 01:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762218644;
	bh=lqCnxzWe9F9EXaJmKQK7WhbD3i1TbOUfvx6g1g2+F1s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XoQ1gTeY6ihIaWiro/2T27RVPzG82Ljp1lGp27RL5fqk0q6eZMxa0eOz18w0D/Dp+
	 opBmgaoq9ypCizVBt318k/hubwMAYBeb9zlIJyOGUPS80Fs98cUlHF6YTA65motTDa
	 jcs1M/BpPqsUMLJz5dnZH4vKL1MOIiF+QMuNmau4s13Rpefue7a5F2jp2jRi+Glutv
	 ivtNx8vrakSAtPbM/YnDoqgD+0oMJ41VdUrLppsogwHMdIjZBadulNovsxx9lxulOZ
	 WzubJjPgpmRaBnMLY6O6/VRgKY3mutFJP+5B+Y1idKle5142xWOtWs6HA4dg8h7X6q
	 lIi9S7PdERuHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CFC3809A8A;
	Tue,  4 Nov 2025 01:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mdio: Check regmap pointer returned by
 device_node_to_regmap()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176221861900.2276313.11074104709182763638.git-patchwork-notify@kernel.org>
Date: Tue, 04 Nov 2025 01:10:19 +0000
References: <20251031161607.58581-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20251031161607.58581-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: ansuelsmth@gmail.com, hkallweit1@gmail.com, andrew@lunn.ch,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, alok.a.tiwarilinux@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 Oct 2025 09:15:53 -0700 you wrote:
> The call to device_node_to_regmap() in airoha_mdio_probe() can return
> an ERR_PTR() if regmap initialization fails. Currently, the driver
> stores the pointer without validation, which could lead to a crash
> if it is later dereferenced.
> 
> Add an IS_ERR() check and return the corresponding error code to make
> the probe path more robust.
> 
> [...]

Here is the summary with links:
  - [net] net: mdio: Check regmap pointer returned by device_node_to_regmap()
    https://git.kernel.org/netdev/net/c/b2b526c2cf57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



