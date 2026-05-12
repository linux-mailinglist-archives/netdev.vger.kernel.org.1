Return-Path: <netdev+bounces-287053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNLUEG/7AmpOzQEAu9opvQ
	(envelope-from <netdev+bounces-287053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:05:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDF051E3E2
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 411FC30115AE
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639F8492514;
	Tue, 12 May 2026 10:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hic2GOX4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1413AE187
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 10:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778580219; cv=pass; b=HB4jp5H/ex+dZ+3Pfddw0Qv29EK/knNvXzIgRetR9x7GE87W4JOjQR0um06cnBwzomAx5/O1ohj47FNmDesclv2qxQQAC0gzq6YCAQhecZWMinIOg+476R27pDtKT7MJ4dDfwdvetMAUopzlCDubLcZsmQ49voL8yWwqsm2RWZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778580219; c=relaxed/simple;
	bh=3oQSk/uVjA1as9ZVrWH+Ah6AoeHdCwAMDsov0zYevO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEGQaCWQ9+sRKfQfCwylRRX1rhqg/t/JhAZxU7HLlOiS6L1rMjeAKab08B/8awzzdtEkNXh+uApniYH3gjiCfTTQrUPxAsd0b/BOZp5XpVf29Dz4EfRzV1zACd83tHIw+/nxlsbD5gRe1DEv+BoIkfnD08N87XiKfx34kxjk9n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hic2GOX4; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4358f61c9c8so1180957fac.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 03:03:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778580216; cv=none;
        d=google.com; s=arc-20240605;
        b=YJvPlheLR20kA7/XCRwWrGk6fN3wpI+PZGhf6UIc+Tu+ja/YlMFSnUEe4pwQG8HKjZ
         gaQ704cwgQGWPylxNSr33BW2zMfLjuOTL/KEYGTpxz2gq2+BDGjt8TparCCSoAH4ASHH
         uB9cFjxItLuvFUNiMMbz225LcXRHvFBM9dNYw47gmcFluDkCvRslYprqX2WNaV/9CAzq
         B7tZkgIuznVD+1EbHJAy0QeDgZhGpFxLpaIFkBiHpEmMuLLIE2udu62P7MP/hg2lDwID
         pgY51hfuaW7+GN1EGY5F04OaMWpvkHe1o7LAD7a7Ua1B3wEXyja4hZ/XD/Ci7Y/cDmgZ
         8xjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9vpyC9g/4a6soW3baW1ZfRfFD5ejqC8VcJYB7ujrZwE=;
        fh=L7xJ3Z4ehael7Zy0GiAsqdupmGcFu8iJQpzW/ZwZi+4=;
        b=lvXqqlHbVtAaE+Nez9A2J0rHWVLW/FdJ3dkD1DKNxCHqLLElItDGqTeccfK9FpgkBT
         RDkK1eZm06kCSZ83yf2T5EnzYvmIjQNuZ/0CGp/5t3ZUkb/yOswgIC1OIo1/Ig/h39BO
         WodjoQvGsuP/cdUeupjYNo6Hyo1UajLIufcomK9fl6JpjjLZCm/+GXudzZcABJZWrHnG
         hX3eG0iH+s6UTCfiJY7RhLSEfEC7TiEO5r6lMe2uznUptiSEack21+tDXCAW7NFxsE0T
         8FWH6RV0rJ8o4JwVugDOPPCOrb9x4XDBm5Sh4sJyHY5C3UsrIbY3Sof6t/ryzL2trQUw
         xaow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778580216; x=1779185016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vpyC9g/4a6soW3baW1ZfRfFD5ejqC8VcJYB7ujrZwE=;
        b=Hic2GOX4ca7GcES0yoK82n9A2MO58pTEMcJhxYXfvYp49YCWn+rdKxl6IUb6nT9isk
         lboX4WozB8R2oCyvHEinBfVdv57UQr2XdRuJEYRGXrKHqzcpVPhyfsPwn3Ubfpd9mrzw
         NLMev3XNuD1M0ufDQNFTXbhqOWx7ynquQ1tM8zmgIuE+nRuo0Z/qCZrxTTWvRbX59kpN
         S7SNypyQGPbye26SNo391Q1asHMZ0+Gdk2jM3ffYr6bZcOc9XxFOd90e57cNN5VGK7Up
         9MwReLX2Fk8dNy6bgBWqeyyZVt7s3ZCTYlZkONulfewCyLmnQiqzlHLo1DNDEaKGxIfG
         J4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778580216; x=1779185016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9vpyC9g/4a6soW3baW1ZfRfFD5ejqC8VcJYB7ujrZwE=;
        b=RM1IyEmbiQulvnLg4z1MPdXhunc3rvwhY5M6EytDDhIGBZa6OlQg+1L+5lXJC1gwbz
         XiqkdXGkwG5QL/GRiYLC6aGoiM4d8kSIwbFRKgpVUXqntupctrxO1aS4eeZjvAjasRDY
         qp6iGlWaJomqt3/R7UCdI0Hh8FbIGM090Hqiw5Zx+5KRJqvODGwp92HvvDpHHcB8fdch
         JtzfY6kGTpkwO6ownlCbhKAGDJ8aGnPVyvuorlt74L6booM6syHC+G4QWo5rjBo+pizD
         RTXD+nOtdITPvHlEqzvA/c8U9jNsOJbNCdjBn8Ea0xbS/j7c2c+ds0z/DWsgb+HmfmhI
         HrdQ==
X-Forwarded-Encrypted: i=1; AFNElJ++oBXxnfDw0E1bgwxwHLa5q2DMJKxci7NRLI/bDc9aM3uDGJDzNa9N55lZsWEX+supw/RZ9ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YymRn4WdpmtnOVuuhR60S8lhEhX6UrqZ38+4OipuFK1W5rAeMox
	b3DpGLdea5WHVYNZJbJXC1FO/Ji8HMaRcwazOWhSiZgRnWZhvn5Uxs8lJenq2GPfxlt7GGgZim9
	tbz/7EPh1gd4TfAeqhxKXKC8z3pme/ZY=
X-Gm-Gg: Acq92OFzYNczMJkVdV+WHIeqSD0WNQuU6R5QTGnfWiEm9QAOU9LANSXjZKKzQw1KA0m
	t7sLwInm8MlAuvj7OjVAdybHjfvjqeVaaqdQ9N1ctj5aclqH+pgRWDsdENINU225Izw+g/4X1su
	sZeqTUEfLnjgku0xC1jis71QizcZKFHLwlTghgwbxXDnO81bClNK87b1jQqpqN0/DdJS6bNeKiU
	nGohr9ABjjYcMJ2fE9zh2zU5DOZoxu4roVhYA+cGGWt7ShA9xmd4PLacc+ZSgW/7u4gcrde8UCB
	SGqjfQl637yMMDOpcGAPMW2y+PPYDpM/FclMgg==
X-Received: by 2002:a05:6870:55c6:b0:42b:d0fa:771 with SMTP id
 586e51a60fabf-439a29aa5d3mr1258410fac.21.1778580216477; Tue, 12 May 2026
 03:03:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512060627.3781329-1-danishanwar@ti.com> <20260512060627.3781329-2-danishanwar@ti.com>
 <CA+XhMqykBWcMdk+iNnOtUxM4MX6jpDyUwfuAVZFbjAShO9_v7Q@mail.gmail.com> <6a1f411c-d7ed-463b-abf1-277d8cc0c184@ti.com>
In-Reply-To: <6a1f411c-d7ed-463b-abf1-277d8cc0c184@ti.com>
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 12 May 2026 11:03:23 +0100
X-Gm-Features: AVHnY4JoBEuCCshjttiiP4pUrkdFzUklGWLsHa6Nwoh6aUuuy2gt7vVqJ1dT2a4
Message-ID: <CA+XhMqzx9CUX5H7q1UqL=heGWLFjZVfyiTx6b45VW=E9t13Fow@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: ti: icssg: Derive stats array lengths
 from ARRAY_SIZE
To: MD Danish Anwar <danishanwar@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jacob Keller <jacob.e.keller@intel.com>, Meghana Malladi <m-malladi@ti.com>, 
	Kevin Hao <haokexin@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Vignesh Raghavendra <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9CDF051E3E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287053-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,intel.com,ti.com,gmail.com,linux.dev,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,ti.com:email]
X-Rspamd-Action: no action

Hi Danish,


On Tue, 12 May 2026 at 10:40, MD Danish Anwar <danishanwar@ti.com> wrote:
>
> Hi David,
>
> On 12/05/26 1:28 pm, David CARLIER wrote:
> > Hi MD,
> >
> > On Tue, 12 May 2026 at 07:06, MD Danish Anwar <danishanwar@ti.com> wrot=
e:
> >>
> >> Replace the manually maintained ICSSG_NUM_MIIG_STATS and
> >> ICSSG_NUM_PA_STATS constants with ARRAY_SIZE() expressions derived
> >> directly from the corresponding stat descriptor arrays, so that adding
> >> new entries to icssg_all_miig_stats[] or icssg_all_pa_stats[] no longe=
r
> >> requires a separate update to a numeric constant.
> >>
> >> To make this self-contained, break the circular include dependency
> >> between icssg_stats.h and icssg_prueth.h:
> >>
> >>   - icssg_stats.h previously included icssg_prueth.h (transitively
> >>     pulling in icssg_switch_map.h and ETH_GSTRING_LEN).  Replace that
> >>     with direct includes of <linux/ethtool.h>, <linux/kernel.h> and
> >>     "icssg_switch_map.h".
> >>
> >>   - icssg_prueth.h now includes icssg_stats.h, giving it access to
> >>     the ARRAY_SIZE-based ICSSG_NUM_MIIG_STATS and ICSSG_NUM_PA_STATS
> >>     before they are used in the prueth_emac struct and ICSSG_NUM_STATS=
.
> >>
> >> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> >> ---
> >>  drivers/net/ethernet/ti/icssg/icssg_prueth.h | 3 +--
> >>  drivers/net/ethernet/ti/icssg/icssg_stats.h  | 7 ++++++-
> >>  2 files changed, 7 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/ne=
t/ethernet/ti/icssg/icssg_prueth.h
> >> index df93d15c5b78..e2ccecb0a0dd 100644
> >> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> >> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> >> @@ -43,6 +43,7 @@
> >>
> >>  #include "icssg_config.h"
> >>  #include "icss_iep.h"
> >> +#include "icssg_stats.h"
> >>  #include "icssg_switch_map.h"
> >>
> >>  #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
> >> @@ -57,8 +58,6 @@
> >>
> >>  #define ICSSG_MAX_RFLOWS       8       /* per slice */
> >>
> >> -#define ICSSG_NUM_PA_STATS     32
> >> -#define ICSSG_NUM_MIIG_STATS   60
> >>  /* Number of ICSSG related stats */
> >>  #define ICSSG_NUM_STATS (ICSSG_NUM_MIIG_STATS + ICSSG_NUM_PA_STATS)
> >>  #define ICSSG_NUM_STANDARD_STATS 31
> >> diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net=
/ethernet/ti/icssg/icssg_stats.h
> >> index 5ec0b38e0c67..b854eb587c1e 100644
> >> --- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
> >> +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
> >> @@ -8,10 +8,15 @@
> >>  #ifndef __NET_TI_ICSSG_STATS_H
> >>  #define __NET_TI_ICSSG_STATS_H
> >>
> >> -#include "icssg_prueth.h"
> >> +#include <linux/ethtool.h>
> >> +#include <linux/kernel.h>
> >> +#include "icssg_switch_map.h"
> >>
> >>  #define STATS_TIME_LIMIT_1G_MS    25000    /* 25 seconds @ 1G */
> >>
> >> +#define ICSSG_NUM_MIIG_STATS   ARRAY_SIZE(icssg_all_miig_stats)
> >> +#define ICSSG_NUM_PA_STATS     ARRAY_SIZE(icssg_all_pa_stats)
> >> +
> >>  struct miig_stats_regs {
> >>         /* Rx */
> >>         u32 rx_packets;
> >> --
> >> 2.34.1
> >>
> >
> > One thing that caught my eye: icssg_all_miig_stats[] and
> >   icssg_all_pa_stats[] are 'static const' arrays in icssg_stats.h with
> >   ETH_GSTRING_LEN name buffers per entry. Right now only icssg_stats.c
> >   and icssg_ethtool.c pull them in. After this patch icssg_prueth.h
> >   includes icssg_stats.h, so every .c in the driver (classifier,
> >   common, config, mii_cfg, queues, switchdev, ...) ends up with its own
> >   static-const copy of both tables.
> >
> >   Would a static_assert() work for what you're after? Something like:
> >
>
> While adding more stats manually, The ARRAY_SIZE() approach was
> explicitly requested by maintainer [1]:
>
> This patch is a direct response to that feedback. static_assert() would
> still require updating the numeric constant on every array change. The
> goal here is to eliminate the need of manually incrementing stats count
> whenever new stats are added
>
> Your concern about multiple copies of table is noted and valid. Could
> you advise on the preferred way to reconcile these two requirements? I
> am happy to restructure if there is an approach that satisfies both.
>
> [1]
> https://lore.kernel.org/all/20260112181436.4s5ceywwembn674r@skbuf/#:~:tex=
t=3DCan%27t%20this%20be%20expressed%20as%20ARRAY_SIZE(icssg_all_pa_stats)%3=
F%20It%20is%20very%0Afragile%20to%20have%20to%20count%20and%20update%20this=
%20manually.
>
>
> >     static const struct icssg_miig_stats icssg_all_miig_stats[] =3D {
> >         ...
> >     };
> >     static_assert(ARRAY_SIZE(icssg_all_miig_stats) =3D=3D ICSSG_NUM_MII=
G_STATS);
> >
> >   next to each array, keeping the numeric #defines as-is. Then 2/2 fail=
s
> >   to build the moment a new entry is added without bumping the count,
> >   which is the case you're guarding against =E2=80=94 without touching =
the
> >   include graph.
> >
> > What do you think ?
> >
> > Cheers.
>
> --
> Thanks and Regards,
> Danish
>


  Thanks for digging up the context =E2=80=94 fair point, I'd missed Vladim=
ir's
  earlier ask. Reading it again though, what he calls fragile is the
  silent miscount, not the keystroke of typing a number. A static_assert
  turns "forgot to bump" into a build error, which I think gets you
  there.

  What about moving the two arrays into icssg_stats.c, declaring them
  extern in the header, and dropping a static_assert next to each
  definition? Numeric #defines stay where they are, icssg_prueth.h
  doesn't need to know about icssg_stats.h, and the tables live in one
  TU instead of every .o in the driver. If the count and the array
  disagree, you get a compile error on the spot.

  Probably worth keeping Vladimir on Cc for v2 in case he had something
  else in mind.

  Cheers,

