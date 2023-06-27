Return-Path: <netdev+bounces-14181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5D873F642
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 09:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7441C209FB
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 07:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F1DBE4E;
	Tue, 27 Jun 2023 07:59:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA983846A
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 07:59:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BA3172A
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 00:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687852738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lP7TnuDcLltzpIl6PbyCFq5YcrBT0OHcqbbRWvHt8GI=;
	b=G4UuqVVsKmdTNWXLzYWDAuIPuu9ps4CJKdL1gl5bupKk8kZRP1+CuH+BaTctyrTYqaqDNj
	omR+YVSbwxOpFf8gZnklUNg2316CdxtNRwGOMetbfDi2eZdSlkExkiTkQBHJdWIaj8nL2Y
	cgwMcidI/+Pz6oSk8aIhKUtfy2cPWjc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-qaV_BhMUPrmOGzB56WW8rw-1; Tue, 27 Jun 2023 03:58:56 -0400
X-MC-Unique: qaV_BhMUPrmOGzB56WW8rw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-982180ac15cso247336166b.2
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 00:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687852720; x=1690444720;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lP7TnuDcLltzpIl6PbyCFq5YcrBT0OHcqbbRWvHt8GI=;
        b=F4aE8GapXs954GwYjHzUxSrHJHWYCTawmMVXZ7vLL7nCe4xs5u4qJsXd8rw2YHDETv
         uL6HU4LmANQvJy4vmwO2aLgQvLv/yBYjdYTS6SOl7eVxf1T8/Ie4gzIgJgGZ7Gh5Cr5o
         807+XrXLHOk8+Cv/ey2XdWNDb39KKvZUrgmFh4XfaGyYzBqZT/wmNkDiAkTsnAk2ZvRl
         Q39JvEavki0zDM3oA81QnZgi5d3ImNV6mrRsdgUkv+gfcEjhL0zro29rxqp5nDlHFpe7
         3edeSXkYeLwJ2KOz+DcfYkFg1dlqy7hyTDQOgCysL0a19TY5q0CEt13Kye1YfEW2Vq+M
         ZdMA==
X-Gm-Message-State: AC+VfDzI/8DMFQ111FpFkHm/nkzqg24moOCIBQRnPf0n7xqu5qXxonRz
	VHnvejF2akI0ViDBke/cqT+g+XhxX4jvh1z2T39EM2EjrhcjryJZL2dOzz8XxHEJqLQFVgaF6zL
	VUAjL3VOiREopaaLA
X-Received: by 2002:a17:907:7293:b0:988:d841:7f8d with SMTP id dt19-20020a170907729300b00988d8417f8dmr20588107ejc.71.1687852720272;
        Tue, 27 Jun 2023 00:58:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Z/tM/gaNroDjLrNnUmnljiX/qH4WmzORhNLz3fZPpTiwtq7Yuehq0VVWZN1uDhbc2Myv9fw==
X-Received: by 2002:a17:907:7293:b0:988:d841:7f8d with SMTP id dt19-20020a170907729300b00988d8417f8dmr20588100ejc.71.1687852719994;
        Tue, 27 Jun 2023 00:58:39 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id u13-20020a1709064acd00b00991f773d9c3sm1109508ejt.76.2023.06.27.00.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 00:58:39 -0700 (PDT)
Date: Tue, 27 Jun 2023 09:58:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v4 07/17] vsock: read from socket's error queue
Message-ID: <3ek3jnkp7iu6ypc6kq7iarx45bc4hkrmko4mtfqke6nvrjmsiu@mnvs66r2sejc>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-8-AVKrasnov@sberdevices.ru>
 <sq5jlfhhlj347uapazqnotc5rakzdvj33ruzqwxdjsfx275m5r@dxujwphcffkl>
 <4d532e35-c03c-fbf6-0744-9397e269750d@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d532e35-c03c-fbf6-0744-9397e269750d@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 27, 2023 at 07:49:00AM +0300, Arseniy Krasnov wrote:
>
>
>On 26.06.2023 19:08, Stefano Garzarella wrote:
>> On Sat, Jun 03, 2023 at 11:49:29PM +0300, Arseniy Krasnov wrote:
>>> This adds handling of MSG_ERRQUEUE input flag in receive call. This flag
>>> is used to read socket's error queue instead of data queue. Possible
>>> scenario of error queue usage is receiving completions for transmission
>>> with MSG_ZEROCOPY flag.
>>>
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> ---
>>> include/linux/socket.h   | 1 +
>>> net/vmw_vsock/af_vsock.c | 5 +++++
>>> 2 files changed, 6 insertions(+)
>>>
>>> diff --git a/include/linux/socket.h b/include/linux/socket.h
>>> index bd1cc3238851..d79efd026880 100644
>>> --- a/include/linux/socket.h
>>> +++ b/include/linux/socket.h
>>> @@ -382,6 +382,7 @@ struct ucred {
>>> #define SOL_MPTCP    284
>>> #define SOL_MCTP    285
>>> #define SOL_SMC        286
>>> +#define SOL_VSOCK    287
>>
>> Maybe this change should go in another patch where we describe that
>> we need to support setsockopt()
>
>Ok, You mean patch which handles SO_ZEROCOPY option in af_vsock.c as Bobby suggested? No
>problem, but in this case there will be no user for this define there - this option
>(SO_ZEROCOPY) uses SOL_SOCKET level, not SOL_VSOCK.

Got it, so it is fine to leave it here.

Just mention that we are defining SOL_VSOCK in the commit description.

Thanks,
Stefano


