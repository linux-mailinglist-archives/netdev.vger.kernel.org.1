Return-Path: <netdev+bounces-292739-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAeUJChcGGrVjQgAu9opvQ
	(envelope-from <netdev+bounces-292739-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:15:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB7F5F441C
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3023F3083229
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 15:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7877627E049;
	Thu, 28 May 2026 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wjl2Z4Jt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6915523AB81;
	Thu, 28 May 2026 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779980684; cv=none; b=Lq1yS304nIdvgBWBLWS8vMUh3mW4xBJHpDObeXYh0Qt/71X5YWvjNv5HJZ4E6F2l/0aXV/Aiqccvl0hPpFn7MNQUnCg+16SkB7L8g3+lt08L8KhdPDYQCAXu2OTiIlIm+uTkZugcCAHk7cfIsROlHsO/scFPl+dBzQxQ7LirTMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779980684; c=relaxed/simple;
	bh=3H2ORX3LaMZZJhQNMwEmqR2+s/uI166hUZt76ChWUqA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOd0pyJg3XKaofNmxiX5SnqrrZ7j4p+0D9zBd2IOZxwtLXPACSfxeHr5dqwdULieWyJAo+9MCZQxUdY5sSFUYx54Wu+0LC4LNWo/VSbZJ+QsWubVMBE43MwQTPpqjPoKFzz444AkRFuS1GERnuNA3AUk+gq/Lkjz3kMyJS5sv5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wjl2Z4Jt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289A81F000E9;
	Thu, 28 May 2026 15:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779980683;
	bh=okVGivR6JMzRY9m1e/jRPmfakZm7inVaYkf/GPCmAhw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Wjl2Z4JtMKtSu5lAXWKgaLJS3/SZN7RcBzQE86jhYuZSxHSyW0a3haS4ys3U85rG3
	 p4xSurbpWfuEPR4F+Ekm5Enl6lgUHYLvo4rtC7bLes/pu+cRoL6jmajJMo/BbxOBIj
	 62XBJpnuiu5sTWO8EHkLe5C8B/nC7vOMcUDVvh12sEGeJGP/du6PNOQP5b3ibtUbhN
	 TbZJcMMWQch74a0ZzDxk9cBwsjNujfLqIlU0DAwVTn3MRs1lLmF1sW/pFmu0ozFbqu
	 O/ICRH0+8+DedJhM+JFiChr2lILsFzHa9vWWPW7CbPPrPD92Oz7H7fraJGjzQgMRPW
	 QA40qw59IXXfQ==
Date: Thu, 28 May 2026 08:04:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Carlos Llamas <cmllamas@google.com>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Matthew Maurer <mmaurer@google.com>, Miguel
 Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, "=?UTF-8?B?QmrDtnJu?= Roy Baron"
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Christian Brauner <brauner@kernel.org>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v5 1/2] rust: netlink: add raw netlink abstraction
Message-ID: <20260528080441.01ab1847@kernel.org>
In-Reply-To: <ahff7OTzS46Rti5c@google.com>
References: <20260525-binder-netlink-v5-0-a90e2923ebeb@google.com>
	<20260525-binder-netlink-v5-1-a90e2923ebeb@google.com>
	<CANiq72kRC_k1cnJLmG+AUSiUH6kDXVsox3nMJnV-c6HkNXOwBA@mail.gmail.com>
	<ahbAyBD584Hk9Mst@google.com>
	<20260527192130.21dabf08@kernel.org>
	<ahff7OTzS46Rti5c@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292739-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linuxfoundation.org,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,garyguo.net,protonmail.com,umich.edu,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9AB7F5F441C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 06:25:48 +0000 Alice Ryhl wrote:
> > > Netdev maintainers, what do you prefer that I put for these files? I'm
> > > of course happy to be on the hook for this code.  
> > 
> > Can we put it under rust/kernel/net and rust/helpers/net ?
> > And then add those directories to networking ?
> > Just so that we don't have to keep wondering with every little piece 
> > of code.  
> 
> Sure, will do.
> 
> However, it doesn't look like rust/kernel/net/ is listed under any
> MAINTAINERS entry either.

Which is why I said:

  "And then add those directories to networking ?"

