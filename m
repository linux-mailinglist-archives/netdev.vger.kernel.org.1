Return-Path: <netdev+bounces-20848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84158761910
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 14:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2E0280FBE
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E0E1F17C;
	Tue, 25 Jul 2023 12:57:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0C81F179
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 12:57:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E6FE76
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 05:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690289843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y3gTlVtfN8TnduIHRVSWl2uOMQIZ0k51NZO0ThoVByg=;
	b=b4FHUSkusyeKA7n1KJTLZBuJIYrDYkNU0h3pd2CiOiKZIHETNW8cLfnOvVcvioatPA01cH
	tFYdxnEAllDmG2BrNlSQvlQOUC7e9u9mkuJwZFDBKof/gsQYdbiqXKgntGR2BYvcUSg5w4
	ODFIm7VtU5mb2ZdkZ3Xc7F6mcMkRyag=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-Vmwxcf25MfOUbcb1_dBKdA-1; Tue, 25 Jul 2023 08:57:22 -0400
X-MC-Unique: Vmwxcf25MfOUbcb1_dBKdA-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-79a378d5a00so57192241.1
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 05:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690289841; x=1690894641;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y3gTlVtfN8TnduIHRVSWl2uOMQIZ0k51NZO0ThoVByg=;
        b=CZFvbARgM8CTUGk1XU+1auyb2UGyjxxvXxlJ4WVWEyBhoW4uwprBaOV6al0JQVm2nB
         0G528mZXfPAT6dH6agPkisXIEd8pXSGWFzz1V66xSbpVHlYn61LjhshKuejhqxdhKpXk
         pI03kWOCszdfSNaFC/P+TFO7AiniDUbps8c8Ilxi/W0TuSg4DfdK/YIYW7DfcaAqFiSD
         FETxN3CZIcywl33JXdqut+RHCof+A2TWvaWny24CfJi/plJYSrkBRyPrmw2SpLktVGus
         Wd5fqtSOiReDMNeA+wXRTmfb3IkmARvgryNmpBl4hOXdvnrV7vLWA9/RB8PQfUIvLp7A
         hMWw==
X-Gm-Message-State: ABy/qLa2M9LeoHlwGd9/J6fmHLP8lJL8Mhd+2v1NHxPcnI3jyaRVb4pR
	q4L05/Wge+XX9RZzgSb3IbrVVW/weEE9UYl2uk7Pa9SSWvYBZkHiYTcQHlBVFKf/QtJObDp/M2P
	FSI8LK4dhuUYz4Vd4
X-Received: by 2002:a1f:a815:0:b0:47d:c99d:4fe6 with SMTP id r21-20020a1fa815000000b0047dc99d4fe6mr4627272vke.0.1690289841605;
        Tue, 25 Jul 2023 05:57:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE9M1b/JaouKWA4ypJpi1wYeIO/IAg/1P/W9/zhgO7lpb6q9hSffgHK3CEF+a4AjkfPNxVBtQ==
X-Received: by 2002:a1f:a815:0:b0:47d:c99d:4fe6 with SMTP id r21-20020a1fa815000000b0047dc99d4fe6mr4627253vke.0.1690289841326;
        Tue, 25 Jul 2023 05:57:21 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-81.dyn.eolo.it. [146.241.225.81])
        by smtp.gmail.com with ESMTPSA id s14-20020a0cb30e000000b006238b37fb05sm4350881qve.119.2023.07.25.05.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 05:57:20 -0700 (PDT)
Message-ID: <8a707435884e18ccb92e1e91e474f7662d4f9365.camel@redhat.com>
Subject: Re: [PATCH net 0/3] net/sched Bind logic fixes for cls_fw, cls_u32
 and cls_route
From: Paolo Abeni <pabeni@redhat.com>
To: valis <sec@valis.email>, netdev@vger.kernel.org
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pctammela@mojatatu.com,  victor@mojatatu.com, ramdhan@starlabs.sg,
 billy@starlabs.sg
Date: Tue, 25 Jul 2023 14:57:17 +0200
In-Reply-To: <20230721174856.3045-1-sec@valis.email>
References: <20230721174856.3045-1-sec@valis.email>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Fri, 2023-07-21 at 17:48 +0000, valis wrote:
> Three classifiers (cls_fw, cls_u32 and cls_route) always copy=20
> tcf_result struct into the new instance of the filter on update.
>=20
> This causes a problem when updating a filter bound to a class,
> as tcf_unbind_filter() is always called on the old instance in the=20
> success path, decreasing filter_cnt of the still referenced class=20
> and allowing it to be deleted, leading to a use-after-free.
>=20
> This patch set fixes this issue in all affected classifiers by no longer
> copying the tcf_result struct from the old filter.
>=20
> valis (3):
>   net/sched: cls_u32: No longer copy tcf_result on update to avoid
>     use-after-free
>   net/sched: cls_fw: No longer copy tcf_result on update to avoid
>     use-after-free
>   net/sched: cls_route: No longer copy tcf_result on update to avoid
>     use-after-free

The SoB in used here sounds really like a pseudonym, which in turn is
not explicitly forbidden by the the process, but a is IMHO a bit
borderline:

https://elixir.bootlin.com/linux/v6.4.5/source/Documentation/process/submit=
ting-patches.rst#L415

@valis: could you please re-submit this using your a more
identificative account? You can retain the already collected acks.

Thanks!

Paolo
>=20
>  net/sched/cls_fw.c    | 1 -
>  net/sched/cls_route.c | 1 -
>  net/sched/cls_u32.c   | 1 -
>  3 files changed, 3 deletions(-)
>=20


