Return-Path: <netdev+bounces-290540-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKHDLzBAD2pNIQYAu9opvQ
	(envelope-from <netdev+bounces-290540-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:26:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF50F5AA318
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 616E532A9C56
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88CE35AC33;
	Thu, 21 May 2026 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0rbP9uF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF8135AC16
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377401; cv=none; b=SxZ4WAnDg1VeDFi9TNnmiUdlweJxNhg0AP0zIxC4rJoY1qjpZ3K/BPuVxlfEW5v2JSyQJx4rvMsnFtDxJz6mNR/UVHaMoRsyHmV/r1x0kEN2cTrsjLPcLFGuE5E/8fWRGkAbVVPRCkTJ8/Ip1M8Zb37o12fdPLwQQV6mC/3I41Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377401; c=relaxed/simple;
	bh=avYHqax9fnJxUU4NlMbkjO9tz0OABZ3yZxLTAF4fhE0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K6mHHs8gdvEMdtPfC0yR9plShs76KlmopA41wWrEbCJh2o6iymeZ7BzHvrDqBwukjXD6vlRAIPx/+rGtQKwNQ8ViG7hn4m/Qs8i2XDFDvNQL7INjwoDWRwn12QIriHn8l4oWBOpTamdQe6fAs/mK8KoCZ/jmqd46BOlwUMizNZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0rbP9uF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916FF1F00A3B;
	Thu, 21 May 2026 15:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779377400;
	bh=VKX9aIzCw03XHET/CqROEEEybFBojw+vJaSS15KR2Sw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=I0rbP9uFzGFzgx6WkmjIN5XTGq5WJQP7lBPUwPpy95ewjqmiyDLKkKTgYVBD811oB
	 0TWwhDmGUu3TCPUHVUXk7XYEe1Pk34/m53Z/zGlwqFPzc9+MV5xSDEzBZDhlKyT82s
	 6wv+rAkXQxBkv1NmGZQmlWCLPIlZs7pbrSOmEcY/iMgECI1w2dVQVu5armQV6CJO2u
	 rNAUo3nNuQXOLUmvP9e1TSONHtVMJ5Ln2sRbEDYD7Iglo95UnmnG/nj7bBv+l/uRQF
	 vc+zaAOWTIugKfZYXPa1BdiqFmAoKoLMyiuTmUQbDJrN7/r4ZI4l4t1ex4yl/87Xdy
	 HGvCxt5yV5VmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A753930E02;
	Thu, 21 May 2026 15:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] pds_core: ensure null-termination for firmware
 version
 strings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177937741014.384060.2930118060876469975.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 15:30:10 +0000
References: <20260520205842.1486718-1-nikhil.rao@amd.com>
In-Reply-To: <20260520205842.1486718-1-nikhil.rao@amd.com>
To: Nikhil P. Rao <nikhil.rao@amd.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, brett.creeley@amd.com,
 eric.joyner@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290540-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CF50F5AA318
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 May 2026 20:58:42 +0000 you wrote:
> The driver passes fw_version directly to devlink_info_version_stored_put()
> without ensuring null-termination. While current firmware null-terminates
> these strings, the driver should not rely on this behavior. Add explicit
> null-termination to prevent potential issues if firmware behavior changes.
> 
> Fixes: 45d76f492938 ("pds_core: set up device and adminq")
> Assisted-by: Claude:claude-opus-4
> Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] pds_core: ensure null-termination for firmware version strings
    https://git.kernel.org/netdev/net/c/3d4432d34c19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



