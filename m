Return-Path: <netdev+bounces-14274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A22C73FDC2
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 16:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705072810C2
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 14:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEB418B1D;
	Tue, 27 Jun 2023 14:25:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCD518B12
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 14:25:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F05270F
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 07:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687875931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vGSc4mdTDNNjtXngrQkAE2Vk0OODhwWQe551QFWP1tI=;
	b=FdeUnfOrm11b2wep8KkXunjz2EIbay/CzmOilQniVGanUWI3cNHOT9xJGCTkoh0Bqrv/tp
	gwMla8wVpT1Wps4yRuFmt6ZFuHTW+MayFs2tHFZQFLERtE7Dwu1l61FdMY2BUSRvjpLAa6
	OOzwc+twiss85/ktI9wJjIxcQMV+Wrc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-9ZGZq4u1P1Sk6MW0fWy6cA-1; Tue, 27 Jun 2023 10:25:27 -0400
X-MC-Unique: 9ZGZq4u1P1Sk6MW0fWy6cA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-982180ac15cso273571066b.2
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 07:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687875915; x=1690467915;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vGSc4mdTDNNjtXngrQkAE2Vk0OODhwWQe551QFWP1tI=;
        b=ND6FwBRs18DLAX+kycw2uIsXDCUlDnlumrlawcMnDFmgS4UGswHOBiBHd46p8jXwoU
         3uh4fBKAqLwQjtanBAcPTZRSJFGYwC5H3VIRA08J2Ur11InRJvKfmzn2OuefJYFz9YTp
         dTPbt/Q09KoPNan1YFkOpzuCVETzeQPxduZI2Z9IvwbDl4G7JCHXoomioBSrYNx4HCYd
         UXrMjdIiwRFd7DBg/tgLLUIbqx5jbDH98L4SXsLW1y6GRSK3OeRVSLmp+AK3vJ6CGDyY
         a/gWGaI4rETSx5EZu9CBrYIkdV53lgBJHM04+1yBDvy4I1WqiyeO5fOW1pXQqCcvhQGs
         K8Qg==
X-Gm-Message-State: AC+VfDwDYf8syGThPQhBPOwB1S42ofFMjrPUlL71jVhJ2d6yU6PeIdZ+
	+/2i7ndUWY08Wz8ML9QeJvZm2IyRiY4OxsHSoUbJiCDMg+qblI8HI7jCXifUD1fL2moGl6Ldjtt
	KUan/OHmfXZE9SgNQ
X-Received: by 2002:a17:906:da8b:b0:982:26c5:6525 with SMTP id xh11-20020a170906da8b00b0098226c56525mr32188637ejb.60.1687875914698;
        Tue, 27 Jun 2023 07:25:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6i5PkNbA3Uw3V9yHzNgEF6zgc+6XvzXai4Ju+na594EFjrV8ZjoKAuLT8tuRH4vcpCqG3Dfw==
X-Received: by 2002:a17:906:da8b:b0:982:26c5:6525 with SMTP id xh11-20020a170906da8b00b0098226c56525mr32188620ejb.60.1687875914199;
        Tue, 27 Jun 2023 07:25:14 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id qn1-20020a170907210100b0098e42bef731sm3234766ejb.169.2023.06.27.07.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:25:13 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2921ABBFF6C; Tue, 27 Jun 2023 16:25:13 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 coreteam@netfilter.org, netfilter-devel@vger.kernel.org, fw@strlen.de,
 daniel@iogearbox.net
Cc: dsahern@kernel.org
Subject: Re: [PATCH bpf-next 0/7] Support defragmenting IPv(4|6) packets in BPF
In-Reply-To: <cover.1687819413.git.dxu@dxuuu.xyz>
References: <cover.1687819413.git.dxu@dxuuu.xyz>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 27 Jun 2023 16:25:13 +0200
Message-ID: <874jmthtiu.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> The basic idea is we bump a refcnt on the netfilter defrag module and
> then run the bpf prog after the defrag module runs. This allows bpf
> progs to transparently see full, reassembled packets. The nice thing
> about this is that progs don't have to carry around logic to detect
> fragments.

One high-level comment after glancing through the series: Instead of
allocating a flag specifically for the defrag module, why not support
loading (and holding) arbitrary netfilter modules in the UAPI? If we
need to allocate a new flag every time someone wants to use a netfilter
module along with BPF we'll run out of flags pretty quickly :)

-Toke


