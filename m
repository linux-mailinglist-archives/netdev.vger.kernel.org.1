Return-Path: <netdev+bounces-273871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGGwKICPzGnXTwYAu9opvQ
	(envelope-from <netdev+bounces-273871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 05:22:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7E63743FC
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 05:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 28D623038CA5
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 03:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184B4331A56;
	Wed,  1 Apr 2026 03:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onNkqnsA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E877B30DD2A;
	Wed,  1 Apr 2026 03:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775013622; cv=none; b=orKLltNQbUZdMYjE+p24RFz4yOpzY4m/K++Gr6J1ulAgIu+70EsEY64JsgkUJ5U2u9w56RoohYhOKqr/1lNWvnEoY6/cUnEssZwLUJbFzN12jdm0NultRXl0EQGTcMS8kbxdk1To9ugeUntHMORtTClw/Z61Rfr07RvUzI30h6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775013622; c=relaxed/simple;
	bh=aUSRSDwAprZUGjJG035g+sUqRo6NQqcdjqTDSA/goZM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rxS+p8P5QhT6Na3MqiKFFZjV/+/Tzjk2bJaxFH0rDdUWKruvgXr9UjKPAMY4STcAlwjnoUEBRoYB31L/uE3zSJoc5j7BPMfGl+i6T/MmvmcWZgqFZNTWQsyxd+dlkKi2ntlZqMMWzBazCSZniIZ3gAByq1Rxh+/pu04hm92K9v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onNkqnsA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B17C19423;
	Wed,  1 Apr 2026 03:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775013621;
	bh=aUSRSDwAprZUGjJG035g+sUqRo6NQqcdjqTDSA/goZM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=onNkqnsA5vBC8Yh2W9929sN4fnZMRbaJZDiAl/c/3OZbRivUldF8548sLx6kqpmWU
	 QYCKqjI9rVdx6yTI7shSFGDeGlh8PpaXEL8J5+JepeH5sikV/MS5+1Esl8ign4cZ5I
	 OCYdsoV293EYPUJKveNAQ7mBwGhGDqW4LMilYTq0FEieiNDqFzxHbl9z0LjwVEy6uT
	 lNaIIndbJORybC77AwYeqInOnpwVC06nrO1k8QQpV6dCV4FY8yMVU2aTeCNkgq83UR
	 Iqi3huwiGOQtOa9eXvvRnlCj4/J7CkmapvM/QlAuiNDQ3RBdiTni0DrpV0sOF9bhgu
	 z1wiaYB3ymlSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DD23808203;
	Wed,  1 Apr 2026 03:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] net: stmmac: skip VLAN restore when VLAN hash ops are
 missing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177501360479.3053582.8123053098284273856.git-patchwork-notify@kernel.org>
Date: Wed, 01 Apr 2026 03:20:04 +0000
References: <20260328-vlan-restore-error-v4-1-f88624c530dc@mmpsystems.pl>
In-Reply-To: <20260328-vlan-restore-error-v4-1-f88624c530dc@mmpsystems.pl>
To: Michal Piekos <michal.piekos@mmpsystems.pl>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, ovidiu.panait.rb@renesas.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273871-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,renesas.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB7E63743FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 28 Mar 2026 09:55:51 +0100 you wrote:
> stmmac_vlan_restore() unconditionally calls stmmac_vlan_update() when
> NETIF_F_VLAN_FEATURES is set. On platforms where priv->hw->vlan (or
> ->update_vlan_hash) is not provided, stmmac_update_vlan_hash() returns
> -EINVAL via stmmac_do_void_callback(), resulting in a spurious
> "Failed to restore VLANs" error even when no VLAN filtering is in use.
> 
> Remove not needed comment.
> Remove not used return value from stmmac_vlan_restore().
> 
> [...]

Here is the summary with links:
  - [v4] net: stmmac: skip VLAN restore when VLAN hash ops are missing
    https://git.kernel.org/netdev/net/c/48b3cd69265f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



