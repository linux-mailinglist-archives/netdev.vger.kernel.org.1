Return-Path: <netdev+bounces-265216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id R/8cNKC+rGl6twEAu9opvQ
	(envelope-from <netdev+bounces-265216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 01:11:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F66122E0B8
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 01:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22BEC300A513
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 00:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D501C69D;
	Sun,  8 Mar 2026 00:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XyaYMEON"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F52CA4E
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 00:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772928669; cv=pass; b=DhHlQR0fivRJIBnwNQuHtfT7ZJTynWqfGtthLij0u4PlEecM4X+En4wIC1/V/vd/yDq2NtsGrbOLHLqv3ki9uF3SdEFzCEJL5ojun/T0JFLJ8WpW32WOiigwQkfWz5wYNe2k1Bxe+rgkRuzAPD0rkIea1zQTjrytVtpCSx96gBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772928669; c=relaxed/simple;
	bh=9GdFvxs1zBruIJvbYM+kJM8eCf2rd9vbW2AL5glxbwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iE0fjRauFenplDyT/8jtVNnxUD77x3ln0wvj6aYV4CL05MEeSYFGkw2PfzyQSbmLAOYlstctMlIWT8VWwThYNEoCfE8vCEAakKIzTg/KCtyVdNgyaph+ykFCCjhXhIYVjRa1WBINZrm87XlLbbZm+CtEJtqU5x5FNAU0mo57LMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XyaYMEON; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-899e87b04d8so125702816d6.3
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 16:11:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772928667; cv=none;
        d=google.com; s=arc-20240605;
        b=Hb5w/9NJMhj0NycCyYKhbD5SbeklXFlftG1mXREdwEkQW+g3yGGbbCcTchiBg2hKWL
         PFanlA885NIF2AvBJC6vtyicQX4h4xKzB9gIwDcl2MqfoS1lwZ4FYO+EvwIcrjeVf75C
         4bwRs2n4fqfugOqqOeSxcD3SvQ7c3r0Hwe0t7d5tG7GY/wPH2bs0FuSNlq2ctI8lgzcT
         taSaGRcZeVfLLP4tii4Tq2Eti/MucmZzR8xUftr0JoALoifVII2D+eI+lSWAVFV47YKD
         kz/Oip+XSfJjuh7YtPbv9siJ1deBPm34o3CXRI2EMJiGIkwsaRzQbm1mRGhGMnmLymlX
         o8AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LDCYFlbrQs631z0N2DQeMX5BuDinoHdYzDFJt3mZ6KU=;
        fh=2aFPCFiK51ZeyOU3cr8RoBRcGnxMG0X2QmLUUmEDlRk=;
        b=X7ZGcJ4DAQu9gUMsIXyPNvgrG/s69XshVaPRHFj6xSIhoYyRIokqGedAdSGVLPKNU4
         eVpGCy1mNEPqR8DtfJtiyo/3kbmwSXqcZmylyTzMHcXfHuMA4wW/f/8+/AYWCusg2jkO
         UGDAxO/PXJGe95AeMz1aNit2UyotdWEY/17XV0ZobN/b/8qiHJ8Tf2m0hygo4qXlyYC1
         AtgNMnIxd8S4e6lQIQQ3L+t9HkR9yFCB92aC0mTRdWu6gCZEsDsQcvwz1gsNTmGHHvGr
         PDkkg9hhjIjPGcPxcEl/5DTqtgSlJIeJowjqnWEgIf0/PBvL8rXHZgpP2tyowaX61Oqg
         KWlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772928667; x=1773533467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDCYFlbrQs631z0N2DQeMX5BuDinoHdYzDFJt3mZ6KU=;
        b=XyaYMEONFNaXdsFWpumvYJnXVc2l8PV042CLr/UtMdEHY5F+hvzHpgL0OQUbvTVwk4
         HRgiligPJ46U01lMppEPza8/MIJhjOaddCcaaHyXsHEtgkOOf9YLj9VAqNkTqqrZvaA+
         1bhaiXD74sNAwmpbeV/kEoHX5ddjTFykWhN6Aqh4RLyd/qke80aFe/MO9wxLMLAob/zy
         0uALdtYYZ1Sv42WW12ZEUU3i4jmz6DTBhjoI7+vZ6mAEWSYe+DvKJko6+TLXB5Dtd1U+
         LEzVeOE25wnOYAWjubcxghj0BXB5ey4SAW3xoXMjBev9Dh1yjjLoufAgBvs9wUbTwi+8
         ygwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772928667; x=1773533467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LDCYFlbrQs631z0N2DQeMX5BuDinoHdYzDFJt3mZ6KU=;
        b=tMzo9efIiabXCz3WwqDcAvMrQttpK1/xsaU5D51Up9NU/70hR7J+55eZfmx1ipej/R
         6A8ox7AZcqAPtUqfYaftDJB9cBOZoHA7IC5g9XZHmtLipnWM7FpUzmcjVPfnvy1a/MgE
         fXS537F5yQLDufd38417ea1UP5HzOoVtjss6kLitN9+uq3Chv0Xrj4TeXItssZZCKpFZ
         t5FN+6VjimJpChSZFpV4rLomDalo6DFCFAI4HU85GGmhw8uNDF3kEGifEyBJ3qLPJCdz
         SdrOga3T7KTpslrjGfnwdAP0YTuw4gn/dfEbWAIDXsNiHRNEcZFFcm7m6X52IktiCloA
         DaFA==
X-Forwarded-Encrypted: i=1; AJvYcCU/xCdcj4QEYRi3ZXGSBslkq/qjC2g0cQyy4ZQogkAyGBwvHFx6mNMk5xVbCv/ldMdwxCGry7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV0rPgycXTgekuQRYCw4OIt2HgA2j0m0W1ngCjnQjDotFL0AUb
	CvsjEYmB1TojEISiZoBxzuvLy2bp23BMBiibCs2mOnks6Yt6xVDKBaMc12BQbRSWoJi2f1gZuPl
	eMRwMyetvBh67xfbHNKiRsDtzmhSSdamAL8nJ4fo6
X-Gm-Gg: ATEYQzwjvl/SkprVfBi1twimoE5BeviL4ebPbzyZ6ScWziyAFAiTsGxkzVx6ljAmKwD
	bhhmMxSDRsfstUz4aEqEI4ElTdbFmQv1dvdX/x/Txv6hLeBdfOnKWEWCjs8dOJ/kjFYEXtDhCCF
	XJR/ict4UEFIklDjByQ4a0smuezXUytas3Hd6Nu9gVwzCTcOygQc+aNzFX2tp6EhvtxiAeVorjO
	IxsIITece1WCOaXB+OIjrp5vw9OxpWSxJ0ylWF0OXes5APNygQAF9JDv8r+O1giJU5DXjpKtXBO
	VrJncPQm
X-Received: by 2002:a05:6214:5288:b0:89a:d41:b1cc with SMTP id
 6a1803df08f44-89a30af97c2mr104052906d6.47.1772928666497; Sat, 07 Mar 2026
 16:11:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307204022.1897614-1-kuba@kernel.org>
In-Reply-To: <20260307204022.1897614-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 8 Mar 2026 01:10:55 +0100
X-Gm-Features: AaiRm53AXznDm3J3Bf7InZko96TU99vFcRIJguqAUWtgAZHuEYfik6SsuMMFZig
Message-ID: <CANn89iKaWRQfSPXc+nqAhz8Zj-Yh+kohPdOvFw-fzNkWTW1TXg@mail.gmail.com>
Subject: Re: [PATCH net] page_pool: store detach_time as ktime_t to avoid false-negatives
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, hawk@kernel.org, 
	ilias.apalodimas@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2F66122E0B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265216-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email]
X-Rspamd-Action: no action

On Sat, Mar 7, 2026 at 9:40=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> While testing other changes in vng I noticed that
> nl_netdev.page_pool_check flakes. This never happens in real CI.
>
> Turns out vng may boot and get to that test in less than a second.
> page_pool_detached() records the detach time in seconds, so if
> vng is fast enough detach time is set to 0. Other code treats
> 0 as "not detached". detach_time is only used to report the state
> to the user, so it's not a huge deal in practice but let's fix it.
> Store the raw ktime_t (nanoseconds) instead. A nanosecond value
> of 0 is practically impossible.
>
> Fixes: 69cb4952b6f6 ("net: page_pool: report when page pool was destroyed=
")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: hawk@kernel.org
> CC: ilias.apalodimas@linaro.org
> ---
>  include/net/page_pool/types.h | 2 +-
>  net/core/page_pool_user.c     | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.=
h
> index 0d453484a585..cdd95477af7a 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -247,7 +247,7 @@ struct page_pool {
>         /* User-facing fields, protected by page_pools_lock */
>         struct {
>                 struct hlist_node list;
> -               u64 detach_time;
> +               ktime_t detach_time;
>                 u32 id;
>         } user;
>  };
> diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
> index c82a95beceff..fb4ca27358cd 100644
> --- a/net/core/page_pool_user.c
> +++ b/net/core/page_pool_user.c
> @@ -245,7 +245,7 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct p=
age_pool *pool,
>                 goto err_cancel;

It is a bit unclear if we always hold page_pools_lock at this point.

If not, a READ_ONCE(pool->user.detach_time) here would be needed,
and a corresponding WRITE_ONCE() in  page_pool_detached()

>         if (pool->user.detach_time &&
>             nla_put_uint(rsp, NETDEV_A_PAGE_POOL_DETACH_TIME,
> -                        pool->user.detach_time))
> +                        ktime_to_seconds(pool->user.detach_time)))
>                 goto err_cancel;
>
>         if (pool->mp_ops && pool->mp_ops->nl_fill(pool->mp_priv, rsp, NUL=
L))
> @@ -337,7 +337,7 @@ int page_pool_list(struct page_pool *pool)
>  void page_pool_detached(struct page_pool *pool)
>  {
>         mutex_lock(&page_pools_lock);
> -       pool->user.detach_time =3D ktime_get_boottime_seconds();
> +       pool->user.detach_time =3D ktime_get_boottime();
>         netdev_nl_page_pool_event(pool, NETDEV_CMD_PAGE_POOL_CHANGE_NTF);
>         mutex_unlock(&page_pools_lock);
>  }
> --
> 2.53.0
>

