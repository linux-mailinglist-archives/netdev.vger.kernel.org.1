Return-Path: <netdev+bounces-21366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801C5763630
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2B42812F7
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 12:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82202C13F;
	Wed, 26 Jul 2023 12:22:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A78CA41
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:22:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1498619B5
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 05:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690373676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9y3yg5KgefYDIN9bSf2g3F3ifzh5J50cmp3vp0NbN6I=;
	b=f/jjpYefZC+203m0VN4ob/f61A/RxPDtB50OivL+haGUY0LoSrzCYsb+tpfBXWIdJUCvHa
	WEalWN+oTTlo1PCgetfudxPgQQ2CIdwJVfd8wgA/cgQmwPJA4r1DVAatC2k1PLZ5I6DLWi
	iYvKM5mK3y5nr9WS7xYi96xHmUszYi4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-246-VAR8qLzmMzq89RhDCSTq8g-1; Wed, 26 Jul 2023 08:14:32 -0400
X-MC-Unique: VAR8qLzmMzq89RhDCSTq8g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 520162815E2A;
	Wed, 26 Jul 2023 12:14:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AE5D0492CA6;
	Wed, 26 Jul 2023 12:14:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <168979148257.1905271.8311839188162164611.stgit@morisot.1015granger.net>
References: <168979148257.1905271.8311839188162164611.stgit@morisot.1015granger.net> <168979108540.1905271.9720708849149797793.stgit@morisot.1015granger.net>
To: Chuck Lever <cel@kernel.org>
Cc: dhowells@redhat.com, linux-nfs@vger.kernel.org,
    netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 4/5] SUNRPC: Revert e0a912e8ddba
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6617.1690373671.1@warthog.procyon.org.uk>
Date: Wed, 26 Jul 2023 13:14:31 +0100
Message-ID: <6618.1690373671@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Chuck Lever <cel@kernel.org> wrote:

> Flamegraph analysis showed that the cork/uncork calls consume
> nearly a third of the CPU time spent in svc_tcp_sendto(). The
> other two consumers are mutex lock/unlock and svc_tcp_sendmsg().
> 
> Now that svc_tcp_sendto() coalesces RPC messages properly, there
> is no need to introduce artificial delays to prevent sending
> partial messages.
> 
> After applying this change, I measured a 1.2K read IOPS increase
> for 8KB random I/O (several percent) on 56Gb IP over IB.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: David Howells <dhowells@redhat.com>


