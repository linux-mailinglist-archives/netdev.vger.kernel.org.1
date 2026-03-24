Return-Path: <netdev+bounces-270827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0G5zJbLewWnxXQQAu9opvQ
	(envelope-from <netdev+bounces-270827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 01:45:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E042FFF27
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 01:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CA8330DFB1B
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6D432D0D4;
	Tue, 24 Mar 2026 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otgPlMp8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8B72701CB
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774312824; cv=none; b=jPrroZif0MHIoE1ZDgmFcQ+COXBNk2umyaK9OzZ6ne83IaYIE6Kxzwbt9d4pwnfbR4q7iQTvP4fPcfh8mhVjnXxKiAWA1/Hnt1D7do8etTQcDvYvD+lL0n79Ce4J8Oro6Ok0I9CgM1c+4MVr6B6D7tgZWFjtAc/WuRd8fUfOpY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774312824; c=relaxed/simple;
	bh=btYs4VEc0poy2Koo3Piud4wH+ItfAcitrk7kH+kgg4Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qvuJ1LPx7NG6taOhA8Sk/HXTlATynbSvB1h/oWwgcS4YGXCb3swhu4j3MEQQaF1s9nmEx+zgzuSVyQrSNQzp1QvtjdZ898oTET4jno2Z9Cf5YD4jOgjBL8+8kQdRjEgbkkocESKnOQiPq/8zeggbuj1uggsP5rHKd3hkFH5iD8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otgPlMp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F0AC4CEF7;
	Tue, 24 Mar 2026 00:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774312824;
	bh=btYs4VEc0poy2Koo3Piud4wH+ItfAcitrk7kH+kgg4Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=otgPlMp8nLSa9QtK2QV9+4EArr7VD2cGlymo/MAOl9xOxt+d2wFXF6O7E/wlwtLwy
	 /QmeFsU6DH3Fy2GlmcIlH1l3/Y6HFx3dOipUKcI5h0i1cZRxjylLjh9PhXKF04jq3Z
	 xidLVVloQFWBfFTCi7L951RRBgoidIjgr7o8qfaz0oBRcPJUJ66oeVJkhWbFKsDQA3
	 CN8T2IQBLb1t+ofJc5govdyN+23scnt6JYIXcz+aWF6chqMUWaQ2VxVFC7b9iDbd+8
	 ViXMCX+hGRY0fuXizhO0y6GIuZUfHCToZaOwPVwAKoh4suNBFlH/GYSLUmJ2rBeE3r
	 OY4iqA/CaVFbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEE93808200;
	Tue, 24 Mar 2026 00:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 maybe? 0/5] net: stmmac: improve PCS support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177431281229.391430.10437162930638421849.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 00:40:12 +0000
References: <abrNYVfZ1Iwff2EI@shell.armlinux.org.uk>
In-Reply-To: <abrNYVfZ1Iwff2EI@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mohd.anwar@oss.qualcomm.com,
 netdev@vger.kernel.org, pabeni@redhat.com, vkoul@kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270827-lists,netdev=lfdr.de,netdevbpf];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 09E042FFF27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Mar 2026 16:05:53 +0000 you wrote:
> I am losing track of what version we're at, because each time the
> series is reworked, changing the approach, which changes the
> patches quite a bit, it makes it difficult. We've gone RFC to non-RFC
> back to RFC and then to non-RFC again.
> 
> This series is the next of the three part series sorting out the PCS
> support in stmmac, building on part 2:
> 
> [...]

Here is the summary with links:
  - [net-next,v2,maybe?,1/5] net: stmmac: move default_an_inband to plat_stmmacenet_data
    https://git.kernel.org/netdev/net-next/c/9a475dc71c38
  - [net-next,v2,maybe?,2/5] net: stmmac: add struct stmmac_pcs_info
    https://git.kernel.org/netdev/net-next/c/7d5a2da501e0
  - [net-next,v2,maybe?,3/5] net: stmmac: add support for reading inband SGMII status
    https://git.kernel.org/netdev/net-next/c/083757866735
  - [net-next,v2,maybe?,4/5] net: stmmac: add BASE-X support to integrated PCS
    https://git.kernel.org/netdev/net-next/c/68cff4fff61f
  - [net-next,v2,maybe?,5/5] net: stmmac: use integrated PCS for BASE-X modes
    https://git.kernel.org/netdev/net-next/c/365c62c8b530

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



