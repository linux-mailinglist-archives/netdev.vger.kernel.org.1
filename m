Return-Path: <netdev+bounces-267025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGU6BIKhsmkOOQAAu9opvQ
	(envelope-from <netdev+bounces-267025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:20:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CA7270C7B
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 957473086A71
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE653AF65C;
	Thu, 12 Mar 2026 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/+GcwiC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4951831197B;
	Thu, 12 Mar 2026 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314427; cv=none; b=J+QI+zP+CmO2G4RH1lthQ8sVfFl3YSnAnoxPa2+Zszwbs9hkq63gyxt+r40swjPAjDHJ3KUGG41KEoSJlStyENKIOWK4FqdOIhSLNZeubwRg9z9Jqe6qk9b8ewggDnT7M3duivQXiInyHdVwNfdJojNkh63N11ETcHtRvoI3HN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314427; c=relaxed/simple;
	bh=u9OsYWdJSWrOOcNYqQLJLMLLG/2Owk1Inn8W58u1hC8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OIeN2w+0ToOkXlXS/FQjKyMo8ZGmB00eKowlXzbcuoSAxHowRLI5hV2OYu1tVI+PpwKMt3fIjZYoxv5Ne5pnvHMP6l9oz0Fc1tq9HxYdmECOE6YsIrjoKrZD9tdCaGXCcS5/fskKTWrjMzRS8qX9rE+RuX1QN0M9ipg1cRRUTj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/+GcwiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E221AC4CEF7;
	Thu, 12 Mar 2026 11:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773314426;
	bh=u9OsYWdJSWrOOcNYqQLJLMLLG/2Owk1Inn8W58u1hC8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X/+GcwiC21njYgLhpp9RH9g3NRtTw2u+JYNnoFSHs/OVNFP08cdNP2/niifqiSCFJ
	 SOzpi0So4DQXAI1zX7Yl9oPFzVek4AhSGf2CndE7BrmisJKgj6yZInZbdV/liA3+Hk
	 zmtg5Vw51ZBS4bu8dt7IDwT+VX/pNcAe/JbcvlbCpdtLrLm6HuNe+LOEYPo1JCjcYw
	 xKZ+8iToq+b7gDyClCc3XZcKXDnHI8P5oso3dPr2DfNtF1x33I3PrfLmWe/jtpbrIh
	 gC6sU0UV1OForfaDs/+VuckZpmUGlx9oJgXRaEZWqA98lO1Al+yo+8U5ACH53nDDv6
	 v4hVUdvf5oF4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F9E3808200;
	Thu, 12 Mar 2026 11:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v03 0/9] net: hinic3: PF initialization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177331442229.4053740.17049484553716552945.git-patchwork-notify@kernel.org>
Date: Thu, 12 Mar 2026 11:20:22 +0000
References: <cover.1773062356.git.zhuyikai1@h-partners.com>
In-Reply-To: <cover.1773062356.git.zhuyikai1@h-partners.com>
To: Fan Gong <gongfan1@huawei.com>
Cc: zhuyikai1@h-partners.com, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, luosifu@huawei.com, guoxin09@huawei.com,
 zhoushuai28@huawei.com, wulike1@huawei.com, shijing34@huawei.com,
 zhengjiezhen@h-partners.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267025-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[17];
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
X-Rspamd-Queue-Id: 98CA7270C7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 10 Mar 2026 09:04:48 +0800 you wrote:
> This is [2/3] part of hinic3 Ethernet driver second submission.
> With this patch hinic3 becomes a complete Ethernet driver with
> pf and vf.
> 
> Add cmdq detailed-response interfaces.
> Add dump interfaces for cmdq, aeq, ceq and mailbox.
> Add msg_send_lock for message sending concurrency.
> Add PF device support and chip_present_flag to check cards.
> Add rx vlan offload support.
> Add PF FLR wait and timeout handling.
> Add 5 ethtool ops for information of driver and link.
> 
> [...]

Here is the summary with links:
  - [net-next,v03,1/9] hinic3: Add command queue detailed-response interfaces
    https://git.kernel.org/netdev/net-next/c/15b5be9389be
  - [net-next,v03,2/9] hinic3: Add Command Queue/Async Event Queue/Complete Event Queue/Mailbox dump interfaces
    https://git.kernel.org/netdev/net-next/c/678c5b3b6b22
  - [net-next,v03,3/9] hinic3: Add chip_present_flag checks to prevent errors when card is absent
    https://git.kernel.org/netdev/net-next/c/d69ee992fbf6
  - [net-next,v03,4/9] hinic3: Add RX VLAN offload support
    https://git.kernel.org/netdev/net-next/c/0f746fc5bc77
  - [net-next,v03,5/9] hinic3: Add msg_send_lock for message sending concurrecy
    https://git.kernel.org/netdev/net-next/c/2a76f900d17d
  - [net-next,v03,6/9] hinic3: Add PF device support and function type validation
    https://git.kernel.org/netdev/net-next/c/3d36efc28078
  - [net-next,v03,7/9] hinic3: Add PF FLR wait and timeout handling
    https://git.kernel.org/netdev/net-next/c/33cf53672b6f
  - [net-next,v03,8/9] hinic3: Add PF/VF capability parsing and parameter validation
    https://git.kernel.org/netdev/net-next/c/330adcedd003
  - [net-next,v03,9/9] hinic3: Add ethtool basic ops
    https://git.kernel.org/netdev/net-next/c/00608d02ddf0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



