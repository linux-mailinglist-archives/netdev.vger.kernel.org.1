Return-Path: <netdev+bounces-34892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B67B37A5BAD
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 09:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD981C210A5
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 07:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A69438BD6;
	Tue, 19 Sep 2023 07:54:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC88358AC
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 07:54:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613F0114
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 00:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695110095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xq2PUpZjcLYmB0sc19KGgnU6q5ctsCTIhTwce+KUPmU=;
	b=EA1PBUYyViTLO73SJ1nOc/IfMNNNcgj+3G7d9NPdqpfEJ4M+NRppCOFFa/EFr26Ro+xqAg
	slw5+QZ/+yokQL9H7oWC+VWbc5Y5Z9phh3IqEXBxaTfHFUbV1eI8sJoNj0zqHaSDrXNZA/
	O5/e2F1xqOUmUzo2w2KVKCHkCA+cI1U=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-ipqFwsEtMje7PLkPpeswuA-1; Tue, 19 Sep 2023 03:54:53 -0400
X-MC-Unique: ipqFwsEtMje7PLkPpeswuA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2bbc1d8011dso66310991fa.1
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 00:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695110091; x=1695714891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xq2PUpZjcLYmB0sc19KGgnU6q5ctsCTIhTwce+KUPmU=;
        b=JnBIrHRq0ULSaWOfJHVvHyheuoyjUfGc3Lv8MLrBuZGYkr/JWcaymr8ZdgUMWWEQtO
         ne+pJrGQfteN42SjaHcFlmQCWNqMl8XkBt/EV6Q6sTR2eq7T0k+viJPzKEWgM1Y8toZU
         RXp3TXCulBITkBo5b7YuLYWt36L15AVvUlGBroq0o8M8LNRb72ZWE6tYogLKUyeySPug
         oecXKDj5LjykKwcEQNTYhG9yUXoG1hcPznXVcSdZX4b2GfEoV/cWW1BPq/AzDIOHaIBk
         yn7yWMNRMO3ERPLdwniA60m3KmvemkoZJUaQ5DNvSJ1yr/O63Ubf8oVoXlZ+dwmDks6u
         BpIQ==
X-Gm-Message-State: AOJu0YxSDY10iE3a0LNM7W2jQQBCBJvcVUkoXmG52WGq6DhYI7KaP3pl
	hgoEBqcAhN5Rcx62Qrh9FuPusw155NW6dbWYRx7nOYxN2ifgGYWQe8qw78KYF6MI54aXoEZ9doS
	ATNwjNH5WDwM98RQ+
X-Received: by 2002:a05:6512:988:b0:500:7e64:cff1 with SMTP id w8-20020a056512098800b005007e64cff1mr7920460lft.14.1695110091567;
        Tue, 19 Sep 2023 00:54:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuCMWkGTykvVJzGOBWF+ltNRkIaGMXVMrzHnBowZKeRdkWnM1pfr62hc7g2qB3p0oGcC763w==
X-Received: by 2002:a05:6512:988:b0:500:7e64:cff1 with SMTP id w8-20020a056512098800b005007e64cff1mr7920452lft.14.1695110091255;
        Tue, 19 Sep 2023 00:54:51 -0700 (PDT)
Received: from sgarzare-redhat ([46.222.147.15])
        by smtp.gmail.com with ESMTPSA id a4-20020a05600c068400b004042dbb8925sm14294571wmn.38.2023.09.19.00.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 00:54:50 -0700 (PDT)
Date: Tue, 19 Sep 2023 09:54:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v9 0/4] vsock/virtio/vhost: MSG_ZEROCOPY
 preparations
Message-ID: <yys5jgwkukvfyrgfz6txxzqc7el5megf2xntnk6j4ausvjdgld@7aan4quqy4bs>
References: <20230916130918.4105122-1-avkrasnov@salutedevices.com>
 <b5873e36-fe8c-85e8-e11b-4ccec386c015@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b5873e36-fe8c-85e8-e11b-4ccec386c015@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 07:56:00PM +0300, Arseniy Krasnov wrote:
>Hi Stefano,
>
>thanks for review! So when this patchset will be merged to net-next,
>I'll start sending next part of MSG_ZEROCOPY patchset, e.g. AF_VSOCK +
>Documentation/ patches.

Ack, if it is not a very big series, maybe better to include also the
tests so we can run them before merge the feature.

WDYT?

Stefano


