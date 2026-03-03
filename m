Return-Path: <netdev+bounces-263033-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHOTO+NjpmnePAAAu9opvQ
	(envelope-from <netdev+bounces-263033-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 05:30:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7FE1E8D86
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 05:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55B1D301F172
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 04:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA825282F1D;
	Tue,  3 Mar 2026 04:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zlgh5xID"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4CC3909BC
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 04:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772512224; cv=pass; b=r4+l48efw+B6kqyBQYz8DZfbOcDNUmhhhjamcrd6J7fZOMnBl+s/LeFurFp6U0Kbvr9A8qFJN2EJ3k1rvpBZDmJXPR2Gt01SEBlS2XDvPxpXZl/fQjROI+ku9HGV+xDVRFyEjBzBj6CPddkXwvv9Fc13dQ4tBkh/8y/1wDeyttI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772512224; c=relaxed/simple;
	bh=/RZ445+hR3jjZ6wsRRo1X6vj8A/uTV4ICGyB7dlH6qI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lf3NikO2lBXp737uTdYjplHxtcm8Y9GwcbQH2LoiE+Hz4DHXeIB4gikz7iv40mzWNhxsKNqfvZyTXAoHNfEQfK1kkzgasyB8dkdTqTl1sl9nPu/p8RI1n1Tc/ug4/leUunMcYKObEw4e38dmg/D2hl5RoqW1niYrP5qiOVGR+FA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zlgh5xID; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506c02ec1b3so61445261cf.0
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 20:30:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772512222; cv=none;
        d=google.com; s=arc-20240605;
        b=FZGVTNpgRSgtDs0aZL6Ro6iAqu31MvSE5Nza3B1SYulp7VUPwZdBBs+xB9boBkqagl
         vNIMWpTcRFSWPt+BcIyKhO2n0bLq0j5WpYdt8cM2zKmiiYGl4dg9CP6cCbJ6S12j6gIn
         sP7GPZFHr1Xbc2bXt+fDAKAz5QOemuigjQT+3WYUDe5KXOAVqT+2r3+ps2SoeKvuOdSC
         Y3DQ6eT2NDZP8SrJ3YVjB7lPSiJDSVHphjcnZHshIIpnToZE8r/tLQHBy+SXNp6HRRpO
         FxPRQWYxPtBqdMh5UbdNQ2bFKwrbI8yTbr9wqIFEe/jes5hDFnxEjqEfgwpECxZemoh3
         zUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yEqROSPbboZGgQozME32vz2BWITqwBYlmthyib6cgEg=;
        fh=KQO6NLp0W1FE4OEP1b7jdykZ+MdYWVyC2r6ymAeqkto=;
        b=B2SbIUGMXIfx0xZGAcTlRhg0yS3eURypgQWhraCI/ELrr2yPRC4kim9TdRPKXmO7t4
         m40TPrK5wL37Zab9yl+rteO+o4aOTTb9Qqz1PP0PwxZsLa8AdK385tWsuAtGnTv2g0Xf
         02W2nuwm1t2TS7FRMDVmZRh0S1bLrTvdUz+5DC8MaKBoR1i6y55aX+ONgsM/MKa6F1E6
         9qVvrcLe1XNnrW+8ALBmn0Yvsdu0oSX4LvvA1lyUMVXWgtFzSiaPjtHADEGOx/smbhau
         8K5GDCKicWvEi7dVsDH28zUFDsQduwdEE4DaUsqE0+UIm9RpbLEmVQO2NYUwVd7aP3S3
         X4bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772512222; x=1773117022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEqROSPbboZGgQozME32vz2BWITqwBYlmthyib6cgEg=;
        b=Zlgh5xIDlFqVCtAiEzG3b0Tbht4nFL7sFiQfl57omloU4HppKZMsRyneyth26UqvRw
         NmBCrLG5JRPtG+D2thT4fLmT/BktyFo670R6eEDVUds6l3UMolFP1+vNhM83q6FS28ga
         xpbpT6hjydT0gfnI9eStRHwMniOmrvw/WeNFp5l9II6xponJ9J0d2A5HoSCJ25aRlDSH
         C+fLnI65+F+Xf3h30uyWJZErUlVegaBeSdTY4r67lzevytpfgBbg2/Ry/L3mLy0Nc84/
         ePfxphAEnnMv0TaHEDzlDAweuENCkZIXPFu5SgRNkRJElkc09QX/BsFn5SjirEIuXQn1
         SqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772512222; x=1773117022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yEqROSPbboZGgQozME32vz2BWITqwBYlmthyib6cgEg=;
        b=omoXv/bFS1PWbAnXLC7rVt0N63dM+pF/fjpC3zWdrxbr0TZaR2U9Z3sQe0lnaQFuHo
         Q+bEowrOgQt9i1KgUtolYhv2DcbLrBwf2SnGHCcabbqv98IKuB09GNPw29Bphgv1LH4l
         55bTqOVlefwxPRbxYlHdgotI8tO0wFvzGG8MR59McMkIzzE6Uau5tneGRZn7vSsvKb8I
         qCHqR/w/AMehydW/Tx45JRRYe+NmsCGN1Ura0esJKIthu3HK3OVKYxmqyZGIRtnUtpzm
         sAHcwIT4wZ5dC2L+AF67Y+KrnLiRFcLh6FKkbCRZM7oogEc/Phu/hJYBZqIA8Tr7bk96
         Yc/w==
X-Forwarded-Encrypted: i=1; AJvYcCUwa8e1/u0qy/FfSQdiyfgY5ElS5hp5e1UjT1y9RNGDQK/s959l7PlixCWlo3v6e8T39nful9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0fi/ABaBM6pPohjolQ5Sy0kOdokW+P9s0Xt3dSxpBARpAb1hB
	RMXPXY5r4pX7PwaoyHYs/9fWXNkwN0AunFxFWgLnnIFkrBpE/6zwT+9K6h2dloO8Tyr2yhxV5hL
	aJY4CVyRRn7+e+Ut3+muir20ce/dTDQtGX+knOtFx
X-Gm-Gg: ATEYQzwTsGIRv2NfM0yuypizLyBrEfewQy9j05Cz4KfDK/2XkNeMdVhTpSeJgdYNhoM
	eOdgJPmdNVNcHXgIvlqEM2quof53ph8OJr361gYF03XLCpz9Oq9Ftd7QhJq3thbn+32HKZuif0v
	7EiAg/vJzrtg6hXo3metFJAbKmwY7wDp2pxAHTy5vQhQVUpm6ADdjzzrY54pD1LBBRI2zHTgU7m
	yKcHRiPEgXhU5zZ/rpvB7iVfJkzu/ofrCrhg4t7vPmeUGh4wuB8i/9WUpgGgezlMO9RKqSdgsTU
	uG2BMQ==
X-Received: by 2002:ac8:5e08:0:b0:4ee:bac:e3aa with SMTP id
 d75a77b69052e-508ceb13c80mr9703921cf.35.1772512222136; Mon, 02 Mar 2026
 20:30:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303022947.3061602-2-bestswngs@gmail.com>
In-Reply-To: <20260303022947.3061602-2-bestswngs@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 3 Mar 2026 05:30:11 +0100
X-Gm-Features: AaiRm53nYAJfA1P793Y1baSnc6GUwRKrVIRmyB4xbB7j850BWmVMotehIBF-OBQ
Message-ID: <CANn89i+mK-CqGPeW65RBeOe2R-YjqjxU9W9AGbvV1Ef+HS4DtA@mail.gmail.com>
Subject: Re: [PATCH net] net/core: add xmit recursion limit to qdisc transmit path
To: bestswngs@gmail.com
Cc: security@kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xmei5@asu.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6C7FE1E8D86
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263033-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 3:37=E2=80=AFAM <bestswngs@gmail.com> wrote:
>
> From: Weiming Shi <bestswngs@gmail.com>
>
> __dev_queue_xmit() has two transmit code paths depending on whether the
> device has a qdisc attached:
>
>   1. Qdisc path (q->enqueue): calls __dev_xmit_skb()
>   2. No-qdisc path: calls dev_hard_start_xmit() directly
>
> Commit 745e20f1b626 ("net: add a recursion limit in xmit path") added
> recursion protection to the no-qdisc path via dev_xmit_recursion()
> check and dev_xmit_recursion_inc()/dec() tracking. However, the qdisc
> path performs no recursion depth checking at all.
>
> This allows unbounded recursion through qdisc-attached devices. For
> example, a bond interface in broadcast mode with gretap slaves whose
> remote endpoints route back through the bond creates an infinite
> transmit loop that exhausts the kernel stack:

Non lltx drivers would deadlock in HARD_TX_LOCK().

I would prefer we try to fix this issue at configuration time instead
of adding yet another expensive operations in the fast path.

Can you provide a test ?

Thanks.

