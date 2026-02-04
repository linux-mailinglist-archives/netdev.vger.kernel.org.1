Return-Path: <netdev+bounces-256531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPsrDCC4gmkzZAMAu9opvQ
	(envelope-from <netdev+bounces-256531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:08:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEB7E12C5
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3123C3036639
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 03:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DB12882C5;
	Wed,  4 Feb 2026 03:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlqoaHdJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB291E86E
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 03:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770174493; cv=none; b=ROgePUVUh+a7v0MsR9ieDGYy3N7J2Kejd6ZZxOCu0YuyJ5JdfL8B5Ps/pB2voYb5wkl5OEieDNd+fc2DEa+LQfcckStD8oHEYCew3kgC0JmQMm8YOT5rlsILjH8gCmmnCZrKpzgSsrjJb1VHXoGXSqKtGB6C1AtZdWNoy11F4Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770174493; c=relaxed/simple;
	bh=IbOekgSiOz9fatLbIBtKt4h+sxKXahDtpevEP5BSZew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YOJdPJeMt6pWBav7g/MdA83ZEW3czru10T96xa6JuOGe4nj3LNvWw/WldwOL3Uyrou5HHhwYIOeAqDv9h1tQSO6om/lG7dnjNBpjLM2TzYH3PkbGk4rgYFInNQxpIuoSaWD84DsbL/d7jpnMqqI/4L5DEdIXbABkINpT7z4Rr4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlqoaHdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F596C19421;
	Wed,  4 Feb 2026 03:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770174493;
	bh=IbOekgSiOz9fatLbIBtKt4h+sxKXahDtpevEP5BSZew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HlqoaHdJkTYkHrY0aI/1/5OT0kJmVMPDIbDZ3uyBv4f4hu0QAX+dAdtm3ILWum2gc
	 BKQr/EfP8BoCMpynGs8MfAj3t2dFwUH3RGwtDcGHhCmC/RYQuuxKD6R/BrRLLaJzQH
	 FGM6PKu3V5t2Ft2hZLqxU2o3TQggaeC1BWVwd0ixVN9VC/XVENvAzuniR+McY18nkd
	 /iMW3KB1GnjucoJZR7Um2sC7CVYIuIxFDRrbOMeQEUAgsw0aFYsmL+YsUiQ3wcCDgJ
	 5fgjz8Pvpwrj95AaVdSem6o4XK/pXuQchUUg7jm9HMIWyx763KeEqJOjZ6VXPZ6iEy
	 ZWaoEII0hEkwA==
Date: Tue, 3 Feb 2026 19:08:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Pielech, Adrian" <adrian.pielech@intel.com>
Cc: <netdev@vger.kernel.org>, <przemyslaw.kitszel@intel.com>,
 <intel-wired-lan@lists.osuosl.org>, <anthony.l.nguyen@intel.com>,
 <pabeni@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <horms@kernel.org>, <andrew+netdev@lunn.ch>, <krzysztof.galazka@intel.com>
Subject: Re: [ANN] intel's netdev-ci for i40e
Message-ID: <20260203190811.1f9e7530@kernel.org>
In-Reply-To: <b5446385-1f51-4359-b484-6dfccb50dad0@intel.com>
References: <b5446385-1f51-4359-b484-6dfccb50dad0@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256531-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7AEB7E12C5
X-Rspamd-Action: no action

On Tue, 3 Feb 2026 13:35:11 +0100 Pielech, Adrian wrote:
> Hi folks,
> 
> I'm pleased to announce that we have set up infrastructure for testing
> netdev on our e700 NIC (i40e), which extends our current engagement with
> e810 NICs(ice).
> 
> This work plugs into netdev-ci initiative by netdev maintainers to run
> kselftests against current proposed net-next-hw branch on real hardware.
> 
> Our results are here:
> https://netdev-ci-results.intel.com/i40e-results/results.json
> 
> Human friendly results browser:
> https://netdev-ci-results.intel.com/results_browser/index.html?drv=i40e

Excellent!

Looks like the GRO test result parsing is off, the test cases are
reported as for example:

	gro-test-lro-ipv6-ip-tos # XFAIL Device does not support...

Looks like this affects all your runners, I haven't noticed earlier.

