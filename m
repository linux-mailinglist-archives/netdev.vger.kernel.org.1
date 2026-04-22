Return-Path: <netdev+bounces-280484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMuROWz16GnaSAIAu9opvQ
	(envelope-from <netdev+bounces-280484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:21:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5384487E5
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 54B7E3001469
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E3C29A9E9;
	Wed, 22 Apr 2026 16:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RmpKPxzn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EBB273D8D
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874804; cv=none; b=uB1Z4f8KY9im3oYhOAJBWZpK8hA0fs1xwdG9lzdJdTcHgoiiuFg0HnpO9HEymIAQqV6k2P4JmPa/6kxQ9VgVaaAnIb6wCIL6RBmSjIpAHa2BFLfXSmfPLLQrTOVbgC+2QecGc1MBW81cQECjmrgMiAkMYWIeaqxLaOvQzj2ZmZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874804; c=relaxed/simple;
	bh=hTbQ+7rBn6Z6oE4IHG7B+e3OJoHuV9HV2cu0aa7qwWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgU7Y5fQ1BlKS70TzwsdbHePjvt3qPtu2zYN6BXZn5QVulZRcZBZnI7G+CbO8fgoIT2425pnfJOs/iexitm/9WPg1gEr/4ca/0E58P6xRkI1ehjE1uhsCGLTFQRA27YJw/U+2HARDeaYHQVpLgye9d+SjhM9FO1K0QFW1aJoY3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RmpKPxzn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=841VCFZltsKSyO2IrUGokvlS9Y7hR4F0aLxXWbhCsD0=; b=RmpKPxznEfqB69d5h7g0nT4oAR
	L053wtOhwrAZlJE/p3yids1FjPutOVv43d6mrs4Dfx23QW9vgMCp5JL70cGGMMFNTiUxQ6cutlNU4
	yBlKSw6jo6BC4EJVEMMOcPavpOOcWUIcXpZXAIzjPfvu5zlNA6+miqZQN7nkGBYOPiDI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFaIv-00H3bR-3C; Wed, 22 Apr 2026 18:19:57 +0200
Date: Wed, 22 Apr 2026 18:19:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Junyang Han <han.junyang@zte.com.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ran.ming@zte.com.cn, han.chengfei@zte.com.cn,
	zhang.yanze@zte.com.cn
Subject: Re: [PATCH net-next v2 0/3] Add ZTE DingHai Ethernet PF driver
Message-ID: <39e6d965-44ee-4edb-a558-859a902ffe54@lunn.ch>
References: <20260422144901.2403456-1-han.junyang@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422144901.2403456-1-han.junyang@zte.com.cn>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280484-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 7F5384487E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 10:48:58PM +0800, Junyang Han wrote:
> This series adds initial support for the ZTE DingHai Ethernet controller,
> a high-performance PCIe Ethernet device supporting SR-IOV, hardware
> offloading, and advanced virtualization features.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Please read sections 1.3 and 1.4, particularly the bit in red.

    Andrew

---
pw-bot: cr

