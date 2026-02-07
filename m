Return-Path: <netdev+bounces-257755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DWMCmUWh2nBTQQAu9opvQ
	(envelope-from <netdev+bounces-257755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 11:39:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 782DC10590C
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 11:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D4DF3004631
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 10:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C9333D6EE;
	Sat,  7 Feb 2026 10:39:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABF417D6
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770460768; cv=none; b=M3m5xii7eAGeHyLdl4a+EbzmyYIR2Fruf483oX1Spx23ofndj+NoSWfYENef/tN5oFAM3C+qsh20Ra4ySk4LJy8h2Sv+JdTWylzd30D3EWOw+1qTfg+7HEtclH7ieriPi/DjXUAJD0bZJLP+hhlmXuk361Yw1K908xfNJ3R2QeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770460768; c=relaxed/simple;
	bh=GWJT77GzIXBDylqhuCWi1ijUbwirtIeOU0ugsT1cOdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a20CleBMHjhqCWp2TEwYjBJRQv3+zLXkQzoU3+c2cIWtSsYDcB7Qslj3xz5V1uGPzU8O+0PQa0C+Wgj6nH0X26N9jbFj9u8vs6k9znbhBLWKTPxuqAvxDje0o0RTZYvlxxZqrnDWLHYcrMHlufZ6MavhuTv1x/iqCqLVGDHS8co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id BF75860345; Sat, 07 Feb 2026 11:39:19 +0100 (CET)
Date: Sat, 7 Feb 2026 11:39:10 +0100
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next] xfrm: reduce struct sec_path size
Message-ID: <aYcWTvF7SNm1NojP@strlen.de>
References: <83846bd2e3fa08899bd0162e41bfadfec95e82ef.1770398071.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83846bd2e3fa08899bd0162e41bfadfec95e82ef.1770398071.git.pabeni@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.864];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257755-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 782DC10590C
X-Rspamd-Action: no action

Paolo Abeni <pabeni@redhat.com> wrote:
> The mentioned struct has an hole and uses unnecessary wide type to
> store MAC length and indexes of very small arrays.
> 
> It's also embedded into the skb_extensions, and the latter, due
> to recent CAN changes, may exceeds the 192 bytes mark (3 cachelines
> on x86_64 arch) on some reasonable configurations.
> 
> Reordering and the sec_path fields, shrinking xfrm_offload.orig_mac_len
> to 16 bits and xfrm_offload.{len,olen,verified_cnt} to u8, we can save
> 16 bytes and keep skb_extensions size under control.

Reviewed-by: Florian Westphal <fw@strlen.de>

