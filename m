Return-Path: <netdev+bounces-277569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCxdFjJi2WnhpAgAu9opvQ
	(envelope-from <netdev+bounces-277569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 22:48:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B2C3DC8DE
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 22:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6C8B3018AFC
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCDB3A6B66;
	Fri, 10 Apr 2026 20:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPK1x0rS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1022DBF76;
	Fri, 10 Apr 2026 20:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775854056; cv=none; b=cVowm+lJsSMKQeP842jpLSy4ywuvZczwcvjVPmZSzjz8fmX6V1T8k38Yctgp7ihV0+MQs7/jprXHuI8KNYxngvRyx0ABkaSjIAa1dHwlmGOEObutizixQ067mwFOjFpu1AOmxnTAvb8Tu/2p1GWilprU+bLUCxYTXgdXugiBU2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775854056; c=relaxed/simple;
	bh=5ZRNbPtjJic/V5lbdkjU+Pdn5mC6F2+j/+jCmIOHBzc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TS7KJi7EbIKhv34tcTEK2Vz3dVbavf0gFlXC3iS5KM5DT5C+raDRPFT0X/JJQR1MCAPMUiYocZTbP+sy2e0vGDOt5toWeIfdhK1e3bSPXANb/5kx3w8K55uL7H50ccdLbOTFvQWSbjMLsZh8TM2EQUgd+gv/MSD5L5x9qE/KOcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPK1x0rS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536B1C19421;
	Fri, 10 Apr 2026 20:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775854056;
	bh=5ZRNbPtjJic/V5lbdkjU+Pdn5mC6F2+j/+jCmIOHBzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cPK1x0rSBbrDzZEBcDz+etEH7ddDekCBHePuXcqCpHgsSTyfGp8CCFHZfN3E3IoNY
	 lxx57Q7cnHVHMv8otccx6fMTODk4DaFxxddWRmUaxlEcSjWuLShlFHhFHe7jeBHRgE
	 Kp7zpJt3EVJ5RIAvATJs1oWQWpgRpNQ1p0SOZUMgNxhsbffSRWxzwauxNljj4mW3ae
	 Cm07EHtyvOgPkUysKRZUEmQ02Kl4sewObb9o9dBOPRzD7hhShKrbiHtKm2p5AiMYOM
	 39KTl90r2x6BDyxKMikJaWqVyVAX2IdnB4z9y8wyfXAu43NKZ3NrzBAZalK6bdS7SJ
	 DqMxE5jauZTaQ==
Date: Fri, 10 Apr 2026 13:47:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cao Ruichuang <create0818@163.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Stefano Garzarella <stefano.garzarella@gmail.com>, Simon Horman
 <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selftests: vsock: avoid races creating Unix socket
 paths
Message-ID: <20260410134733.1c10a183@kernel.org>
In-Reply-To: <177581562073.13887.468247298173578281@163.com>
References: <20260405195733.86043-1-create0818@163.com>
	<20260410035237.59644-1-create0818@163.com>
	<177581562073.13887.468247298173578281@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,gmail.com,meta.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277569-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 98B2C3DC8DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 18:07:00 +0800 Cao Ruichuang wrote:
> vmtest.sh currently uses mktemp -u to precompute Unix socket paths for the
> namespace bridge helpers. That only returns an unused pathname and leaves a
> time-of-check/time-of-use window before socat binds or connects to it.
> 
> Create a private temporary directory with mktemp -d and place the
> socket path inside it instead. This removes the pathname race while
> keeping cleanup straightforward.

And you actually run into this as a real problem?
How do you repro the failure?

Basic netdev rules:
 - don't post new version of patches in reply to the old ones
 - no more than 1 posting in a 24h period

