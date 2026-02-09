Return-Path: <netdev+bounces-257961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHM7DXMFimluFQAAu9opvQ
	(envelope-from <netdev+bounces-257961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 17:04:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AD0112490
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 17:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4732B3008236
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 16:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E865537BE81;
	Mon,  9 Feb 2026 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAePo52Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68AC220F2D
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770653011; cv=none; b=EOQKnwRru51GGXRu7GJ6N1vOdU2HqYziur4+b7uxh02o0rHMT4vHOUuvwillHkpQeIXAVq/XvMX4JjyCtHoz5qPKj/wARDviRFld26VAbO4W/FVwdPuX51h8GlbyxlseVuMGoUYsbIRR7USRCwsPXmKO1Da7/ZWc0C3SdcYoUkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770653011; c=relaxed/simple;
	bh=Toc7k4xM9S8wGAw7kNYtytC8YDNqnxF/R9Te/CWhyCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVksYWR54cnlyj9lVPgzSDhCNIfiJ55pUdGhi+5llGHGBEpHB7n/BV08lnOW8vF1neA4QO8HFavg6Pwwuj0D/gXc3sJKqXX6Kn6MCncbDVUdSxuO64/5UzkFMwlus+4lVwedlixzBpTsu7DPCn7pMwRacL4cTPfpuPb5lzkIlic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAePo52Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83A1C16AAE;
	Mon,  9 Feb 2026 16:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770653011;
	bh=Toc7k4xM9S8wGAw7kNYtytC8YDNqnxF/R9Te/CWhyCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UAePo52QYrpmyj+YfmmO9KyqhGuWwLMvhQSWEmrl2KvI+tttCy4Dc8O6PE2r//2zB
	 MPbgvuq6wf0rnVeP0mqiftYHNOIZWLEsxBYjiC+BleQwMYoncajWR4+G/ba320T0E0
	 ghlQJZKvPIk+UMUSz7H0m0zxHBWXiEXRHhgo88AsiniRKnYK3Jd9Xpu1dqsYLEXXQH
	 qXla3aXchD9gVkievIH5WjFuDlYKX8rrXGcmKZQEuJZokhF4bl+50y9EDI/f/tTptP
	 +U677kT5Yo5wEeYB5OAGcM0STuFzIpRmpqZRkYobBZMdOvhUC4Z7CcqFwOBXouapH3
	 cvXCiDhi2KpwA==
Date: Mon, 9 Feb 2026 16:03:27 +0000
From: Simon Horman <horms@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: arcnet: com20020-pci: use module_pci_driver
Message-ID: <aYoFT0QgeixLRfKv@horms.kernel.org>
References: <20260205070632.37516-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205070632.37516-1-enelsonmoore@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-257961-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 86AD0112490
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 11:06:31PM -0800, Ethan Nelson-Moore wrote:
> The only thing this driver's init/exit functions do is call
> pci_register/unregister_driver, and in the case of the init function,
> print an unnecessary message. Replace them with module_pci_driver to
> simplify the code.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

I'm not sure that I see the value of cleanups to this driver.
Which hasn't seen much activity for a while now.

But I agree the change is correct.

Reviewed-by: Simon Horman <horms@kernel.org>

...

