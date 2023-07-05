Return-Path: <netdev+bounces-15667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0374749153
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 01:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62FD1C20C3A
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 23:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A08615AC1;
	Wed,  5 Jul 2023 23:06:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCE0154AC
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 23:06:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF41DE57
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 16:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688598367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwuQxAK6zqLGBR5M40mwPHJnWPOJGuE2YbKWU1Q6hD4=;
	b=i5qEvjT7WtqnVBbHLyQS7j60foUujpXVSmVQCh93wd8LLsD6E7HvxcUwFPB1gpR2VGhQdt
	KUYZ2a5Pqy1DY0z23mix/eyIh8Py35K1coAy5kMMDjgPQL3npBwFm1OcFtnTJ4ycvlyRsS
	bDdeGLxa0h/u94oYWN1qAceb98oHaQs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-393-0pGMGBMBMHiYAe5PpGyDbA-1; Wed, 05 Jul 2023 19:06:04 -0400
X-MC-Unique: 0pGMGBMBMHiYAe5PpGyDbA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09F6B101A528;
	Wed,  5 Jul 2023 23:06:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.195])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 246594087C6A;
	Wed,  5 Jul 2023 23:06:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZKXoBM7EQfbKKVjG@gondor.apana.org.au>
References: <ZKXoBM7EQfbKKVjG@gondor.apana.org.au> <0000000000003f2db705ffc133d2@google.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dhowells@redhat.com,
    syzbot <syzbot+f2c120b449b209d89efa@syzkaller.appspotmail.com>,
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
Content-ID: <1869451.1688598362.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Jul 2023 00:06:02 +0100
Message-ID: <1869452.1688598362@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> CPU: 0 PID: 26699 Comm: syz-executor.2 Not tainted 6.4.0-rc7-syzkaller-0=
1944-g3674fbf0451d #0

Looking at the version string, this is from net-next before the merger wit=
h
Linus's tree after the point where Linus had merged:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/=
?h=3Dfor-6.5/splice

> extract_iter_to_sg(3) unsupported

This is ITER_PIPE (type 3) before is removed by:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?id=3D3fc40265ae2b48a7475c41c5c0b256374c419f4b

=46rom that point on ITER_XARRAY is type 3 and there's a case for that in
extract_iter_to_sg().

So the fix for this is to merge it with the splice tree - which Linus has
already done, so this should be fixed upstream.

With hindsight, I should've used iov_iter_get_pages*() rather than
iov_iter_extract_pages() and extract_iter_to_sg() in the networking code
recvmsg() path until after the merge.

David


