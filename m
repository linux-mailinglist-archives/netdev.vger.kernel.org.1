Return-Path: <netdev+bounces-271841-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGVsOF7CxGku3QQAu9opvQ
	(envelope-from <netdev+bounces-271841-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:21:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5141C32F52E
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25F6D3035A54
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 05:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213BA285CAA;
	Thu, 26 Mar 2026 05:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAT2SzVH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58DF1624DF
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 05:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774502490; cv=pass; b=I3UxPUEnvAnmyHk6f3NSlJulrKd6rqvQ9ArbVp/FCPFYbyEmet3bpkAlDonX8xKLocLPTJS1FBwQAvqMZQcAe6VfSmCLbmIfeOt5YOQgaZRzsckEYi7vhbq9jMWwsaaQRk7INztge3l8cmAHORZJA0DLKe5lWXXqYULhNAI+Als=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774502490; c=relaxed/simple;
	bh=WmoygiK4mswoxU4JfUsDPkIVpH2z6nQI9DiAElLfl4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FbVWEJ+9fH2davkc557Zue5lCJX0UQqXlsxtthLu8svkvBTrwc0FAZ/dIXm2Kb4HKEEVBY64cxEEePmUhtGmiOeS5X78WdJTL7yLPfr88gnat/WvyyNiTLMXvHQp/iMVTprtCpzc40EJvL/rWCk9QBjksXuI2QA+x6NGzV/LVxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAT2SzVH; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-41c47bc8052so82156fac.2
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 22:21:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774502487; cv=none;
        d=google.com; s=arc-20240605;
        b=HryOleAuVsTk4iFrYdZLN+mz8V7YHln9RCyr1ftW1B9gZK8xO5VI/FvPNAaSsjubhh
         VMAmF218Jg1qzQ2tV04B0B2cVPjLNpLBa49U1Kw8TWLhgAtGqiQaK0hKvE7w7X/QZzu4
         ktaXR/cdjeQmw44qkXJregtMTvgVenmCj6igaUpXqP3Pq9RLB05dWaIfoe0wJ2yhl1Tx
         Pt6D+6XdvATYD82+nV8Dqo58K8977cxLhDhMK/xMaw//14aQjMaWlxnkvVDjYoz9taiv
         1YLOIkhVqooIoOkJROEzfgkzq9oi4eunFrPv7bUcjIrv0Pj4gcpwH96SvJ5Qoe628Lx4
         VG+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ROmhNL6XaP6ecKz0U4FWDJzVQ//DRmujBmIKW3OH+9k=;
        fh=Hdt/E4Liw9xVY3BfZAnJFRdU7viIShcMAgqezFGUvzg=;
        b=U5uGrR0lRjqC7KJX045vMMj7Th84iYFkxQPrDgNcP5MRqiRAdC/JSqvi1Z+gmuf+ne
         EJAqcQXpi5FZw/hTN7QifCiAU53/75HW0FpsDz1IDCRvK/ejcCC6N0HX9SpwA4G+SJcU
         vGnt1oNb+hIzNoJcAOfyb1JGdvBj4MzXGK0SBGuNR3HME+UFC6AD85XhXfvbZYpbR2xT
         An2jUWuk+LCKxlBYQySJJ8F0kbJLwOuLw0fB9WuQ3aSrzyXz6YSbKnIT5wuYE+0L2uOb
         Pe3LTnvoL/rpiI5U21c3D2kPSWXFr1Ctzj6f1AVaTeqH8WoSj4aETkTF6+zRRyg5shaC
         1P2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774502487; x=1775107287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROmhNL6XaP6ecKz0U4FWDJzVQ//DRmujBmIKW3OH+9k=;
        b=JAT2SzVHmjuFOHEJQpo5TgIHmnJqSFg+yopwXYEcqrskPtVRyVXkMngV9617d+sJl7
         Tn8l4sp21wjcYPa8ass/2KAhsq6aQ7IRq6K2jjo3LLpZu1aDQKY6a7GucrgoC5Uf27h+
         JLRAnvpGXVO2jbK5ph0FXMOU1pMlxz54LPfDi9vpsnh8I2GgWv4wQ+6z1znY/Bxxbg1F
         IqNvH8/MgQZ4BjAcm1lkpi97LjmvoqRYa90R4eveby17hL4nECOr9p82qicOaD2oqa30
         EHCcbXPvQdHznVWNBNYb6z8/E8QXm+bMfXMJ3vUr8gBPPlq3jjSoVxki8G5x73wRYS8N
         hDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774502487; x=1775107287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ROmhNL6XaP6ecKz0U4FWDJzVQ//DRmujBmIKW3OH+9k=;
        b=KY7c+UewWL2qWpSeOWZosZ8PmU7dg960VFU71kZc0raX1Op44+GJAnglEshlZQmOPm
         j0ostukm/dY3g0sJ60Olp2SFpGCRZmuQCQ8FXEytjpdare2ciqV6qYXm8s7us8DSvGSP
         WEX8ZTuxH9MMQ/ixGuBnFkMThST4S3AQMLhWrL4f+E/4SckC6LktIw6JD5rYgXtyrUFx
         zRDTnR+FoKzenq79EVs1WAqUQsY+JLYHwPXmM+Boq6phs5NBtI189guK77S1Wyanpz7r
         TPml8hQcCVHmAZbqVy1m0ioqPHSVmwBmTIjThuDkO+WusPqLyrxoMO2TFLucFGdSY3HT
         QWsw==
X-Forwarded-Encrypted: i=1; AJvYcCWqmeTwIKb3Xq0WmjgEsWTslI5gxcmN3NF5H4B53CtYEd54rd7g1MEg5Xqdh5XimH3gsQBIKxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa4OdiF4mrrA1EF3e+XgrzRUkR8kwOWAaCSHS+2/LNhr8JgAFQ
	UgwtKZDci6iAu/V9tYMUPUDMkkPDpRbLIEoZa3nEFdYVfFM9e9ISOLVgap/YKmN8xUSEtwbicLM
	/WslirSfs2U9wVQayAQFBljA9iwYdjBbsl/nY
X-Gm-Gg: ATEYQzwzn1wWOJylSUiGNcplF4r82H9uCWvmpSd3NRGLn77Hk/QadV1RnBSyHbyeih/
	tNxRmVVCFuneOlOMFp6KoDvlV9VmNuLfwXy+c2m9xnrPYRgqOOWdlgN0KQqTGw2zgpLNQ0k+TXt
	oWT7booXCr7zMMPd9EqG40sYr5x2VkYZSRDs4kDcsGIl8BSQ9MIxfID8WOilz6M2VjMfe4GHcoq
	QU/OAERGOMjaFjcPmIwv146qp6o6XMg5kPZqLO4PRjiTHXrualzj/bN9DNs0PKVxECheSVPoH8r
	im1Mgg==
X-Received: by 2002:a05:6820:6188:b0:67e:8dd:8f05 with SMTP id
 006d021491bc7-67e08dd93ddmr918810eaf.2.1774502487470; Wed, 25 Mar 2026
 22:21:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322040704.991766-2-weibunny.kernel@gmail.com> <20260323182339.177058-1-horms@kernel.org>
In-Reply-To: <20260323182339.177058-1-horms@kernel.org>
From: Wei Wang <weibunny.kernel@gmail.com>
Date: Wed, 25 Mar 2026 22:21:16 -0700
X-Gm-Features: AQROBzCwMVX1-DTFMq6Vlqs1AQVVU_xNlryfLERtgoK1E8DP6XWYH5RWiWkwQG0
Message-ID: <CAGqc4nX7-8YFSxyoHbB_VPnqtEtMwY0u32XhWbhXPGtyEQJuzg@mail.gmail.com>
Subject: Re: [PATCH v7 net-next 1/5] psp: add admin/non-admin version of psp_device_get_locked
To: Simon Horman <horms@kernel.org>
Cc: edumazet@google.com, willemdebruijn.kernel@gmail.com, 
	netdev@vger.kernel.org, weibunny@fb.com, daniel.zahka@gmail.com, 
	bobbyeshleman@meta.com, kuba@kernel.org, davem@davemloft.net, dw@davidwei.uk, 
	andrew+netdev@lunn.ch
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
	TAGGED_FROM(0.00)[bounces-271841-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,gmail.com,vger.kernel.org,fb.com,meta.com,kernel.org,davemloft.net,davidwei.uk,lunn.ch];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5141C32F52E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 11:23=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> psp: add admin/non-admin version of psp_device_get_locked
>
> This commit introduces two versions of psp_device_get_locked to distingui=
sh
> between admin operations (dev-set, key-rotation) and non-admin operations
> (dev-get, rx-assoc, tx-assoc, get-stats).
>
> > diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netli=
nk/specs/psp.yaml
> > index f3a57782d2cf..fe2cdc966604 100644
> > --- a/Documentation/netlink/specs/psp.yaml
> > +++ b/Documentation/netlink/specs/psp.yaml
>
> [ ... ]
>
> > diff --git a/net/psp/psp-nl-gen.h b/net/psp/psp-nl-gen.h
> > index 599c5f1c82f2..977355455395 100644
> > --- a/net/psp/psp-nl-gen.h
> > +++ b/net/psp/psp-nl-gen.h
>
> [ ... ]
>
> > diff --git a/net/psp/psp.h b/net/psp/psp.h
> > index 9f19137593a0..0f9c4e4e52cb 100644
> > --- a/net/psp/psp.h
> > +++ b/net/psp/psp.h
>
> [ ... ]
>
> > diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
> > index 9508b6c38003..82de78a1d6bd 100644
> > --- a/net/psp/psp_main.c
> > +++ b/net/psp/psp_main.c
>
> [ ... ]
>
> > diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
> > index 6afd7707ec12..b988f35412df 100644
> > --- a/net/psp/psp_nl.c
> > +++ b/net/psp/psp_nl.c
> > @@ -41,7 +41,8 @@ static int psp_nl_reply_send(struct sk_buff *rsp, str=
uct genl_info *info)
> >  /* Device stuff */
> >
> >  static struct psp_dev *
> > -psp_device_get_and_lock(struct net *net, struct nlattr *dev_id)
> > +psp_device_get_and_lock(struct net *net, struct nlattr *dev_id,
> > +                     bool admin)
> >  {
> >       struct psp_dev *psd;
> >       int err;
> > @@ -56,7 +57,7 @@ psp_device_get_and_lock(struct net *net, struct nlatt=
r *dev_id)
> >       mutex_lock(&psd->lock);
> >       mutex_unlock(&psp_devs_lock);
> >
> > -     err =3D psp_dev_check_access(psd, net);
> > +     err =3D psp_dev_check_access(psd, net, admin);
> >       if (err) {
> >               mutex_unlock(&psd->lock);
> >               return ERR_PTR(err);
> > @@ -65,6 +66,18 @@ psp_device_get_and_lock(struct net *net, struct nlat=
tr *dev_id)
> >       return psd;
> >  }
> >
> > +int psp_device_get_locked_admin(const struct genl_split_ops *ops,
> > +                             struct sk_buff *skb, struct genl_info *in=
fo)
> > +{
> > +     if (GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_ID))
> > +             return -EINVAL;
> > +
> > +     info->user_ptr[0] =3D psp_device_get_and_lock(genl_info_net(info)=
,
> > +                                                 info->attrs[PSP_A_DEV=
_ID],
> > +                                                 true);
> > +     return PTR_ERR_OR_ZERO(info->user_ptr[0]);
> > +}
> > +
> >  int psp_device_get_locked(const struct genl_split_ops *ops,
> >                         struct sk_buff *skb, struct genl_info *info)
> >  {
> > @@ -72,7 +85,8 @@ int psp_device_get_locked(const struct genl_split_ops=
 *ops,
> >               return -EINVAL;
> >
> >       info->user_ptr[0] =3D psp_device_get_and_lock(genl_info_net(info)=
,
> > -                                                 info->attrs[PSP_A_DEV=
_ID]);
> > +                                                 info->attrs[PSP_A_DEV=
_ID],
> > +                                                 false);
> >       return PTR_ERR_OR_ZERO(info->user_ptr[0]);
> >  }
>
> This isn't a bug, but psp_device_get_locked_admin() and
> psp_device_get_locked() are identical except for the true/false parameter
> passed to psp_device_get_and_lock(). Would it be cleaner to introduce
> a common helper like __psp_device_get_locked(bool admin) to avoid the
> duplication?
>
> Reference: https://lore.kernel.org/netdev/6fde8fe3-1ac9-4a47-89f5-b6f759c=
2f103@gmail.com/
> Daniel Zahka raised this refactoring suggestion in v2, noting the two
> functions are entirely identical modulo the admin parameter.

Ack. Addressing in the next version.


>
> > @@ -160,7 +174,7 @@ static int
> >  psp_nl_dev_get_dumpit_one(struct sk_buff *rsp, struct netlink_callback=
 *cb,
> >                         struct psp_dev *psd)
> >  {
> > -     if (psp_dev_check_access(psd, sock_net(rsp->sk)))
> > +     if (psp_dev_check_access(psd, sock_net(rsp->sk), false))
> >               return 0;
> >
> >       return psp_nl_dev_fill(psd, rsp, genl_info_dump(cb));
>
> [ ... ]

