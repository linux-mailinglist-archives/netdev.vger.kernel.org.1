Return-Path: <netdev+bounces-39202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC937BE4F4
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFAF628114D
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FA73716E;
	Mon,  9 Oct 2023 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9SbhX7w"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8173715C;
	Mon,  9 Oct 2023 15:35:53 +0000 (UTC)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A1E19AF;
	Mon,  9 Oct 2023 08:35:43 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d9a389db3c7so381011276.1;
        Mon, 09 Oct 2023 08:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696865742; x=1697470542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uaFqyOtgNgr8D364DEWlCzRWj3REtDAAsylQN2PmDng=;
        b=h9SbhX7wiEPsZei99XW4pM42Zva+IE1crDiB0+d9Eq1GXipfTUe3D2XgFlZOOYjGm+
         eIQ4uo+/wZ1H8L5UI7kXOrn9+T1iQoZW7IkG7R6EFu6yQNV2limF0CBQ+JcKVdXvqm57
         HhRiXE1ImCkm3Pueky6ZQjfiOrmV3syiKfxc1UfC75iXDagrNHyMDkbh7uvCyTKtGRAs
         4/jXPd5PWCRsHgqa3v8/BYSZaAuAIdhFPVDFHvLjEruWbKIiDNAiBboxZZf6f0EHJYf+
         KtX1RQZduPZZt5Pv+CIT9V660ekFAP7ZjuLGMdZsMr+FnQ4eUgpK36tU3bIt1hdYD9xw
         0Mcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696865742; x=1697470542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uaFqyOtgNgr8D364DEWlCzRWj3REtDAAsylQN2PmDng=;
        b=nQhGduP6AP8ovuvdYfS0h/oqf2IZ/DCNuTpuV6RKQHDrYTJauqyw1b5lGIOsXBy3nm
         KjrvURpvLA0aSAXRRQZz/SaUD3WCjzKg21zWxMCuTU9QMDXncGJc0ZHxulvkF86sjTPP
         jlKamvExW6U1R31ODupvRttSAXkVGJHRViKDbNbIvZafNoYDeEVGNCCU44K+jzm1CbvU
         dN6QzDJ/emXCfzmTsP+qF5Xq1/SXcd9hurpWHY8BssagHQN/v8sfeCYnE0mBBNwHOuJt
         aJoqwAp9TcjNY+oZAzuBArnMEZm9mzkt3ytC4yEeAXxU9GtMVKlwOfheen4U6s63s81q
         Ku/w==
X-Gm-Message-State: AOJu0YxOxKImM24Km5lOt8PWu4vM9z5JznYOcqOe3z/eWnUxVgzrDW0M
	lCMaxLLEL25j1BLospWoRv1is/+1bdt3H0NISy0=
X-Google-Smtp-Source: AGHT+IEgFW0EElOv+YWbAIy22gOf2JNU7FslBCh4wkUVVsUD6i0ATkaw4wKQ6UskBMRZ2n6cnHB3zAa9Quawzd/YJuw=
X-Received: by 2002:a25:e80e:0:b0:d1c:876d:2c7d with SMTP id
 k14-20020a25e80e000000b00d1c876d2c7dmr7827839ybd.13.1696865741968; Mon, 09
 Oct 2023 08:35:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <20231009013912.4048593-4-fujita.tomonori@gmail.com> <ZSOqWMqm/JQOieAd@nanopsycho>
 <bdfac30f-364f-4625-a808-fcffab2f75b4@lunn.ch> <CANiq72k4F4EY-cLYMsRFsAnjd9=xyMN_4eHS9T7G1s=eW7kHjw@mail.gmail.com>
 <fd715b79-3ae2-44cb-8f51-7a903778274f@lunn.ch> <CANiq72=OAREY7PNyE2XbFzLhZGqaMPGDg3Cbs5Lup0k5F7fnGg@mail.gmail.com>
In-Reply-To: <CANiq72=OAREY7PNyE2XbFzLhZGqaMPGDg3Cbs5Lup0k5F7fnGg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Oct 2023 17:35:30 +0200
Message-ID: <CANiq72mVRO18ZCFBnKPbJfxkD6A5hsOoVwk8Sef7rVX7GnTBzg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] net: phy: add Rust Asix PHY driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jiri Pirko <jiri@resnulli.us>, FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, greg@kroah.com, tmgross@umich.edu, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 5:27=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> I apologize -- I didn't mean to say that you should know about those
> things. Just that, we are trying to do our best to get things ready in
> the best way possible, while letting people "play" meanwhile with the
> abstractions and so on.

I forgot to mention: we have been planning a "networking call" for a
while for everybody interested in it in e.g. Google Meet. Initially it
was going to be tomorrow, but we are rescheduling now.

The goal of the call is to get the different parties involved, since
there are quite a few trying to upstream different bits and pieces
around networking. In particular, we want to discuss having
a`rust-net` branch where everybody can work together on the networking
abstractions and iterate there.

So that is another alternative. Of course, the `rust-net` branch could
be in the networking tree instead.

Please feel free to join, you would be very welcome (and anybody else
from netdev, of course).

Cheers,
Miguel

