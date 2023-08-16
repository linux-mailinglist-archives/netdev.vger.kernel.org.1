Return-Path: <netdev+bounces-28178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6FD77E809
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 19:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837F3280FCB
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 17:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF1A174ED;
	Wed, 16 Aug 2023 17:59:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8342D20E7
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 17:59:38 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1842721
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 10:59:36 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40a47e8e38dso29941cf.1
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 10:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692208775; x=1692813575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWnLRO/GKxzBH9gafDxQXPJzCbdJmTTWVpogphTDa7s=;
        b=fKqhM2ELueKs89fo+NJZ+07rnsnl8DHonxMS2BZ6jUNwDsssGQIdFzW3fP9KW2F2zF
         WYfWaE4SR6iTVVnIkbWLqogIzfXAhKjrBzCLpFmV4ujheK0Ri3wCTifcTbnv1U7DPTRS
         OERx5YAElZjG2evuzg/UD2raZU3JNXTZyMSAtEjPW4gOkbT436CFtuL22rUlQ9Z52VUs
         qECSYjWqeKkAPNiMMZRUAOHI1yuCYkXIEmKt6i1JkJnWtPZDhAj9E6FvnP9k0vgcDVGx
         XUlLCdQFAxvgDkrRVGlqy2Th3xJ4jpQBZ6EW2oeJNnDWhHsmnBm/fYeFB6uyj4F3Ocg2
         fRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692208775; x=1692813575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWnLRO/GKxzBH9gafDxQXPJzCbdJmTTWVpogphTDa7s=;
        b=QRUZt3E3SDpeI/sC5rsg5U/RVPX1DWZ315yKijqL89AzwfcAMTiidxhf8RzOt46Lzz
         B6haXbfH0BCnuEI1hHX2rAxCjz/SCHXMETPuUvPLhnGts6XePJpcWixKEWxMU7n007lQ
         uRtHyFA6j81c+UYYAXZMK6WGU2nRP6KtDVdsPVuLcXcXpvmq/bpg4CajKOSQTJQfND5x
         cBKuy87bBvsbpiW/x9T7C5kQIEXyxT90Kr2bh2JwrVvA/jEE0D+uiHXdlFKDo+piA4zm
         h/Ou4Xhv9+U9Ku0ZYeg9D9nRWyU5I1FqT/sAD5HmFD4ESRC3VW8gk6Pr2odhDlNXNhNS
         O6hA==
X-Gm-Message-State: AOJu0YyTqf0bAW4oaV3dvuwLviTXq/NhxH9hGZek6poALDGh3iWijtEq
	0mxOgGeWp41oZl9mGLGgnJ4sDx2JWOLd+hrY4LKqYA==
X-Google-Smtp-Source: AGHT+IFfMthOGnOOu5dmQ/X8FnifTrU98fHZITXmF5sWDPcXpvO5MgdNNna9rqRNSjZTkm06Zr1u0fl/CSXnEy753lo=
X-Received: by 2002:a05:622a:355:b0:3f0:af20:1a37 with SMTP id
 r21-20020a05622a035500b003f0af201a37mr24283qtw.15.1692208775284; Wed, 16 Aug
 2023 10:59:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230802092340.9640-1-edward.cree@amd.com> <CANn89iK6MPMUiAoRQKo+qyKp4ia6q9oweMi5VSawYQHwv4+-ng@mail.gmail.com>
 <7b756e5e-d2f9-a6a9-cda6-bc047a3936ba@gmail.com>
In-Reply-To: <7b756e5e-d2f9-a6a9-cda6-bc047a3936ba@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 16 Aug 2023 19:59:23 +0200
Message-ID: <CANn89iLJi8n7=kmhN4hkF8SDr9uuiX8_4SVzx5Og_Mpn_RYGXA@mail.gmail.com>
Subject: Re: [RFC PATCH net] net-gro: restore check for NULL skb in napi_gro_frags
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, 
	Martin Habets <habetsm.xilinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 7:46=E2=80=AFPM Edward Cree <ecree.xilinx@gmail.com=
> wrote:
>
> On 02/08/2023 11:22, Eric Dumazet wrote:
> > On Wed, Aug 2, 2023 at 11:42=E2=80=AFAM <edward.cree@amd.com> wrote:
> >> An sfc customer has encountered this panic in the wild; we're still
> >>  investigating exactly how it happened (we have a reproducer) but it
> >>  seems wise to have the core handle this check rather than requiring
> >>  it in every driver.
> >
> > An ethernet driver feeding non-ethernet packets to the upper stacks
> > seems weird to me,
> ...
> > Not sure why a napi_gro_frags() enabled driver would be allowed to
> > cook arbitrary packets with length <  ETH_HLEN
> ...
> > Mixed feelings here
> Fwiw we now have some more understanding of what caused this: the
>  device produced an RX descriptor with a zero in its buffer length
>  field (there was actually data in the buffer, but a =E2=80=94 we think =
=E2=80=94
>  firmware bug caused the length to be stored in the wrong place).
> And the driver, blithely trusting the device, attached the RX page
>  to the skb from napi_get_frags, passing the buffer length it had
>  straight to skb_fill_page_desc without checking it.  (After all,
>  the device had told us through RX event flags that the packet was
>  TCP, so it had to have seen a complete set of headers.)
> This certainly can be fixed in the driver, by adding a length
>  check before calling napi_gro_frags(), but I see two reasons to
>  put it in the core instead.
> 1) The same issue is likely to be present in any napi_gro_frags()
>    driver; I've just looked at e1000 and mlx4 (as examples) and it
>    looks like they could both be susceptible if hw misbehaved in a
>    similar way.

Yet, it seems they do not misbehave ?

How XDP will react to such bug btw ?

I would vote to add the fix in a driver first.

If really the same disease seems to be common to more than one vendor,
perhaps we could harden core ?

