Return-Path: <netdev+bounces-269274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAK4Mh9iu2lujQIAu9opvQ
	(envelope-from <netdev+bounces-269274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 03:40:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 647F82C50F8
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 03:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D8D83301BA93
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF616387345;
	Thu, 19 Mar 2026 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZxqH/KI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4FE386C02
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773888029; cv=none; b=lpF6jZnUto/RkivP/OHNLx2pIpl//nIRTTDpfbzK0NWEeVqr2sOU1R13JrqHOeSYnEykjvF9R1HYWnV6R/bMZabKaBWWHJOyRRfYYQFKvJz0loC0AC8zKQEtqUTeMH5CS8VAZEo2xp+a9w5DcDtIZtmBL9iBX1XFQR6fkHCWIIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773888029; c=relaxed/simple;
	bh=H5RLHeJWH+I9uF37gYvFq+eFJ7VDw83fsojnhLOWIw4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kvj/RDiy+FnTVRdY6BOjt60vzHEHR5I9YmFIKjPxeYYVyDERUbWn1H8MTQeeWpJCJjPJcm78R1xc2oNZBzdUzhshbDPX6wU9bA8QH0qTkBQ0AN0cxQWnAGXg2qXZHjOu1njOZWAf8ENLtGzDQxkk2a9bwepjLEeeCmIUF+1CBig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZxqH/KI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD68AC19421;
	Thu, 19 Mar 2026 02:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773888029;
	bh=H5RLHeJWH+I9uF37gYvFq+eFJ7VDw83fsojnhLOWIw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tZxqH/KIoVzs0mOfpKcWy4GZyRRYJnGSnUSqJlhGXJSWUzFNVDqfp0FJGOTK7+H2J
	 O9SW3+sighNOVlNh23CnxkPTB45Q2xj5qZrT0c920OZSXlqU3PSlpkctZji6IRYwiF
	 ltnzrhu0w7DgxssmfhoKV8ZvKoXa3w+uVt/2Zba017a8tFfCtVFLPLSVylVJrgX2LG
	 47t48s9iHovaraFY8GFEDIHD5NTlThhV1zltf5MFz742cTs3WWGjW/sP9TsrRPaarR
	 hWEqonRcwuJEJIQczriiayu3/cVGW5aFiHw0bN+WTWGSJ8VddVOsRcwyWB4kS6uuh/
	 qSurNxcnBq6XQ==
Date: Wed, 18 Mar 2026 19:40:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Wang <weibunny.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Daniel Zahka <daniel.zahka@gmail.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, David Wei <dw@davidwei.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Wei Wang
 <weibunny@fb.com>
Subject: Re: [PATCH v6 net-next 5/5] selftest/net: psp: Add test for
 dev-assoc/disassoc
Message-ID: <20260318194027.12c23a4b@kernel.org>
In-Reply-To: <20260317235222.700615-6-weibunny.kernel@gmail.com>
References: <20260317235222.700615-1-weibunny.kernel@gmail.com>
	<20260317235222.700615-6-weibunny.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,fb.com];
	TAGGED_FROM(0.00)[bounces-269274-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.918];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 647F82C50F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 16:52:18 -0700 Wei Wang wrote:
> +    # Test connectivity in both directions before PSP operations
> +    remote_addr = cfg.remote_addr_v["6"]  # remote peer address
> +    nk_guest_addr = cfg.nk_guest_ipv6     # nk_guest address

ruff check says:

tools/testing/selftests/drivers/net/psp.py:22: [F401] `lib.py.cmd` imported but unused
tools/testing/selftests/drivers/net/psp.py:418: [F841] Local variable `remote_addr` is assigned to but never used
tools/testing/selftests/drivers/net/psp.py:419: [F841] Local variable `nk_guest_addr` is assigned to but never used
-- 
pw-bot: cr

