Return-Path: <netdev+bounces-269733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ0QBWmVvGmE0wIAu9opvQ
	(envelope-from <netdev+bounces-269733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 01:31:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A162D476B
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 01:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9957310D4B7
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 00:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BC4230D0F;
	Fri, 20 Mar 2026 00:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsYtQycc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BF820010A;
	Fri, 20 Mar 2026 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773966630; cv=none; b=GRclbQ52UpwXeIzg0z7S03BhDol7QFeUqnyvMkoSdiDHM296gzmVJi8htRmjm98PWx3afsJuOmjx+nMtqsfSPSegYO34PH7tI08386pIJ3stDfK8Wca63W4k+AVELYMy5SAlVRHfHRwd2gMkHTsyYHFJW8MfCa39VLh7HOtlTHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773966630; c=relaxed/simple;
	bh=MXeok0SgoLg5i9psIWqgFC1Fr2n3qJgASZfMwKntDK4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cKom4ZeaICRE6Dv2q57ZlH9bQya8BKQHCTw27V+oZnpUETo1jd4X/cCu7/rVYEc0k4ToJoJBEDl7xwPQ3T9ohSh0BpyquiaS1FK9lSQtoR8RUgG+FVOZkAjE57o0OQI8wlic84WdqvEF69DoQSEuVmue+UQ5b63LPxdwIML5OV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsYtQycc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EB5C19424;
	Fri, 20 Mar 2026 00:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773966629;
	bh=MXeok0SgoLg5i9psIWqgFC1Fr2n3qJgASZfMwKntDK4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EsYtQycceyxXWqWLlwb2g54fPQRKnCS2FLzpG0o0sU/wwr/0cWSpg0WHhSNV1HVf7
	 YamBGh65+Hy3sMvf1cLLIntzwi+ApOP5sUeZzCUD27NSaHSeG4voQXnEz6UG/53Co/
	 CDYpqr/JdzoJu9wcfADqlh/F8kptX0n+AfpsB0SdD7+t7vlms9MOxFfzBV33khgeBR
	 d7KjxwBqFZnzlMGrWD9dxcqKXERvvx7okxwiVvrNvrNDY7vbfq5kZ+yHaJqx2AsIc2
	 gP+66Zv9/8hhHmWPiKwP2uHxSE1MKsDCNAthxe5e/Iyd768QpVthE971AydK78FxBd
	 DTiYkrlmVhFmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9ECB39302F6;
	Fri, 20 Mar 2026 00:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: fjes: Drop fjes_acpi_driver and rework
 initialization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177396662028.1861152.3902963437419313881.git-patchwork-notify@kernel.org>
Date: Fri, 20 Mar 2026 00:30:20 +0000
References: <12857407.O9o76ZdvQC@rafael.j.wysocki>
In-Reply-To: <12857407.O9o76ZdvQC@rafael.j.wysocki>
To: Rafael J. Wysocki <rafael@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269733-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: B0A162D476B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Mar 2026 14:43:55 +0100 you wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> The ACPI driver interface used by the Fujitsu Extended Socket (fjes)
> Network Device driver is redundant because its only role is to create
> a platform device the fjes platform driver can bind to, which can be
> done already at the module initialization time.
> 
> [...]

Here is the summary with links:
  - [v2] net: fjes: Drop fjes_acpi_driver and rework initialization
    https://git.kernel.org/netdev/net-next/c/ca7e99335aea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



