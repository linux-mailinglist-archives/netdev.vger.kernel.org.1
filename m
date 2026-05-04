Return-Path: <netdev+bounces-283737-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBMGBKdR+GmQsQIAu9opvQ
	(envelope-from <netdev+bounces-283737-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:58:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE464B9C37
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8202430078C0
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 07:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BB23115BD;
	Mon,  4 May 2026 07:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="omec0qvK"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70D5310762;
	Mon,  4 May 2026 07:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777881243; cv=none; b=fN1O7hOepj1HghDu4d+4B7yj/GZjyQjgv8xKI9n5rv1FA5i7W98xqKJ2oabnH06ZALcQWMC9JiCJ2U/Lu96GwJhdByYS4PJA9OIutI4Yb7oy3CxO500MbnTq5Chp/C8Byr5Pxh2zdRx6us45blGGHk87SxuRFhAiEaaNDceCgM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777881243; c=relaxed/simple;
	bh=zmfJWUtoD6QrwTwY/0qkxmllKEhdZBEbkEMGD29+lN0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lk7NzKBjuNeDb3aai08uGhNtFHMaWMhu5P/RUdXlSQkIqvBAW0TxKQkQhGo2/Vqd2ahdMMfXbiPhTRmJ239ySrL7tbpJh92L30u1s2D6Gb2vnGQyx/rGNjbQha12RwkL4L02AzGUtL+RFQo0JNqkjhGpeUAl0h6TQQHa87FtYbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=omec0qvK; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 424E620523;
	Mon,  4 May 2026 09:53:53 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0_xA0Jmcl71J; Mon,  4 May 2026 09:53:52 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A736F20189;
	Mon,  4 May 2026 09:53:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A736F20189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1777881232;
	bh=O1M/zVFLhzRw5c7wj/4+AVWP83j9/+MMSJJExWB0Yw0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=omec0qvK0665P82qJ/FYq+faN0yvOen3pU+a4dr6STV9BQAxXqwEEhP6FTh/qoWpO
	 /KRwvgmTgM5ig6qPKydJ9hEdSZUZF6OZqtDRMHXjy2ptaBF022PuS0Qv1/9ZkjiVG1
	 UbKRp+6TKO/xph/EudyZ3W/4VYFz+0j+Y+Foc03ihWviVT/cT+ug7a/ZicqiqxhxB+
	 1B89zDvbvORvvsLb3RklxkyqGjdfDJVXXXIIcvLILXPn9K9mlfFSXvH++XEqPXydCg
	 tCLHP1ZtM5d2didGWJrR+9DqLH2ajaqXEcpkfsv12sZwg4A/+85dh7GDZ+aXEOvun8
	 09wqdrIiftq1Q==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 4 May
 2026 09:53:51 +0200
Received: (nullmailer pid 2934465 invoked by uid 1000);
	Mon, 04 May 2026 07:53:50 -0000
Date: Mon, 4 May 2026 09:53:50 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: HexRabbit <h3xrabbit@gmail.com>
CC: <netdev@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
	<linux-kernel@vger.kernel.org>, Hyunwoo Kim <imv4bel@gmail.com>
Subject: Re: [PATCH net] xfrm: esp: avoid in-place decrypt on shared skb frags
Message-ID: <afhQjlpmt2agPcRE@secunet.com>
References: <20260504073403.38854-1-h3xrabbit@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260504073403.38854-1-h3xrabbit@gmail.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Queue-Id: 5DE464B9C37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283737-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,gondor.apana.org.au,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:dkim,secunet.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

We have antoher patch that addresses this issue in a different way,
so Cc the author of the other patch.

On Mon, May 04, 2026 at 03:34:03PM +0800, HexRabbit wrote:
> From: Kuan-Ting Chen <h3xrabbit@gmail.com>
> 
> MSG_SPLICE_PAGES can attach pages from a pipe directly to an skb. TCP
> marks such skbs with SKBFL_SHARED_FRAG after skb_splice_from_iter(),
> so later paths that may modify packet data can first make a private
> copy. The IPv4/IPv6 datagram append paths did not set this flag when
> splicing pages into UDP skbs.
> 
> That leaves an ESP-in-UDP packet made from shared pipe pages looking
> like an ordinary uncloned nonlinear skb. ESP input then takes the no-COW
> fast path for uncloned skbs without a frag_list and decrypts in place
> over data that is not owned privately by the skb.
> 
> Mark IPv4/IPv6 datagram splice frags with SKBFL_SHARED_FRAG, matching
> TCP. Also make ESP input fall back to skb_cow_data() when the flag is
> present, so ESP does not decrypt externally backed frags in place.
> Private nonlinear skb frags still use the existing fast path.
> 
> This intentionally does not change ESP output. In esp_output_head(),
> the path that appends the ESP trailer to existing skb tailroom without
> calling skb_cow_data() is not reachable for nonlinear skbs:
> skb_tailroom() returns zero when skb->data_len is nonzero, while ESP
> tailen is positive. Thus ESP output will either use the separate
> destination-frag path or fall back to skb_cow_data().
> 
> Signed-off-by: Kuan-Ting Chen <h3xrabbit@gmail.com>
> ---
>  net/ipv4/esp4.c       | 3 ++-
>  net/ipv4/ip_output.c  | 2 ++
>  net/ipv6/esp6.c       | 3 ++-
>  net/ipv6/ip6_output.c | 2 ++
>  4 files changed, 8 insertions(+), 2 deletions(-)

This looks ok to me. From the IPsec point of view, I'm
fine with this patch, but it also touches generic
networking code. So I'd like to hear an opinion of one
of the networking maintainers before proceeding.

