Return-Path: <netdev+bounces-278886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /OiEA7kw4GlWdQAAu9opvQ
	(envelope-from <netdev+bounces-278886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 02:43:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C41409525
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 02:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5A1D3034672
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 00:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F4917AE11;
	Thu, 16 Apr 2026 00:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Rd6bH6pb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE501C695;
	Thu, 16 Apr 2026 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776300203; cv=none; b=Rcz1rf3XvKnLxcIrF1Q5RsJVW2Ksf6Iycw1YdAclWC6MI+ds7FdnGOKBKswTGCgw2J2/ufnplDYea0c+s45QmOrKW8P6a46Xm1IMI4WYSyQnzqIEMNi1yA5vWwBFKnHjSVTDnjuwXzWgDSJUFp+7BBd3PgOAD4dDYrm8Xc6LLzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776300203; c=relaxed/simple;
	bh=lQv0RrnnKjrsrz3OfpAB7H9RZq1x1kFzHaHJw9VDgVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNts5G3XOIHMZj4M2rKo+BclOuc/I5LINJ3vIs41NM4hAqHmJ1zLRLXQqxiymIUwbeEu9C2xRy6C9zy08BaOyYK7+0GUCRd8Kkiftdw9NlpgvnBkF9yqw8UsTENEoTI/50kN4AkOdQ4i+FSuM8uo/CuT22zD19ZjplWaipPoD98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Rd6bH6pb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QwwpPMeXcqgVS3p4zP/MvEBTtT1TcMx4mqU6gSoWG44=; b=Rd6bH6pbTu/TXQmeEjPzoeYA4f
	bKKjflY+DmB/3kutQngE653je1dDqjLiAqBG/MvyzKAmx0Ve4SFst6NYUrwA+nUo6ivQGuIL+xHdA
	TurvxQAa7VnTt+Xa4NOU+ShgXPc2WCci+ragGgHsRp3Z05ydWySP/Ff4pza+hk2xvA8g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wDAoq-00GEEl-LQ; Thu, 16 Apr 2026 02:42:56 +0200
Date: Thu, 16 Apr 2026 02:42:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 1/4] rust: netlink: add raw netlink abstraction
Message-ID: <e8875c97-ddc1-4eb2-85cf-27f34e0d9e08@lunn.ch>
References: <20260415-binder-netlink-v3-0-84be9ba63ee2@google.com>
 <20260415-binder-netlink-v3-1-84be9ba63ee2@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415-binder-netlink-v3-1-84be9ba63ee2@google.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278886-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,gmail.com,davemloft.net,google.com,redhat.com,linuxfoundation.org,android.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2C41409525
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> diff --git a/rust/helpers/genetlink.c b/rust/helpers/genetlink.c
> new file mode 100644
> index 000000000000..3530b69f6cf7
> --- /dev/null
> +++ b/rust/helpers/genetlink.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (C) 2026 Google LLC.
> + */
> +
> +#include <net/genetlink.h>
> +
> +#ifdef CONFIG_NET
> +
> +__rust_helper struct sk_buff *rust_helper_genlmsg_new(size_t payload, gfp_t flags)
> +{
> +	return genlmsg_new(payload, flags);
> +}
> +
> +__rust_helper
> +int rust_helper_genlmsg_multicast(const struct genl_family *family,
> +				  struct sk_buff *skb, u32 portid,
> +				  unsigned int group, gfp_t flags)
> +{
> +	return genlmsg_multicast(family, skb, portid, group, flags);
> +}
> +
> +__rust_helper void rust_helper_genlmsg_cancel(struct sk_buff *skb, void *hdr)
> +{
> +	genlmsg_cancel(skb, hdr);
> +}
> +
> +__rust_helper void rust_helper_genlmsg_end(struct sk_buff *skb, void *hdr)
> +{
> +	genlmsg_end(skb, hdr);
> +}
> +
> +__rust_helper void rust_helper_nlmsg_free(struct sk_buff *skb)
> +{
> +	nlmsg_free(skb);
> +}
> +
> +__rust_helper
> +int rust_helper_genl_has_listeners(const struct genl_family *family,
> +				   struct net *net, unsigned int group)
> +{
> +	return genl_has_listeners(family, net, group);
> +}

The C part looks sensible now. For this bit only:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

