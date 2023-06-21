Return-Path: <netdev+bounces-12828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E31A7390A9
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 22:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBC1B28176B
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 20:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217731C759;
	Wed, 21 Jun 2023 20:20:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A74F9D6
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 20:20:33 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D764919BE
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 13:20:29 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31110aea814so6606961f8f.2
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 13:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687378828; x=1689970828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHvYvv2nmaLNjsV2yeFKL4pFCVfSe6yjUFEDIUbKFRI=;
        b=KVwpZeyyfEf+tn0bpYyIi/wVaA+JOh3rGk215qVp+Rs51vWysIsTp3IbmjJ5i/0Sx4
         UQ2jY8LcCWcC6PXk3fYOo7O6csBEYFms244JV7mArIUeKapkWN0U+jx2wITsp7g0B9C/
         thA0r8/4xu49g97c9RwCZzuLJN7x/TRAYeWlhgEvwYm8dRadWw5XjGVbaqgL3kbT3hH6
         XZNq0BlzmwgNcg54vZkuAw0i0itoZH3r+w2pg4JwfJRaXkWQFe1+ByymmK+ftOl6XsIc
         Z/6gSdWyCWPD2JajYunXJRYUPGZ/jag05zvSUUel6xLTq02thJNpIW2ODMxdz/aip8N5
         TMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687378828; x=1689970828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHvYvv2nmaLNjsV2yeFKL4pFCVfSe6yjUFEDIUbKFRI=;
        b=D2OXJch74KnVcF18gdGEqsJOjZBs5q/0tbLDiIiU+IkNnCSRTPKiGpWn5zvKdTyKL+
         PI9WNc7BUBf+JpLKyvQ3mbC9/X60NbMQ/8IFlwsDFBlLiUVUYfty4rWGLXRzF5MSptZU
         jF4wX9dJpExBTxQbJ/EK6kek3vUS/xuTU6EMvb1ttnu1LUO9y6g7XlTtPej30eDTeavZ
         tqDPYW5NbrzLpJb4Qpzel9Q1KQVJT42ACxeLHPE/hm9+gOpW+tCp8qerCOkgfcVCcqGA
         WGH9XEsPsB3OpHrS8am8yz9/84vQWhF9gi95qAyzkDeLEIfleuE1zrFq2nHwElkFE3ju
         7LvQ==
X-Gm-Message-State: AC+VfDxjFC23ewPiwotI5bHSj45GBeuhQ3UZiaR46gEJg85cU31KKgf6
	E6r1/2owdzR4PUOJ2r/UVNUL22IWCLRIsy1Lu5CSAQ==
X-Google-Smtp-Source: ACHHUZ6N7oKhesraMZilrvAdS5HRbmb159m9zl6N4gIAhDOs+9Aoj/EqQh2sgNCK99l5aDhHKQNzos3tMpFfEhOwD8w=
X-Received: by 2002:a5d:6a91:0:b0:311:1128:9634 with SMTP id
 s17-20020a5d6a91000000b0031111289634mr14518596wru.54.1687378828151; Wed, 21
 Jun 2023 13:20:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230616231341.2885622-1-anthony.l.nguyen@intel.com>
 <20230616235651.58b9519c@kernel.org> <1bbbf0ca-4f32-ee62-5d49-b53a07e62055@intel.com>
 <20230621122853.08d32b8e@kernel.org> <03819ef3-8008-43e9-8618-f37f5bc5160b@lunn.ch>
In-Reply-To: <03819ef3-8008-43e9-8618-f37f5bc5160b@lunn.ch>
From: David Decotigny <ddecotig@google.com>
Date: Wed, 21 Jun 2023 13:19:50 -0700
Message-ID: <CAG88wWb+vN+3RFE8KKHY_W9ggBefhFAMZfX+FRNS=8ry_GUOvA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 00/15][pull request] Introduce Intel IDPF driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, emil.s.tantilov@intel.com, 
	jesse.brandeburg@intel.com, sridhar.samudrala@intel.com, 
	shiraz.saleem@intel.com, sindhu.devale@intel.com, willemb@google.com, 
	leon@kernel.org, mst@redhat.com, simon.horman@corigine.com, 
	shannon.nelson@amd.com, stephen@networkplumber.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For information, we have tested this driver as is proposed in its
current form, and merging it into 6.5 would work best, provided that
the follow-up improvements can be provided in a later set of
submissions.

--
David Decotigny -- Platforms, US SVL MAT3 -- go/balance/decot


On Wed, Jun 21, 2023 at 12:45=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Wed, Jun 21, 2023 at 12:28:53PM -0700, Jakub Kicinski wrote:
> > On Wed, 21 Jun 2023 12:13:06 -0700 Linga, Pavan Kumar wrote:
> > > Thanks for the feedback. Given the timing and type of changes request=
ed
> > > for the patches, would it be possible to accept this patch series (v3=
)
> > > in its current form, as we continue to develop and address all the
> > > feedback in followup patches?
> >
> > I think you're asking to be accepted in a Linux-Staging kind of a way?
>
> Or maybe real staging, driver/staging ? Add a TODO and GregKH might
> accept it.
>
>     2.5. Staging trees
>
>     The kernel source tree contains the drivers/staging/ directory,
>     where many sub-directories for drivers or filesystems that are on
>     their way to being added to the kernel tree live. They remain in
>     drivers/staging while they still need more work; once complete,
>     they can be moved into the kernel proper. This is a way to keep
>     track of drivers that aren't up to Linux kernel coding or quality
>     standards, but people may want to use them and track development.
>
> Andrew

