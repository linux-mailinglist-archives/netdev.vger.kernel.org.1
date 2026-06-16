Return-Path: <netdev+bounces-299745-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Bab+Ft7mMGocYgUAu9opvQ
	(envelope-from <netdev+bounces-299745-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 08:02:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 884C768C538
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 08:02:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=kxdjAO6J;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299745-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299745-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 900DC3020856
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 06:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930B23DA5C4;
	Tue, 16 Jun 2026 06:02:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5613DA5B1
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 06:02:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589723; cv=none; b=BVEraweMUqvDGfKT9UAd3Ms5RSOTWLXwtMsBeZKalpOdSwrXitWRauHnpRjArQHdAYGejyMGtae5o3D6bVheK6a7k2biK9/L+gx2P5XMpaLYapugbXbVWVr6j5coB4qdu5LcmX+GnVWqnQqsopseKIP7bhWGZ/aAuUne1UL9wRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589723; c=relaxed/simple;
	bh=L8QYipn/cpD7W2OsRmo1QDjDakg2nTOzWwfv87mjwqM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Clhq1PTSOZX4vOqrA/n0HS9AMGom+Q7ymnvciVaXRg9UsRfwDl52Ht3SHFgxc9VjZJp8T9xbuBCsDVy8LtVgFp6KnQhL2Pf1+TTNwCvYfKOQeblcERYAxsEVZUWHLAFe5jLZDlOk4NpLGdHEsrMywEIlyyEd50lytuTbtfK7K38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=kxdjAO6J; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 9734020606;
	Tue, 16 Jun 2026 08:02:00 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XLE67o31Gk9A; Tue, 16 Jun 2026 08:01:59 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id D06AA20561;
	Tue, 16 Jun 2026 08:01:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com D06AA20561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781589719;
	bh=qA6U5ZJtL4VkNZKUR8JA7wz54Bmtu/1O0/SLhJVyeXU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=kxdjAO6JCK94q/3vw01MKIN58L8D4pN/TvT+J2Yxusze4vNrlOF+BxQZYNE0Y0pE8
	 bjvdU6Oi7w6ieM3V11Gg92I6aJQGSmo+2UEb37fQHr5RHp1SKL0PWa2utZU4BO8z2J
	 Ordu12qhqilYi8BJCmBAJiA4IauWE5l2EdZgjo7YmokjM2Kq64nb4rsUsxYldqYomK
	 uzud/JCfCMrz1BxC1gY5Oxv6FkdBctDfVMoZyqVRIj8q6i9orUPEIXA1rd/lsEEaeI
	 aZ89feiJA+z+KsVGxy9+sEGEQ0p1F81fJpRzrjJXXbkGGXYi7hBJr+m7jG8ks7cjeH
	 au9kiyYmi1BSQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 16 Jun
 2026 08:01:58 +0200
Received: (nullmailer pid 1677294 invoked by uid 1000);
	Tue, 16 Jun 2026 06:01:57 -0000
Date: Tue, 16 Jun 2026 08:01:57 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Dong Chenchen <dongchenchen2@huawei.com>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <tpluszz77@gmail.com>, <idosch@nvidia.com>,
	<netdev@vger.kernel.org>, <zhangchangzhong@huawei.com>,
	<xuchunxiao3@huawei.com>
Subject: Re: [PATCH net v2] xfrm: Fix dev use-after-free in xfrm async
 resumption
Message-ID: <ajDm1TepQ0bIgqVq@secunet.com>
References: <20260609092117.1362316-1-dongchenchen2@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260609092117.1362316-1-dongchenchen2@huawei.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299745-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dongchenchen2@huawei.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:tpluszz77@gmail.com,m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:zhangchangzhong@huawei.com,m:xuchunxiao3@huawei.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,nvidia.com,vger.kernel.org,huawei.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:dkim,secunet.com:mid,secunet.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:email];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 884C768C538

On Tue, Jun 09, 2026 at 05:21:17PM +0800, Dong Chenchen wrote:
> xfrm async resumption hold skb->dev refcnt until after transport_finish.
> However, xfrm_rcv_cb may modify skb->dev to tunnel dev without taking
> device reference, such as vti_rcv_cb. The subsequent async resumption
> will decrement the tunnel device's reference count, which lead to uaf
> of tunnel dev and refcnt leak of orig dev as below:
> 
> unregister_netdevice: waiting for vti1 to become free. Usage count = -2
> 
> Stash the original skb->dev to fix refcnt imbalance. The new skb->dev set
> by xfrm_rcv_cb can race with device teardown. Extend rcu protection over
> xfrm_rcv_cb and transport_finish to prevent races.
> 
> Fixes: 1c428b038400 ("xfrm: hold dev ref until after transport_finish NF_HOOK")
> Reported-by: Xu Chunxiao <xuchunxiao3@huawei.com>
> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>

Applied to the ipsec tree, thanks Dong!

