Return-Path: <netdev+bounces-286054-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOTgC599/mnhrgAAu9opvQ
	(envelope-from <netdev+bounces-286054-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 02:19:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 805B54FCFDA
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 02:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E6B13013691
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 00:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF8C16DC28;
	Sat,  9 May 2026 00:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oE2HmQNS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9F1138490;
	Sat,  9 May 2026 00:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778285979; cv=none; b=TDth+afegmVue/f+p/9vf4MEA53bnXkV1+a5btlxE6h0xF2e8+yUfNIAdZmUWz/0DFWOHY9cr4+9dC3lFAeEW67JrAtlrTCVtpDvsuEcR8yDrjOe8h36bkFBiPbOmXFSOuJNDSbX2tJn+X0IeeWiYHifgIZ5xkH3nXW/jK1dTio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778285979; c=relaxed/simple;
	bh=b5qA5vB1EXMLj/yB7RsAZzkcdF3PgoU+Nhq97+UCZz8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncU2MvC4iwBFMtn86NtbQAhO5pDkjItRiMs1PtfCuyY9uGu1tcXf+oTl2qWboCpD1kMmI64XJf+OtmADgqeCBf4OSZMPGylCod81DLw/QbAoSPk4QGRi0oOXsQz/TmYCq7tKBGshYm3ohwIzcwHtS69DRK8kV9QJF6aOr/UZ0Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oE2HmQNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A813C2BCB0;
	Sat,  9 May 2026 00:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778285979;
	bh=b5qA5vB1EXMLj/yB7RsAZzkcdF3PgoU+Nhq97+UCZz8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oE2HmQNS/Q/ccBjA9xlyKCeceeVlStrUxgDk7xZf07bD36CuDtWE9LA8Qj/kZo3YH
	 w9C5wIMQfCt7wRAIK1rIZneK0hPUNsJalA1yPd5cfvSutk36ohP4yaxAiYxFpQDOdq
	 o4KuMVdT6hEJe1T4hk1684MiCu3GUK3THAJ6HJy3cL7CYAy/ufMr3rcYHJ+fagTMSa
	 7Dwh2plsFKfpzKDaDw4idoFymGhgqQJEGYUiKuB+OGS4pdtaaHjymqCUk6hkzGXdE2
	 C6dJqyjE4Wau8FC5HvnqZwLl7Ki+Rh0J9CbRFw06ebLHiT7GTirTUli+TZpM2z/9Cx
	 9fesukQdaSRig==
Date: Fri, 8 May 2026 17:19:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christoph =?UTF-8?B?QsO2aG13YWxkZXI=?=
 <christoph.boehmwalder@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
 linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
 Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 0/2] drbd: switch from genl_magic to YNL
Message-ID: <20260508171937.1c9419f5@kernel.org>
In-Reply-To: <20260506124541.1951772-1-christoph.boehmwalder@linbit.com>
References: <20260506124541.1951772-1-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 805B54FCFDA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.dk,lists.linbit.com,vger.kernel.org,linbit.com,gmail.com,google.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-286054-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed,  6 May 2026 14:45:39 +0200 Christoph B=C3=B6hmwalder wrote:
> DRBD's genetlink interface was defined using a custom multi-include
> macro system, genl_magic_{func,struct}.h. This system generated struct
> definitions, netlink policies, serialization functions and more
> from a single "magic" header.
> It never really caught on; DRBD is its only user, its internal macro
> jungle is next to impossible to understand, and even harder to debug.
>=20
> This series replaces it with the standard solution, YNL.
> The *_gen.[ch] files were created with a modified YNL generator, but
> these modifications are not shipped because the current DRBD family is
> effectively frozen.
>=20
> Note: this family primarily aims for compatibility with existing
> userspace. The next planned step is a new (also YNL-based) family,
> "drbd2", which will implement all the actual modern recommendations for
> new netlink families.

FWIW:

Acked-by: Jakub Kicinski <kuba@kernel.org>

