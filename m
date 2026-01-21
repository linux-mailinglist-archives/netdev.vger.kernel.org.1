Return-Path: <netdev+bounces-251715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Dq6DwU9cGmgXAAAu9opvQ
	(envelope-from <netdev+bounces-251715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:42:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6624FF64
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F42EBC576D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7479F346781;
	Wed, 21 Jan 2026 02:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzZFHkO4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1263446A5;
	Wed, 21 Jan 2026 02:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963219; cv=none; b=DlsVRFlSLDcus6bPko/AYNmqODMKsc9puJ2c4bktIVZduUjNEYL5CONiMfC12NLZlNgLBfOlG3rZ3TPyhKHCg+kEUVw6GQcdSBwi7bg5il2Wz8s+Qtu55CYxJPww8enNfcor6eSpWUuOpDLbrQ4Y+o0W4yjgZDLrBVLzwiA+wOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963219; c=relaxed/simple;
	bh=xB3/bVu9fxc9dswTHUsQz6jp4wYlM5O9I1s/L3N6y1s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K85XjjC0p/4oqdN/jtL9dN+v3LB2uSXZFBBs+sPsFrW1ZP0pd9xdqHXIWww/D5nXmGt6iQLNuCe0djiO0h5qvOhMPD8neC4P3GqGRKG4FVtajZfBt/nWUNIQmx60PcLu7imeAtuxNeIYgkuOJ08dUbhGR0zeZZo28ynL2Z++S3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzZFHkO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17A4C16AAE;
	Wed, 21 Jan 2026 02:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768963218;
	bh=xB3/bVu9fxc9dswTHUsQz6jp4wYlM5O9I1s/L3N6y1s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DzZFHkO4mOTQdJ24w+o/y3/V8WPlwndezJAX2QAcpF809tzG/VdfJOjjuNKj1PJwt
	 V76deEmO+LiP4R3Z2kLFGIqYY+Ebrx+R0VFJlHE+YhS/qekwAsf8Ab+uJjFbHW7asl
	 q1CrLJz6Lv0m5p6poepKVl8kJW0mhoWNp6KNglXX9ACRbn56xLabaYH1vjblcYGmxR
	 JqJziHFM5dV8NwniyE6sVfypmpcL5seiXlFWiywqdKvn8SjhEjUMUpNUbCpO4+irFC
	 Tu3rgsyUviIqQEO+EYnV+0epWA8ufXyFJc5qAd85JtHoeWKaKDed1FBee8txY2qu42
	 BdUQYRsBPHGeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EFA8380820D;
	Wed, 21 Jan 2026 02:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: hns3: fix data race in hns3_fetch_stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896321609.699622.18082153762490079564.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 02:40:16 +0000
References: <20260119160759.1455950-1-mmyangfl@gmail.com>
In-Reply-To: <20260119160759.1455950-1-mmyangfl@gmail.com>
To: Yangfl <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, shenjian15@huawei.com, salil.mehta@huawei.com,
 shaojijie@huawei.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 tanhuazhong@huawei.com, linyunsheng@huawei.com, lipeng321@huawei.com,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-251715-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: BE6624FF64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jan 2026 00:07:37 +0800 you wrote:
> In hns3_fetch_stats(), ring statistics, protected by u64_stats_sync, are
> read and accumulated in ignorance of possible u64_stats_fetch_retry()
> events. These statistics are already accumulated by
> hns3_ring_stats_update(). Fix this by reading them into a temporary
> buffer first.
> 
> Fixes: b20d7fe51e0d ("net: hns3: add some statitics info to tx process")
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] net: hns3: fix data race in hns3_fetch_stats
    https://git.kernel.org/netdev/net/c/748a81c8ceda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



