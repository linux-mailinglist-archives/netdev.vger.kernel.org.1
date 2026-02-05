Return-Path: <netdev+bounces-256920-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AQJLrUAhGkbwwMAu9opvQ
	(envelope-from <netdev+bounces-256920-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:30:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B34EEDF95
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2148300FB56
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 02:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514692BE657;
	Thu,  5 Feb 2026 02:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSJZ1K8p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9302BE051;
	Thu,  5 Feb 2026 02:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770258610; cv=none; b=llnN0HeV8s4NZPl7Hs2Oqlaa+xste9mVVI5mt5mArkqi0dTOxLrwBkSaJxBCOpdmlfILl6J9Ag9WKhm50o/SdGQi8dpbDqIVh97FKbr5WzZCVwzkkd5wuBLNsozNYOIpjm/JG5VoAadCVH2ZGgJufzz/zFMpvWkW8Oer8HTEoIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770258610; c=relaxed/simple;
	bh=1wc5PdUchyOEUz6O/c6N92zSn0zymMQmvEmSPDBdI3Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SkYVV7aQPGk25lPaz/TKS+o73FyzNX3XLljlKVeOwbB58NiU0Oc5P4CxYKarjz5DcFhleqRVg0z35bzYAvqjxlraLn/maRLt42jj+0GZDTz1KkMpWNuPWI4/SR6k9pK0qqEosWG2PthidB2JXtD6HAbzrRDE35GuSCqrho9aFlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSJZ1K8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07902C4CEF7;
	Thu,  5 Feb 2026 02:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770258610;
	bh=1wc5PdUchyOEUz6O/c6N92zSn0zymMQmvEmSPDBdI3Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lSJZ1K8pWyoZfCz15uTLU2VKgg/HklYNXvSckVy89SHs4Ke0gd/rqOnMWLH6e4uEU
	 M+yyKOGwy4C+KVeYO3/gb8iIusHcsmpGf6KJVqCTwGilMtJXzs25w6v3vIzCnWhSMb
	 K8ks0kcuSEO06vUoNHxbeSKuCsVl9bqYwLbVjJXjQ18zlaxLBYYDXP4LweAhmvo6q2
	 /omtSTMAsW2MvKvE8egqpYrUQoopmHK6ruX2zn9PFWXaIrDGh/NWivab2WmntryQeD
	 DMJ46ue5kztpaMwCcMskTfbvi9IFNt7knjYvbutm3eCgB86/L6CcyfAqRjFbzo1yVg
	 Zbxe81BUO/Ing==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4838E3808200;
	Thu,  5 Feb 2026 02:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 0/3] s32g: Use a syscon for GPR
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177025860808.131667.13084016124799705995.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 02:30:08 +0000
References: <cover.1769764941.git.dan.carpenter@linaro.org>
In-Reply-To: <cover.1769764941.git.dan.carpenter@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: chester62515@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, conor+dt@kernel.org, davem@davemloft.net,
 devicetree@vger.kernel.org, edumazet@google.com, festevam@gmail.com,
 Frank.Li@nxp.com, ghennadi.procopciuc@oss.nxp.com, imx@lists.linux.dev,
 kuba@kernel.org, jan.petrous@oss.nxp.com, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, mbrugger@suse.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, s32@nxp.com,
 pabeni@redhat.com, kernel@pengutronix.de, robh@kernel.org,
 s.hauer@pengutronix.de, linaro-s32@linaro.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256920-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[gmail.com,foss.st.com,lunn.ch,kernel.org,davemloft.net,vger.kernel.org,google.com,nxp.com,oss.nxp.com,lists.linux.dev,lists.infradead.org,st-md-mailman.stormreply.com,suse.com,redhat.com,pengutronix.de,linaro.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B34EEDF95
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 Jan 2026 16:19:35 +0300 you wrote:
> The s32g devices have a GPR register region which holds a number of
> miscellaneous registers.  Currently only the stmmac/dwmac-s32.c uses
> anything from there and we just add a line to the device tree to
> access that GMAC_0_CTRL_STS register:
> 
>                         reg = <0x4033c000 0x2000>, /* gmac IP */
>                               <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */
> 
> [...]

Here is the summary with links:
  - [v6,1/3] net: stmmac: s32: use a syscon for S32_PHY_INTF_SEL_RGMII
    https://git.kernel.org/netdev/net-next/c/b0eeeb1b70c0
  - [v6,2/3] dt-bindings: net: nxp,s32-dwmac: Use the GPR syscon
    https://git.kernel.org/netdev/net-next/c/0d9588039543
  - [v6,3/3] dts: s32g: Add GPR syscon region
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



