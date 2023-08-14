Return-Path: <netdev+bounces-27469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C717777C1AB
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 22:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025A91C20B6E
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 20:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A66CD2ED;
	Mon, 14 Aug 2023 20:44:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF7D2CA6
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 20:44:26 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D52D1
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 13:44:25 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bbf8cb61aeso30278555ad.2
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 13:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1692045865; x=1692650665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yMTKyqg9kFybpSwnutc8Wf4Ipjy+kWZuL9Vn1vKnoI=;
        b=x9EQDEWA8luVnEsGaAMe3HByI2x5/9iXtTIXUOtjDzg3nAJcc6WBHk71JR+I3mkIXK
         U56p0YcvUM+wJBE6lzfrGW6/gPZ/E6LA1C8E0vd6phRrF32NjAhNKxv1NKxvjfPi9CtI
         oJ4XHTbiPmJoCYiJtcbCUHYX9Bm1WarFVc1Dtdk++zpJPKo9AS7UFHLyER9/2tfpEtkj
         Pm2jvEKYqEe7g64gpArKN8kJ0SRj0iTb2xjhahyaY19JAT6VJW6GKhIprAOZ0gQU8rik
         amsDKMbjb/aUlEevquAMP+E/ut2pNYvnExFArOgqnWZj7Nw+TBTdmdptzKBL8+/LKEw+
         Ongg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692045865; x=1692650665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5yMTKyqg9kFybpSwnutc8Wf4Ipjy+kWZuL9Vn1vKnoI=;
        b=jFN9tfu2uWNdkyfHjohaU/PVAJZoexIPJuyNAjBnEXHhrdCYPP5sWjpR8D0QYpdi7N
         4Mah8bSuh1VFo81Vl+TPA3fTKCOsgFhVY6+4AJ4tiA9bxOR5VR6tmUjQpNckrxIrShqD
         9PfxvlxDc+moTKLuLWD99j10VaUa7DKldS8vAd27M6lLhqtNtmAkHbFnp1g8UTU14X5H
         i69r6az3MXGWtM9Eo/0oTtQVkQt27cSQ7jkhzFO56XxriepcScYNi/blPiKZTA8suDCJ
         w7sXgdjP95Vp4ZeF8dehzEzmaUppdB66y3P4u5IdTYopBpFdnvd7JjDVmdPlNEbFKdRr
         z25g==
X-Gm-Message-State: AOJu0YyO0xFD35Id64zC0ZMhbYxsjeghrnI+gncsVYRYYMSj83rKFzz7
	GHDEUPjtReZkkW/NQfyUrUeLmFzFwjru82gdwbRjroW+q28=
X-Google-Smtp-Source: AGHT+IGHjoiiXT+tOhF4fO1SCtC/H+0Fy2gzXtHnx2qPCZH7on0fJwDDDdLhv/92FbzY0HXhCSF6iQ==
X-Received: by 2002:a17:903:185:b0:1bc:2036:2219 with SMTP id z5-20020a170903018500b001bc20362219mr10390594plg.41.1692045864919;
        Mon, 14 Aug 2023 13:44:24 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id ij13-20020a170902ab4d00b001b02bd00c61sm10005108plb.237.2023.08.14.13.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 13:44:24 -0700 (PDT)
Date: Mon, 14 Aug 2023 13:44:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maximilian Bosch <maximilian@mbosch.me>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] ip-vrf: recommend using CAP_BPF rather
 than CAP_SYS_ADMIN
Message-ID: <20230814134423.46036cdf@hermes.local>
In-Reply-To: <e6t4ucjdrcitzneh2imygsaxyb2aasxfn2q2a4zh5yqdx3vold@kutwh5kwixva>
References: <e6t4ucjdrcitzneh2imygsaxyb2aasxfn2q2a4zh5yqdx3vold@kutwh5kwixva>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 9 Aug 2023 11:26:36 +0200
Maximilian Bosch <maximilian@mbosch.me> wrote:

> -This command also requires to be ran as root or with the CAP_SYS_ADMIN,
> -CAP_NET_ADMIN and CAP_DAC_OVERRIDE capabilities. If built with libcap and if
> -capabilities are added to the ip binary program via setcap, the program will
> -drop them as the first thing when invoked, unless the command is vrf exec.
> +This command also requires to be ran as root or with the CAP_BPF (or
> +CAP_SYS_ADMIN on Linux <5.8), CAP_NET_ADMIN and CAP_DAC_OVERRIDE capabilities.
> +If built with libcap and if capabilities are added to the ip binary program
> +via setcap, the program will drop them as the first thing when invoked,
> +unless the command is vrf exec.

I don't like it when documentation becomes kernel version dependent.
And distro kernels backport all the time. Documentation should cover why
instead of hiding it in comments.

This paragraph is almost unreadable even before the patch. The verb tenses
and wording are not those that would be used by a native English speaker.

