Return-Path: <netdev+bounces-263482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMvxNrF3p2kchwAAu9opvQ
	(envelope-from <netdev+bounces-263482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:07:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 805021F8B26
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F030304890B
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 00:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663F61F8AC5;
	Wed,  4 Mar 2026 00:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPcFGXMW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E887A21B1BF;
	Wed,  4 Mar 2026 00:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772582824; cv=none; b=bYxChnRFF7aO+kKY78N+XN5kyNhRAkj7gIu1o/hICGXxt7Po/KKJIb9AbZgh27WYeYVnjuFtODdxF1q1rwZHIM963kcOcDTz0MCKUN2/WRof29LVnhoPtRUPZkxiqg1rMV1rkRKZjxYRIIx0fM/pGgcV5pjjnAn16QIMpyhW96g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772582824; c=relaxed/simple;
	bh=DKvD+Lht8o2ly8XEv5qKbz2/Y5MsEFKRtxvkE7ct8Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfPj5EQfAJD8xPybfwTKrbjbNBr5P71ijH47SVRSVwcYoTVoYHpeBYZ5XHptPGLfkVA0S7ZIkXkDrki5u1y0vsTBQskV50mc7Ivxd3PckSeQMi5WPuhqd1RbEYHFpjaq3OGNDTrXPuwYQtZd7PCqhCMXY8sI8WNukS1AFEuC8A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPcFGXMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4488C116C6;
	Wed,  4 Mar 2026 00:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772582823;
	bh=DKvD+Lht8o2ly8XEv5qKbz2/Y5MsEFKRtxvkE7ct8Zk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vPcFGXMW56W9eqU0YHr7fJLZpTGK1a3AN7o1DOxMJ9AdCquwKxHcgZUfvY7tcP2jN
	 x+wOJOI+4cZ/imfCdvcXfmb74yPkIr5qS8zsxr7Og4xV27cFDUEF2vXC4o+695vUre
	 1CZIbp29r5+vLeNk4X5NQsjvERAvfb/9Wvauw1J2IjyjQkkK7Oi7J5oyMq6YKhxnos
	 hKusvQi1gkV9LAWITBFnKZriQt59RfzotWPMfU9OJEZworp7PGpz6tetjPmAkam6X2
	 hgBQ20izSdr0zB1ti6rykBtBc+nIZlsdquSHYcyn8cNb4zEf71IW1FOBMzkIP2JU8r
	 iWolFwCl+mRzg==
Date: Tue, 3 Mar 2026 16:07:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next 3/5] netdevsim: Add RSS context support with
 dynamic table sizing
Message-ID: <20260303160702.7d28437f@kernel.org>
In-Reply-To: <20260303181535.2671734-4-bjorn@kernel.org>
References: <20260303181535.2671734-1-bjorn@kernel.org>
	<20260303181535.2671734-4-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 805021F8B26
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-263482-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue,  3 Mar 2026 19:15:31 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
> Add RSS indirection table, hash key, and non-default RSS context
> support to netdevsim. The create/modify/remove context callbacks are
> no-ops; the core manages context state in its xarray.
>=20
> The table size is dynamic: roundup_pow_of_two(channels) * 16, capped
> at NSIM_RSS_INDIR_MAX (128). This mimics drivers like bnxt where the
> table size changes with the queue count.
>=20
> nsim_set_channels() uses the core resize helpers to fold/unfold tables
> on channel count changes, exercising the full resize path.

Let's not bother with netdevsim support?
Let the HW tests cover this?
netdevsim was usual when we didn't have HW tests.

