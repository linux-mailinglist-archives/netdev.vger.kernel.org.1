Return-Path: <netdev+bounces-263189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOaJDCbVpmnHWgAAu9opvQ
	(envelope-from <netdev+bounces-263189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:33:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E8B1EF7DF
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BE47300E5C4
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 12:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107B51AF4EF;
	Tue,  3 Mar 2026 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkXJzJh0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11201A704B
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772541015; cv=none; b=ZEtzTj/lJo3fKA9KNEqwGZByv9ODNbeXn7gsrj7EWPUtWj8pccZD800enDEdw72CatQ03VrRGYUtAySUSnTO7ZaL1oZsYZGaBQ2gdnJzc6L3GuK9R+tjWIyWfnnzPi0xs1q9ou5zA4CBnHiCruV3CCtAcsekchPa0qd22CIUebU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772541015; c=relaxed/simple;
	bh=Hb99zZEnfXUWFcCZg0RwqomnFr/1bYLm8adSEDZXJ4I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O0jKtDT4Tj0STWl7bnw4aegJkILXPo6zl59p+rmCXVvfNd3snzspG7ZdJBF34sLmJ7Jb7H5kXCBsvZse1U79UcjeY612zMonM8hkaBw9/zCFBfsKuPLFzI5NeKe48b3sihhfzdPC41NdVZA2LQ/zpJpXub4KXIZK0VVQyiHjr0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkXJzJh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8E3C116C6;
	Tue,  3 Mar 2026 12:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772541014;
	bh=Hb99zZEnfXUWFcCZg0RwqomnFr/1bYLm8adSEDZXJ4I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MkXJzJh01K4AdnyDXCxtSMHGZnkVj4a5Ks1sVEwei6MkdjQYsl5D4dWJERhFV2TfE
	 l6m9iUNes/d6ONDZpXXMSTLNdYib57JHafdo0OWbU+Eb38T4yDnZR9oe6JRWmO3TuW
	 +0Tt9jxY5jY1srtah3MK2/C4k8Gk8TMzkyXA2Cn9dz+lmHVBlcCcn//9XJs0r1TLGs
	 XHESqQfWlDmiyorm0wLaVs2OpxLUyAf8kbndZdafneRIRUiCu3SogWWFTczbUwomOQ
	 6vcO3786TuwreWlYOfEHZD2HZwdJ7aqZjpJiZLVflabKemesyRS14FsiLoaxXiavKQ
	 X3z4zGJTRoY0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02EC8380A966;
	Tue,  3 Mar 2026 12:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] net: phy: improve stats handling in
 mdio_bus.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177254101579.850080.3261786515806089217.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 12:30:15 +0000
References: <799114be-1456-442b-b479-142e7ee9d254@gmail.com>
In-Reply-To: <799114be-1456-442b-b479-142e7ee9d254@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, linux@armlinux.org.uk,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org
X-Rspamd-Queue-Id: A1E8B1EF7DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263189-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 27 Feb 2026 23:04:20 +0100 you wrote:
> Improve stats handling in mdio_bus.c.
> 
> Heiner Kallweit (8):
>   net: mdio: extend struct mdio_bus_stat_attr instead of using
>     dev_ext_attribute
>   net: mdio: use macro __ATTR to simplify the code
>   net: phy: consider that mdio_bus_device_stat_field_show doesn't use
>     member address
>   net: phy: avoid extra casting in mdio_bus_get_stat
>   net: mdio: constify attributes and attribute arrays
>   net: mdio: use macro __ATTRIBUTE_GROUPS
>   net: phy: inline helper mdio_bus_get_global_stat
>   net: phy: improve mdiobus_stats_acct
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] net: mdio: extend struct mdio_bus_stat_attr instead of using dev_ext_attribute
    https://git.kernel.org/netdev/net-next/c/5c494f404a3f
  - [net-next,2/8] net: mdio: use macro __ATTR to simplify the code
    https://git.kernel.org/netdev/net-next/c/807d8addc3ec
  - [net-next,3/8] net: phy: consider that mdio_bus_device_stat_field_show doesn't use member address
    https://git.kernel.org/netdev/net-next/c/8068acaff125
  - [net-next,4/8] net: phy: avoid extra casting in mdio_bus_get_stat
    https://git.kernel.org/netdev/net-next/c/c599649d05a0
  - [net-next,5/8] net: mdio: constify attributes and attribute arrays
    https://git.kernel.org/netdev/net-next/c/a4c08b701559
  - [net-next,6/8] net: mdio: use macro __ATTRIBUTE_GROUPS
    https://git.kernel.org/netdev/net-next/c/8e0bdf30be75
  - [net-next,7/8] net: phy: inline helper mdio_bus_get_global_stat
    https://git.kernel.org/netdev/net-next/c/7f97ca5f9858
  - [net-next,8/8] net: phy: improve mdiobus_stats_acct
    https://git.kernel.org/netdev/net-next/c/1afccc5a201e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



