Return-Path: <netdev+bounces-265798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FdTJSZar2m3VQIAu9opvQ
	(envelope-from <netdev+bounces-265798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:39:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD133242B53
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BACE3055C55
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 23:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D293939D4;
	Mon,  9 Mar 2026 23:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsDfR47n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BDA392C35
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 23:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773099540; cv=none; b=gxElMTQmShpihAX06wkPKWKhyIrePvzK3/GUdgemtK9VsennBSQdQOdI4EBhoQftrlPMh8ds1K0nVXybOdbNph1RFhBTVH/3NJjpuaAwVibX+Ugxjpb1WBlgAmhpii+VsPuktmdQUpWgb7WlOkMpNasCA57iUDVAQOrOVgwm9jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773099540; c=relaxed/simple;
	bh=WtKWn6qK1INg7feQ07zfye3cINCV/UdAMK1VoZjSJZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ggs7rUxHY8XFhIGU8gE0sM9ch65eGSPMB916K0wXXxq0ppGmQgxpM/xaRuH7kILzNukUrC/1s/OXaONZCPUtdIvm9vSJB9BJ+OkqTD4Meh4k1eih/jAgRecFenuQhVWQo17Ls1QBpbKU+5ZygyXD1lOCqR7DAllwxcR0jrWD3ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsDfR47n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2492C4CEF7;
	Mon,  9 Mar 2026 23:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773099540;
	bh=WtKWn6qK1INg7feQ07zfye3cINCV/UdAMK1VoZjSJZ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XsDfR47nQYRdRxhgxzjZEDn02eHA6eEIulxQ4ytprPK6Er/oS8rLRfebIBtBJDL5D
	 f8di9yTzipnKWDhMJBoIeukZdYUvKwKUBB++kWVrsDaUtthtrHI7io5WQxt0ul59aj
	 JpI8O6Z0nEQkjIzOuGBVynSJHHUibWOYXOIPaqMSadGT0gJyTzXhOc1qf85yCYk4vP
	 u6SVv1Rt2nOzjVgb8FeHFx1Nqgs0XvObcT70ZyExtRC+MdFkAi+hXIamI9s+74xxsl
	 UpFoXupO232q0em2HeAinHSfcXwYXAKGd0Ak5V0S1HJ59cd1xev12qsNRi7WKP7BVa
	 TjMkhR1+Kv++A==
Date: Mon, 9 Mar 2026 16:38:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Wang <weibunny.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Daniel Zahka <daniel.zahka@gmail.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, David Wei <dw@davidwei.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Wei Wang
 <weibunny@fb.com>
Subject: Re: [PATCH v3 net-next 5/5] selftest/net: psp: Add test for
 dev-assoc/disassoc
Message-ID: <20260309163859.382968a0@kernel.org>
In-Reply-To: <20260309183454.2872967-6-weibunny.kernel@gmail.com>
References: <20260309183454.2872967-1-weibunny.kernel@gmail.com>
	<20260309183454.2872967-6-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DD133242B53
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,fb.com];
	TAGGED_FROM(0.00)[bounces-265798-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon,  9 Mar 2026 11:34:53 -0700 Wei Wang wrote:
> -    with NetDrvEpEnv(__file__) as cfg:
> +    # Use a different prefix for netkit guest to avoid conflict with dev prefix
> +    nk_v6_pfx = "2001:db9::"
> +
> +    # Set LOCAL_PREFIX_V6 to a DIFFERENT prefix than the dev prefix to avoid BPF
> +    # redirecting psp_responder traffic. The BPF only redirects traffic
> +    # matching LOCAL_PREFIX_V6, so dev traffic (2001:db8::) won't be affected.
> +    if "LOCAL_PREFIX_V6" not in os.environ:
> +        os.environ["LOCAL_PREFIX_V6"] = nk_v6_pfx
> +
> +    with NetDrvContEnv(__file__, install_tx_redirect_bpf=True) as cfg:

NETKIT needs to be added to the driver/net's config (it's only in
drivers/net/hw/config now)

Can we also add some code to handle NetDrvContEnv() creation failing
and falling back to NetDrvEpEnv() ? Skipping just the test cases
that need cont?

Last but not least let's use variants instead of the test builder?
-- 
pw-bot: cr

