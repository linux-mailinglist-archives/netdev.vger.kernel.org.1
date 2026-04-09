Return-Path: <netdev+bounces-277164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DEoDQgr2GnIZAgAu9opvQ
	(envelope-from <netdev+bounces-277164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 00:41:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6883D055A
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 00:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC4683014C04
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 22:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83624395273;
	Thu,  9 Apr 2026 22:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="htUMGIBs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EF239525E
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 22:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775774189; cv=pass; b=ILU4948kMPjkK0OaiH+SY7CdI8k5WxPjULqM0ydp+oARfR5AsUX7RVZJa2tv2zZiEYqouOZDKcudC9tuJn7EEcpBa4bf4Jt078smJlEr1xgAMSul92OhHGJqTLxIQe0wL3dcBWbYmfsPa9x7FcuDNSGrkh4VE0Aw/vQzu3FJqLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775774189; c=relaxed/simple;
	bh=6NF9qUHWoX8c5iTn1fP1XAU18pMiHwpiI3ney0IRLJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJrbgGVxRJoc/CZ0PHqLtEcQ6GIUeF4u/JQQ9VLr+HCEAh1DDI707TLbMh7P/f4+vXJnk3HedAp3Vh2Qx8Ct+q1c8zCwTZQhdLSri5tNCh3DxdVntf6+OQU6uoJIO8YWRB6hpkInjEjpActfm455YCY+icuq61bgYJHNtIDfo7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=htUMGIBs; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7a2b6adbfa6so15334187b3.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 15:36:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775774187; cv=none;
        d=google.com; s=arc-20240605;
        b=Ub5ERqtAE8V/EFq4UYTAU08iomiSECAZbXEN2OW2DC89d10eStCNxxEg1l42QkfRJN
         A6aOeFGipwipwv/Sb8/qpjEoqNtc3w/CtHupELrYP30DCltF8kv+d2uuhwk2kMxSrjb9
         eVJGmyAToHhd7XcdQdQzPySDevnRmLGNylYTUfJ8xbySmlPmNXYjTLe+mVIY9VWlf/2i
         LwR8pIkGv7IG6qZZsDmdanw1sb72GxC1NWMIE7j4QnZmHkWoYTpBnm5r1sWLhLK9o6gS
         UE2cGuGz9JXXbHTgL6K2ub+vx2Ny++I1jbk3HFiBs85ppJkABdrlZf+LovlAb1+snVUd
         gxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0zJo9ruiyA89gxojsKY5mJ/fYqCxgS4MIEe9tTJdKnk=;
        fh=ksB/biwoyM2AHeLX2zAYAcqwX+Da935sruhwRgNQ2LY=;
        b=RwLm48Dqrvvv3BpIdUo031AuVdFyVypR5fdVCAaxwetyYOfZOzXrYBqC5isB7XYS3w
         BL2s5Afk+yOAL2A9NFQ0nVvPY1xyRHfnZFFcsPVhZIDeufXxZhRvMzvXp7D9G5zhv4f9
         mRO2PGFEOnydZaklIQ++4GSrjRrQ86OXlJ66tdX5+0RQREQOu/T8waZFXw218eHzxEPO
         32JCPBGIFu4J4rylTO1A+0oHoTiD1B1mg1XjHX2Iqbg+gzmjfvUHaThnQf7iOAPsuVvF
         qDBzoXTv06jc6ty+GQZSsBrMrRddEjjf10LMJuah/pEN9Xo3mct8HrL9PL2m2aNnmf2k
         pkQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775774187; x=1776378987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zJo9ruiyA89gxojsKY5mJ/fYqCxgS4MIEe9tTJdKnk=;
        b=htUMGIBs93MLw9dTl6z7Y4zoZEl8ED2ObstL/6yx4HTAUkzi7UpN0YXNGlGde7lG/U
         EZlNRu/M9KAPqJixydH/Jexc5AIHg1s1gV0m/ZvEmsb/PUXGgUua0oqH5kL5mpIHKpTF
         JumN3ACLN7hTGfF4491i6Sk1QxDzo/MU6qCrMv8WasS9bL6x0+2hOVtSPGvrHF6SENjP
         NMh52khOv6xxyTG11pW1S1Ic+fq0idCgW9917NPN817XqRcORCtUf7iP5HVlGSkA6bi3
         lGkTdWjKRhJywhG9BvDO0+DELJRMWFr0iI+C97YiFEhenCwOAlIm9jopdieGVIPciq4s
         jExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775774187; x=1776378987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0zJo9ruiyA89gxojsKY5mJ/fYqCxgS4MIEe9tTJdKnk=;
        b=DDOXDUhwgcJkrzKJqAexvgMFgFCShLAgbAyZ3maxao/1vezElZJfE0Z2PfIHC2QMGX
         UC74sJVPEsMDeYuN9sa94zIDAIpBZPA9I1i5hVwW5qnKUut4ap9Q3N7DSPnEn13w7k7E
         dDcFfHYTJaBna/8XRmmUXmBloc+lbxYsaoeW8XHDnZQxYbW+/xDELf1HL6/Y/gtBa384
         q0/0QY3jFVohzwhtsYMiVkXx7GSg0eHTFnTpkskzwlBrdr/fVVHaxISiqTdKGn27S3b4
         go6aYoEXZd7WsZkiTrSRPYdG8HvERjnHiqMkVvarQZdCkXDcUjfQZqfg/sgppzaRKE6C
         0nfg==
X-Forwarded-Encrypted: i=1; AJvYcCVOptyWtiqs6SR4KC1C6qC1wUeHlE0o2lwwr/ZqmaQ5gnaycBqIfa/uYY7MDZ7SSUmLSJsaJZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoikjQBi7ZftHTAB2t4gM/I3QRDGJP+8MDsW+L0oKo1aK2zqmU
	eIiP3wOB9F6WNR+1bkDO8WYK+QYnUzZBuXFmPFiby8KCk7Pih7YvEjo5MSlHfgbKe6DzPLOtzEk
	P/IL5rXQI5n9LgJOe0hoQ3P4GRmr1Muge5aFN9NQ+
X-Gm-Gg: AeBDietSPPRbAExX6wE6t4O0acleuDZn29dtjZFtS4MfDaZDoY0XUDWDTWbqcGBTbOx
	76vVOegJ7qC3FGkEjNThsQT2r/9GV5Q9vrGDEGxh2zsCAJy3tgzRYxC1Xk/Ceu3hFXIxfxdjjT7
	Sbl9mA04Owm/F3Hs6+BYNCzjaGctw+PWrRCBHh7iNXHwZxdJLNZEOpDxNkoBQ0chu+RiRqzLyFs
	pVFQECo9l7TFKWPHhulJPQV85gM8jsiU+CTKxJ6wDNrL8Fh3ekLBpoKBBfgKXCMObrVTQWYxRYf
	2Cd0s82byz5qltPMfg==
X-Received: by 2002:a05:690c:e651:b0:798:6f0b:86b4 with SMTP id
 00721157ae682-7af71282bd6mr6430907b3.25.1775774186532; Thu, 09 Apr 2026
 15:36:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409221532.69090-1-krisman@suse.de>
In-Reply-To: <20260409221532.69090-1-krisman@suse.de>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 9 Apr 2026 15:36:15 -0700
X-Gm-Features: AQROBzAT3PQFf6C26sinAG1EjRodcD85MGUAwIDp1lQ2qIllAgAW5RbjOLrVSZY
Message-ID: <CANn89iKQhLOdtn-_viyDN8ytjJtR-4p0gteXL6gGSHoUYZp5Hw@mail.gmail.com>
Subject: Re: [PATCH] udp: Force compute_score to always inline
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com, horms@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277164-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,vmlinux.new:url]
X-Rspamd-Queue-Id: 8B6883D055A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 3:16=E2=80=AFPM Gabriel Krisman Bertazi <krisman@sus=
e.de> wrote:
>
> Back in 2024 I reported a 7-12% regression on an iperf3 UDP loopback
> thoughput test that we traced to the extra overhead of calling
> compute_score on two places, introduced by commit f0ea27e7bfe1 ("udp:
> re-score reuseport groups when connected sockets are present").  At the
> time, I pointed out the overhead was caused by the multiple calls,
> associated with cpu-specific mitigations, and merged commit
> 50aee97d1511 ("udp: Avoid call to compute_score on multiple sites") to
> jump back explicitly, to force the rescore call in a single place.
>
> Recently though, we got another regression report against a newer distro
> version, which a team colleague traced back to the same root-cause.
> Turns out that once we updated to gcc-13, the compiler got smart enough
> to unroll the loop, undoing my previous mitigation.  Let's bite the
> bullet and __always_inline compute_score on both ipv4 and ipv6 to
> prevent gcc from de-optimizing it again in the future.  These functions
> are only called in two places each, udpX_lib_lookup1 and
> udpX_lib_lookup2, so the extra size shouldn't be a problem and it is hot
> enough to be very visible in profilings.  In fact, with gcc13, forcing
> the inline will prevent gcc from unrolling the fix from commit
> 50aee97d1511, so we don't end up increasing udpX_lib_lookup2 at all.
>
> I haven't recollected the results myself, as I don't have access to the
> machine at the moment.  But the same colleague reported 4.67%
> inprovement with this patch in the loopback benchmark, solving the
> regression report within noise margins.

You could include scripts/bloat-o-meter results, so that we can sense
the cost of such a change.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/2 grow/shrink: 6/1 up/down: 622/-410 (212)
Function                                     old     new   delta
__udp6_lib_lookup                            797    1007    +210
__udp4_lib_lookup                            838     984    +146
udp6_lib_lookup2                             404     536    +132
udp4_lib_lookup2                             396     498    +102
udpv6_rcv                                   3018    3034     +16
udp_init_sock                                244     260     +16
bpf_iter_udp_batch                           953     937     -16
__pfx_compute_score                           32       -     -32
compute_score                                362       -    -362
Total: Before=3D30269687, After=3D30269899, chg +0.00%

No change for clang.

Reviewed-by: Eric Dumazet <edumazet@google.com>

