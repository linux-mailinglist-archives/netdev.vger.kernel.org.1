Return-Path: <netdev+bounces-17977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E321B753EB9
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 17:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6071C20FFA
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 15:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8603C14282;
	Fri, 14 Jul 2023 15:24:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7560C14264
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 15:24:50 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28854270B
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 08:24:48 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a04e5baffcso1633022b6e.3
        for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 08:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689348287; x=1691940287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KKCPDDjyadziwl2/AK/7bwW5AQLCnpdzpQfQJ+yWANU=;
        b=VkfHth5MNAZHQQpEhdDGh0pq0hoDNb/IkCyvJyfZlohZ7FEqc/tc2UlGQlp5P+ls2k
         LP4Az77bQs/0UVX1KSsNiwTlKtw8ZJErPfpgp4NpbjjW9RxzvWKdoj5q9JZGtbqYKyMw
         IkbeE1z0uT48kd4G5uv3BxnFhNNELaU6M+7XHRszPJ3LTmAtfce0FwO0kiq6qtWbZVLj
         +GaUqzfPkfSAQcQuVfYKAUHYwjH4iU0nqNSXmWkPMWsXsceycWdUU7PI1Bdr+PTPu7X6
         X/OpA3sg1LJmtBpK2xUftGMYHz3Z91vTuIVh4aBU1pURrsic+RJAvN3CFStnNYgOJO/U
         rXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689348287; x=1691940287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKCPDDjyadziwl2/AK/7bwW5AQLCnpdzpQfQJ+yWANU=;
        b=ZmlBGlTCZIhGRUetjw2bRRSzZg9ZB2J1ArMyeKUm1gggjOFgXulxRrilGEe8NLz6q7
         UyMh4kSbfNIWw3v/5qNIrLwV9Qbpr8TjUKSP9KeArElkDEaCWazbux+9ao+s/fcT+io+
         ujdklZv5Nqt7C4LN7IKNw52MD1pkvaQFVo+lJYkNXJUcSasmZI551pbWeRgNgFxx85Ah
         hNA+SEsYIcZTSaT0jNDtlTaouLXOP44cuOfntHPyLUZ8J5zsPFCBRCVVYvTv6yEIWtiE
         +C2xse7W4qDSHYSneNOLlJxpXYzaNsaYYmGG7e8dG/3CTEbZ29AmmWPFWom8hJHTf3I9
         Yiew==
X-Gm-Message-State: ABy/qLbi2OHWFOCbwc+ItFaaYYjsXae3x0NLt4aN/ps1CPGNlLHgZBxN
	KE/Kqx5mSW9qpuUsUlQtl4B/SA==
X-Google-Smtp-Source: APBJJlH+MwWcaUVg/7akbj8keBMvf8gq7EKuq9vDRBoNFYJ4+ezTmB048XjMLkW7GX8JAT8v1K03Sg==
X-Received: by 2002:a05:6808:2226:b0:3a3:eceb:7bbc with SMTP id bd38-20020a056808222600b003a3eceb7bbcmr7147567oib.54.1689348287397;
        Fri, 14 Jul 2023 08:24:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id x19-20020a17090aa39300b00263154aab24sm1230248pjp.57.2023.07.14.08.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 08:24:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qKKez-0017NL-5i;
	Fri, 14 Jul 2023 12:24:45 -0300
Date: Fri, 14 Jul 2023 12:24:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian Brauner <brauner@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
	linux-usb@vger.kernel.org, Matthew Rosato <mjrosato@linux.ibm.com>,
	Paul Durrant <paul@xen.org>, Tom Rix <trix@redhat.com>,
	Jason Wang <jasowang@redhat.com>, dri-devel@lists.freedesktop.org,
	Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
	Kirti Wankhede <kwankhede@nvidia.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Diana Craciun <diana.craciun@oss.nxp.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Shakeel Butt <shakeelb@google.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Leon Romanovsky <leon@kernel.org>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Fei Li <fei1.li@intel.com>, x86@kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Halil Pasic <pasic@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	intel-gfx@lists.freedesktop.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	linux-fpga@vger.kernel.org, Zhi Wang <zhi.a.wang@intel.com>,
	Wu Hao <hao.wu@intel.com>, Jason Herne <jjherne@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Johannes Weiner <hannes@cmpxchg.org>, linuxppc-dev@lists.ozlabs.org,
	Eric Auger <eric.auger@redhat.com>, Borislav Petkov <bp@alien8.de>,
	kvm@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	virtualization@lists.linux-foundation.org,
	intel-gvt-dev@lists.freedesktop.org, io-uring@vger.kernel.org,
	netdev@vger.kernel.org, Tony Krowiak <akrowiak@linux.ibm.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Sean Christopherson <seanjc@google.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	Benjamin LaHaise <bcrl@kvack.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Frederic Barrat <fbarrat@linux.ibm.com>,
	Moritz Fischer <mdf@kernel.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Xu Yilun <yilun.xu@intel.com>, jaz@semihalf.com
Subject: Re: [PATCH 0/2] eventfd: simplify signal helpers
Message-ID: <ZLFovYocElAD7gJ0@ziepe.ca>
References: <20230630155936.3015595-1-jaz@semihalf.com>
 <20230714-gauner-unsolidarisch-fc51f96c61e8@brauner>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714-gauner-unsolidarisch-fc51f96c61e8@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 14, 2023 at 09:05:21AM +0200, Christian Brauner wrote:

> I have no skin in the game aside from having to drop this conversion
> which I'm fine to do if there are actually users for this btu really,
> that looks a lot like abusing an api that really wasn't designed for
> this.

Yeah, I think so too. The ACPI thing should use its own FD if it wants
to feed actual data..

Jason


