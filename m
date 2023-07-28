Return-Path: <netdev+bounces-22411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7B7767599
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 20:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4FF32821B4
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 18:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDB21401A;
	Fri, 28 Jul 2023 18:39:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D150BDDB0
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 18:39:28 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2054489
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 11:39:26 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686f38692b3so2047585b3a.2
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 11:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690569566; x=1691174366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2flqKPY9mF456lzl7KZSlOozTCBExKcvkCqkGx9wsSE=;
        b=hoBR/RW0WEdqNVVswTS/7PMr8na4eRwQGTuRVV/2gXcg/fpOfuif3lVi2AHeWpL5MZ
         8FVYAenG0BPDSoD+acBSjJt67i+GHDSMk1LralzU7yF9zxqOG5m9ZVj/BVXBT8a1vpXd
         E0Svba5qKjjmGVOgp/MrMG2FKBAjAt3KDr1kaRCea2YmLjo6tTa/nLIVuTOLYCEsFm4J
         sEojsEc+nXPLnyWSXpGQSoJ5Mm6ULvYM/xvh0cJ8/tdLQvjIIis9nrimhXOF6pe/MzaO
         yT4gAW/lyG+/BlmjmGBkeHK3KO9CDCVwYo9jlBDHw/9aL3tBp1CcPiVRqnpeYvb1r1C9
         dOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690569566; x=1691174366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2flqKPY9mF456lzl7KZSlOozTCBExKcvkCqkGx9wsSE=;
        b=VTrXCJeWQ1S23ZPoFJWzIKfk57aWSclPVwozuLhZIiF5sT+H2faDGiG+pcC3k8YqLI
         OjZTs3kOJKrsY19cbJXrQMa2bdEVf9IWhX7z4NXzM5XGo4TjJmuqWkq/+Zh6zEvc+Gt+
         orCOBZppENSnqEso3k6wTgXZ8U3X/VtcRh6pjfE64Lyz4cm7ezsZd15Fq2ivn0ETcQM6
         iwV4QBJeSpHUCKUwFST1cAoKuBoxYOLZ1zXfgUV7MDwj+Dp931Bk6I3qSR5vtjysIOzs
         vS9Yqvg/KR9SALLR8hVnPLxiD2DB6mO9eyvocCaglYvzWBbd2AfQBAZeMK3ng0mG0v4Q
         Gs3g==
X-Gm-Message-State: ABy/qLbNK4ujyJq0YveOveCpbTaEQa9ogdAhVlEJ5XW/LehNRpb/2dTj
	cgucHphIaKIPF6yd+uFcI3Ss4boXt96f6RS63h0=
X-Google-Smtp-Source: APBJJlHg+nmPr0U2c+eIQr9bUSWzAzZD8+AsIqvrxWDqn+SqeHSWiNYJxTwFAdcBUodvt5dsdhGY2A==
X-Received: by 2002:a05:6a20:96c9:b0:135:110c:c6de with SMTP id hq9-20020a056a2096c900b00135110cc6demr2662864pzc.6.1690569566294;
        Fri, 28 Jul 2023 11:39:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id z136-20020a63338e000000b0056001f43726sm3807409pgz.92.2023.07.28.11.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 11:39:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qPSN1-001o9T-Vo;
	Fri, 28 Jul 2023 15:39:23 -0300
Date: Fri, 28 Jul 2023 15:39:23 -0300
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
Message-ID: <ZMQLW4elDj0vV1ld@ziepe.ca>
References: <20230728170749.1888588-1-weh@microsoft.com>
 <ZMP+MH7f/Vk9/J0b@ziepe.ca>
 <PH7PR21MB3263C134979B17F1C53D3E8DCE06A@PH7PR21MB3263.namprd21.prod.outlook.com>
 <ZMQCuQU+b/Ai9HcU@ziepe.ca>
 <PH7PR21MB326396D1782613FE406F616ACE06A@PH7PR21MB3263.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB326396D1782613FE406F616ACE06A@PH7PR21MB3263.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 06:22:53PM +0000, Long Li wrote:
> > Subject: Re: [PATCH v4 1/1] RDMA/mana_ib: Add EQ interrupt support to mana ib
> > driver.
> > 
> > On Fri, Jul 28, 2023 at 05:51:46PM +0000, Long Li wrote:
> > > > Subject: Re: [PATCH v4 1/1] RDMA/mana_ib: Add EQ interrupt support
> > > > to mana ib driver.
> > > >
> > > > On Fri, Jul 28, 2023 at 05:07:49PM +0000, Wei Hu wrote:
> > > > > Add EQ interrupt support for mana ib driver. Allocate EQs per
> > > > > ucontext to receive interrupt. Attach EQ when CQ is created. Call
> > > > > CQ interrupt handler when completion interrupt happens. EQs are
> > > > > destroyed when ucontext is deallocated.
> > > >
> > > > It seems strange that interrupts would be somehow linked to a ucontext?
> > > > interrupts are highly limited, you can DOS the entire system if
> > > > someone abuses this.
> > > >
> > > > Generally I expect a properly functioning driver to use one interrupt per CPU
> > core.
> > >
> > > Yes, MANA uses one interrupt per CPU. One interrupt is shared among
> > > multiple EQs.
> > 
> > So you have another multiplexing layer between the interrupt and the EQ? That is
> > alot of multiplexing layers..
> > 
> > > > You should tie the CQ to a shared EQ belong to the core that the CQ
> > > > wants to have affinity to.
> > >
> > > The reason for using a separate EQ for a ucontext, is for preventing
> > > DOS. If we use a shared EQ, a single ucontext can storm this shared EQ
> > > affecting other users.
> > 
> > With a proper design it should not be possible. The CQ adds an entry to the EQ
> > and that should be rate limited by the ability of userspace to schedule to re-arm
> > the CQ.
> 
> I think DPDK user space can sometimes storm the EQ by arming the CQ
> from user-mode.

Maybe maliciously you can do a blind re-arm, but nothing sane should
do that.

> With a malicious DPDK user, this code can be abused to arm the CQ at
> extremely high rate.

Again, the rate of CQ re-arm is limited by the ability of userspace to
schedule, I'm reluctant to consider that a DOS vector. Doesn't your HW
have EQ overflow recovery?

Frankly, stacking more layers of IRQ multiplexing doesn't seem like it
should solve any problems, you are just shifting where the DOS can
occure. Allowing userspace to create EQs is its own DOS direction,
either you exhaust and DOS the number of EQs or you DOS the
multiplexing layer between the interrupt and the EQ.

Jason

