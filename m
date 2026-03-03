Return-Path: <netdev+bounces-263169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPk9EKjSpmnHWgAAu9opvQ
	(envelope-from <netdev+bounces-263169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:23:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C441EF525
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03AF032CE16A
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 11:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B581733A6F8;
	Tue,  3 Mar 2026 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqSvVayH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A9F2D46B3;
	Tue,  3 Mar 2026 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772538608; cv=none; b=RtwKpkSYgck/qt9jFmoeKI2ZH/1thFh5WamUYGMFQeU2BJo2yuZ6krjn0CS27oLp/nIM4KOml0wNYkewpO6u3AAzGqI0WHX4WewaDp5W9ucPFl+fPBjhnWCQPb1T0gvdZIkcmxxQ8swM2HGEwY0vclh145Ett+ysclV5RUtf0SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772538608; c=relaxed/simple;
	bh=9GLyG+++AmoUClZPw6vDXpyimeIQuYiszXoyeZyFG+0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eZZFq2oCH+WpR/hgimyNMNqNFXOGvpS+by+JdgNnJ/1DshrSXXDNdk8ZDH9fyOlAy264LEELGjCSkN49no8t4Ft/oaIg6UKW+7FuetnxUTY5cx4bybqGkHk44NjZcvGeHyFriuHEdxWXz3lxt8HUsRlfbZXgGvcYJc2dPNBJHYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqSvVayH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC10C116C6;
	Tue,  3 Mar 2026 11:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772538608;
	bh=9GLyG+++AmoUClZPw6vDXpyimeIQuYiszXoyeZyFG+0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nqSvVayH179lP2OPO1l96rGSaqaO3HtT2PnaIzaQeYvJRF/HhUkkh8ROJ9g8O06uL
	 cpWETR54+979upoYU1ptZOmxY6qRAAI8MMCRmb4JxplF0YYFbwZ8/tgzCJgtA8i2Z1
	 5M9l/MB+RYTGRcyEQ9mdcbNYWTaNjG0tsR5N0rn7Ev8JILj+jNwsGb8nhj2Fo3ynRW
	 x6JNviRtFXq6Iu9ev1t9WJJBXhap1+I92+UuT7Y47FnnfHWtOHL0OhwqRig1co+Cwp
	 J375p9vmd62/BBDKPaiK014JIdAkNwpjps7z6Vix4MrTEMFyY1ADCgzjYND91acWRj
	 0cBHmXlrMqHsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA068380A965;
	Tue,  3 Mar 2026 11:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ti: icssg: Add HSR/PRP protocol frame
 filtering
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177253860929.835747.5608802035058183541.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 11:50:09 +0000
References: <20260227174254.3821443-1-danishanwar@ti.com>
In-Reply-To: <20260227174254.3821443-1-danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, m-malladi@ti.com,
 jacob.e.keller@intel.com, haokexin@gmail.com, vadim.fedorenko@linux.dev,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, vigneshr@ti.com, rogerq@kernel.org
X-Rspamd-Queue-Id: A9C441EF525
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
	TAGGED_FROM(0.00)[bounces-263169-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,ti.com,intel.com,gmail.com,linux.dev,lists.infradead.org,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 27 Feb 2026 23:12:54 +0530 you wrote:
> Add support for HSR and PRP protocol frame filtering in the ICSSG
> classifier by configuring filter table 3 (FT3) to detect PTP frames
> (EtherType 0x88F7) in HSR/PRP tagged packets.
> 
> Also add rx_class_or_base to miig_rt_offsets structure to support
> RX_CLASS_OR register access, and fix typos in FT1_N_REG and FT3_N_REG
> macros (slize -> slice).
> 
> [...]

Here is the summary with links:
  - [net-next] net: ti: icssg: Add HSR/PRP protocol frame filtering
    https://git.kernel.org/netdev/net-next/c/f56438a74d88

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



