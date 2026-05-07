Return-Path: <netdev+bounces-285139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEi3FGIK/GkAKQAAu9opvQ
	(envelope-from <netdev+bounces-285139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 05:43:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3D64E2B47
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 05:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8CF43008D40
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 03:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017162E6CC0;
	Thu,  7 May 2026 03:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIHh0qzp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB5F2DC792
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 03:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778125407; cv=pass; b=nXxi3SCWB3FXcKhUf7zyXcRusTi8Wa6kJ6cwvzB21QSHclUJREbwO32rECxZnyp2J5JhA5l7vaYliO3E5vDKRtla/7RGM8EKECF6vJeR2aQJ6nYnJzKAMkO/oOGovL3Nd+VfNbVRPH4ByHPzoBEUGF4kE1iLH3Ey8ALmHHKek1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778125407; c=relaxed/simple;
	bh=aRKnidp3Q05VqBbc2S/w3FeyyaWE66PWhaoPodWVk2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qngAgqbX9+hJjgu8vL80N58D1Png3gLt7vu1GYy8JVPMnYy/PHiUaNYnk2LHuFXZBaj7t5t/TTRQ8IUwT3N9/VfEkS2MWPxWoMqC/SYPOSgj0pHPjAbK81c5R65E+BK4QpH0Zu74Hu8QHQ+kZuzhmMhx/xEfMgVm9U0kYSzWqpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIHh0qzp; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dbcb467f2bso365156a34.3
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 20:43:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778125405; cv=none;
        d=google.com; s=arc-20240605;
        b=EoBA9PMCdMo3243FPkMsxPI37yTt00JGiwJe4NpwLS5tzprOwM+BZgMM3Lb8TnC3nS
         bXvk2j1bX5cMFk0KxSoS4uT3pNoGwuJysoeI9DCrSrsgJXlH/TKR0vPM19wy7EObwz1m
         UHkbkPtd9z7XnaANAZbMuvEUiFOb8klw35h8khFBPP86W/eyqhrKt+bHCbVbetCasazQ
         BYz4oXHK5BcxoLrFc9J+juLXldSVTKbytS65gtsjqO5m+RFSrU3iO3Z/70jrggfYg0hq
         ho+VByW7Y1D5oz8XUPjMsn92OE139kn9FlYGTBL2ORI8Y+DaiWEVD+UIzB9AHikPEjiN
         +d8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q3i1ZjGdgGDQWTUc11ULCcW0c9KwcFuhUwitu00k0gE=;
        fh=sa0LY2vE9y9xkMqaND7GbekOJRgA3esgoYAjYMZBkEo=;
        b=M8xP8nVx9/c5DAkOF6aZMqnJiWqlciLhUxCzpDIrtbm0/e9DeaE9d9rcH5tp9nsMwQ
         ld7Ftlsa1vqa78tn8xeEb809gBpv+dk0z6FPefcykjAMJA9l++NUTyVEedrLyDFHkyHY
         7Tt4WRV5vPVHcycJN7fXpEhRwdGetUzH1M1ljwlQDAG6MiT2rC41GWdVtOk929Yeo6Gi
         qI2B5TZ+Mz/eWS1MC7tRNynjAhc1sdhWQ3a7wQ7JCMO0KaUzib7lckYSHu/Uz612By3y
         9TjWMQ0mYK7UIy/z72GS2K/8dKZHHuQ9+UKCLHWF83uic9ZuWg9gQsGE3tHWm5LPTZso
         Watw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778125405; x=1778730205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3i1ZjGdgGDQWTUc11ULCcW0c9KwcFuhUwitu00k0gE=;
        b=VIHh0qzpUfuJSivPHbNLpX6MgWvyquIOxAc2k8mXczVRB7/GYtTvPTno1Lgn6orF/J
         5J2DHdX8HgcVDXSkT2Ci+OkKfNAsbm88uWPsgYzBiInFhzKq4jAFEZ7M3bFZ/EgH0Bxu
         AfM3vcEvCta4hjKdCuVHLw2/oqy/6qV4VlXnotGbwIiXU5ha9/JYzoHuCrz7URIX5Gex
         sMQ9s87KGK0NUe5dbCn2lbEaaFtUv4TNIHFTzYsl2fhFlopDiUG3LYiQ/E+ddEO0i+zS
         qTM/R2o32oFOhCclktNTk3hzFUIgXy4tGphyaQSwhA8wgZEGgf4my2JT2/8FHFj4A1IX
         eNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778125405; x=1778730205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q3i1ZjGdgGDQWTUc11ULCcW0c9KwcFuhUwitu00k0gE=;
        b=BnRMag58fAi3C9FUWruF9fmBOnclCAz//4rcLuyXNwybepSP5ZDCD3zoYsXVBmtqZJ
         RfzqhapQh3BVcjha6K6XjGJeUXw0PDJ+6SuxSnWsUcpswoutW1SAnCYGst86ymWR93UY
         aK2O4gW9WPloGj6KQBWABcDSGYfKUod9ZUP+W2b0RngC2zIGC/9RoMZF5rvnBI9sPbBo
         NhgenRCgURqgWcTRn5LBd2+0MGjMcSOrF1f7DC5idg2ohqE6VDtaK+bZ3XYOj65Z+PUG
         yDul1uMVMFwNOUjhDc8IsV4bKu6+7Na/ZjCyCybUjlghohTKzhxZmEu13mqhFMxgYBDF
         CIBQ==
X-Gm-Message-State: AOJu0YwgLCbzqpc0Tw3yJsXASr2SrEJGPsRm+rRdtrrYEG3ItcWmx6Ta
	ALhugA06H3ooDO14+7d8dlbrM11nCwQscheq0on67ASlokSrk0ZHVf+6r6eCOVWISjvhUIll/k8
	fLm5sjReMhFAu1QYPuZ29trJsP25WP5k=
X-Gm-Gg: AeBDiesG1KowGP/XIg18r/whaQGjtLesXmVaY9TEyhrqSKNOTHdmSmQDTVcU3q6LoWe
	gvekzQ6cEvHjhPVJpvd9i8SK4P4uhYdfZFbrlYlUYx+IUE12oqthgJDWIqzyVNXPAUBypSkr+Lu
	T3b4F8NOfJCARdUGQNHTf6TRLW/VP5ADRxUbyz1bZZnjeomoPkhcoA56d1LkGcSxZuHvmF+tZg2
	PRxSAguny5sEokTs2LYxb4Stvit8VNUlc5ex/5/skAGvjK6J56QJlVsGfXb2C1fLbUevtwrHeUl
	11qsrMJUZKUr7Y6cJsd737BEYv5eV4ER0TLe1Iy6Hyc5Q5rDhtoLYEpZytgh
X-Received: by 2002:a05:6820:1793:b0:696:6d2c:92b with SMTP id
 006d021491bc7-69998d1d63amr3177652eaf.33.1778125405313; Wed, 06 May 2026
 20:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504101258.1608004-4-mmyangfl@gmail.com> <20260507012311.2187979-1-kuba@kernel.org>
In-Reply-To: <20260507012311.2187979-1-kuba@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Thu, 7 May 2026 11:42:49 +0800
X-Gm-Features: AVHnY4Kz2DpjSwL-PW9Ijw012NoML73jqi_gVdxwhybBru6xUf40tWsz3WruDnk
Message-ID: <CAAXyoMNRAs0+Hmy7TFAcsRcxM94=pgWFdLw4twEcXs3w6aR6wA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: dsa: yt921x: Add port qdisc tbf support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, jhs@mojatatu.com, 
	jiri@resnulli.us, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: EB3D64E2B47
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285139-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,mojatatu.com,resnulli.us,kernel.org];
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
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 7, 2026 at 9:23=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
> > +                     NL_SET_ERR_MSG_MOD(extack,
> > +                                        "Offload not supported when mt=
u/peakrate is configured");
> > +                     return -EOPNOTSUPP;
> > +             }
> > +
> > +             if (!p->rate.mpu) {
>
> Does this code miss validation for p->rate.overhead?
>
> The TC TBF layer allows configuring overhead to account for additional
> headers. If the hardware relies on fixed wire frame sizes and the driver
> ignores p->rate.overhead, could this lead to a silent misconfiguration
> where the hardware shapes traffic at a different effective rate than
> requested?

I didn't see it can be non-zero while testing with tc-tbf(8).

> > @@ -1378,6 +1390,112 @@ yt921x_dsa_port_policer_add(struct dsa_switch *=
ds, int port,
> >       return res;
> >  }
> >
> > +static int
> > +yt921x_tbf_validate(struct yt921x_priv *priv,
> > +                 const struct tc_tbf_qopt_offload *qopt)
> > +{
> > +     struct netlink_ext_ack *extack =3D qopt->extack;
> > +
> > +     if (qopt->parent !=3D TC_H_ROOT) {
> > +             NL_SET_ERR_MSG_MOD(extack, "Parent should be \"root\"");
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     switch (qopt->command) {
> > +     case TC_TBF_REPLACE: {
> > +             const struct tc_tbf_qopt_offload_replace_params *p;
> > +
> > +             p =3D &qopt->replace_params;
> > +
> > +             if (p->mtu || p->peak.rate_bytes_ps) {
> > +                     NL_SET_ERR_MSG_MOD(extack,
> > +                                        "Offload not supported when mt=
u/peakrate is configured");
> > +                     return -EOPNOTSUPP;
> > +             }
>
> Is the p->mtu check overly broad here?  tbf_change() in
> net/sched/sch_tbf.c sets q->mtu from the user-supplied qopt->mtu whenever
> TCA_TBF_PBURST is absent, so p->mtu can be non-zero even when no peakrate
> has been requested.  A user that explicitly passes the mtu parameter to
> tc would then be denied offload with an error that attributes the failure
> to mtu/peakrate together.
>
> Would gating only on p->peak.rate_bytes_ps better reflect what the
> hardware cannot do?

IIRC I have checked that with tc-tbf(8) (or I used the wrong series);
will check that later.

> > +
> > +             if (!p->rate.mpu) {
> > +                     NL_SET_ERR_MSG_MOD(extack, "Assuming mpu =3D 64")=
;
> > +             } else if (p->rate.mpu !=3D 64) {
> > +                     NL_SET_ERR_MSG_MOD(extack,
> > +                                        "Offload not supported when mp=
u is other than 64");
> > +                     return -EOPNOTSUPP;
> > +             }
>
> Is setting an extack message on the success path intentional?
> psched_ratecfg_precompute() leaves mpu at 0 by default, so the common
> tc qdisc add ... tbf rate X burst Y invocation will hit the first branch,
> return 0, and iproute2 will then print:
>
>     Warning: yt921x: Assuming mpu =3D 64.
>
> on every TBF replace.

https://lore.kernel.org/all/20260413153248.0588690b@kernel.org/
...BTW we can use extack for "warnings" like this, too

> Also, is the assumption actually enforced anywhere?  yt921x_marker_tfm_sh=
ape()
> and yt921x_marker_tfm() do not appear to compensate the rate computation
> for a 64-byte MPU, so the message seems to document an assumption that is
> not modelled by the transform.

tc-tbf(8): "For ethernet, no packet uses less than 64 bytes." I don't
see a need for rate computation unless I get it wrong.

> > +
> > +             break;
> > +     }
> > +     default:
> > +             break;
> > +     }
> > +
> > +     return 0;
> > +}
>
> Would it be clearer to have yt921x_tbf_validate() return -EOPNOTSUPP for
> commands the handler cannot service, so the supported command set is
> stated once?  The default arm here returns 0 for every command other than
> TC_TBF_REPLACE (including TC_TBF_STATS and TC_TBF_GRAFT) while
> yt921x_dsa_port_setup_tc_tbf_port() below returns -EOPNOTSUPP for those
> same commands.  There is no observable bug today, but if the validator is
> ever used on its own the two lists can drift.
>
> > +
> > +static int
> > +yt921x_dsa_port_setup_tc_tbf_port(struct dsa_switch *ds, int port,
> > +                               const struct tc_tbf_qopt_offload *qopt)
> > +{
> > +     struct yt921x_priv *priv =3D to_yt921x_priv(ds);
> > +     struct netlink_ext_ack *extack =3D qopt->extack;
> > +     u32 ctrls[2];
> > +     int res;
> > +
> > +     switch (qopt->command) {
> > +     case TC_TBF_DESTROY:
> > +             ctrls[0] =3D 0;
> > +             ctrls[1] =3D 0;
> > +             break;
>
> Is there a concern about the write ordering on teardown?
> yt921x_reg64_write() -> yt921x_regs_write() performs two independent
> register writes (reg+0 then reg+4).  On TC_TBF_DESTROY the first write
> sets CIR=3D0 and CBS=3D0 while the previously programmed EN bit in ctrls[=
1]
> is still set; only the second write clears EN.  The REPLACE path writes
> configuration before arming EN, but the inverse is not followed here.
>
> Would writing ctrls[1]=3D0 first (or clearing EN via a read-modify-write
> before zeroing CIR/CBS) be safer for the hardware state machine?

The AI got confused on register operations; see comment for multi-word
registers.

> > +     case TC_TBF_REPLACE: {
> [ ... ]
> > +             ctrls[0] =3D YT921X_PORT_SHAPE_CTRLa_CIR(marker.cir) |
> > +                        YT921X_PORT_SHAPE_CTRLa_CBS(marker.cbs);
> > +             ctrls[1] =3D YT921X_PORT_SHAPE_CTRLb_UNIT(marker.unit) |
> > +                        YT921X_PORT_SHAPE_CTRLb_EN;
> > +             break;
> > +     }
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
>
> Does returning -EOPNOTSUPP for TC_TBF_STATS defeat the hw offload
> indicator?  qdisc_offload_dump_helper() in net/sched/sch_api.c first
> clears TCQ_F_OFFLOADED, then calls into the driver, and only re-sets the
> flag on a zero return:

No one else did that; mt753x_tc_setup_qdisc_tbf().

