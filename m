Return-Path: <netdev+bounces-22403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE8D767426
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 20:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E8691C213A9
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 18:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB3C1775A;
	Fri, 28 Jul 2023 18:02:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923A515493
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 18:02:41 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5926C3588
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 11:02:39 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6b9b835d302so1682736a34.1
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 11:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690567358; x=1691172158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eEzxvMzQhe+aFw/a+Xbe6lGzH8JrChN+Z8lQ7mk28aE=;
        b=ScA6cwcWmNwMdsimpAwO6rLZQSvnT/clp4CKPqnsz4wOFo6JlJEkobkY2/u1nvPoIv
         kSkgTSZJiMcPKrk7dOV/fbEWZ3et5y/L0qklgUAf9vfa5Y50UqjZ3yVdOqNDWliQCV4R
         kIqmafyIqJUeXjixtnK8RQLUgRS0U81rJMQFqBTUSuLOchrMz0Q6zWxePBC9cwSwqCUc
         ZeyGRAJTKpHeDafbPHXjwLR4HQSLOYM5bHmrDuuT1ON4j87XRUwKoaRFbyPwZBA7+rp2
         DbwM3rTTrkr3QpAT1ABIXtv4zEzmmEYNltU5bMLEa8EWCRaykXaErQRELlwZ/gDUxel7
         izXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690567358; x=1691172158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEzxvMzQhe+aFw/a+Xbe6lGzH8JrChN+Z8lQ7mk28aE=;
        b=WY22+fM6s+JTpLE+iUkv+S/K5UTz4SkKHJMgD3KyXmBJwt89QaTiakxO6pQEEuMMpE
         6fcaUgix+KD50luTD4vKNU4natE66zzTk2JcoowLPLgpyS9fNgqYuOhFibw3OgZF0/r+
         oRM/Kviaq1zK7ZhMozXsqAPKvyfwx7U0Qy4xKYMmspyObLeC1HLgaoCYBYD7mOr0fmYK
         AXu9Dv/4FehisA/kbL2+r9ukwHUguZFZu5Poq/ezzoVf48CYKJOciVNFaCoJmSeKUXxf
         mVXsxv5lct64QfaFiXcc8tqymdhi6T6qsSzXz/DmHR4gQEU7048cjOEuTDQ/1YzfTHZh
         ssVQ==
X-Gm-Message-State: ABy/qLY2oxmsahwPHsxOQl553gZS1c4c7CzckoCQPihIe5e4Wz4UAOyY
	98Zaj7VNDOzIsSn/5ja3tXWIsg==
X-Google-Smtp-Source: APBJJlEv2VmPAlHU14LlDhvqiR7Wi89nHv8L3mYJR0P8VC9gRtAxmL9tlIyiZRyAhUXMVsry+vWCKQ==
X-Received: by 2002:a9d:67ca:0:b0:6b9:4b45:42ca with SMTP id c10-20020a9d67ca000000b006b94b4542camr3076466otn.25.1690567358536;
        Fri, 28 Jul 2023 11:02:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id h18-20020a0cf212000000b0063007ccaf42sm1414844qvk.57.2023.07.28.11.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 11:02:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qPRnN-001fpu-71;
	Fri, 28 Jul 2023 15:02:33 -0300
Date: Fri, 28 Jul 2023 15:02:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Long Li <longli@microsoft.com>
Cc: Wei Hu <weh@microsoft.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	"leon@kernel.org" <leon@kernel.org>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>
Subject: Re: [PATCH v4 1/1] RDMA/mana_ib: Add EQ interrupt support to mana ib
 driver.
Message-ID: <ZMQCuQU+b/Ai9HcU@ziepe.ca>
References: <20230728170749.1888588-1-weh@microsoft.com>
 <ZMP+MH7f/Vk9/J0b@ziepe.ca>
 <PH7PR21MB3263C134979B17F1C53D3E8DCE06A@PH7PR21MB3263.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB3263C134979B17F1C53D3E8DCE06A@PH7PR21MB3263.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 05:51:46PM +0000, Long Li wrote:
> > Subject: Re: [PATCH v4 1/1] RDMA/mana_ib: Add EQ interrupt support to mana ib
> > driver.
> > 
> > On Fri, Jul 28, 2023 at 05:07:49PM +0000, Wei Hu wrote:
> > > Add EQ interrupt support for mana ib driver. Allocate EQs per ucontext
> > > to receive interrupt. Attach EQ when CQ is created. Call CQ interrupt
> > > handler when completion interrupt happens. EQs are destroyed when
> > > ucontext is deallocated.
> > 
> > It seems strange that interrupts would be somehow linked to a ucontext?
> > interrupts are highly limited, you can DOS the entire system if someone abuses
> > this.
> > 
> > Generally I expect a properly functioning driver to use one interrupt per CPU core.
> 
> Yes, MANA uses one interrupt per CPU. One interrupt is shared among multiple
> EQs.

So you have another multiplexing layer between the interrupt and the
EQ? That is alot of multiplexing layers..

> > You should tie the CQ to a shared EQ belong to the core that the CQ wants to have
> > affinity to.
> 
> The reason for using a separate EQ for a ucontext, is for preventing DOS. If we use
> a shared EQ, a single ucontext can storm this shared EQ affecting
> other users.

With a proper design it should not be possible. The CQ adds an entry
to the EQ and that should be rate limited by the ability of userspace
to schedule to re-arm the CQ.

Jason

