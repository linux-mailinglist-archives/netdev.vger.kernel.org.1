Return-Path: <netdev+bounces-295240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 00O+Ic56IWqdHAEAu9opvQ
	(envelope-from <netdev+bounces-295240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:17:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5D56403C1
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:17:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=J+Qq9g4e;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295240-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295240-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A3D03002B7F
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 13:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52C747D922;
	Thu,  4 Jun 2026 13:06:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74F93BE17E;
	Thu,  4 Jun 2026 13:06:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780578388; cv=none; b=p0MnZqjnrH3kDmM6x7W362Cm7/lXNNPfe2p/FRxpJODGITsZ9o4iZQvW44l3uXdwVYUTtqyaGo2d5q59gJTBmkljdUksJ8JVvRhbh/TeXHRSuMgUaZZYJQXpIWGAqa5AVwJ9NyrAue4VgYA+672Tn2f50xu3k98/ULLrIiG8bSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780578388; c=relaxed/simple;
	bh=t/bnHVvLxSnLu7GFAfeDE6W9zRykt9dyoZD7Bp1dM8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+U9EILtBgxB65TE9ziYP9e6QGFumE0sUWnXHjmWfVAS5cwSbz4xC7gCwJ0IRL06VkmrzO9AHlJtLaE3CPPBpNOn+VcQt5YtT7SaeC3Sr4QHnqyTqb5Q84c2dobB1ZZPeHOqu0DV/UgLNv+Te7JJTNySmf7VSh9xbMKDtZ4jp9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+Qq9g4e; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8A11F00893;
	Thu,  4 Jun 2026 13:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780578387;
	bh=Yk7G4nQ76kEw4V8LfGixmYzRqb+tUcXQEXr+9JxJya8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J+Qq9g4ecq6sFBscMlTP5Yd+894YldsFLUszk5+a4sBaXHEHvTdLhRnn9UekuoDLN
	 /gY8+t2iBNybiMJoZAw1p5RGzGvV8Q3ZMQqiiX0+BP9YJqRaCGi8UANpo5FSZCvLXo
	 AI0VKx5InvAx3ljDvwT2DXzrB0QDhe8vJfrCLh9c8+wB8kv7RufsKFcMn/eKmmJTBE
	 UNb9FYDFzjojwOhrCT5DmnN9MA5y9gmDIYvQEEVs7Cxo5jeuntl4eAbR3xQrO55Pyr
	 mjSsYj14vx05f9cFVuwGQW3Yy7oCXv8rGa5n7qc6sA2tWdJgFiLHKIIiS5BhnnNfHr
	 Gus2LDtsORCvw==
Date: Thu, 4 Jun 2026 14:06:22 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next v2 0/3] netconsole: Fix reported problems
Message-ID: <20260604130622.GB3920875@horms.kernel.org>
References: <20260602-netcons_fix_before_move-v2-0-eca3f8a8b1a3@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-netcons_fix_before_move-v2-0-eca3f8a8b1a3@debian.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295240-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,linux.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D5D56403C1

On Tue, Jun 02, 2026 at 07:26:56AM -0700, Breno Leitao wrote:
> These are some of the issues that LLM reported to netconsole, and they
> are being addressed here before big refactors.
> 
> I was doing some big refactors, and got some "pre-existent-issues"
> during LLM review of the refactor, that make them hard to guarantee that
> refactor is not introducing any bug, so, let's clean these pre-existent
> bugs first, and then submit the refactor.
> 
> The issues fixed in this patchset were reported during the review of
> https://lore.kernel.org/all/20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org/
> 
> Not all of them got fixed, but, those that were easy to reason about.
> 
> Why net-next and not 'net' tree.
> 
> Most of the functions that are being fixed here moved from netpoll to
> netconsole, thus, fixing this on net will cause merge conflicts from
> 'net' to 'net-next', thus I decided to fix it on 'net-next', given we
> are on 7.1-rc6 already. Sorry if that is not the right approach.
> 
> Changed from v1:
>   * Change it from 'net' to 'net-next'.

Hi Breno,

There is AI-generated review of this patch-set available on both
https://sashiko.dev and https://netdev-ai.bots.linux.dev/sashiko/

I would appreciate it if you could look over that with a view
to addressing any issues that directly effect this patch-set.

