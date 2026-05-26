Return-Path: <netdev+bounces-291668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBrmF0+EFWoSWQcAu9opvQ
	(envelope-from <netdev+bounces-291668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:30:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F6A5D4E28
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F2A09300620A
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47C03E0757;
	Tue, 26 May 2026 11:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYBFKLTS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF3035E95E;
	Tue, 26 May 2026 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779795017; cv=none; b=Tgt5Gn52YqOg1jmfFWLqGluyDoVw8AkF70SJI8U9a3IG7SE5aAx088+SeqUn8UPaBCN97C6Oo+w/LkFb8gUHQ0O458Y1fWMABRzvhlBZOlmxMkUSJUyBA5OAmsJsbnpqHfR7b1rFT00w0a274cSzcXsJQAjJ7Ap5M0JHA4NW4iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779795017; c=relaxed/simple;
	bh=4T0S1SJnmZ//WqYc6v6jMuu2mYXD+SpCpC1Sg7hkdWA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oY8iwR/x0Ey5GrrntdP0IjVA2k33IYUZVnFeWDkEDUSp5TP+E/8CfHLDmFRhZxcjJDnTezJ7/VFEk5JYY1stxJjCtDYCjpkLQUT7y3NU6H2jHIZbNIz5wqp/T7SBG8vuL9zOJB+WJmLG15qxQLaS/CBabdHRoIoWWikOHGlMrs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYBFKLTS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFBA1F000E9;
	Tue, 26 May 2026 11:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779795016;
	bh=rtzF9hdSo6E8OEvCh9hF3LI4xnZS2o7ueMMOUYZMlgM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jYBFKLTSE02JxRCrgm9inwgihqzg2Kr5NpNk8j7jgEDovNXYDiKpe3d7mmcuO8TjM
	 hrm54Hf6VplXtBdozS/WBAVlBWsQWM2LQ9Z9rzS6rIXTh1bq1t7D1aWH8M5/uNE3ZI
	 nl1mgwslpPea9Jse45Ozu2LsNvfR0m1OF5nfgjNqx2HEvM/4br3w2f2xr9H7+dMDE9
	 xGadj3FqT3OTeLib975xEjKKT3gMkYmpq/FzFYrH7m0fovaNsKkOV7KpexBh8dg83I
	 vnNtQKUXdbZ5SAkbhMxYJPiOBl/ssAy27dz1HayMmp9d4B//i+nAe1MHDrATiBsvyP
	 E6jdFy/UJ4CYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93CFD380CED3;
	Tue, 26 May 2026 11:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 00/12] net: enetc: Prepare for ENETC v4 VF
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177979502214.3330509.9195258100271241089.git-patchwork-notify@kernel.org>
Date: Tue, 26 May 2026 11:30:22 +0000
References: <20260522092438.1264020-1-wei.fang@nxp.com>
In-Reply-To: <20260522092438.1264020-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-291668-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 65F6A5D4E28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 22 May 2026 17:24:26 +0800 you wrote:
> This patch series refactors and extends the ENETC driver infrastructure
> to prepare for upcoming ENETC v4 Virtual Function (VF) support. The main
> focus is on code commonization, improved VF-PF communication, and dynamic
> resource allocation.
> 
> The ENETC IP has evolved across different revisions, and the existing
> driver architecture was primarily designed around v1 hardware. To support
> v4 VFs efficiently, we need to share common code between PF drivers of
> different IP versions while maintaining compatibility.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,01/12] net: enetc: use enetc_set_si_hw_addr() for setting MAC address
    https://git.kernel.org/netdev/net-next/c/443a573e7940
  - [v2,net-next,02/12] net: enetc: move VF message handlers to enetc_msg.c
    https://git.kernel.org/netdev/net-next/c/9ba01f877040
  - [v2,net-next,03/12] net: enetc: relocate SR-IOV configuration helper for common PF support
    https://git.kernel.org/netdev/net-next/c/bb69b9fd1c60
  - [v2,net-next,04/12] net: enetc: integrate enetc_msg.c into enetc-pf-common driver
    https://git.kernel.org/netdev/net-next/c/7a3c77287039
  - [v2,net-next,05/12] net: enetc: use read_poll_timeout() for VF mailbox polling
    https://git.kernel.org/netdev/net-next/c/55d62e801dde
  - [v2,net-next,06/12] net: enetc: convert mailbox messages to new formats
    https://git.kernel.org/netdev/net-next/c/3c4542b252fb
  - [v2,net-next,07/12] net: enetc: add VF-PF messaging support for IP minor revision query
    https://git.kernel.org/netdev/net-next/c/72037f953a34
  - [v2,net-next,08/12] net: enetc: align v1 CBDR API with v4 for VF driver sharing
    https://git.kernel.org/netdev/net-next/c/4f46f1accd02
  - [v2,net-next,09/12] net: enetc: add CBDR setup/teardown hooks to enetc_si_ops for VF support
    https://git.kernel.org/netdev/net-next/c/6bdc3144c0dc
  - [v2,net-next,10/12] net: enetc: add generic helper to initialize SR-IOV resources
    https://git.kernel.org/netdev/net-next/c/250069ef0df3
  - [v2,net-next,11/12] net: enetc: use MADDR_TYPE for MAC filter array size
    https://git.kernel.org/netdev/net-next/c/c55a33014b52
  - [v2,net-next,12/12] net: enetc: dynamically allocate rxmsg based on VF count
    https://git.kernel.org/netdev/net-next/c/9d7b650888ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



