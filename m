Return-Path: <netdev+bounces-248086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 581BFD033A9
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 15:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06167300752A
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 14:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4BB48AE27;
	Thu,  8 Jan 2026 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZHSzKmt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FD3468B88
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879748; cv=none; b=bhA9DnbzhdQLrGDvfTx1n3DN/euW5zqm/FgSAom4Y2jvpCCrEmBVPblU0BnebpUojWGbKO5GXbvj3eg1cNYiaYsGhSX3oWkYGO300OS1PaZHgIamc2ITFWKqVCScvMFd4V2cD0/pDZee2/s/g04i5zdNjlhrJHcL/n/raKGFejM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879748; c=relaxed/simple;
	bh=pe9KmbGm9xuuSWM3/YXKmjg+dSK5yOvOy7pH+xkhYA8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=aY8RBc6gH+Agv6R2OC15OpDqxIpV0gifq2iqwO4mDG77f9+VSprFpUeffzb1pG8hUv6++SVoajz8joRqe8FY+W0Qj8c4NROBW6smr63XfhzEdMWi8s68y+I+go84j12uKd0jDG2PTsrqxi5W/zU5ZZOGdy8Gdg4MFYku3ImUYBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MZHSzKmt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767879746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AGhr52nYvXhfApR02+v107rrmbA3NTYCdw5cmq0BQS0=;
	b=MZHSzKmtBSK7buoqVsJ/tXAvix0ZcSbCALaBfbBFoGc+Yhtg/vdl1cDkmogk+YiMSlXvIQ
	YSWazOG+Q9uc+J48BjLzcj4eyr0ED8Ibd3pt3vsgETQMGeBojRorivsNxLQrPR9M/92KUw
	LD24CWf4JATOJoN+y/P08ycs2YcSHTQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-7flqMiTvOtCsLHxzKswyFA-1; Thu,
 08 Jan 2026 08:42:20 -0500
X-MC-Unique: 7flqMiTvOtCsLHxzKswyFA-1
X-Mimecast-MFC-AGG-ID: 7flqMiTvOtCsLHxzKswyFA_1767879739
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F38219560A2;
	Thu,  8 Jan 2026 13:42:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B8AD630002D2;
	Thu,  8 Jan 2026 13:42:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <695e7cfb.050a0220.1c677c.036b.GAE@google.com>
References: <695e7cfb.050a0220.1c677c.036b.GAE@google.com>
To: syzbot <syzbot+6182afad5045e6703b3d@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, davem@davemloft.net, edumazet@google.com,
    horms@kernel.org, kuba@kernel.org, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org, marc.dionne@auristor.com,
    netdev@vger.kernel.org, pabeni@redhat.com,
    syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [afs?] [net?] KCSAN: data-race in rxrpc_peer_keepalive_worker / rxrpc_send_data_packet
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2744141.1767879733.1@warthog.procyon.org.uk>
Date: Thu, 08 Jan 2026 13:42:13 +0000
Message-ID: <2744142.1767879733@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

I think that this shouldn't be a problem.  The write is:

	conn->peer->last_tx_at = ktime_get_seconds();

and the read is:

	keepalive_at = peer->last_tx_at + RXRPC_KEEPALIVE_TIME;

an approximate time is fine as we're estimating when to send a keepalive
packet if we haven't transmitted a packet in a while.

David


