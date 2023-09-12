Return-Path: <netdev+bounces-33017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBC679C3EF
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 05:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD191C209D5
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 03:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E1315487;
	Tue, 12 Sep 2023 03:18:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD6B9448
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 03:18:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBB77768D
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 20:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694488710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yeybBoB7J55cAsRT4vB+kKuTH4cQaXdnVyGYiAsXlEA=;
	b=JGT/gMsTQIcKbr7XpWUGNCTYwphaZm5z9FDekn/tvClE7gm4F/aK1Acxir8/zG7mGTUzMj
	4mfQa7swxHcxmpdIWlEcuItFOe0SOWDwEJRXaIGVgnOtzuD/kFN2MrK9lKn+rlTExMawUH
	see7i43W826592NwAlZAsYY9xVAy2cQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-BbVf5iu7MhqIVNgnagD0kA-1; Mon, 11 Sep 2023 23:18:29 -0400
X-MC-Unique: BbVf5iu7MhqIVNgnagD0kA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5008240846fso3262417e87.1
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 20:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694488708; x=1695093508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yeybBoB7J55cAsRT4vB+kKuTH4cQaXdnVyGYiAsXlEA=;
        b=UzPisv3C45AJ32NDCswnSiCVd34YXbvrXomOIg5+xC4e6f9LlWYCjGieiuL4lkTBh2
         FycZAW9ORuXiGOgyEsBkfS8/peLw4QlKMMIin4yN0NHpOwwiDs3+/m2ArbZ2XmkGz/ep
         587zNB8X4R2cg+xSM85j8rlqLQbTEKAIjYJvRUukRRecZu5xr1hSSubXm5aiAnmOrhfy
         66NqE1WOS3H/cZIDQWPCMX004JbjX8O2XxO1dt1hWidqLbZ/iNo89JLjv6xdhhojJBUn
         0cBli7Wq5BPUZZ5brb5x6+cVHOFFkcSXsPbnE5I4+H9avKOYbZ3pqpbCxULSa/DRObIp
         clpA==
X-Gm-Message-State: AOJu0YwFSyXdBzYr+tyqVP62ODVkazJlVxYFwKyyKU/B8/UppzAUQrYi
	94YPkEp9X4f9LliMguZNXe96PZ+wfe7ttv/zgODRAoQPLFTLTMWD9YDsxrOni3LZhIJG0glWu76
	0OnZ5tgl+cD4SrzExiHA0zg9/jsnPDnjX
X-Received: by 2002:a05:6512:2316:b0:4fe:bfa:9d8b with SMTP id o22-20020a056512231600b004fe0bfa9d8bmr483626lfu.12.1694488708170;
        Mon, 11 Sep 2023 20:18:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcI0EBEc/QXrime6KsTNxJiED9DaU9PSMy94XNYwPaePPhMWRnYMoxdWeG/PqyWi06hFiToOQxQZyCUvQ+zf4=
X-Received: by 2002:a05:6512:2316:b0:4fe:bfa:9d8b with SMTP id
 o22-20020a056512231600b004fe0bfa9d8bmr483618lfu.12.1694488707796; Mon, 11 Sep
 2023 20:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230911180815.820-1-shannon.nelson@amd.com>
In-Reply-To: <20230911180815.820-1-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Sep 2023 11:18:16 +0800
Message-ID: <CACGkMEtkieLpkwifTEUw7ROpj8Ywb8BBspzJRoL6qj_O5+ZFQw@mail.gmail.com>
Subject: Re: [PATCH iproute2] vdpa: consume device_features parameter
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: dsahern@kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, mst@redhat.com, 
	si-wei.liu@oracle.com, allen.hubbe@amd.com, drivers@pensando.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 2:08=E2=80=AFAM Shannon Nelson <shannon.nelson@amd.=
com> wrote:
>
> From: Allen Hubbe <allen.hubbe@amd.com>
>
> Consume the parameter to device_features when parsing command line
> options.  Otherwise the parameter may be used again as an option name.
>
>  # vdpa dev add ... device_features 0xdeadbeef mac 00:11:22:33:44:55
>  Unknown option "0xdeadbeef"
>
> Fixes: a4442ce58ebb ("vdpa: allow provisioning device features")
> Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  vdpa/vdpa.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
> index 8bbe452c..6e4a9c11 100644
> --- a/vdpa/vdpa.c
> +++ b/vdpa/vdpa.c
> @@ -353,6 +353,8 @@ static int vdpa_argv_parse(struct vdpa *vdpa, int arg=
c, char **argv,
>                                                 &opts->device_features);
>                         if (err)
>                                 return err;
> +
> +                       NEXT_ARG_FWD();
>                         o_found |=3D VDPA_OPT_VDEV_FEATURES;
>                 } else {
>                         fprintf(stderr, "Unknown option \"%s\"\n", *argv)=
;
> --
> 2.17.1
>


