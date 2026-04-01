Return-Path: <netdev+bounces-273877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPobAgeUzGmbUAYAu9opvQ
	(envelope-from <netdev+bounces-273877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 05:41:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDA23747C9
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 05:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A51E300B451
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 03:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8522C237C;
	Wed,  1 Apr 2026 03:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xg76noXy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BD627B4F7
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 03:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775014822; cv=pass; b=mEe5ujSC29obNIl+UrtDJW3rvnvr9ufDQWDgrxV5DPmFCKKNqL0yexfQ3CsgK8iRHeS3ujX2QCnIjgRur2bHX9LIMgwK4fVB5LC+1GmLJKnzQ0rLll0e3HAtjNECE9wgJkSPz5roMGsNFhUy9gej8nVMqHVZS5xTsRX9M58F7fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775014822; c=relaxed/simple;
	bh=oUyEXc3XiynjcTHtGiID2EUz4N7zasHPlmhALP9ffJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjJ1dh7NIMAQNanYqz2WrOs3nB/z0pSPky9LhWxfe1j6JuM5cZ9cTmK7+nEJpyiH6QhmDYY5EeG84MxD6w47d9XMmkUuSWUOD03X4I9oJBwQGLobzPvdLnhG3iIPeq+OHXziuieVbhNCVt511sLRb7uihZubxNmqKzLQjQErOV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xg76noXy; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a159c1e65aso5997713e87.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 20:40:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775014819; cv=none;
        d=google.com; s=arc-20240605;
        b=KImrHzu8+GOMJTgg5yqtSQOM7yabeL7gXIIMzapxnPF5L81+cOBhmBbQvFT7hzGfAM
         cqD/Go7ze3gi0dNA1kJ5TSvZ+MQVqzpFuS8Brds6FGcQqP1RT718FIUAIHZoTfswphl7
         kX4YWWRpiaY0enWX7l8URsVYHN2ZSM7HU/bfcq9I8uM6wjjggits7+9vugQU1sCFjc5h
         gXFh/ynElkXDJhca/8fsdnuQJiYYXA/wA5r04KvATXDn8XDCn6llhzF8Q7qfQ/Ip0HJn
         UEY8Ljy+RUogGASD81DSy89AsbMcDOdlKQlPnrXERyRDaM4fc+/sYzEeV5t4MthXdEMx
         0hXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T+u5tZ9YMLQ8JYf/l9scUzCOxeWBehfS4X5EDKo4y0c=;
        fh=Xf3If7O3syvJt+nSEJhhxTQlalPm+bqH+s0Ea7zsnsI=;
        b=aEtkgfMTl9tqk9MFb4llDAG4EtfTmLBGwwmOdOghiFUXZR85QI5PQBOltqgmPkaleb
         xfxFqp0ZQAu8VYKVKeBZo9tq+OzTHE8K8QXxGhana1vONYejvti7DWpIv1AQ96Ak4RUA
         sDPyfA8jcQf9g0Q3SftRl5UsfQeyEWMl5yZvi86rnJmFD9JiiKaOxNbZu/YEzR0IISqv
         GOWtTtv21eDNGV8iifM5lsmlyTzqDuRaKYiv/BckD/A2c99uouIrteu1Gum02RzdAAOe
         Cf8ZeFpX4xiDbNjX8NVOgZSoWfTG5e03MOrBfPy46G1pUFrPcwEu9Ns1eIz4DC2aD3b1
         5VrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775014819; x=1775619619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+u5tZ9YMLQ8JYf/l9scUzCOxeWBehfS4X5EDKo4y0c=;
        b=Xg76noXyjm/ZnqoPW3WMIiWBQORpq/Mge53XecxOWrUHjSVF+T8z/8OxfiuqyWNiKu
         xSyT/byz/jPQD1JgIi/1GKRv4KcigxC5b5D6KU8f9zOb+PLobN2IXDqkGVoiPaXKBWD8
         vqTd/bMKID/tqzBY5vLCeZ0T+ZFLWz1anqsdgKg3dx4WsSx3vxCVtQpaVPWinrhLSlVj
         OXAYfDiKSUpOrV80/IGS5N+mKSmIlNF3Dr5mXKOuSl3GfPOBhTKPigfO2GFmwzHu+4Wq
         Q3yUzaiZ6N0DOW8+VtNWyJ9pH9xNWJaFClabEsD2QOvgeb5v1W4qdVrkHg10Svtukj9T
         yGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775014819; x=1775619619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T+u5tZ9YMLQ8JYf/l9scUzCOxeWBehfS4X5EDKo4y0c=;
        b=QlqqApA8HA/Hft8dlNYZHowAPO6uI6Ch+i/Xiwb4n0fNCSB41rLe4HkIo/lHP72B7o
         dxfzkH9yteiNTMJAmpY5n8l2PEF3qMYg4SzalelMCg8M25k7bT6dsjp9LGMDZbSfJQ+d
         MpwWnaREiXHXaTU/p4R1P3X0g9ZBS5FwoQ/ODdUOsVtrzt5bTXRhKRfTR2e+Qa7yUrH8
         nkdH8b8xvxxZZINoqQYBOGh0FfY39sHyP4CoqcHrJ45HolEhEop+rIOC4FAQ+f09RROj
         umAGNk8W+xUeVmOE/EdjVALYvOscIbu0Lt6gxL4KnEjNPExNA0bRCYURiC+twOKYcIKo
         Ha7w==
X-Forwarded-Encrypted: i=1; AJvYcCUbwKWcpNI09bkvzSaSlF9pziXYqVDdFWHeFUMApKnIPuPYKm9O7geiJI1fFmRJUyXDhUPcJxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+GxEjAc0FjliS+xsELefsAFaqjIincC0y9TZFIaagUQlC2Zas
	HqN67ipJxZ6SSx5/GKrI0AhZBZusVMpp+Gxxl48EsaVVsTBl/MY+VsqjGilacDxcC7Xk3/z+r4T
	n8RzaPuMl7ZU7dNZlcBQMAZiXsJd5UW0=
X-Gm-Gg: ATEYQzyaXjSrNA/lM2H7yKKCtvuP4w88Dg4Xo+HOCGldHOnyVtwnQpGb2vTCvOTp5qp
	CcFVhKIlDXNjrypS2SPZAc03jjD+bS9pg18rpSlG7lL5Q4qY1eOn74JdJFTPAGFLp/RwvvFKWpq
	XRs2vX3HzkqAz+/dpOjbBPqefzFS1BJBl3ZpUjuEIlXvz4Ff+tl2F8219rR32U0syymD5c6gqPA
	PvZEIR7IP+qdphEZhPHpQ0mFoEiv6WLW57JmdQtyugsrztYXHyAUS+zu3PixKHPFU365Myfd20+
	cEMDIiuV
X-Received: by 2002:a05:6512:3ba0:b0:5a2:c1b5:f70d with SMTP id
 2adb3069b0e04-5a2c1ee181dmr657567e87.6.1775014819071; Tue, 31 Mar 2026
 20:40:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327153347.98647-1-kerneljasonxing@gmail.com> <edbd653e-d7dc-4c49-a5fd-1954a8b21770@redhat.com>
In-Reply-To: <edbd653e-d7dc-4c49-a5fd-1954a8b21770@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 1 Apr 2026 11:39:41 +0800
X-Gm-Features: AQROBzCfH8FKjaVxuE6t24GU9I7a_-bMRUcl4EIFoffo3nBf9wEChS5KCRtbzII
Message-ID: <CAL+tcoBOkorHZhx3K6hTK_Fzy_eQoZ5AsrLG5uuDAkZ33i3EKA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] net: add sysctl to toggle napi_consume_skb()
 alien skb defer
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	horms@kernel.org, kuniyu@google.com, stfomichev@gmail.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273877-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5EDA23747C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 7:39=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 3/27/26 4:33 PM, Jason Xing wrote:
> > Commit e20dfbad8aab ("net: fix napi_consume_skb() with alien skbs")
> > defers freeing of alien SKBs (alloc_cpu !=3D current cpu) via
> > skb_attempt_defer_free() on the TX completion path to reduce cross-NUMA
> > SLUB spinlock contention to improve multi-queue UDP workloads.
> >
> > However, this unconditionally impacts the napi_skb_cache fast recycle
> > path for single-flow / few-flow workloads (e.g. AF_XDP benchmarks[1]):
> > when the TX completion NAPI CPU differs from the SKB allocation CPU,
> > SKBs are deferred instead of being returned to the local napi_skb_cache=
,
> > forcing RX allocations back to the slow slab path.
> >
> > The existing net.core.skb_defer_max=3D0 could disable this, but it is a
> > global switch that also disables the defer mechanism in TCP/UDP/MPTCP
> > recvmsg paths, losing its positive SLUB locality benefits there. AF_XDP
> > can co-exist with other protocols. That's the reason why I gave up
> > reusing skb_defer_disable_key. Besides, if the defer path is disabled,
> > that means TCP/UDP/MPTCP in process path will trigger directly freeing
> > skb with enabling/disabling bottom half(in kfree_skb_napi_cache())
> > which could affect others. So my thinking is not to touch this path.
> >
> > Add a dedicated sysctl net.core.napi_consume_skb_defer backed by a
> > static key to selectively control the alien skb defer feature. Let
> > users decide which is the best fit for their own requirements.
> >
> > This patch also avoids touching local_bh* pair(in kfree_skb_napi_cache(=
))
> > to minimize the overhead.
> >
> > [1]: taskset -c 0 ./xdpsock -i enp2s0f1 -q 1 -t -S -s 64
> > 1) sysctl -w net.core.napi_consume_skb_defer=3D1 (as default)
> >  sock0@enp2s0f1:1 txonly xdp-skb
> >                    pps            pkts           1.00
> > rx                 0              0
> > tx                 1,851,950      20,397,952
> >
> > 2)sysctl -w net.core.napi_consume_skb_defer=3D0
> >  sock0@enp2s0f1:1 txonly xdp-skb
> >                    pps            pkts           1.00
> > rx                 0              0
> > tx                 1,985,067      25,530,432
> >
> > For AF_XDP scenario, it turns out to be around 6.6% improvement.
>
> I'm not a big fan of multiple tunables around the same feature, but

Another interesting thing about this is for AI/auto tuning systems
more sysctls can be leveraged and help users find the best combination
of sysctls for their own scenario. I realized that especially a sysctl
can decide the different/opposite fate of one particular case, which
means we can give it a try.

> possibly here the use-case extends beyond AF_XDP right? Do you observe
> some measurable positive delta even with UDP? Possibly even with TCP,
> when the bottleneck is the sender?
>
> More data would be helpful.

Unfortunately, I didn't see any improvement with a simple udp flood
test that I wrote. Maybe I need to do more experiments around it with
more adjustments.

>
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> > V2
> > Link: https://lore.kernel.org/all/20260326144249.97213-1-kerneljasonxin=
g@gmail.com/
> > 1. reuse proc_do_static_key() (Eric)
> > 2. add doc (Stan)
> > ---
> >  Documentation/admin-guide/sysctl/net.rst | 13 +++++++++++++
> >  net/core/net-sysfs.h                     |  1 +
> >  net/core/skbuff.c                        |  5 ++++-
> >  net/core/sysctl_net_core.c               |  7 +++++++
> >  4 files changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/a=
dmin-guide/sysctl/net.rst
> > index 0724a793798f..42e06f93306f 100644
> > --- a/Documentation/admin-guide/sysctl/net.rst
> > +++ b/Documentation/admin-guide/sysctl/net.rst
> > @@ -368,6 +368,19 @@ by the cpu which allocated them.
> >
> >  Default: 128
> >
> > +napi_consume_skb_defer
> > +----------------------
> > +When set to 1 (default), napi_consume_skb() defers freeing SKBs whose
> > +allocation CPU differs from the current CPU via skb_attempt_defer_free=
().
> > +This reduces cross-NUMA SLUB spinlock contention for multi-queue workl=
oads.
> > +
> > +Setting this to 0 disables the defer path in napi_consume_skb() only,
> > +allowing SKBs to be returned to the local napi_skb_cache immediately.
> > +This can benefit single-flow or few-flow workloads (e.g. AF_XDP TX)
> > +where the defer detour hurts the fast recycle path.
>
> I think it should be clarified that skb_defer_max takes priority, i.e.
> no defer with skb_defer_max =3D=3D 0. Also it would be great if you could
> additional extend skb_defer_max documentation noting that 0 disable such
> feature.

The skb_defer_max and the newly added sysctl control different paths
respectively. In napi_consume_skb, napi_consume_skb_defer takes higher
priority.

These days, I'm wondering if you don't think it's worth a standalone
knob, how about a simple patch to save more cycles when skb_defer_max
is zero, like this:
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 3d6978dd0aa8..4045d7c484a1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -94,6 +94,7 @@

 #include "dev.h"
 #include "devmem.h"
+#include "net-sysfs.h"
 #include "netmem_priv.h"
 #include "sock_destructor.h"

@@ -1519,7 +1520,8 @@ void napi_consume_skb(struct sk_buff *skb, int budget=
)

        DEBUG_NET_WARN_ON_ONCE(!in_softirq());

-       if (skb->alloc_cpu !=3D smp_processor_id() && !skb_shared(skb)) {
+       if (!static_branch_unlikely(&skb_defer_disable_key) &&
+           skb->alloc_cpu !=3D smp_processor_id() && !skb_shared(skb)) {
                skb_release_head_state(skb);
                return skb_attempt_defer_free(skb);
        }
--=20
2.41.3

Thanks,
Jason

