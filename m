Return-Path: <netdev+bounces-273763-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJzuFFNCzGm+RgYAu9opvQ
	(envelope-from <netdev+bounces-273763-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:53:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DAC37237D
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DEE9301049B
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 21:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FA24508FB;
	Tue, 31 Mar 2026 21:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+G0r314"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85263DBD4F
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 21:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774993747; cv=pass; b=YE2bvy1UJQZCSTueFsSrTPzddm9Ys5vvjbQqfvjzoL0Hd0+1XgXrdiGp8jsS8ryse4U6H61tF2zeKY40YTkBOe2tLJpVAv55g7WDHwCGFD7kBlIqAPy9xEo40yj87CTUIbLNGsRWeduIXMo0KIpcwSorah8HKFcE/kTgMlOlDwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774993747; c=relaxed/simple;
	bh=jvlCLFcPse4SaHbyz+HGzGo6wtgSiLnUmm1YWYaw9Go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVPiCyZa2xxyNYzaUcT3D85NPfRaQWo0kwsVolGAVxhWf3b45piSWhTZTVOd1oQQut8FSWgVa3/iNnTXAYKMicvdNfPfO2Jy17T2YTmZsmagFcyWspS7+qsFw/68Hc7SW3621hb6zIPDNK/oE3B2R5mUk29sur0WCcpy2sYsrwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+G0r314; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d743d94d5eso949016a34.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 14:49:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774993745; cv=none;
        d=google.com; s=arc-20240605;
        b=Q8l6SoTzexbbselt5MZzgUJEDC3e8ntvlHcEWiiUwZZliGSXanDeeD16E8iFSPhM2m
         OQ6OnIddyb8wzFlOBHlAFPozhNSuDk+rGAhg5AWadgq3KIZ0VO4WcOYn0PscqCsDVWY2
         Z2gaQXwvfczlE09Y+CFM9Wdj5+sIHiZ/NVPRLDEwHGDJcApf/jQ3O6cNf7s8eRGHw4sw
         qiru2sIhLXO8FiZjfrQxxL1ouADj5zB4iPlrKL+sR64BOv8zJHryT2HvM85Sl3Cxssd4
         9WLrcWIqVBQn+fhjgt1Fd/Rg/9W/pwACeuwh3vVJ7JEw6CATQ7h9dzOzaPGej5ijYi+q
         2k4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=npJdhse5lKdrUnP/HJ23u6qxKowm2LM6hD6XwJb4G28=;
        fh=H8c9WxbJiTCOeqRsgzc/2tlfc6S4phJdV26sywHRpr8=;
        b=U8mtHhluxlSBnYjzGG+fsh/ZHkgf7vOzN0KlmfND84KS8Q8GItTbthih6x+Ga+/Ws8
         5BXSiUlpKimPNpYXcLcVGSbdFAsf1l4TsJncI7aNQWEy2crqOJ5rw8kY9GSUtcD1UuKP
         fwfSHDzzDSM5umYPZGPqO/EvfeG0Tg5oI2glbvP5u+QOAs3Z3miPFFZz8070d2SF9yGK
         vVV0EXk1RNCE62FVlbaewZv9pv6bFwNgEdbQoCjg2LHBxzdBZIfAo+2+PIxEreQxBb60
         TeHe6EF2q+mn2QnjtidAFu7WW9RRJ0qDKC+IrisikS3MR8pT8MPCjyp4orLimALCzaeY
         FMpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774993745; x=1775598545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npJdhse5lKdrUnP/HJ23u6qxKowm2LM6hD6XwJb4G28=;
        b=i+G0r314n+rlQSFGPD/Ke+8gm3ejXaR1GpL4HivbBUeUwsn11ftEVSJr6nEtUpyLcx
         +KFNA3wsdQ4HzHefzR4l0jgwEMuZi/utUUcDh60R8s1JFZEskVO6/cInyXfzzzL1reDJ
         qtevwPyHH6vIZl4Nbo/jagySsrDYYfLV6fG600qWEcI4yw/PmjBjy18hv34bqAkS1fSg
         3n4YqJJz5ZbYRZWsq5vZbaGG7awmT7ks0g9LM4YXsQRuSom+eFkR1QsmM1um0IeRToqU
         F+RK1sksui8RJQuLBPY/KJEJlRxCIhsTwVnFqjQd3Jbne3cBIMysLyCbwRojnVHpD+uO
         +EmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774993745; x=1775598545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=npJdhse5lKdrUnP/HJ23u6qxKowm2LM6hD6XwJb4G28=;
        b=EI3DwnIxQ4c7V1gxaPGHjDB2oWgVVmaLrtsf42syV7nptkyKscH9qbktjDtcOwuQFa
         rpoWSNGp7FHfWcoUD5nXgwxJiNW1jDTabVfUwP90jzfh7roXromjnZFGiYWMPCf+uEeU
         /uhLMJNds2ywi1s7aL2YATIF7yDWn4QVBD2UleadTEEuS/EF7MV4AgW4QCOdPG4VKu6k
         V8khM1nq8vb5oH6/bbj3k49wvGe52XXUansVeuV3Elo5kPjTUM6+fz2IxytRjR+uPI6f
         8y20FEAb3mab5ZM+oTMxlP3d0zQGVQ8I71Cgx0yrZ3HwW27KCrUt62Bfb187Pz8CONT9
         R01g==
X-Gm-Message-State: AOJu0YxKuDHzKnTPAd62xt6/VvHDtsTJqLsjNkv9UNs4NRBU+2ZDMV+i
	jg0/AHOCknbfDEUREuufNNHYF99SLSIoRmZIFXN2Q2aD1TDUiEq46+Rb4V0MWqnlz8QkACbKDL6
	wnLHRjXhREmO+6Pj+mMgpzd1CDij93Qk=
X-Gm-Gg: ATEYQzwJ1hDd7+/ejmUq+fmhpV9C6gVwwCU32qfIdpRCMSipSMrb5X4ifZw/WmmwgDz
	6zASygbtOTLIloB3dsp8JqsnS4uW0+UEcU/JnRcMiLQLTzW7xgSk3TJ6lgDoUscuXEuOrbpo/t1
	W/6JW3iNccEPlgXF/k/f/7mbA78Rt2EL6uuknjwN+WfvLN4AalSDwhYsJ+GZuX0Tc982vSd+wXX
	e5P2JuDiwvml/z3lv9RUuUwWURlBrtCQDqj2Ijne+cO9w6uVav7VA4Bh6dVYxRBKkPgVQer8kWZ
	RkQlH9QnTkDkq1e+
X-Received: by 2002:a05:6808:178d:b0:467:2509:c1bd with SMTP id
 5614622812f47-46adff5aabemr447459b6e.2.1774993744793; Tue, 31 Mar 2026
 14:49:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330223143.2394706-1-weibunny.kernel@gmail.com>
 <20260330223143.2394706-3-weibunny.kernel@gmail.com> <a9c76822-cca7-4108-9395-4af6a4ff1eca@gmail.com>
In-Reply-To: <a9c76822-cca7-4108-9395-4af6a4ff1eca@gmail.com>
From: Wei Wang <weibunny.kernel@gmail.com>
Date: Tue, 31 Mar 2026 14:48:53 -0700
X-Gm-Features: AQROBzA5TZoIYqwn-yyT7s1VBbOEvElHeLYUwu4QjT0QCU8kiwUpL8sX8keuEC4
Message-ID: <CAGqc4nVWukOMcQKEmdZyFV+aukp3w5cgcFSvT7HYTp1+Fa94qA@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 2/5] psp: add new netlink cmd for dev-assoc
 and dev-disassoc
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Wei <dw@davidwei.uk>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Wei Wang <weibunny@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273763-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,fb.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6DAC37237D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 6:03=E2=80=AFAM Daniel Zahka <daniel.zahka@gmail.co=
m> wrote:
>
>
> On 3/30/26 6:31 PM, Wei Wang wrote:
> > +    -
> > +      name: dev-assoc
> > +      doc: Associate a network device with a PSP device.
> > +      attribute-set: dev
> > +      do:
> > +        request:
> > +          attributes:
> > +            - id
> > +            - ifindex
> > +            - nsid
> > +        reply:
> > +          attributes: []
> > +        pre: psp-device-get-locked
> > +        post: psp-device-unlock
> > +    -
> > +      name: dev-disassoc
> > +      doc: Disassociate a network device from a PSP device.
> > +      attribute-set: dev
> > +      do:
> > +        request:
> > +          attributes:
> > +            - id
> > +            - ifindex
> > +            - nsid
> > +        reply:
> > +          attributes: []
> > +        pre: psp-device-get-locked
> > +        post: psp-device-unlock
> >
>
> Not sure where we ended up on the netns isolation model, but I'll just
> note that these ops are not "admin" so they can be done from any netns.
> I don't think that's an issue per se, but I wonder if someone with a
> different use case will come along down the road and want to go for the
> more restrictive deployment option.

I will add a note before the function definition of psp_device_get_locked()=
.
>
> >
> > +     list_for_each_entry_safe(entry, entry_tmp, &psd->assoc_dev_list,
> > +                              dev_list) {
> > +             list_del(&entry->dev_list);
> > +             rcu_assign_pointer(entry->assoc_dev->psp_dev, NULL);
> > +             netdev_put(entry->assoc_dev, &entry->dev_tracker);
> > +             kfree(entry);
> > +     }
> > +
> >       rcu_assign_pointer(psd->main_netdev->psp_dev, NULL);
> >
> >       psd->ops =3D NULL;
> > @@ -361,5 +381,4 @@ static int __init psp_init(void)
> >
> >       return genl_register_family(&psp_nl_family);
> >   }
> > -
> >   subsys_initcall(psp_init);
>
> nit: spurious line deletion
>
> > +int psp_nl_dev_assoc_doit(struct sk_buff *skb, struct genl_info *info)
> > +{
> > +     struct psp_dev *psd =3D info->user_ptr[0];
> > +     struct psp_assoc_dev *psp_assoc_dev;
> > +     struct net_device *assoc_dev;
> > +     u32 assoc_ifindex;
> > +     struct sk_buff *rsp;
>
> nit: reverse xmas issue
>
> > +
> > +int psp_nl_dev_disassoc_doit(struct sk_buff *skb, struct genl_info *in=
fo)
> > +{
> > +     struct psp_assoc_dev *entry, *found =3D NULL;
> > +     struct psp_dev *psd =3D info->user_ptr[0];
> > +     u32 assoc_ifindex;
> > +     struct sk_buff *rsp;
>
> nit: reverse xmas issue
>
Ack.

