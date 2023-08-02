Return-Path: <netdev+bounces-23542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10BE76C755
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8D7A1C21204
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 07:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875A14C95;
	Wed,  2 Aug 2023 07:46:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7996F5224
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 07:46:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0792535A2
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 00:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690962376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h0UDSjpYhDP6foyjtQosf3cDeLd01SyV7B6Zn77rW4I=;
	b=hVlz3z9oubslwFeNNfP1fFqZuRqYGw7POGtZt/4+j9N0PvOqXix6iTAuT+NrtFQapRAMmF
	kfpuCF6tC4i3WSc038+9VEanZn67ddivfGIu4Ya2dIJ8osEjAd7V83xMsfLJSEmVZAXWSb
	C/aS+S211EQcDepzZeomwPoVZPvYHB4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-Y_Au9zcgPeCw49zTX1235Q-1; Wed, 02 Aug 2023 03:46:14 -0400
X-MC-Unique: Y_Au9zcgPeCw49zTX1235Q-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-76ca8263c45so483144285a.2
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 00:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690962374; x=1691567174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0UDSjpYhDP6foyjtQosf3cDeLd01SyV7B6Zn77rW4I=;
        b=b7SN6JFTzt5cF7wj6Z3V2cXnVxCD0wNn/6arsGDlfwFpnfKi6EH0JCJbRAj6BnpfQT
         VWriyy0z8Zkgu8rw/9L/ZlsOmB7+cxEapril1/vpmq8fmEG3eBz8HWz2urEH5Nmae1kF
         IdWxKyk+R/BJ+hqHBJ+XGaMffO5Ou9HfjbydoryCZr5xyisAkiwWfjI8r21kQDOsbWV5
         rRV65Jkjbf79hw9xykLodfQLUFn7dfXUS7saUQF+gIBvtwMzsNaIDtwZbDAtuZoERMqp
         lXqEmcPAF+9TVKijpogy/1W9En7QJES4AfQArHjYmOVxHQMnpsOcPbumAIlQRitV3H6C
         6XAQ==
X-Gm-Message-State: ABy/qLbmEs2y/owmpHifNUNmRBQYMQQfoBT3SXwrYiT+Z8chz/UFXW1G
	G7wLjAhzM6mjsVmZcCAq45iui5WxOaQmaQjEiHa04O/DIgAeQCz25Od9iMfUUWihMeuDgAAI3Io
	oW4/82NFo0aPLtA9l
X-Received: by 2002:a05:620a:2ae7:b0:76c:a35d:ee7b with SMTP id bn39-20020a05620a2ae700b0076ca35dee7bmr10630794qkb.75.1690962374345;
        Wed, 02 Aug 2023 00:46:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFodtYusq4miD67/qZPAflmfAiVup1o7pJRX1yLg/dsHxa8uZugDcgzMDc/Lwni4Tbe0+BMww==
X-Received: by 2002:a05:620a:2ae7:b0:76c:a35d:ee7b with SMTP id bn39-20020a05620a2ae700b0076ca35dee7bmr10630782qkb.75.1690962374098;
        Wed, 02 Aug 2023 00:46:14 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-214.retail.telecomitalia.it. [82.57.51.214])
        by smtp.gmail.com with ESMTPSA id f10-20020a0ccc8a000000b0062439f05b87sm5270298qvl.45.2023.08.02.00.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 00:46:13 -0700 (PDT)
Date: Wed, 2 Aug 2023 09:46:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v1 1/2] vsock: send SIGPIPE on write to shutdowned
 socket
Message-ID: <qgn26mgfotc7qxzp6ad7ezkdex6aqniv32c5tvehxh4hljsnvs@x7wvyvptizxx>
References: <20230801141727.481156-1-AVKrasnov@sberdevices.ru>
 <20230801141727.481156-2-AVKrasnov@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230801141727.481156-2-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 01, 2023 at 05:17:26PM +0300, Arseniy Krasnov wrote:
>POSIX requires to send SIGPIPE on write to SOCK_STREAM socket which was
>shutdowned with SHUT_WR flag or its peer was shutdowned with SHUT_RD
>flag. Also we must not send SIGPIPE if MSG_NOSIGNAL flag is set.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/af_vsock.c | 3 +++
> 1 file changed, 3 insertions(+)
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

Do you know why we don't need this for SOCK_SEQPACKET and SOCK_DGRAM?

Thanks,
Stefano

>+
> 	release_sock(sk);
> 	return err;
> }
>-- 
>2.25.1
>


