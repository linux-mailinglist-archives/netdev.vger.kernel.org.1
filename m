Return-Path: <netdev+bounces-271377-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOfUBb1cw2m1qQQAu9opvQ
	(envelope-from <netdev+bounces-271377-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 04:55:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BCD31F4E6
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 04:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1695A3114578
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 03:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010102EB878;
	Wed, 25 Mar 2026 03:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bh5h3/J9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29BF2EAD15;
	Wed, 25 Mar 2026 03:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774410627; cv=none; b=S6rLf/BRydm6kESOMjTmpaSHAF5KjfL/Cp5RQMj6pYcsG5KpUQry1zS8hKlVb1++wYwcG+/cXxWOxXtOZE05wjHBz6Mup/wN/rjJvl+gqoYOJ14s30e8Y38PyHAWZY1eI/pYbvRurTsDitVwjNPGAiOLXT7KoQZIrQFX4t+FOkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774410627; c=relaxed/simple;
	bh=RGHQa5QsG4ig4avoKy58WbOnXoXgJmnhA8I6Wj34rJY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LRrF/oj9sobVrajK8CilrjghprQf0ibSIS/98FcSFGJxFjQO7NoTEIH4c4o9Rv6JCrDcjUgWmevCujT1cIdplLqhV/UbdgHaZ96HHZQvHq3UxeZPQrxUX40tFrLd53bpjr5c5REY4YXEpp3MWCfLtUqXQYqeKZjU24hlJTwtoBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bh5h3/J9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757E2C4CEF7;
	Wed, 25 Mar 2026 03:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774410627;
	bh=RGHQa5QsG4ig4avoKy58WbOnXoXgJmnhA8I6Wj34rJY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Bh5h3/J9zeRCCx5LCs1Y9LMLUATioi1+aOI7ZkYSKdKxb3CFlkskQRjnHfQ49ZQfN
	 Qrs01zIssAON8Sx0DILgXMOZ18PVHVU0FWMIoyourDtVey6uKYELd9QT2+jqGwUaaS
	 RSBWzLHCTtGhlZhVYIGBoSpebMkZxOdpuqbyGp743b/BtcWZL7dyAlQTCJDPRzZ2wI
	 7eUFI/7HgL5VqzXP0JQB4T0oGJnkjGXoWFPGlCzb45in1/gptse2XiCJKJAs3boUKr
	 EdurI2mvrX6G8kYz2gu5tn5AZD7PcMP9dTSfV7uknEBjVuNDISnYr6sPKfDf13d3pT
	 w5TnDL+Ptg6jg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE663808203;
	Wed, 25 Mar 2026 03:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: dsa: mxl862xx: MDIO bus integrity
 and
 optimization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177441061478.1414050.14973716725330389642.git-patchwork-notify@kernel.org>
Date: Wed, 25 Mar 2026 03:50:14 +0000
References: <cover.1774185953.git.daniel@makrotopia.org>
In-Reply-To: <cover.1774185953.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 frankwu@gmx.de, chad@monroe.io, cezary.wilmanski@adtran.com,
 lxu@maxlinear.com, yweng@maxlinear.com, jverdu@maxlinear.com,
 ajayaraman@maxlinear.com, john@phrozen.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	TAGGED_FROM(0.00)[bounces-271377-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 89BCD31F4E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 22 Mar 2026 13:27:12 +0000 you wrote:
> The MxL862xx firmware offers opt-in CRC validation on the MDIO/MMD
> command interface to guard against bit errors on the bus.
> The driver has not used this until now.
> 
> This series enables CRC protection on both the command registers (CRC-6)
> and data payloads (CRC-16), and reduces MDIO bus traffic by bulk-zeroing
> registers instead of writing zero-valued words individually.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: dsa: mxl862xx: add CRC for MDIO communication
    https://git.kernel.org/netdev/net-next/c/a319d0c8c8ce
  - [net-next,v2,2/2] net: dsa: mxl862xx: use RST_DATA to skip writing zero words
    https://git.kernel.org/netdev/net-next/c/7c20f6c1cfb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



