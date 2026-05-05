Return-Path: <netdev+bounces-284599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFN2EGF6+mlePQMAu9opvQ
	(envelope-from <netdev+bounces-284599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 01:16:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0344D49CD
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 01:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5844C301877D
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 23:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFEF1F1534;
	Tue,  5 May 2026 23:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxmfHOtZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EACCA6F;
	Tue,  5 May 2026 23:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778023006; cv=none; b=LTv5jy4FY3J+4IrVncbrB3r7a1h2O5ugtZupQkAeahmzB/fjadxrB5ORq45MkWAYxk7wo6qbzhe2WTJ+br9ugg75XrVe4hJ1plUhap0CLiipPzzHF4w0XW96vJnuBKcv9xnJHQxXeIZZycweyYMbtMeJNvDUzMqAKFSxa2/XUrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778023006; c=relaxed/simple;
	bh=nS9bfT8zK49jmC0dUWw2ngeOCqazm+jrd5fomE/rMiU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8EOxbgJ7krqut+jg1xrArmoiYiSRZP2tM/ufdOEelAUq7MNo8ttUGCa393cI9futnQZHSBQCiZFvaSJk6Q75FZMJNfoQRFd4nmjvTJ7UzFEOEUbA8UdGGBwZCLMZgtze6aSuofSj7canGaC8wmhIeMgPWVSYbqf+CorJWJxKRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxmfHOtZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D125C2BCB4;
	Tue,  5 May 2026 23:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778023005;
	bh=nS9bfT8zK49jmC0dUWw2ngeOCqazm+jrd5fomE/rMiU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nxmfHOtZkFwnqyialFj7b4w6ZbInFQOh0/D3MpisbSYfSAqbpTBsb2tooOsrOIXn5
	 ixlSAZad21UUwZZArngr8+MGVBDGT8t4EgkOBQmXo6PnAIYwUsmyqZKdK6dFD5Gy3g
	 LruLgIjMpePrMNAcqlp1pfH3HMatWqVhXIaBwkmm/MPzTQM5dfv4S+Dhcs/EuMkONA
	 TJfEUJ23UyKnhIU2gPxLv4IZrG/p5lBM+Fl/CKKJ5LAs19M6Ul9jVGjFxpD5Ozau/f
	 EFpK57/5w0g4UpEmrFXa1vdalV2kRpFf0McozQAGfmqaBRvrQYwT4XQiZyHwXJWi6S
	 wkNrvvKb3O7bA==
Date: Tue, 5 May 2026 16:16:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lucas Poupeau <lucasp.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] llc: fix coding style and memory barrier documentation
Message-ID: <20260505161644.0fd7e3ed@kernel.org>
In-Reply-To: <20260505192549.74382-1-lucasp.linux@gmail.com>
References: <20260505192549.74382-1-lucasp.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9A0344D49CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284599-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url]

On Tue,  5 May 2026 21:25:49 +0200 Lucas Poupeau wrote:
> Fix multiple style issues reported by checkpatch.pl to improve code
> maintainability and compliance with kernel standards.

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~
  
  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:
  
  * Addressing ``checkpatch.pl``, and other trivial coding style warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)
  
  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.
  
  Conversely, spelling and grammar fixes are not discouraged.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches

