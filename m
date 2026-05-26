Return-Path: <netdev+bounces-291746-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO7nL/HCFWoAagcAu9opvQ
	(envelope-from <netdev+bounces-291746-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:57:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C61275D92D8
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B95DF30509C2
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEE7338936;
	Tue, 26 May 2026 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g57GTVS7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C14732F76D
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809415; cv=none; b=nkqN13DbqdKEuwoQLc7vJlEC9ZoiYRwVI2AIMxT3920dun0Y67hZeLoMRDTHpLnOr/Jgt0lny96JEG+4SVOWlrhjiblSG29mlR6TkU5vFaseopN+CseHjILAXBTnTP5Ru8H7OoyloEXMRGIxWGrOQCpyvFkcT+u3JydlAS2PiQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809415; c=relaxed/simple;
	bh=yzFkK839+/1f4x3jlmMjWl3Vhg1FlnY5SGJqQuQaYi4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WI6eo101eT1yZC3FAX3V5Orx1BieElv7YgHVLXQnswfaQm+e+yno/2YKIqRSMZllc7i/6fXWQD2of2jfRx8WGrn6emtWmhsPW+8yEXYGD7Fhb0ceolnYSRNMctQEeg613aC0bae4JE94c0xCu7NUnkUqUr7M8bi6uiyj0mLEf94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g57GTVS7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40BD1F000E9;
	Tue, 26 May 2026 15:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779809411;
	bh=6b2qPv1R2bbT1dC5yiUw4GKjS4ZoDEv9VSAYbRRQS7g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=g57GTVS7vuErYV5Z06m4K8eDhIOllj5QeNkVhTteOGoOrWYBka3SquikFg2NYGsqT
	 LL4OnwZA6Q8Y8kRBEb0FY0X0z2tOEAE7S+9HJhw2cGr1ODiWu8PLu4zPrf3P/c+rM+
	 taLb/aIpslJBYpmcHLdw8U+ixr6y13MRj2GmPIbOxRZgAoIt6W0EzCZqmnwLCLsPgr
	 eqL0MO2I2KJxoknocVULfsPvoxKaJof4KTG1dhYv+sG6XghO6ze2+wnNEIUgxI0s1d
	 bSBKoGWJQTpbr5u/AfbhNSuVpZSizZJDlBTfnuIMOkyEaTmXFv/iSr/KP6gAn/bnJ+
	 XeaZXMxW3IpMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19811380CEDF;
	Tue, 26 May 2026 15:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/9] ethtool: module: fix a handful of small bugs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177980941764.3863246.3945329754927899368.git-patchwork-notify@kernel.org>
Date: Tue, 26 May 2026 15:30:17 +0000
References: <20260522231312.1710836-1-kuba@kernel.org>
In-Reply-To: <20260522231312.1710836-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 maxime.chevallier@bootlin.com, danieller@nvidia.com, petrm@nvidia.com,
 o.rempel@pengutronix.de, idosch@nvidia.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291746-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C61275D92D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 May 2026 16:13:03 -0700 you wrote:
> I've been poking at the locking in ethtool and it appears
> that the FW flashing is not currently taking the ops lock.
> Existing drivers which implement module FW flashing seem
> to have their own locking, so this series doesn't actually
> add the ops lock (I'll add it in net-next). But a number
> of other errors have been surfaced in the process.
> 
> [...]

Here is the summary with links:
  - [net,1/9] ethtool: module: call ethnl_ops_complete() on module flash errors
    https://git.kernel.org/netdev/net/c/84371fb58423
  - [net,2/9] ethtool: module: avoid leaking a netdev ref on module flash errors
    https://git.kernel.org/netdev/net/c/fb7f511d6269
  - [net,3/9] ethtool: module: avoid racy updates to dev->ethtool bitfield
    https://git.kernel.org/netdev/net/c/7a84b965ffc1
  - [net,4/9] ethtool: module: check fw_flash_in_progress under rtnl_lock
    https://git.kernel.org/netdev/net/c/504eaefa44c8
  - [net,5/9] ethtool: module: fix cleanup if socket used for flashing multiple devices
    https://git.kernel.org/netdev/net/c/760d04ebad5c
  - [net,6/9] ethtool: cmis: require exact CDB reply length
    https://git.kernel.org/netdev/net/c/6c3f999a9d13
  - [net,7/9] ethtool: cmis: fix u16-to-u8 truncation of msleep_pre_rpl
    https://git.kernel.org/netdev/net/c/3e8c3d464c36
  - [net,8/9] ethtool: cmis: validate start_cmd_payload_size from module
    https://git.kernel.org/netdev/net/c/12c2496a71f8
  - [net,9/9] ethtool: cmis: validate fw->size against start_cmd_payload_size
    https://git.kernel.org/netdev/net/c/d5551f4c1800

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



