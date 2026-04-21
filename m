Return-Path: <netdev+bounces-280118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KkQLq5y52ke8AEAu9opvQ
	(envelope-from <netdev+bounces-280118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:50:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E901743ADC3
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B77693004605
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 12:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5FA3CF685;
	Tue, 21 Apr 2026 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRW2gfz7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FB43BE15C
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775848; cv=none; b=MawDOIeCy8yIyenjJ8Z5YTnx4NDAeVPGPDkojwa758WkgUPBdFoH62Bllekg3rB/cLeHUIqKxBxPkxKbTESaF63VLo3jjmJtWyFZ2LNMrzgIeUOjb+Cu+9+JSSys8kZ6oFSUesT//HVcCFVmhdCgqMtvNQcYOVjbw2HFQkkUHso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775848; c=relaxed/simple;
	bh=zHLgjRB1LuMCBSvVgevKyv7Oic8qKcP2sKvteANDRXU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OdquUtQaSWnrjAEqjsqtlZBvckNiKnL6Rj5eJkZkB34Rs3g3saS0ThXdIA8Bo8sqeePbbGOA5T9qvYWEWLPdS3wTneXixMdDUUKIrPJox2/qJnSWz9YnoVrooMXoisZOeJNVmUiGle13FtQQBG55/yXJHDjCdNmYjP3sIOZpPcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRW2gfz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9A6C2BCB0;
	Tue, 21 Apr 2026 12:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776775847;
	bh=zHLgjRB1LuMCBSvVgevKyv7Oic8qKcP2sKvteANDRXU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MRW2gfz7hq6jWX8IG24XjQJUassdlv0JvbIdnqrl7+PFGW0dBmdD2ur2KDl/69Ig1
	 YHs2xRKZTADyUmIJmFhIpo41dDMTKsBHgTz/3y0ai2r8eUWZq23D5ifL7BT2UHvDM0
	 aANCbZAeAka9hxpDmDDGsWhEP0LnUd/RLGRZLnz5EZsDly/k6eqzAK3ZQQrMBUC3dB
	 J5WyJbKU1vrWkb6lOU5sSXcso5Q+hRmF8cKL3n4bn8Uoh9QoL8KUV8qBhwEnxemEEq
	 yELVzCRGV6ffrnaSidngoXq0FDOnNq9CEyYut5fMxWkcKvfEkgMbJZLJbeRWuzd82P
	 GdHHPjB4KFR1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEFA3930198;
	Tue, 21 Apr 2026 12:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: Fix PPE cpu port configuration for GDM2
 loopback path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177677581130.2390604.14637094256330318723.git-patchwork-notify@kernel.org>
Date: Tue, 21 Apr 2026 12:50:11 +0000
References: 
 <20260417-airoha-ppe-cpu-port-for-gdm2-loopback-v1-1-c7a9de0f6f57@kernel.org>
In-Reply-To: 
 <20260417-airoha-ppe-cpu-port-for-gdm2-loopback-v1-1-c7a9de0f6f57@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280118-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E901743ADC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 17 Apr 2026 17:24:41 +0200 you wrote:
> When QoS loopback is enabled for GDM3 or GDM4, incoming packets are
> forwarded to GDM2. However, the PPE cpu port for GDM2 is not configured
> in this path, causing traffic originating from GDM3/GDM4, which may
> be set up as WAN ports backed by QDMA1, to be incorrectly directed
> to QDMA0 instead.
> Configure the PPE cpu port for GDM2 when QoS loopback is active on
> GDM3 or GDM4 to ensure traffic is routed to the correct QDMA instance.
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: Fix PPE cpu port configuration for GDM2 loopback path
    https://git.kernel.org/netdev/net/c/d647f2545219

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



