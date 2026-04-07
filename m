Return-Path: <netdev+bounces-276136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFeKFk1d1Wlq5QcAu9opvQ
	(envelope-from <netdev+bounces-276136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 21:38:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F256D3B3C72
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 21:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3755B30211AF
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 19:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F02374E57;
	Tue,  7 Apr 2026 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aterlo.com header.i=@aterlo.com header.b="wfHWRSOV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78186372EC5
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 19:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775590729; cv=pass; b=ss1PrPx5a0nNzEgyTdVVgQ0ofiFbMvCVcdvmZimrptPtt4PflfEEUjq8GpfFDzJDXVze8t7gXy8keIYELju9Ln6YogZub9DYS8H9RYqOBZvWu7njUSokREUZ+/5+FrO7YdoKSnA593YJARBE68+PInE2Wm8c9zcHKFSxXPBWTXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775590729; c=relaxed/simple;
	bh=IdXckQZCCR0Unwj4/ri1WZGlzCDrwrr4RtZGyYKmWyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2Xg7h+Yq/uXJ5f9N16IWm2uj/X2l3pXcqDBCkBYA6LUeR1X2p8rxysLd41DE9Mjv9nBTQOGzVRBL9MsLYu/z6YgWeZoeX5b52qmJyoi4vr31FVJTptorw5VoivmjFf6kaOzo5AFLsWghj5hUJ5i2BT+mIqN+d00gMCw7Gm2BjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aterlo.com; spf=pass smtp.mailfrom=aterlo.com; dkim=pass (1024-bit key) header.d=aterlo.com header.i=@aterlo.com header.b=wfHWRSOV; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aterlo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aterlo.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9c3e2cf3c0so875505066b.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 12:38:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775590725; cv=none;
        d=google.com; s=arc-20240605;
        b=dx7clCyXEtLqi+ehPq/ZqiMjNdA587XrM0afEYyToiTr1i4BXM0jAkUi5W89RBHH80
         X+D6+aFK66ubIoiL/Ao4UshDE+HlzPEYuFQoLJxsI33hm8qIJSXOTay6xAl7HuRjj5gz
         Y5ezp4rJG1q5HZRgCeY6wI7tR/4K5dVi9MCCyNYR27/ojcgExOQj+CTwYYHunUKMqwYD
         s9XnfQynXFbaXrfDNfPnQ2RZcPtv+aPrbJrCPvOr7WGt/2qV2u+1ZUcGTj3VqilM3+ef
         l6gy7oCGfQbzk/2551DcwzNAGFCylbsXc4ryyDCjb02+Ovit8/rt61HvBpfznBbROg+M
         7vrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iYWkYVlGE8Lt7q6zTJAbPvbpf/WQd0q5Z0z3fhQdg68=;
        fh=wu32itSxRiuz9D1tC0va9eLaMur/VEu3bswqlqHiE64=;
        b=goYvMMUMECqgYBLJx/6vbI8GigasT38h2xbTeQQloMch4KzvqmfcOITRtp5RQTKbzf
         nRXMwqqBiy5x0rZmNXOHCDAWpLNBQZLeV9bqxXV3Dv8lMRkfG/Wo1hWoQyb+a/sxcgf0
         IUOJk9zfLmJV7YFWGTYrB761YM+r0J0vFcNBhnRGAECcfQyAPRYKbgM3BlpGk65IjdZD
         Ws6rL8F8zphAaruz8afJv+WUM+EzCUR8dbdX+QotK0SzuSY1UYlhCgmrkWl/R79QEnl7
         eJqkJ1shRv9EOsf1yiyaddQjcyD1bFemQp8UfsaC315ISWSOgO4c1nGQODdDWrr1YYUI
         Ny/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aterlo.com; s=google; t=1775590725; x=1776195525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYWkYVlGE8Lt7q6zTJAbPvbpf/WQd0q5Z0z3fhQdg68=;
        b=wfHWRSOVIcjbVx9iguVLRu/QMLo3fz0P2i47byaae520LD/UF3ax8NH1vLKRjq4Yga
         tvXPhAiTlS3KgB7karaAWX94hsHr+442/PXsTHxfcx5PbCfWfvZXFepUuQJrMdow5DJO
         wYoXhvnr29/thpNgp1fimAQVTnIiV0dHa9VE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775590725; x=1776195525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iYWkYVlGE8Lt7q6zTJAbPvbpf/WQd0q5Z0z3fhQdg68=;
        b=ZoazJ3n4yJMl2y2Ng3Sa4Spi8GN36vPIu2a2nA19WKSp4diudloh1DPuiGHN2vmgor
         CxCi4whoFSX0AOE36PckaX2NUaSzvNSF5ThWo5BscujMLFn9w84U/vlUOH/NvsRY8RmW
         W74dwEI0iYytK+WhERHSdmUohD7dvtaWZukBXbDL2h+YZcd3X8E1bWoCDo/Mplh+uiJ2
         hNGDaW4PL+i4zXG962oqy9fq0CWpfLtE9+AG1Y3NhY9g8gXj6+KwQTdOKnP+T9WYGX7p
         tmFF2CYM/DfL++echafTxPrI1OvszRaThzcWL26iuv7EeZwyv+Sjv/vnn0xgGWHItrIN
         Ph3Q==
X-Gm-Message-State: AOJu0YwQ2rwsEMF3m9++L313sxvL7XEGxh/ojb8IfdX+JemG4gSz2ous
	Jyf43hLa0TdDqxAJxajbWM4W7Amzxy6qTCCdLNlFnwTOKBicKr7XwUcq81RJhq+ObkcFry5/osj
	mJ4rAQXrkMpJH75RRNpgNb5l7SylR1/3Ofp1a2gEX2A==
X-Gm-Gg: AeBDievV5ZdkOJAIItIux4z4ZrSJ5/isLxWR6cDyG1ghHciWWwpafpGJ+04WhuSGtOr
	UK2bCbaE67BV9qsBbWmsoON/T3PfZbYS16GKMbQzBzfUvyUAmyLA6aA0cVkp8wzKxPM/qd8zTn0
	hSz299QDGXbB6wFmJVcI54BZtAY5UbP3/9Pz3aV4J3mUyqmPKNkRQnTsiSbWnE4DXSHYVkMQT63
	up1oTDIGq5wb+oniss+YFgCPghUEcfXOoX6FZZDUn+6zuLURgMiuF4P8lNcv0BunvRos6siA2bJ
	88K+JcPtHQ==
X-Received: by 2002:a17:907:93c7:b0:b9c:1a5:acb4 with SMTP id
 a640c23a62f3a-b9c67b46e89mr659534766b.45.1775590725256; Tue, 07 Apr 2026
 12:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPgFtOLaedBMU0f_BxV2bXftTJSmJr018Q5uozOo5vVo6b9tjw@mail.gmail.com>
 <507ccd57-b164-40ab-95e9-2fcc185a1f7d@suse.de>
In-Reply-To: <507ccd57-b164-40ab-95e9-2fcc185a1f7d@suse.de>
From: Damilola Bello <damilola@aterlo.com>
Date: Tue, 7 Apr 2026 15:38:34 -0400
X-Gm-Features: AQROBzCBJ-8eprfpzXz4i-KYDXtMq9cXYq3hAIzq2_XxNETr6y9XL6Dl_kImJX4
Message-ID: <CAPgFtOKRdSCqTJ35vGOxCd7DZ8hg-zBqzf7ujkq2yz6dUucWQQ@mail.gmail.com>
Subject: Re: [BUG] net/sched: skb leak with HTB + fq_codel on packet drops
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[aterlo.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[aterlo.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276136-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[aterlo.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[damilola@aterlo.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,suse.de:email,aterlo.com:dkim]
X-Rspamd-Queue-Id: F256D3B3C72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Yes, that's the commit that caused this.
Fix looks good.

Thanks.

On Tue, Apr 7, 2026 at 12:39=E2=80=AFPM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> On 4/6/26 4:29 PM, Damilola Bello wrote:
> > Description:
> >
> > Using fq_codel as a child qdisc under HTB results in continuous growth
> > of skbuff_head_cache objects when packet drops occur. Memory is not
> > freed even after traffic stops, and the system can eventually run out
> > of memory.
> >
> > Regression:
> >
> > - Works on: 6.18.16
> >
> > - Fails on: 6.19.x (tested on 6.19.10-200.fc43)
> >
> > Environment:
> >
> > - Kernel: 6.19.10-200.fc43
> >
> > - Distro: Fedora 43
> >
> > - NICs: ens2f0np0, ens2f1np1
> >
> > - GRO/GSO/TSO: disabled
> >
> > Reproduction:
> >
> > #!/bin/sh
> > DEVS=3D"ens2f0np0 ens2f1np1"
> > for DEV in $DEVS; do
> > tc qdisc del dev $DEV root 2>/dev/null
> > tc qdisc add dev $DEV root handle 1: htb default 10
> > tc class add dev $DEV parent 1: classid 1:10 htb rate 100mbit
> > tc qdisc add dev $DEV parent 1:10 handle 10: fq_codel
> > tc filter add dev $DEV parent 1: matchall flowid 1:10
> > done
> >
> > Generate traffic exceeding 100mbit (e.g., iperf3) to force drops.
> >
>
> Hi,
>
> I managed to reproduce this and did a bisect. This commit introduces the
> issue:
>
> commit a6efc273ab8245722eee2150fa12cf75781dc410
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Fri Nov 21 08:32:56 2025 +0000
>
>      net_sched: use qdisc_dequeue_drop() in cake, codel, fq_codel
>
>      cake, codel and fq_codel can drop many packets from dequeue().
>
>      Use qdisc_dequeue_drop() so that the freeing can happen
>      outside of the qdisc spinlock scope.
>
>      Add TCQ_F_DEQUEUE_DROPS to sch->flags.
>
>      Signed-off-by: Eric Dumazet <edumazet@google.com>
>      Link:
> https://patch.msgid.link/20251121083256.674562-15-edumazet@google.com
>      Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>
>
> I tested this solution a bit and seems to be fine. We could probably
> just drop directly if the qdisc isn't the root.. but I believe this is
> cleaner and more future-proof.
>
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index c3d657359a3d..61ba54e909f2 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -1170,12 +1170,18 @@ static inline void tcf_kfree_skb_list(struct
> sk_buff *skb)
>   static inline void qdisc_dequeue_drop(struct Qdisc *q, struct sk_buff
> *skb,
>                                       enum skb_drop_reason reason)
>   {
> +       struct Qdisc *root =3D qdisc_root_sleeping(q);
> +
>         DEBUG_NET_WARN_ON_ONCE(!(q->flags & TCQ_F_DEQUEUE_DROPS));
>         DEBUG_NET_WARN_ON_ONCE(q->flags & TCQ_F_NOLOCK);
>
> -       tcf_set_drop_reason(skb, reason);
> -       skb->next =3D q->to_free;
> -       q->to_free =3D skb;
> +       if (root->flags & TCQ_F_DEQUEUE_DROPS) {
> +               tcf_set_drop_reason(skb, reason);
> +               skb->next =3D q->to_free;
> +               q->to_free =3D skb;
> +       } else {
> +               kfree_skb_reason(skb, reason);
> +       }
>   }
>
>   /* Instead of calling kfree_skb() while root qdisc lock is held,
>
> Of course, in this situation if the root qdisc does not support
> TCQ_F_DEQUEUE_DROPS flag then, the child won't use the optimization. If
> I am not wrong all the qdiscs that can be parent currently do not
> support TCQ_F_DEQUEUE_DROPS. Anyway, this generic fix is in my opinion
> cleaner than handling every caller.
>
> I am sending this as patch for net tree.
>
> Thanks,
> Fernando.

