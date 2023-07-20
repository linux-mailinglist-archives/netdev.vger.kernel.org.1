Return-Path: <netdev+bounces-19455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4578B75ABCC
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 12:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D806A281D5E
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 10:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1733174F1;
	Thu, 20 Jul 2023 10:20:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35A4199E7
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 10:20:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E5310CB
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 03:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689848407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U9gHz/fFp0Gl9tgjEgz3BmVFVaQ9EGXgU4wCFul7DOo=;
	b=VQBF3d4GTRMKhno4QbLKoQjAZXd+H3/Y+RLVbxZ4XzVqrS05YGVqpCxyytz6KUbNkSpQKo
	ty+IK2NhfPFuy9zsDgKxIRBu98lUnDd6zeNUj/qloxfSlOm42QhViercRy2BQZWl2pIF84
	pNbM4A6aHq0axLDXdQxcLONOShZLlwI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-I_3BkyHzPNiamiVPOhRobw-1; Thu, 20 Jul 2023 06:20:06 -0400
X-MC-Unique: I_3BkyHzPNiamiVPOhRobw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-402fa256023so1894031cf.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 03:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689848405; x=1690453205;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U9gHz/fFp0Gl9tgjEgz3BmVFVaQ9EGXgU4wCFul7DOo=;
        b=fOR6z3YMkF6Ot2HxVOvAkHBYOl1lJEKWe/GfgfDHtLtOfpc1iHDePjoWMr84V9OmJq
         5yr4SH4Tb2ni3mMeGOefOBBHwqmhaPXTJW3ThWwh793zXjWNP+8yiteiRK1/n4Ds3RYU
         UZOqQ453QlTaLuPvmqzKKy1IEh2oC3JV3N4M9vInhWUM3CQbaSzSGLgq8UNHtp85p+go
         t+heGS/6pgWiw35IWeQ/GTw3tk7fBaTd4qJ3SRtWa8GiP0uNcV3T5M3kray+bm4KlX8F
         hRKUB+cjHq7ZWhiyOW+Q73IGWhv4UetOv1H+zMUtAcAKtsNeQnVIV9a3AR8OjhwNpYko
         c0hQ==
X-Gm-Message-State: ABy/qLbRaiJWoU0nCgCJDuHN4tIvaCJt09N9DT2r82IyABwPscIPKNRB
	KpL2uhlaHbq46FUGMDcFUx3IeLoTBjddQtceEhnVk20u0VCkk8uUjAi2ltsX4cQCby8rbV6eR3q
	yvOXlpQihmVi675pF
X-Received: by 2002:ac8:5905:0:b0:403:b11f:29f0 with SMTP id 5-20020ac85905000000b00403b11f29f0mr3026678qty.0.1689848405743;
        Thu, 20 Jul 2023 03:20:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGE3+67AknhjLaEMWKEAymuZIBin5scI4dUP+C7OqKPViLquW0m6kc0lCdBPRL9n8Wj/zRBwg==
X-Received: by 2002:ac8:5905:0:b0:403:b11f:29f0 with SMTP id 5-20020ac85905000000b00403b11f29f0mr3026655qty.0.1689848405474;
        Thu, 20 Jul 2023 03:20:05 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id k7-20020ac81407000000b003f6ac526568sm214341qtj.39.2023.07.20.03.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 03:20:05 -0700 (PDT)
Message-ID: <47eb92888fa46315214ad921a9ac45b695355a36.camel@redhat.com>
Subject: Re: [PATCH net v4] bonding: Fix error checking for
 debugfs_create_dir()
From: Paolo Abeni <pabeni@redhat.com>
To: =?UTF-8?Q?=E7=8E=8B=E6=98=8E-=E8=BD=AF=E4=BB=B6=E5=BA=95=E5=B1=82?=
 =?UTF-8?Q?=E6=8A=80=E6=9C=AF=E9=83=A8?= <machel@vivo.com>, Jay Vosburgh
 <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Taku Izumi <izumi.taku@jp.fujitsu.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "opensource.kernel" <opensource.kernel@vivo.com>, 
	"ttoukan.linux@gmail.com"
	 <ttoukan.linux@gmail.com>, "jay.vosburgh@canonical.com"
	 <jay.vosburgh@canonical.com>
Date: Thu, 20 Jul 2023 12:20:01 +0200
In-Reply-To: <20230719020822.541-1-machel@vivo.com>
References: <20230719020822.541-1-machel@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-07-19 at 02:10 +0000, =E7=8E=8B=E6=98=8E-=E8=BD=AF=E4=BB=B6=E5=
=BA=95=E5=B1=82=E6=8A=80=E6=9C=AF=E9=83=A8 wrote:
> The debugfs_create_dir() function returns error pointers,
> it never returns NULL. Most incorrect error checks were fixed,
> but the one in bond_create_debugfs() was forgotten.
>=20
> Fixes: f073c7ca29a4 ("bonding: add the debugfs facility to the bonding dr=
iver")
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  drivers/net/bonding/bond_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/bonding/bond_debugfs.c b/drivers/net/bonding/bon=
d_debugfs.c
> index 594094526648..d4a82f276e87 100644
> --- a/drivers/net/bonding/bond_debugfs.c
> +++ b/drivers/net/bonding/bond_debugfs.c
> @@ -88,7 +88,7 @@ void bond_create_debugfs(void)
>  {
>  	bonding_debug_root =3D debugfs_create_dir("bonding", NULL);
> =20
> -	if (!bonding_debug_root)
> +	if (IS_ERR(bonding_debug_root))
>  		pr_warn("Warning: Cannot create bonding directory in debugfs\n");
>  }
> =20

Does not apply cleanly to -net. To be more accurate, the patch is
base64 encoded and git is quite unhappy to decode it.

Possibly your mail server is doing something funny in between?!?

Please solve the above before reposting.

/P


