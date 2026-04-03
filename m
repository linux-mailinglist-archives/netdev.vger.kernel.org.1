Return-Path: <netdev+bounces-274899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLdxBzphz2kVvwYAu9opvQ
	(envelope-from <netdev+bounces-274899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 08:42:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 673BD39176E
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 08:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 231DB301703C
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 06:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6318F35A3BF;
	Fri,  3 Apr 2026 06:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BZYMYLP9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ED836309F
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 06:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775198510; cv=pass; b=LTk42DiM22Bf0rnf6whpcWHU0kC/ub9D4ZRz9+Zi2Y/ocOEWk7+xQb4c/nmyYhHmU9iY/sTiRv92kp147JdUoDNDVkHRiL+l2uk5gTYqNKiBmVQXNdgG3CAH19DWrnum3FY/zTW/isxTOAC5SJJGwQoNz5AMIVSJeB2JkDwlHTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775198510; c=relaxed/simple;
	bh=g34Q7kaCdGutrL4RG/9Ww9dX+8MOecUwvEqAiZCWlPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlzCJcth5U7nqQVrtKYkal/m2vFhFgFWdMmoT36dUETURck6TXVXaIXMsz5tysBvvc3ydYNXmxnDDjoOlxVhx6N+fIDjcKx7hJwK0l3xyGVeQsTjNO+No9DUaNuQL1rENPylDZ+uOduTFOWO8yZydagdztNe+zR//x68xBfxROQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BZYMYLP9; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cfdac74050so214742085a.3
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 23:41:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775198508; cv=none;
        d=google.com; s=arc-20240605;
        b=C7AvyoWg6foiu0mzD9iwNGp8R0+CyoQiOG6nd2pwajO4ic11faZ4VSX3y9KWuk5EVu
         d3dkuvgOksSozcxaXtl+9j9rFiXp9/7zdTUNhGwdPSvlvqojNS8B5+WHvsxoezhoapJV
         r3QKqWh8BD1bzwOHKBFbNFBGp7z+aFys1j8xHDXpILq49wTRx27BXv6SY3vJkArJyoSR
         FBABrEPRAV+UHuzf8Iuu2EpoynQXLz02NVpqC0qnoA4fm2z7aZXPnekwdbwHYre194ti
         t9PZrbydNK7Q9q27brrEq2Hk0GY5T+WwRAsFSv5eBsdKvkgt0o75xpaCqYw5KZlGaDKh
         abPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=476jFsFJ6OvjFssD1jWF4sFE8F3LXSAtn8n1PRhwgZQ=;
        fh=izaFAkB8ptIVxteM7TMtjVVwV6dwHDQxrPdWtgF2Pw8=;
        b=k1JXarV2A7VrK/lADdIRb7rNWI+iMJDN96zj7/DrKQ06VB6J+rcU/mMOdBkmYcPuYh
         QrjR9HFkYafe6Jhyvi0hIawAWSqfdy6l0WyNlrmoBcW50PxQfoWCf+10WSn9i5mlRUgV
         mU0G4wzu/GWBDsc/kRFnglhsMfLHKbkG/aLWV0gCDYxZIZaL9U7RleywF3uZ+HVZLXjV
         ZwMuy6hiMCBrY+Hk+DfXOcknpMpnzkOFnug8eoO4cRFrDCyk5Zvlo0J9z/4yf1bdomY5
         QapWNtxb1VG3Y4AWuFBJDmGixqHdIFvpEC6Oz+5ug1+GhlHFuBLnNNlQHE6+ORawLE1S
         XYDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775198508; x=1775803308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=476jFsFJ6OvjFssD1jWF4sFE8F3LXSAtn8n1PRhwgZQ=;
        b=BZYMYLP9q4PUC4A/B8ZDY1Y4PLmKUrGgjQVMVS20K2IHQzSI9wKpOJytFLaxPPcy8J
         3/wrEVmtAsbKCJ5OOhRkGqTlpZ6e/UQVYzHPJwombqkbT6hUYQxKQH/88j+I910pZwpM
         zlInPo16Xm9nYKkjctXQUVdhBMQ43EO+1kqDvP7TCv27efw2N70wJgyVayi9/mDxP1Vl
         5OnxH1QSPpi+eZKw/eAMLYE84tkuvaowRKBDwkNlphlOo4Iq2EW6ta9l84UxDhEsgKe0
         yor7uYSeBUnv9Jcdhd4+9ThyHhP4onWToZiMyu8irOHsxQk8pIx6+haofuOU7Ojxjq4I
         3MFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775198508; x=1775803308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=476jFsFJ6OvjFssD1jWF4sFE8F3LXSAtn8n1PRhwgZQ=;
        b=NLDbxNiPd5tTqc2KMlfkpT/BGeQ2C70sQl01d0EzSNjhSITg43wmJyyo/LXBOZVTW8
         wA+rGn+G9/3Jd4E8Uc+QUPQ+4iS2Cej36ViOGjh9T+XFc0qwDqsMq+fa2m30meoZfF5q
         C+tJV5yXIGYfRvR62nXQTYMq6pAV9TlmF550oEI71O71L/o7O7NewlbcoKqn5XMNYO4l
         jOMvHMqWPk48ayO4mhHJ4qJC5VsWtsoOIkqDI+VIu2nGbCHzH5BgCzdGCo98iU+viC4U
         NvqHldj94Qb3gTVc/f5u94fEL2dqL3zpHXcL8Mmg7ryT2ycpYy148W+pKUe1s12+EoxR
         LkWg==
X-Forwarded-Encrypted: i=1; AJvYcCXeo9OeamnGpHw1NV0w1qtQuAPxsKlzqIYNL1VQlXZCMUGprrIbWoh4ARsa82iiJuZY9//q/AU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKZ8pAb7CAyx8ZEFQY871WMi+OIPlPCVhv+S8WjfFjpXtN5BWd
	Etx6n0RQGXPCuFRXvMZbH5OTEXlkmbJxoazfq8tQHZLKmM7ckHuf1xkrAhlbYQgEGwgAEZ/3wSz
	ZCcPBu36Rh1QDvDp90MjOL0aJ/wak2zFwGTOh0JZM
X-Gm-Gg: ATEYQzzqMd8nvvR0uLj4d8fSooGhmgNXh7k98W4W/EHkFJJBcoLP+/5ZBJp+hwrsmfw
	cV8SrhqSRYs7AIfBsRUb1NQJa19DmlQ+1m47twbNc7sJTCjkL/wonDnETkCbscQUhpe7AqvWBV4
	sbA5SfYmVpPFN246aKT4CJXUBFQ+UnmE18SKP7LEZeqaII8b5UVpb7MKsRM/aNC3nIVQGrK/vbD
	qy0/pKQXB5D7hv+RBHGToSimTSOONLj50cpc8OVXREP2OAWG2KkwISWaOEmx89qSAlPaQIjNmaI
	jovYfB4=
X-Received: by 2002:a05:620a:480a:b0:8d0:8f7:36b4 with SMTP id
 af79cd13be357-8d41db50c79mr276130585a.32.1775198507282; Thu, 02 Apr 2026
 23:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403043237.3909226-1-edumazet@google.com> <20260403043237.3909226-2-edumazet@google.com>
In-Reply-To: <20260403043237.3909226-2-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 2 Apr 2026 23:41:36 -0700
X-Gm-Features: AQROBzBi3eNOEyZe4lajR8IzB7hPG-pqfUh6FzlcdCkHsVlu7bP8OaKeSZqCZyo
Message-ID: <CANn89iK00Ttiq6CBkKZ1KdPbVwOgEMYwQP=6PK8fpYf2Fp9mDw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/9] net: tso: add tso_features_check()
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Joe Damato <joe@dama.to>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,dama.to,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-274899-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 673BD39176E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 9:32=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> net/core/tso.c users expecting headers size is smaller
> than TSO_HEADER_SIZE must fallback to GSO when headers
> are too big.
>
> Provide tso_features_check() for drivers .ndo_features_check().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/tso.h | 11 +++++++++++
>  net/core/tso.c    | 12 ++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/include/net/tso.h b/include/net/tso.h
> index e7e157ae0526c8d655aca67a8a49191ec870746b..9be7cb6553975a2a82e098721=
4fee6883bf74404 100644
> --- a/include/net/tso.h
> +++ b/include/net/tso.h
> @@ -28,4 +28,15 @@ void tso_build_hdr(const struct sk_buff *skb, char *hd=
r, struct tso_t *tso,
>  void tso_build_data(const struct sk_buff *skb, struct tso_t *tso, int si=
ze);
>  int tso_start(struct sk_buff *skb, struct tso_t *tso);
>
> +static inline int tso_compute_hdr_len(const struct sk_buff *skb)
> +{
> +       int tlen =3D skb_is_gso_tcp(skb) ? tcp_hdrlen(skb) : sizeof(struc=
t udphdr);
> +       int hdr_len =3D skb_transport_offset(skb) + tlen;
> +
> +       return hdr_len;
> +}
> +
> +netdev_features_t tso_features_check(struct sk_buff *skb,
> +                                    struct net_device *dev,
> +                                    netdev_features_t features);
>  #endif /* _TSO_H */
> diff --git a/net/core/tso.c b/net/core/tso.c
> index 6df997b9076e9842f3de7bb3e34599d8ff4e4fd4..81e2cc66d0dd29eeb647232e0=
4032b1412382a6f 100644
> --- a/net/core/tso.c
> +++ b/net/core/tso.c
> @@ -87,3 +87,15 @@ int tso_start(struct sk_buff *skb, struct tso_t *tso)
>         return hdr_len;
>  }
>  EXPORT_SYMBOL(tso_start);
> +
> +netdev_features_t tso_features_check(struct sk_buff *skb,
> +                                    struct net_device *dev,
> +                                    netdev_features_t features)
> +{
> +       if (skb_is_gso(skb)) {
> +               if (tso_compute_hdr_len(skb) > TSO_HEADER_SIZE)
> +                       features &=3D ~NETIF_F_GSO_MASK;
> +       }
> +       return features;

I forgot that netif_skb_features() uses:

if (dev->netdev_ops->ndo_features_check)
    features &=3D dev->netdev_ops->ndo_features_check(skb, dev,
                                            features);
else
    features &=3D dflt_features_check(skb, dev, features);

So I need to call vlan_features_check() from tso_features_check()

pw-bot: cr

