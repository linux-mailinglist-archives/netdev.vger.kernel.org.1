Return-Path: <netdev+bounces-14182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EB673F64B
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 10:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45391C20A98
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 08:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1374BE4F;
	Tue, 27 Jun 2023 08:01:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD148A94B
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 08:01:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F1C1716
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 01:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687852886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZVrQ3elX4XCNFCp5FYtuzZCCkQ+mBaJA/Ngz6/9n5g=;
	b=Ik1N6zEHugtTkZMHBO8RaSFEYfSdcFwTRy46W6JyZKsdi1KmbBNgH4W5sXxTKcdCO27Rss
	pGYUti0Q8lx1sreQwZFOjuy5J/ZZWUUxx/xn0NQSTV1k23d8k2dm1HqJbyoJLtcche6OB4
	Fe+8/GL3tzNebNsJuZKmM4xBBvWH6u8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-4S6EvSsxNguyDOUbfs4nHA-1; Tue, 27 Jun 2023 04:01:24 -0400
X-MC-Unique: 4S6EvSsxNguyDOUbfs4nHA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-98277fac2a1so312679466b.3
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 01:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687852883; x=1690444883;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oZVrQ3elX4XCNFCp5FYtuzZCCkQ+mBaJA/Ngz6/9n5g=;
        b=CzjcyP4PD0xR6yq+sHXStHPPrRAQN7HQkNQ5LzE6NW7BMQJSfchDMK9b+dTMUcxWWB
         2sxVNVBvZn4rOacHLGBVonzaG5Ani6HxN2i4T8DVWRKK8NMk6zsb+YgDOX+5ZTADUC9d
         +mb1+pZDT/YX15ZPUsW1NBjspX/kJG+chgc+BAqoVRhWIwWIz8x7B0FC7GHNtGQisUB4
         jB49M6WWZyrZG7QfvK0zgNkFILyrNJ4OWab+LnKGEq/eUQHCdjPF4p4i8mJIGky1Hupk
         4lezOjIGkrUgvHDfr8e7RBU2Mx2kLuYOxjS4hgJxh7RP3PZcJTHpYNGoCDWzORUYpvbA
         B8cA==
X-Gm-Message-State: AC+VfDzgX1vrDtQV/4UlzWUTAQl4zMjb7Y0kQy65FPPAzsfA7QI0ShBO
	d6Rsi1D7whIHEeFFoOCP3kaKtHMMRnkN74QddlXicNgS7PWtvnaiOx+xRdfGWiPhBtMcznQHe8e
	EbwvmgoO3KldYRUf7
X-Received: by 2002:a17:907:16a1:b0:988:d1d5:cd5b with SMTP id hc33-20020a17090716a100b00988d1d5cd5bmr22462643ejc.75.1687852883136;
        Tue, 27 Jun 2023 01:01:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Z0J/vWmfnxp6OJSKZUcEDuPdK0byEs7sKI3sU5hfyvYS5pWlrPir4/Xy8z0GyEbfTC147Zw==
X-Received: by 2002:a17:907:16a1:b0:988:d1d5:cd5b with SMTP id hc33-20020a17090716a100b00988d1d5cd5bmr22462601ejc.75.1687852882783;
        Tue, 27 Jun 2023 01:01:22 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id re3-20020a170906d8c300b00977ca5de275sm4307511ejb.13.2023.06.27.01.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 01:01:22 -0700 (PDT)
Date: Tue, 27 Jun 2023 10:01:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v4 00/17] vsock: MSG_ZEROCOPY flag support
Message-ID: <vqh472etosyyht53hd3bafvtuaedwhqsuqwdbmfkd6lyvxkkgq@mnp42ujut5ox>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <kilgxopbdguge4bd6pfdjb3oqzemttwzf4na54xurwl62hi7uc@2njjwuhox3al>
 <352508dd-1ea2-5d2d-9ccf-dfcfbd2bb911@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <352508dd-1ea2-5d2d-9ccf-dfcfbd2bb911@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 27, 2023 at 07:55:58AM +0300, Arseniy Krasnov wrote:
>
>
>On 26.06.2023 19:15, Stefano Garzarella wrote:
>> On Sat, Jun 03, 2023 at 11:49:22PM +0300, Arseniy Krasnov wrote:

[...]

>>>
>>>           LET'S SPLIT PATCHSET TO MAKE REVIEW EASIER
>>>
>>> In v3 Stefano Garzarella <sgarzare@redhat.com> asked to split this patchset
>>> for several parts, because it looks too big for review. I think in this
>>> version (v4) we can do it in the following way:
>>>
>>> [0001 - 0005] - this is preparation for virtio/vhost part.
>>> [0006 - 0009] - this is preparation for AF_VSOCK part.
>>> [0010 - 0013] - these patches allows to trigger logic from the previous
>>>                two parts.
>>> [0014 - rest] - updates for doc, tests, utils. This part doesn't touch
>>>                kernel code and looks not critical.
>>
>> Yeah, I like this split, but I'd include 14 in the (10, 13) group.
>>
>> I have reviewed most of them and I think we are well on our way :-)
>> I've already seen that Bobby suggested changes for v5, so I'll review
>> that version better.
>>
>> Great work so far!
>
>Hello Stefano!

Hi Arseniy :-)

>
>Thanks for review! I left some questions, but most of comments are clear
>for me. So I guess that idea of split is that I still keep all patches in
>a big single patchset, but preserve structure described above and we will
>do review process step by step according split?
>
>Or I should split this patchset for 3 separated sets? I guess this will be
>more complex to review...

If the next is still RFC, a single series is fine.

Thanks,
Stefano


