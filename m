Return-Path: <netdev+bounces-21320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B81763428
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 12:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00C731C211D9
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 10:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58C6CA5A;
	Wed, 26 Jul 2023 10:46:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA786CA47
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 10:46:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068C3212B
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 03:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690368405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lvJT1Nrqg3NuKZyozBDgNxTT7my/YGr0ImgVXCIWT+Q=;
	b=iJtzYJg3lp0T3TNi2HW/4OqACPw5/weINRzYed1b4ngAKyDewJdKIx8f13Ghtu+px4HhRN
	9vIjXqMkW/LTmo1pzENDjQv8ro3EZi1PkYkK3afVVZqzYqTLcxl3bruyHjx9onqaoshRkJ
	cyq4SshZB3ssbQ+N0idHjpGoQ3REdmk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-FPRlPA5MOl2fS2zC8T9MoQ-1; Wed, 26 Jul 2023 06:46:40 -0400
X-MC-Unique: FPRlPA5MOl2fS2zC8T9MoQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 503CE892240;
	Wed, 26 Jul 2023 10:46:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.158])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3FA5240C2063;
	Wed, 26 Jul 2023 10:46:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <0000000000000ced8905fecceeba@google.com>
References: <0000000000000ced8905fecceeba@google.com>
To: syzbot <syzbot+0bc501b7bf9e1bc09958@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, davem@davemloft.net,
    herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
    linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
    pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [crypto?] general protection fault in shash_async_update
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20271.1690368398.1@warthog.procyon.org.uk>
Date: Wed, 26 Jul 2023 11:46:38 +0100
Message-ID: <20272.1690368398@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

#syz fix: crypto: af_alg/hash: Fix recvmsg() after sendmsg(MSG_MORE)


