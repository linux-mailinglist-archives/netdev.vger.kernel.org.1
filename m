Return-Path: <netdev+bounces-293814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADJbJyWoHWp+cwkAu9opvQ
	(envelope-from <netdev+bounces-293814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:41:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6053D621EBC
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB4CA307B64C
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 15:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E708B3ACF1C;
	Mon,  1 Jun 2026 15:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bAjDP/ao"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C96F3DB653
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328013; cv=pass; b=B2iMXSxVdanBbEAb6vj7SOLjPWy+YDWzZ3NUyiaJYPIDYIDWNlAleq4FIanNxEREmhf2Ft8Hj77WcEbjEGmVoihyNm3fKyhLc1jaF8KXqZ2qGxgk2DGziVGDt6OvMfTWZFEgy1VkX1xJZcm4QGbz5ilGpIYIQNlKb+LlYSov3d8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328013; c=relaxed/simple;
	bh=1PTgAlGAK5hfN4DJNf5K5bRNhI988IdyaMltcAq4Eyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQ8F8fTodoTyzco4QzzD0okVMA40drcGVgpj/Zrv5dVr6vBiJXoODctYeU3WvdvXrIzwltcw5JCKJb/hckvg8XjlVinekGabpUddguQxFTHIbUhJsJHQGFRbVDLKg/39TggDeHT10n31Hw8/4fWm8XsVUiRhdg/ZU8/bnxanW88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bAjDP/ao; arc=pass smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-91541fa94aaso255848785a.2
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 08:33:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780328008; cv=none;
        d=google.com; s=arc-20240605;
        b=kfSx9mhrywB4/tHhT/1gwwgYN5hXJ7DHAIqmkqElRTsS9FOz/r/DykFipzpm6yZAKf
         1dm4CgUBW/Kke1hbFVC/DiVZuOnJTTG4LroRpURMOI/K43Muxi5azV1+2X/0y8s2jHX7
         TUiB7XvBEIbLjD5K3/5OFuqM0XgVE2ORe0uyL/PVGoM44ho0yJkOBiowHxZFgxphaPtR
         AmAloRQ1khHETlHWo1c267tS+DErLJv2+5Ku48oK3ryWi07aOlwFVQq7wEhvXaF079Yw
         phGInF85JuLy4h68bonert3KDmP92sgsznMDO9JZdSM8HWFTxmpwaQ86mGUpBw+71YrJ
         idAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UbQdOtpzUbEPtjqvjWcm+pIPF3+/nTAYsHR+hxfI1fk=;
        fh=Z6fKtkvgBzb2MkCka6TRCitWBkFurkgP5VbCYdYKmi8=;
        b=ZCHOfIRrqsV7y5C/WpPO/pviA18WQEHNRKE0YIbA6qXq5XRHUk6cvWlgNZ2kpCja1l
         QIiOQsje3By35xTCVRqDdxUHAtsb5ESReccfQLqx/jbWZTS/Edsq080JiLgACoaMBpEi
         jYRq9mJ4SECzgJobG4AqIF+zj/U5i6wI8Qd3gKD4mJNZApX25DbSz3KCNEs2VKBM9Coe
         p34+fFIF/xkEefPmlwc4hna/0YZKSSBsmp20YJye6fQGN7xb3Pd882ID01SRtxTUwa9h
         WvQrfq9Gr8kDdIxRTWysPKth/HEea3kkrCmyUeQVhZMdVH8pVkCbjdHOG4JH9ltC3O5b
         r7ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780328008; x=1780932808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbQdOtpzUbEPtjqvjWcm+pIPF3+/nTAYsHR+hxfI1fk=;
        b=bAjDP/aoYXAEcC1ZQFFf5xeSZFT/zNbLTYWPei5d7l8S95mB3hYyMJog3ou6gukxQZ
         FH2ik6UGPPDQlSYcBmG3iAsjuFO29Cumu3aFg/sncAKtGKW3nFxIP/U5kkchXG9nimvW
         Dnv9nutSBTHU0Kxt0seQaEuvFvIuWvZ8GIVsxYrRhbacm299FwoyCPe2aqiRtDvC4qdQ
         fmP/DfY54RTyrgwhpNUAEG19lFij9HAbitpfLfYjujN8CNJMdNb10ERVslvt3TDchcpJ
         4vbrs8nzdso0oxLbDnxKyC2aaIrpHOddrJrcaWEJczXa5bYl5lt5xSz9OPsA8jHZGSZN
         0gYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780328008; x=1780932808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UbQdOtpzUbEPtjqvjWcm+pIPF3+/nTAYsHR+hxfI1fk=;
        b=e9hF/T1w8mgcDjfQq/JawJaL8FppmDU/WeE8eyi8fXgCyUO2DD2ShZdnwKBj/wawFE
         Lx0Oz76icQUwkToxHrwk90PVa+I9he4BrHifNZmRuVYKaFRUDSLp6gUJ6h6HYg0TxjnL
         dPrnDwRL0WotVML0Z8m2G1IOg62LRG/3eASG4jObLvv1Q3gSK/RM/oEsbIbqPd2cFBIj
         7F+RtCZIPNcIb7lgyh1F98bdw8PXR7X7KrdVACs6Hyy5vFik9cqmF2Sq8jvrU8Rceil1
         UULTun7ArTZDuk/0sy4AnkeAb/omaDtEkJRm02CnD/J1RdmDaR7HURZe7XPicVeO7d/L
         QTVg==
X-Forwarded-Encrypted: i=1; AFNElJ/YcX2RjSo/+w/zNSMrYrSBADDi9THADpkdEbq9Fvs7eaqYateTn1VK5avpFTDEpofGsKiEXlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbNdGbHQx9nVhzE3PmwyFQzx6tXMLMfvtojpL+iG7OBdtfRzae
	nAluC+qiZObjSxu0INDH+Zc2nOw7TY97y4qgc6nHmuWWCamK0gmFp3OTYv/pacEMq7QSyKEw/Bf
	yL6EISns1aPc8V7eepYddJDVhju8EoVrocJxKu1oV
X-Gm-Gg: Acq92OEOioQxqFuv0F/NImzlOghq1K3ANKtWv3rIZ3m2OMfyNYJSv4Uhw4EZrprpvln
	tr8/g/lwiJYiPQyUYbzb6QR34K2phWby7gP9RQTzoad/UXPgUCUpwpOpXabU38VDU9AFkyCN9dn
	yAFNXSppgran56k7+Yg+6FtavmmbyqR1Fg6b581x6T395NY9Gt/TXF4MiU3Z80etRRLDG47OvKW
	J2FskwOt9pZvhwluTCpLscL1G1MizoMkvmQm3FQz5X2AsQw1JTaaDrC43UZTRXEPNQ/FjrbGd/j
	GwYo1tPQ7SFzoMNKLbSEY7YG1WLzGOk6wdsO5DHqc6N+u0SOC2BrK6VM+BC2qnR5cFj8Ry7c5ix
	TWODRWKaVwEMRENQtpHAweUX37mh3
X-Received: by 2002:a05:620a:2406:10b0:8f0:5e11:d201 with SMTP id
 af79cd13be357-9153d93b22emr1342049085a.12.1780328007727; Mon, 01 Jun 2026
 08:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601150203.20352-1-leon.hwang@linux.dev> <20260601150203.20352-2-leon.hwang@linux.dev>
 <CANn89iLJgBxx=NaZDHy4s1_U9LKp9dqUDd1v9LR3CQPNo7DxEQ@mail.gmail.com>
In-Reply-To: <CANn89iLJgBxx=NaZDHy4s1_U9LKp9dqUDd1v9LR3CQPNo7DxEQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 1 Jun 2026 08:33:16 -0700
X-Gm-Features: AVHnY4IsIkxzqxpucMb62Vf6bTc3GC9Y6wluDi7tPS--FKnWGOygHAF98fTYzks
Message-ID: <CANn89iJ3XfvAeEa90gTPXgfz5hJNEd1gEdH6sTubZ2k9j4M+2A@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: Update transport_header when
 encapsulating UDP tunnel in lwt
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Guillaume Nault <gnault@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, Peter Oskolkov <posk@google.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-patches-bot@fb.com, Leon Hwang <leon.huangfu@shopee.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293814-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,gmail.com,iogearbox.net,linux.dev,nvidia.com,suse.de,google.com,fb.com,shopee.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6053D621EBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 1, 2026 at 8:28=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Mon, Jun 1, 2026 at 8:03=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> =
wrote:
> >
> > Currently, bpf_lwt_push_ip_encap() does not update skb->transport_heade=
r.
> > When a driver, e.g. ice, reuses the stale skb->transport_header to
> > offload checksum computation to NIC hardware, VxLAN packets encapsulate=
d
> > by bpf_lwt_push_encap() helper may be dropped due to incorrect checksum=
.
> >
> > Update skb->transport_header in bpf_lwt_push_ip_encap() whenever the
> > encapsulated packet uses UDP, so checksum offload works correctly.
> >
> > Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_p=
ush_encap")
> > Cc: Leon Hwang <leon.huangfu@shopee.com>
> > Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> > ---
> >  net/core/lwt_bpf.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> > index f71ef82a5f3d..65d1dfbf3312 100644
> > --- a/net/core/lwt_bpf.c
> > +++ b/net/core/lwt_bpf.c
> > @@ -599,6 +599,7 @@ static int handle_gso_encap(struct sk_buff *skb, bo=
ol ipv4, int encap_len)
> >
> >  int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, boo=
l ingress)
> >  {
> > +       bool is_udp_tunnel;
> >         struct iphdr *iph;
> >         bool ipv4;
> >         int err;
> > @@ -612,10 +613,16 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, vo=
id *hdr, u32 len, bool ingress)
> >                 ipv4 =3D true;
> >                 if (unlikely(len < iph->ihl * 4))
> >                         return -EINVAL;
> > +               is_udp_tunnel =3D iph->protocol =3D=3D IPPROTO_UDP;
> > +               if (unlikely(is_udp_tunnel && len < iph->ihl * 4 + size=
of(struct udphdr)))
> > +                       return -EINVAL;
> >         } else if (iph->version =3D=3D 6) {
> >                 ipv4 =3D false;
> >                 if (unlikely(len < sizeof(struct ipv6hdr)))
> >                         return -EINVAL;
> > +               is_udp_tunnel =3D ((struct ipv6hdr *)iph)->nexthdr =3D=
=3D NEXTHDR_UDP;
> > +               if (unlikely(is_udp_tunnel && len < sizeof(struct ipv6h=
dr) + sizeof(struct udphdr)))
> > +                       return -EINVAL;
> >         } else {
> >                 return -EINVAL;
> >         }
> > @@ -637,6 +644,10 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, voi=
d *hdr, u32 len, bool ingress)
> >         if (ingress)
> >                 skb_postpush_rcsum(skb, iph, len);
> >         skb_reset_network_header(skb);
>
> iph might point to freed memory after skb_cow_head(), leading to UAF in i=
ph->ihl
>
> This issue is already there in the skb_postpush_rcsum(skb, iph, len) call=
 above.

Ignore this, I missed the context about iph, which does not point to skb->h=
ead

