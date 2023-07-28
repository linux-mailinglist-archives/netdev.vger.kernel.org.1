Return-Path: <netdev+bounces-22378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8557673A8
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 19:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A671C203A2
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7F5156F2;
	Fri, 28 Jul 2023 17:43:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F310E14AA6
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 17:43:16 +0000 (UTC)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B7A19B
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:43:15 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-76ae0784e0bso110079085a.0
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690566194; x=1691170994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ow1dOB44syTAe0NpfhihQwAompkV9GWSbhBvMRdYVTQ=;
        b=Ouhhw6u7fqADJY+H1/kFxhxmp2WKsqPyd03Mlv5dUG0DmvPy9caWPbD1AvCkvGYbWe
         1kLa0VVzdrCbfWm+rqWk9WsLPe+jFF1Zi7i2Ut2T9rY+MpLK7fh0NEblFrvF2djUssq7
         F+fxk1WcuUjH9a9p7T9UXCMqzVOHGcIC/A4wQL3T0r/pJ8cyWQbVwr1cqf5m3WjvYkbL
         AejUb+m5m7NR5Y3nppmUsxomi56ZmV904voI9terGcp9GZaBXll39GTC6ztqPGWmC2fz
         b/9J/bwNHZIbQRfvPCKH3fLM1b/mm5+lA1YfVxCKL6EThXIF0Y0GRBFXTxXo2aVYVyqy
         wapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690566194; x=1691170994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ow1dOB44syTAe0NpfhihQwAompkV9GWSbhBvMRdYVTQ=;
        b=eWGCZDa9F2vpp/Xj2fwTi7aSl4gxPmxHbZN1SU/Q4Ya5XDUVlxJLefWvXf4fA8FVwW
         8IMgYmlk/Sw+HZm6sL8gOTK2zAFjDuP4+DSW6gcKksP98AfDkUjVZARSeEJbhDTAAcHM
         9YBHLErKPIHf7LORQaTiIC0fZMpUeT7q1sZV1aMMjGzbiHwB3bjhgMSlvVeflSRffkgd
         5G3Fbwcc1DupnC3VotM/Ff64AiyyrUVmESTvDwF9sx4B1WdnWa6wqWUX4HxMCl+nMY5x
         b3p9loP2yX3a2F9BhQSTMdwmqgNcFxj1VRV7+QcVwartuRnsuM0IYqj4yP2UzcdfcZL4
         yUAQ==
X-Gm-Message-State: ABy/qLalCt1suhewWt/ykC7Jp8TxPq9FGO0JsA1Rv98moJrJF64Y71vD
	83luD0eXChsPTyPRwlqe5vf0vQ==
X-Google-Smtp-Source: APBJJlEf/l5iXtW9hUonbvLBpNRFVYCeb6kxyBQ2YKwEADRmvKg5uR+6zMAiiWhpmjOswALp7BGS5w==
X-Received: by 2002:a05:620a:4082:b0:767:1d7e:ec3d with SMTP id f2-20020a05620a408200b007671d7eec3dmr5043744qko.2.1690566194647;
        Fri, 28 Jul 2023 10:43:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id f7-20020a05620a15a700b007682634ac20sm1274983qkk.115.2023.07.28.10.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 10:43:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qPRUe-001fhT-S8;
	Fri, 28 Jul 2023 14:43:12 -0300
Date: Fri, 28 Jul 2023 14:43:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Wei Hu <weh@microsoft.com>
Cc: netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org, longli@microsoft.com,
	sharmaajay@microsoft.com, leon@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vkuznets@redhat.com, ssengar@linux.microsoft.com,
	shradhagupta@linux.microsoft.com
Subject: Re: [PATCH v4 1/1] RDMA/mana_ib: Add EQ interrupt support to mana ib
 driver.
Message-ID: <ZMP+MH7f/Vk9/J0b@ziepe.ca>
References: <20230728170749.1888588-1-weh@microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728170749.1888588-1-weh@microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 05:07:49PM +0000, Wei Hu wrote:
> Add EQ interrupt support for mana ib driver. Allocate EQs per ucontext
> to receive interrupt. Attach EQ when CQ is created. Call CQ interrupt
> handler when completion interrupt happens. EQs are destroyed when
> ucontext is deallocated.

It seems strange that interrupts would be somehow linked to a
ucontext? interrupts are highly limited, you can DOS the entire system
if someone abuses this.

Generally I expect a properly functioning driver to use one interrupt
per CPU core.

You should tie the CQ to a shared EQ belong to the core that the CQ
wants to have affinity to.

Jason

