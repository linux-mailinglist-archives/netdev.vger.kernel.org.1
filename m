Return-Path: <netdev+bounces-16997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA2B74FC4F
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 02:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5D41C20E49
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 00:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5FA365;
	Wed, 12 Jul 2023 00:46:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABCF362
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 00:46:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E86A10CF
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 17:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689122798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vuMz9r50CK+igrSG6zWU18FkXs8hvCJFWii7yehFB7U=;
	b=MjxJ4ePSZgt4vRcXsQ9MZ3sWpbj0yJD0avb2tobjNJ4ICg/s6EhA6jH/z1ocBNrfAt5Q3E
	YiKRo2+SoCYBktfCW7KxZLPm59gRZ9nAgj2dKy1YjZxH06616u30DfEoSMtytrPYLnicgK
	oKCjlqwZhpf74B/mT+laqnLh/z5LQAo=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-UqLtC1v8M-aI35IVovLruQ-1; Tue, 11 Jul 2023 20:46:35 -0400
X-MC-Unique: UqLtC1v8M-aI35IVovLruQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC44A1C47671;
	Wed, 12 Jul 2023 00:46:33 +0000 (UTC)
Received: from localhost (ovpn-12-61.pek2.redhat.com [10.72.12.61])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4830BC09A09;
	Wed, 12 Jul 2023 00:46:17 +0000 (UTC)
Date: Wed, 12 Jul 2023 08:46:13 +0800
From: Baoquan He <bhe@redhat.com>
To: Simon Horman <simon.horman@corigine.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	linux-mm@kvack.org, schnelle@linux.ibm.com, vkoul@kernel.org,
	eli.billauer@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
	derek.kiernan@amd.com, dragan.cvetic@amd.com,
	linux@dominikbrodowski.net, Jonathan.Cameron@huawei.com,
	linus.walleij@linaro.org, tsbogend@alpha.franken.de,
	joyce.ooi@intel.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, tglx@linutronix.de,
	maz@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	robh+dt@kernel.org, frowand.list@gmail.com,
	kernel test robot <lkp@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 5/8] net: altera-tse: make ALTERA_TSE depend on HAS_IOMEM
Message-ID: <ZK331Ru27wiRApF2@MiWiFi-R3L-srv>
References: <20230707135852.24292-1-bhe@redhat.com>
 <20230707135852.24292-6-bhe@redhat.com>
 <ZK2Ok5i2m7zS6Uq0@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK2Ok5i2m7zS6Uq0@corigine.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/11/23 at 06:17pm, Simon Horman wrote:
> On Fri, Jul 07, 2023 at 09:58:49PM +0800, Baoquan He wrote:
> > On s390 systems (aka mainframes), it has classic channel devices for
> > networking and permanent storage that are currently even more common
> > than PCI devices. Hence it could have a fully functional s390 kernel
> > with CONFIG_PCI=n, then the relevant iomem mapping functions
> > [including ioremap(), devm_ioremap(), etc.] are not available.
> > 
> > Here let ALTERA_TSE depend on HAS_IOMEM so that it won't be built
> > to cause below compiling error if PCI is unset:
> > 
> > ------
> > ERROR: modpost: "devm_ioremap" [drivers/net/ethernet/altera/altera_tse.ko] undefined!
> > ------
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202306211329.ticOJCSv-lkp@intel.com/
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> 
> 
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Tested-by: Simon Horman <simon.horman@corigine.com> # build-tested

Thanks, Simon.

> 
> I wonder if this should also have:
> 
>   Fixes: ed33ef648964 ("Altera TSE: Add Altera Ethernet Driver Makefile and Kconfig")

Agree, it's worth having Fixes tag.


