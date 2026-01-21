Return-Path: <netdev+bounces-252027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI23JEc3cWnKfQAAu9opvQ
	(envelope-from <netdev+bounces-252027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:29:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 558D95D3F1
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C27347E9187
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6BD3933FE;
	Wed, 21 Jan 2026 18:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEx5GIM1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7663612F8
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019809; cv=pass; b=YYD6kSAGiLZOMFC362xqKjcF1yAKY2tr2GBtFT0iWCa0+MYC9LQXKAKTkPwHQmy34+kyN1cKdyk276XAKYgD9F5MUnLKatWr1NIngqFLYGwEPyKQtQHprE137yxNktFzCww8ibSjJi9XLuot5eefqHIdDKX+LaTk0j9BBexqjsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019809; c=relaxed/simple;
	bh=PdETfuP1u9AkTnIAU4OIisLef/UtQm36zVR7qzogAWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzzrHW/zLmrGyz0zLkBzvoT+AwgmQ1UJ0NHJIsKAxjloOTTOB7WRMuRZ3bg6845IZ4/nyWsfhy0HSir5HOcwBd1g4HcuwPLI46mQtcbszvcNUaBRZZdm/RizkXGAHDubXp6slM9r0rdFNxmt6c97XPujBViIGM0cxttd7SJilbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEx5GIM1; arc=pass smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-662b5db048cso59605eaf.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 10:23:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769019806; cv=none;
        d=google.com; s=arc-20240605;
        b=jC511UrhZnosGLg2LibtId+8JIH2LOXro8OSP+oSaYvsZ+qxFiFIeOvWuHOW/6Eky4
         D/wqXnJGA8F07ihs1KqqWIcT4GpXe2wzGpAC0KiY/debtThdFZ1IjcvNak3ZKctM8x/Y
         AG0jDipwmXS+I/fwS8IefDO5SENKUCSjWoOwD5bSajbx1hrgXrfTtBK5swSEPGSpgmiE
         PepQsJKeZzvsWt6EOZevbOztg1ILqRi1sWNvc2qEOIVbTCT590KKp3mGN+Hd9iUa7y2m
         0/BeHn6fVwHcSy9f9+0J5jC8LQauXRvwg6hqSeJmXTzaD6d9FcnYli3tTcANUO4Cr1Ir
         6uFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c1Hlj3w4l/0faf2g6KLOHGpExK3gCGGcIA2RjqkPX44=;
        fh=P/HVX2Scij3vZdTIcYjaqMyR9xJ+3MajswY47mPMVIA=;
        b=SJYhWVDB7dg323zzKrrAM+w6bZ2Vgmco8bG8MgLoSNi29NKBFtdVNhoSdBRI/QNuZk
         mH/+/2u7JNeRg6vQGHhDYH/aOLuKaqKqOLNnc8nM12pC21GChRF9AaOYvTkUZkya9stq
         wSVsOdiGSMOsEX5jrYbTen00062RswZsLpqEgVnDp9wsPWe6ulZeWuL8DC1uPeRWudDY
         hPAHn9dkmlJhgGj26ZvDCwuVBZGklxZ0nVVZojZ4oE5jpRXPBHQmQ+YW8WdyrhIDhbUO
         pWQ/VIYV5UD9wZG9vugD+NscaJYUbmFz/J5EKV1q/U31J/ot+kVNcMvDK5me/V1vkLyQ
         0VOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769019806; x=1769624606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1Hlj3w4l/0faf2g6KLOHGpExK3gCGGcIA2RjqkPX44=;
        b=NEx5GIM1Cm+k9YzMXo1CssCsPb+fEabArGDdg96J02KQ3+wdw+2I9RAKu2YcvdIJAS
         rRaM08v1OCJMhXNmB1QDbsDhnZtwFC/Yz4KG5072SLS7DADFL2Q9/x9YlELyyc/L03HA
         U8ie62v68eY+GCf5DgrvOXCMA6GN5FJECk40suqOvZQgrzMn39+0+kKfuK8HIFJ8tBPl
         eLPva3ritx1naoFTTJVjGgr+gRvWlI1H+FV4o0rfiylDMzeAUfm/XkuTrg8/TIGic4Tk
         zAMamFKcssVrpYFC2yjSY3aOiPKbzckEhBuvwVrzBqOnBBoSIH3ubRL2Jmi5mZUwuIL7
         Nr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769019806; x=1769624606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c1Hlj3w4l/0faf2g6KLOHGpExK3gCGGcIA2RjqkPX44=;
        b=hoQqlafuZYex+CMUSGLm/3c/xLXg6TI3CDzRu+97nDQ9rjAySQf5O2d7bh+58PzFms
         rLV9AgicmNh6NV9bJ5JiMNxYgR5EKNNgRqgBTH7WRRrpYE6g2nhqbrtGK1KVp/BJOQuk
         9iimHn/+P44fEu9PcOlaY/k8XbkUiyhCgxj0/8IIvwYsxy1pGVTS1kilhZtLE7lusAhE
         t8q+aMUufOcZqY57TeMlKHIyqTQlEwSFggaIg3as/Fthqg1k0/wxv9UcPtAhWM1cYQDw
         zykFWbSocEX9/8JBwJYiY+pTp4LD5ZHX/8sn2sgbg1+5C/8NF3EGjHfoY+8FMsGrJUaG
         PcRQ==
X-Gm-Message-State: AOJu0YykRmcvMMEsks1VTOB0hwU1sAnSDxaExOn2Vp2imev5iNS9now5
	RUF9ESGE6tATDj5Fd6Nex6erlCFMa22As07UoEahn7h79OxrRGg1WLN/6I6Nxzd9bgYxbXm2JAe
	Il+vkUYYR2BZMFMYtvq/diyt8Q0Z8EK4=
X-Gm-Gg: AZuq6aL8UOXiAYAtL8aSWCFC0Mw4SRKl/M7mesjbk+6+lPRNT4gmboj+WfybuameyiO
	LoVyzeM6pP80boHRT6T6fa8e0pFyTnK8cT6lPTuyzMT+A3T44NWHzQuQaZIpLDboqODX5QX9E5z
	PpclWxHMpVFMH7kUa6hx9maspKpdUwTSp+CQS7M3sqco6Ex0jwOFzFCKxKkjoEE8iRCgTaGGcNh
	9MPFOXGZKN/SJFDf1thNlYjHTe51RtzgZ571BoUq4qMSk5hi5xePWHGTPP34DbOO0jb8BfTyvgE
	ZURzxs6jKWJcUGZoc05yHUtD3ihs0vQGK69/9YaXOJvmGiw3NvWLk14Eppla
X-Received: by 2002:a05:6820:174a:b0:65b:35fe:4323 with SMTP id
 006d021491bc7-662b008f427mr2444409eaf.67.1769019805582; Wed, 21 Jan 2026
 10:23:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120092137.2161162-1-mmyangfl@gmail.com> <20260120092137.2161162-2-mmyangfl@gmail.com>
 <aXELnMSc4UU6DkbZ@krikkit>
In-Reply-To: <aXELnMSc4UU6DkbZ@krikkit>
From: Yangfl <mmyangfl@gmail.com>
Date: Thu, 22 Jan 2026 02:22:49 +0800
X-Gm-Features: AZwV_Qh2WtvpqzJ52fSNEITfJoGoQaUtqAWfgaFDL8o68nHE05e8TExvPZS0aAg
Message-ID: <CAAXyoMMAMAbEu=-wTf3MGMiZr2Uq7pqJXC+_zrtxKrsjyYi+AQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] u64_stats: Introduce u64_stats_copy()
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Mark Bloch <mbloch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Carolina Jubran <cjubran@nvidia.com>, Breno Leitao <leitao@debian.org>, 
	Shigeru Yoshida <syoshida@redhat.com>, linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252027-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid,queasysnail.net:email]
X-Rspamd-Queue-Id: 558D95D3F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Jan 22, 2026 at 1:23=E2=80=AFAM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
>
> 2026-01-20, 17:21:29 +0800, David Yang wrote:
> > The following (anti-)pattern was observed in the code tree:
> >
> >         do {
> >                 start =3D u64_stats_fetch_begin(&pstats->syncp);
> >                 memcpy(&temp, &pstats->stats, sizeof(temp));
> >         } while (u64_stats_fetch_retry(&pstats->syncp, start));
> >
> > On 64bit arches, struct u64_stats_sync is empty and provides no help
> > against load/store tearing, especially for memcpy(), for which arches m=
ay
> > provide their highly-optimized implements.
> >
> > In theory the affected code should convert to u64_stats_t, or use
> > READ_ONCE()/WRITE_ONCE() properly.
> >
> > However since there are needs to copy chunks of statistics, instead of
> > writing loops at random places, we provide a safe memcpy() variant for
> > u64_stats.
> >
> > Signed-off-by: David Yang <mmyangfl@gmail.com>
> > ---
> >  include/linux/u64_stats_sync.h | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_s=
ync.h
> > index 457879938fc1..849ff6e159c6 100644
> > --- a/include/linux/u64_stats_sync.h
> > +++ b/include/linux/u64_stats_sync.h
> > @@ -79,6 +79,14 @@ static inline u64 u64_stats_read(const u64_stats_t *=
p)
> >       return local64_read(&p->v);
> >  }
> >
> > +static inline void *u64_stats_copy(void *dst, const void *src, size_t =
len)
> > +{
> > +     BUILD_BUG_ON(len % sizeof(u64_stats_t));
> > +     for (size_t i =3D 0; i < len / sizeof(u64_stats_t); i++)
> > +             ((u64 *)dst)[i] =3D local64_read(&((local64_t *)src)[i]);
>
> Maybe u64_stats_read/u64_stats_t instead of local64_read/local64_t?
>

I think casting to u64_stats_t is a bit overkill here since we accept
const void * and we are the actual implementation.

Again, they should convert to u64_stats_t, and this solution already
implies that u64_stats_t is binary compatible with u64. I've already
sent several patches related to that, but that's another issue.

> > +     return dst;
> > +}
>
> Since this new helper is always used within a
> u64_stats_fetch_begin/u64_stats_fetch_retry loop, maybe it would be
> nicer to push the retry loop into the helper as well?  Not a strong
> opinion. It would be a bit "simpler" for the callers, but your current
> proposal has the advantage of looking like memcpy(), and of also
> looking (for the caller) like other retry loops fetching each counter
> explicitly.
>

The callers may want to copy other discontinuous data as well, albeit
no one did it then.

         do {
                 start =3D u64_stats_fetch_begin(&pstats->syncp);
                 memcpy(...);
                 u64_stats_read(...);
         } while (u64_stats_fetch_retry(&pstats->syncp, start));

It would be redundant to provide two variants of the function.
Moreover, callers can (and already) invent their own reader/writer
helpers, for example

         #define SLIC_GET_STATS_COUNTER(newst, st, counter) \
         { \
                  unsigned int start; \
                  do { \
                          start =3D u64_stats_fetch_begin(&(st)->syncp); \
                          newst =3D u64_stats_read(&(st)->counter); \
                  } while (u64_stats_fetch_retry(&(st)->syncp, start)); \
         }

> Either way, I think extending the "Usage" section of the big comment
> at the top of the file with this new helper would be nice.
>

I think callers should avoid memcpy() eventually, and they almost
certainly copied more data than what they need. However, I took a look
at some instances, and it would be non trivial to modify those
drivers.

> --
> Sabrina

