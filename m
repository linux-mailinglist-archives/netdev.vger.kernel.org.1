Return-Path: <netdev+bounces-18131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A6A755464
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 22:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28B32812E1
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 20:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9498F74;
	Sun, 16 Jul 2023 20:29:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09A18F5B
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 20:29:53 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98432BC;
	Sun, 16 Jul 2023 13:29:52 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-676cc97ca74so1090962b3a.1;
        Sun, 16 Jul 2023 13:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689539392; x=1690144192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iK9RtZ9Rm9JaCO7gLtL/lZtWWMLp1ISIMI/Ww2ye3bw=;
        b=TBuKdBnQkQ0aj2HCakTY/yUXgSvInqs56ZVseMoTGdAwSVZhCAS7GM1Avc+bjipram
         8I6wNUs9cvdEczfVJex4V2nqZWruHG0dEMlcw7uFKSIsD2uwC3RX+k2j5vykhnb3XwOL
         QyG6PxMLYv2aPe7nH8vuUTpN7zLAx/cNINPF12MOh1kXiZVa2QrfU4tKsHEeIpceeneJ
         +/H96UfOMtMSLCV6efDyKiUDLlgt+CN/IZc9ZOTiQ5lZb+VwodPblqpvOWQzRacgzB9m
         1J0sWm7w2cpVoVD6EVGHSqFhQ5D305iEqEKtMbyMdj2b5S+7B9yh5iDCXd1P5tLDbiYR
         V5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689539392; x=1690144192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iK9RtZ9Rm9JaCO7gLtL/lZtWWMLp1ISIMI/Ww2ye3bw=;
        b=XDqtKoZtQO+Fx/4AZ5y9HS8rZo+7ya536Tx0nW7JJltQjN9cMQhAxcvrsnC7kYafQK
         aSdXtcJ37R4SsOzdvPmN9TOqEn06unYQz6Y6LQFbx0r6+w5LbojgHKW16S/s3PaZ7t01
         gZAHdQcm7AMY2pc+3YghG2UbQ4oB2+KeIGsI45jeUJ4l3kMHGepKG8nqPtfbcPsFHYL/
         hqDZczrEBsrZmhTNcdn1hyomCG1LcKR99OlNBhR4HAndurE1hl0SmAF15eFDpTUscL6a
         J+1WZVjh/Bc/t0g50bu/SqNuRcOS2tHwhTWLxsIue8pptobglCTd5mU+EzkYoiUdf+0+
         0MiQ==
X-Gm-Message-State: ABy/qLbGNExacO1RPgASybNjq5xLAMNXJOvk66PpfE5bjAK6qmHIIr9k
	Km3jSoCocO73HvSoudp/iQDpeuV7AmE=
X-Google-Smtp-Source: APBJJlGo4QWhLMdwkTNRGBxINBy9kxJFUsfhrAuSpGu+obMZNnwVdUWRGnFdUXrgMz4vvCBTbHhqrg==
X-Received: by 2002:a17:903:32cf:b0:1b8:a469:53d8 with SMTP id i15-20020a17090332cf00b001b8a46953d8mr13833632plr.0.1689539391898;
        Sun, 16 Jul 2023 13:29:51 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id a18-20020a1709027d9200b001ac7f583f72sm11307440plm.209.2023.07.16.13.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 13:29:51 -0700 (PDT)
Date: Sun, 16 Jul 2023 13:29:49 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Yangbo Lu <yangbo.lu@nxp.com>, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptp: Explicitly include correct DT includes
Message-ID: <ZLRTPcgYscAQgyRL@hoboy.vegasvil.org>
References: <20230714174922.4063153-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714174922.4063153-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 14, 2023 at 11:49:22AM -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Richard Cochran <richardcochran@gmail.com>

