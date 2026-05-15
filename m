Return-Path: <netdev+bounces-288437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBaqOGp3B2pL4QIAu9opvQ
	(envelope-from <netdev+bounces-288437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:43:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E83555570DC
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA40E3023D75
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2F0413D9D;
	Fri, 15 May 2026 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9mcxaRt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF91413D9C
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778873399; cv=none; b=LTHUu0qcO3MvxLxLqDNPeDGrfe4bZxFW5/7nYVQ2u4ddnIA2SkFLKInYhj/vnzgoUJ6+txCGa4H+zBDGPybipd0unzmafulb7yN9k7VlkWKIj4Lcj+9/g5HvotOUgkZ4xJO4vdmbOBuhzMDhfWESmSCn5FQ6hcm5C/kog5x78Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778873399; c=relaxed/simple;
	bh=2S/TiJJqmScwY2jPUxBtGE41co/LWT09Ij0hT28v8WI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pt3xxP6fMsFMmEA1EJ45XmJZM5kevPKDLJizGkn99XMmhdt/3gE8BsvCeskgmdsuHRZ/fm8aAFV34YW5xDOaGA49I8jeu582F7Dpx7m+nEfHQHacNqxorzpONWB/ePELywAtB8vp6cHn7ByW4lYekK5EAVS8h6iSIT+01bpWZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9mcxaRt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95859C2BCB3;
	Fri, 15 May 2026 19:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778873399;
	bh=2S/TiJJqmScwY2jPUxBtGE41co/LWT09Ij0hT28v8WI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y9mcxaRt+OGDW7NOB6uFIzRKpkYdyktGguB4ezhRl2AODsfRlAQ2L1tIlKV3WndaL
	 lMKc3qB4r/LF5Jh4NWAeIqkQcMZxEwK3gc7qNSIgS5CQlTU3HAZy/xwA1MmeGUQgpX
	 Faxt8+xltcucapze9mtmU4AoYc9lE0hBWZdT3DxPq0O5AsJ7VNDeCmMsOsHVQw9peS
	 1nXC289/QR5vT5as/lCSTNuIQ08kW5rewgcxm5km4cjRUku+yxoZ2DVHVyQM7dtaC7
	 p0GERx2r9A76WHlJqyAz87GnainizCs4OfoooaeGdTPPzilN9Q8aTzQoTqPQQD7r8p
	 uYS4jHcotelGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197ED3930A06;
	Fri, 15 May 2026 19:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next 0/2] dpll: add pin operstate and fractional
 frequency offset to parent-device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177887341263.127669.1029299613309497612.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 19:30:12 +0000
References: <20260513145115.174597-1-ivecera@redhat.com>
In-Reply-To: <20260513145115.174597-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, poros@redhat.com, dsahern@kernel.org,
 stephen@networkplumber.org
X-Rspamd-Queue-Id: E83555570DC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288437-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 13 May 2026 16:51:13 +0200 you wrote:
> Add support for two new pin-parent-device nested attributes:
> 
> Patch 1 adds pin operstate attribute support with filtering.
> Patch 2 adds fractional-frequency-offset (PPM/PPT) display in the
> parent-device context alongside the existing top-level attributes.
> 
> Ivan Vecera (2):
>   dpll: add pin operstate attribute support
>   dpll: add fractional-frequency-offset to parent-device
> 
> [...]

Here is the summary with links:
  - [iproute2-next,1/2] dpll: add pin operstate attribute support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=55cbf807b378
  - [iproute2-next,2/2] dpll: add fractional-frequency-offset to parent-device
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=dde3f17bc311

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



