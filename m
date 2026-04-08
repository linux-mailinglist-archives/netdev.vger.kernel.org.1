Return-Path: <netdev+bounces-276208-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PyYeA+2a1Wni7wcAu9opvQ
	(envelope-from <netdev+bounces-276208-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 02:01:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3231B3B5966
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 02:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02E8B300FB4D
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 00:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602FA40DFB6;
	Wed,  8 Apr 2026 00:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Knk35dpx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05F710F1
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 00:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775606506; cv=pass; b=lNogUnuUy5kujem7/x6+3I+LJioa3BCz/1bxDMi520omVfxs+maBBfmb/TQQJdG1FnNd2QpS4OOUSRS43lPB1IBzxKxB0MRwMMB/aNJJzKN2ir3GP069yyaxDgBSkmlw3br81dFWiKpw7K1kFu1SOnoyyP9wGCzUXEE4UpwSwqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775606506; c=relaxed/simple;
	bh=xizV81PBD/HRJtwvIS69T38/iGX4WO3eJxiKp3abKjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTwQMzGiJlxf8BxIUUDeY5JUufSqWNLxL52X0f/7Ulg9QZVy5MufTtuQcKdtGonJuXXKdxA+wF+XlZKmfWE48M6XIKxu535orCtTKcYVi0AdLeFCt28UTvmiPZQN0Vl65djRYJpubNnIsDPEIKpABv/LkM96NEPd8sf3UPVcmPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Knk35dpx; arc=pass smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-68240e0d925so116584eaf.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 17:01:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775606504; cv=none;
        d=google.com; s=arc-20240605;
        b=Y5IJUMmXiCOUy2S68XGJPTZYy26Du82MtmTHqHdF6oCCzsKEFpNcF8/8axu4sr3dGg
         PGFs49fUH94zm/+JiPLeAvHXkS6ARvPxt8k8pkMyCaGyguiI0zr4eXgeizIUyeH1k2n7
         QRyVIM5h/eTpyt1HH548G8FCzak7tdFB5Uw8PnwAuXvqbPvYaT9r+z75k+wlz54TvwT+
         WrJmenZmM3b8PRfZbdY/emTwuBAzsSgoQH9sqbIJTLrDUVWyBakshlWNZvZxFa423Z0d
         RFl8K23k83Dt1YdqjWE9MGkfcs7190o6DfG6YELkMfnJfE/Ps8DM8l9U2REkIs8W+eYT
         raEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zqWBHbwGA6KKL3R05G8g3BYmmPEu0qU934/zMvJBkGI=;
        fh=H8c9WxbJiTCOeqRsgzc/2tlfc6S4phJdV26sywHRpr8=;
        b=cH4eOEwGmwfNvSj7MZqbWa9rnSaFLT7bBrqqQuf/Cc2R4obyfcO+n6v/80hqL1KXe8
         IG1Hvq8/N8pGMShp0WxF9/VSxUI9DcPkBiyKguTmiKhsmUHzUPgxksEtzNdzBXxSArgM
         SFZYmhNTF2S88czWEFvN6oYiqeWdZ2WPaaBMlzJTg9dYJUDQokkuUK/GszRk+tQI+Gne
         UcXIBP4AvvGWk+Hchdg6vBVhuAi1u1qFOK7pbVE0DAU0Z5WtuHJX3zVc+ohxgtef1dxZ
         8978+gehwS9cUCnPzIcZf1dwzYv5fVWpVCIwlMY3OdzvkKJh7KtFQ6UN/TYxZJiSArou
         690A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775606504; x=1776211304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqWBHbwGA6KKL3R05G8g3BYmmPEu0qU934/zMvJBkGI=;
        b=Knk35dpx4SySPSeG1We+jcngUiovWyUQ4kv80aRD3SygUqy+ztjThvFQsIXEiaraRb
         SufOrcCr+YbedZj87UQsBzQrJwOW7Tn7kTZPzqMQKbu+pvPPbf8LC/VGp/2j5CbkY1ie
         W7LShmRWSBSV7Ai3p73pTIzGa0Hq7e4YTEXP5KXu3uXqn4yK0t5jDG2dWLrIxjIKQfZv
         B5Gff3jXcU1olzL/WB5GGSQ+CDOv0zwOhCwgTGYuqXry7KW3Ju+sBvZgIUsr24lb379/
         FDirOu+MvAnAYpMjDahATuURDFmwgzzojiv2OQSCfMa6DnwmqUlY7N7ofN5ECSJFdlW4
         6c/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775606504; x=1776211304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zqWBHbwGA6KKL3R05G8g3BYmmPEu0qU934/zMvJBkGI=;
        b=fyWnYePTAmhP7Ta859tAr8adUmOQ1pU9S0TkqU+4TWwGyIuA8bzh00Yfc7r/qClC7V
         d2P7fWrZHs7cS0wL4lm+cOrZ0nAxajo56kPr0t8ZUd2rhLP2pEAahAqHOuAKvXw/rtMA
         JvHdUknBh1bV2nThf+AnayVokCLUeOcpb3tJ1QYC3S4Xn/GCVtdaVOT1Su5rtohMs1P0
         NGd8UQXGB+B6IlAVd3bq5gAPbWt5UAELAvH3NwQDt4Z+7Ndw8Gv0kEf2GLpteLO1cXGM
         X1VsxVkIr9hfcxMvRuybTdPsm+WoB5hWpohVm0QjBWWBB7RpubbCvt4ABzD0Lw3TfMG/
         fC1A==
X-Gm-Message-State: AOJu0YwBjJAaz2noiRRD8o54A+VQ2TG2qhDm/SZ9UgkJ5lwXgfMgbSp4
	hrpeHVtJJrgVkuBNaM87zEvO/7KO2neHTmPxbIwIlyYr7mv/cjmSQDNy8aQv8PIN/Xx0TZ4E+w0
	Jx1Zff9VcnkXJous7HEb0hQipVOFQ22k=
X-Gm-Gg: AeBDievwhuyNEIlIBPvs0cuQBW/YqxX9D/CcuQXffTz9HMUY5OMCDU4HjTBpuKUciVs
	/S1x/0FyvZAatIyGwEQlN981N4MC9vFTrJCK5+lgkDQH3Fvf1Ic3gZaMuKWllZmkCVtUXStFXDK
	daSkccbivE68UDWygcj8BLxhtzieVx4C80ESaMLpLqcMwVP7ZTVxz7jrl4cp4NYBhFtXP1MXzen
	z4uaQ8O96ql3fKMPXd+4a5gjmRJQtVryd6JUpZRwo8trQA1iXX7qHBDMjXkv8r8ap8EHJgbDavZ
	VMvVXYFmOZiNkFOICLEK
X-Received: by 2002:a05:6820:858e:10b0:67c:3021:908a with SMTP id
 006d021491bc7-6821fa67067mr4495356eaf.3.1775606503679; Tue, 07 Apr 2026
 17:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405055853.3285534-1-weibunny.kernel@gmail.com>
 <20260405055853.3285534-4-weibunny.kernel@gmail.com> <c502c837-6f01-4854-bd6b-e81aba940dc8@gmail.com>
In-Reply-To: <c502c837-6f01-4854-bd6b-e81aba940dc8@gmail.com>
From: Wei Wang <weibunny.kernel@gmail.com>
Date: Tue, 7 Apr 2026 17:01:32 -0700
X-Gm-Features: AQROBzCuO4JpTsUv-gma0KK0J1BNF8R_7syFxtkngLro7UXD83dRnxrXKJMSx6M
Message-ID: <CAGqc4nUqtL634_iBSv7dNZfoU9SWjgZHWyO66V0aAK=ed18z=g@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 3/5] psp: add a new netdev event for dev unregister
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276208-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,fb.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,fb.com:email]
X-Rspamd-Queue-Id: 3231B3B5966
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 6, 2026 at 7:12=E2=80=AFAM Daniel Zahka <daniel.zahka@gmail.com=
> wrote:
>
>
> On 4/5/26 1:58 AM, Wei Wang wrote:
> > From: Wei Wang <weibunny@fb.com>
> >
> > Add a new netdev event for dev unregister and handle the removal of thi=
s
> > dev from psp->assoc_dev_list, upon the first dev-assoc operation.
> >
> > Signed-off-by: Wei Wang <weibunny@fb.com>
> > ---
> ...
> > +static bool psp_notifier_registered;
> > +
> > +/**
> > + * psp_attach_netdev_notifier() - register netdev notifier on first us=
e
> > + *
> > + * Register the netdevice notifier when the first device association
> > + * is created. In many installations no associations will be created a=
nd
> > + * the notifier won't be needed.
> > + *
> > + * Must be called without psd->lock held, due to lock ordering:
> > + * rtnl_lock -> psd->lock (the notifier callback runs under rtnl_lock
> > + * and takes psd->lock).
> > + */
> > +int psp_attach_netdev_notifier(void)
> > +{
> > +     int err =3D 0;
> > +
> > +     if (READ_ONCE(psp_notifier_registered))
> > +             return 0;
> > +
> > +     mutex_lock(&psp_devs_lock);
> > +     if (!psp_notifier_registered) {
> > +             err =3D register_netdevice_notifier(&psp_netdev_notifier)=
;
> > +             if (!err)
> > +                     WRITE_ONCE(psp_notifier_registered, true);
> > +     }
> > +     mutex_unlock(&psp_devs_lock);
> > +
> > +     return err;
> > +}
> > +
>
>
> This looks like an abuse of the psp_devs_lock to provide mutual
> exclusion on psp_notifier_registered, which has the undesirable property
> of establishing a lock dependency from psp_devs_lock -> rtnl_lock.
> Perhaps a dedicated mutex would be cleaner.
>

Ack. Will address in the next version.

> >
> > +/**
> > + * Non-admin version of psp_device_get_locked() + psp_attach_netdev_no=
tifier()
> > + * only used for dev-assoc.
> > + */
> > +int psp_device_get_locked_dev_assoc(const struct genl_split_ops *ops,
> > +                                 struct sk_buff *skb, struct genl_info=
 *info)
>
>
> kdoc open, but not a kdoc comment.

Ack.

>
> Minor comments, otherwise:
>
> Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
>

