Return-Path: <netdev+bounces-287963-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N3ECj/MBWpGbgIAu9opvQ
	(envelope-from <netdev+bounces-287963-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 15:21:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1B5542414
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 15:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31EC9301603E
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 13:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20D73DEAEC;
	Thu, 14 May 2026 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieL68oiE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF51413959D;
	Thu, 14 May 2026 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778764860; cv=none; b=NNI9o3gLXtjLsIZq2B6IlS0Se2PBV22h6eshSEX3OJl/mavg0wVpIvg0mARVQt6skRTqYoenrKHF0kKP8UkrwtnKfTXrgcROHRJTFZ1xeY1X5XxkPcPkUGTA4ZFe28ZVMKqEtQPPSEzRXB7VjQiVR/xhkDRk/KtsMcBL3eTvApM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778764860; c=relaxed/simple;
	bh=b5+uwiv1rRqvFQ4zpfy++OC6J70mF/9B48SIcf/QN6g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qvtU0rKIKlccvib1vy94i4tPQdzE58f+RZjEGSwarT0xysBJaBIqYHHHbppuXA86lNzep//SwSWwEnfpYoDDSXLu/JYQVy7H8UJnyI/xgpCRGq1sqWAI9Ple4/qbGnOCiwZ5auS473rRuQwhCIm3VQoIy/+DIU51KjzlAUjizOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieL68oiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A37C2BCB3;
	Thu, 14 May 2026 13:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778764860;
	bh=b5+uwiv1rRqvFQ4zpfy++OC6J70mF/9B48SIcf/QN6g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ieL68oiExae6AwV99o2CMNDkdl/Es3p5Sm4a4JoLa7cTOhIQHTdfZrDM0xOHhovkY
	 f0itIFvON6zRn/VvWpqPSeYP6V3drw3Dzx+V59/23MghxP9NPGJq0lgWjwqvS52ASg
	 dCjK7G5vVN/XpfYvR5ETwLouH/SjR0SgE0qnFgFV6UafzDRYh2Je8fJj94l6dBqxlC
	 h6HQA8mh5rRIHQkD3JVTEwyipOe+mnCcEkvg87KLlG6X1QmgSpBOr3TZ9pQnU2OzF2
	 6F02ptnkPDR9Kvew6K6hR56H204ignTKLXWbVZyLJAz74Mf3DSdb/HLBmfphUIiaA2
	 c+Vu8b9zju8NA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDA839310AE;
	Thu, 14 May 2026 13:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: phy: DP83TC811: add reading of abilities
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177876480530.4119260.8287001430215972003.git-patchwork-notify@kernel.org>
Date: Thu, 14 May 2026 13:20:05 +0000
References: <20260512071949.6218-1-schuchmann@schleissheimer.de>
In-Reply-To: <20260512071949.6218-1-schuchmann@schleissheimer.de>
To: Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 f.fainelli@gmail.com, dmurphy@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com
X-Rspamd-Queue-Id: CD1B5542414
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287963-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,ti.com,vger.kernel.org,bootlin.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 12 May 2026 09:19:47 +0200 you wrote:
> At this time the driver is not listing any speeds
> it supports. This should be ETHTOOL_LINK_MODE_100baseT1_Full_BIT
> for DP83TC811. Add the missing call for phylib to read the abilities.
> 
> v3:
>  - Fixed indentitation problems. no code changes.
> v2:
>  - Fixed subject and added fixes tag. no code changes.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: phy: DP83TC811: add reading of abilities
    https://git.kernel.org/netdev/net/c/c78bdba7b966

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



