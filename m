Return-Path: <netdev+bounces-19349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6672675A5F5
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 08:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1322E281AD8
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 06:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DCF3FE4;
	Thu, 20 Jul 2023 06:00:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129533D99
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 06:00:45 +0000 (UTC)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5AD2130
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 23:00:41 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-267711d2b43so68196a91.0
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 23:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1689832840; x=1690437640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtAo4mjJBub60XWMBv8RYd5J7m4MnOyLAC7LPGP3KxI=;
        b=dN9ux6c865oFKsf2ygQ1/30J9cYIxGwswQHOvg7GC2us6TNA9FZPncM/M/aqlojGZU
         XFCN7ZrfDVQIA3kL/7SdniQfidXF84siYWJ0fgb/+OxEKiJB0AjKN3BwF93QrQb7uyC+
         qThezW6FzcimavwO5sGiuCyAHAl5Ho6/Yl9S0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689832840; x=1690437640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtAo4mjJBub60XWMBv8RYd5J7m4MnOyLAC7LPGP3KxI=;
        b=TYgqyF+VmZ4MyRPBhCd1Ekx/4elCinDleWFeg3t+dmB0XfUJA6kKirUTt5mQpnx/wX
         Kg2asXCsILstUq1P6KyWzSheTqP1a6SJFm7BRAFYe0zUzqBqdm+KXVEZ/grYlYGxIVGa
         gD+B262p0Kca21jeUT9B/L3uJ1hSoThlITZPVYc/jnj2Jjz4NT/tohDSIiqRsU5auWE9
         3gR6llZoY7ldQWD1+cZlHoer3ZSSocJRh4Dxzu1BC53uedgAGritqcyomcdYEeVHKJ5S
         BVyVns2uhFdK6jRuqAidBw9RlruYEtNIJezN7+vNbBwGi1S7lJhIfwJqZCfNCRtvVYXc
         qsBQ==
X-Gm-Message-State: ABy/qLaXCkskhv8hOscwWfkpxOoPQMrI8EsKgh3J1szuqjDetBNK2cQ/
	1UUJhSbpQNb71lhz+CgYkh9okfDGqpyyPu6/vw/ddw==
X-Google-Smtp-Source: APBJJlH7IDJturi9ztd5thyCUYM+2O3dRdnsCuz2V8+lnzwIxOFaSl2RuroBWcha/7q0B5Ww4N/1POCDpjVG9nCYQmo=
X-Received: by 2002:a17:90a:8cd:b0:263:730b:f568 with SMTP id
 13-20020a17090a08cd00b00263730bf568mr1365299pjn.3.1689832840281; Wed, 19 Jul
 2023 23:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH0PR11MB51269B6805230AB8ED209B14D332A@PH0PR11MB5126.namprd11.prod.outlook.com>
 <20230720105042.64ea23f9@canb.auug.org.au> <20230719182439.7af84ccd@kernel.org>
 <20230720130003.6137c50f@canb.auug.org.au> <PH0PR11MB5126763E5913574B8ED6BDE4D33EA@PH0PR11MB5126.namprd11.prod.outlook.com>
 <20230719202435.636dcc3a@kernel.org>
In-Reply-To: <20230719202435.636dcc3a@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 20 Jul 2023 08:00:29 +0200
Message-ID: <CAJqdLroJK34pNGMO8owToH1_Hjtk=1Tf29L4-chw75dqw_UP6g@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bluetooth tree
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, David Miller <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 5:24=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 20 Jul 2023 03:17:37 +0000 Von Dentz, Luiz wrote:
> > Sorry for not replying inline, outlook on android, we use scm_recv
> > not scm_recv_unix, so Id assume that change would return the initial
> > behavior, if it did not then it is not fixing anything.
>
> Ack, that's what it seems like to me as well.
>
> I fired up an allmodconfig build of linux-next. I should be able
> to get to the bottom of this in ~20min :)

Dear friends,

I'm here and ready to help with fixing this. As far as I understand
everything should work,
because in 817efd3cad74 ("Bluetooth: hci_sock: Forward credentials to monit=
or")
we have a call to scm_recv(sock, msg, &scm, flags). And scm_recv does
not use scm_pidfd_recv (and pidfd_prepare).

Please tell me if something is not working and which tree I should
take to reproduce it. I'm ready to dive into it.

Kind regards,
Alex

