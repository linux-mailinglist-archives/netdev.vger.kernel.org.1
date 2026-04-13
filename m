Return-Path: <netdev+bounces-278161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHL4BJUu3Wn1aQkAu9opvQ
	(envelope-from <netdev+bounces-278161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:57:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 645E13F1BD1
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8110F3075E70
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5823815F7;
	Mon, 13 Apr 2026 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pd5m4oxg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE5A3815CE;
	Mon, 13 Apr 2026 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776102591; cv=none; b=DRhWS7R2tYA2IT4cJIwQgS35zbaNmOuCqGYfkyd42D4knNdr5BmmzIuejYmd7RU8DeEVl4h30xOpugb75TtWZOK1bLJijvV2zvobPyGW8vRXyOhF9pvjONYYEuc5ur0nwc3ZDs8NsKyy2rnLCmdtjGS2HYGvtPTyYsYZz1RGojY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776102591; c=relaxed/simple;
	bh=RHlWpDhqE4IKOkFXV9Fh64KcGdDthPmi41dfkVaT7Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTIw1IA/+oXLLULkPnCKMJaE6LjTaYWEQksRy0fDZTNIYAzb+awuXrf1YouLPnFJSGZ8DUGv2W+VdD/H/l6YfPCyYU9wOfFBlE12i94AV1qQVg572fDXKDhMDz9MdVpY1H+12Nw2VUcvVQ5pjrv65nNTa9tDWplsZRrsQovofdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pd5m4oxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09482C2BCAF;
	Mon, 13 Apr 2026 17:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776102591;
	bh=RHlWpDhqE4IKOkFXV9Fh64KcGdDthPmi41dfkVaT7Eo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pd5m4oxgxc1vqwjyEk7DN6TH2VpxTalo4RumGHaVVor1SNl1iMBx8h2Ag54LYKuru
	 b65KDkBBPKyPXs0q4YhzDqW6ghgjdWFXJIyDy/50knKXbLZkgdKdILK6WEXx+zt2tU
	 7rOj7gCfVGp+0TbEM5ufWQtO031CsBr/bKdocJe54Np+rrhF/Xc8QTPUb5WNnu/GfZ
	 zR54cG5qCcspBnMFrdiWjD3fA6BmIgSN3hQwi8ExomvmsE8+W2JQPHVOqh/1LEMKPT
	 mxWqhQKO35QRtKHhlQAqcG7AZw8rJj3sYXSL+lyXIEBDBFEQ8aAg8UYUdytK8dozoL
	 XqW4/3d5W6dLQ==
Date: Mon, 13 Apr 2026 10:49:39 -0700
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
Message-ID: <20260413104939.5ef4d9dc@kernel.org>
In-Reply-To: <adzVUdf74CVk2DwJ@localhost.localdomain>
References: <20260407173356.873887-1-christoph.boehmwalder@linbit.com>
	<20260407173356.873887-3-christoph.boehmwalder@linbit.com>
	<20260412125502.3f8ff576@kernel.org>
	<adzVUdf74CVk2DwJ@localhost.localdomain>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.dk,lists.linbit.com,vger.kernel.org,linbit.com,gmail.com,google.com];
	TAGGED_FROM(0.00)[bounces-278161-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 645E13F1BD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 13:48:32 +0200 Christoph B=C3=B6hmwalder wrote:
> >Can we just commit the code they output and leave the YNL itself be?
> >Every single legacy family has some weird quirks the point of YNL
> >is to get rid of them, not support them all.. =20
>=20
> Fair enough, we could also do that. Though the question then becomes
> whether we want to keep the YAML spec for the "drbd" family (patch 3 of
> this series) in Documentation/.
>=20
> I would argue it makes sense to keep it around somewhere so that the old
> family is somehow documented, but obviously that yaml file won't work
> with the unmodified generator.

To be clear (correct me if I misunderstood) it looked like we would be
missing out on "automating" things, so extra work would still need to
be done in the C code / manually written headers. But pure YNL (eg
Python or Rust) client _would_ work? They could generate correct
requests and parse responses, right?

If yes, keeping it makes sense. FWIW all the specs we have for "old"
networking families (routing etc) also don't replace any kernel code.
They are purely to enable user space libraries in various languages.
Whether having broad languages support for drbd or you just have one
well known user space stack - I dunno.=20

> Maybe keep it, but with a comment at the top that notes that
> - this family is deprecated and "frozen",
> - the spec is only for documentation purposes, and
> - the spec doesn't work with the upstream parser?

The past point needs a clarification, I guess..

