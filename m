Return-Path: <netdev+bounces-252315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA6jIEsccmnrbwAAu9opvQ
	(envelope-from <netdev+bounces-252315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:47:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6C866CD2
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8434E74790E
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDA63A6405;
	Thu, 22 Jan 2026 12:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI0kM8qZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5520134D912;
	Thu, 22 Jan 2026 12:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083209; cv=none; b=bElk2Lb53VgXcD+PIPMFKuoyWVdFG01BE6MGv5E8L2MIeDUqolGeGWM/luhvBddx6ggz4jR9c3e7oRm6MZ87riEVYrfzUqR/u8pdvJtHyjsqEa+ilHnmLVnuzD3WkZiUroFSPrzaRs5I0C2yKW+DURSOliIEHTN5K6M0b9pUe8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083209; c=relaxed/simple;
	bh=JyPDdEQ73QkWm09W2r9cDzf8sVXjY987iOwOVKyxymM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sPLPLbuqcqXBKMJLCKpg0de4YPNk1PU5zlppPwubztBoVOSDnkYaep7kU8asxyr7DlZLxA6zbzEi/XmICzXdZDs5opeOZZe73A+rG7kdwyaeYimuJICtgzJ17+Z4RvDmfgH0SE3nL8uiS98nzcN2z5jA4TBNHljf/cc2AagZbJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bI0kM8qZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72C2C116C6;
	Thu, 22 Jan 2026 12:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769083208;
	bh=JyPDdEQ73QkWm09W2r9cDzf8sVXjY987iOwOVKyxymM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bI0kM8qZ5OLHKQ0nz+mn28GVyFSVlIpcLy1QDkm5Tlk+jmu40buORTBeqxfx1n48r
	 laNjX2aNEUFI0klBF05WqNExvXs6NRwLdXaIVl5Se+2l/DMaluTUCm91BqZSxahZTV
	 ljPWfkWA2/dX6y0SQNuZ8+b8MmvH0F6kpUTGemKkjHj7mVwfoQ+YNP4FG+m5vsJ38v
	 IQwHWYhHf9201ENhTl5CPzxqBmastQTEFcoAvgKsH1H/hxdzcA+JKCGKz0X0BYFeFg
	 JhG0jFyEJuAVBnPU5dzz0zhOK9aLFpm5hC/SxWSWNFV/v9DEbozXgAId0MI4l64Et/
	 Vpct97emLG+bA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BBB63808200;
	Thu, 22 Jan 2026 12:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: openvswitch: fix data race in
 ovs_vport_get_upcall_stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176908320511.1691590.17244442615265904977.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 12:00:05 +0000
References: <20260121072932.2360971-1-mmyangfl@gmail.com>
In-Reply-To: <20260121072932.2360971-1-mmyangfl@gmail.com>
To: Yangfl <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 i.maximets@ovn.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 wangchuanlei@inspur.com, dev@openvswitch.org, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-252315-lists,netdev=lfdr.de,netdevbpf];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E6C866CD2
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 Jan 2026 15:29:26 +0800 you wrote:
> In ovs_vport_get_upcall_stats(), some statistics protected by
> u64_stats_sync, are read and accumulated in ignorance of possible
> u64_stats_fetch_retry() events. These statistics are already accumulated
> by u64_stats_inc(). Fix this by reading them into temporary variables
> first.
> 
> Fixes: 1933ea365aa7 ("net: openvswitch: Add support to count upcall packets")
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: openvswitch: fix data race in ovs_vport_get_upcall_stats
    https://git.kernel.org/netdev/net/c/cc4816bdb086

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



