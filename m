Return-Path: <netdev+bounces-21318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A14C763418
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 12:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ADB01C21207
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 10:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB38CA54;
	Wed, 26 Jul 2023 10:43:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412CDCA47
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 10:43:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1111E47
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 03:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690368188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h2bZ6fkGnjjiUXO0kDMBnPkuhQcio8YOy+L/LeFNu98=;
	b=gdcfP9Sp53D/dO1xJ8aI3nVomSPacy7Q1Q3B7wxx6jocQMRzRvloxF6qlBWyHPgLLmZDMd
	xWFktEClqiI+4bIyFDrhWC13pIOU1EFPN+YcT5CXEn1z/6uMrVJnEGpbbSpBfNekGm/Qzf
	D/OhAegGR2ovjEQqNUMB7Xd/O6jZCo0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-KcvHA5d_Ni-_yRXPlaRE9g-1; Wed, 26 Jul 2023 06:43:05 -0400
X-MC-Unique: KcvHA5d_Ni-_yRXPlaRE9g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E937388D7FA;
	Wed, 26 Jul 2023 10:43:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.158])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 856E2C2C85C;
	Wed, 26 Jul 2023 10:43:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <31ddce1d-6014-bf9f-95da-97deb3240606@leemhuis.info>
References: <31ddce1d-6014-bf9f-95da-97deb3240606@leemhuis.info> <CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>,
    Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>,
    Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: Another regression in the af_alg series (s390x-specific)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20078.1690368182.1@warthog.procyon.org.uk>
Date: Wed, 26 Jul 2023 11:43:02 +0100
Message-ID: <20079.1690368182@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

"Linux regression tracking (Thorsten Leemhuis)" wrote:

> What's the status wrt to this regression (caused by c1abe6f570af from
> David)? It looks like there never was a real reply and the regression
> still is unresolved. But maybe I missed something, which can easily
> happen in my position.

I was on holiday when the regression was posted.  This week I've been working
through various things raised during the last couple of weeks whilst fighting
an intermittent apparent bug on my desktop kernel somewhere in ext4, the mm
subsys, md or dm-crypt.

I'll get round to it, but I'll I don't have s390x h/w immediately to hand.

David


