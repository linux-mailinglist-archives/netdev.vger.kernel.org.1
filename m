Return-Path: <netdev+bounces-34553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1B37A49D7
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 14:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 091E7281DA2
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F701C69E;
	Mon, 18 Sep 2023 12:38:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055EE1C694
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:38:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382149F
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 05:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695040704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbTT3UxyL3H/nEohNzpH2nr94phq7RVCv6YPBkujK5k=;
	b=jVY/LUP25zAlXcjNC34O2GYwnP9WPGbZUg328ATTDxa8FDc1dDXI2bv2PHt43vnjnwATQW
	M3ubLxP3mfYt8xqLem9fW9FxG6RbgEsCcavG5mtj2r5ikebQTR6cEJpAgp+s2th5Y0ViI1
	uWUvahLYZjjC5G1wFKCqmkBh+Jc+jYo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-CPI-kU-VPo685ABK_2E6IQ-1; Mon, 18 Sep 2023 08:38:22 -0400
X-MC-Unique: CPI-kU-VPo685ABK_2E6IQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-52c03bb5327so3077479a12.0
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 05:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695040701; x=1695645501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbTT3UxyL3H/nEohNzpH2nr94phq7RVCv6YPBkujK5k=;
        b=pqJyLqUG3irDVuRAf5Ted7UM+I1fPKWUiyAleLIuHxjnetCvXit86By4mCIO+Vnlrm
         2EXMeMSpLjSDGi/4uerBEvY3GFJnUZL2hB8Yb8Acl0XM4eB4/2EXFH7h30stSTPO/4CU
         3XDiYBVil4ZyZHVvSVSsDweH57szsLreJlZVNQ8Kc80txA2mg+T+TkV1jBc8ptmZ3/HJ
         ReLBTLeeMq14PqOolmiYAZvEHQe5bmZVVXRMnyZsy3HgEYcjHtb+ShVZm8Hx+W2OlUpS
         MaMwMyLpVw0u7Qd9RKtg031CcvqAdYE6YxzdqXty/ndME/AoeCxp1qEFPUvrD/6HVGTA
         F4TA==
X-Gm-Message-State: AOJu0Yw/RCjW2Xh61p4AQLbjhHMMljBXFDiS4MjE7m8KypSY1z0Isc1L
	Luk7GkTaAXdE8+srfsSqwg+wqL+U43M0YbwDBmY5WYJCKv2XxAyVnVENFSXsNwq4cA0F3kHWUdS
	0vi2abwASYpAiaWhBbLiGC2Eg2YGM3XXA
X-Received: by 2002:a17:906:32c1:b0:9a1:c659:7c56 with SMTP id k1-20020a17090632c100b009a1c6597c56mr7442395ejk.22.1695040701547;
        Mon, 18 Sep 2023 05:38:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzI2EitJR0zJDb98cayvdczTbfNmReyYoiX5qbAGrH1KzCfB9fNZ62SOPdtO2qfvgfJn1kpICDpn7XizCnTc4=
X-Received: by 2002:a17:906:32c1:b0:9a1:c659:7c56 with SMTP id
 k1-20020a17090632c100b009a1c6597c56mr7442378ejk.22.1695040701286; Mon, 18 Sep
 2023 05:38:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK-6q+ghZRxrWQg3k0x1-SofoxfVfObJMg8wZ3UUMM4CU2oiWg@mail.gmail.com>
 <ZQUjD0liUnH+ykKY@gondor.apana.org.au> <ZQg7s8MtByk4kfzP@calendula> <ZQhButkhI8K6cduD@gondor.apana.org.au>
In-Reply-To: <ZQhButkhI8K6cduD@gondor.apana.org.au>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 18 Sep 2023 08:38:09 -0400
Message-ID: <CAK-6q+jLe_WnsMrkASv_AB722YARP=f7j=Je2VZYOKjfYUKcuA@mail.gmail.com>
Subject: Re: nft_rhash_walk, rhashtable and resize event
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Network Development <netdev@vger.kernel.org>, kadlec@netfilter.org, 
	fw@strlen.de, gfs2@lists.linux.dev, David Teigland <teigland@redhat.com>, tgraf@suug.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Mon, Sep 18, 2023 at 8:26=E2=80=AFAM Herbert Xu <herbert@gondor.apana.or=
g.au> wrote:
>
> On Mon, Sep 18, 2023 at 01:59:47PM +0200, Pablo Neira Ayuso wrote:
> >
> > One more question: this walk might miss entries but may it also
> > duplicate the same entries?
>
> It depends on what happens during the walk.  If you're lucky
> and no resize event occurs during the walk, then you won't miss
> any entries or see duplicates.
>
> When a resize event does occur, then we will tell you that it
> happened by returning EAGAIN.  It means that you should start
> from the beginning and redo the whole walk.  If you do that

To confirm this, redo the whole walk means starting at
rhashtable_walk_start() again?

Thanks.

- Alex


