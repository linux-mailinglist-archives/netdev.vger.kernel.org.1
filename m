Return-Path: <netdev+bounces-31605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C9978F033
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 17:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60871C20AFA
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 15:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46736125DF;
	Thu, 31 Aug 2023 15:24:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35478186A
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 15:24:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A7AE69
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 08:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693495408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T2qLYWseOqvE9giCpHzoh0LjB8ysce7C+TOetknN7JE=;
	b=Qd8X79P9VcslsGIi7Jm3GZEPtdDARFD9kMiuTR3VGVNAukpUTjGCOd/XjLSL+qR+hR6Wup
	WcUj4Wn7zaiRYkRudeTnqOAp1pO2Uk+AHoJW3H+LxJJaDryeAgHAn94squ8O371GT+b9cR
	X6F25BDeocHGM9lJAjsdewM3HR6etpM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-z2lWzOcoOnqH2fQtTJKMSA-1; Thu, 31 Aug 2023 11:23:26 -0400
X-MC-Unique: z2lWzOcoOnqH2fQtTJKMSA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-997c891a88dso67180566b.3
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 08:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693495405; x=1694100205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2qLYWseOqvE9giCpHzoh0LjB8ysce7C+TOetknN7JE=;
        b=UGjPmSTBGq2t5E4Darv3NV3V2OMwDZuVoAnfm4Z0F3pvufYey4Nwq94Cbm1LzdjxKL
         p7OxGo30Kfs0+XnO1VnCbwXi81nSpNxggYuOi3U9/vYjzwlLLVs1j68kgJyrkkxs4Zmk
         C5nvGhQKPFbYmyOY3Hju4ewI+xpKT0zoMhZAwXaRXZhTKAjCG1pBLZK8r8uI0MUxzftA
         NXGNATJCIcmaFHSWsvZ9x4qYkUy8kUTHIxtVKlc27JNoLPWudy0eafjG34IsvlPdlCuh
         zFUzAoTGkBGkDQ6DcR4TLe9+2bJgLHbmyXrDpFYOACwgey3iKCo34hDzhyW/KkzVQtSH
         NMWQ==
X-Gm-Message-State: AOJu0YzztNG5URfXykXyJpxJoKsvuTU4mnVyqV+DNNHvX8oEWbSdn19D
	IyZMs1atKxqiT43zY//iJgmG/Zsce8xdLyHVyxpSk4KUoM7+CMVTegH7V9NIm8jtU2uWc34iLcb
	B6UWKFYdn/Stz8FgV1PtSFkKD
X-Received: by 2002:a17:907:270c:b0:99b:40b5:1c3b with SMTP id w12-20020a170907270c00b0099b40b51c3bmr4298755ejk.57.1693495404938;
        Thu, 31 Aug 2023 08:23:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqU32suFcax5N4zksCL5waYuwAr8trEmXcjLOBAuPXy6wP4BOWSV+IqSHWUR9lSPZ+Yzgs4w==
X-Received: by 2002:a17:907:270c:b0:99b:40b5:1c3b with SMTP id w12-20020a170907270c00b0099b40b51c3bmr4298742ejk.57.1693495404674;
        Thu, 31 Aug 2023 08:23:24 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it. [82.57.51.114])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709066b9200b009930308425csm859467ejr.31.2023.08.31.08.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 08:23:24 -0700 (PDT)
Date: Thu, 31 Aug 2023 17:23:22 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v2 0/2] vsock: handle writes to shutdowned socket
Message-ID: <7byt3iwpo5ewpxkjwh6adlzq2nerrbv7trlreujuchsrkworxk@2jxzyul3o5cz>
References: <20230826175900.3693844-1-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230826175900.3693844-1-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Arseniy,

On Sat, Aug 26, 2023 at 08:58:58PM +0300, Arseniy Krasnov wrote:
>Hello,
>
>this small patchset adds POSIX compliant behaviour on writes to the
>socket which was shutdowned with 'shutdown()' (both sides - local with
>SHUT_WR flag, peer - with SHUT_RD flag). According POSIX we must send
>SIGPIPE in such cases (but SIGPIPE is not send when MSG_NOSIGNAL is set).
>
>First patch is implemented in the same way as net/ipv4/tcp.c:tcp_sendmsg_locked().
>It uses 'sk_stream_error()' function which handles EPIPE error. Another
>way is to use code from net/unix/af_unix.c:unix_stream_sendmsg() where
>same logic from 'sk_stream_error()' is implemented "from scratch", but
>it doesn't check 'sk_err' field. I think error from this field has more
>priority to be returned from syscall. So I guess it is better to reuse
>currently implemented 'sk_stream_error()' function.
>
>Test is also added.
>
>Head for this patchset is:
>https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=b38460bc463c54e0c15ff3b37e81f7e2059bb9bb
>
>Link to v1:
>https://lore.kernel.org/netdev/20230801141727.481156-1-AVKrasnov@sberdevices.ru/
>
>Changelog:
>v1 -> v2:
> * 0001 stills the same - SIGPIPE is sent only for SOCK_STREAM as discussed in v1
>   with Stefano Garzarella <sgarzare@redhat.com>.
> * 0002 - use 'sig_atomic_t' instead of 'bool' for flag variables updated from
>   signal handler.
>
>Arseniy Krasnov (2):
>  vsock: send SIGPIPE on write to shutdowned socket
>  test/vsock: shutdowned socket test

Thanks for this series, I fully reviewed it, LGTM!

Please send it targeting net-next when it reopens.

Stefano


