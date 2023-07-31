Return-Path: <netdev+bounces-22777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E77769273
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16BE1C20B66
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 09:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C808917AC3;
	Mon, 31 Jul 2023 09:55:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5811426B
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 09:55:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011FDE54
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 02:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690797314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SQoMCvoY9z85LfglEVQlQxX/qlev/LvzY9LJJJIP4QE=;
	b=eNfmdtAiiPbhxwaSs+RSdrVw7U2Js6yhousJ30vkY9HoWECQ+hJRFA9YVVkPRQZGZ5gVTE
	ZTynFXCS6Gp7zZ+CvaoLEJwcf3I40BB5eaOBdTz4Hm9NZHv8xyAWqxSZuuTZtiHRfyYXDU
	5K7HKgDe+TNYiRG7PDbdSrqDBh98VUE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-B8v4MCWiOyiY2W909YJL0g-1; Mon, 31 Jul 2023 05:55:13 -0400
X-MC-Unique: B8v4MCWiOyiY2W909YJL0g-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-522aa493673so1543998a12.0
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 02:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690797312; x=1691402112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQoMCvoY9z85LfglEVQlQxX/qlev/LvzY9LJJJIP4QE=;
        b=L98hvYaXMkfUhF6sTysjHzAuoPZ0Ojc4bU1cXF0Avr+MuetxRjkvceQ0BDNpP8SCeO
         1gHKvWmboCCS2k1TV7XawD2+tiTJ30q3cPqWsh0mJClwgQUHTBpEP6XTs7xGjJ5oFgnz
         jcEnnVQ2mRHlSKJ6bz9ByV3bauQXZP68xBDpdIaDmhwDn0h3nc3ARE32vQXnqwwtmLlw
         K+UmkzGgjHYEC85U5QbnjAI3cdSwQqBsVBRUwZcBdydpydjHzFnTELdg+YrsCh4ubJVI
         oCxaKQWhZaQajR9mmIW1y02aT5ZVD/DJB7eJ94pe8LdvBX8+RBRA3UErNgAbIu93nrPr
         RWaA==
X-Gm-Message-State: ABy/qLb3Gj2n1YaM/Fsw/WITorb0D/kzoiUOpDTBq0M4rKkQ99/uDBiN
	j7hVBuxrxJn6fb1UmrB/vzHLE8Jb4IfUbxKFXi3Au6qg5LfYsTjhcRfpIYnyivx5KljgzBXrltI
	mp2APIbsfcUdXD9BG
X-Received: by 2002:aa7:c443:0:b0:522:55bf:21af with SMTP id n3-20020aa7c443000000b0052255bf21afmr7246382edr.7.1690797311992;
        Mon, 31 Jul 2023 02:55:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE58TsNYsn/mQvr3qBZ6RLFnKbCrKdzPm+vWtUuE+xxgcoyQK4b4Cl5YZ1mF+9BK4pUUO0zZg==
X-Received: by 2002:aa7:c443:0:b0:522:55bf:21af with SMTP id n3-20020aa7c443000000b0052255bf21afmr7246363edr.7.1690797311630;
        Mon, 31 Jul 2023 02:55:11 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-29.business.telecomitalia.it. [87.12.25.29])
        by smtp.gmail.com with ESMTPSA id i23-20020aa7c717000000b0051bed21a635sm5234603edq.74.2023.07.31.02.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:55:10 -0700 (PDT)
Date: Mon, 31 Jul 2023 11:55:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: bryantan@vmware.com, vdasa@vmware.com, pv-drivers@vmware.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] vsock: Remove unused function declarations
Message-ID: <ftvs2ivhynszqi3ib3w4uccfx5ren5dgkjagoeuyasbjdd76ac@4rbyljp2xnof>
References: <20230729122036.32988-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230729122036.32988-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 29, 2023 at 08:20:36PM +0800, Yue Haibing wrote:
>These are never implemented since introduction in
>commit d021c344051a ("VSOCK: Introduce VM Sockets")
>
>Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>---
> net/vmw_vsock/vmci_transport.h | 3 ---
> 1 file changed, 3 deletions(-)

Good catch ;-)

I'd used "vsock/vmci:" as a prefix in the title.

With or without:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/vmci_transport.h b/net/vmw_vsock/vmci_transport.h
>index b7b072194282..dbda3ababa14 100644
>--- a/net/vmw_vsock/vmci_transport.h
>+++ b/net/vmw_vsock/vmci_transport.h
>@@ -116,9 +116,6 @@ struct vmci_transport {
> 	spinlock_t lock; /* protects sk. */
> };
>
>-int vmci_transport_register(void);
>-void vmci_transport_unregister(void);
>-
> int vmci_transport_send_wrote_bh(struct sockaddr_vm *dst,
> 				 struct sockaddr_vm *src);
> int vmci_transport_send_read_bh(struct sockaddr_vm *dst,
>-- 
>2.34.1
>
>


