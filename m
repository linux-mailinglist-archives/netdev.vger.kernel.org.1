Return-Path: <netdev+bounces-23468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A8776C135
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 01:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F1E1C21123
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 23:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB9712B8C;
	Tue,  1 Aug 2023 23:46:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB356D18
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 23:46:06 +0000 (UTC)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E055E48
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 16:46:05 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-76c7eb57c0bso327340085a.2
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 16:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690933565; x=1691538365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KBKGP+rOQrE0yI33WFL70QQXfWqUPCJII6/ruXV7a18=;
        b=SWXVXrgm7uYZHZpxzUnYKGRlHWgX0IK0Rnlpt7cDr5IAkGjYP2UkjUfjYQGOZNR6qJ
         LJgCwO55lyoYtyX6E3Q4s40xhlJi1dKPH0AZpIy8isp0s8rC0ju8u3sjUbibjy6jNmr+
         mcJOcMWuV5sswR+4lXv+R2JNNPJMLL1UAxV+nc9eXFABT8+j+4Fr4O92HGXMdw8ZW/cO
         tYSdLgE9sYsL2LpWr9Lpjtw96tubbaY6Lk9BRgEa7XCIyKeCZkvIgI1OH2+pWauTOwMU
         tjTG/lngwIPwA8M8k3ptItHteXjaC4SjLv7Eqa1WLuIH7QiFLFw+WP+vp7HZAj1aZd8b
         Tmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690933565; x=1691538365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBKGP+rOQrE0yI33WFL70QQXfWqUPCJII6/ruXV7a18=;
        b=Ye8WoaMprpj3O8qzgSnzWniW9/5+W5L5btCRFImf+N6LLrOfu5oi5YerytuuZ/i8UK
         m9aTtMIRuFMtDS4h4DGKxQVHvh7XOA0slxySN+4BkxgSdVw4Isv0l8wkS4Yz5MSKo2O8
         Zu4XnIyJB043qyPnmon3yN0QM0jFvl47FY1gVngnw5HzWuDPQ/0sBoikhpleF0Am41Fv
         OfvM0zD2J4aETz++4ph4/Lx9ZRsYZT+usWDOsUwqTLciIfwWVE5mqSqqif0cwlOtAGgV
         KNei6EVzO1kezqJShG8Evl4ZEY9MMcLERdKzHYIUiGv7CB6YbomkIHsTGnoFrNVgqU/B
         pHuA==
X-Gm-Message-State: ABy/qLZoxRblq/10IuQJOMknLxKThpHValXkR9SmTha/H/hX+DF/3Jlt
	0RE6l1WUMYLBZspERU6gF3vd7Q==
X-Google-Smtp-Source: APBJJlGxnpoNiNKnO6qXw0UeYYlZ6fEaFr61aQgxxSleH8rfkxM6Fg0dXraa5FyNSubaYwh/wMlyfw==
X-Received: by 2002:a05:620a:4010:b0:76c:bf54:70ab with SMTP id h16-20020a05620a401000b0076cbf5470abmr5499429qko.12.1690933564773;
        Tue, 01 Aug 2023 16:46:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id q10-20020ae9e40a000000b007676f3859fasm4543814qkc.30.2023.08.01.16.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 16:46:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qQz3z-002y3w-GJ;
	Tue, 01 Aug 2023 20:46:03 -0300
Date: Tue, 1 Aug 2023 20:46:03 -0300
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
	vkuznets <vkuznets@redhat.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>
Subject: Re: [PATCH v4 1/1] RDMA/mana_ib: Add EQ interrupt support to mana ib
 driver.
Message-ID: <ZMmZO9IPmXNEB49t@ziepe.ca>
References: <20230728170749.1888588-1-weh@microsoft.com>
 <ZMP+MH7f/Vk9/J0b@ziepe.ca>
 <PH7PR21MB3263C134979B17F1C53D3E8DCE06A@PH7PR21MB3263.namprd21.prod.outlook.com>
 <ZMQCuQU+b/Ai9HcU@ziepe.ca>
 <PH7PR21MB326396D1782613FE406F616ACE06A@PH7PR21MB3263.namprd21.prod.outlook.com>
 <ZMQLW4elDj0vV1ld@ziepe.ca>
 <PH7PR21MB326367A455B78A1F230C5C34CE0AA@PH7PR21MB3263.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB326367A455B78A1F230C5C34CE0AA@PH7PR21MB3263.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 01, 2023 at 07:06:57PM +0000, Long Li wrote:

> The driver interrupt code limits the CPU processing time of each EQ
> by reading a small batch of EQEs in this interrupt. It guarantees
> all the EQs are checked on this CPU, and limits the interrupt
> processing time for any given EQ. In this way, a bad EQ (which is
> stormed by a bad user doing unreasonable re-arming on the CQ) can't
> storm other EQs on this CPU.

Of course it can, the bad use just creates a million EQs and pushes a
bit of work through them constantly. How is that really any different
from pushing more EQEs into a single EQ?

And how does your EQ multiplexing work anyhow? Do you poll every EQ on
every interrupt? That itself is a DOS vector.

Jason

