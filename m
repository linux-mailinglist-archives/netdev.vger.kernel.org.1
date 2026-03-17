Return-Path: <netdev+bounces-268550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CImMN3QxuWnsuQEAu9opvQ
	(envelope-from <netdev+bounces-268550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:48:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C5B2A83B2
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 700E430C19C1
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C9B35E955;
	Tue, 17 Mar 2026 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="NnY5Chj7"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BFD355F48
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744108; cv=none; b=enB42LVL9w5qhIwsB0EHDwNbhPPa3xmwrYRi/a9RzDFQyrStt5c0BSkv49Z2nWup7xVaBYf/duMAwrTl/XMeMcVLzHbklYG208xDkRPy+ft8hrN2GjZL1KSfU26bN30ny1TlE4yoHlgf4AVU56rmsRvl6tHiIVX4E4GMvCxZkQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744108; c=relaxed/simple;
	bh=mOHKJHo+XZ+BkVCZjLAhCGUmd7cFqK3jcx93u8sfV+0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpoVXvrJ85pWwAbDI6FoTK0RqhZGdUApq70MQrXrwITlBfnrkIQI58d/YRMHVmolkDe1/gz9T8joJIkaSav5A+XCm1RDfc4GDAoiYPtcDgs7x+PI7yZzsagYWIqevDEhHGJHc3s4K60qWUB4N5u3BtuVS+P/zZ1RiPn4G8kro+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=NnY5Chj7; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 2DAE3207B2;
	Tue, 17 Mar 2026 11:41:38 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RQmRiWg8sdb7; Tue, 17 Mar 2026 11:41:37 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A4F4F20520;
	Tue, 17 Mar 2026 11:41:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A4F4F20520
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1773744097;
	bh=jVWPuNq5TJbIXPIqc5fKsr7Aj5p3gjQAz0FDp9leky8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=NnY5Chj7RJmam4Ijwva1/Rf4cb+GFrK5YclFiU183gsEsSIkCftaNT67qO0gpQwnM
	 u0RokvWM3RhkXQD2NcVCur3GJaaXbYO3L6eh/H/NBtqeTSIzoZIBRE4lUMJvJCX9Mx
	 3FoJ3qdSYB3sS0zbdXBuWBRcdzxq4BiW5aoZVTFWRkIjR+VUXGMPhdSlWl6ezomYbB
	 QsrqBA9Kh/dvrnr89zH6puWi8uML5iUhTQnlGcMpTcmK+U4z5VDezHZp9Ueql4Lf82
	 pc/Xzsit74Qv2DyL9mV9ATO1+D8je+r3MKAVJ6gnffvjg/0gYfahipBIyBdJ6EMZAl
	 fcKKEhpdOzJkg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 11:41:37 +0100
Received: (nullmailer pid 1919837 invoked by uid 1000);
	Tue, 17 Mar 2026 10:41:36 -0000
Date: Tue, 17 Mar 2026 11:41:36 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Minwoo Ra <raminwo0202@gmail.com>
CC: <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Christophe Gouault <christophe.gouault@6wind.com>
Subject: Re: [PATCH net] xfrm: prevent policy_hthresh.work from racing with
 netns teardown
Message-ID: <abkv4Hwt2Mx9M0M3@secunet.com>
References: <20260313155929.7406-1-raminwo0202@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260313155929.7406-1-raminwo0202@gmail.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268550-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:dkim,secunet.com:mid];
	DKIM_TRACE(0.00)[secunet.com:+];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 40C5B2A83B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 12:58:44AM +0900, Minwoo Ra wrote:
> A XFRM_MSG_NEWSPDINFO request can queue the per-net work item
> policy_hthresh.work onto the system workqueue.
> 
> The queued callback, xfrm_hash_rebuild(), retrieves the enclosing
> struct net via container_of(). If the net namespace is torn down
> before that work runs, the associated struct net may already have
> been freed, and xfrm_hash_rebuild() may then dereference stale memory.
> 
> xfrm_policy_fini() already flushes policy_hash_work during teardown,
> but it does not synchronize policy_hthresh.work.
> 
> Synchronize policy_hthresh.work in xfrm_policy_fini() as well, so the
> queued work cannot outlive the net namespace teardown and access a
> freed struct net.
> 
> Fixes: 880a6fab8f6b ("xfrm: configure policy hash table thresholds by netlink")
> Signed-off-by: Minwoo Ra <raminwo0202@gmail.com>

Patch applied, thanks a lot!

