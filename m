Return-Path: <netdev+bounces-274678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBHzHerKzmntqAYAu9opvQ
	(envelope-from <netdev+bounces-274678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 22:00:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBB238DD5C
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 22:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7567E3023821
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 20:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4C738838A;
	Thu,  2 Apr 2026 20:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IZf6Hldx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EB27081A;
	Thu,  2 Apr 2026 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775160037; cv=none; b=dyn6mGrUR8ONf69mQ5O6V8DU+K8JrpDuMA9ZfGGUtX9XIGTLx5cjWsv8bT77pDZHQGLs1j2gpJHybCfL2AQO9/XuptfT9Mh+nnFlEC9ZQk5+FHJLrpZHq1RX0+OX0JCkt0UsWNOeKdWajlhLex4/YCzG+oGMTR4NThQR6R+rPw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775160037; c=relaxed/simple;
	bh=aVZ3rdlH+5qhoOD4WzauZVkBL1g7oLCtYfJ+eXcaAws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZqaV1RuUNmn/v4YswfQxSAt3+IDRafIA+PxOR3Gyzcw43V+wx4FGH1IcTvlinO2HNsrkOb5SAYdvrz6D2E9E17ylCkl+k/oP/hnCkIrJP79THLF5C9LNFsm38hvFrK5ZGCoCgutSEKVCzReL7AWMJ/+EZ8DjFJVO23CewLw23I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IZf6Hldx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0245cheqWxXzUkjGJ9n1SNpzxZKHuLmv9mX6T/bT3Oc=; b=IZf6Hldx9vIojzV0pgm7Pto/Rg
	+hl490Qvm2Eshq6IhkkQWOYXv9uOTGTi6Dw7EsLj2k2BuYg+tfiObsW1mgtFoU1zA3A2nYjTxNlzN
	pWAxXlJHByXAvifbsQs/2YULE8q/7YCDHO+x5+y3oKTTdmUCVwnrkSZsz0vxKr6vFRYw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w8ODM-00EZ7B-Mo; Thu, 02 Apr 2026 22:00:28 +0200
Date: Thu, 2 Apr 2026 22:00:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
Cc: rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojeda@kernel.org, boqun@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [RFC PATCH 0/6] rust: net: introduce minimal rtnl/netdevice
 abstractions and nlmon reference driver
Message-ID: <bd785bda-fd5d-4bfe-9e75-acebd6d7184a@lunn.ch>
References: <20260402163640.1079056-1-wenzhaoliao@ruc.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402163640.1079056-1-wenzhaoliao@ruc.edu.cn>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274678-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1DBB238DD5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 12:36:34PM -0400, Wenzhao Liao wrote:
> Hi,
> 
> This RFC proposes a minimal set of Rust networking abstractions for
> link-type drivers, together with a Rust implementation of nlmon as a
> reference driver.

nlmon exists. Why would we want a second implementation in Rust?

It seems like we keep getting Rust submissions for the sake of
submitting Rust. We never seem to get Rust code adding something new,
something which does not already exist.

Please, if you want to submit Rust code, find a device which does not
have a driver and write a driver for it, in Rust. Or find a protocol
described in an RFC which we don't implement, and write a Rust
implementation. Or find a new firewall rule which cannot be described
using the current code, and implement it in Rust.

Unless it is something new, i doubt it will get accepted.

       Andrew

