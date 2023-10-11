Return-Path: <netdev+bounces-39821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2765D7C4930
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 07:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB541C20CD5
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 05:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4309D2F0;
	Wed, 11 Oct 2023 05:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnQ+GssB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C292354F0
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 05:26:10 +0000 (UTC)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD7E8E;
	Tue, 10 Oct 2023 22:26:07 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d9a3d737d66so2399558276.2;
        Tue, 10 Oct 2023 22:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697001967; x=1697606767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBvwRr+UYeiNIgyMN0xgl61IRq+wFgkmFE+ImROj8bE=;
        b=HnQ+GssB8GJIy4D535iGnWgD9CzdOXJuTmK/bBx1HvFHEvLLZGL2rTkQwvrUVJ6cso
         IBNQBBO/0AW00YVBbuwl2qb+uNeZ8/3Ed5IVi5Med6ktAGgl6F/ZD1Cyjv9jhXrIjjuw
         WAQcww4fsHGVAI0SYWcIYIheDUjAW6VJ3qZHAbBb5sF7+675MBdUqsqIAwi4uiTFao+Z
         rPK+DEnKha55IHkdEhWp/4PKE67G1ToG1Qh29djQkGBDzp5+TqZDkjo4GxtbpxAHhfeV
         7AO/2tI/aUhEnGIfbDR7ono2kyL8KeUhG9hUnBhAL9M1UG6bR1TZtrdCYO7nHNc7oXJu
         d+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697001967; x=1697606767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBvwRr+UYeiNIgyMN0xgl61IRq+wFgkmFE+ImROj8bE=;
        b=jhrRLUlSE5yAHgQirYQ3Br8WSSiN1pAlgXNNIIk/+4p+A/fFXqH+omHlFUc4Ioq9yo
         4wl8vCCra5sHKvZ2u9jkC2kQ5KpM1fWVEYrWf5a2wGDnrd6Ufr0QGpAtcDUgtBcSVa1h
         tqTcFEoeNhuhE300kr3dsSHGj88BlxKQO2T6hiUH7e4SpTC830Krk/3uFxgQTagfajE0
         EKPWhDOHBld8Ax1q8X5O7XgVPYufOaiU+dhL02ktjjZx2VUpSwhPEYyQcoNPVrzqAvdC
         ftQSguNEXb9+dtSfw8MztVAfbqMedpH4kdXJoGyl7vMgzZM3cxaLZIT7vgqiwVGSpXkO
         r8VQ==
X-Gm-Message-State: AOJu0YyZcH72Am2Wm3B54N3yvZO0In0e2cQiaAr5GkQsJhXwOZ9kzcDR
	e1jsmfq1wXy5VeWCf8w+bDW4+UmYeiH2aqlCG0c=
X-Google-Smtp-Source: AGHT+IEaY2Yf4jvH8XVVUz0xhr3RUVnk5NEk7IF1fZvHezTCJfsFmn71Qp6kAytD9i89wqEAY5X70wkXV3Hikk9VCcg=
X-Received: by 2002:a5b:1c8:0:b0:d9a:54c2:1b92 with SMTP id
 f8-20020a5b01c8000000b00d9a54c21b92mr3827731ybp.14.1697001966675; Tue, 10 Oct
 2023 22:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231008075221.61863-1-hayatake396@gmail.com> <20231010123235.4a6498da@kernel.org>
 <CADFiAcKF08osdvd4EiXSR1YJ22TXrMu3b7ujkMTwAsEE8jzgOw@mail.gmail.com> <20231010191019.12fb7071@kernel.org>
In-Reply-To: <20231010191019.12fb7071@kernel.org>
From: takeru hayasaka <hayatake396@gmail.com>
Date: Wed, 11 Oct 2023 14:25:55 +0900
Message-ID: <CADFiAcL-kAzpJJ+KAkvw2tH8H0-21kyOusPSPybcmkf3CM7w9g@mail.gmail.com>
Subject: Re: [PATCH net-next] ethtool: ice: Support for RSS settings to GTP
 from ethtool
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thank you for teaching me so much!

> > Sorry! My email was blocked because it wasn't sent in plain text mode.
> > I've made the necessary changes and will resend it.
I got it. I'll do it like that :)
Please let me know if I'm using it incorrectly.

> Makes sense, thanks for the extra information. I think it would be
> worth adding all of this to the commit message!

of course:)
I got it. I will add this background information when I issue a patch
for the next version.

> Regarding the patch - you are only adding flow types, not a new field
> (which are defined as RXH_*). If we want to hash on an extra field,
> I think we need to specify that field as well?

I've been really struggling with this...
When I read the Intel ICE documentation, it suggests that in RSS, TEID
can be an additional input.
However, I couldn't think of a reason not to include TEID when
enabling RSS for GTP cases.

https://www.intel.com/content/www/us/en/content-details/617015/intel-ethern=
et-controller-e810-dynamic-device-personalization-ddp-technology-guide.html
(cf. Table 8. Patterns and Input Sets for iavf RSS)

However, for Flow Director, it's clear that you'd want to include the
TEID field. But since I found that someone from Intel has already
configured it to use TEID with Flow Director, I thought maybe we don't
need to add the TEID parameter for now.

https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20210126065206.1=
37422-1-haiyue.wang@intel.com/

If we want to include something other than TEID (e.g., QFI) in Flow
Director, I think it would be better to prepare a new field.

2023=E5=B9=B410=E6=9C=8811=E6=97=A5(=E6=B0=B4) 11:10 Jakub Kicinski <kuba@k=
ernel.org>:
>
> On Wed, 11 Oct 2023 10:56:17 +0900 takeru hayasaka wrote:
> > GTP generates a flow that includes an ID called TEID to identify the
> > tunnel. This tunnel is created for each UE (User Equipment).
> > By performing RSS based on this flow, it is possible to apply RSS for
> > each communication unit from the UE.
> > Without this, RSS would only be effective within the range of IP addres=
ses.
> > For instance, the PGW can only perform RSS within the IP range of the S=
GW.
> > What I'm trying to say is that RSS based solely on IP addresses can be
> > problematic from a load distribution perspective, especially if
> > there's a bias in the terminals connected to a particular base
> > station.
> > As a reference that discusses a similar topic, please see the link
> > below(is not RSS, is TEID Flow):
> > https://docs.nvidia.com/networking-ethernet-software/cumulus-linux-56/L=
ayer-3/Routing/Equal-Cost-Multipath-Load-Sharing/#gtp-hashing
>
> Makes sense, thanks for the extra information. I think it would be
> worth adding all of this to the commit message!
>
> Regarding the patch - you are only adding flow types, not a new field
> (which are defined as RXH_*). If we want to hash on an extra field,
> I think we need to specify that field as well?
>
> > Thank you for your understanding.
> > ---
> > Sorry! My email was blocked because it wasn't sent in plain text mode.
> > I've made the necessary changes and will resend it.
>
> No worries! Additional request - in the future please prefer the
> bottom-posting or interleaved style of replies:
> https://en.wikipedia.org/wiki/Posting_style#Interleaved_style

