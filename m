Return-Path: <netdev+bounces-293270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AbHDFz+GWr80QgAu9opvQ
	(envelope-from <netdev+bounces-293270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 23:00:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D82608C04
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 23:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43B3A301411D
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466B2425CD0;
	Fri, 29 May 2026 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OT1i0a7z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A002423146
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 20:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780088381; cv=none; b=Vgg7tl3Z8R1/nSGD2YCX+IHiEvLFLRK5FRbKgQzZj8UZOlL7MxFMjFWREanMTzw3WU/lSxx6rq9DZ9TpG+4/nlZBZ8CfiVsl7Epl42HMSpZI0R0UKfkplESBKt9d+ihznmeosDv9IDCiIsfxdxmdSJXqx+kpKQZjHClsv2DdBso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780088381; c=relaxed/simple;
	bh=bAEGJxcdlwG0RKB/0Z30dR1kOp5KBPMSiPruyopTHYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nW252CDC5flNW7BThu71qWj10n/zB/VoTi5Y6NpekMpazuhQK0Y7iDaphGI7FDVSc/tHIseAFpwR2prx9I1B49MLdevbeuUCrWqy+0n+E/QtE/F4kscXyRZDCXeyHCyP5fWi7RR8NlaYmqF+6RuKc8fAkIZV1yokBpkITg+JjB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OT1i0a7z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FD31F00893;
	Fri, 29 May 2026 20:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780088379;
	bh=jL452QaglnT/makUrjhGcMYYLM2L+vnHFEcI48RZULg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OT1i0a7zSPKM06hfgSzek7Pq61SWB+lQ7ZaPnFdzgNWyMOcAKdosrzpV0d6l1kBPp
	 MHwYepIsxkUmIw8pYxRfhRwGby/V9Hpa563lO5U3hJ133P3l9gq4GTiFafZ7EmB54B
	 W4CIBjD8VnpKkwP3qE/sJomeh27ORdxaIIdkxU/mLL2k76tUpTJFF5xPvLbGT9Qhwo
	 QAigZBgJxvecUa329h7rq6ipFduP9XKQIbmLOda5go7UZIWCwDCO4BHGjXBDm/MyKw
	 v7mfJSHA2tmu1NolFcu6SXVl879zI1NdA6/7hTtEAWhgAC9x4jysJG7uppOJQmidqN
	 VR83GBozfOZlw==
Date: Fri, 29 May 2026 13:59:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sheena Mohan <sheenamo@google.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, Eric
 Dumazet <edumazet@google.com>, pabeni@redhat.com, horms@kernel.org, Willem
 de Bruijn <willemb@google.com>, Max Yuan <maxyuan@google.com>, Pin-yen Lin
 <treapking@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>,
 Joshua Washington <joshwash@google.com>, Danny Gonzalez
 <digonzal@google.com>, David Decotigny <decot@google.com>, Brian Vazquez
 <brianvv@google.com>
Subject: Re: [ANN] Google's Netdev-CI for IDPF and GVE
Message-ID: <20260529135938.0ba988eb@kernel.org>
In-Reply-To: <CADWJPTsg5G21=hybo81+QHv0+g64d3a+6gGUaJSm1i7EttCUcw@mail.gmail.com>
References: <CADWJPTsg5G21=hybo81+QHv0+g64d3a+6gGUaJSm1i7EttCUcw@mail.gmail.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-293270-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gve-netdev-nipa.static.usercontent.goog:url]
X-Rspamd-Queue-Id: 90D82608C04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026 13:44:48 -0700 Sheena Mohan wrote:
> We are happy to share that Netdev-CI testing on both IDPF (running on
> Google Bare Metal) and GVE (running on Google Virtual Machines) is now
> up and running.
> This NIPA integration work enables executing kselftests against the
> current proposed net-next kernel branch on real hardware.
> 
> Thanks to Danny, Max, and Pin-yen for their contributions!
> 
> The test results and logs are available in:
> 
> IDPF Results: https://idpf-netdev-nipa.static.usercontent.goog/json/results.json
> GVE Results: https://gve-netdev-nipa.static.usercontent.goog/json/results.json

Awesome stuff! Pulling the results now.

