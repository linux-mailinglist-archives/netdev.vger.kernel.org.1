Return-Path: <netdev+bounces-277887-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKAlL5/422n9JwkAu9opvQ
	(envelope-from <netdev+bounces-277887-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 21:55:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 098313E5CAF
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 21:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C47E330097FC
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 19:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B0A365A07;
	Sun, 12 Apr 2026 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vR1mmNVv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFF343147;
	Sun, 12 Apr 2026 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776023705; cv=none; b=HgxL3IriRcPQpY3zKo6CMAhXesPMgQnTYsbC/2TRkUMmDFb4X8nT/FRAXJzpu/HgxeKym6moF3ud353w4n1IO+w5+MvmQD4dipDc32g98CtGjzZ3VQiMLMAUNkCvy5kEbKw5ZsqgoH1Hw5wy+DkVjn7NjCwzUWnoryWhyGnelWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776023705; c=relaxed/simple;
	bh=WdJxeYmmwVGQcrKKOV+mgsVWVSfM6w4XxdfxGzCPDto=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kwWYEEYgS7P8Va5odzCWVDiL6iK1U3PZZM9FJLmJjNKsKeJuW4QB32Dd84faxlFFYbwEm2hKOJ1wJHKs3duyL1uvE4Z+ywIWDGdR9OooLJke0IUaPAlweVYyz1t47PCIJ0I0nrcTRPABcK5fhKXGtKBfk8jwyB1wHCD4HVqkhJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vR1mmNVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6440C19424;
	Sun, 12 Apr 2026 19:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776023705;
	bh=WdJxeYmmwVGQcrKKOV+mgsVWVSfM6w4XxdfxGzCPDto=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vR1mmNVv21poI2EMgosTHT0V+9+hT1hkOpFnBoZFYKcT0UVkK/P1C2nzuM6jz12l0
	 yo9lwh+zCYDkTikyfj/ALNggi06f6AB0/fndZ6rzM+sj1Pw1S3Htjgz3uDuBrIOJf+
	 r1ZTHCGml6I/evdGn6lbyqlyoqAbP48SpH9xQ8ZekR13pSEbATHpwgSq3nbh4rwYZX
	 ZUDxCGwr5XcIjoinUhEjFNI9K07MbMzjfu0f9kyouAGTTzjf6jPxy1EM3VHmrNiyjU
	 Df26pAvhjsU3417ouN/V2bFXXBaBi3mFAhDfhCT0WyS31o4uH6n/mG2tUKkCvTfawP
	 LmxN7joup4XKA==
Date: Sun, 12 Apr 2026 12:55:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christoph =?UTF-8?B?QsO2aG13YWxkZXI=?=
 <christoph.boehmwalder@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
 linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
 Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 2/4] tools: ynl-gen-c: optionally emit structs and
 helpers
Message-ID: <20260412125502.3f8ff576@kernel.org>
In-Reply-To: <20260407173356.873887-3-christoph.boehmwalder@linbit.com>
References: <20260407173356.873887-1-christoph.boehmwalder@linbit.com>
	<20260407173356.873887-3-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.dk,lists.linbit.com,vger.kernel.org,linbit.com,gmail.com,google.com];
	TAGGED_FROM(0.00)[bounces-277887-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 098313E5CAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue,  7 Apr 2026 19:33:54 +0200 Christoph B=C3=B6hmwalder wrote:
> The new flags in the genetlink-legacy spec that are required for
> existing consumers to keep working are:
>=20
>   "default": a literal value or C define that sets the default value
>   for an attribute, consumed by set_defaults().
>=20
>   "required": if true, from_attrs() returns an error when this
>   attribute is missing from the request message.
>=20
>   "nla-policy-type": can be used to override the NLA type used in
>   policy arrays. This is needed when the semantic type differs from
>   the wire type for backward compatibility: genl_magic maps s32 fields
>   to NLA_U32/nla_get_u32, and existing userspace might depend on this
>   encoding. The immediate motivation is DRBD, whose genl spec
>   definition predates the addition of signed types in genl. However,
>   this is a generic issue that potentially affects multiple families:
>   for example, nftables has NFTA_HOOK_PRIORITY as s32 in the spec but
>   NLA_U32 in the actual kernel policy.

The series doesn't apply for me (neither to Linus's tree nor=20
to networking trees), so I didn't experiment with this code.

Are the new code gen additions purely for the kernel?
Can we just commit the code they output and leave the YNL itself be?
Every single legacy family has some weird quirks the point of YNL
is to get rid of them, not support them all..

