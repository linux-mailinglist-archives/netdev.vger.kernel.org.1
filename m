Return-Path: <netdev+bounces-252438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEgbIJlScmnpfAAAu9opvQ
	(envelope-from <netdev+bounces-252438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:38:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C46F66A1EA
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7AC69300C8FA
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C733F5DD3;
	Thu, 22 Jan 2026 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lbkcm/Xv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852483DDF2C;
	Thu, 22 Jan 2026 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098812; cv=none; b=jZAZaaMOq1pRsrhqHbSYRCvBk4PMy+kCVpwHymFM9Tt9k68LY8fqJYK/s21nuJH2qkNxE8oT7RXXWu2eXJRGf+PSXg5PfE9QyLkCpTx7pj8GOHCUdncadCyXxC5k+276AF52KPj94sf+8b271pwwmaDyednjPno/cZKnwpiXQYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098812; c=relaxed/simple;
	bh=doPWRASXli5CgWaVQnZQX3LHTP+rQ6sgi8LOJGbGsJc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BFJ4F2HUKpZylKvhP4PMmmUi2POxBp3i/Ehv48dkh0WG85BG72U8iOCbydAvIQcTstG5frFQ88Tke2CN94CgByYoIu3r6M8Wv235b5s7U5tK7nGcl12gqeBL39DqUT4wGZmpDgUA9eybrVxLaBMehTCr5YUyyaF1+WScYLAFWaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lbkcm/Xv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598CCC19423;
	Thu, 22 Jan 2026 16:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769098811;
	bh=doPWRASXli5CgWaVQnZQX3LHTP+rQ6sgi8LOJGbGsJc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lbkcm/XvUrF2o2wMq15S0ARN1su/Q3fydwuzZaQRoPgWTPEBI7u5Cr9qYCXxUXYZ3
	 K/4suLKWVo7/UUus+rV+jD6ZMqEnBnOIXUkfcJoQg9PikR2AtFSV0ml47I7mqY9w/+
	 Rv4ZybjD7LNWXx82IBYLiGgweFWDcclV77sp+ojafW+TZfl6D45f/Jc5oIonJ7nxGO
	 +GNjwP3sW08ZBJDPaAdFtqlQRNaQjIVfzjQane7gXXm0Ft33dmrkr9LtQhqQF9ve3g
	 9yOUX36q9MZskZItxIVkxWg5W8T1hoprv1MLEWGprPwLADXTcqi3AF16XytlgKabnv
	 MVQeNlGSlmMAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11B4C3808200;
	Thu, 22 Jan 2026 16:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dpll: Prevent duplicate registrations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176909880785.1793166.12309152684797538271.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 16:20:07 +0000
References: <20260121130012.112606-1-ivecera@redhat.com>
In-Reply-To: <20260121130012.112606-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, davem@davemloft.net,
 michal.michalik@intel.com, milena.olech@intel.com,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252438-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C46F66A1EA
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jan 2026 14:00:11 +0100 you wrote:
> Modify the internal registration helpers dpll_xa_ref_{dpll,pin}_add()
> to reject duplicate registration attempts.
> 
> Previously, if a caller attempted to register the same pin multiple
> times (with the same ops, priv, and cookie) on the same device, the core
> silently increments the reference count and return success. This behavior
> is incorrect because if the caller makes these duplicate registrations
> then for the first one dpll_pin_registration is allocated and for others
> the associated dpll_pin_ref.refcount is incremented. During the first
> unregistration the associated dpll_pin_registration is freed and for
> others WARN is fired.
> 
> [...]

Here is the summary with links:
  - [net] dpll: Prevent duplicate registrations
    https://git.kernel.org/netdev/net/c/f3ddbaaaaf4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



