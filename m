Return-Path: <netdev+bounces-22685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4954768BEC
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 08:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5570A280EE8
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 06:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A95BEDF;
	Mon, 31 Jul 2023 06:24:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB36EC4
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 06:24:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E3D1BC
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 23:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690784687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kCGfGQpNevEyxQJOi2EpZ/60FOEBzdh7x63Yvc5DA1k=;
	b=YGl4rQzqXAwanoeUDx/c7agUc2x4cic/NviePL+TRdWXvMLa1DKiHZbOmeFnmDLfAmEv+5
	rSDQZRbkI9QedHItsqJVt7hoJTZ+gVL/EMXqOrMF7JXy8qtlaOalwb2FwXguxlhAyf2MrV
	q7pdmh6/efkl+kjbVea0rNXxHwWz3Tw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-2qwMDNPrO6SlJUmn0Rmfpw-1; Mon, 31 Jul 2023 02:24:44 -0400
X-MC-Unique: 2qwMDNPrO6SlJUmn0Rmfpw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-68732996d32so965985b3a.3
        for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 23:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690784684; x=1691389484;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kCGfGQpNevEyxQJOi2EpZ/60FOEBzdh7x63Yvc5DA1k=;
        b=PPTJQXNssDc+nVcVc2BMhBgEesGj1DweDJQEiJuyOWRZSPM4UejMigpziSHsZ6yvZt
         aUGHnhpKj5fSramqHq3NV+zZEocKsDAMSLr2ATA2Ka3Wao97g6d/yqIWBH9ts3YQOB3x
         9a0yQTsFQjWZLrh9wfcQILeqofVhLunooT3SVFV1C4OGUFBaOWMemPCsxzuigkEH26Rv
         NL2PLxwoYFKhoQ1KwlrZAo3EnuEDsglh/QIZmANo26v2JF34acoAmHZeY1NAkUiX/pgg
         Ps3nx8Xoj+eTgut4F/r8Irk6SArBxdiXrg6YDWhRG7qCJOw7ATy1tdFHpw6163ji9cg1
         qE7A==
X-Gm-Message-State: ABy/qLY1pP2k2m/6GUArvXK7qJNJVGk39/6naCheeSi3eCkpcnvxEA7X
	5uPoBSTMRciPh3kzajNtXOpgitjbhckVZsfTE6v1YNM1+CGXFxWh4qSwQdA+CDnr82RJ38QgV++
	HhdGvh/hVttlDpBht
X-Received: by 2002:a05:6a00:1902:b0:682:5634:3df1 with SMTP id y2-20020a056a00190200b0068256343df1mr10454902pfi.10.1690784683938;
        Sun, 30 Jul 2023 23:24:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE7hRSrqGoCxMOCQEWdDDgEVMWsydvLGR7y6jP66LSsLJaoK1Qrd924k7OelmyerHuJSUgtvg==
X-Received: by 2002:a05:6a00:1902:b0:682:5634:3df1 with SMTP id y2-20020a056a00190200b0068256343df1mr10454894pfi.10.1690784683710;
        Sun, 30 Jul 2023 23:24:43 -0700 (PDT)
Received: from [10.72.112.185] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e7-20020aa78247000000b0066f37665a63sm1200909pfn.73.2023.07.30.23.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 23:24:43 -0700 (PDT)
Message-ID: <bd76081f-e6d3-ee60-a2de-cacd3e40563d@redhat.com>
Date: Mon, 31 Jul 2023 14:24:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next V4 3/3] virtio_net: enable per queue interrupt
 coalesce feature
Content-Language: en-US
To: Gavin Li <gavinl@nvidia.com>, mst@redhat.com, xuanzhuo@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, jiri@nvidia.com, dtatulea@nvidia.com
Cc: gavi@nvidia.com, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Heng Qi <hengqi@linux.alibaba.com>
References: <20230725130709.58207-1-gavinl@nvidia.com>
 <20230725130709.58207-4-gavinl@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230725130709.58207-4-gavinl@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


在 2023/7/25 21:07, Gavin Li 写道:
> Enable per queue interrupt coalesce feature bit in driver and validate its
> dependency with control queue.
>
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


