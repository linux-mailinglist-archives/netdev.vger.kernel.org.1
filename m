Return-Path: <netdev+bounces-285136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMBHGisD/GmxJwAAu9opvQ
	(envelope-from <netdev+bounces-285136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 05:12:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FF54E28E5
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 05:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4D3E300D94F
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 03:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377512C0F6D;
	Thu,  7 May 2026 03:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfdFzrZU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C426E283C87
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 03:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778123558; cv=pass; b=V9Sfwvt9LJf8ykI08RcUHtiVGY0PICAtvJRSF+8YbN9pT1CarcBD3BoQ6IyEUcitlzXq1tmzOl+IUNCt2yKzIRip5xuP337uMktonAbAXbEzMQKZ65U9GWLmwejtCZiZ79ciAOtjljDmerOTmpkP5zKn/hve0//ZwCW7cC/v0pI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778123558; c=relaxed/simple;
	bh=t8EcPkbMkdoqxSEskUGLBEnkfdCmwpUfrxysv+5GqbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0+Nb5owbnWWCQx+oEkFTSVlyqnFKItcp64kiAvTAbjUx+O+/fCZ1iGC+J2Zfly/8oZtlUa7r4zzSQFGU1bsoFBTXHvVOLcIUIdcG5mZ9fHvNd5YM2mJteYI4e5zVjmIYOsWQWcIHQj7kJAAHSWVAwtTVgk5IBnCqYN1drAfuxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfdFzrZU; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7dbec19732eso282915a34.3
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 20:12:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778123556; cv=none;
        d=google.com; s=arc-20240605;
        b=HVcYBndAKn0D5PYvngKrQsz/b/VXMrRx+dtGV6nrAzaQV1XUvkIfE7mv7d/S2Hwy4L
         fDjaP+Hc3RgfasTk9trD4QjSKzYr0jRiHEsNHD7fyFJzFO5MPUiSwnaIGLfD/WHPc+KO
         2L/udcfmUhA9YwJsVac6ZWaE6q76Sq00oGJBZFp97i8+nD5hE/03ZRFbJWvw33Q/oViv
         IP/meSQIhNojUZeDj/bNLi+3eEgDM6dbGRjFOuYdT1esmRt6aUhpeeSt9HMSkU7aiwLJ
         yEWhsY4FpK4gNjWI4UQwkLTeu7nQgXQMeFWBDxIAAo7H5PnjaKzBVSc6CLnzuA+z7DjN
         OIzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8s+sgSUpkyzy1t4IZ6P1H+j3krIb9xw33fvGDbko/5w=;
        fh=sa0LY2vE9y9xkMqaND7GbekOJRgA3esgoYAjYMZBkEo=;
        b=fJ7Ow8Faph5cMIkQST+yK7c51GNZOcu6IR7gr3JBH8aSiYb+Jy9EBQQAGW8zUpF7Xt
         04rsmimp7eCWIiSWs/LvMC9byf5pwpOY5QzWpDjIiEVPrUUtLW7soDYSR74+h8Fwwq2i
         heDZcVvDIZLgpxpyaMvdE3MmvdduUx9nbylu0HMzd+8wSDDnc2kSe7ZV09AgHZeZM9pD
         lD4CI8LBL4byZcgUjAWZKrsGCGDDB2QRCl5E4QNhsWUcdUmZbGP9wzqZKA76r2cmfMeL
         GjIklMPU9/PNYkR+HtcGn88oPXSAtCkYKTALCbuJfX2Zr95MA7e+snhDCk3PZmepSar2
         oY/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778123556; x=1778728356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8s+sgSUpkyzy1t4IZ6P1H+j3krIb9xw33fvGDbko/5w=;
        b=LfdFzrZUyzD5SWtm5Fz2AqwCpg6pvIlpi6kp49Bd/TidFo/9aE6OL3THUHctANGoKM
         RoUi0tDoTsTcYKXbh0AsFlwkMIH7dMSLZLdi7/l4R5MhW2/nvTltF+YiLY2Y7SIh+hJg
         BCvFg4h9/tii+caKw1yq/7BR0kq+qhdaFKs1RmdGxe2t0a4sjM9XMgQXWa8lQYI5lcHB
         ihXVHtciqvfZBqp4D8RqneVwvaOWkvpgCkPa0cURHZvKWgOmUX7ps9aa+SjqHPpEDEUa
         vjnHbsuoHg8nYGJjZkUcc/Z279Rditp4cJPYR/nbYIcfFbWhkr2LuFdeLEDI/Ywvbj2d
         hReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778123556; x=1778728356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8s+sgSUpkyzy1t4IZ6P1H+j3krIb9xw33fvGDbko/5w=;
        b=MdUIvfbhXBBi4vqw61e4ln2dfz6xCF4RoksuZMUAn5BzB5t/HcvWK1era1svMzmeez
         1I0iCcNeaLQvEfL9eC7UQ0LbVxSu+RDADGLy5FnUynx3eq4A8DpkvKahZIQewV7z0P6U
         kJ/jUJOB1NlOSDyjYsGt/8ferwMk02+RTu7KPfTHqBWQfPIgcwTOQMCyVLy+9upaq841
         kwAI0PdmiToi22Z/Fxw/NabARDT9a444hqx7f67A7h6oUzE+wtUDZ5iD6FlUJ2tT/278
         YLx39sWISogiyLLJFqSzQbC11yYd8R8gPvPHdqR7LgyuRO3KtB7duR3vg1Mp+cA/G0XR
         O+Lw==
X-Gm-Message-State: AOJu0YzUQ5KQ6l/w3DXokhqeWb5N4M8iujVIMJoCw+UsTM0jtaFAETy1
	R++t4jPcr1vH1kwLpb8DkSbDn3KSOvH17D2BwObTRpo1nrzg0k+YzbcVolKAmHtbsNBeNVhX0FY
	0RybKXBzOOLsnnnGqynGgy2Ks2HA+yGE=
X-Gm-Gg: AeBDieutIWIaP9L8yqqpC3U4In+RLANFv0rdqYsb8hIW2AxeqVgfCqd0dy1jglKReem
	G81TJVllPuBeHKqOG7AgeyYTsJUfEkmvRJFQ5OZLDDHvTBSN7fvPMc7ks3OgjR4kcZnif7cKOMU
	E+Anm0CPJO+RE2Qf1EX/bK275xDRbwjeqhOjo2a3Uv8FsR9073n1W2rXlM9rGfAnYmjbDaWlyur
	0cA3T4FRJuHU8LIcJjoxA5zLkX/8yhFl++wYtnF68FUZ4QxjbhDHOY6ivz3xAWJh2/J3nKhXxK/
	yCzfAJzj+khC30liQfZ+DDM81pf8J9lSRmAQD6yrQMrUgbm9ntrBtLqPGfzN
X-Received: by 2002:a05:6820:220d:b0:686:d107:2856 with SMTP id
 006d021491bc7-69998d5251dmr3656437eaf.51.1778123555725; Wed, 06 May 2026
 20:12:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504101258.1608004-3-mmyangfl@gmail.com> <20260507012306.2187935-1-kuba@kernel.org>
In-Reply-To: <20260507012306.2187935-1-kuba@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Thu, 7 May 2026 11:11:58 +0800
X-Gm-Features: AVHnY4Io7tH2DZdfq5zzXT3e2RKqkbqnGO2JDlNxYdUTjM1Wr6KQ0-UdNZMlxI4
Message-ID: <CAAXyoMP3RNFWG+n39ZtCYb3Aq66KvpEjMhKr_2zU85mah0czrg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] net: sched: tbf: pass all params to
 offload users
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, jhs@mojatatu.com, 
	jiri@resnulli.us, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B5FF54E28E5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285136-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, May 7, 2026 at 9:23=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
> >       qopt.command =3D TC_TBF_REPLACE;
> >       qopt.handle =3D sch->handle;
> >       qopt.parent =3D sch->parent;
> > -     qopt.replace_params.rate =3D q->rate;
> > +     qopt.replace_params.limit =3D q->limit;
> >       qopt.replace_params.max_size =3D q->max_size;
>
> Does passing q->max_size here provide the driver with the original burst =
size?
>
> The software TBF overwrites q->max_size with min(burst, pburst) when a pe=
ak
> rate is configured. As a result, the offload API only passes this overwri=
tten
> value, meaning a driver attempting to offload a dual-rate TBF is not give=
n
> the original burst size in bytes and would have to reverse-engineer it fr=
om
> the nanosecond buffer value.

I'm not an expert on TBF so I don't know if it's fine to expose the
internal of schedulers to the drivers, also this would require changes
on struct tbf_sched_data.

> >  struct tc_tbf_qopt_offload_replace_params {
> > +     u32             limit;
> > +     u32             max_size;
> > +     s64             buffer;
> > +     s64             mtu;
>
> The buffer and mtu fields are stored in tbf_sched_data in nanoseconds
> (see tbf_change() in net/sched/sch_tbf.c where they are derived via
> PSCHED_TICKS2NS(qopt->buffer) and psched_l2t_ns()), but they are
> exposed here as bare s64 buffer / s64 mtu right next to max_size
> which is a byte count.
>
> Would it be worth renaming these to buffer_ns / mtu_ns, or adding
> kerneldoc to describe their unit?
>
> A driver author reading this struct and seeing mtu adjacent to
> max_size might reasonably assume mtu is a byte MTU and program
> hardware accordingly.

These are carbon copies of struct tbf_sched_data, I see no reason to
rename just here.

> >       struct psched_ratecfg rate;
> > -     u32 max_size;
> > +     struct psched_ratecfg peak;
>
> tbf_change() does memset(&peak, 0, sizeof(peak)) when no peakrate is
> configured, and the qdisc internally uses tbf_peak_present(q) which
> checks q->peak.rate_bytes_ps !=3D 0 to distinguish absent from present.
>
> With peak exposed to offload drivers, every driver now has to
> reproduce this convention implicitly (e.g. by checking
> p->peak.rate_bytes_ps).
>
> Would an explicit indicator such as a bool peak_present field, or at
> least kerneldoc spelling out the rate_bytes_ps =3D=3D 0 means absent
> contract, make this safer for future offload consumers?

No similar logic is found for struct flow_action_police.

