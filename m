Return-Path: <netdev+bounces-268871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIenEs4euml8RwIAu9opvQ
	(envelope-from <netdev+bounces-268871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 04:41:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA782B58BA
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 04:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0A46305FC72
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 03:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAE033BBB9;
	Wed, 18 Mar 2026 03:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZlImp5d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B32D243376;
	Wed, 18 Mar 2026 03:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773805244; cv=none; b=ulQLDM0gQq3cIzi0FmzfQkbKTU5D9ad9kjrqtKjszeqMQWCRPC4HvATKyo+DlZ2aU458TmrIo3mqj1sAsKpj6S8CDBjL2ureiEJyVfjTE+pSn/s7ZG/JdDCxxq8uU+Uk87WHxmO1aetRTWGi0bi4hK8fE13GQ0DzKiCmUfDWgKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773805244; c=relaxed/simple;
	bh=b5OWkuV535Oj1V56MTHDGF5WH37w+G2cepaHZkvA+6A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=un6Z2BRoCuKiDLSSx/og4bfcd1cxmqBjgGKuV9FMhj2UWBJRi8YeME2ntxLsRInQsRtwCvVBIFcqSRqEdyvgUhBeUA5j9pcVeVsmo8nMoxfLqEqlJ2a/HXiekS0n+hSaXhfy7iPR7GzVoikSQpgJ/n34i4UIfSe9YbD0M51kl78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZlImp5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170E8C19421;
	Wed, 18 Mar 2026 03:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773805244;
	bh=b5OWkuV535Oj1V56MTHDGF5WH37w+G2cepaHZkvA+6A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OZlImp5de0YUVbmDOxamq0jULzuXJ18Plsj/DYYr1d9yzVnU6jnkLIdgBgapY5l+Z
	 9z/5aKPq8GfU/o4Ld5wUT8/Ii6U5HAKgU1f410onFyYmJkWpepDrCDRmQMOZD1VY/H
	 16gKyCAwyP9sjqfzKI/7vuK50XPkT5mJwMRAU+mEVIMka9P3FSPwfFAjz697NEmuX9
	 F0xrbH4WwthbEiRhnluec/iydIpOUqNsL4LAs2ZPidcH1ZSlPAd6Fnc1oICkd/Bpjp
	 ZvzxCB2LilAYUWlnZt82XHcqnEBkQ8JhkTS3CHM+ye6UiSkWyLw4plYFKqJ9ZGURar
	 Km0HUg2O2yMXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FFCF3808200;
	Wed, 18 Mar 2026 03:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v10 0/4] riscv: spacemit: Add ethernet support
 for K3
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177380523578.113469.12534429691494800323.git-patchwork-notify@kernel.org>
Date: Wed, 18 Mar 2026 03:40:35 +0000
References: <20260316010041.164360-1-inochiama@gmail.com>
In-Reply-To: <20260316010041.164360-1-inochiama@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dlan@kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, richardcochran@gmail.com, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 rmk+kernel@armlinux.org.uk, me@ziyao.cc, siyanteng@cqsoftware.com.cn,
 vladimir.oltean@nxp.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 weishangjuan@eswincomputing.com, wens@kernel.org, lizhi2@eswincomputing.com,
 boon.khai.ng@altera.com, maxime.chevallier@bootlin.com,
 quentin.schulz@cherry.de, peppe.cavallaro@st.com, joabreu@synopsys.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, dlan@gentoo.org, looong.bin@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268871-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,armlinux.org.uk,ziyao.cc,cqsoftware.com.cn,nxp.com,bp.renesas.com,eswincomputing.com,altera.com,bootlin.com,cherry.de,st.com,synopsys.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,gentoo.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0AA782B58BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Mar 2026 09:00:36 +0800 you wrote:
> Add initial support for ethernet controller of the Spacemit K3 SoC.
> This ethernet controller is almost a standard Synopsys DesignWare
> MAC (version 5.40a). This controller require a syscon device to
> configure some basic features, like interface type and internal delay.
> 
> Change from v9:
> - https://lore.kernel.org/netdev/20260312012232.373713-1-inochiama@gmail.com
> patch 3:
> 1. fix misaligned brace.
> 
> [...]

Here is the summary with links:
  - [net-next,v10,1/4] dt-bindings: net: Add support for Spacemit K3 dwmac
    https://git.kernel.org/netdev/net-next/c/bb30400a566c
  - [net-next,v10,2/4] net: stmmac: platform: Add snps,dwmac-5.40a IP compatible string
    https://git.kernel.org/netdev/net-next/c/d35aa97ea908
  - [net-next,v10,3/4] net: stmmac: Add glue layer for Spacemit K3 SoC
    https://git.kernel.org/netdev/net-next/c/30f0ba420ed3
  - [net-next,v10,4/4] MAINTAINERS: add entry for SpacemiT DWMAC glue layer
    https://git.kernel.org/netdev/net-next/c/25e7553a502b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



