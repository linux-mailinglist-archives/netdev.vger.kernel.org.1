Return-Path: <netdev+bounces-258616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIG8JuYyj2k+MQEAu9opvQ
	(envelope-from <netdev+bounces-258616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 15:19:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0850F13705A
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 15:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 044BD300DE38
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 14:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DD925487B;
	Fri, 13 Feb 2026 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0Fbb1dZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325181E376C;
	Fri, 13 Feb 2026 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770992344; cv=none; b=vALPJlxnvghPwDNFEF+THA7upL5mbWIWVsldz0KMK4Ri3zliBCHqygdCwhTUKM6hL3C+8mlbfwSZlE00E29aNZ0RzRts15vMPC/hrxHOMGM/qDTb5ObGSOeyCsRwE3/6Pv7wmbBcNUbRSTIruKMiP3QG1A5UbMzgdE1x+FgNNAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770992344; c=relaxed/simple;
	bh=T+WU0QN6oLz5dRbHnI15ISCNNguwotjY59hsUOGBEuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAdrbgyy+FJ3XCAoU+nob3lJ/NJdEkccl3P3fJS8YbOvFDJDc7R9vdzQrpwGV+kjAYNi17ScFnbRQm6jgGs3tCNG+FGXzRspFH+TneO31wmcUP7bi/yj4ovew6UWbs8QWjX7UdHrcpmB/V6Kxc4H4h+5rJqqsI9ZpJVsFYBqjpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0Fbb1dZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C00C16AAE;
	Fri, 13 Feb 2026 14:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770992343;
	bh=T+WU0QN6oLz5dRbHnI15ISCNNguwotjY59hsUOGBEuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K0Fbb1dZFif3zC5eISWPo54HKbjuhmBzb6zxCWXHtCI6PbHFTS9ruQtabCz9IY0GX
	 d+7uJuB7mySEm00o1VpFgjKOGvD/mizoo1YTEEKOjum1EyQ2SRofxBSfSWPgMjb/y1
	 mOJfZhCvf2XgY8vX6zmL9vR5PWmcBgLQpw0eZj0+aRPNswYJTzOZPYWWwDcHQQrir1
	 bQ6E8UxL4xYpM4I8MztaqPQsCxMUHCNFAwVXF4Zdv/428bmwLd1zoVGvZghPniTRDW
	 imaIrXVsPrUJSU4Xxf2flLli9Xx4fVimUillDTMYomwvH4LbsDcuNYOzyB6//xSwZP
	 9duHW7Bag7qow==
Date: Fri, 13 Feb 2026 14:18:59 +0000
From: Simon Horman <horms@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Yohei Kojima <yk@y-koj.net>, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] docs: ethtool: clarify the bit-by-bit bitset
 format description
Message-ID: <aY8y0zTlif9dGuLA@horms.kernel.org>
References: <f43999612ed9d17fb7fe8f21e777e1c784f23c46.1770457868.git.yk@y-koj.net>
 <f2882370-a531-4a83-ab39-cf73878c0d03@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2882370-a531-4a83-ab39-cf73878c0d03@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258616-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 0850F13705A
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 12:55:55PM +0100, Paolo Abeni wrote:
> On 2/7/26 11:25 AM, Yohei Kojima wrote:
> > Clarify the bit-by-bit bitset format's behavior around mandatory
> > attributes and bit identification. More specifically, the following
> > changes are made:
> > 
> > * Rephrase a misleading sentence which implies name and index are
> >   mutually exclusive
> > * Describe that ETHTOOL_A_BITSET_BITS nest is mandatory
> > * Describe that a request fails if inconsistent identifiers are given
> > 
> > Signed-off-by: Yohei Kojima <yk@y-koj.net>
> > ---
> > Current ethtool-netlink documentation doesn't describe several behavior
> > around bit-by-bit bitset, which makes it hard to develop a ethtool
> > library without digging into the kernel code. This patch eases the gap
> > between the kernel behavior and the documentation by adding descriptions
> > around the mandatory attribute and bit identification.
> 
> This needs review by someone provided with English natural language
> skills far better than mine. I'm wrapping the net-next PR right now;
> this has to be deferred after the merge window, I'm sorry.

Hi Paolo,

It's my opinion that, from an English language perspective, the changes
in this patch match the description.

Reviewed-by: Simon Horman <horms@kernel.org>

