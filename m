Return-Path: <netdev+bounces-45689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C147DF074
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 11:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58D2CB2123D
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 10:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2CD125DD;
	Thu,  2 Nov 2023 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmXyCwn6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEFB748D
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 10:45:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD99F136
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 03:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698921954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y9mBMnZXkfcn8X+S1uWPcpA8muaoQVjDKXTStMVPXQk=;
	b=EmXyCwn6/voZedyi3tlQaGSxPn252OT+AJFyUuOKTirpx2Cql1PU7XjujK0f2fh62edf/F
	TF1hkTTAxau4/sMaDXYUP0vR9u2I5/odI5uA4ScgG6Uw+PK6NZCcoHvW23r+liUI6qxZ5K
	70DfUwm7fo6L4ZdQYULdO49sVaXz7MQ=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-kUmBPmG6Om-9eWKjYRpyag-1; Thu, 02 Nov 2023 06:45:52 -0400
X-MC-Unique: kUmBPmG6Om-9eWKjYRpyag-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-7b9e9665a87so114848241.0
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 03:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698921952; x=1699526752;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y9mBMnZXkfcn8X+S1uWPcpA8muaoQVjDKXTStMVPXQk=;
        b=HPt5lXpwfYkY7kJ0ldF3N9n/MgLmBorw5GNYKT2Nbs/9Qjspr6h7RP4KiT1hC3XmtX
         H52WaPGf4Yxad7V6laaoL4x5N6l8T+NTnUSSVI2ssBskB6QGO0WGWz8s1TRqkxb0N/Vl
         hP3VeQRWCYqSUWFBLQdWO/3rBWWbaZ2DTCmr/9pKgQURShEuJvVUgV9Ks5SfnZEwhiiQ
         U0/2izV+Jco4jTeKsvdhVvSf3Sr+Rv31x+OPrpAL1nr4CAVSbskdNOXrfyYTwPdvyi1c
         PdpFqNsQ4R/8yx774dr+kkm0goxUBUX/VoPqVh4Kr7HhrV4ST24wHGQVB1OY/3gSj/xe
         MXFw==
X-Gm-Message-State: AOJu0YwxPZ4FFp2jtu+p5Wy0WoACMsBXvwRcRbuTV0ZTbgooRZzCQNSf
	1MLHT+dXzBTtBj0b6KSvAf2TnHspCZmO284BWmHDeFFOnzpkl7rsGN/CRwBBqzsTQUO79g7E+RI
	8B7CofHG/u7eKwCEd
X-Received: by 2002:a67:ec09:0:b0:45d:6f59:75d with SMTP id d9-20020a67ec09000000b0045d6f59075dmr1132348vso.3.1698921952282;
        Thu, 02 Nov 2023 03:45:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEUz+8/oijfPH+hmrLS8G8SbahpZB+B82vOdVxZz6QZCauVC6ge20YbaMyHu2lpttGCmY9SQ==
X-Received: by 2002:a67:ec09:0:b0:45d:6f59:75d with SMTP id d9-20020a67ec09000000b0045d6f59075dmr1132326vso.3.1698921952004;
        Thu, 02 Nov 2023 03:45:52 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-153.dyn.eolo.it. [146.241.226.153])
        by smtp.gmail.com with ESMTPSA id f28-20020ad4559c000000b0063f88855ef2sm2252683qvx.101.2023.11.02.03.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 03:45:51 -0700 (PDT)
Message-ID: <9bc9514044063bc57155fb786f970ca1d69758b4.camel@redhat.com>
Subject: Re: [PATCH net 6/7] net: hns3: fix VF reset fail issue
From: Paolo Abeni <pabeni@redhat.com>
To: Jijie Shao <shaojijie@huawei.com>, yisen.zhuang@huawei.com, 
 salil.mehta@huawei.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: shenjian15@huawei.com, wangjie125@huawei.com, liuyonglong@huawei.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 02 Nov 2023 11:45:48 +0100
In-Reply-To: <20231028025917.314305-7-shaojijie@huawei.com>
References: <20231028025917.314305-1-shaojijie@huawei.com>
	 <20231028025917.314305-7-shaojijie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2023-10-28 at 10:59 +0800, Jijie Shao wrote:
> Currently the reset process in hns3 and firmware watchdog init process is
> asynchronous. We think firmware watchdog initialization is completed
> before VF clear the interrupt source. However, firmware initialization
> may not complete early. So VF will receive multiple reset interrupts
> and fail to reset.
>=20
> So we add delay before VF interrupt source and 5 ms delay
> is enough to avoid second reset interrupt.
>=20
> Fixes: 427900d27d86 ("net: hns3: fix the timing issue of VF clearing inte=
rrupt sources")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c   | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/=
drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> index 1c62e58ff6d8..7b87da031be6 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> @@ -1924,8 +1924,14 @@ static void hclgevf_service_task(struct work_struc=
t *work)
>  	hclgevf_mailbox_service_task(hdev);
>  }
> =20
> -static void hclgevf_clear_event_cause(struct hclgevf_dev *hdev, u32 regc=
lr)
> +static void hclgevf_clear_event_cause(struct hclgevf_dev *hdev, u32 regc=
lr,
> +				      bool need_dalay)
>  {
> +#define HCLGEVF_RESET_DELAY		5
> +
> +	if (need_dalay)
> +		mdelay(HCLGEVF_RESET_DELAY);

5ms delay in an interrupt handler is quite a lot. What about scheduling
a timer from the IH to clear the register when such delay is needed?

Thanks!

Paolo


