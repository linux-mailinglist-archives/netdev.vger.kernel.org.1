Return-Path: <netdev+bounces-44113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 798627D6532
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 10:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F636281C34
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 08:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FC71170B;
	Wed, 25 Oct 2023 08:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SpYxdJ1W"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B081F612
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 08:34:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F958B0
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 01:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698222843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PwvR0H/rJekRKW7bPChVNQWyI2TmQ8ZzJ/CtmxOFWqI=;
	b=SpYxdJ1WrLHdcqJcift3iEEjgSOB8HThh7vHZwBImlDMf/B4bkwFugRNQ85dlRyWayKYZ6
	+dvJ3SjcooiQWqjUA+B6sl+/2+Vh9p06tt10y4CltLmEPNPLLb34hYLa7P3mE7zt2vZo07
	I/GU/bK4h/76yNze8viUIlPJF5HYYvE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-6d3I9mrTM8KM_UmdJBtueA-1; Wed, 25 Oct 2023 04:34:02 -0400
X-MC-Unique: 6d3I9mrTM8KM_UmdJBtueA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-778a2e847f4so738069285a.0
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 01:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698222841; x=1698827641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwvR0H/rJekRKW7bPChVNQWyI2TmQ8ZzJ/CtmxOFWqI=;
        b=Ed07i1iN+oW11TGTPEsIvFiHkQ/3xTgVasLy3amTa2Ox8wnBSTmbs5NyIRUQWxBjh2
         1co7TWo/p+d2TkMIJSS2TOEeE25YV8g1PxtjCWdIFbqbs4wIWnVhbfUQGl3MvbKPOA9H
         w8T9OkKc9Bmpy9YFdvVQ3y2H5YQrCEx+l+col8q0wDsomYWloCf98TFeI3tQjQd56ghx
         sfYr3J77THkVlscv+W5d1t+AQpXf5Om+f2hpUpmF5K13gdABLTEDwDwN6d1yUHc0eKke
         SgzGyY4lPQwXmQylDhz6lbPVmr14f4FocFT4h+qwoPjDnhiXR4JnNbEV9RDv8l5iF5WU
         +sQg==
X-Gm-Message-State: AOJu0Ywx9b4Czk1NsUNG12EMyYft2wBtTnTXQ0j0x7Bx+x5D6/uqsepx
	k5RF9peNEOs4N8QrtEI50pRmlbljY6+4LoXF7uGkUJLiCOWLoX9qRUISx7EZaqskocmCu4uA8K7
	Cuk8RS5wrQIKoOBHj
X-Received: by 2002:a05:622a:3d3:b0:418:b8c:1a0a with SMTP id k19-20020a05622a03d300b004180b8c1a0amr19027898qtx.25.1698222841614;
        Wed, 25 Oct 2023 01:34:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwwSeGExFJjD6DFEBCEVHy8IMPsNdmNyv4qMG1/LmCczDQr1ec7svBZSUmolsxUEMpJlCnJQ==
X-Received: by 2002:a05:622a:3d3:b0:418:b8c:1a0a with SMTP id k19-20020a05622a03d300b004180b8c1a0amr19027875qtx.25.1698222841295;
        Wed, 25 Oct 2023 01:34:01 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it. [87.12.185.56])
        by smtp.gmail.com with ESMTPSA id f2-20020ac87f02000000b004198f67acbesm4022433qtk.63.2023.10.25.01.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 01:34:00 -0700 (PDT)
Date: Wed, 25 Oct 2023 10:33:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexandru Matei <alexandru.matei@uipath.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mihai Petrisor <mihai.petrisor@uipath.com>, Viorel Canja <viorel.canja@uipath.com>
Subject: Re: [PATCH v4] vsock/virtio: initialize the_virtio_vsock before
 using VQs
Message-ID: <gg3dml3ipk44cx55gjshr7km74xsksdc6pkosa5sulufannxsw@pgpqq7kjosw4>
References: <20231024191742.14259-1-alexandru.matei@uipath.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231024191742.14259-1-alexandru.matei@uipath.com>

On Tue, Oct 24, 2023 at 10:17:42PM +0300, Alexandru Matei wrote:
>Once VQs are filled with empty buffers and we kick the host, it can send
>connection requests. If the_virtio_vsock is not initialized before,
>replies are silently dropped and do not reach the host.
>
>virtio_transport_send_pkt() can queue packets once the_virtio_vsock is
>set, but they won't be processed until vsock->tx_run is set to true. We
>queue vsock->send_pkt_work when initialization finishes to send those
>packets queued earlier.
>
>Fixes: 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free on the_virtio_vsock")
>Signed-off-by: Alexandru Matei <alexandru.matei@uipath.com>
>---
>v4:
>- moved queue_work for send_pkt_work in vqs_start and added comment explaining why
>v3:
>- renamed vqs_fill to vqs_start and moved tx_run initialization to it
>- queued send_pkt_work at the end of initialization to send packets queued earlier
>v2:
>- split virtio_vsock_vqs_init in vqs_init and vqs_fill and moved
>  the_virtio_vsock initialization after vqs_init
>
> net/vmw_vsock/virtio_transport.c | 18 +++++++++++++++++-
> 1 file changed, 17 insertions(+), 1 deletion(-)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


