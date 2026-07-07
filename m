Return-Path: <netdev+bounces-305262-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vunVBENlTGrVjwEAu9opvQ
	(envelope-from <netdev+bounces-305262-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 04:32:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F625716DB7
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 04:32:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pKMQkq90;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305262-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305262-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9148130054E1
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 02:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7493C367B97;
	Tue,  7 Jul 2026 02:32:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ADC372662
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 02:32:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783391550; cv=pass; b=M8BKvzRfOtx9wQW+GVjtQIzBe1u7XMnLXnC8N9BRzatMXfCJxGanRppm67XGf021E3y08zflAadkzR+ojnTq6v+Pl8yj1Z+FT8Cz9SwvCHdWnSjCaixwBOOQ2Kg7dFWSIDClJaoIczvI+Wro0nJvpP3Ni2mxECGgT6fZTC4LArA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783391550; c=relaxed/simple;
	bh=Otxxuui+KzpRNHXt9Jlt8OAdNVAoGdxxjae/jUgi5+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVkWNi6psNm4Z7my1KFNUjDbvUE4294ie5QiIZe1qoNSgcmXPG1jmn+eAzJwyWJq5SySMZ/B5SPqOOrA6jgwtd9qDtDmA/Pg3Qbjp8eclwM0nKiP97ke9/RSMlVQCBGMY02utU10tTHSxRTclWYjBV0zwxQqU0cA+qea5nsRdZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pKMQkq90; arc=pass smtp.client-ip=209.85.128.172
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7fe4808741eso31104137b3.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 19:32:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783391545; cv=none;
        d=google.com; s=arc-20260327;
        b=jLLBA1utDpc2CG1YiJn3Ipk2I1i8Z3aJy42AkBypxSAdl8sCtMOyUNmJevgG3qkbFM
         mHolcUy819HYL6lhzcjqV3XIB3C8N70EZYr2jIOrhE0tptHbyzeFlmMi2yTnEewdvWaL
         XOuNc10jtNx6LeXYD67Us2I7keqP5GqgTsRUM69+1mPqztcPWtQ7RNB+2/0WK9EpnhJG
         hTBA++wdH4FBL1AhFlY7bxeguzUJ6o0SWt53xneB//mVL6nVQ0KPrfRgKvDJv3G5Tgtx
         y1QWpvcCvTJIWwiIORDkZHvN0pgCfIeXxIcJfGIOL76TuqVUWQUCR3/w8Vx18enh/+a+
         adIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j7mSOAtwCkmxO0Ga9LO1DY4idm21hS03RdnP7Hxl5Jc=;
        fh=ITytedqMHQkUhOcSWea2rW0XKobIG5PcaIqa0y+1DkA=;
        b=EJmwFNBdTdwF35lA8ftG8qyVJ2To9efOr50SyTuj+CV8hLWmsDBn1Suc48csOH/YN1
         3NyM8IERr3XYxQY/K9BqWeVhFYUWggB7sAVD4jc8tRA/lDJwDUdcpTKN77qVJawHUSox
         Ksag5R56F7tmIRC2HA/zQ3hOYpFa8WipCrf5WFcbyteWyTLt4Gp7keNRQMRl7VNKhN1/
         vK9i3EjX8NZWA/o0/41FcFJfHp1qQSIqLftNzBseTElh9fpH2BrXXO4M6WrQcUGKmfQR
         UGJp7KAjCuqJRlWppLIEvlon1GuCc/m+DVj+5x8EdH8JAlO/KT6qR7nyRlgnHwf8QAB2
         UA4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783391545; x=1783996345; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j7mSOAtwCkmxO0Ga9LO1DY4idm21hS03RdnP7Hxl5Jc=;
        b=pKMQkq909LuYGfi7oQXEDzSkAIu+R1R8mxT2/l9VXp0mD76MCmBqqU3tA0+ttBtGs3
         Z2bTF0zJ7342d9W5g97bs4vN7UI1XYARB+wsKSiKb/6NwCbsg2fHtbkMRgPBXAuCvlv7
         EvYSY2R6QYercvybrDvZymgRdsWihgngyJH0GnPU7xm90E4LuYVQFVySVXyVP+9/G9UV
         GfKW9vcR27eUFBl/cqPAJygUQAC9Nfx3ez2wyMO/zzQkr17b7LfSHJ1OMOHHNdL24w/W
         JWstooOP1W+pE/0FKzdNhf0dlx/6fSRtz4WQDQU9TUusmeCEImAueCnfIwQNNdROerPD
         HeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783391545; x=1783996345;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j7mSOAtwCkmxO0Ga9LO1DY4idm21hS03RdnP7Hxl5Jc=;
        b=nFOiOFxKLSWkgnD3dwCS+OF5DBwjvA2qOZrvQjwrYEyZY4iB9iiP2CQ077tXmpyDC4
         x5GMrlp/JEPnLPWi7lk15bFkKohcpTVWk1qPWNDaQFP2EtaNzYm6RLMaeXRxphvPGg05
         Jcvog45G2XCSK++YShOLP58VP/IpQFXhVSkASs1C831fY8BulnQLJ0dVeUBJPQdU+Ur/
         HSgzU1Ek06B2fRZLrcNK0ZUjnQC9Hb6FYXyY/KVjN4zVqpGlDOdJZtEunXi03tsgM5+5
         TUmyZSM7vLJlhvl2HXjG6UaA15HK8JAd35pBYFUPmcQXOb7Xbs90P8GbmVoEMYSxHeXc
         EpQw==
X-Gm-Message-State: AOJu0YxKLTN/svqR+NfoLvDhOCzyT0j7ChtQmwLQYdEMF3JB03ns960x
	ZbMbbdbc9ARmpqslH7RlLfOmVEchAN/Ju+T0SseCc0ANH0xnPx29Ydimc3eMtHvgHy3Pm6IIZJw
	bndkR1NIPb34xMA5Purkz1Ip2ZOi+MCY=
X-Gm-Gg: AfdE7clSg12JAZwKyVRCuChnHmRUZo6HhjULVUze28STXkmWtmrwcPqKRYGqux04dXW
	WDiabM++NMPDpSxFE/ksIsuEylpvBZdzI71dtybQ6V2gm12/MDCy1XJQqxSuO67B1/3DT4OS2o2
	sxTZNF67HdpwH/Dq2jXXMWckHdEymKShOTLy9n8Xntqt90YuraHyok3bqxlKiTZ1WyggostzaQN
	b/uPs9wUTZVmLUZHmTCoUXhgjWNSkIEKQ0FoSXbnDLPQTWExLHNa6mX1oSYlMtuISNlEadaTFs=
X-Received: by 2002:a05:690c:d8b:b0:80d:66b2:837 with SMTP id
 00721157ae682-81be1340648mr28891857b3.14.1783391545383; Mon, 06 Jul 2026
 19:32:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627030117.2614741-1-zzzccc427@gmail.com>
In-Reply-To: <20260627030117.2614741-1-zzzccc427@gmail.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Tue, 7 Jul 2026 10:32:13 +0800
X-Gm-Features: AVVi8CcmjsMmhiwq4dDzZvQiiw1DO7W94kBjturRKaso7lURsDvzbJkABHWcuEE
Message-ID: <CAFRLqsXvrfWE4MWVic+en7KGs6UuxwjDot2ygt2cWH2TCUgmBg@mail.gmail.com>
Subject: Re: [PATCH] xfrm: clear mode callbacks after failed mode setup
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Christian Hopps <chopps@labn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305262-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[zzzccc427@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:chopps@labn.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:baijiaju1990@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zzzccc427@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F625716DB7

Hi all,

Sorry for the noise, but I wanted to gently follow up on this patch in
case it got buried.

I would really appreciate any feedback when you have a chance. Please
let me know if I should make any changes or provide more testing
results.

Thanks a lot.

Best regards,
Cen Zhang

Cen Zhang <zzzccc427@gmail.com> =E4=BA=8E2026=E5=B9=B46=E6=9C=8827=E6=97=A5=
=E5=91=A8=E5=85=AD 11:01=E5=86=99=E9=81=93=EF=BC=9A
>
> xfrm_state_gc_task can run long after a failed IPTFS state setup. In the
> reproduced case, __xfrm_init_state() cached x->mode_cbs, IPTFS setup
> returned -ENOMEM before publishing mode_data, and the temporary module
> reference from xfrm_get_mode_cbs() was dropped immediately. The dead stat=
e
> then kept x->mode_cbs until deferred GC ran after xfrm_iptfs had been
> unloaded.
>
> Clear x->mode_cbs when mode init or clone fails before publishing
> mode_data. Those states never installed mode-specific state or the
> long-term IPTFS module pin, so deferred GC has nothing mode-specific to
> destroy and must not retain a callback table pointer past the temporary
> lookup reference.
>
> The buggy scenario involves two paths, with each column showing the order
> within that path:
>
> failed setup path:
> 1. cache x->mode_cbs
> 2. mode setup fails before mode_data
> 3. drop the temporary module ref
> 4. dead state keeps x->mode_cbs cached
>
> GC/unload path:
> 1. xfrm_state_put() queues GC work
> 2. xfrm_iptfs unloads later
> 3. xfrm_state_gc_task runs
> 4. GC dereferences stale x->mode_cbs
>
> This also covers the failed clone path where clone_state() returns before
> publishing mode_data.
>
> Validation reproduced this kernel report:
> Kernel panic - not syncing: Fatal exception
> CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=3Dy
> failslab_stacktrace_filter matched xfrm_iptfs frames
> ack_error=3D-12
> FAULT_INJECTION: forcing a failure
> BUG: unable to handle page fault
> Workqueue: events xfrm_state_gc_task
> RIP: xfrm_state_gc_task+0x142/0x650
> Modules linked in: esp4_offload xfrm_user [last unloaded: xfrm_iptfs]
> Kernel panic - not syncing: Fatal exception
>
> Fixes: 4b3faf610cc6 ("xfrm: iptfs: add new iptfs xfrm mode impl")
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
>  net/xfrm/xfrm_state.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index c58cd024e3c6..4d95b2720894 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -2071,8 +2071,11 @@ static struct xfrm_state *xfrm_state_clone_and_set=
up(struct xfrm_state *orig,
>
>         x->mode_cbs =3D orig->mode_cbs;
>         if (x->mode_cbs && x->mode_cbs->clone_state) {
> -               if (x->mode_cbs->clone_state(x, orig))
> +               if (x->mode_cbs->clone_state(x, orig)) {
> +                       if (!x->mode_data)
> +                               x->mode_cbs =3D NULL;
>                         goto error;
> +               }
>         }
>
>         x->props.reqid =3D m->new_reqid;
> @@ -3291,6 +3294,8 @@ int __xfrm_init_state(struct xfrm_state *x, struct =
netlink_ext_ack *extack)
>                 if (x->mode_cbs->init_state)
>                         err =3D x->mode_cbs->init_state(x);
>                 module_put(x->mode_cbs->owner);
> +               if (err && !x->mode_data)
> +                       x->mode_cbs =3D NULL;
>         }
>  error:
>         return err;
> --
> 2.43.0
>

