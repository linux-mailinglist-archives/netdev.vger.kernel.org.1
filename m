Return-Path: <netdev+bounces-287974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPQQGwnXBWqacAIAu9opvQ
	(envelope-from <netdev+bounces-287974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:07:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 541BE542C4B
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF38D30357D8
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 13:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073EE3DFC8A;
	Thu, 14 May 2026 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9XCPoME"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D844A23741;
	Thu, 14 May 2026 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767047; cv=none; b=i8C6YftbqhCSVWWfh4M+LhKVBwyrvRhyu3WoHDY2hkV76B6WnXlGxRHk6OYI552GOL7AQjhyyXgz4YdgFci37745J+BJDnODQ2SApM47zveVozTe2JeXFT5FJINlmQAcXPL8JkaJAAUdPCx+/zy4LQJOpRlm4E7qkgYQ1C1Geq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767047; c=relaxed/simple;
	bh=FgX4bM3joS/ARFp6Is0bSb6fIJUNZVHYKk7HXhHjg5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRmdUWl6l2yPx9In9jssUjLq9jQzA7mcfjzLRj9ucS1oX+xeqvdwDUijv/v6V5zT7PfRsjW/yfemX62p5wh3fxsr/ZCRWGH/e9mZ7eFUpEPP3pqthaCO+L+Pm7dTtRgmGTXJa2ygl41sZemHfrnyIEBAjJuWWxiw074VU08dn8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9XCPoME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2888CC2BCB3;
	Thu, 14 May 2026 13:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778767047;
	bh=FgX4bM3joS/ARFp6Is0bSb6fIJUNZVHYKk7HXhHjg5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T9XCPoMEY5LbATYiWJCCU6q8/cu9u0kwLO8D+VnhNFYhfYs/Iw6uWgLa9Bw41ieIh
	 wcbm95ZlzNMVkldq6CHZxQGtJ0Z3kkwbf1KMHUoMyVee60wp7FouOrSM1v3NsY+1VD
	 M1u+NZP56T7fDt5SlN7m2We9WNLQw/eAd128XFIqjtJ/+VUivt9LRMGQOV90f/LLGH
	 bw8D7cuqnoxpYVcFfJZJFLJimBmORYijt1PzXW5a6JXb/cuXY7CpR29Ftnj9J4fOM5
	 nzq/NRttBhvAj0TyDqs4AyrUVD7UrM5BSNADRh7LQmm/1I/vIkhzI5WbC4gkuWz90d
	 zVkJw/Dd7pnOQ==
Date: Thu, 14 May 2026 06:57:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/ethtool: fix HWTSTAMP TX/FILTER BUILD_BUG_ON in
 tsconfig SET path
Message-ID: <20260514065726.09d56535@kernel.org>
In-Reply-To: <20260514091537.1544154-1-zhaochenguang@kylinos.cn>
References: <20260514091537.1544154-1-zhaochenguang@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 541BE542C4B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-287974-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, 14 May 2026 17:15:37 +0800 Chenguang Zhao wrote:
> BUILD_BUG_ON(__HWTSTAMP_TX_CNT >= 32) and the same for
> __HWTSTAMP_FILTER_CNT reject the valid upper bound of
> 32 enum-derived bit positions in a u32 bitset (indices 0 .. 31).
> Use > 32 so only counts strictly larger than the u32
> width fail at compile time.

If someone needs to use 32 they can investigate this properly and bump
the bound. Either you're not explaining the problem well or this is
a complete noop right now
-- 
pw-bot: reject

