Return-Path: <netdev+bounces-273827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IgUAet5zGnrTAYAu9opvQ
	(envelope-from <netdev+bounces-273827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:50:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8088A373906
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D451C302DB7E
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 01:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A1E2882D6;
	Wed,  1 Apr 2026 01:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAZX7zUf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D550013FEE;
	Wed,  1 Apr 2026 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775008229; cv=none; b=l7Q8Wsj+PPo/072Zr5/pd4wScjBD/oh2OE4vSzfo2L5G8irB6CsDATqO4wrc5tOBspryVnCNLKdgac8ZBMhFoO7cai6PdpwaClYLs4wWRjCIcvZNQNbB8Lltpguf66hyFXpHQAHvSQeXbFCuWnga3XcaCJgKRoNVFeZDinX+GGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775008229; c=relaxed/simple;
	bh=zF+IwgsMlWdbcS4YI7VuKc9Odl/LNhRXN+v/URS4t3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUsquZ15e2U2mlsdpqodROGB0SauNRag4Ml0kEeMJCysaHdjsx87/sIvGTxZPKMND4k7wj8MRuwQL6ji6zdCayFevfrvmfmBeb5+BPvyoIzVnXFjdfs231wXu23SCd/vaG+4K31chLOW9PWxT6KkfaG/Wrl12oA3DejWl1SXJKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAZX7zUf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7F4C19423;
	Wed,  1 Apr 2026 01:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775008229;
	bh=zF+IwgsMlWdbcS4YI7VuKc9Odl/LNhRXN+v/URS4t3Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IAZX7zUfRFxlOSNmSSyXBbHF63z1mcbWHF68z3T03XnfRp+KMI7g/ovY53Y1Xxoi3
	 ads6Q9O9F7SHabqITSawwwijruJlKd0RBNBIe34Jkg6f8UkVgMAHOWUlsGQfgK8bo+
	 0Dd82fNZAMXq8mGMR0W+kJiWAy1eiAzN/OrsXkRRpkM0qzZ+RuOdZ/gEj36mYmL0QL
	 4pq4kWqmS7N6Zyx0R7sd0NgPnZCTrkgvFXwadM8HywjxQEgf976y6x2GDEMaRP3omE
	 om4OGm/HYbd2+6XSCfm/z5LIrRrqi2D4krqDEiZQEPl1u1veQsLisTKtKYezrcMJtB
	 TIayPekWR3aPA==
Date: Tue, 31 Mar 2026 18:50:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] tools: ynl: ethtool: use doit instead of
 dumpit for per-device GET
Message-ID: <20260331185028.45dffe3a@kernel.org>
In-Reply-To: <20260331-b4-ynl_ethtool-v1-1-dda2a9b55df8@gmail.com>
References: <20260331-b4-ynl_ethtool-v1-0-dda2a9b55df8@gmail.com>
	<20260331-b4-ynl_ethtool-v1-1-dda2a9b55df8@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,lunn.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-273827-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8088A373906
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 11:56:11 +0800 Hangbin Liu wrote:
> +++ b/tools/net/ynl/pyynl/ethtool.py

We have converted all the samples to selftests so this script is 
the last piece of random "PoC" code we still have laying around.
Should we also move it to tests/ ?

If there's a reason to keep it as is -- could you please add that reason
at the top of the file for my future self? I'm pretty sure I already
questioned this script in the past ;)

