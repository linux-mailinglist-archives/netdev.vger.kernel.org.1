Return-Path: <netdev+bounces-258529-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id a9pFM2qEjmkyCwEAu9opvQ
	(envelope-from <netdev+bounces-258529-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 02:54:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 290F2132547
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 02:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABA8F306706C
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 01:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EF6217659;
	Fri, 13 Feb 2026 01:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHlvS3NY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B5D1386DA;
	Fri, 13 Feb 2026 01:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770947688; cv=none; b=YL8c4QHIkszvqFbX20F1Xsn3jOaFswMdxLDRKiwt7xVXCYhm4Md4w3RLSslkQMp4FEuG1X65eFpgtfkKFh9vghN+LTNS+2XWE6dH0psWtXDNCfCyT4wjpCDS4o09nmQ++W+NML9Mw3be3o7npKVx0ska2EP2lXa9PfUuXnRgfD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770947688; c=relaxed/simple;
	bh=BuWzvajIksF/4EKVOsQ5ZP4kXUEABUIKVsrMXESfepY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSCvttLdn+WXNOpJLEITx8soE4wGgfwTHp5WzDJEC2KZHMLV1ks7U7+1J7lm+8SrzZu4kkSqffaji63C/lVEhkpDmiPGoKCM5T0bGNMi91UI6VY+jOK0vcenxJjalWP6ya8kH1bRTa9/bPnM3eHamtnqkZgLoBvSopu0vscH4BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHlvS3NY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A75C4CEF7;
	Fri, 13 Feb 2026 01:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770947687;
	bh=BuWzvajIksF/4EKVOsQ5ZP4kXUEABUIKVsrMXESfepY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iHlvS3NYdOr+y7IHb3bzw4XQ1lbeAt7Pj9wcVlpQwPje1KGTul1G0PayFU0p4m7fL
	 U3pKYCqJ0xFadb5P4JpxT81KWDsoMssX74wdtkIoO7Eg3YVxJlgFjGzt6tXgIpIF0H
	 n9SMNxpyUOS6gisWVF5akqnaR8eYhLx1nhRWCCzs9wz/7FAmnMAc+CpzfpMcGNshkD
	 72GXKVQenrxQBtuPQODqvdrBZ6mObcN5nxf8qVi8F5aX9nuBlvIDJYvBpUfwmuS6ZR
	 kMTYwRmofqbjDX0wt93yVko2uMocZ6rpK40LGwQxxJi7xCB/Nd/LOnzpH/UZnmU8vB
	 3eSb9wb2K/nVw==
Date: Thu, 12 Feb 2026 17:54:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Chen Ni" <nichen@iscas.ac.cn>, andrew+netdev@lunn.ch, "David S .
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, "Ingo Molnar" <mingo@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Dave Jiang" <dave.jiang@intel.com>, "Lukas
 Wunner" <lukas@wunner.de>, Netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] myri10ge: Convert comma to semicolon
Message-ID: <20260212175446.57bd0792@kernel.org>
In-Reply-To: <0244faa4-763c-4ccd-b98e-59a0ee6b346b@app.fastmail.com>
References: <20260210013733.1901270-1-nichen@iscas.ac.cn>
	<20260211103308.4d6263bf@kernel.org>
	<0244faa4-763c-4ccd-b98e-59a0ee6b346b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258529-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 290F2132547
X-Rspamd-Action: no action

On Wed, 11 Feb 2026 22:07:56 +0100 Arnd Bergmann wrote:
> > We have already submitted our pull request with net-next material for v7.0,
> > and therefore net-next is closed for new drivers, features, code refactoring
> > and optimizations. We are currently accepting bug fixes only.  
> 
> This is a regression fix for a mistake I made in a patch you merged
> for 7.0. This was not very clear since Chen forgot to add a 'Fixes'
> tag and labeled it as [net-next] when it should (now) have been
> [net].

Ah, I should have connected the dots.. thanks for chiming in.

