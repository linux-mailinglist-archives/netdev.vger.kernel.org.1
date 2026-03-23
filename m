Return-Path: <netdev+bounces-270551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BWtES5CwWmqRwQAu9opvQ
	(envelope-from <netdev+bounces-270551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 14:37:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E362D2F3105
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 14:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D39CE30175F9
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BF43AC0CB;
	Mon, 23 Mar 2026 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oiqdas9m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8663340298;
	Mon, 23 Mar 2026 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774273041; cv=none; b=UTxA7rjJk2JBe6yHotHd4hkvdA7NIPuq7G+SclNUH8O6NGFxZ8Etpcyyr4r9ps+M6k1KRLHb9JGkoQV+FmtmxVbzBHp9r+pgQO8keKHNTRaIaKvAxGVJZB2AzGuNWDw+ZHdkoVGWo7erBFD5/4uRtkKj9L9tV1RDFdT/z3DnmOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774273041; c=relaxed/simple;
	bh=uMu/ZZasV7ymEHC/lFsoY+JPq69Sa9hTiiAtH+neU3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TT3yPyXoX0W8pkCl/ApBsFEXjQqvYboXKVevtCcnxVxtUEnM2L6F8sHRveJQhW81LRnhR30aiibXUh0TRKVaCDjhs/i12TiNRYqrzGU9td3SzwxCRhchO1d91/w8mcTdWMVEkzm8/pb7WVXrYNcGOCBmrewRrOV8NHxgs2DrhQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oiqdas9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C907DC2BCB1;
	Mon, 23 Mar 2026 13:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774273040;
	bh=uMu/ZZasV7ymEHC/lFsoY+JPq69Sa9hTiiAtH+neU3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oiqdas9mzxn84ZmJM5mCTMwjt1bG2n8Q1DYsQu15EqWWIXVtfZWw7rAXYvhmzNs+P
	 EjiL4G8UADFtnBpLynoSsHGoUXulFShvNLkZE6aqJr7CEf0iEXFdCgevVuBu1a7nxi
	 unM/jBP+NQ5gp87RBgv5skEzDgc77AqXZ7+eeHbxRLgeIW7LW/bMIdUZRLnC1p+3U/
	 EXmqAHlfSP9QMVVC7aXX3O+1NqnAjyi2tC5nWlBpV17WrR8uYWmy3J2D7J64UkaG2A
	 0IhO/pNioRob9M3oDVkYYuIYcNKeYyQ4eQ6wp+IrSggZ6PIlRNFBO536FjsSgVFwRV
	 bXXv9/32ytejQ==
Date: Mon, 23 Mar 2026 13:37:17 +0000
From: Simon Horman <horms@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] nfc: microread: Drop unused include
Message-ID: <20260323133717.GA70497@horms.kernel.org>
References: <20260320215230.3236005-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320215230.3236005-1-andriy.shevchenko@linux.intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270551-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,horms.kernel.org:mid]
X-Rspamd-Queue-Id: E362D2F3105
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 10:52:29PM +0100, Andy Shevchenko wrote:
> This driver includes the legacy header <linux/gpio.h> but does
> not use any symbols from it. Drop the inclusion.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


