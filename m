Return-Path: <netdev+bounces-271291-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJb4B/72wmklngQAu9opvQ
	(envelope-from <netdev+bounces-271291-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:41:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CFC31C6F6
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A834305A2D1
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6A535504D;
	Tue, 24 Mar 2026 20:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kf63acWi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C703537FE
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 20:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774384809; cv=pass; b=Z8yEggfNh6/5hHL0jSfsT4u/LtdgSsAIyp2zuV+oiG7zJj2HFjc/HHVDj54tIr0tNbv/zKtUzTVfJCSFpsg8BsDOnb79pTiWjmDFF1qTHtDpmQg9IL2qrA90LMl2NCi8fofzC7af6QQoxpBwRa/hbaRA7+pLtltOOYTh/luX1cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774384809; c=relaxed/simple;
	bh=I527tD2LADZrsZFQR21Bz3y0caQ83wQGhRDjZgOdcRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7N845Fydob3cgSxrVjArXnslTkE+RevKfkXoNyc4c4bm9C/ZOHNQRqzqMu0YtEGtb86TyU4ZqufmWg27xntyDaZtw8SbMf9kPJIxrQdpkWxTvVxOJvf51lV2TY/GjfS0Dc7Enrc2LTTkLsScOGe6q/KHTaJGKP3mVvlUVgV6h8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kf63acWi; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50b392f1846so69892721cf.3
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:40:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774384807; cv=none;
        d=google.com; s=arc-20240605;
        b=JNkp1zyWB8il2txDosRmiVevUmChQRNfPHawsSMIQmDp0n39jc6dUMrTXR5U4nE1Fg
         BiMZDhw8XGuVu6xy3MFDbbw+gdhRXfEQ70UWXwXj6qz77AQ45JXlM3ytBUV5NU0vwOkS
         +wZJEMHc2oavifQv1tV2FNF5w2s8k2RAiv7gLZODh1MH09UEv5rb5363uZtBrEZpr07H
         D0IjQeH/laOeb8c4QpfYaD/6QNzBqBPy4OZ28eoL+evyDSq4FkPB3VnYqvGpL0K0n6SE
         5Rqt53vuv46ZKCV60F8ngBtCL8uiBsCvCyngMIuOVqtoR39rJrMkP8Tq759G+a5/T8Qd
         cRDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TJx6RzVW6fdo6krtMlTd5qSDS7LK2bGBCeZpFa66tzI=;
        fh=bzHabNCJuTXYdhwPo3Ft++HW0iLEVsMXQ48FLmqSbhk=;
        b=cAb0J9+YrbhW57OHeeWM7iSf3Jud1nGnfYFYCo3C0HwawFYKpPrryD+1YwqCDov09T
         xToPJrd5xAVPD22NSOMx6HI9qWlFysznwe4sUIgXaX2k6iIJtuIUVYXvcn6yawTmpUdU
         fvb+gzLSdRjru8OUhv0h8mqYBOJmqUxAwevVPRIn0k09Z46NiRBC6PYhm+C1L0tMVSR8
         ioEMRHIe9w98eN1vbJ1noHbEFQx8nLJICza2ZFw2uaDADd1dyABF/FPv+1BPhel0YhD9
         rhxBv8Zb4J7E6d1KcpqGJspf3wWv9BJMPQTLMy55Xg78L1m3uOZjWaVOZ4jFIGAJhT2C
         qO1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774384807; x=1774989607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJx6RzVW6fdo6krtMlTd5qSDS7LK2bGBCeZpFa66tzI=;
        b=Kf63acWiztAOM+EJGdUdjdW7RKI/hyVlqouVSXzQob5jvT1io9JQPCxEJed+ee59VC
         M472Ke8I2IWg7iK6zuEooZ7QHeAyK0u+KVtQa0MFkbUAzU/z0YOVtGioyRx4tGFYjNmJ
         ua2u1VotB3rzxWSixLGOA+VeHK032cAIAiwOOYMz57g+f2jWwjBd3IiqSD6DoFG88hbt
         CQM5rFa4w89i/E4RKGcDR2LIfBZ+z2e+aZ+4ZooRPGws/3+TZuXo4pMTep3YuLpd1cps
         GfHlY2vJvFYICUYepOWnj5Yqfb4sDLOL1q4GNutDFLUbJUphBfjW08cRcMsxrB8iY+Fe
         pySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774384807; x=1774989607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TJx6RzVW6fdo6krtMlTd5qSDS7LK2bGBCeZpFa66tzI=;
        b=VN1o4Djf6WU/4OOv7QykCjqqVnPgSJMb4WsoP8/1SdsPfHQXhmPFMyVrY344yldIgZ
         vBIkOCNYJ6nbOq6opbrsNyMwM8lbKY1Tw9QFDVbdrafmSlmalVVPcc6LJRSEr6jFrdBN
         aRZWVYJAOaOeEq5fZSr80ETcAy6uL9y3AOxdhgg9Gx0k6HTr8sjRKg0XcjYmvAnjLK11
         t97K3JJxmLp1CP9VH1duZK6emakr2ZFWG6/Cv8zNfE6HZ4DC9r52NSphb69Zz2tyVuxv
         1xkrZQcpm+37Sebo/3AObqswO2sRVAOryrxTV8Vb8l/yV9K+gGt9PuB1ASKzYsn9dIlL
         g10Q==
X-Gm-Message-State: AOJu0Yx80JIZNePNfrRJCegn3vBg4x065E3z+7jnExbBQwXzU0l9vTCm
	taZWsAQocJbsdnBAk/bTM1WyYWAgu67An4yriDuDcStY6TVeK/F8EGw0VmwiQID4cx+QmZ1TJGK
	OuB0G8129LgICIb7y4Kh5rj9ovilnotc/QVWmmjt+w14f475gNnwCeeyr
X-Gm-Gg: ATEYQzyYIzkT8oDRWX/cxiMNwK4n26QEsYvHGDIMKToUHJylvo/o71TVOS7NuMls0nQ
	GdIxcKefBeinmbhfBpqD4s4pXTGsU+X6mFrX62/HK2qTZgKXNLH2unjqDh8ohbFQgPerqPt+ZOC
	r0Umdw/mnvEc6yxqvoFiQXk3YC+vXB/YhPns1dKfl/smyOnx4raaL8fDeyglM42kLF3hjIQnXPs
	zfZ25i5irp9P3dA1FMEwg5ult3sDcnvJbdcB8uTcAvGp/6EoB8Lwbe1Mdi4Qz2iRi7XU9oak2Ci
	AhOrC56CjwzHKR7qi7pEUmEXGoQDIVjqtWUQfw==
X-Received: by 2002:a05:622a:684a:10b0:50b:46ba:d271 with SMTP id
 d75a77b69052e-50b80c87771mr14384801cf.12.1774384806395; Tue, 24 Mar 2026
 13:40:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324155521.525292-1-idosch@nvidia.com> <20260324155521.525292-4-idosch@nvidia.com>
In-Reply-To: <20260324155521.525292-4-idosch@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 24 Mar 2026 13:39:55 -0700
X-Gm-Features: AaiRm52V_lCD9tMLxBR3akjJM1MGGiOV1vmYzMv4yespAM1FS1RAWqwd_1tnWuk
Message-ID: <CANn89iJ9hD3vBiViEz886sVwuqQVbaocnE0UJHZMhchFHKiM-w@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] vrf: Remove unnecessary synchronize_rcu() invocations
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, andrew+netdev@lunn.ch, 
	petrm@nvidia.com, lirongqing@baidu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271291-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 98CFC31C6F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 8:56=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> vrf_rtable_release() and vrf_rt6_release() are called as part of the VRF
> device's ndo_uninit() callback. As such, an RCU grace period passes
> between the removal of the VRF slaves and the closing of the VRF device
> until these functions are invoked.
>
> Therefore, it should not be possible for any concurrent RCU readers to
> try and acquire a reference on the dst entry while we are potentially
> releasing the last reference via dst_release().
>
> Given the above, the synchronize_rcu() invocations in these functions
> seem unnecessary and only add unnecessary delay when deleting VRF
> devices. Remove them.
>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  drivers/net/vrf.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
> index bfc9ea91ac20..75edb8eba87f 100644
> --- a/drivers/net/vrf.c
> +++ b/drivers/net/vrf.c
> @@ -753,7 +753,6 @@ static void vrf_rt6_release(struct net_device *dev, s=
truct net_vrf *vrf)
>         struct rt6_info *rt6 =3D rtnl_dereference(vrf->rt6);
>
>         RCU_INIT_POINTER(vrf->rt6, NULL);

We could argue that the vrf->rt6 clearing is not needed,
or should be done before the RCU grace period mentioned in the
changelog started ?

> -       synchronize_rcu();
>
>         if (rt6) {
>                 dst_dev_put(&rt6->dst);
> @@ -992,7 +991,6 @@ static void vrf_rtable_release(struct net_device *dev=
, struct net_vrf *vrf)
>         struct rtable *rth =3D rtnl_dereference(vrf->rth);
>
>         RCU_INIT_POINTER(vrf->rth, NULL);
> -       synchronize_rcu();
>
>         dst_dev_put(&rth->dst);
>         dst_release(&rth->dst);
> --
> 2.53.0
>

