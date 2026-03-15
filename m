Return-Path: <netdev+bounces-267903-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGDdDXGmtmnCEwEAu9opvQ
	(envelope-from <netdev+bounces-267903-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 13:30:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7792290AC5
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 13:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FB193042FCA
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 12:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A9634FF7D;
	Sun, 15 Mar 2026 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+keosLe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22A4350285;
	Sun, 15 Mar 2026 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773577836; cv=none; b=EG7pCeIFp6Gz0te3xQmrNGaBFMuLRjlop32vfgxFAB/93vs40EBU6k1S9xSIa3hnlGwnu9YAtUk7++SaAoShu69AdZz5/tERVdjAdV5xVnkdeWsbHAZ9vURf6N0tVREIOSh/4YEB+ooiJaCi2XB2BiDsuHJaIIZrQy+92gNK2zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773577836; c=relaxed/simple;
	bh=z4rhJ0MAlLXWIwBE/DLS0hy7130Yo8vaGFjA4dZQEqk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ThoemGDAz68YTz2gg9+jX1NLz7903PO19fjBniCecZsngpJf/H/i3bw6BK4sifcnqmqnO1VX9Wu1Jhsa9ePLoEzPkro7aEuSijemFspaXZ08F5z/lIpNvzNzSicpxaoe4PsPsc6Lh+7HlsYs8uK7IUnsJe9h6dZUiApMdSDaoMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+keosLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06EF1C19421;
	Sun, 15 Mar 2026 12:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773577836;
	bh=z4rhJ0MAlLXWIwBE/DLS0hy7130Yo8vaGFjA4dZQEqk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=X+keosLemfsI7BVZBzyUQqSVb/q5V/tjHHwClIWYUE6+g2YtxoPRqPk2g6jvAgmnp
	 eIveEsYMRa9hpiR75Q4J31ZLqbO8zpmehsoTJoWr7tlKZ8/GSpbuC0KYFOhppILwVZ
	 dkxs3evpw0DBHNzqc0jA0IVXiiu7QHPr+0X/fZjUZQk6UbjVg+Wd+Ht0RiVd5vLPIl
	 tXrhY+e0R8l9y3SW4lA6vfXJhNW8eyqTYjsOjk7cD4aU95Cp0bFJXO9iuaxHTbjzLe
	 8KmpEZPk5rcB83PcVNWy7SuAG9qKj6UUtfAJmC0FePTEo3lrUMe9hWEL/7jbbehL+S
	 Sc27UiLZ6QPbQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kselftest@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
 Shuah Khan <shuah@kernel.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 intel-wired-lan@lists.osuosl.org, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v4 0/3] ethtool: Dynamic RSS context
 indirection table resizing
In-Reply-To: <20260314093518.43b820b7@kernel.org>
References: <20260313071322.3489243-1-bjorn@kernel.org>
 <20260314093518.43b820b7@kernel.org>
Date: Sun, 15 Mar 2026 13:30:33 +0100
Message-ID: <87a4w9p95i.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.07 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267903-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A7792290AC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 13 Mar 2026 08:13:12 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
>> Some NICs (e.g. bnxt) change their RSS indirection table size based on
>> the queue count, because the hardware table is a shared resource. The
>> ethtool core locks ctx->indir_size at context creation, so drivers
>> have to reject channel changes when RSS contexts exist.
>>=20
>> This series adds resize helpers and wires them up in bnxt.
>
> Sorry Bjorn, I was typing the explanation below and I realized that=20
> we may be violating user intent. We should already record the user_size
> from rss_set_prep_indir() as part of the context (and presumably some
> netdev state for the main context?) and don't allow shrinking the
> context below that mark..

Don't be sorry! Good catch, and glad you caught it now rather than after
it landed.

I'll respin with user_size tracked in the context (and netdev state for
context 0) as a lower bound, so resize never folds below the size the
user explicitly configured.

WDYT?


Bj=C3=B6rn

