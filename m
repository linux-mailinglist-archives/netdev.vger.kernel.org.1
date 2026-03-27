Return-Path: <netdev+bounces-272409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AD2RNmMxxmnzHQUAu9opvQ
	(envelope-from <netdev+bounces-272409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:27:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A848340613
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76D4E30137A6
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAED3C8701;
	Fri, 27 Mar 2026 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KEDz3red"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48CA146D5A
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596303; cv=none; b=AdrRrTgVMcVTy/QD0GsXLkUp7khU/s9rmBe7pyct7x4cx/wX+MYlzM0EMRaVUpvVzmMJzXoENgRSZJFpXdO1y9/zj2e1N7+dgzFbLXLk31Bv/hlzeD+GKI55LKk+F/gHIwdhvBKuATfG3JqAg/4liCe325QKPQMFzqV9BU3UGWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596303; c=relaxed/simple;
	bh=/c/rEAtjoA4U5rsMmbIsoF9wNzTdLXDFB7/5P7jUcxY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=bvsmuz4d4Eu1Hzi7OBhsO65z5haOIG72xPFsahgQWnGvX0MOBtJhexeTKz6HSZpDEyofMoCnOy8ebQ2XaQ9QmTqgy4jbpTrZ+sBFOxQ2b3eMmJJPlt1qVvH4qD2pInASdvblRStS4fw5NX+HlzxFOqGOh5L9B18Xslpo0Q/ZTo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KEDz3red; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774596292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iARXEuBHEV9efpZyZLEAupusw8ARegIJ0ZGZqhBhaD8=;
	b=KEDz3redi6EvkGAbANzOggDpSjE6hjc3vJJFsYxputScv+I8NddaVx+E6fZCtHPCYP4w+W
	YWHnHWUY9jl2zhLcdNRd3z0DbsrM1qZW9E90rIUU/notS08DKWGr874QuCgd70sLG/52JH
	04jiyFZOme4VN76hnIXsvyJWsCeujWo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-xtlZW6gXPQihAPG65_m18g-1; Fri,
 27 Mar 2026 03:24:49 -0400
X-MC-Unique: xtlZW6gXPQihAPG65_m18g-1
X-Mimecast-MFC-AGG-ID: xtlZW6gXPQihAPG65_m18g_1774596287
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 386DE19560B6;
	Fri, 27 Mar 2026 07:24:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.121])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 633B23000223;
	Fri, 27 Mar 2026 07:24:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAPhRvkw8eopbCei6XQY3Fi-nDk+FyuXUWs8ToQyHE9J229_v0Q@mail.gmail.com>
References: <CAPhRvkw8eopbCei6XQY3Fi-nDk+FyuXUWs8ToQyHE9J229_v0Q@mail.gmail.com> <20260326131838.634095-1-dhowells@redhat.com> <20260326131838.634095-10-dhowells@redhat.com>
To: Anderson Nascimento <anderson@allelesecurity.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
    Jeffrey Altman <jaltman@auristor.com>,
    Simon Horman <horms@kernel.org>, stable@kernel.org
Subject: Re: [PATCH net v3 09/11] rxrpc: Fix keyring reference count leak in rxrpc_setsockopt()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <754860.1774596280.1@warthog.procyon.org.uk>
Date: Fri, 27 Mar 2026 07:24:40 +0000
Message-ID: <754861.1774596280@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272409-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,allelesecurity.com:email]
X-Rspamd-Queue-Id: 5A848340613
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Anderson Nascimento <anderson@allelesecurity.com> wrote:

> To make the logic more coherent, what if we check if (rx->key ||
> rx->securities) in both options and remove the rx->securities check from
> rxrpc_request_key()?

You're allowed to have both a keyring (server) and a key (client).  You can
issue client calls on a server socket.  The in-kernel kafs filesystem does
this, for example - though it normally sets the outgoing key on individual
calls.

To parallel the kernel example, it might be worth my while adding a CMSG tag
to take a key ID or key description so the rxrpc_sendmsg() can do a
request_key() when setting up a call (the AF_RXRPC socket allows a different
key with each call dispatched), though the AFS command line tools tend only to
talk to a single cell at a time (you only need one key for comms with an
entire cell).

Davod


