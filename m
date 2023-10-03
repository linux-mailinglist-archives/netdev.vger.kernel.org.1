Return-Path: <netdev+bounces-37647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7256C7B6736
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id B8796B20939
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 11:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8A8210FC;
	Tue,  3 Oct 2023 11:07:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C502C1FBA
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 11:07:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F207A1
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 04:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696331260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkX3U2XtLh0SwP2dw+8InxKx4ja/2ylF1rIlz3maCoQ=;
	b=OmlzaQZ0AUv3PHX9T/5OgMCdAJRnlSrMDyH23FHXzNF5d4UCVpVrjOJz9ZBnDkIVHMA1XG
	5je1Wz/DgZqJRFpsJPG/AHm/pvwz/XXn0XL6hcBeEBoLE0PsX9Qzim1DBynIEy/8xSe5N/
	YYRtC98heEjoquAYVGa3X96e2l4AVVI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-9ZvzwocHNsSOKfo7uuLvnQ-1; Tue, 03 Oct 2023 07:07:39 -0400
X-MC-Unique: 9ZvzwocHNsSOKfo7uuLvnQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9b2d2d8f9e0so13922066b.1
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 04:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696331258; x=1696936058;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pkX3U2XtLh0SwP2dw+8InxKx4ja/2ylF1rIlz3maCoQ=;
        b=Dk+reN+XuZZVEwm4JiHUi4iVnrNklHzJODIkkFTttBxTUKNle7iMpagxiE8WpGMh0I
         FCKNGGj7IT7YTHerwdoyxCPvmKnnTbSpmb/ww5B8KOID99DfUQRU3RMrgT7My/hq5d1Q
         R8pKu+/+MwGsEB3ZKQsPW4Gg57GtYeaz1EwrK7xXnMgcRWTV9wcsA/mR1l3cHwfUw6VM
         OO1K5qL+eM60iGJ/a23JVqgksQLDtUAGp+UygYUHKaxY8jzfcncx88rC9duYIjfVJyj4
         DjJA2tn6jwxdUoKSrAHwHxuf9yX/2++nqL/WeOlwTlwaRRKGeCqgQfyGAbqfbYOL5t/e
         xeJA==
X-Gm-Message-State: AOJu0Yw3bB2SwrWb7bpUI2tL9yat3ktSKjkyk2Tob6fpMJOhbvK3hVOm
	8lhLyihFbuJmLv5mE6I2PFPC3dqEwA9gUmkk6N58PGR9DDdXolfZa8wN53KpNsrjsmQsnPfyxVk
	5/54y5TCdGOpFpqTa
X-Received: by 2002:a17:906:105d:b0:9ae:5868:c8c9 with SMTP id j29-20020a170906105d00b009ae5868c8c9mr11024438ejj.0.1696331258306;
        Tue, 03 Oct 2023 04:07:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkhlAIXYFVb2EVm+9XNesx6S7O3/U021Az3cUkjHDMO5/4Ow9uAXi1UHhVA83zO+sTrcIO6w==
X-Received: by 2002:a17:906:105d:b0:9ae:5868:c8c9 with SMTP id j29-20020a170906105d00b009ae5868c8c9mr11024422ejj.0.1696331257909;
        Tue, 03 Oct 2023 04:07:37 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-193.dyn.eolo.it. [146.241.232.193])
        by smtp.gmail.com with ESMTPSA id op13-20020a170906bced00b0098921e1b064sm875546ejb.181.2023.10.03.04.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 04:07:37 -0700 (PDT)
Message-ID: <018982972b43bdac3f6d50bde03287282364e357.camel@redhat.com>
Subject: Re: [PATCH] fjes: Add missing check for vzalloc
From: Paolo Abeni <pabeni@redhat.com>
To: Petr Machata <petrm@nvidia.com>, Chen Ni <nichen@iscas.ac.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
 izumi.taku@jp.fujitsu.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 03 Oct 2023 13:07:35 +0200
In-Reply-To: <87r0mms4a5.fsf@nvidia.com>
References: <20230925085318.1228225-1-nichen@iscas.ac.cn>
	 <87r0mms4a5.fsf@nvidia.com>
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
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-09-25 at 16:40 +0200, Petr Machata wrote:
> Chen Ni <nichen@iscas.ac.cn> writes:
>=20
> > Because of the potential failure of the vzalloc(), the hw->hw_info.trac=
e
> > could be NULL.
> > Therefore, we need to check it and return -ENOMEM in order to transfer
> > the error.
> >=20
> > Fixes: b6ba737d0b29 ("fjes: ethtool -w and -W support for fjes driver")
> > Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> > ---
> >  drivers/net/fjes/fjes_hw.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/net/fjes/fjes_hw.c b/drivers/net/fjes/fjes_hw.c
> > index 704e949484d0..3a06a3cf021d 100644
> > --- a/drivers/net/fjes/fjes_hw.c
> > +++ b/drivers/net/fjes/fjes_hw.c
> > @@ -330,6 +330,9 @@ int fjes_hw_init(struct fjes_hw *hw)
> >  	ret =3D fjes_hw_setup(hw);
> > =20
> >  	hw->hw_info.trace =3D vzalloc(FJES_DEBUG_BUFFER_SIZE);
> > +	if (!hw->hw_info.trace)
> > +		return -ENOMEM;
> > +
>=20
> I'm not sure, but shouldn't this call fjes_hw_cleanup() to mirror the
> setup() above? Also only if ret=3D0 I suppose.

Yes, that looks needed, or memory will be leaked. Additionally it looks
like the rest of the driver handles correctly the case where
hw_info.trace is NULL, so this fix is likely not needed at all.

Cheers,

Paolo


