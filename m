Return-Path: <netdev+bounces-289185-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Bm2G7iLC2p1IwUAu9opvQ
	(envelope-from <netdev+bounces-289185-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 23:59:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C241B5742CD
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 23:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 005383040D9A
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 21:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3718D39A7E1;
	Mon, 18 May 2026 21:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="RycZE0jy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7DE37CD4F
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779141138; cv=pass; b=GixuoOFaB608b7I/49P4qRH78w0GQp+JQrJXVvfn5eMQSO/UrAZ8m/1nNWZpl0xaLs6DGkomVX9H0+udH6cUkH/5Htm4SsCtIyd9LYpu1JWxya5QO37WKKoAtjTpDzYUhmNAR2gfT2nbgzpkZ8jue11L+RFSfDZjydSaWMYi2UA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779141138; c=relaxed/simple;
	bh=wzYNpsuSJQmOr8UWHB7d8e38qoMl71WGD4cU2BeSqxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXPtMAkKSWd6R4pMRJAUdn9ykjMVOr+0nzV6rEENysfjIU+Dhy2Hv1BVJp3L8GSAovJU5uubO9RLUac45MSPWEaCrWVoQ6BzjZ0yo4rhwY9d7b6D1xG4CNH51XIdiyaN9DyhlvP72J4it9djXvkPRB17YZAyTjQVCagTi/HJygE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=RycZE0jy; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-83538fbd0b2so1093268b3a.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 14:52:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779141136; cv=none;
        d=google.com; s=arc-20240605;
        b=kA+mLvl3aufFB1g3FRZ0KzD58IiM9WGC382XQGgo/ijXYJ9fP0oJQIrMxhsya4tlyw
         eCHGy+oAP/Loo2zJUo0iqbENcbajZBMmuN8UiQOPuo9hqBXlwt4/lDxhBl6qqAWNx1iz
         FY2srTugmOxOWYR22QPx4KlyKI5S/mesN9kJiYogo4U9Tpx7ZmOuGFH9YGD88vKTdnCw
         UTLhETtK1OFLWi3rS1Xb/GyjBf9MBArp8guQogw5/teq/XR7XZzzGjZ/1OrlVmLezxEi
         jxM7O6YEPO49OskTO6uup+3eNxrD3aYSXuNaS4hVmb9//NsDId0xpAaaGhi1xDwxXmLs
         UWdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5Mh+/rSs4Uwa0gCEh8gW3uU8389fFhJAZ+ROF0d8ftA=;
        fh=ecB1J+ACQLZAy3pw+CDnqR5q7+DaSVJ4htLuMCvXIcc=;
        b=hhNiHzb0e1fd+jEWu6NQ6DQ53W+B4sKKEn7iThuRGXGnoGFVo/P73cHJ4ihybJ9fxl
         w+2/O//bb+JmEofL76xQxZvyny8UYwLY3jEUGVHJGC2m7Ah7wBJOVnfT560f+wvif/sq
         rFDWb+w5wjtN9FxQs4RqNM3hiptNajsBuhDQ5Wzc1V0AT9tJgV1y7EIyEv6r98HhpT5Q
         EAidJ3x1W443ChfEy5FKK+fcATFdbx9YVKDPXpa6yXxj88qjV3taTcSdLdrtKGGSPfWo
         FHlJZypXEEIjyHxhImLP+UFoh6xGe2ve1uuQN0QjFaZNCFDCr7MRWzFH01mRmr4LjSUb
         rooQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779141136; x=1779745936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Mh+/rSs4Uwa0gCEh8gW3uU8389fFhJAZ+ROF0d8ftA=;
        b=RycZE0jy0GB9eQc7hctjGF5x/JnxGDfOggeYScwg30aEVM3LCs0xAzTe3yfoSD54TM
         DKjQCus/+RcyTiCbIYITwNYj0E5PjTnmuJsYu9pZN2CE6VNOSWb94/pVTAFfm5lIQqbQ
         4t4MQNkhX/Rr2I7lxFka0mE8TN8+LIUImQ9MmgMH/PxOkkVO2vSo1LLFHlRj9VLTvPOk
         lKrWVJ39ixbJzOlNdZY11ybli6O4IzRT5thVmPXzGeLupccDH647nALDKvlP6C8vyY9b
         7r4FSxJHqMf3HYbvflFxLHrRGtw5rHVpJVuMn/6jjUfYjGDLaF6bHkrvULJ2kizn43Bt
         qXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779141136; x=1779745936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Mh+/rSs4Uwa0gCEh8gW3uU8389fFhJAZ+ROF0d8ftA=;
        b=k2/LqKFtHiBe6a9a50QAIYwyiX9KHkYc7RwANrsMQsptUZa32GCpr5m8EEr/tQolfA
         h7ikPblWsGH6mv/kQIfEz0gNyBg2aeskeUyNMZy3Anmb3l6iffEkklhQG+hfn8NFOBaL
         h4vA5nEaOQRW6IEICppzFZlErdkL7ovzjLvNpcQ2xvZa4KzmvruPnn+pZwLkrB9GaLlQ
         TZzmzvGExW3omXv12YjqMZMcHcAVcfs7/pUtn8MtDM45wF4ziQRC4TwcLaSWfwhftzW0
         W96koeN84x2ZhFXuY3AGUtBtAhyBe34DsF0ucue1jn+vjrxB2ZGp36b25y97nABtiPVi
         h6yg==
X-Gm-Message-State: AOJu0YyBFCsMkeCrkIYdeH1GPToiCwA0LxI0/r2CDHLazaO64WJaKHu8
	n9LYoISMVLfA0jpI1jS1Llf2aOXCAZ4ZkSaF9G8h3LqsLE0iJJ01UwN85xZUsVwJSfPr2z0VvXy
	WhwdJk+WquR1QpSrnYkKZ+bMD7wYMyKfSqYHa9TOG
X-Gm-Gg: Acq92OGCVOpjCSEI38ZFtKYC1EGNvIRVDQVhzIrvBWIqj8nqR8+UJY818GwGairUpcZ
	ZxWC1L4KkuPWhL7HWhir0dxLvIVc1NWo5/735vN5h7LlKO5cARvUXoMeyGMTA/dxl1Z/KpQhSAg
	gKrlfpl1P7EazMM09z94xNW01kq7MhrN4m5XHLEn9Zs3mx5uveK4z9/CsEjvimPG7f4wn2aEQ0O
	5P679WzLoArAopEU5mhnx0HG+OUnvxjIjDAvfmZ5m0y+xb2XoUARmCDs2lEo45HTC4nC+eoSIRn
	AIuw72TT1vQbXvm9JSI=
X-Received: by 2002:a05:6a00:3d08:b0:81e:b2ba:5b3a with SMTP id
 d2e1a72fcca58-83f33bc7c26mr17251232b3a.8.1779141135976; Mon, 18 May 2026
 14:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514144747.527175-1-jhs@mojatatu.com> <CAM0EoMkthnGFtsmJgj5ibwuFjKg5s8dGOAkJSXUtH4FytG=qtg@mail.gmail.com>
 <3131c62f-b5c2-4f8e-b2a3-ebb844f800ff@redhat.com> <CAM0EoMkiFap7hARrC9eca4FNdpgXndT9767WpO+2Q2HehWusKQ@mail.gmail.com>
In-Reply-To: <CAM0EoMkiFap7hARrC9eca4FNdpgXndT9767WpO+2Q2HehWusKQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 18 May 2026 17:52:05 -0400
X-Gm-Features: AVHnY4KMQnBe6JADxPUdHBJUTzxxofDu285GxHRWiMQhHF0q9HyY-_yzJvt1Pvs
Message-ID: <CAM0EoMkTTXEwddn9Kbp+KsX7eoy-Lhhv=8k_Nc+T0o6_tGVckw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
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
	TAGGED_FROM(0.00)[bounces-289185-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,resnulli.us,networkplumber.org,mojatatu.com,syst3mfailure.io,willsroot.io,asu.edu,toke.dk,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C241B5742CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 9:47=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Mon, May 18, 2026 at 4:14=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On 5/15/26 10:26 PM, Jamal Hadi Salim wrote:
> > > On Thu, May 14, 2026 at 10:48=E2=80=AFAM Jamal Hadi Salim <jhs@mojata=
tu.com> wrote:
> > >>
> > >> This patchset adds a 2-bit per-skb tc_depth counter that travels wit=
h
> > >> the packet. The existing per-CPU mirred nest tracking loses state
> > >> when a packet is deferred through the backlog or moves between CPUs
> > >> via XPS/RPS. A per-skb field covers both cases.
> > >>
> > >> Patch 1 adds the tc_depth field in a padding hole in sk_buff.
> > >> Patches 2-3 revert the check_netem_in_tree() fix and its tests,
> > >> which broke legitimate multi-netem configurations.
> > >> Patch 4 uses tc_depth to stop netem duplicate recursion.
> > >> Patch 5 uses tc_depth to catch mirred ingress redirect loops.
> > >> Patch 6 fixes the infinite loop in the mirred egress blockcast case.
> > >> Patch 7 fixes an skb leak in early return error scenarios in tcf_mir=
red_act
> > >> for redirect (caught by Sashiko [1]).
> > >> Patches 8-9 add mirred and netem test cases.
> > >>
> > >> Changes in v5:
> > >> - Fix issues in patches 6 and 7 found by Sashiko
> > >> - Set limit (1000) in root qdisc in test 8c17 to avoid flakiness (Pa=
olo)
> > >>
> > >
> > > Sashiko has found some issues - we'll be sending a v6.
> >
> > I'm likely too late here and I haven't looked into the details for this
> > series, but please be aware that sashiko(gemini) has a tendency to poin=
t
> > out pre-existing issues in surrounding code, sometimes hiding quite wel=
l
> > the fact that the issue is pre-existing. The general guidance for such
> > cases is to address the issue(s) separately with follow-ups.
> >
>
> It's asking for something not very complex - so we'll just add it and
> send for this time. Next time we'll look into doing followup patches.
>

Ok, unfortunately a2f6ed7b4873 is conflicting in net-next  and the
testing branches. I can send it if it won't mess things up.

cheers,
jamal

> cheers,
> jamal
> > /P
> >

