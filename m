Return-Path: <netdev+bounces-19612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA90575B691
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 20:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B283F1C214F0
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 18:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524C219BBA;
	Thu, 20 Jul 2023 18:22:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4497F182C3
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 18:22:34 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D02135
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 11:22:33 -0700 (PDT)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 160683FA7A
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 18:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1689877351;
	bh=digy5DCqNsigl+eVeOkr7OQYNKSxl46kC4WxbLHYBlg=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=PPtuAOeByBa6dsO7beL2cNbL2HbQehOWn7HgV/Ve0XyP019OcdPJIQx0NVqZE3ACq
	 5cduhKXNhT2l6IuR9L6uqxiHuo+UabA7t36m5hSEdUTSjQhjBeVSlYbLrSkmyaipUq
	 rzurL6UcV4UxdRxcQDjQOl2zEl820DAB5c16KItpDozw6vXmExKGLpVqJPsG+TYSZc
	 k4aKeeKyM897huxNQz/5NI3roxLiPAsxYWfFWuDSIN/7DhXNnNttt1GlfE9tolbuOJ
	 r+csL1wh7Uk3w1peS76Zl2dCPymKuJszu4IQThmMFYiqunysgcaucb2byvaNbA1s66
	 GS2Psgi3y0rJA==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1bb1bb45da1so9031025ad.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 11:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689877347; x=1690482147;
        h=message-id:date:content-transfer-encoding:mime-version:comments
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=digy5DCqNsigl+eVeOkr7OQYNKSxl46kC4WxbLHYBlg=;
        b=gQmzfkgCB0ePULYS6q1TEY6tEGzOAKcmecv6pMRQ+zylrJ+XZzkNLAcK922Qy68yIN
         /Fo74qhor/iH1qbmYxCpLz0TfLZTKNkwxXXx7O+bvhVWPMEyLQfe65QbskA9g2jmDIlY
         2uFsaOwiCv6UrvSkZDnI8yFh/2okIadri7SwGYcQKBhwUmjJ5WlFURt27WayKuJSxAc5
         BxyN5ksJt0uVskTn6SuB/kqyDOOZTEoIDNsR4/zgnZ/Dz0AJFyX8kPwhTdWMnJZ5cPwk
         Zbo8oyJp3RfERIL4v844LJec/3H4M3jzsXGvIhsHE1lC/WO5NuNSNoJYB5tlD0eCjI3s
         58yw==
X-Gm-Message-State: ABy/qLYHKj3mg18AIR9r/lmE+nTcvQsnhCg2O/pZ4NgFJ09q+DvJJCIQ
	65bR+KJxdxPEtUC3NjzXFiZtXPZB5UkDa7sGMeMthQdslikBtQuciCmrFPnrx2Dpo55Fsl+4soa
	XZgNMLkHtbNTGQgwJBppxpCiPuopAOv31R1Rj/6NWkA==
X-Received: by 2002:a17:902:b584:b0:1bb:1494:f7f7 with SMTP id a4-20020a170902b58400b001bb1494f7f7mr74729pls.23.1689877347515;
        Thu, 20 Jul 2023 11:22:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG9bQHHgpcEhm4TYUG2OZL2k1KHLsFgBmvmLT9xfcpP0FnGx8Rd3um5aLXu8hfZbDEbokTUcQ==
X-Received: by 2002:a17:902:b584:b0:1bb:1494:f7f7 with SMTP id a4-20020a170902b58400b001bb1494f7f7mr74711pls.23.1689877347187;
        Thu, 20 Jul 2023 11:22:27 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id j8-20020a170902da8800b001b891259eddsm1712395plx.197.2023.07.20.11.22.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jul 2023 11:22:26 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 587EC60283; Thu, 20 Jul 2023 11:22:26 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 5085B9FABB;
	Thu, 20 Jul 2023 11:22:26 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: =?us-ascii?Q?=3D=3FUTF-8=3FQ=3F=3DE7=3D8E=3D8B=3DE6=3D98=3D8E-=3DE8=3D?= =?us-ascii?Q?BD=3DAF=3DE4=3DBB=3DB6=3DE5=3DBA=3D95=3DE5=3DB1=3D82=3F=3D?= =?us-ascii?Q?____=3D=3FUTF-8=3FQ=3F=3DE6=3D8A=3D80=3DE6=3D9C=3DAF=3DE9=3D?= =?us-ascii?Q?83=3DA8=3F=3D?= <machel@vivo.com>,
    Andy Gospodarek <andy@greyhouse.net>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Taku Izumi <izumi.taku@jp.fujitsu.com>,
    "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
    "opensource.kernel" <opensource.kernel@vivo.com>,
    "ttoukan.linux@gmail.com" <ttoukan.linux@gmail.com>
Subject: Re: [PATCH net v4] bonding: Fix error checking for debugfs_create_dir()
In-reply-to: <47eb92888fa46315214ad921a9ac45b695355a36.camel@redhat.com>
References: <20230719020822.541-1-machel@vivo.com> <47eb92888fa46315214ad921a9ac45b695355a36.camel@redhat.com>
Comments: In-reply-to Paolo Abeni <pabeni@redhat.com>
   message dated "Thu, 20 Jul 2023 12:20:01 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Jul 2023 11:22:26 -0700
Message-ID: <25152.1689877346@famine>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Paolo Abeni <pabeni@redhat.com> wrote:

>On Wed, 2023-07-19 at 02:10 +0000, =E7=8E=8B=E6=98=8E-=E8=BD=AF=E4=BB=B6=
=E5=BA=95=E5=B1=82=E6=8A=80=E6=9C=AF=E9=83=A8 wrote:
>> The debugfs_create_dir() function returns error pointers,
>> it never returns NULL. Most incorrect error checks were fixed,
>> but the one in bond_create_debugfs() was forgotten.
>>=20
>> Fixes: f073c7ca29a4 ("bonding: add the debugfs facility to the bonding d=
river")
>> Signed-off-by: Wang Ming <machel@vivo.com>
>> ---
>>  drivers/net/bonding/bond_debugfs.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/net/bonding/bond_debugfs.c b/drivers/net/bonding/bo=
nd_debugfs.c
>> index 594094526648..d4a82f276e87 100644
>> --- a/drivers/net/bonding/bond_debugfs.c
>> +++ b/drivers/net/bonding/bond_debugfs.c
>> @@ -88,7 +88,7 @@ void bond_create_debugfs(void)
>>  {
>>  	bonding_debug_root =3D debugfs_create_dir("bonding", NULL);
>>=20=20
>> -	if (!bonding_debug_root)
>> +	if (IS_ERR(bonding_debug_root))
>>  		pr_warn("Warning: Cannot create bonding directory in debugfs\n");
>>  }
>>=20=20
>
>Does not apply cleanly to -net. To be more accurate, the patch is
>base64 encoded and git is quite unhappy to decode it.
>
>Possibly your mail server is doing something funny in between?!?
>
>Please solve the above before reposting.

	It appears to have trailing carriage returns on every line after
base64 decoding, i.e.,

$ git am /tmp/test.patch
[ this fails ]
$ git am --show-current-patch=3Ddiff > /tmp/patch2
$ cat -v /tmp/patch2=20
---^M
 drivers/net/bonding/bond_debugfs.c | 2 +-^M
 1 file changed, 1 insertion(+), 1 deletion(-)^M
^M
diff --git a/drivers/net/bonding/bond_debugfs.c b/drivers/net/bonding/bond_=
debugfs.c^M
index 594094526648..d4a82f276e87 100644^M
--- a/drivers/net/bonding/bond_debugfs.c^M
+++ b/drivers/net/bonding/bond_debugfs.c^M
@@ -88,7 +88,7 @@ void bond_create_debugfs(void)^M
[...]

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

