Return-Path: <netdev+bounces-290852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qRwYFYBjEGroWwYAu9opvQ
	(envelope-from <netdev+bounces-290852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:09:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD9A5B5DE9
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E8803038A62
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895DA405C2B;
	Fri, 22 May 2026 13:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmYAAOj5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66BB407565;
	Fri, 22 May 2026 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779458233; cv=none; b=pzdhqFI41RdVmdTRNG44Z5QXbQ9vlwxWxQzCjh4QQAyNX0aZ8UExuZEGGN/Rx6wbkHxYfGJdRBTuqBd3vfuYlSeqCQzTUR9UXOA9YMT2FHUqc7TSrBfJYRW+5XUIru7tWi5VED9BGibA9oXcPNFL57teBMcAXyWet9r/RSC71bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779458233; c=relaxed/simple;
	bh=a3ND9OvD3CTrT94oU9J6m7tOAZfAuSPF4/GgkSuvY3k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNDDyqdiact4a7viHrO9yp4E+CpwEwAWxpf5N3+VL/pP4z5zdOz65PlWu3bQacjHqPK8EmHi7v4L1iATGsNoW4aVVmlNYql2ykROoY0xSZuJR1bN1w86Fx2mZ0E/7iKi5bqwPqa1vFJVzbD6zDka9zUrzVpBZ9mnx5BGg51+vMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmYAAOj5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E320D1F000E9;
	Fri, 22 May 2026 13:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779458228;
	bh=K1noXykKhAShRph5zaNh5F3qdcPueU9kCqVJG4yvFuc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BmYAAOj5Yy7k1hfxxXU6ONoytM0zYua3S/Afani5X6uPo+2kjh+CUp+ShN9eabTPq
	 Be9GRh1G4OPOS9QD8R5aghWguOWhXzEkA13Rv7mvb/x0n5rShtEoAHWX2sBl1dihSw
	 NgWDeT0Ww4XNyInMy407tmvvjH6J1pJsCMgDwKrgUkiFWYU2vUxTAsTyYIKt/ZqaUo
	 RvSVUCZI5CTO6Y5RZ1U+Vc7uIasX8QXJQRmAQiGTirUzzLjkwTSFyEeRtufk/8PFA1
	 IzgAAn3bwugkCpxJXaPHLyXX4+fBNUHIESDVz2XyyBBjlElCiKTFisdFPMBLpZUVJ6
	 5KLyR+n6U7ziA==
Date: Fri, 22 May 2026 06:57:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, Mohsin Bashir <mohsin.bashr@gmail.com>, "Mike
 Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Pavel Begunkov
 <asml.silence@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] fbnic: Track BDQ fragment geometry per
 ring
Message-ID: <20260522065707.0599c216@kernel.org>
In-Reply-To: <20260522113225.241337-2-bjorn@kernel.org>
References: <20260522113225.241337-1-bjorn@kernel.org>
	<20260522113225.241337-2-bjorn@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290852-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org,intel.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DFD9A5B5DE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 22 May 2026 13:32:20 +0200 Bj=C3=B6rn T=C3=B6pel wrote:
> Fbnic programs BDQs in 4 KiB fragments, but the driver has so far
> decoded buffer IDs using PAGE_SIZE-derived constants. That works while
> HPQ and PPQ both use PAGE_SIZE buffers, but it makes the fragment
> layout global even though the layout really belongs to the queue.
>=20
> Store the fragment shift on each BDQ and use it when programming
> buffer descriptors and decoding receive completions. HPQ and PPQ still
> get the same PAGE_SIZE-derived value, so this does not change behavior
> yet.
>=20
> This prepares PPQ to use a larger io_uring zcrx buffer size without
> changing the HPQ layout.

PAGE_SIZE can be 64kB, I'd have expected the first commit to change
"page size" from a compile time constant to a runtime knob.

> -	unsigned int pg_idx =3D FIELD_GET(FBNIC_RCD_AL_BUFF_PAGE_MASK, rcd);
> +	struct fbnic_ring *ppq =3D &qt->sub1;
> +	unsigned int pg_idx =3D fbnic_rcd_bdq_idx(ppq, rcd);

This patch breaks reverse xmas tree in a lot of places.
--=20
pw-bot: cr

