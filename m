Return-Path: <netdev+bounces-260336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIdKCMIwnWkDNQQAu9opvQ
	(envelope-from <netdev+bounces-260336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 06:01:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1F5181C7B
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 06:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4B82302837B
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 05:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF514258CD0;
	Tue, 24 Feb 2026 05:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNWy1yEr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A461A1607A4
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 05:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771909306; cv=pass; b=DrLpIR8h94Ll4UG7Ry+6p4Mm3JaPnS8144sZWDR11sOUqiJk+KiHMljip/M2FIdVnaWl10DlH9JQ+uspGy5p7XkW1G3Kx/TdX2TRs7EKpYG9qZ0b0yHtEr47G67JszB8hReCwVFDXEOgR/YWGqlNwvEgDjBC/x7sxl3lK6GkClY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771909306; c=relaxed/simple;
	bh=L2ttXJfkcoeJVcdKWVAE/l3LxodapvzxfEs8Na/1mgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dit0jZ27hv6avip8GMxPEZOG2+p3zXF5BIkP8rRfR652jAUR5t3xg0annNwebaKxZg4iQc4mxkZsEmyZfy1kQm3TKWUskrMw//VwhjnriCQ+A847WS00o0RTmE0WFJ4vrOuqXN0SSzipRKcMD6NXJc30TYSDuRDTsuurC/K9lj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNWy1yEr; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7927261a3acso45367457b3.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 21:01:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771909304; cv=none;
        d=google.com; s=arc-20240605;
        b=FtvccnAmz8KSm3qFUSsoeIQVwPXag/P75Hli+ANb3jDio9viSYNRFzSvHBwbe91Blt
         ZB9CtHPXgG8C/BGLhMZ69W8xeeFLyxPZi1Rw8LCMwO3lEbI2WG97TKvB04L4M0GVnsjT
         jw1XBKeFNu5hW5uIWIQqsvRV9DiAuO+T7wbiEREG2YM2C9IWpQF74NQIF2npE8cw/VmP
         O5lb7J9AJnrVBzaIL4qJMlHG48gKF8LxWWhZGswoCFEXI6qhOw24T42GJpq6CyN9sIVu
         eQDRxueFN9ostDXHu03X9KzoJaE49Z8l175jVaE3RePmXW4CUxBWrnnr7itYIBcJETG6
         mjPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L2ttXJfkcoeJVcdKWVAE/l3LxodapvzxfEs8Na/1mgY=;
        fh=m1cvyIfXc/nmZG5l3no9tK7TRZklTtsHXiiuwTOmj4E=;
        b=Tu0f99W9ceaoL27alK1Xqrb5yBq0aqU7KTed/yoLxjmr0n1vJMBI1iwu6yo2kjJtK0
         ULnzvAstMr1bljoKDSlcnAVt6+46wRoajKLX9IdelppqryAEAZUBSo6zWDZKQUpTtORa
         FLWGSLgR5wVOku4/JHdyEYr4GUIyQNA8xhO45jX29OTZ7VHqwfFaEikrCiQ3VKhkiImq
         izfy093WGnCwLT3X3VHsRhDpMbBbJXOrSnnwcVxQVI3YmlbLlhRu9N3QA7sqZv8B1Cua
         5q8CtoVMUOVA+tNJ+s0z9cmOnZWg2/zACBARzstBBGaxqkjXa2Xrw81gg+vx1hF/dBXr
         Bueg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771909304; x=1772514104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2ttXJfkcoeJVcdKWVAE/l3LxodapvzxfEs8Na/1mgY=;
        b=QNWy1yErdUA6CTe+ZzPMdutofAqGRETpseLswi8T9sPolZchDWpOj6oikaAEWTAgyg
         biWpPHvTkkKWdBLAIu8cSBAp4qNaEAgLRqWJNVQpKv+dJsVObNW2qyqRAujh8kvGa8Gj
         plwzDVia9jXR9MyTrLaRhtgTgSwVf04N30eLYrSTxjMlbLOCZtEQ9OCQM2WqAG2iXgCP
         opUF+RP6v/wYk7qWQepNi7AegitkncpPfa04jNpBzxKNtHxLvEk4sV7xqn+Eyu0yFMqe
         qYE5XCXPSdSMLnMx6JfFETBxkrrnCF2NG969PWoRDFGedJ8vKzdJv0MZvycBQd7K44Pq
         jjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771909304; x=1772514104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L2ttXJfkcoeJVcdKWVAE/l3LxodapvzxfEs8Na/1mgY=;
        b=MB8lEzU4Xr6kQsR2ngxvXeAj3RaUDxP+lmy44IhDeepSaK6fEWcywudAXnHLqE74k3
         1gVYpGj4HUVNUUiO2Qbn17yBNZdFBv2Y91WVJ6vmWoyB2itsZjbVB6ultYU8LDLUu9yJ
         IKDv51VAQTlhq4KAmRbwwQWO6hsz1DGXFJ3YGfnFI0P4DKwJN7PFqPrQPvAh8QmSxkVo
         mdC0SSQcN5/QumNoLPYcihvRdMmyBvBc6kTbXREMgqLx8uR+T5MDCdf3+tKjzgL4Gts7
         QwL3zD/lCUPaOGkZBvevqVxzaSB07WVN3bSsGVQjdgnLn6gyJ56M4/gcs3tiZKg1Ho6g
         P7XQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2i53w+Od2PSyU05Dc8K9pkwKfc9EQvVlcaeKQWwr5UWfCvj3hcgURHJxPlYiAlgHw4iAJbAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqaelZRU6xg6P7WLQR0XknLWfQLCv4gfKSZNc7ContaJX3kwxb
	VdrQeYL5WrrOpjNQ43cxrug6khIR7haBAxup3UFxY+gQBNSLjPlBey7ESfFTkM1bUE/YCiXnBvW
	Olwu5XqV1YEQoWj8DpatFLsHBH4VRNek=
X-Gm-Gg: ATEYQzyDWo/1+Bwu6okn04dD7sKRIY8ctEJkDKi36UhQByLE8PkDjO1pq/HGw0K7W19
	3NAVpk9tFsaMraFL2mwAswM72dAsMPlBJFxQFghgx75P0/O8jLyf11YC4ieHcSbwh5AMSuhNpaz
	0KMNi5XnDiO7AnFqyt6kGZMLfEgFUpLOQNcizx8p8jXLz839kzGs8YBXbXM79bUOClSk6n9pqPv
	qd+MRo6dPDohW5VDcR8Sbm6ZI0sm8wT0rg30a2etsLzgIpNAhsXt7uhG27nNeQQ3nLERVz6UoU3
	TKzIQcyH8JxUios=
X-Received: by 2002:a05:690c:e081:b0:794:fffa:a4a3 with SMTP id
 00721157ae682-79828fe3e97mr99881817b3.32.1771909304693; Mon, 23 Feb 2026
 21:01:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260222111847.692325-1-sun.jian.kdev@gmail.com>
 <20260223172214.5d8ddaa1@kernel.org> <CABFUUZEuMCYYfi-SapTLT1BhYOWBk1e-OYh+h9fOZcfoSP06fg@mail.gmail.com>
 <20260223185321.0f0581e6@kernel.org>
In-Reply-To: <20260223185321.0f0581e6@kernel.org>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 24 Feb 2026 13:01:32 +0800
X-Gm-Features: AaiRm50G16KCDeABgvXX9N06coP-jcWkxjZu1pw8PVHh9TwTz85YTT7Ed9y1XyQ
Message-ID: <CABFUUZHb2R_SiiE_K-ixhjPVkvG4WWTjcOygAM-YBGtZ6Cnq_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests/harness: fix XFAIL_ADD matching when test
 metadata is not initialized
To: Jakub Kicinski <kuba@kernel.org>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, edumazet@google.com, horms@kernel.org, kees@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260336-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7A1F5181C7B
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 10:53=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 24 Feb 2026 10:43:15 +0800 sun jian wrote:
> > > Constructors seem to have a concept of priority so if we have to,
> > > we should probably used those for the fix.
> >
> > I considered constructor priorities, but I'd prefer to avoid relying on
> > toolchain/linker specific init ordering here.
>
> I thought constructor priorities were specifically created to avoid the
> problem you are seeing. What it is the point of constructor priorities
> if not to order constructors??
You're right that ctor priorities exist to order constructors.

With clang+lld (LLVM=3D1) I can reproduce xfail nodes being attached to
variant->xfails but with xfail->test =3D=3D NULL, so the pointer wasn't
available at XFAIL_ADD() registration time.

I don't object to ctor priorities per se. My concern is that fixing this
via priorities likely requires ordering the entire registration chain, not
just XFAIL_ADD(): kselftest_harness.h has multiple constructor-based
registration sites (I see at least 5 macro-generated ctor blocks plus the
constructor-order helper), so we'd need to thread and maintain explicit
priorities across the relevant registration macros to guarantee that the
test/fixture/variant metadata is fully registered before XFAIL_ADD() runs.

To avoid relying on init order, I'm happy to send a v2 which doesn't add ne=
w
state and doesn't rely on ctor ordering: keep xfail->test as a cached point=
er,
but resolve it lazily at runtime on first use by looking up the test metada=
ta
by name within the fixture's test list, then use the original pointer match
thereafter. This resolution happens at most once per xfail entry and keeps =
the
hot path pointer-based.

If you prefer ctor priorities, I'm also happy to respin that way =E2=80=94 =
but I'd
appreciate guidance on which ctor(s)/registration macros you want ordered
against XFAIL_ADD() so we can keep the change minimal.

Thanks,
sun jian

