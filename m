Return-Path: <netdev+bounces-268551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIOkLIIxuWn4uAEAu9opvQ
	(envelope-from <netdev+bounces-268551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:48:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 037092A83C8
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C730300D16D
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7333D3A6B79;
	Tue, 17 Mar 2026 10:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="b8oBytzJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C443A6EE5
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744163; cv=none; b=WopH0cQCwCfaAmUAQrjpHR5UbiM/06ux2BnE1p0MR77QCJ+CDzRhnwTfd1VI6pWdc+d5UkQNfFVWWNnkWwOtZpSv2E6I++gqU9mREmvz3fTQ+LVJmaevnvHOJJP2zbRFR3j1Hc/xUndHfrS2T9wT9hGA18x6N/GS2zTSJK/LMVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744163; c=relaxed/simple;
	bh=J/rLAy+MarupWrvyAXpP4A+sqnGRpacd/t9XOlTXSk4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XViAIzuS23wWogkwE4JIyjmztyJ1RBEKroRjh2hU9sqI8/s4erxmZIFObrJkDuGZhIoiil1rmoSSteEEQwXcYn1AV25fAU6/vojBqnuCsGFx03lxWDAvO12NM19joPXRx3/JOIfNB31O6xQUjrWOofI/TF+5y46RVV4DnVg1oVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=b8oBytzJ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 1725D20660;
	Tue, 17 Mar 2026 11:42:40 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rh7o5ZaKEkUZ; Tue, 17 Mar 2026 11:42:38 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 8FB7720520;
	Tue, 17 Mar 2026 11:42:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 8FB7720520
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1773744158;
	bh=L9MkpAJtr8uyTo98kPwRP2spnR8dVQx+3wVJOZ3mIqw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=b8oBytzJYN0ndXIaUOfpQlUvXewogk98kFjFHsKt5CYVeDd2tI+JL6P4lN2qGS6Jb
	 COJkTQFKGpOoQV36t82xpGLYP7zlQBj+s4/mA5pbge5VVtc7BktSviMIFs/GNSOhyr
	 A+DTyRhLVslcKGooMNWI37/XlE/be4/iq3XQLLW7XfbVsH/4oV8uydmVcJKka+wtZX
	 QtyxUZV32gpEw+xjcTeQMIbHUQ1Gd/zVOCqVkBZemvH7wEGJ5XayVO2geKSkTQ+f8j
	 20pI+U4wcc8JBe6aG8skJGhPaR3TOR6SZ8EBVN8m5g4UyHHqi9A37PuICSdnsesmzG
	 ChOEwwh0jTuKQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 11:42:37 +0100
Received: (nullmailer pid 1926784 invoked by uid 1000);
	Tue, 17 Mar 2026 10:42:36 -0000
Date: Tue, 17 Mar 2026 11:42:36 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <eric.dumazet@gmail.com>,
	<syzbot+b518dfc8e021988fbd55@syzkaller.appspotmail.com>, Herbert Xu
	<herbert@gondor.apana.org.au>
Subject: Re: [PATCH net] af_key: validate families in pfkey_send_migrate()
Message-ID: <abkwHKnsm-AWwinP@secunet.com>
References: <20260314170210.4039941-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260314170210.4039941-1-edumazet@google.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,gondor.apana.org.au];
	TAGGED_FROM(0.00)[bounces-268551-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:dkim,secunet.com:email,secunet.com:mid,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:email];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,b518dfc8e021988fbd55];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 037092A83C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 05:02:10PM +0000, Eric Dumazet wrote:
> syzbot was able to trigger a crash in skb_put() [1]
> 
> Issue is that pfkey_send_migrate() does not check old/new families,
> and that set_ipsecrequest() @family argument was truncated,
> thus possibly overfilling the skb.
> 
> Validate families early, do not wait set_ipsecrequest().
> 
> [1]
> 
> skbuff: skb_over_panic: text:ffffffff8a752120 len:392 put:16 head:ffff88802a4ad040 data:ffff88802a4ad040 tail:0x188 end:0x180 dev:<NULL>
>  kernel BUG at net/core/skbuff.c:214 !
> Call Trace:
>  <TASK>
>   skb_over_panic net/core/skbuff.c:219 [inline]
>   skb_put+0x159/0x210 net/core/skbuff.c:2655
>   skb_put_zero include/linux/skbuff.h:2788 [inline]
>   set_ipsecrequest net/key/af_key.c:3532 [inline]
>   pfkey_send_migrate+0x1270/0x2e50 net/key/af_key.c:3636
>   km_migrate+0x155/0x260 net/xfrm/xfrm_state.c:2848
>   xfrm_migrate+0x2140/0x2450 net/xfrm/xfrm_policy.c:4705
>   xfrm_do_migrate+0x8ff/0xaa0 net/xfrm/xfrm_user.c:3150
> 
> Fixes: 08de61beab8a ("[PFKEYV2]: Extension for dynamic update of endpoint address(es)")
> Reported-by: syzbot+b518dfc8e021988fbd55@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/69b5933c.050a0220.248e02.00f2.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>

Applied to the ipsec tree, thanks a lot Eric!

