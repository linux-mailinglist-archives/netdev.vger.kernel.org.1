Return-Path: <netdev+bounces-42149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E717CD619
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 10:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B011C20D78
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 08:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC5D14A9E;
	Wed, 18 Oct 2023 08:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnf12Tsx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A70F9D5
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 08:10:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DFEB6
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 01:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697616622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=37/kJ7xBvGvJcqALMsAiYLG6+205Ian/eThnUNlAZmo=;
	b=cnf12TsxEGqNOziW0U3vbeD072WFqUZUmvZ8+TD8igNCiVbgGq/owIiZcKJXSaFQ+W6kx+
	xrURYxl19ECVvU0/JwGiAytjMX1pH98nwk+HJ/COCht9qL+4t2E94NhOF4k08Wtc/7rUuA
	Nu1RV29y83xFL0wtyPxSTYs3KPdUlww=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-8otKgJvPMairF72uS1hW0w-1; Wed, 18 Oct 2023 04:10:05 -0400
X-MC-Unique: 8otKgJvPMairF72uS1hW0w-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9ae0bf9c0b4so495472866b.0
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 01:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697616604; x=1698221404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37/kJ7xBvGvJcqALMsAiYLG6+205Ian/eThnUNlAZmo=;
        b=STOBlm/TAsZfndwC5cnnQ2cS0O1/dgmV+npJsBdNgv60ZpECwQYMnuCcGIr85whrYS
         HKerjIWWZ1VlQ/RztUFo/gPJKkrMLfJn0T/SzEuPORzUDHRlCqYebvYWeSMPi1GAWQaR
         SaB6l30spxoUJ4sbRTpF65FO8wKZVmAuCCdMU1u5wDVUBun9Je0whhYbCpKtFIATnd3l
         8a8zu27zVXAv8eCpAuUVdtLvnyFFcPc/dvBG7R5ce51im+k+3LI6kUpzNohz/pJaChgB
         WsAePJrY7wDGC+MMHtNh/IPCxLesUMOK2USzCwKSVRLGpojwV6XwIVR9f6plzQRQl0cS
         ZPIQ==
X-Gm-Message-State: AOJu0YyTlVRqQifQIlTJjGEt82J6VOsB2yJTAAsah6jkTlg/gI+3avvq
	HcyAUOy2Q+4OLHImW+bG9mtEmXxKMTwBlMbVIYeRbLKMHtwFJylQY+ja6P48ryY/b17pP39H4hk
	Zy5+hxWWHEdJY6SMT
X-Received: by 2002:a17:906:ee81:b0:9be:481c:60bf with SMTP id wt1-20020a170906ee8100b009be481c60bfmr3207760ejb.55.1697616604096;
        Wed, 18 Oct 2023 01:10:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo/uNRLOrJZqZfYt3SG8LZALHlWpLFAe29ra7F9UnNNgD7+57SContltcsRq/ZecphhcN7iQ==
X-Received: by 2002:a17:906:ee81:b0:9be:481c:60bf with SMTP id wt1-20020a170906ee8100b009be481c60bfmr3207746ejb.55.1697616603792;
        Wed, 18 Oct 2023 01:10:03 -0700 (PDT)
Received: from redhat.com ([193.142.201.34])
        by smtp.gmail.com with ESMTPSA id f17-20020a1709062c5100b009aa292a2df2sm1118534ejh.217.2023.10.18.01.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 01:10:03 -0700 (PDT)
Date: Wed, 18 Oct 2023 04:09:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH vhost 02/22] virtio_ring: introduce
 virtqueue_dma_[un]map_page_attrs
Message-ID: <20231018040907-mutt-send-email-mst@kernel.org>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-3-xuanzhuo@linux.alibaba.com>
 <1697615580.6880193-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697615580.6880193-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 03:53:00PM +0800, Xuan Zhuo wrote:
> Hi Michael,
> 
> Do you think it's appropriate to push the first two patches of this patch set to
> linux 6.6?
> 
> Thanks.


I see this is with the eye towards merging this gradually. However,
I want the patchset to be ready first, right now it's not -
with build failures and new warnings on some systems.


-- 
MST


