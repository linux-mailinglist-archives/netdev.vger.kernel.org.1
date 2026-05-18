Return-Path: <netdev+bounces-289079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE9AFHEYC2o5/wQAu9opvQ
	(envelope-from <netdev+bounces-289079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:47:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD95C56DF2D
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F21B301727C
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 13:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B943D3CF9;
	Mon, 18 May 2026 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="h1bR3dWi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E2B2745E
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112046; cv=pass; b=QRIvLdLg5MJ6v5NkysrnPQFq8gkczMToRZ+gatAALEUza16yvPUAWFG6tpmUoocuG9FjU1Ye4QbBr72FNydkzydxT7SNV2qRA8GfnyMtd5G4Q5QQY174C9zTxHXtAHuD+4hTTXIUbNdcxzGRcWMlz9icX07Xt0/t3hylGyIQ0+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112046; c=relaxed/simple;
	bh=AiBfizs3XqGgxWmZEFEssJiEOWWFoex2tZo1PsCQ90c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJ1lbq8TKY0V/axZe/ZEnEigvu7DU/cSkIBa3M/gBetXqo3hi4CUYjuN6aRqHQTB6q9Xn0Z21Wcri3IqIbWXhO4NMbgyrnFkvztlyrNIQZ5XeOSNPoFlnCr1fqAL+k0CNdTsOkMTk0SCvYBX/te7MdGWfME577Ew+0tlz7mgTyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=h1bR3dWi; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-83ec36a13e9so927575b3a.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 06:47:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779112044; cv=none;
        d=google.com; s=arc-20240605;
        b=ivGP7oLTUqRoLh8Za2HVno65fVmdTW6aBol2sT7BhCvx2fLQEOIWfZpCRQnm3l4fRv
         dTf12zPHkXGhtPIME7VjEFsOKdfrgl5B1/HtcNeF26bYejz2u4JQqjyg26fIfx5eq7xu
         t2jg7fiDb2FmVGJ4LdpIAwtNKuMwoxfES7022FD3Hu5U1S7PIbN++VyjPotAgAjVDKy9
         wohAS4ejMbVzXQt3LyJjvVJfmfs5Bq9BjTnJVESkBOtJ4hn+pk1OOzcV/vdhsaTYJ3nG
         4tcyuZsoraY2rJoxx6I0Qif00idrDmLE/VPZw1NkRM4swY7BGDDqUjD1DOqJ4wXtqomt
         oAZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AiBfizs3XqGgxWmZEFEssJiEOWWFoex2tZo1PsCQ90c=;
        fh=ecB1J+ACQLZAy3pw+CDnqR5q7+DaSVJ4htLuMCvXIcc=;
        b=brV5kBKGFD2zm07Ncj0+Lurn+qSVWsPWl9DoHe2qreX9jU/dKDxIu19sCByr3TPD6o
         1wjP6k/95fkOdCldip1oGaNkT12FRBg/Xr4dFyhH8P2JDEAzmMPdFZFatKBSC5hF2FTs
         eRWZsSEfuQgLiB1zW8EKe5MbrprCIKUriUhAxYR6bqNVRioT56lsUbbo/2gbuMXezKuD
         tFTkEspK+EPR+/KVGO5Vx25woy5yp050Uj6KlgNhIM4umH4EaIt6nPyDVe5R2DD+szwU
         QsbI1BFVLdWI1Q5NBGJp6JfGcuwUmsftuoSlPwt+9oV2/iwW0ioUyU5a3QpHvWrPtOH3
         LTPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779112044; x=1779716844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiBfizs3XqGgxWmZEFEssJiEOWWFoex2tZo1PsCQ90c=;
        b=h1bR3dWiAeo9opqZMvCxHho1+/0bCcH96Y6KsbYLXpfPeMOm02zeIPXmbybWPWHBsM
         zCtxD2wT78TX20y6vwGq6SKaHgYJ0mdlDqMaZsFnAY9IRTLrhIdI+EI8ro5eRNPK+/oP
         lp0aMQkHaLEeK36ij2EuvWYALPwcJItiGAFZU0pkkGLQchPLYwovrd8QmtsUHaJxs1li
         px0BssMhLp0RMfI3Jkv6koqC+jDpxP9QnZ68Xm66cI7rbeubj5P26hNFkxDILLW45GxH
         wCuoInU44ulIEJjkcomNa6PBaOr199OydkJKzI0ExmKIJ36r6u5UeeFQZu5CC+kFi0iK
         txaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779112044; x=1779716844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AiBfizs3XqGgxWmZEFEssJiEOWWFoex2tZo1PsCQ90c=;
        b=ESuUeo622EgXEoq0chMBVIaPUdj6cyThnGScBBlUuRzRfQSY++CNgcQQZRLKzb8ncw
         e3pUqRxWIKXOXckwjuGka63pUDAj225Q7iZqZ/khHL6pPKi0lUqVmGHHnc1J99tXmFJO
         M/MTRQ/K78xMGhOPQb/qorPIUXsZgUFyzg2Z1h9aUTtcKX+Sxzft2IHH9qFk4oXerddp
         27E8TU/z1JYAHCNkGPp2hQwzErCO07HmrotZjBA90sMwSpe9F9k0Sp9WyTrUoWJ82z1T
         g5nVj5bhd6RV8QCIp1llxHeLtLNTBHFEWdPboQOHeaGqhg6pRI+0WxcWdm+JnCkTtXx/
         cxqQ==
X-Gm-Message-State: AOJu0Yy5O6Nni6PZnt3xQ6ntONlGlWUib3GJstAshDMRECPHS11lxN1R
	0uyE/6cBElQnkZfOz1NGSloF33gpDe4pFw+/iAdwRA5RrHbT9OncpxcwOvE7ocVXj0AFxp2TCAj
	/yeoL21JsWV9shpCClVlqz9oYYo4jGAXOLPjm6kbk+wYpexvllB4obg==
X-Gm-Gg: Acq92OGhavivr3Y1bcmvH9QxmPn3d31vk2hKeXKOkxIh3exyiDf60/e8ZxZRB6a8UVA
	3jQiiKONA+MI2OjKWbLU8wBe4S7GaNzssE2eabtBI+jOCCqXU/6tdHO75bf3Hukraq0X0qDsamG
	iKBo6OHHu4WyPaT6iuW7MJFbIvVEhPyW6MasUOey3vXxNqACAAPq2wjFzgnWDsFTsyaxZkDgEBy
	plHHAFr0j7BvJcRZDjqJ16VFc5t6DIiHBOmqYENVqmACVIjWwZeLG7eb/mR05hE4KwpC/8m16mq
	dbBFHZH3v5OY0gED2Uw=
X-Received: by 2002:a05:6a00:9502:b0:83a:78ac:edb7 with SMTP id
 d2e1a72fcca58-83f33ab95ddmr15092029b3a.5.1779112044199; Mon, 18 May 2026
 06:47:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514144747.527175-1-jhs@mojatatu.com> <CAM0EoMkthnGFtsmJgj5ibwuFjKg5s8dGOAkJSXUtH4FytG=qtg@mail.gmail.com>
 <3131c62f-b5c2-4f8e-b2a3-ebb844f800ff@redhat.com>
In-Reply-To: <3131c62f-b5c2-4f8e-b2a3-ebb844f800ff@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 18 May 2026 09:47:12 -0400
X-Gm-Features: AVHnY4LhkZoATVbpS1JQiNqB7Tf9yGEuOwTB_DMnfBy38hJ2OOGQHSvysQbBf-M
Message-ID: <CAM0EoMkiFap7hARrC9eca4FNdpgXndT9767WpO+2Q2HehWusKQ@mail.gmail.com>
Subject: Re: [PATCH net v5 0/9] net/sched: Fix packet loops in mirred and netem
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, horms@kernel.org, jiri@resnulli.us, 
	stephen@networkplumber.org, victor@mojatatu.com, savy@syst3mfailure.io, 
	will@willsroot.io, xmei5@asu.edu, pctammela@mojatatu.com, kuniyu@google.com, 
	toke@toke.dk, willemdebruijnkernel@gmail.com, hxzene@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-289079-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,resnulli.us,networkplumber.org,mojatatu.com,syst3mfailure.io,willsroot.io,asu.edu,toke.dk,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mojatatu-com.20251104.gappssmtp.com:dkim,mojatatu.com:email]
X-Rspamd-Queue-Id: BD95C56DF2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 4:14=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 5/15/26 10:26 PM, Jamal Hadi Salim wrote:
> > On Thu, May 14, 2026 at 10:48=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> >>
> >> This patchset adds a 2-bit per-skb tc_depth counter that travels with
> >> the packet. The existing per-CPU mirred nest tracking loses state
> >> when a packet is deferred through the backlog or moves between CPUs
> >> via XPS/RPS. A per-skb field covers both cases.
> >>
> >> Patch 1 adds the tc_depth field in a padding hole in sk_buff.
> >> Patches 2-3 revert the check_netem_in_tree() fix and its tests,
> >> which broke legitimate multi-netem configurations.
> >> Patch 4 uses tc_depth to stop netem duplicate recursion.
> >> Patch 5 uses tc_depth to catch mirred ingress redirect loops.
> >> Patch 6 fixes the infinite loop in the mirred egress blockcast case.
> >> Patch 7 fixes an skb leak in early return error scenarios in tcf_mirre=
d_act
> >> for redirect (caught by Sashiko [1]).
> >> Patches 8-9 add mirred and netem test cases.
> >>
> >> Changes in v5:
> >> - Fix issues in patches 6 and 7 found by Sashiko
> >> - Set limit (1000) in root qdisc in test 8c17 to avoid flakiness (Paol=
o)
> >>
> >
> > Sashiko has found some issues - we'll be sending a v6.
>
> I'm likely too late here and I haven't looked into the details for this
> series, but please be aware that sashiko(gemini) has a tendency to point
> out pre-existing issues in surrounding code, sometimes hiding quite well
> the fact that the issue is pre-existing. The general guidance for such
> cases is to address the issue(s) separately with follow-ups.
>

It's asking for something not very complex - so we'll just add it and
send for this time. Next time we'll look into doing followup patches.

cheers,
jamal
> /P
>

