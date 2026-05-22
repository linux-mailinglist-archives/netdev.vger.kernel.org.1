Return-Path: <netdev+bounces-290869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cB/2OBx6EGrdXwYAu9opvQ
	(envelope-from <netdev+bounces-290869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:45:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AFF5B718E
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FBD63061DD9
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 15:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560A642848D;
	Fri, 22 May 2026 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="BXTedcAb"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF477451060;
	Fri, 22 May 2026 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464405; cv=none; b=uPL3BKulpX+nbu10lzsO3wnJsDqzAsCHRFQXQzLKJL28jf3hoT8geEgZCyyYCOS/y5O/oYIwdIKxz4SwlSeQ3kYA16bKUaqfe479HHqVf0xGa3gF1s4kuh5+PpRE/MNa7Okl357ZuVtBMxxzSROe7hupAyW7pojOqHxPF5MJkSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464405; c=relaxed/simple;
	bh=/eYs819iJ6Q6bHoy5sa/NML0w9zSyXkkTPD5/gWI5vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOuuJlh24T1/DiXaGg6JmxDGSE9xO6Rcenrns5R6EQ/MR1/WT8zW0krER6hG8i1yALHmSJC0VWSz3m/G6BHj5TL2xYB4skGsV+rL2yqnaaNn4cikKx8j0ou8KdTQw2/XqN0aYEAQKXIHpBjY+KONpzSdB4Vg1qvULrj5KQzR+1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=BXTedcAb; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=mjWO/2FqSMC+SP/B4fyvziI0tW/20AxcF96HQZzcYSM=; b=BXTedcAbtRKIanJbi8CpHBKIKK
	0mRp0jxPLeZCVrAkD46vxLIDzZ3b8YNlDIkZ9i6CuZ+qAJBFfTyjfI3iAOT7QV8oI10GMBzMclSdw
	Dp2Mg+lwjKhkDc03QK0bhVQfT1SRNUsGnTAc2oFXiBkLNAX7uqOi0h6RXBZGJVC08SCAFySd5XvHy
	haiQXN+Nets6OO2ThRrOoq2o7orbTDrdYaifeHmR5rkix7pv3ExrI1jpECSYiIPGYvzeOuSdO4n6d
	NpS0Keyj0NuO5fPdgEDFdcIC3F5LzhXpTR3Z6qttum7OXu3d98/ghTNHXBZEYq1GSMKC0ipLASSCm
	p3P5fBYQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wQRyJ-004lSF-1k;
	Fri, 22 May 2026 15:39:35 +0000
Date: Fri, 22 May 2026 08:39:30 -0700
From: Breno Leitao <leitao@debian.org>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: Avoid checksumming unreadable skb tail on trim
Message-ID: <ahB2VbotEW5GD8K5@gmail.com>
References: <20260522120643.242974-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260522120643.242974-1-bjorn@kernel.org>
X-Debian-User: leitao
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290869-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 61AFF5B718E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 02:06:40PM +0200, Björn Töpel wrote:
> pskb_trim_rcsum_slow() keeps CHECKSUM_COMPLETE valid by subtracting
> the checksum of the bytes removed from the skb tail. That assumes the
> removed bytes can be read.
> 
> io_uring zcrx skbs may contain unreadable net_iov frags. With fbnic
> header/data split, small TCP/IPv4 packets can carry Ethernet padding
> in such a frag. ip_rcv_core() trims the skb to iph->tot_len before TCP
> sees it, and the CHECKSUM_COMPLETE adjustment then calls
> skb_checksum() on the padding.
> 
> This is exposed by IPv4 because small TCP/IPv4 frames can be shorter
> than the Ethernet minimum payload. TCP/IPv6 frames are large enough in
> the normal zcrx path, so they do not hit the same padding trim.
> 
> Keep the existing checksum adjustment for readable skbs. If the
> remaining packet is fully linear, drop CHECKSUM_COMPLETE and let the
> stack validate the packet after trimming. If unreadable payload would
> remain, fail the trim; the checksum cannot be adjusted without reading
> the trimmed tail.
> 
> Also clear skb->unreadable when trimming removes all frags.
> 
> Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
> Signed-off-by: Björn Töpel <bjorn@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>

> +static int pskb_trim_rcsum_complete(struct sk_buff *skb, unsigned int len)
> +{
> +	int delta = skb->len - len;

I suppose this is not unsigned/size_t because csum_block_sub() requires
an 'int', is this right?

>  /* Note : use pskb_trim_rcsum() instead of calling this directly
>   */

I think you can make this a one-line comment, or just a proper kdoc.


