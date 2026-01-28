Return-Path: <netdev+bounces-254401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BgAGidOemnk5AEAu9opvQ
	(envelope-from <netdev+bounces-254401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:57:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C8AA75C9
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C7DF30A4467
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B29371044;
	Wed, 28 Jan 2026 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2Z7rVNs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B20371042
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769622555; cv=none; b=PfE/cHIFS9u8g3EF7yLcY+44+d9IDr3RrDV0QJkVZ/z/sjAeSbYXBKER9vV2ucib0XF5f5VngU931xuvDORNPZOh0KrljRkV6HwUYR5fOX7T08zAH2asqutF/a/yKX7fkj5+kM+pUrlhOzXrjwlKLpPEyfsXW3kTBhwAcYRUKbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769622555; c=relaxed/simple;
	bh=8un7es/xbbUnllzzDdMW70O2+NRNmtH9ogTJheki5Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LV4Y98J+FttdZ5TopFlGCSbVBlIDBcXugzyLav9yJBVSCF9YXJlaCl4pbX8yyOSH3/+piewlsovzBexNvSGcgIhgXULyFq69xn48YuwWZQlEdOzWOS/AdgkoicZuWZU/9bT6EStviig59QEicjj3xrVK7aKoJceDdLTII5h8OKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2Z7rVNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4147FC4CEF1;
	Wed, 28 Jan 2026 17:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769622555;
	bh=8un7es/xbbUnllzzDdMW70O2+NRNmtH9ogTJheki5Cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c2Z7rVNsiHVACF4AADeS8WdZ+dkRf3d8nPghXNLmyuRWXDwQAU7zhmFkwGk5z6YEb
	 aXJ0aJBAK/I11tp19OMtswzd9afkMmRhxbt4wDFM+gHuyRX3qpyg3kGUxHB263w2Ww
	 tq9XmDu7yfu+dJH5J76iBnu69uhw9xWO9jWOEJfM8j74Qifr6ytMiy6qmhxSWnlJRH
	 3E1bdJwVb0r8cDwJSF+sN956IrrUe0KGobdnnb2nWcOc0USY2zJbTlFaWjKbe37SQ0
	 9QE2QmrDdeJH1VUVJoDnLjHnOnnNcwDQatLEVuUkzKEWyZEPutb0Z1+4R0jit1G2Um
	 Y0c2c6ygGpDxA==
Date: Wed, 28 Jan 2026 17:49:11 +0000
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next] ipv4: Use EXPORT_IPV6_MOD_GPL() for
 ip_fib_metrics_init().
Message-ID: <aXpMF0DNTpmb7KGL@horms.kernel.org>
References: <20260127081335.646666-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127081335.646666-1-kuniyu@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254401-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 22C8AA75C9
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 08:13:20AM +0000, Kuniyuki Iwashima wrote:
> ip_fib_metrics_init() is only called from fib_create_info()
> and ip6_route_info_create().
> 
> Let's use EXPORT_IPV6_MOD_GPL() instead.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks,

This matches my undestanding of the purpose of EXPORT_IPV6_MOD_GPL, as per
commit 54568a84c95b ("net: introduce EXPORT_IPV6_MOD() and EXPORT_IPV6_MOD_GPL()")

Reviewed-by: Simon Horman <horms@kernel.org>

...

