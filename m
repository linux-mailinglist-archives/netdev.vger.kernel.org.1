Return-Path: <netdev+bounces-268665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC2oMHp5uWnQGQIAu9opvQ
	(envelope-from <netdev+bounces-268665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:55:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 377E32AD5E5
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7425B300B523
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2142D94B4;
	Tue, 17 Mar 2026 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4dA4sjj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4CA2D878D;
	Tue, 17 Mar 2026 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773762932; cv=none; b=Uv8PTsQ8YhtWqoMkbYlMNQJCSB7NV/xY8vvNjqpEQEbL1JmVMi6+Q76yt/eivSgjDV5V4JPvM9AIu9F8RjP5blUg+dc2AjcgY2xyXKKTnbuBQ+5EikDpF4ts3LY/AfXiCQGXqZJFtHGjsSYfWd0fly2zTLEtuD+9foZLNcgfci4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773762932; c=relaxed/simple;
	bh=sdxc17hjDvTbV8HLPbMxuIDiB/Y91gmpH6ASytKM/Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DbdwJZXpf4K2KTVBlimUMpDXeUxTthVnm4L8iI5flP+vVZimxZFF8XCC8+MHm19WT9NTMq1oQcJ8/OjI6E0YaarQxmcwrzLmyObBillFpqzy1bI/rw25WvdRDk+zTBVoxTCTsPZLHKyALs8akhdvOjDIhVZdGDFkG2TJXVw1eII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4dA4sjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6835C4CEF7;
	Tue, 17 Mar 2026 15:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773762932;
	bh=sdxc17hjDvTbV8HLPbMxuIDiB/Y91gmpH6ASytKM/Tk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X4dA4sjj1looa+b5wTefcyhkj+2WL4lLnQHRSOHBTGlVnDIZeOYpFKfDbJAnEa8qu
	 f+V9e9LYrOCadGrPOF3yRi9yM2VdWeExoPWiPcw7ZFCSIwwFv18Xqv0N/s6tzYrXiS
	 wMR8XCQqNOBxtIZbFu4yzMr/TQjp15/boOL0qFxiyKdvpB2YKgUlR8ldOS4KlsNoEk
	 IULKg3AtCNMejQ2wB9h1NqA7mfLeCTQIopJBMnbRViSsc37IokuJCB8+xbe2svLgi5
	 rRxdCf5ywuYjN0TRicKfZrAmc4DmAoO7Wg1ZnQSQAfREpFscgmqBh2ZYWWBUkHoPL2
	 BBPwI+lhFX2eQ==
Date: Tue, 17 Mar 2026 08:55:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/9] r8152: Add support for RTL8157 RX/TX
 descriptor format
Message-ID: <20260317085531.3ddff582@kernel.org>
In-Reply-To: <2094f5a3-e692-4d8b-9b66-0368e5142b98@birger-koblitz.de>
References: <20260314-rtl8157_next-v1-0-9ba77b428afd@birger-koblitz.de>
	<20260314-rtl8157_next-v1-1-9ba77b428afd@birger-koblitz.de>
	<20260316175123.45b8d6e1@kernel.org>
	<2094f5a3-e692-4d8b-9b66-0368e5142b98@birger-koblitz.de>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268665-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 377E32AD5E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 06:04:34 +0100 Birger Koblitz wrote:
> I would prefer to have individual patches in the series adding support 
> for the new functionality of the RTL8157 in parts that also allow 
> developers to understand the differences, even if this functionality is 
> used only in the last part of the series.

Functions should be added with the first caller.

