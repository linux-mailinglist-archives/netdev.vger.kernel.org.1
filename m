Return-Path: <netdev+bounces-251670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLqxLCcacGkEVwAAu9opvQ
	(envelope-from <netdev+bounces-251670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:13:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6BB4E60F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28B8C50F2AF
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643D422F767;
	Wed, 21 Jan 2026 00:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xo1vFzb+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C3722A4E8;
	Wed, 21 Jan 2026 00:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768954211; cv=none; b=Giof08nqigS++GxfCDhdeTlN/wMWVJVu/abJo5tLge4/ePmuF9LoT3H6m5wEonHsUuvHqImpyi+t83biSWbSPWpKkUJJudlnbNQg7FBlgv/l6xa7R9IPGVaJZqrK5QNrlxGH8bneGWIrnLhh88xC7EyOnVOOJxE9TZWJ8J2jyXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768954211; c=relaxed/simple;
	bh=EMr/DoMLChMMSL51PhhrUGNiqV4mWQOyMCVdeds/Btk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ELHJhlFG7lxXTEeQIlJvbW8wN2fFeJRVPy+owN1I1QDnUrNNsrSIcHalOjkFEaLwRPcaxS9OUGUZY4iDVMN426IK3OUfr6EXL09ukLyddAn52S4bXXvijLmtSF+8hDtG+cMJUfFQlY2i5dcqmfsGwG2ZbdM2+Nj2l5PI+bm26Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xo1vFzb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A317FC19423;
	Wed, 21 Jan 2026 00:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768954210;
	bh=EMr/DoMLChMMSL51PhhrUGNiqV4mWQOyMCVdeds/Btk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xo1vFzb+oo7wkO38Zp+eJwnp6yVzHJk4PBHzlSRpgC2ZBjf3javTnwG4NxB0EXhu1
	 DKR6zdd3iuQvuGwKuvZGxe/WInvy5Tq4Uub2jE3rcS995ylxBsYRkGRSyu08kVACCZ
	 xN4BeMHBIKe/iguZXMQ+8HUTB1N9v4x1yn5sjBcg+jb2zfKPVDaqPnSQ8y4OubyyTN
	 v8DOWa3RwP15K4iMacO4QsdD/qfQT/L7ADqFYmNesE9hRrvuR65lbm3NZl1kUawg+a
	 eEhap9KRobx6GeD7gYPTdJr1QPnk/WjgpbxdoF+HU6XJDFniM+24FhghkCfY8+NNT6
	 MEAkiIGqm8CGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4ED02380820D;
	Wed, 21 Jan 2026 00:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: phy: intel-xway: fix OF node refcount leakage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176895420809.659962.727652527212463185.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 00:10:08 +0000
References: 
 <e3275e1c1cdca7e6426bb9c11f33bd84b8d900c8.1768783208.git.daniel@makrotopia.org>
In-Reply-To: 
 <e3275e1c1cdca7e6426bb9c11f33bd84b8d900c8.1768783208.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251670-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:email,linux.dev:url,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 1F6BB4E60F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jan 2026 00:41:54 +0000 you wrote:
> Automated review spotted am OF node reference count leakage when
> checking if the 'leds' child node exists.
> 
> Call of_put_node() to correctly maintain the refcount.
> 
> Link: https://netdev-ai.bots.linux.dev/ai-review.html?id=20f173ba-0c64-422b-a663-fea4b4ad01d0
> Fixes: 1758af47b98c1 ("net: phy: intel-xway: add support for PHY LEDs")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: phy: intel-xway: fix OF node refcount leakage
    https://git.kernel.org/netdev/net/c/79912b256e14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



