Return-Path: <netdev+bounces-251529-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA1yGRjIb2mgMQAAu9opvQ
	(envelope-from <netdev+bounces-251529-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:23:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1744961E
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7DC7A80932C
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16D74657DC;
	Tue, 20 Jan 2026 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFeeKXF3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69BD4657CA;
	Tue, 20 Jan 2026 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924209; cv=none; b=ASfrxL0YkflfcQ0CoPOR+oZgqTD+qRXff9NQLaSi3gaxkP1xV5DiCVtCp9jcIrD+luZ0xZARVDSe4h8ScqGtG7Ls8r61/o1dewPtuUMhp/BlCLOGD0yRMCcPmiN5eJ8ydUbcTjTUmIIsODYoABdZbzBkcH/twuMiCbi4eDlU9gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924209; c=relaxed/simple;
	bh=ZZjyt8cua4ZkqKAaWQbTM7HPeZDV7dBhN5cbqpQholY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WN5fo00GkNM0qxNKt3XLsibf7IM6NhqmWPrazW33c/ityIYb+I35YKKEMfr+P4ebB2rwVP7lwWS3YOtWdYvWvGsAR+5fmu/ngP+tvyfPuW/Gbjdf4e6kyjB3wlfAyNnyiIkvbDq+YOIm1JiR+cO6gZmu+chWeWVviOwjD2ooPF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFeeKXF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4017CC19422;
	Tue, 20 Jan 2026 15:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768924207;
	bh=ZZjyt8cua4ZkqKAaWQbTM7HPeZDV7dBhN5cbqpQholY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kFeeKXF3fgZQVa3KD1dAlMJEgbMat9ZsH3Rpv6SZWKznGxAmGTAdeGfpATJA2AYOW
	 1CnTwDrIiUj5KZTFzWBlrB8oFnQENbCuja+6eJOcyKFjPapj3En8xcq6rVJmR2BNpR
	 UiW4kZ4FkCc5WSuzaKgpeu0XYZcRZ0zqbisATHfYduCT9wpRI/SE9g2ZeHcu3zd8Yu
	 2ssRgTiTs+81ZIdjpki977rR6LBNunVSBgjBOmRsya2lzYxiBBV70ITJC6B8Q1ShG9
	 rLfaKStzZUzGOig3L/iMQNLCrweWdFdJ02uy/b7+sNwINJoPnkfn6XfED3vyW2KMQv
	 eBB+EEn/BTCHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11A193806671;
	Tue, 20 Jan 2026 15:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vsock/test: Do not filter kallsyms by symbol type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176892420460.101865.5448435086952120781.git-patchwork-notify@kernel.org>
Date: Tue, 20 Jan 2026 15:50:04 +0000
References: <20260116-vsock_test-kallsyms-grep-v1-1-3320bc3346f2@rbox.co>
In-Reply-To: <20260116-vsock_test-kallsyms-grep-v1-1-3320bc3346f2@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: sgarzare@redhat.com, leonardi@redhat.com, kuba@kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251529-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 1B1744961E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 16 Jan 2026 09:52:36 +0100 you wrote:
> Blamed commit implemented logic to discover available vsock transports by
> grepping /proc/kallsyms for known symbols. It incorrectly filtered entries
> by type 'd'.
> 
> For some kernel configs having
> 
>     CONFIG_VIRTIO_VSOCKETS=m
>     CONFIG_VSOCKETS_LOOPBACK=y
> 
> [...]

Here is the summary with links:
  - [net] vsock/test: Do not filter kallsyms by symbol type
    https://git.kernel.org/netdev/net/c/5d54aa40c7b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



