Return-Path: <netdev+bounces-23710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 836E376D3E7
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 18:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E671C21334
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 16:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7108CD312;
	Wed,  2 Aug 2023 16:43:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641D92C80
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 16:43:36 +0000 (UTC)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197C9F7
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 09:43:35 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-26825239890so4900133a91.0
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 09:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690994614; x=1691599414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGG4/SOxJJw09y28ASK6MxqZa14wgopwkyaswmkWtIU=;
        b=pZsll61wPVHvNLhy5ghiD1TX/K98aFgF4KGhQdIXGoHkwODQKdMaAacpFW/1txCUUu
         4rfmJgU49gMGKAgFx83DZRwrebo1KH69yNOAVQwFtEXcdW9gbHHteHhjsGagiH3CZWSy
         sswtKDx+JM9W+itWe8RbW7R578igtt2bbTTPymRttk1X++TeFviNbOOdnpZPNO/A5gnr
         2bT2MkoUbi0PqTQrhzhSIl7EZfkdLSRjl17aHGRsvXMKiXT7+xoPUf7pidfSkTN+l0Nf
         juc6Wwg6YViPW5BKwueOHiuUVUq2z9d/DE7NQxuJmopYZZt7vBnxUWF0k0miZ8AuKsht
         3CBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690994614; x=1691599414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGG4/SOxJJw09y28ASK6MxqZa14wgopwkyaswmkWtIU=;
        b=g5dCZd5Z/mHYoR3JjJE2mvLHcLgScq14460xfggS2kqA7vYtHEqpj2fJYbLyiFVkA+
         NpWpAvqyNRzdBhLQIdITdNdzCWcuiAkI3VoFrwyoiu1RiL7Dpq8D49rV81kUahohLpR8
         41VHtlU6OQ0DVP4pegpv6KqGT5ke7u/9OU5rLQysTFMl1UmpKh0VKw7VOeC0GvZO1JvJ
         RmMpO5BkemB7XhrxEMLLjXMJDBb5ioJM6zHmgbXDb437F6JLbe396E0Rd+9zPKCZWHb6
         BY3bDbw5YxaCYgz28nianoMfp6u8DoDdopGLwwMEw2LkkrCNuiymzJd5yvODwVS6z3mg
         a8rg==
X-Gm-Message-State: ABy/qLZzFOft7Mp2jmjoughlGcDLw9hnDmYrup2c5BahGYWKuIzP2S79
	km3a9D+lzd8n3UtMVxxEf4si0ijKZN0hdYub5Yo=
X-Google-Smtp-Source: APBJJlGvSul0YJBUCwbCfry/eaKOEKAgYEXKBeHhoqy6hJppFSB2BRxbuBQNFAAVj7RnFFkkvPM4K7+Du3z9fk3EBP4=
X-Received: by 2002:a17:90b:3b89:b0:267:f157:e830 with SMTP id
 pc9-20020a17090b3b8900b00267f157e830mr14443131pjb.3.1690994614365; Wed, 02
 Aug 2023 09:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230802145736.gp4bbudizpk7elk3@skbuf> <CAKgT0UcDXUFDzVjOj4EkVRoz=zdro+hQx877dvhACMwVnjAagw@mail.gmail.com>
 <20230802152259.uwmstxftdk6wnjfg@skbuf>
In-Reply-To: <20230802152259.uwmstxftdk6wnjfg@skbuf>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 2 Aug 2023 09:42:57 -0700
Message-ID: <CAKgT0UfwcaCh6FdtJ2eXYwNNLPVrGSRhUeLjZYsHNhgg-PKYEw@mail.gmail.com>
Subject: Re: netif_set_xps_queue() before register_netdev(): correct from an
 API perspective?
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 2, 2023 at 8:23=E2=80=AFAM Vladimir Oltean <vladimir.oltean@nxp=
.com> wrote:
>
> On Wed, Aug 02, 2023 at 08:04:01AM -0700, Alexander Duyck wrote:
> > We really shouldn't be calling it before the netdev is registered.
> >
> > That said though the easiest way to clean it up would probably be to
> > call netdev_reset_tc in case of a failure.
>
> Thanks. What else will happen that's bad with XPS being configured on
> TXQs of unregistered net devices? The call path has existed since 2017 -
> commit 93ddf0b211a0 ("staging: fsl-dpaa2/eth: Flow affinity for
> non-forwarded traffic").

The only risk I can think of would be the potential memory leak.

It might make sense to look at adding code to netif_free_tx_queues()
to free the XPS memory there if it hasn't been freed already. That
would resolve the memory leak issue and allow it to be used earlier.

