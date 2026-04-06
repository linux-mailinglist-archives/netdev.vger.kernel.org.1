Return-Path: <netdev+bounces-275649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLcXA2Xj02nIngcAu9opvQ
	(envelope-from <netdev+bounces-275649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 18:46:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA1D3A569A
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 18:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A22E30036FB
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 16:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B935D21D3F4;
	Mon,  6 Apr 2026 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkGwYExh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9667E25776;
	Mon,  6 Apr 2026 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775493986; cv=none; b=PZ41/CXZ6B0FiJJiEcdCVMHEKtrkx8w1utv0SozZfVoI+8bJk+MsBz20PB9iAlRg0gAOEUB+2smCNghE0t4kWJfGRxV9fZfNPU7y/NNx7BBIPBohf6i0UXn8NRcV7nC7Fe9PTcUJztB2BVbLTx2rlymYHOCJIqhyEpeDBg68ofE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775493986; c=relaxed/simple;
	bh=w7ilhOLnMp5wknDWz/9lNlLZdxQo+8GSJ2ogFLcQlxA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YNso4Vgk0yQsHyarvQy2wwV+H/s27e7U4D9N+DFumCcotLl6Ar/4GQdF152k2VH8vsVTXvum7XuXbKQUA3A3o7RYLBKolnzyzS2/3QrkeYiWOikk+7L9NuP7YY7c3FgaF+5cdM3vUm07X9S/X4iEiu4pWi8jE0gSAU07SEL2+BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkGwYExh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1ED4C4CEF7;
	Mon,  6 Apr 2026 16:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775493986;
	bh=w7ilhOLnMp5wknDWz/9lNlLZdxQo+8GSJ2ogFLcQlxA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZkGwYExhTfFNHrQWWgGX7gQeFvmjNivBLZHVCGy5/Gq0Lfkj6lFjHQW5rRIVoNfDc
	 FMOpFccWedg8zx8pwIRJGC0f8EmMlSmQC6IYsqflqJUlwcWL3NoKPn8TeyixaWGEXr
	 ZrXHlIEoznygY7gohLBnJHuIkFYR4JAyqf/rfPWiumTAj9X1t8JdvBwVKcnKFn43M+
	 +73JD6O542D7IMf17s2fXEmNTFJMjkfUmvV5VCipeGebUJ2KoJIIUC785mPjWVrb69
	 uJzsFrwSPbbrohd/S1YIGJVs0AsRj8aB+qlAtWGcrh23i9Uropc5/6jR9hWy5qA3HQ
	 3wiUvkUxTiiuw==
Date: Mon, 6 Apr 2026 09:46:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Yiqi Sun <sunyiqixm@gmail.com>, horms@kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, pabeni@redhat.com, Mark Brown <broonie@kernel.org>,
 linux-next@vger.kernel.org
Subject: Re: [PATCH net] ipv4: icmp: fix null-ptr-deref in
 icmp_build_probe(): manual merge
Message-ID: <20260406094624.79736044@kernel.org>
In-Reply-To: <80348cc5-195d-4acf-9d20-2ddc0da92ef5@kernel.org>
References: <20260402070419.2291578-1-sunyiqixm@gmail.com>
	<c7df7e27-992e-4973-b6fb-63cdb7b40158@kernel.org>
	<20260406083615.32f44e4f@kernel.org>
	<80348cc5-195d-4acf-9d20-2ddc0da92ef5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,davemloft.net,google.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-275649-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9EA1D3A569A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 6 Apr 2026 18:10:14 +0200 Matthieu Baerts wrote:
> On 06/04/2026 17:36, Jakub Kicinski wrote:
> > On Mon, 6 Apr 2026 12:48:28 +0200 Matthieu Baerts wrote:  
> >>  -			dev = ipv6_stub->ipv6_dev_find(net, &iio->ident.addr.ip_addr.ipv6_addr, dev);
> >>  +			dev = ipv6_dev_find(net, &iio->ident.addr.ip_addr.ipv6_addr, dev);
> >> + 			/*
> >> + 			 * If IPv6 identifier lookup is unavailable, silently
> >> + 			 * discard the request instead of misreporting NO_IF.
> >> + 			 */
> >> + 			if (IS_ERR(dev))
> >> + 				return false;
> >> + 
> >>   			dev_hold(dev);
> >>   			break;  
> > 
> > See my reply, AFAIU we can just delete this new check in net-next.  
> 
> Good idea.
> 
> Should this not be done in an explicit patch, rather than "hidden"
> during the merge?

Dunno, it's not a huge change, feels like a good fit for a merge.

