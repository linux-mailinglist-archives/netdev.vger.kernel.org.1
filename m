Return-Path: <netdev+bounces-14546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5097424F4
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 13:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76623280CD6
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 11:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEF510953;
	Thu, 29 Jun 2023 11:29:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ADAD51C
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 11:29:22 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C12A30EF
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 04:29:20 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666e3b15370so406563b3a.0
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 04:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688038160; x=1690630160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfFuThe/qoMIzWjTwGboo239F1nJd90UWgAoB6QoOsc=;
        b=hGNohoohoand6sYmOE6Fyi221R8jV942yuGsQFCDjACZgO8QG+ccaRDHsCrEI9M3WO
         irZQYSIDlhoKaajGW/85gVO8z28CAC3eBYJbB1IlM0fsKvPXiOMNCMyECXQu0MFK9IVT
         Na8ZcqO1uCTTJPiKVCQbad8EqpE42YbLGKfj15SVvTn9RiAGRox7y58x8k7Sfv6qldXf
         pKmTyKXy2SS0Zy7Bn0oYi62TX8cNqSLMOOkFpxgZask4TcwiVtl2cGFp/o4hl3evUtgG
         2u7sZQm6sjWNWGfc+P/yK6/VQkfSazqD8ztd8ygfbpPoWz4pO/l1eIN3ZniLBL8qi2Fn
         cZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688038160; x=1690630160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfFuThe/qoMIzWjTwGboo239F1nJd90UWgAoB6QoOsc=;
        b=GBjx6shSa6oI0KlwgOh6i76x/nRan7O7QaKGTvWY7Y/887X2706tQTrg7HNFECpw4v
         RpoEABQFen5dZiElPaq0Kejkddc+BCd/z5N53fxYzCPjxlhRNrFkM7gHgdJjyHN3YUgc
         GZxSAssha+HWlunCXfnHOR3QN/KJJDRkT2MOWX9ZGeyKE8Hwx2ejIjHmfYTqcOs1kQYm
         avCzrKJrLyWIYdcpSi+x1yxfJN40HSvjShdkU+nuQTEYKf31Xay19UqP7km0gRFeJSFu
         tnZT2qp0Dmpxbv10gfQKpaJQZafFpAt7wFqxKlY962wDZwnod47muVBFN26hBSFnv7ra
         Sn5w==
X-Gm-Message-State: AC+VfDw3YzQHQun/pEh1UQihthgZMrU4Ul58OjeI/ViB1lZXAaGrWSc8
	WARz1Dz9vBVJghJgA2kCteU=
X-Google-Smtp-Source: ACHHUZ4Xk/z/bHUiwLYrZYqWdxImDCmhy4j0eyvPIpQ8LIQkywIimLFSdtx8SVfbS8hUjsGaqR99XQ==
X-Received: by 2002:a05:6a20:1609:b0:105:94e5:f5c5 with SMTP id l9-20020a056a20160900b0010594e5f5c5mr28539912pzj.56.1688038159515;
        Thu, 29 Jun 2023 04:29:19 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id v26-20020aa7809a000000b006589cf6d88bsm8566325pff.145.2023.06.29.04.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 04:29:18 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
	id 8F47D80F639E; Thu, 29 Jun 2023 18:29:15 +0700 (WIB)
Date: Thu, 29 Jun 2023 18:29:15 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Martin Zaharinov <micron10@gmail.com>, netdev <netdev@vger.kernel.org>,
	Eric Dumazet <edumazet@google.com>
Cc: Linux Regressions <regressions@lists.linux.dev>
Subject: Re: Bug Report with kernel 6.3.5
Message-ID: <ZJ1rC8WieLkJLHFl@debian.me>
References: <20F611B6-2C76-4BD3-852D-8828D27F88EC@gmail.com>
 <ZHwkQcouxweYYhTX@debian.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TZC7wl6DVJTO11zM"
Content-Disposition: inline
In-Reply-To: <ZHwkQcouxweYYhTX@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--TZC7wl6DVJTO11zM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 04, 2023 at 12:42:25PM +0700, Bagas Sanjaya wrote:
> On Sun, Jun 04, 2023 at 07:51:36AM +0300, Martin Zaharinov wrote:
> > Hi Team one bug report=20
> >=20
> > after upgrade from kernel 6.2.12 to 6.3.5=20
> > After fell hour system get this error.
> >=20
> > If is possible to check.
> >=20
> >=20
> > Jun  4 01:46:52  [12810.275218][  T587] INFO: task nginx:3977 blocked f=
or more than 609 seconds.
> > Jun  4 01:46:52  [12810.275350][  T587]       Tainted: G           O   =
    6.3.5 #1
> > Jun  4 01:46:52  [12810.275436][  T587] "echo 0 > /proc/sys/kernel/hung=
_task_timeout_secs" disables this message.
> > Jun  4 01:46:52  [12810.275527][  T587] task:nginx         state:D stac=
k:0     pid:3977  ppid:1      flags:0x00000006
> > Jun  4 01:46:52  [12810.275624][  T587] Call Trace:
> > Jun  4 01:46:52  [12810.275707][  T587]  <TASK>
> > Jun  4 01:46:52  [12810.275786][  T587]  __schedule+0x352/0x820
> > Jun  4 01:46:52  [12810.275878][  T587]  schedule_preempt_disabled+0x61=
/0xe0
> > Jun  4 01:46:52  [12810.275963][  T587]  __mutex_lock.constprop.0+0x481=
/0x7a0
> > Jun  4 01:46:52  [12810.276049][  T587]  ? __lock_sock_fast+0x1a/0xc0
> > Jun  4 01:46:52  [12810.276135][  T587]  ? lock_sock_nested+0x1a/0xc0
> > Jun  4 01:46:52  [12810.276217][  T587]  ? inode_wait_for_writeback+0x7=
7/0xd0
> > Jun  4 01:46:52  [12810.276307][  T587]  eventpoll_release_file+0x41/0x=
90
> > Jun  4 01:46:52  [12810.276416][  T587]  __fput+0x1d9/0x240
> > Jun  4 01:46:52  [12810.276517][  T587]  task_work_run+0x51/0x80
> > Jun  4 01:46:52  [12810.276624][  T587]  exit_to_user_mode_prepare+0x12=
3/0x130
> > Jun  4 01:46:52  [12810.276732][  T587]  syscall_exit_to_user_mode+0x21=
/0x110
> > Jun  4 01:46:52  [12810.276847][  T587]  entry_SYSCALL_64_after_hwframe=
+0x46/0xb0
> > Jun  4 01:46:52  [12810.276954][  T587] RIP: 0033:0x15037529155a
> > Jun  4 01:46:52  [12810.277056][  T587] RSP: 002b:000015036bbb6400 EFLA=
GS: 00000293 ORIG_RAX: 0000000000000003
> > Jun  4 01:46:52  [12810.277185][  T587] RAX: 0000000000000000 RBX: 0000=
15036bbb7420 RCX: 000015037529155a
> > Jun  4 01:46:52  [12810.277311][  T587] RDX: 0000000000000000 RSI: 0000=
000000000000 RDI: 0000000000000013
> > Jun  4 01:46:52  [12810.277440][  T587] RBP: 00001503647343d0 R08: 1999=
999999999999 R09: 0000000000000000
> > Jun  4 01:46:52  [12810.277567][  T587] R10: 000015037531baa0 R11: 0000=
000000000293 R12: 0000000000000ba5
> > Jun  4 01:46:52  [12810.277693][  T587] R13: 0000150348731f48 R14: 0000=
000000000000 R15: 000000001f5b06b0
> > Jun  4 01:46:52  [12810.277820][  T587]  </TASK>
> >=20
>=20
> Can you clearly describe this regression? And your nginx setup? And most
> importantly, can you please bisect between v6.2 and v6.3 to find the
> culprit? Can you also check the mainline?
>=20
> Anyway, thanks for the regression report. I'm adding it to regzbot:
>=20
> #regzbot ^introduced: v6.2.12..v6.3.5
> #regzbot title: nginx blocked for more than 10 minutes on 6.3.5
>=20

No reply from Martin (MIA), thus removing from regzbot tracking:

#regzbot inconclusive: reporter MIA when being asked to provide regression =
details

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--TZC7wl6DVJTO11zM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZJ1rBwAKCRD2uYlJVVFO
o98vAQCfmPM0/FgOA6TnBKdHZKH7NpIqApgAM7RSqDd1ff7fYQEA2jh5tomQyWRj
9PcS4byaAkXqO13KyoqSebAaELNx0Q8=
=P9rd
-----END PGP SIGNATURE-----

--TZC7wl6DVJTO11zM--

