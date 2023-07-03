Return-Path: <netdev+bounces-15080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7013F745884
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 11:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129C7280C6D
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 09:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AB82119;
	Mon,  3 Jul 2023 09:36:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C64720F7
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 09:36:53 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C266D91
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 02:36:52 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57059f90cc5so49588007b3.0
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 02:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688377011; x=1690969011;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0eZiFXW9Ju4K3xie6ZNb6cOckxZbLpuUBrtke5dHQM=;
        b=oU/VLi2mewFAa38gcuCP9A6LzivNVNDH6YOFHLmcsvqB3MbO+n3EFO26iOpboHEnfv
         goOkSsUHMhGGkO6C6Qt7naxU0qQo4Je2DcOtHQgdsUVu9Q3oSkuymfyTvLcJDThjjhBi
         gYfH6R7FK0uHgIWZbjgKIsyz2cBLmIbOlBaHzQmlWLxg1xzIhTXgMSwW8spVqAQShbMo
         hPW7M8NR9T3q84plJUu0ceDjyxX1v4GulxTLUbOn2ljDv4Y+oIqKLw14NA2U2EdO2B2c
         SVAod3k5F/sHhR7HhBYyfhG9B0IeyaZKf+zoIzYI4jaFffzEJJabO6m8ZlE4znWyRTeD
         ADkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688377011; x=1690969011;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F0eZiFXW9Ju4K3xie6ZNb6cOckxZbLpuUBrtke5dHQM=;
        b=mCJpHiZJc7y0ylNEHET9b0dzLzJnoZJHd8rJCbhXokN1FlvYdkUf8MtN2jzzoKn/3S
         G7F2PVwJqt5EuZkYqu6lSut4yp17UwyLGJdIc19/jXFT+PPX3p3JGuz8pl8IY+YsP6xP
         03omtHx+fteZB13V/lSAkY1u04nNfuvEb2ccNUSqRsyU7yJI/ZlCZibXiMbiOxNU47U3
         ZEWjEGJOp2v1HlBX5YCZkk1OnkTXsaZ2zSWzD6WNBkRDXDCttivaVQgIdIbB1L7LmvU1
         k7FkGD1j7gnbEqiOHHOYLKt8bP0UNPe1RuMC2fkaYc6FLU99o8S0s+PCUtWlhPJHPGnH
         VzYw==
X-Gm-Message-State: ABy/qLbdSzn+jzz/wiszjx73RBv7pfjgVl2s22vzKYVzbUMpqcxMojYH
	8x5uf1C3A+BixfcuDHVkjC2hYzgmLyQ=
X-Google-Smtp-Source: APBJJlF3XLqBeCJ5bRpU5duO0tUjw5cT8D4q0XoqKg5aXVoxD4B+UKNJx4piXDt7kM3ItR+2EAPuk9Huq4M=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:7808:ed7:57d0:c891])
 (user=gnoack job=sendgmr) by 2002:a81:b283:0:b0:577:3b0c:5b85 with SMTP id
 q125-20020a81b283000000b005773b0c5b85mr65333ywh.0.1688377011727; Mon, 03 Jul
 2023 02:36:51 -0700 (PDT)
Date: Mon, 3 Jul 2023 11:36:48 +0200
In-Reply-To: <338bba9d-6afa-7c6b-2843-b116abb36859@huawei.com>
Message-Id: <ZKKWoS+clQGLF4O4@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230515161339.631577-1-konstantin.meskhidze@huawei.com>
 <20230515161339.631577-11-konstantin.meskhidze@huawei.com>
 <20230701.acb4d98c59a0@gnoack.org> <4a733dbd-f6e2-dc69-6c8d-47c362644462@digikod.net>
 <338bba9d-6afa-7c6b-2843-b116abb36859@huawei.com>
Subject: Re: [PATCH v11 10/12] selftests/landlock: Add 11 new test suites
 dedicated to network
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: "Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>
Cc: "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>, 
	"=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack3000@gmail.com>, willemdebruijn.kernel@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 03, 2023 at 11:37:13AM +0300, Konstantin Meskhidze (A) wrote:
> 7/2/2023 11:45 AM, Micka=C3=ABl Sala=C3=BCn =D0=BF=D0=B8=D1=88=D0=B5=D1=
=82:
> > Initially Konstantin wrote tests with TEST_F_FORK() but I asked him to
> > only use TEST_F() because TEST_F_FORK() is only useful when a
> > FIXTURE_TEARDOWN() needs access rights that were dropped with a
> > TEST_F(), e.g. to unmount mount points set up with a FIXTURE_SETUP()
> > while Landlock restricted a test process.
> >=20
> > Indeed, TEST_F() already fork() to make sure there is no side effect
> > with tests.
> >=20
>=20
>  Hi, G=C3=BCnther
>  Yep. Micka=D1=91l asked me to replace TEST_F_FORK() with TEST_F(). Pleas=
e check
> this thread
>=20
> https://lore.kernel.org/netdev/33c1f049-12e4-f06d-54c9-b54eec779e6f@digik=
od.net/
> T

Ah thanks, this makes a lot of sense!
I had not realized that TEST_F would also fork a child process,
I should have double checked the selftest implementation.

=E2=80=94G=C3=BCnther

--=20
Sent using Mutt =F0=9F=90=95 Woof Woof

