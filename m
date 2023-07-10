Return-Path: <netdev+bounces-16305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD4474CA48
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 05:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62D331C20930
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 03:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130F217F2;
	Mon, 10 Jul 2023 03:16:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016AB17D2
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 03:16:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD37FB
	for <netdev@vger.kernel.org>; Sun,  9 Jul 2023 20:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688959006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a62DSLSpXeASP7dYpa5HsA33PutQ3KjJO6C/G/Q8iAk=;
	b=EtDC9taNDHxe3UhqS0Y14C9GRRrvbHW+ueIqProwcxJlRByuZtx+cnvnRc7Z+G7cq9wh87
	wU5+SGTKeEdB3+kJ+G22FYsTIEf30g1tID9cqbrtAlJhwKGWro5WCVQVlKI7XiccCJngZH
	P42ZiJogMaJfuwV5F7AvW0EP+f4sVCc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-VD7rjbhSPgOPpiseE_ovLA-1; Sun, 09 Jul 2023 23:16:45 -0400
X-MC-Unique: VD7rjbhSPgOPpiseE_ovLA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b6cf671d94so33348411fa.1
        for <netdev@vger.kernel.org>; Sun, 09 Jul 2023 20:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688959004; x=1691551004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a62DSLSpXeASP7dYpa5HsA33PutQ3KjJO6C/G/Q8iAk=;
        b=EsOKjxtqALEdZRwr1Wg5GbPKGmogwaIBbks7cDXTOpixzNfWRr5ZcEvaewYE+UcBOh
         mtCRD8Nd96nHUF3Aj6aojbV8J4+qzHK3a/3pkLzNYhGaUgfTGAoibm+XAard9VJFjfsu
         lkLguXjOlCC2gqMJ/Ol65KIVXXFvGKkYN6akACMm3d/nISk3JPNqB8arN/NgdAakWZjh
         EB83/tXgXUyNDkTXr2vgk55pteo5uKA48pzG+JgFPDcW5eJRZKtGoVupILLSTIYvi6T2
         y5pY/3WkHem+Xusr7WcYPFW+mlNmTkOWzpkYbbMLHrMnepJ3ZRG0rzcFfcVp0bY/5CQf
         v7Ew==
X-Gm-Message-State: ABy/qLYcZ9nD0Ll74cBk6R6+hUsNBPtYF1GZHMVVRgRBRYxZB3BG5QLw
	akiFwuAzem6XDjHiDWWvUK9UlxrJdoAQQAWQ9PqIOd1px+msP19Y7me3B51QcxtDaAXFNGzqG2D
	kN25kGCqnCevOJYSntWkXi1hdTcxxwiI0
X-Received: by 2002:a05:651c:1025:b0:2b6:a22f:9fb9 with SMTP id w5-20020a05651c102500b002b6a22f9fb9mr8375731ljm.27.1688959004008;
        Sun, 09 Jul 2023 20:16:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEnVegvrkpNt0TR6XRnujYIiNrsRYYJzxc37gJtNWKUE7a5YX0jPBMxs0gFC9cJdQNoUf+kMZdSTNMkLAa3IKo=
X-Received: by 2002:a05:651c:1025:b0:2b6:a22f:9fb9 with SMTP id
 w5-20020a05651c102500b002b6a22f9fb9mr8375700ljm.27.1688959002988; Sun, 09 Jul
 2023 20:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230706231718.54198-1-shannon.nelson@amd.com>
In-Reply-To: <20230706231718.54198-1-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Jul 2023 11:16:32 +0800
Message-ID: <CACGkMEuD9DgK7CEp0cW-he3FAbzDVsvnhvouLWAMv9bUrq+ATA@mail.gmail.com>
Subject: Re: [PATCH virtio] pds_vdpa: protect Makefile from unconfigured debugfs
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: rdunlap@infradead.org, mst@redhat.com, 
	virtualization@lists.linux-foundation.org, brett.creeley@amd.com, 
	netdev@vger.kernel.org, drivers@pensando.io, sfr@canb.auug.org.au, 
	linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 7, 2023 at 7:17=E2=80=AFAM Shannon Nelson <shannon.nelson@amd.c=
om> wrote:
>
> debugfs.h protects itself from an undefined DEBUG_FS, so it is
> not necessary to check it in the driver code or the Makefile.
> The driver code had been updated for this, but the Makefile had
> missed the update.
>
> Link: https://lore.kernel.org/linux-next/fec68c3c-8249-7af4-5390-0495386a=
76f9@infradead.org/
> Fixes: a16291b5bcbb ("pds_vdpa: Add new vDPA driver for AMD/Pensando DSC"=
)
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/pds/Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/pds/Makefile b/drivers/vdpa/pds/Makefile
> index 2e22418e3ab3..c2d314d4614d 100644
> --- a/drivers/vdpa/pds/Makefile
> +++ b/drivers/vdpa/pds/Makefile
> @@ -5,6 +5,5 @@ obj-$(CONFIG_PDS_VDPA) :=3D pds_vdpa.o
>
>  pds_vdpa-y :=3D aux_drv.o \
>               cmds.o \
> +             debugfs.o \
>               vdpa_dev.o
> -
> -pds_vdpa-$(CONFIG_DEBUG_FS) +=3D debugfs.o
> --
> 2.17.1
>


