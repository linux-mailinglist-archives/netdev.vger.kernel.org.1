Return-Path: <netdev+bounces-259048-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDLQFU12lGlmEAIAu9opvQ
	(envelope-from <netdev+bounces-259048-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:08:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A46C14D017
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8757930028CB
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D846361DAE;
	Tue, 17 Feb 2026 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="SLG9dpM7"
X-Original-To: netdev@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B322036C0B7
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771337281; cv=none; b=YVsaqgda6OJNdQK1TqgmOxcDfxSEK6eRYrFieXK+MbfRQQeE4Ne2NVknQxFJsrfX/bX8QxOsW8quQVd9O4RzW6RNAw3Zs4QsjlQ8gYYaSGbDYLANcdw+iRuLPBvLBNlDMN9VxKwPAJjjhe1WCsYsaXGghE7WI0T0FLnp7NFPCew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771337281; c=relaxed/simple;
	bh=0NyJYsksmxUgMNXz4K6ZP9ZbJ6FoZ+im2I1GHNA4b5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tG4r9ih/PFG3TcPhrOd2yJAbFrdpEkFZ0mhyiu59BH/MivxAXoRVesX38zXbPQtw8T01YCiuShatCB/0RduGjGgpfadH7kRhDuxHLu0WSls5yB5hGJae3Uhs0gxOzGG+nsfs/x6l/fruNpz2WPIcj6kxHMcrP68aNetezzC0qxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=SLG9dpM7; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id D011C240103
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 15:07:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1771337276; bh=sKkWkOyFI8xNo6uOC2GXNy2uDG/uIzVcULqnGEdSUrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=SLG9dpM7R/EukPvsptQCgwA5Q7435NpmHzSTb5H+8qodPUOhuN42f9P5OmR6wSgY7
	 kaM1clwhP121Hr8i3T9s7IzWRcdPTR+oQA0NHQKA0garTDE4sxCcigDW8byTsnSIDc
	 7kkO4P0NW6lblKNVs/hT3hA5RFXr4Y+Eq8uwFHotFVv8FA2uRLHsnmXhMI+ZZDHzL7
	 rh4wtIRR9Fwpe1wsm2EP8AkPSS4wQuDDv668fMrW3JH2k2WbajvXssN1NVnZHvrOKe
	 aqeqOWlkjMTu3lbyvG5eRPblIItOCkfYS73wCpn3WgHSDkni6RDft0XMJsOlMzEm0w
	 rWTF9H+61fMbg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fFhLL594fz6v15;
	Tue, 17 Feb 2026 15:07:54 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Tabrez Ahmed <tabreztalks@gmail.com>
Cc: allison.henderson@oracle.com,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  horms@kernel.org,  gerd.rausch@oracle.com,  linux-rdma@vger.kernel.org,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  syzbot+aae646f09192f72a68dc@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] rds: tcp: fix uninit-value in __inet_bind
In-Reply-To: <20260217135350.33641-1-tabreztalks@gmail.com>
References: <20260217135350.33641-1-tabreztalks@gmail.com>
Date: Tue, 17 Feb 2026 14:07:56 +0000
Message-ID: <87y0krea4m.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[posteo.net,none];
	R_DKIM_ALLOW(-0.20)[posteo.net:s=2017];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-259048-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[posteo.net:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charmitro@posteo.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,aae646f09192f72a68dc];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email,posteo.net:mid,posteo.net:dkim,posteo.net:email]
X-Rspamd-Queue-Id: 6A46C14D017
X-Rspamd-Action: no action

Tabrez Ahmed <tabreztalks@gmail.com> writes:

> KMSAN reported an uninit-value access in __inet_bind() when binding
> an RDS TCP socket.
>
> The uninitialized memory originates from rds_tcp_conn_alloc(),
> which uses kmem_cache_alloc() to allocate the rds_tcp_connection structure.
>
> Specifically, the field 't_client_port_group' is incremented in
> rds_tcp_conn_path_connect() without being initialized first:
>
>     if (++tc->t_client_port_group >= port_groups)
>
> Since kmem_cache_alloc() does not zero the memory, this field contains
> garbage, leading to the KMSAN report.
>
> Fix this by using kmem_cache_zalloc() to ensure the structure is
> zero-initialized upon allocation.
>
> Reported-by: syzbot+aae646f09192f72a68dc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=aae646f09192f72a68dc
> Tested-by: syzbot+aae646f09192f72a68dc@syzkaller.appspotmail.com
> Fixes: a20a6992558f ("net/rds: Encode cp_index in TCP source port")
>
> Signed-off-by: Tabrez Ahmed <tabreztalks@gmail.com>
> ---

Reviewed-by: Charalampos Mitrodimas <charmitro@posteo.net>

-- 
C. Mitrodimas

