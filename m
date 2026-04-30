Return-Path: <netdev+bounces-282909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBMcE7R382mt4AEAu9opvQ
	(envelope-from <netdev+bounces-282909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:39:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E97934A4F1F
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C19A3014B89
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6593D3148D0;
	Thu, 30 Apr 2026 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jj1aD3nj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3C031E830
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563426; cv=pass; b=F7avLTr5qOBwdCvj5iJsGPompAz/WN9FS6FW3uAWgy8k1ezFQy1xeXxXVtSoEXG+en/HtI8UVGCj5kAcOdGG/53gSSK/nisjfzuxCIvQ5U7qzsVlCMdtCazW0NEEZIJPCYiHXW4ZEqdzPticlKsH9buTpzyx8ngVnmrlUjQagP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563426; c=relaxed/simple;
	bh=510+nnx3c418bRyfMTOsuP/0znWHRwewHOZyQyizsQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bIN6hQd6twoHaG4pQscYgAJemZWcHZc2ekTzLWbv7ITOPGdPRID81Bf0a2qTAecADbTgJQ0hG6x1ZhLYHT+sSl3AbxF0DGVjje/FmLb3cMsx9ODmbdTyZvQwnscD+M0Kw8WFWgBJr7alpX+l7lg12OGrHzhUsV9neYslCAlEZnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jj1aD3nj; arc=pass smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-94e578a0fa5so640943241.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:37:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777563424; cv=none;
        d=google.com; s=arc-20240605;
        b=fzTDCTRWJ1HhlIICObXwb+fY9Q7+bC377fqr2CoaJFIc9QTk613VV2ePX6i8/vyPtE
         1Sswo5W3Qvn2wEHjPSUiksqis6uzwRQrZ7HmWNIN7r6cwz5tIsFPI8Tcso5bCzudrCTL
         6ST5xA8ItaJ8DUIN8G9sEd3rgABwJxO+o5dsHoraY0C42BWs4OPyi09aA8/ix4HD3p4k
         CphKmB6w1EcKu38fMdDZr2GwuuVdY2UIuKpJmZaWJItOrCi+85+/akIObX9RW2uP9wfE
         3QqBF65PiF583zZgZI3HVc/OJClE8mYwBDhVsCVaeyYMN1sUZFW8nqHJmO+/R8QW/S1z
         +5uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x1RKOP4VP3d7J5yz+d/pjS5o/pOR8N4/xyq7WLkcEKo=;
        fh=MnVumcB2DZGFZ03rgeYtUN5lMq/ZbY+AFBtx841kNgc=;
        b=bJ7LNdft8nGOJJZRn2DJ+TkJR7f0I/ONA5PctBN7JApXXENnDQuSsgDTOnKMz/zQFH
         zEFA+H6K00cnh0rEnSBiPUqIYSyqV9VTI02pzVPpfYemqSth4HDQpbxLLzhhkckNctBf
         PIm1qGlJvx2Yump7x5sb+iSd1KpiccxMLMGArUeEs5czZ+PF5Arru5KhtPv3NpQU1Dly
         Ab1GHzYn6fEpfA0nZa6pIhl8SC9cS/Lmj3JW/jLeQdlEsQPcJkoSJyeQeqvhH87lz3h8
         XU+/+cBoFWV/HblaM5pHg0uzSW05KWnqpTVFdoM9aSE3WGdadj3MoVoZKnRTswYyKwZN
         yG4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777563424; x=1778168224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1RKOP4VP3d7J5yz+d/pjS5o/pOR8N4/xyq7WLkcEKo=;
        b=Jj1aD3njS5r/rIAgNzHBidUPMHQDMa/8NP0TE/Ds33yHuTEMC3qV5dxrH71Ircpo2/
         +AfxIpzb16xtzE/AxSF78EEKNq/CnULAIGAPZWuJlFc4wXTDkg3GZEjcTMEmL7q0sxnU
         0HGCuLbIGj0Nmi8NRdx1KhaA7+aHXuPsFx8OqXQNXAQCB+Vae5U/4cG0YUJgaElCif9S
         Y6S2k7w7TWADTkkRn1HDUdXAz9eXLSa9PaW1ahKGLHrdGGOQ5su6ZD66ufg1UYRAstxc
         tC4HHYSji8HPtwbMD0rwgT1tlxgTojWJUn/CCyKyNP5SLciCdzNuMICF10KZ+2+ZcyQW
         p3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777563424; x=1778168224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x1RKOP4VP3d7J5yz+d/pjS5o/pOR8N4/xyq7WLkcEKo=;
        b=pohLmAYeftdMatFM7xf2yU99EZxZxEPCXXawZgzsDZ9EG8Km/iqwIFQ9fIQq2LPvgC
         oX44qme0ArshG0jZjFiSbX8QcwhrUh+CGMfcuHyBNeAiybnyshx5rz+QEKTJG7Fn56B9
         tvTW7dm0l5BDkjFu/S9NJtj0RyEOmcHl+5uRzvBWAdd7lXdfVhwEDQZOmQW/fJXaP7SW
         mquerdym9x/iV7ZLs5kBTIbNNBM/1MkDgVe5JVwaenxUobjn4D88t+FBt+VtBnpI1Y/Z
         yScrAy8j6ZiZs1Qp2fQAqTdnx0OW5eCMJ7T20NXFhjwMKCApzV01tUcl3RDymEhTNhKZ
         Q57w==
X-Forwarded-Encrypted: i=1; AFNElJ/77Ra06+GCsXpUsr4qFlZMlEsqMnzfjaGKZhWkjzNBzdPGPrhw14Cmeh1wVd98BJvPlPtimtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YziRYx7MNUvPlsRvgmWGiTdUs4EAvCic/viIz6mDKSAbb9q1qQo
	kxEmPBoAwM4mk6WF8UEbGBlKbEkevd8NJtXe5ERXt6IfJJlOgOOK88M11Iju2qSl4FoJS977RC+
	EA46r+US/pcHQ9B6Ex0NgGn8GXRUU6Bw3mz9HrXIIZWvzNRXkwU89YKJ3
X-Gm-Gg: AeBDies8/DwtR5pVq4P7iHB2HLorUIKl53lyrWTcnLzFph1XJjXBjZkP89S+wcqfY2y
	j1kZKbfYq/0VdgHcQnpIWbAjXFwb7IcidHVhfvUZoC24Lm+RN8I4nZ85WvptwEKuOX4NwUs9cnI
	6mz3vU3Ptfxih+9em3xFChWZj4UyEk1Xpbvc7MN3WiHkjjmuhj3bx6NhuChNKBRNe3wVJ9UKQPv
	VeGsUUYPbwhwwzrnwMXcrojEeTLHuVSa+joWjEsmjYXvvDLgC8JMQXyPG5VSD1/xu2+N5KpAMr7
	APDaR2H4hhHvp9I/rxyV2gPDy9K3l9r2+Q/8Bql3rep8k16o54JoZJkaOGDg5MhAj/K+wwGDbaM
	At0Wtv9xTNpC+qmxnvgtEyqwEW0TqwcDBZPUnsLPO
X-Received: by 2002:a05:6102:2b93:b0:5ff:cb2c:a043 with SMTP id
 ada2fe7eead31-62ad1d3e0b7mr1964048137.2.1777563423337; Thu, 30 Apr 2026
 08:37:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427081953.364819-1-edumazet@google.com> <6e00eaa5-a4d7-45dd-9d90-fb319b76c9fa@kernel.org>
In-Reply-To: <6e00eaa5-a4d7-45dd-9d90-fb319b76c9fa@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Apr 2026 08:36:49 -0700
X-Gm-Features: AVHnY4IqHXIxB-ED2RO9MpZRTMiAoy-s6nLq0Fp5f9xarmAhj0jFIwB7lArMlhU
Message-ID: <CANn89i+VmgMqcte4GgBBF7+rtXUzX-=k1hYY6T0=xsj-Sm-=_Q@mail.gmail.com>
Subject: Re: [PATCH v2 iproute2-next] utils: add fflush_monitor() helper
To: David Ahern <dsahern@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E97934A4F1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[networkplumber.org,davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-282909-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]

On Thu, Apr 30, 2026 at 8:35=E2=80=AFAM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 4/27/26 2:19 AM, Eric Dumazet wrote:
> > Some fflush() calls only make sense for monitor programs.
> >
> > For other cases, forcing a flush is expensive.
> >
> > After this patch, ip, tc and ss are correctly buffering most of their
> > output when redirected to a file.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  include/utils.h  |  7 +++++++
> >  ip/ipaddress.c   | 12 +++++++-----
> >  ip/iplink.c      |  4 ++--
> >  ip/ipmonitor.c   |  1 +
> >  ip/ipmptcp.c     | 10 +++++-----
> >  ip/ipneigh.c     |  4 ++--
> >  ip/ipnetconf.c   |  2 +-
> >  ip/ipnetns.c     |  2 +-
> >  ip/ipnexthop.c   | 12 ++++++------
> >  ip/iproute.c     |  4 ++--
> >  ip/iprule.c      |  2 +-
> >  ip/iptoken.c     |  2 +-
> >  ip/tcp_metrics.c |  2 +-
> >  lib/utils.c      |  1 +
> >  misc/ss.c        |  3 ++-
> >  tc/tc_class.c    |  2 +-
> >  tc/tc_filter.c   |  2 +-
> >  tc/tc_monitor.c  |  1 +
> >  tc/tc_qdisc.c    |  2 +-
> >  19 files changed, 44 insertions(+), 31 deletions(-)
> >
>
> no longer applies after merging main to next.0

Hmm... I thought Stephen had a better implementation?

