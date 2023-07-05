Return-Path: <netdev+bounces-15668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F0774915A
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 01:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD34C1C20C6C
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 23:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FA515AC4;
	Wed,  5 Jul 2023 23:10:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54672154AC
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 23:10:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E1F19A1
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 16:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688598627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ke5tgQfioUkSfs2lxW1LmyHZfufsO0C+IRL4oW7y/KI=;
	b=d2fwYxbVdgFQ0i9TIKDmWdw+KrGWDcsRgJPvPOpcIE0ttlctkajqiMAn1pDpORk6TSKr+9
	/xug3SnpKai22e/qfp7AEOvSRtTuDvyA7ZughCZhz8KzFz/DFi7iQ2asZHVz0sqgUkvYsr
	46WUfoVch6WIOCdqtHx9kNHttwfVOpA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-tgZJihUGPjyXphJ8M6gE0Q-1; Wed, 05 Jul 2023 19:10:23 -0400
X-MC-Unique: tgZJihUGPjyXphJ8M6gE0Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 376998022EF;
	Wed,  5 Jul 2023 23:10:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.195])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 59C84492B02;
	Wed,  5 Jul 2023 23:10:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZKXoBM7EQfbKKVjG@gondor.apana.org.au>
References: <ZKXoBM7EQfbKKVjG@gondor.apana.org.au> <0000000000003f2db705ffc133d2@google.com>
To: syzbot <syzbot+f2c120b449b209d89efa@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>,
    davem@davemloft.net, linux-crypto@vger.kernel.org,
    linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
    syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [crypto?] WARNING in extract_iter_to_sg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1869586.1688598621.1@warthog.procyon.org.uk>
Date: Thu, 06 Jul 2023 00:10:21 +0100
Message-ID: <1869587.1688598621@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

#syz fix: iov_iter: Kill ITER_PIPE


