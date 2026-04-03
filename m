Return-Path: <netdev+bounces-275089-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uC6jEXTWz2mb1AYAu9opvQ
	(envelope-from <netdev+bounces-275089-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:02:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D153957C3
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 960FD302D0A3
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 14:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1AF3C5550;
	Fri,  3 Apr 2026 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kCjyQcr9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A798F7D;
	Fri,  3 Apr 2026 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775228207; cv=none; b=FoUlWDp5MnpYowMyQUgRyKoq+ZMLvABmGMLb/Vy6FrGhl0uEP1F+hUDTZMgIRTk7G+rBWE9GiRiLyqw6bih7PKbbnSbczebKIMn6PKtn8a/eAu05/sXN4iAcaqDcwkdOCc+aHQWcCY/KXWX35T2GhM5GYqZxqZSZnxsK2AiSIL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775228207; c=relaxed/simple;
	bh=t2hjL5FLYq3Ti/UKzqQbs9exRzv1ZiHRFwRCFo/NSQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnWMVQmAu0FweDyH6jWTAW/sJ3Nnm+o+VEPvqCccjRPNW/ushAzKE7omS0TA6EqlaioRhNRx2YuiE3fJiNvvlXXuHEzKZxlA6iAU+GHvt3BCKOT40GGdf2Xjvp30YM0Yu42+8HfuZOVX3V1hREElIVXk6BwYfOwJCdWq63o0/zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kCjyQcr9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eJzDuAdtWqWopHjM3QVEBnUAbqrkUoD8spuL+EDprgk=; b=kCjyQcr9BRjBYVjpWbgupQhQtv
	VgzDuuuU36NWfb0SxhY5VUE7XViM7dtFkNYelxma4XYjpp6T7AlsuQhjfYjsRZG6M2O2ayOnwvRvD
	0vMXuX7+Qo+oZrnzl4GhoO9VFNG5SjInrv4xadggkjN5epK37e2EZvR5Nr7jUhpQed+A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w8fwq-00Eg5I-V0; Fri, 03 Apr 2026 16:56:36 +0200
Date: Fri, 3 Apr 2026 16:56:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: wenzhaoliao <wenzhaoliao@ruc.edu.cn>
Cc: rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojeda@kernel.org, boqun@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: Re: [RFC PATCH 0/6] rust: net: introduce minimal rtnl/netdevice
 abstractions and nlmon reference driver
Message-ID: <6d038b0d-5d7d-4869-ab39-df0eae713a1f@lunn.ch>
References: <20260402163640.1079056-1-wenzhaoliao@ruc.edu.cn>
 <bd785bda-fd5d-4bfe-9e75-acebd6d7184a@lunn.ch>
 <APYAlQCNKK5EzEq6n4bgjqou.3.1775205609812.Hmail.2023000929@ruc.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <APYAlQCNKK5EzEq6n4bgjqou.3.1775205609812.Hmail.2023000929@ruc.edu.cn>
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
	TAGGED_FROM(0.00)[bounces-275089-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,lunn.ch,davemloft.net,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 99D153957C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 04:40:09PM +0800, wenzhaoliao wrote:
> Hi Andrew,
> 
> Thank you for the candid feedback. I completely understand and agree with your
> point. Introducing Rust just for the sake of rewriting existing, perfectly
> working C code is not the goal here.
> 
> To clarify, my primary motivation for submitting the nlmon driver was not to
> replace the C implementation, but rather to use it as a minimal, isolated
> testbed to validate the proposed Rust networking abstractions (the first part
> of the patch series). I wanted to ensure the abstractions were somewhat
> grounded in a real use case before attempting to write a driver for a
> completely new device.

We prefer to see real users of newly added code. So start implementing
this new drivers for new hardware. Introduce the Rust abstractions as
the driver needs them. We allow patchsets of up to 15 patches. And the
first patchset does not need to be a functioning driver. So implement
what you can within 15 patches. It does not matter if it does not even
send/receive frames. Maybe it will just probe, and setup the Rx and Tx
rings? Then submit another patchset of 15 patches, adding more
abstractions and using them in the driver. Eventually you will get to
a working very minimal driver.

You might want to be way ahead in terms of development compared to
submission. So you might have 45 to 60 patches in your tree, a very
minimum driver which you know actually works, and then start
submitting. But expect to be doing a lot of rewriting as you get
review comments.

What hardware do you have in mind?

	Andrew

