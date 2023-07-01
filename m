Return-Path: <netdev+bounces-14966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAED744A1F
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 16:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A89C281117
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 14:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D148EC2E9;
	Sat,  1 Jul 2023 14:52:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E0A566F
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 14:52:03 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A5A35AB
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 07:52:00 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-39eab4bcee8so2190262b6e.0
        for <netdev@vger.kernel.org>; Sat, 01 Jul 2023 07:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688223119; x=1690815119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4Vvz+NxgmcnglJSaOiYfOTqGa31XUnul9o/nLqp0XE=;
        b=TraCPekw+6Oe3ikNwgm3vM964y9Sbne4iTDEpK4i5iF9lLAP0D1jcuBZNwCjFFSDau
         PGy1uup79ZF6Sxqu0u09tchQh8NgqGDQOp2ON+jniNYsJT1ZGnsdGmLsQozLmG/Q1wlO
         sNY7QxlXpMyE6IHpCpFHEsSZhJDY2KoxyrWuqW8uVgy8FnV81ct8B7YJw2I+UKw/0r9y
         q0/C6z8gx8/nD0OKypORt5XjD2QP6EYyb10W6qYDvA+pYJ2wLjf8Sgz8S5H/2pYaCLWE
         fmmceCtxRGZxcsCyDe3EMd310hgKUm2uT4vs1fGZidOEJg5jSksGxaBuAMNUhtqEZMNG
         gyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688223119; x=1690815119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4Vvz+NxgmcnglJSaOiYfOTqGa31XUnul9o/nLqp0XE=;
        b=TzoBHRpQUw1W+JyuzhF146P2VmG2Ge6UnZ9Ip66CTqSUVmSFmHEWtCrwAPNBMelWpd
         7cSi/NOiBOLTF80Le8dmevRh8rQR6CwlSYptKstTlSFQTIwCI8Wo3pcLlLhKuM85D679
         tnMKn03JqdbunG6FYNprXUGoCE9mapOq7EQrx3FazmfXKckw/3uuU6NlbRDAeAcyx20i
         STGrp87KnYHz0s0sqf0HiwMYxTnyMDAI7Bt1uEd4vMpW2PSS4dpIyzxHSdpwaelTpQga
         3odwvhlGvVsl1PqvDIYxn1xAA/1vOs4q3TCELro48iaRGZ3cUsoKahMrALIcVkRE7MC2
         9U9g==
X-Gm-Message-State: AC+VfDz0c0UwLqo0sYN/aJvwVNmZOFyYxsaDDJTRqamAN9yRmgyoGblO
	gUk9LxYq2k1iimw/NXqQls0IlctqDdJp6JVZ7xM=
X-Google-Smtp-Source: ACHHUZ6PNmFZc/xS1JswIpF3V0olKqDpyBkNeSAl5b7FCMH2cc9Yzo4FCbz0HCWAUUH+AgP4jj3wAZ21cAsq41JyoKU=
X-Received: by 2002:a54:4713:0:b0:39e:5892:8539 with SMTP id
 k19-20020a544713000000b0039e58928539mr5965518oik.9.1688223119551; Sat, 01 Jul
 2023 07:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230502043150.17097-1-glipus@gmail.com> <20230620192313.02df5db3@kernel.org>
 <20230701100347.eqijafwdsc6mc6lb@skbuf>
In-Reply-To: <20230701100347.eqijafwdsc6mc6lb@skbuf>
From: Max Georgiev <glipus@gmail.com>
Date: Sat, 1 Jul 2023 08:51:48 -0600
Message-ID: <CAP5jrPGcrL6TvNV2QeaHowEETyMH=9u9q5iw2F86qbzdj3uRFg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 0/5] New NDO methods ndo_hwtstamp_get/set
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Jakub Kicinski <kuba@kernel.org>, kory.maincent@bootlin.com, netdev@vger.kernel.org, 
	maxime.chevallier@bootlin.com, vadim.fedorenko@linux.dev, 
	richardcochran@gmail.com, gerhard@engleder-embedded.com, liuhangbin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 1, 2023 at 4:03=E2=80=AFAM Vladimir Oltean <vladimir.oltean@nxp=
.com> wrote:
>
> On Tue, Jun 20, 2023 at 07:23:13PM -0700, Jakub Kicinski wrote:
> > On Mon,  1 May 2023 22:31:45 -0600 Maxim Georgiev wrote:
> > > This stack of patches introduces a couple of new NDO methods,
> > > ndo_hwtstamp_get and ndo_hwtstamp_set. These new methods can be
> > > implemented by NIC drivers to allow setting and querying HW
> > > timestamp settings. Drivers implementing these methods will
> > > not need to handle SIOCGHWTSTAMP/SIOCSHWTSTAMP IOCTLs.
> > > The new NDO methods will handle copying request parameters
> > > between user address space and kernel space.
> >
> > Maxim, any ETA on the next version? Should we let someone take over?
> > It's been over a month since v6 posting.
>
> Assuming Maxim does not respond, can I try to take over? I may have some
> time this weekend to play with some PTP related stuff.

Yes, it looks like I hold back everyone.
Vladimir, you are welcome to take over this patch stack.

