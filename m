Return-Path: <netdev+bounces-31601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3101678EFE0
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 17:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681301C20A38
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 15:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11999125AA;
	Thu, 31 Aug 2023 15:00:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00777186A
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 15:00:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FDDCC5
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 08:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693494056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vgwa1dB9SPLXrOuebcpc/xedsvZ9jq5rbgcVN4pe9yQ=;
	b=FBuzfSrLRkrWrrPGOFz1Fy1XTwRHN2XVo8JaHnQLVWvrsRcfu0XRXj6EhS5wP1xM9ZVe3r
	IF/+R/OROo4amAdOgt1T/8w/I5ZdZkTpZU5CREFp3edcgvWtsz5wPdvBv8wxb7eSZpeQFO
	85H1qNSFISAATyBQQYpxrgGBaAP9fWk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-9rp1c5wWMe67ansjXjOAUg-1; Thu, 31 Aug 2023 11:00:53 -0400
X-MC-Unique: 9rp1c5wWMe67ansjXjOAUg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-978a991c3f5so68985766b.0
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 08:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693494052; x=1694098852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vgwa1dB9SPLXrOuebcpc/xedsvZ9jq5rbgcVN4pe9yQ=;
        b=aYz74jer3F+bUe1Nk8wt2o6dWN97njNG9eT5iKwj4TK8im1n/2qpukEB6ZqDnW4BQm
         ETwg+QI7VMzqzQ6qeb+PfLpbeB9lPlK/mBgY9EMM9q/JxDtCv2MNki4bVvts2qDPcrUo
         IJZr5bhSL8zqNxga2B29H8Qr0eTDbiXuq2L7P7jijHtND9Je1aF3DQWK6gKLc+qYp3EN
         tEb3pGAnnf8MloXzTqV0GtMLEKk0RWtr1w9mb6aD4BL5jaRfVsmSqPQVEstE1gXDRTxJ
         RUzcHD3O+4oMuRsR4HOBWJfmxFaz7Ygu0P7lt+UzKsid7MUrZswsN85hZY3ZN1ZaRReN
         zvng==
X-Gm-Message-State: AOJu0Yx999GRrV37Gf2V0ZzcnI2YonADP5RCO6CWFTHWnaiKd+tYsDGn
	gCly5rEfKx2+Bxd6+i17xymlpix2NVMHiqAQu0yK3BDC5XFi56lI3VExfk1EcE0/aLINYTJweZK
	wlf8rFLmCOx4lSNEj
X-Received: by 2002:a17:906:5a6f:b0:9a3:c4f4:12dc with SMTP id my47-20020a1709065a6f00b009a3c4f412dcmr4524808ejc.7.1693494052174;
        Thu, 31 Aug 2023 08:00:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEItJP1c9NKLWMSDU2Fjxe2iKrYoxUCLRWz4/6JWjMqNieHJ8iRQusTIkf8kXERSXMOfiazaw==
X-Received: by 2002:a17:906:5a6f:b0:9a3:c4f4:12dc with SMTP id my47-20020a1709065a6f00b009a3c4f412dcmr4524784ejc.7.1693494051830;
        Thu, 31 Aug 2023 08:00:51 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it. [82.57.51.114])
        by smtp.gmail.com with ESMTPSA id rs10-20020a170907036a00b00992b510089asm855137ejb.84.2023.08.31.08.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 08:00:51 -0700 (PDT)
Date: Thu, 31 Aug 2023 17:00:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v2 1/2] vsock: send SIGPIPE on write to shutdowned
 socket
Message-ID: <gqhfmvel7kkglvaco5lnjiggfj57j7ie5erp6vjvfmm5ifwsw5@o2tzqsnvoc7x>
References: <20230826175900.3693844-1-avkrasnov@salutedevices.com>
 <20230826175900.3693844-2-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230826175900.3693844-2-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 26, 2023 at 08:58:59PM +0300, Arseniy Krasnov wrote:
>POSIX requires to send SIGPIPE on write to SOCK_STREAM socket which was
>shutdowned with SHUT_WR flag or its peer was shutdowned with SHUT_RD
>flag. Also we must not send SIGPIPE if MSG_NOSIGNAL flag is set.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> net/vmw_vsock/af_vsock.c | 3 +++
> 1 file changed, 3 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 020cf17ab7e4..013b65241b65 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1921,6 +1921,9 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
> 			err = total_written;
> 	}
> out:
>+	if (sk->sk_type == SOCK_STREAM)
>+		err = sk_stream_error(sk, msg->msg_flags, err);
>+
> 	release_sock(sk);
> 	return err;
> }
>-- 
>2.25.1
>


