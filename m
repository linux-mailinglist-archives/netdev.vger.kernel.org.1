Return-Path: <netdev+bounces-35765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401F87AB034
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 13:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E68912824CA
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 11:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC611DDEA;
	Fri, 22 Sep 2023 11:07:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9435918B0C
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 11:07:01 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFAC197
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 04:06:59 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso251788066b.1
        for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 04:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1695380818; x=1695985618; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=wOCT5ExoC5YPQiQiKaq0RQhda2tSHNuc6pgLlFjLqqU=;
        b=IP85yETdfvlmWtTLgQvn/zUWZ4Gn1onznz86Lz4rYiWIbdn4Y4WJqvKXGAdu+Xu3gS
         HAFLueHcvNmr0lvpDtpx6uOjEKTQW193Er89S9fD7nxqECzkY9j/GYOo8E6yoS3XLfh+
         QT+YFHVvARiEdKrEiAJ2qKHRDvoHIwdir1giinji+yHAGMgCy0JC7g9/ysSlJvcnqphD
         UX2Ag+vIVBVMcna86nX27YpoHq3h+hocpMO0d1RF8thmtRtZhhCJZhc5G7Y0QuDv8JEQ
         wYiKibUa1GHCEe0PIb8UtMmGm7fv+4+MYF6ACf1Y6vul3Ks0fmRMsI9ZcDendCicWH1B
         ZzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695380818; x=1695985618;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOCT5ExoC5YPQiQiKaq0RQhda2tSHNuc6pgLlFjLqqU=;
        b=CEGoJtdjyXT2YgmaEXFCgXrXp9c3X8+HskCCmDND3BCTWkyBFGg9A9a2k6GJO5M+i1
         LXoFnLM2DKloLmeDWM0fMwPob43gzlAr9ceoOQPVOJJUmnBVkDcKXC+7yBctnMGk4r7H
         roPVUNpjDiUzTFC1YazBBsNQtK2l5vSx+rD9XM88b/bRASMrQaz5Ps4FUZosM25F6VFG
         fUg/tlA+QqdhR4aHNVr3GyxK1D505DQj16zFyBwpFIV7NNqyZUOBIEFxaXizKwpJ1tLZ
         GxvGjOnFbQYiVjMM8n3D2XBsJxksUZJOkYCN4/aS1x4ujof1JBuKpJNr4B8X/Z208HP3
         NELQ==
X-Gm-Message-State: AOJu0YzOUISA0cNBtcd0nxEgtNHG6GPpUGGOiVJsCzuM6MzAXnn0VSjJ
	0Bm+7qdxSvEG3dIrfMomBuIms0HXZ4s8w9cZbSg=
X-Google-Smtp-Source: AGHT+IGIgmfl8kFxYgfccaUTbjUpz/4MfyDAq2jjgq/Z9YPBa1wYUwZppJ0KQnQ9uo2j2/ApTdwChg==
X-Received: by 2002:a17:906:30c7:b0:9ae:738b:86d0 with SMTP id b7-20020a17090630c700b009ae738b86d0mr1520786ejb.66.1695380817983;
        Fri, 22 Sep 2023 04:06:57 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:139])
        by smtp.gmail.com with ESMTPSA id d11-20020a170906370b00b0097404f4a124sm2570971ejc.2.2023.09.22.04.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 04:06:57 -0700 (PDT)
References: <20230920232706.498747-1-john.fastabend@gmail.com>
 <20230920232706.498747-4-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf 3/3] bpf: sockmap, add tests for MSG_F_PEEK
Date: Fri, 22 Sep 2023 13:06:36 +0200
In-reply-to: <20230920232706.498747-4-john.fastabend@gmail.com>
Message-ID: <875y42sbzj.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 04:27 PM -07, John Fastabend wrote:
> Test that we can read with MSG_F_PEEK and then still get correct number
> of available bytes through FIONREAD. The recv() (without PEEK) then
> returns the bytes as expected. The recv() always worked though because
> it was just the available byte reporting that was broke before latest
> fixes.
>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

