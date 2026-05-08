Return-Path: <netdev+bounces-285830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEjNGlTj/WmOkQAAu9opvQ
	(envelope-from <netdev+bounces-285830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:21:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B47A4F6F63
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 616F83007B39
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 13:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341A03803D0;
	Fri,  8 May 2026 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFjXLEaV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118F037DE8D;
	Fri,  8 May 2026 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246478; cv=none; b=JDHOkfrt64CMncUCwYguGz4cokdkrrmEb9AVdqosXmcwpIXdlBmqaYHKiymCfYHHhpl63LXSV+QO9s45unJ4anjiNM9/VBtoobGw2RcbABD4wXtHWdecOcyRfSPuJocMd+t7IeYlIDZ4IQltld5HPcqSBs//jHQ/83tv2uVEoQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246478; c=relaxed/simple;
	bh=XsLfUZzfG8Zb4SNGXPeC/V0k5XAE9VokINR/PbQYcFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0X5xA2WuhckXA+VQLNlkWJIz54sOraCAQSiIR4Khn2wgbygUcTaN/lF4jnJ2yjexGfxs/F9dmiT+8gbTcNtHn/flgl3+qokBqSEqJkXkWRpvvkU9TpgoYg49zCpbAF9bjjbxI5CUvdfGok3xCWwh8juQKpqetHGhncJ8tYJEq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFjXLEaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615F3C2BCB0;
	Fri,  8 May 2026 13:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778246477;
	bh=XsLfUZzfG8Zb4SNGXPeC/V0k5XAE9VokINR/PbQYcFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qFjXLEaVQZdM6rzDT6ZS0LwxW8LaCuRC7gpoUF64uyolRdrDRhhcjwnL0TR8iUsHr
	 cQ0OEh2mU7Fwr8qTYLvIJJv7JUdZJk/4yrmp4imvbjF+CPe4hfRsZJ41+1LIoWV8MR
	 +xEL8hLEdq6/ZuNp7Z42cQV5B4jQwQw3w1EKOyDPkdpG9ua4rQJgdJJTkqpZW6Yw0m
	 hyIPYNdN+pm3dNElUn4HQlYmBr+49jtxIUuc5TF1tBPtN3FsR8W50f/ZOF2FVuefmm
	 e1Pn1dVvyMlN3Q57tcKHuHBICFVmJW8jmNiEyxyIrgibj3DOQskqJVCUkquA5WUOc/
	 9FDjU8uAHhI+w==
Date: Fri, 8 May 2026 14:21:13 +0100
From: Simon Horman <horms@kernel.org>
To: Quan Sun <2022090917019@std.uestc.edu.cn>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
	alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com,
	andrew@lunn.ch
Subject: Re: [PATCH] net: iphc: fix offset errors in multicast context
 compression
Message-ID: <20260508132113.GN15617@horms.kernel.org>
References: <20260505163146.432309-1-2022090917019@std.uestc.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505163146.432309-1-2022090917019@std.uestc.edu.cn>
X-Rspamd-Queue-Id: 5B47A4F6F63
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[uestc.edu.cn:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,lunn.ch];
	TAGGED_FROM(0.00)[bounces-285830-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.388];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 12:31:46AM +0800, Quan Sun wrote:
> The function lowpan_iphc_mcast_ctx_addr_compress() contains two offset
> errors that break context-based multicast address compression
> (LOWPAN_IPHC_DAM_00).
> 
> When compressing the multicast address, the compressed format expects
> exactly 6 bytes:
>   - Bytes 0-1: Flags, scope, and reserved bits (from s6_addr[1..2])
>   - Bytes 2-5: The 4-byte Group ID (from s6_addr[12..15])
> 
> Currently, the memcpy() operations use incorrect offsets:
> 1. The destination offset for the Group ID is &data[1] instead of
>    &data[2]. This overwrites the previously copied scope byte.
> 2. The source offset for the Group ID is &ipaddr->s6_addr[11] instead
>    of &ipaddr->s6_addr[12].
> 
> This mismatch results in a corrupted compressed address being
> transmitted. Consequently, the receiving side fails to reconstruct the
> original IPv6 address via lowpan_uncompress_multicast_ctx_daddr() since
> it expects the Group ID to start at data[2].
> 
> Fix the logic by correcting both the destination and source offsets
> so that the 6-byte compressed representation is assembled correctly.

Thanks,

This matches my understanding of:

RFC 6382 Compression Format for IPv6 Datagrams over IEEE 802.15.4-Based Networks
-> Section  3.2.4. Stateful Multicast Address Compression
   https://www.rfc-editor.org/rfc/rfc6282#section-3.2.4

And it's reference to 

RFC 3306 Unicast-Prefix-based IPv6 Multicast Addresses
-> Section 4. Multicast Address Format
   https://www.rfc-editor.org/rfc/rfc3306#section-4

RFC 6382 is referred to by
RFC 6775 Neighbor Discovery Optimization for IPv6 over Low-Power Wireless
         Personal Area Networks (6LoWPANs)
- https://www.rfc-editor.org/rfc/rfc6775.html

Which is in turn referred to by
RFC 8138 IPv6 over Low-Power Wireless Personal Area Network (6LoWPAN)
         Routing Header
-> Section 4.3.  Compressing Addresses
   https://www.rfc-editor.org/rfc/rfc8138.html#section-4.3


> Signed-off-by: Quan Sun <2022090917019@std.uestc.edu.cn>

As a fix this should have a fixes tag.
I think this one is appropriate.

Fixes: 5609c185f24d ("6lowpan: iphc: add support for stateful compression")

I don't think you need to repost because of this, but for future reference,
fixes for Networking code present in the net tree should be targeted at
that tree. This includes making sure the patch applies to that tree
(I assume this one does) and including net, as opposed to net-next,
in the patch subject like this:

Subject: [PATCH net] ...

Also, as a fix this probably waranted being CCed to stable.

For more information on Networking development process please see
https://docs.kernel.org/process/maintainer-netdev.html

The last two points not withstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

