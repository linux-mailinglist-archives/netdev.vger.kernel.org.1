Return-Path: <netdev+bounces-26571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C0C7782C7
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 23:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C6A1C20DE1
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 21:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6526923BEC;
	Thu, 10 Aug 2023 21:42:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5716D22F0C
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 21:42:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A293272C
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 14:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691703753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2HtcNk1A7Nq+3/V6wlbgltFs7j7KhU3JDIUkHEFT9ak=;
	b=Zr3VHsCAN0Yu06Cm+KS2hWFC5f066tBMQnJM2FLmqPp8a//sLDUGN2x5KDoxdsaxtFJnCk
	qaLEbCLyzAXbtbamiWNgmLBMuac1TbMePlYZIfI+yPVzKR8I+WGbbYGhAr73JF2/4rGJhp
	FRzkmrCG/R0aZkJaseo5xSgWpYwxm+o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-WzoR3YztP3Kp6DYRA5MF4Q-1; Thu, 10 Aug 2023 17:42:32 -0400
X-MC-Unique: WzoR3YztP3Kp6DYRA5MF4Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fe19cf2796so9072405e9.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 14:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691703735; x=1692308535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HtcNk1A7Nq+3/V6wlbgltFs7j7KhU3JDIUkHEFT9ak=;
        b=hThbO7cNbmAUUoBKsuYDPdCh29ss5sAN8zUuHIxG4OLV16MmvTFWX7685fdvm3OeOc
         IuWsfp1YC2rUWuHwqFXxFdeG3ywmIRC5vDgfbE1wQ3/igPca76ChJUnQZ9HAMfxziDhO
         zr6EoHKuQxDW/pznMkumUaMS2ypn0A40kr44IE/O7oOrJnJdpHlqgXBFBvM2cF9K93/0
         EE+J+hfmo/EvWoaPaTZqSjhFiiUU9lSX12H1FBt7o3rOILEFzB45CTF3GoQ5JtZwmYlI
         MKDqvSMS1pDjq1R4uTtF/vlWxW8xbZkfiH7eFM9ZrvbaQ+FZwtfu8vMH+/ZJn207ASn1
         p+Vw==
X-Gm-Message-State: AOJu0YyYIGNxrKVKNNst87kWJuHT3nyE7jiMQGRxjLJYybE6yuMW960m
	oHem4XRIgPu0+9jY8Z6zwVQw81mzTHRA6FEYoJnTuBc56fD6BS8FWjPH9IfTQAq9MGT9eggq2gw
	YgXWLC2po8WNKCJFm
X-Received: by 2002:a05:600c:218f:b0:3fc:186:284d with SMTP id e15-20020a05600c218f00b003fc0186284dmr107040wme.18.1691703735764;
        Thu, 10 Aug 2023 14:42:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8OFCHupC30sqzZHz8wZXJmFsOw+UxdKSTyakavwrTBFMqwiyoteEVk+I7wC7S8jsf3rwrDQ==
X-Received: by 2002:a05:600c:218f:b0:3fc:186:284d with SMTP id e15-20020a05600c218f00b003fc0186284dmr107027wme.18.1691703735439;
        Thu, 10 Aug 2023 14:42:15 -0700 (PDT)
Received: from redhat.com ([2.55.42.146])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b003fba6a0c881sm6129528wmj.43.2023.08.10.14.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 14:42:14 -0700 (PDT)
Date: Thu, 10 Aug 2023 17:42:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, xieyongji@bytedance.com,
	jasowang@redhat.com, david.marchand@redhat.com, lulu@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Subject: Re: [PATCH v3 0/3] vduse: add support for networking devices
Message-ID: <20230810174021-mutt-send-email-mst@kernel.org>
References: <20230705100430.61927-1-maxime.coquelin@redhat.com>
 <20230810150347-mutt-send-email-mst@kernel.org>
 <20230810142949.074c9430@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810142949.074c9430@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 02:29:49PM -0700, Jakub Kicinski wrote:
> On Thu, 10 Aug 2023 15:04:27 -0400 Michael S. Tsirkin wrote:
> > Another question is that with this userspace can inject
> > packets directly into net stack. Should we check CAP_NET_ADMIN
> > or such?
> 
> Directly into the stack? I thought VDUSE is vDPA in user space,
> meaning to get to the kernel the packet has to first go thru 
> a virtio-net instance.

yes. is that a sufficient filter in your opinion?

> Or you mean directly into the network?


