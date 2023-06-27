Return-Path: <netdev+bounces-14328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1D8740256
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 19:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5E12810D7
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 17:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045211309B;
	Tue, 27 Jun 2023 17:38:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFA31308A
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 17:38:54 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F260626A5
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 10:38:52 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-668711086f4so67131b3a.1
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 10:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1687887532; x=1690479532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Npdxn4+suX/J8anoQMkLKCwl/iMlO/oTO6c1ZE3ljUk=;
        b=pgT005ghG3e7QjS8cgAYnTAeKjrZzeODEZE1FKfHqkY4huhzqU917DeJRJvo8zvtud
         RVR4T0g3cJ2fJczDp9Sfml2LMhaBoxtPpgP/GPooSy4/WgDZ+44+SX/LveKrLqMO7uJK
         Ci7TNCYlCMsVyv0R6qDNx7/Ajw9v0ojQ5ihMDoYUxZKnHLWeXMJCOY1HJI7myozgm4Pa
         HB4B/uunVvMwehSTb4IbpNjmdNCilfZeI18ySbW0g61/JCoCAh6eElJzcPGKFqR/HLNI
         6ybQG4ybU+OJLyw+AZJ7zxVj8zv+z0wsNk+0lkdMfEWnXAPFSQGtajyRaRQ1NpvZ+UEC
         b9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687887532; x=1690479532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Npdxn4+suX/J8anoQMkLKCwl/iMlO/oTO6c1ZE3ljUk=;
        b=f4i43prgf5xNcfMkmHj8p4b0T67mqSOQEpX/V11VAg+rRANmzPAprLZ6VUHOhlFBNo
         z4YizXxckrrNY4SonbALtms6DLUKYtJW8wd2oWdabgaCMM2rqP0sXlqvvxJBK3H/8zG3
         pMiGq6Ore8/en9VD2tcaNL///Tf/PqVk/QkdGPUBPdaAN0msXBBIwm2wwJgM2X0ADKaw
         eQed0eMWLB1tWD5UokDCxbFTAroCc/pQ/IxPhwWGD+fc2GBA2kZKinBJw9fPNTZwTRY+
         VMf65/a7J5aEggi56VeoRBmynsoMELnPU8v+pkOgNskSIXx2Qv7S/StJwuWItKKnGmb2
         rg3w==
X-Gm-Message-State: AC+VfDyAqeSh/4MIVkrsefnRfM65R5lIMM8yCR64taPB5MDyOTzHV9v8
	xlRrFhbkYjvVxdmERr5Q1Wq47WvHQ37wphb0qachiQ==
X-Google-Smtp-Source: ACHHUZ6W2Fc8lkegzKm+xiwHBC7kMLlG4asCs5OjYjBGetx1binpt9j2z8CKSPIQSn5QKUfLwfLS4g==
X-Received: by 2002:a05:6a00:2449:b0:657:1fe5:eb63 with SMTP id d9-20020a056a00244900b006571fe5eb63mr55025258pfj.7.1687887532344;
        Tue, 27 Jun 2023 10:38:52 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id s24-20020aa78d58000000b0064ff855751fsm5678063pfe.4.2023.06.27.10.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 10:38:51 -0700 (PDT)
Date: Tue, 27 Jun 2023 10:38:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bjarni Ingi Gislason <bjarniig@simnet.is>
Cc: netdev@vger.kernel.org
Subject: Re: tc.8:  some remarks and a patch for the manual
Message-ID: <20230627103849.7bce7b54@hermes.local>
In-Reply-To: <168764283038.2838.1146738227989939935.reportbug@kassi.invalid.is.lan>
References: <168764283038.2838.1146738227989939935.reportbug@kassi.invalid.is.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 24 Jun 2023 21:43:21 +0000
Bjarni Ingi Gislason <bjarniig@simnet.is> wrote:

> Package: iproute2
> Version: 6.3.0
> Severity: minor
> Tags: patch
> 
> Dear Maintainer,
> 
> here are some notes and a patch.
> 
> The difference between the formatted outputs can be seen with:
> 
>   nroff -man <file1> > <out1>
>   nroff -man <file2> > <out2>
>   diff -u <out1> <out2>
> 
> and for groff, using
> 
> "groff -man -Z" instead of "nroff -man"

Overall this looks fine but:
1. Make the commit message more succinct and clearer, don't need to write a letter.
2. Lines with starting with # get ignored by git when committing
3. Missing Signed-Off-by which is required for all iproute2 patches.

Running checkpatch on this patch will show these things.

