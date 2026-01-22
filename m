Return-Path: <netdev+bounces-252154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJ1ROZ+VcWngJgAAu9opvQ
	(envelope-from <netdev+bounces-252154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:12:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1C06134C
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAF105E0DD8
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8937B3C1980;
	Thu, 22 Jan 2026 03:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWlUDAXQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603EB3ACA60;
	Thu, 22 Jan 2026 03:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769051410; cv=none; b=RuIcl6G4WfxgvpBWVXeizhxgM1f4sa1TUTMvU64SKJ724WjDfaS5s3d59k/8uYsc4cKMn01eqeu47yivalXTF0xacIYejWlQ320Kx6N8Zmp+8BF9F3215SeNf9dF9A8GofQffvhI/G/zMGtuoo4rk81q32mp0ZN7Z9Tsvryrchs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769051410; c=relaxed/simple;
	bh=VETuccUQr7uHSZN81IKAXnj6IPAQs++tTbVu5aUIc3E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gbeZgeKveSQKzIVV421JqwB2Fh7z7TXB4F3cPjHn7ayF4LvzT4B958mzouwPT0aIjJZAM+deYkzaSZt/sB9o9JdtFI1GJa0iydJ/CwdHAp2c88d+plxAwuo7hHErrjlpKHNpmu0lYGl3YI/NhFazXkMpKI8mE1PqUqrys7RXuZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWlUDAXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C652AC116D0;
	Thu, 22 Jan 2026 03:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769051407;
	bh=VETuccUQr7uHSZN81IKAXnj6IPAQs++tTbVu5aUIc3E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JWlUDAXQQLhsbSRljv1iDjnfgsfVsKFqCTGFZeEdLcGIrH2OQpHVQKK2al6zm8hn6
	 ZIqnILdv71p3MsgjUCQcithqafOTS4fqNhKe2hv71waQogDTBavdahVr9p4RdxC0cE
	 C+G2f9/dBdyru5HFaYtcJtHpLY/rBBXGvGj5340m/O9+CB+cue59icy1j+UijonuKM
	 vHtRxc3NYGcCUzgF+r2c6VATLNRTV4fN2XvwKyXKNbeRKdIy44YLK4457jRyZsNwCs
	 eTfU08Iy3KobjIitTVU4w3ZUXIzO1xTsEGU0oI2vBWtMAqSEnXFPN0Npkss4fymhRJ
	 OGTjlJ9FDpLEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8C023808200;
	Thu, 22 Jan 2026 03:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net] Revert "net: wwan: mhi_wwan_mbim: Avoid
 -Wflex-array-member-not-at-end warning"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176905140460.1535278.15584487376182391881.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 03:10:04 +0000
References: <20260120072018.29375-1-slark_xiao@163.com>
In-Reply-To: <20260120072018.29375-1-slark_xiao@163.com>
To: Slark Xiao <slark_xiao@163.com>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 gustavoars@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-252154-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D1C06134C
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jan 2026 15:20:18 +0800 you wrote:
> This reverts commit eeecf5d3a3a484cedfa3f2f87e6d51a7390ed960.
> 
> This change lead to MHI WWAN device can't connect to internet.
> I found a netwrok issue with kernel 6.19-rc4, but network works
> well with kernel 6.18-rc1. After checking, this commit is the
> root cause.
> 
> [...]

Here is the summary with links:
  - [net] Revert "net: wwan: mhi_wwan_mbim: Avoid -Wflex-array-member-not-at-end warning"
    https://git.kernel.org/netdev/net/c/2030c4358bd8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



