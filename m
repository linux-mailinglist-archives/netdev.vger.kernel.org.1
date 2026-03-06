Return-Path: <netdev+bounces-264914-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA1UFbFAq2mdbgEAu9opvQ
	(envelope-from <netdev+bounces-264914-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:01:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C46227B0E
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 353E0300B9E2
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 21:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC481438FFB;
	Fri,  6 Mar 2026 21:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLLrYahm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A702F0C79;
	Fri,  6 Mar 2026 21:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772830891; cv=none; b=K34oZvowCpXaV+J9jL6AMqpcJV3u7/lM5KEdUpB+0DhKg9LeWvR/WhO8ugaCkikHXz5GYpAPq7fYfl29c/CU6CUMOSGtdIeyaivRqIqpq6IiTU69PyUgMhTEGbC0AlIt13zo5dfoaJJmoTQEdVWjoiWhZOjWqQF6DwdUZbfSl9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772830891; c=relaxed/simple;
	bh=WSE4TX2vKrSPfMke/B27gIYINKQ19826nt6K+Q+4k84=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VMqGZzdaMAalV0C0Lfp9qyqwRcjDimrJA4v5K4XVvZ03hZFivbvGKMshHsPAqlREOU+Id7AEXudga47YQqPoew6Ruka1dVcTQpy4VzQPqgyfOdqqUJNrNr/+W1QTc0uoLF2ZLjPLDcCMXu7DE/N2EGlhYNGqB9SY6DC2z1oFHp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLLrYahm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA35CC4CEF7;
	Fri,  6 Mar 2026 21:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772830891;
	bh=WSE4TX2vKrSPfMke/B27gIYINKQ19826nt6K+Q+4k84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mLLrYahmgBBy+fX3zYLq5NZkzMsVwTY7euuAGALIDhBWRfIZQPjVmYOEGeWywA8ez
	 Qm3hZ/0YwbtoxzAJ0b8kYB835XBlCU7kv5Gjce4calSln7T5TaQcjRSI0C45B04vRK
	 NsLgnK93X/hPJteoXU9VDCApabhdSrzktwaccZD73qycIOYIg2Pk9ejjoPNGBP2LvP
	 YS/ZtzLBvKsgsYhg+814G3AHg++E995B/zQxk4KoQcduHJKikTdTIyF74+h8uCROIw
	 pEpLbotE0OmLd5v4ICI8jX83FmYEekqqr0nIrllrJsVky3z4GA+A1UFFdN1pWg6qb+
	 uxHWsHCNC7V2A==
Date: Fri, 6 Mar 2026 13:01:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Ralf Lici <ralf@mandelbit.com>, Sabrina Dubroca
 <sd@queasysnail.net>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, horms@kernel.org
Subject: Re: [PATCH net-next 5/9] selftests: ovpn: add notification parsing
 and matching
Message-ID: <20260306130130.559d844f@kernel.org>
In-Reply-To: <20260304230643.1014-6-antonio@openvpn.net>
References: <20260304230643.1014-1-antonio@openvpn.net>
	<20260304230643.1014-6-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 31C46227B0E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264914-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.969];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu,  5 Mar 2026 00:06:23 +0100 Antonio Quartulli wrote:
> +def check_requirements(requirements_path):
> +    """Return dependency issues from requirements_path, or an empty list."""
> +    issues = []
> +    with open(requirements_path, encoding="utf-8") as f:

Semi-jokingly let me also mention that you do all this requirements
checking here, all the dependencies seem to have been installed on
netdev CI already. One thing for which you don't check is ngrep,
and that was not installed.

IMO the requirements checking is a waste of effort, things always
slip thru. But unless you have a strong reason to use ngrep maybe
switch to a more standard tool?

