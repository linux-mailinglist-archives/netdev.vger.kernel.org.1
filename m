Return-Path: <netdev+bounces-24305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B35376FB5A
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 09:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D40F3282510
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 07:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13178480;
	Fri,  4 Aug 2023 07:50:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8B88471
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 07:50:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6327B421E
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 00:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691135415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EJNCjBbUaxpHFi81g2fq9zXIhVcgdwCTwZCKF8pxHv8=;
	b=csf0Tqp6AWC8HYl9beXKgYkCTS/+o17LWk+VIliad4H2MnkPG+e7ZgJQDmh3asaEa5qVR9
	idbaSYL7qt5UUfzhPqOguU6ItQs+UOFR3t2zpSDMNceZLmJ7KOQz7O6nnE1pqM80p0ChvU
	DlPubDNfEdMNNEePJ92zPdUMZDB3tFc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-R1tEHMsFN9SUz5KjHBpwiQ-1; Fri, 04 Aug 2023 03:50:14 -0400
X-MC-Unique: R1tEHMsFN9SUz5KjHBpwiQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-40c8f2f17c3so24741961cf.2
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 00:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691135413; x=1691740213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJNCjBbUaxpHFi81g2fq9zXIhVcgdwCTwZCKF8pxHv8=;
        b=i+RA9X2FWAEjIWa80BmdsEzPAoHhgPvasp4jWD4qI3aRH9o7vqqnDNuz0BfP+Jna0T
         al5DoChtOXisGgaantdLYoNBDuaWKho/bHFWHYwqtkClga2IQdq6alInnIEH9dN3tVCw
         ZM5AkEr8PhY3i2BRH7kkxnWWxq0sOIUvN+f5ZVcZPPbnBt6TCB6aLuQh21HnrqSnYOqG
         HV1e5OgPAC3KpbdzolNFITetQy5U03zY/KPzcl9Dsn8ulAtFWFQsQWL+FnW7uObmpfKN
         w90QRK+Ky1srXxUyg5rpfnCs10/6WnNwYwchy50SbuX0Yw9rot5spj5mtfvGtB+BMOZw
         Yekg==
X-Gm-Message-State: AOJu0Ywya9LHtnqgnaA2mUngrDntQypqVNkwrzfqZol6KfPhBfApPU6J
	J9+6zcYnLm3AQRl4op37lUR/Swzz8qgbWEohHsEcytFJSLdSHXB8QhLGiiPnIjo5+1hlYootNpy
	P+XxPFXHNhVXP4qyf
X-Received: by 2002:a05:622a:651:b0:405:49e0:899f with SMTP id a17-20020a05622a065100b0040549e0899fmr1604383qtb.39.1691135413412;
        Fri, 04 Aug 2023 00:50:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdJhhhHo66q8mOj5/wTJahLgvxWofEBXXNIVMVbM5UXM0NqJORuYMOilvr66YHHR5o9ji0/w==
X-Received: by 2002:a05:622a:651:b0:405:49e0:899f with SMTP id a17-20020a05622a065100b0040549e0899fmr1604364qtb.39.1691135413153;
        Fri, 04 Aug 2023 00:50:13 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-214.retail.telecomitalia.it. [82.57.51.214])
        by smtp.gmail.com with ESMTPSA id c24-20020ac80098000000b003f7fd3ce69fsm485256qtg.59.2023.08.04.00.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 00:50:12 -0700 (PDT)
Date: Fri, 4 Aug 2023 09:50:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, bobby.eshleman@bytedance.com, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH -next] af_vsock: Remove unused declaration
 vsock_release_pending()/vsock_init_tap()
Message-ID: <xjs5cdmrcnsnzvbezd24lzvb4fgoofkyamvbxzbcwpetslhizc@seph4jwbpziv>
References: <20230803134507.22660-1-yuehaibing@huawei.com>
 <ZMwBFdw8BTno3dn2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZMwBFdw8BTno3dn2@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 03, 2023 at 09:33:41PM +0200, Simon Horman wrote:
>On Thu, Aug 03, 2023 at 09:45:07PM +0800, Yue Haibing wrote:
>> Commit d021c344051a ("VSOCK: Introduce VM Sockets") declared but never implemented
>> vsock_release_pending(). Also vsock_init_tap() never implemented since introduction
>> in commit 531b374834c8 ("VSOCK: Add vsockmon tap functions").
>>
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>
>Hi Yue Haibing,
>
>FWIIW, I think this should be targeted at net-next.

Yep, please send to net-next.

Looks good also to me:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


