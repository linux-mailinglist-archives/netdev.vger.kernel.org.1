Return-Path: <netdev+bounces-13057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB77673A0E5
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 14:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3737E28193E
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 12:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E091E536;
	Thu, 22 Jun 2023 12:28:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6D715AE4
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 12:28:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D5E199E
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687436901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5pmHwEzAPicyH88XD8XeXekL+O3YOK5f/E4/IhyQwRg=;
	b=YLSt3EX8N6obAmjyI2Jdcxn7uA7S/MKUhGjZYK+Yghcr5sWsdiaM6hAVIC0gzhDYB6RRl8
	uDJ4NVRXcI1BC88qwtAD827T1ZcSa+2vFHXNvMuDXhvhynjMpGOnnB+umCbR0Iq5zPAoma
	aLP1ACAak0zi/462OHpgXVhZIcUD4/g=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-9QwWQNv4P6i-qvlW89URWA-1; Thu, 22 Jun 2023 08:28:18 -0400
X-MC-Unique: 9QwWQNv4P6i-qvlW89URWA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-763dcfe8c92so216935985a.0
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687436897; x=1690028897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pmHwEzAPicyH88XD8XeXekL+O3YOK5f/E4/IhyQwRg=;
        b=AWhHUUMzM5xpvgf4p/mwANst2ZhNHbX2OqlfKM+kvJCDIFZUcBjVScExhbxgjwoTPw
         VpakZVQDJsHqk1ZaQ34scW1foEFtlrZozW7mYfkbkN7s+XDa/WCz+B4fKWl9PL/qxWfw
         omOfuDX1XB26PWibP6wCjDakE/Xico6Q0XyjmzaThk4vlHZCrSm3UskbF5ivm7dLLF1r
         BXEofxSu039ppCRQuHxNgrcNK1te/xFK2wNIplFNwethC7B98+pYqnjtx+8SL/cSzrp0
         HiJyp7VZMnrxiq6Wf/ePBW8/mW99GjdZHQnCME2pag1jkXhk8sCAeYUE4J0PWljF1G9M
         yv1w==
X-Gm-Message-State: AC+VfDygNiev2SiUOHxNMSzA+lP7f6jP60N9uiKj/B9jlgUDaXLz0knq
	RXs2enfjMSkp2OV3mQ6MvuSEuh9C1FJKNGxmpCxT9mxifGxM2ho3StzCPYUTqTyTiFuCb5P2ovC
	FYA6gEs+qYEPbUo6U
X-Received: by 2002:a05:620a:4d4:b0:765:25be:36e4 with SMTP id 20-20020a05620a04d400b0076525be36e4mr2203241qks.6.1687436897372;
        Thu, 22 Jun 2023 05:28:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6+Pf7PlnZxl+iDCZchQ2oSl5E1RwIAB5qxqHpnM5zKpM+NYgKOaaF1kJ1Jxjl6Kghb8vQT2Q==
X-Received: by 2002:a05:620a:4d4:b0:765:25be:36e4 with SMTP id 20-20020a05620a04d400b0076525be36e4mr2203223qks.6.1687436897080;
        Thu, 22 Jun 2023 05:28:17 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id s16-20020a05620a031000b0075f13bda351sm3301106qkm.115.2023.06.22.05.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 05:28:16 -0700 (PDT)
Date: Thu, 22 Jun 2023 14:28:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Tiwei Bie <tiwei.bie@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <6culpnuswqq4fh7r5iqqtvwrpnsapn4jhx3heorfctztc2miem@hscigltkix5d>
References: <20230605110644.151211-1-sgarzare@redhat.com>
 <20230622073625-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230622073625-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 07:37:08AM -0400, Michael S. Tsirkin wrote:
>On Mon, Jun 05, 2023 at 01:06:44PM +0200, Stefano Garzarella wrote:
>> vhost-vdpa IOCTLs (eg. VHOST_GET_VRING_BASE, VHOST_SET_VRING_BASE)
>> don't support packed virtqueue well yet, so let's filter the
>> VIRTIO_F_RING_PACKED feature for now in vhost_vdpa_get_features().
>>
>> This way, even if the device supports it, we don't risk it being
>> negotiated, then the VMM is unable to set the vring state properly.
>>
>> Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>OK so for now I dropped this, we have a better fix upstream.
>

Yep, I agree.

Maybe we can reuse this patch in the stable branches where the backport
is not easy. Although as Jason said, maybe we don't need it.

Thanks,
Stefano


