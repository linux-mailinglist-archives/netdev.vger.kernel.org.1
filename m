Return-Path: <netdev+bounces-33816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E98497A04F5
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCE031C20E0D
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 13:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94F61D68F;
	Thu, 14 Sep 2023 13:06:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCA3241EC
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 13:06:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1166E1FD8
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 06:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694696785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X/pGng4Jlz5jKGWmwVqa99A3qKH6EyoanXPEX+/wRiw=;
	b=hIRVVVOzKiwgVi2u5A31m4hbSkkKjOsCcwEMo3YF2ynF969HokJTRo83QQm436VsU4RlMh
	FlOxZoqZvMtAtR1KbYi9vKbEpTeZScmgp/BjxmvpxCDCgknoivMek3sm/ZZqMEPO4nM8fV
	4OUCCXo4aMscBy4L5GQ3H2YND1drdHg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-ia-WULbwPH2nCfRzGYGb5Q-1; Thu, 14 Sep 2023 09:06:23 -0400
X-MC-Unique: ia-WULbwPH2nCfRzGYGb5Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31c6c275c83so571679f8f.2
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 06:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694696782; x=1695301582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/pGng4Jlz5jKGWmwVqa99A3qKH6EyoanXPEX+/wRiw=;
        b=nnihIo26m/gV4e6WFYE1susrZb5blsDuTCu8IIHBMR8LWmNjmcVs9/hFq/NVRT63nI
         +0XUONM7kWSTxsHN3iX+2v4Df3BLHxtxmgyZepFWKDzoYSrcKxih1n7RCgpp1bBAd7kl
         KptEYc+UZ6692Cjg27Qj8V0DadEeIrAJry1FbdVKG9PX0fRg3Ps9XogBhXGJBk4G6aTE
         k60DDiY8EuYdsog11TjDr8YgIkunwGq2yIgDUP8nm3rkRAbERefVS40W4d4gdngk5rGx
         DBSzTSI8Mqm+eoQzXae5lpMlVRFo5vApwZ8MSAA7LbxjNeLrcNEtgwl4sKcy2lkYYoH+
         n2/w==
X-Gm-Message-State: AOJu0YxlFkqy7YOrOxmgpgAFkh+O4+YfI2DhQ5EOJh1hceXejZMEQ0/d
	SzAh/7qrbsNw48a9p+2p3O+/aHsRtto3dMJxGoarBj9dpgIwmlTosi2Ks8oQNrdJn7cPNoQ9fcT
	3dPYpljLAU/uHGZ33
X-Received: by 2002:a5d:6752:0:b0:31f:b91c:6ebc with SMTP id l18-20020a5d6752000000b0031fb91c6ebcmr4442869wrw.14.1694696782740;
        Thu, 14 Sep 2023 06:06:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMprSt5Eq7z2+zyD9pVdEhDhOcN3K4FFKy92OAHwhT7/UABz6yxx0vX6SGjsriWT02u92rgg==
X-Received: by 2002:a5d:6752:0:b0:31f:b91c:6ebc with SMTP id l18-20020a5d6752000000b0031fb91c6ebcmr4442801wrw.14.1694696781669;
        Thu, 14 Sep 2023 06:06:21 -0700 (PDT)
Received: from sgarzare-redhat ([46.222.114.183])
        by smtp.gmail.com with ESMTPSA id 4-20020a05600c22c400b00403b63e87f2sm1940671wmg.32.2023.09.14.06.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 06:06:21 -0700 (PDT)
Date: Thu, 14 Sep 2023 15:06:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v8 2/4] vsock/virtio: support to send non-linear
 skb
Message-ID: <nzguzjuchyk5uwdnexegayweyogv5wdfgaxrrw47fuw2rjkumq@4ybro57ixsga>
References: <20230911202234.1932024-1-avkrasnov@salutedevices.com>
 <20230911202234.1932024-3-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230911202234.1932024-3-avkrasnov@salutedevices.com>

On Mon, Sep 11, 2023 at 11:22:32PM +0300, Arseniy Krasnov wrote:
>For non-linear skb use its pages from fragment array as buffers in
>virtio tx queue. These pages are already pinned by 'get_user_pages()'
>during such skb creation.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Changelog:
> v2 -> v3:
>  * Comment about 'page_to_virt()' is updated. I don't remove R-b,
>    as this change is quiet small I guess.
> v6 -> v7:
>  * Move arrays '*sgs' and 'bufs' to 'virtio_vsock' instead of being
>    local variables. This allows to save stack space in cases of too
>    big MAX_SKB_FRAGS.
>  * Add 'WARN_ON_ONCE()' for handling nonlinear skbs - it checks that
>    linear part of such skb contains only header.
>  * R-b tag removed due to updates above.
> v7 -> v8:
>  * Add comment in 'struct virtio_vsock' for both 'struct scatterlist'
>    fields.
>  * Rename '*sgs' and 'bufs' to '*out_sgs' and 'out_bufs'.
>  * Initialize '*out_sgs' in 'virtio_vsock_probe()' by always pointing
>    to the corresponding element of 'out_bufs'.

LGTM, thanks for addressing that comments!

>
> net/vmw_vsock/virtio_transport.c | 60 ++++++++++++++++++++++++++++----
> 1 file changed, 53 insertions(+), 7 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


