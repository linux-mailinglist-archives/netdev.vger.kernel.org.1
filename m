Return-Path: <netdev+bounces-14385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 787DB740871
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 04:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37031C204F7
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 02:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BD7139C;
	Wed, 28 Jun 2023 02:34:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B345B7E1
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 02:34:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AB310CC
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 19:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687919693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dCxVeK5h/dORUE2gYkmTMAY5Skn7U71Hm0WtRWaHEYk=;
	b=FyJRXVld5I5+uXYoEtLfG6DQORu8CrVXHXoB57U0/drYN7uKv6surbh7pTMZRnhndGmf57
	qTQQbhJX2UUia0Pcr7SfpnRX0Y57gK+64arj90ztI2DczQIvLulNpgR6cYTfs+hSpF8BZg
	BhakAyWVSoSKiabZucWPIu5o01EKkPQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-VWr_fKYgPxyTRhpHjGwKcw-1; Tue, 27 Jun 2023 22:34:51 -0400
X-MC-Unique: VWr_fKYgPxyTRhpHjGwKcw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fb87c48aceso1160918e87.3
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 19:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687919690; x=1690511690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCxVeK5h/dORUE2gYkmTMAY5Skn7U71Hm0WtRWaHEYk=;
        b=Sby0gth3MVAWq1Wkjshj85EUBj/4qj4i5E1GOC3Nbt1ANDtjt47i+l4uhRyb96uuaO
         8syDXCftzd3lQlsWV2SPi79wRVw8HHmLMQGfani1q8rmLCdJalKxqBzKuy52FSDNUwoG
         2dV8wH/LMfo4TMeDPgB8xlcKBnHjj7WrHRK1IoJYOcaWWZd93kMFda7tS4WQdwPQVC58
         xOLStvfQjNnG4jKP5Kgj+yJcRrFgKV6xHeEU6OL8ZzG1OPgMwhNcgDdLCgdCSX71FL0a
         TbQ5HWWXs6bUQh7s4fm6r9jokKNTkbwM1N0gwfoUW6BBuVG7Eklveatekz8TRy31d8JB
         i+Sg==
X-Gm-Message-State: AC+VfDwtarP7L1Uq4dz6MWVXRzVIBNdqVEzDgz9c/HScFob9+vEc6dE5
	jS40+A9u26/ybjF79h3mSO4iac82PIEAFvHVqN0PwUGwXCy0L19fUyWvFAkNlhHDWKejAtBgQh/
	5DZ4LCp57TJCkirs40eioyogfwK9pweNQ
X-Received: by 2002:a19:2d54:0:b0:4f8:5e5f:b368 with SMTP id t20-20020a192d54000000b004f85e5fb368mr17437569lft.21.1687919689998;
        Tue, 27 Jun 2023 19:34:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6TOdyFneufgIE6Aita5S8TSfhtJ7h2l/bao4uqZmEfdB72MMgC1AzLUSdBVAFlaWW6dl2nrE5KtoGWh4spOKE=
X-Received: by 2002:a19:2d54:0:b0:4f8:5e5f:b368 with SMTP id
 t20-20020a192d54000000b004f85e5fb368mr17437556lft.21.1687919689714; Tue, 27
 Jun 2023 19:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230627113652.65283-1-maxime.coquelin@redhat.com> <20230627113652.65283-2-maxime.coquelin@redhat.com>
In-Reply-To: <20230627113652.65283-2-maxime.coquelin@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Jun 2023 10:34:38 +0800
Message-ID: <CACGkMEveEcB5LsQBSc7kf7JEwDfX3-dc38+6sh7tu_wryROpRw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] vduse: validate block features only with block devices
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: xieyongji@bytedance.com, mst@redhat.com, david.marchand@redhat.com, 
	lulu@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 27, 2023 at 7:37=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> This patch is preliminary work to enable network device
> type support to VDUSE.
>
> As VIRTIO_BLK_F_CONFIG_WCE shares the same value as
> VIRTIO_NET_F_HOST_TSO4, we need to restrict its check
> to Virtio-blk device type.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 5f5c21674fdc..c1c2f4c711ae 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1658,13 +1658,14 @@ static bool device_is_allowed(u32 device_id)
>         return false;
>  }
>
> -static bool features_is_valid(u64 features)
> +static bool features_is_valid(struct vduse_dev_config *config)
>  {
> -       if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
> +       if (!(config->features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
>                 return false;
>
>         /* Now we only support read-only configuration space */
> -       if (features & (1ULL << VIRTIO_BLK_F_CONFIG_WCE))
> +       if ((config->device_id =3D=3D VIRTIO_ID_BLOCK) &&
> +                       (config->features & (1ULL << VIRTIO_BLK_F_CONFIG_=
WCE)))
>                 return false;
>
>         return true;
> @@ -1691,7 +1692,7 @@ static bool vduse_validate_config(struct vduse_dev_=
config *config)
>         if (!device_is_allowed(config->device_id))
>                 return false;
>
> -       if (!features_is_valid(config->features))
> +       if (!features_is_valid(config))
>                 return false;
>
>         return true;
> --
> 2.41.0
>


