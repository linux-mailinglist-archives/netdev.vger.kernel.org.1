Return-Path: <netdev+bounces-19795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAF175C5BE
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 13:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1A62821E4
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 11:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260B91D2EC;
	Fri, 21 Jul 2023 11:17:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DBA168CA
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:17:42 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943B6171A
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 04:17:40 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fde022de07so1920590e87.1
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 04:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689938259; x=1690543059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2LctkT5dF9S8RcAuY6I6O6ZER/oQ7YyW0GxeknMoUg=;
        b=ZtYey9NgEBM2l/RoIBH0f1KoVUmroVOsMBC0PugUM6CN4XIz6tSzbRePr9YOI0XXvR
         r8KgAXzC9Sjh4nK/9xr59/ati20Gtz3BrgkDuxdm4SRAMiTngjNrGVdFyukQi6bT60t9
         ToVSbKBL8yI2ZZuF93HAjiSEDxpnDJLvb4X9pxJG4UYnIWe9wWzDXWMMiMir9pTtSn4K
         RGwRN+SZ4/9kkeKnpKt5ORiDxvhsHmFCqVddy5qRCbTjx2g6Qs8XzQrL0HDrage++0NI
         fzsIQR+qPMmCIAFXtGr9cv4W2s4fkgEwL7l9KSlsu+2kbNRZQF/ubvRQIOgCBmTrjJ05
         Fbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689938259; x=1690543059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2LctkT5dF9S8RcAuY6I6O6ZER/oQ7YyW0GxeknMoUg=;
        b=Iu9XjVbaD+faGcD/zFybARN3g+Y96NTNLe0DecLae3Wm14o5D2i2IKLiOfuITf8++8
         4ziGuodPFfjEfRoMGDe4A6+s3RLM4U1IuOVtLoG1eh+VAgPLqEmWbJshSduyWqihZegG
         oMUYLveI/kMyep6+fbBrwI4lkFB8+otcxKi9+MhQvqr2mf/K/skfpxYf6cznVEzN0zBY
         bhoMyJM4eNbMJ8O+uFceOxdeNq/J3rMK316uN/Z8gwxIk/UAkzRVC1jhpJkpke8nr3rS
         q1uTucxDHtPh6oXacigMeaysnKWzhu1MD0OhTNuQJIldwLg04nUUnieDUPs2MzV6Ldj0
         G5SA==
X-Gm-Message-State: ABy/qLZXRKBlczxizrGV8gwKdbA+XbkOQKbl7EdzdVFHeDrAFnWE6fAG
	Kn+y0C7kxbVe6suamcy1bo5RvbJVdeZFsLjYErw=
X-Google-Smtp-Source: APBJJlGz6240fMiyiMy5/hJAQF61yvBLrxD4Kd5GTECqfFmfEoJx7p74usS0JwvwcMXgcNWCJb+WYoBI+liwk02std8=
X-Received: by 2002:a2e:3001:0:b0:2b7:2ea:33c3 with SMTP id
 w1-20020a2e3001000000b002b702ea33c3mr1557410ljw.22.1689938258494; Fri, 21 Jul
 2023 04:17:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230719072907.100948-1-liangchen.linux@gmail.com> <dd01d05c-015f-708f-8357-1dd4db15d5de@huawei.com>
In-Reply-To: <dd01d05c-015f-708f-8357-1dd4db15d5de@huawei.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Fri, 21 Jul 2023 19:17:26 +0800
Message-ID: <CAKhg4tJRm4EMgUWca=c7jDuEPeJc2F3SY--oVo4qWRkfO0A=pQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 1/2] net: veth: Page pool creation error
 handling for existing pools only
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	daniel@iogearbox.net, ast@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 8:44=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2023/7/19 15:29, Liang Chen wrote:
> > The failure handling procedure destroys page pools for all queues,
> > including those that haven't had their page pool created yet. this patc=
h
> > introduces necessary adjustments to prevent potential risks and
> > inconsistency with the error handling behavior.
> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > ---
> >  drivers/net/veth.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > index 614f3e3efab0..509e901da41d 100644
> > --- a/drivers/net/veth.c
> > +++ b/drivers/net/veth.c
> > @@ -1081,8 +1081,9 @@ static int __veth_napi_enable_range(struct net_de=
vice *dev, int start, int end)
> >  err_xdp_ring:
> >       for (i--; i >=3D start; i--)
> >               ptr_ring_cleanup(&priv->rq[i].xdp_ring, veth_ptr_free);
> > +     i =3D end;
> >  err_page_pool:
> > -     for (i =3D start; i < end; i++) {
> > +     for (i--; i >=3D start; i--) {
> >               page_pool_destroy(priv->rq[i].page_pool);
> >               priv->rq[i].page_pool =3D NULL;
>
> There is NULL checking in page_pool_destroy(),
> priv->rq[i].page_pool is set to NULL here, and the kcalloc()
> in veth_alloc_queues() ensure it is NULL initially, maybe it
> is fine as it is?
>

Sure, it doesn't cause any real problem.

This was meant to align err_page_pool handling with the case above
(though ptr_ring_cleanup cannot take an uninitialized ring), and it
doesn't always need to loop from start to end.

Thanks,
Liang

> >       }
> >

