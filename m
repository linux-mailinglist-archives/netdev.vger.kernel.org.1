Return-Path: <netdev+bounces-53838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B852804D35
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 10:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5C61C208CF
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 09:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223CB3D982;
	Tue,  5 Dec 2023 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNVUQvzo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB7910F
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 01:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701767210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/5hbavG9FxtP2fqgbrUZXKsls1QEJHwMBm7cnQddac=;
	b=NNVUQvzoSQQ0tIEW+atLuD3QTxTsAkTnPoDmNbK8F0Ag50D0VmE68S7xQ0YUW6AMUoQxKu
	GoMmB/bsBO++hahDlqCHXQPmfUUcKeIEvFEfwcCbW/bUvz75GyjA9uAb49rOoaTPnbN4Kc
	pwyW9VNCgV//71wv6b0CIk/C46SJTQo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-Lcudkjk4MlGhUZJjMv4v4w-1; Tue, 05 Dec 2023 04:06:49 -0500
X-MC-Unique: Lcudkjk4MlGhUZJjMv4v4w-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a19a974cccfso62186966b.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 01:06:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701767208; x=1702372008;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0/5hbavG9FxtP2fqgbrUZXKsls1QEJHwMBm7cnQddac=;
        b=WzeQKnd3r0ArK/JYVMBx0bcRzh3yfb7e/0Adjfuy9p0YQvLUND8RdBdOKmyX+Gh9iQ
         FZzqcsFJ4eWpnwN6w+jemxPfJe+OSsF13EsaaQ5TNXgrnZyzTC0GgQRl0Tz6TY6/Nse1
         LA9DNIVoAxjRti1YmKvl812x4BbQOvY8Wfz+JsYFUL+6y1+DTJ4cmmQxKUgfAO7J0HBr
         OziUgkZzZqq9ldL69ZFduLLyyN9HaTh+aC27MwmtVXxh2h3/97BDNDlaaH5nQLbcNKOf
         ShHKdRGflZNCHLFnr8MCX4jDkemYdtQxed2/Po8Ua2oXGvdvqDe1JFg0iXymNlg9aDKq
         E52w==
X-Gm-Message-State: AOJu0Yy5/AVOFfKZZJ9/HDpqNKBmdOcF42nYtwDOaO2AwqcytYRzgUwX
	dLjYM1PKJhTtxKL5IQVF9l+wHfifa5JcSv5PviRLvg7G463A6DpUoOrAaCA6Mj+ei0PK4UM2Ltk
	Qlz1L4a1ccHeqxa8Il0L2QATt
X-Received: by 2002:a17:907:7b94:b0:a1c:5944:29bb with SMTP id ne20-20020a1709077b9400b00a1c594429bbmr1029469ejc.7.1701767208256;
        Tue, 05 Dec 2023 01:06:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2xEfzHGLjR6dkG5vPelsChBHYBSZ8pQ6/tWoEjwLbIwKq9MOsnOkGAMl0nAtEF2pfqgyfKQ==
X-Received: by 2002:a17:907:7b94:b0:a1c:5944:29bb with SMTP id ne20-20020a1709077b9400b00a1c594429bbmr1029447ejc.7.1701767207884;
        Tue, 05 Dec 2023 01:06:47 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-54.dyn.eolo.it. [146.241.241.54])
        by smtp.gmail.com with ESMTPSA id ay19-20020a170906d29300b00a0c3b122a1esm6361708ejb.63.2023.12.05.01.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 01:06:47 -0800 (PST)
Message-ID: <1f0cd6c635d1f570ff36c4b5a94e8d5a9f596aee.camel@redhat.com>
Subject: Re: [PATCH net-next v6 1/6] ptp: clockmatrix: support 32-bit
 address space
From: Paolo Abeni <pabeni@redhat.com>
To: Min Li <lnimi@hotmail.com>, richardcochran@gmail.com, lee@kernel.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Min Li
	 <min.li.xe@renesas.com>
Date: Tue, 05 Dec 2023 10:06:46 +0100
In-Reply-To: <PH7PR03MB70644CE21E835B48799F3EB3A082A@PH7PR03MB7064.namprd03.prod.outlook.com>
References: 
	<PH7PR03MB70644CE21E835B48799F3EB3A082A@PH7PR03MB7064.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Thu, 2023-11-30 at 13:46 -0500, Min Li wrote:
> diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.=
c
> index f6f9d4adce04..f8556627befa 100644
> --- a/drivers/ptp/ptp_clockmatrix.c
> +++ b/drivers/ptp/ptp_clockmatrix.c
> @@ -41,8 +41,8 @@ module_param(firmware, charp, 0);
>  static int _idtcm_adjfine(struct idtcm_channel *channel, long scaled_ppm=
);
> =20
>  static inline int idtcm_read(struct idtcm *idtcm,
> -			     u16 module,
> -			     u16 regaddr,
> +			     u32 module,
> +			     u32 regaddr,
>  			     u8 *buf,
>  			     u16 count)
>  {

[...]
> @@ -553,11 +554,11 @@ static int _sync_pll_output(struct idtcm *idtcm,
>  	val =3D SYNCTRL1_MASTER_SYNC_RST;
> =20
>  	/* Place master sync in reset */
> -	err =3D idtcm_write(idtcm, 0, sync_ctrl1, &val, sizeof(val));
> +	err =3D idtcm_write(idtcm, sync_ctrl1, 0, &val, sizeof(val));
>  	if (err)
>  		return err;

I'm sorry, but it looks like my previous feedback was not clear enough:
now that the 'regaddr' argument in idtcm_write() has 'u32' type, you
don't need anymore to swap the 'module' and 'regaddr' arguments in the
call site.

Specifically, you can drop the above chunk, many later similar ones=20
and additionally even chunks calling to idtcm_write(), for the same
reason.

That would make the patch smaller, and IMHO more clear: it would be=20
strange that something that was known as a register address suddenly
become a 'module'.

Thanks!

Paolo


