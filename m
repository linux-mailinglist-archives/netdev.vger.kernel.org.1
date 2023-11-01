Return-Path: <netdev+bounces-45512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676C87DDBE8
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 05:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986C51C20D41
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 04:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356D37F;
	Wed,  1 Nov 2023 04:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CgqGLVec"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2327FE
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 04:36:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10148101
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 21:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698813395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bm6nv3OrJNAdAjBRVuIThTw9zVigtFmJLGDyu68dZkw=;
	b=CgqGLVecpP7Lijf8PrpUByNLnlp+jdoJEvR006pxwEdI2me0Uy82s8Y7Dl3gtH+bBVUgx9
	an+0cI3yy7zHd/SAlcWa5/w9eIZZ50dsU81zArCTUXKV2LMuwyTcnLQd1BNW/30M+nRKVK
	Jgt7sCE/XaMMq4wGVJBxmye7er+75D8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-dRgAhpbQM7ivuVljE02hxw-1; Wed, 01 Nov 2023 00:36:32 -0400
X-MC-Unique: dRgAhpbQM7ivuVljE02hxw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5090f6a04e1so4271489e87.0
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 21:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698813391; x=1699418191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bm6nv3OrJNAdAjBRVuIThTw9zVigtFmJLGDyu68dZkw=;
        b=MphWRD/fhJFplPUflUPfeKHa4cofCHgtpDDyK9I+iNq+xIx+6I5Kh9f/LT/1bfw3+B
         x1r4bGNPrwr6kLv2XM4tB/VAZtDK8aL/q38dxkLfQr14DhnqURerIWcwii1SBJ9OO6wH
         y+TQJrnMuS1CvDq75TOxh3LJSrfbXyxzZCgZA1s/RPG7NoowJ6tUVfsHK8b5z3D4VkgS
         Y5bxjMdXiqzxGCZIhENwPCZ1FYfZIhY9KcXqbSrL48yPIcKdd5ulyVBPTazP0uMhdpad
         x4nzPa07wQ0/AowRkdKKGejjsk2G2m3A36RRtXG/UBOFt9F12PM9h33vqoSIGLKylm/x
         +bcA==
X-Gm-Message-State: AOJu0Yy0qMJp01lJzmMrs70kSHCiQtSLJ/wk03KGVyYvmi9iTZTjAbtr
	VuPx7spk7a04YIYYFxFA/2zFF2qvuJMNv1XDc10ASFATfIYuSgFyJ9+HJ0L6J15I+LmZS24fD9H
	R2WH1VRznDuM26+3kJqgQlyK46Idop3Qw
X-Received: by 2002:a19:ae16:0:b0:503:afa:e79 with SMTP id f22-20020a19ae16000000b005030afa0e79mr10181917lfc.5.1698813390937;
        Tue, 31 Oct 2023 21:36:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFiWTEEXffIJuc8scoNdDy3OwhB3Mf/+OrEdEdZTWinIPqM4Ur7SHi0nvzq6dnmpW4or5dSxVvXJ3rxzRcbLU=
X-Received: by 2002:a19:ae16:0:b0:503:afa:e79 with SMTP id f22-20020a19ae16000000b005030afa0e79mr10181908lfc.5.1698813390652;
 Tue, 31 Oct 2023 21:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cf53cb61-0699-4e36-a980-94fd4268ff00@moroto.mountain>
In-Reply-To: <cf53cb61-0699-4e36-a980-94fd4268ff00@moroto.mountain>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 1 Nov 2023 12:36:19 +0800
Message-ID: <CACGkMEvytH47Wb2LjP2667-D8OWbDruwV8aRvqcUzksWB-ruvg@mail.gmail.com>
Subject: Re: [PATCH net-XXX] vhost-vdpa: fix use after free in vhost_vdpa_probe()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Bo Liu <liubo03@inspur.com>, "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 8:13=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> The put_device() calls vhost_vdpa_release_dev() which calls
> ida_simple_remove() and frees "v".  So this call to
> ida_simple_remove() is a use after free and a double free.
>
> Fixes: ebe6a354fa7e ("vhost-vdpa: Call ida_simple_remove() when failed")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vhost/vdpa.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 9a2343c45df0..1aa67729e188 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1511,7 +1511,6 @@ static int vhost_vdpa_probe(struct vdpa_device *vdp=
a)
>
>  err:
>         put_device(&v->dev);
> -       ida_simple_remove(&vhost_vdpa_ida, v->minor);
>         return r;
>  }
>
> --
> 2.42.0
>


