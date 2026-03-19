Return-Path: <netdev+bounces-269388-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0D47Bu3Gu2n1oAIAu9opvQ
	(envelope-from <netdev+bounces-269388-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 10:50:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A7D2C90A5
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 10:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23F26303A4A7
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643A837FF49;
	Thu, 19 Mar 2026 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwYVAvyS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA183793AB;
	Thu, 19 Mar 2026 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773913815; cv=none; b=bvyZ6QFQRUtxU1t7FYf8dVD8/3JM6fClopnQYzdgLf8P+t1uoxO9nxzyvsUOJw++1mNW+cEK8BMBas5qkXIVvhf+nqqB/kAsb6+NTQyxNBGxFDyhCxYj2UMLHHpHQcI8fN2WzRcGy58iZGCSynTd6+RIZnfxZcpaNZZNVOP3bYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773913815; c=relaxed/simple;
	bh=k8ewNHzkg2OGVcThqrN3sSViY423OjE5NmcGG5AbGlY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VmcZglE/tHRiQQTQ8Ag1bpTrWN/UJSsXUSfTqQ0hrrz0TkZ7+DmVjnhp1X/miKdQEK8qtVCyB5Y/tnN2nSJxQaEpfh3yezzZDWReroqGhJXCfIsdvbC1i3j2t+9idjBjGUJgMHnM+Tl3YvAE2+D8JbRR2ULxYLEXyecWMPJ9QBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwYVAvyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673FBC19424;
	Thu, 19 Mar 2026 09:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773913814;
	bh=k8ewNHzkg2OGVcThqrN3sSViY423OjE5NmcGG5AbGlY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pwYVAvySZrjNQ2n/SPLjWQOqmpJLqrXdZdUwwei9IDvqAeUwQtmijCNw/ALNCXTnf
	 EEpbLVNr1lBwTeIAWhAM3lRxgPk7ljMGo3KNU1LOhoQxll6yYHzzJtK4HnLrHopX8F
	 iPqRXeXUzunmKI5N7K0yG44NDNYamE24r1WZEYAkcU10XnEACEw9/NnXZKIvCN3EL0
	 AXtKbB5XAe9FVZj3r6F4AxY9ZyH2nkbICiMv0G8HDyvPKExzmuxxsEEIH5vpVqoMrb
	 TDdF15+ZZyAGrXk56e0a3obwnYo5mMspLOMjJ0rSwk0oGX5mMAigf4cSQ5SQUsopbe
	 t+7ukVLm+UGHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F7B3808200;
	Thu, 19 Mar 2026 09:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: mvpp2: guard flow control update with global_tx_fc
 in
 buffer switching
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177391380529.1122278.3799765225588594880.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 09:50:05 +0000
References: <20260316193157.65748-1-mhijaz@amazon.com>
In-Reply-To: <20260316193157.65748-1-mhijaz@amazon.com>
To: Muhammad Hammad Ijaz <mhijaz@amazon.com>
Cc: marcin.s.wojtas@gmail.com, linux@armlinux.org.uk, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stefanc@marvell.com,
 gunnarku@amazon.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269388-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,marvell.com,amazon.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6A7D2C90A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 16 Mar 2026 12:31:01 -0700 you wrote:
> mvpp2_bm_switch_buffers() unconditionally calls
> mvpp2_bm_pool_update_priv_fc() when switching between per-cpu and
> shared buffer pool modes. This function programs CM3 flow control
> registers via mvpp2_cm3_read()/mvpp2_cm3_write(), which dereference
> priv->cm3_base without any NULL check.
> 
> When the CM3 SRAM resource is not present in the device tree (the
> third reg entry added by commit 60523583b07c ("dts: marvell: add CM3
> SRAM memory to cp11x ethernet device tree")), priv->cm3_base remains
> NULL and priv->global_tx_fc is false. Any operation that triggers
> mvpp2_bm_switch_buffers(), for example an MTU change that crosses
> the jumbo frame threshold, will crash:
> 
> [...]

Here is the summary with links:
  - net: mvpp2: guard flow control update with global_tx_fc in buffer switching
    https://git.kernel.org/netdev/net/c/8a63baadf084

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



