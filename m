Return-Path: <netdev+bounces-276259-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LYnBoTI1WnA9wcAu9opvQ
	(envelope-from <netdev+bounces-276259-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 05:16:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9252E3B68BA
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 05:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8BDD301907D
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 03:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F9B2D23BC;
	Wed,  8 Apr 2026 03:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4wEImSH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C524C29B781;
	Wed,  8 Apr 2026 03:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775618066; cv=none; b=QTsQs6iPCo1K1Q5AyFGnGb+KXssP1WSLK51End4kRUhfQPoX5Sk7E2Ffq7+zdGLC9MEooaoXiioQcLiwj7FdaON4nFlOGF7Rf4JS0GBhbHIupfZ9iNhg32YvGyfykoVq8kTeshANmLYwJ7wq1a3HTSEDUahnNMzkJs+kvcJbVf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775618066; c=relaxed/simple;
	bh=obQJV6aXp3S3NHxyucEQz/cQ/FH/Acc129pdEXjDBr4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Apluv+7tmxk/9NgqAQTI2LVR1pjeQ5qFUVn26ar4as9pUiRKFeMJlzatOGAXZ+EkqDHVQBZ8mG7Dxp9lCVUWD4u0FikYyrCqnBh1c/Fa6A6OOmjSN4awwC3+A9qzjKPOM2XUGZDF5VjprBcW4tfss5pvkZqAONJFzol60Jclxns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4wEImSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A3EC116C6;
	Wed,  8 Apr 2026 03:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775618066;
	bh=obQJV6aXp3S3NHxyucEQz/cQ/FH/Acc129pdEXjDBr4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y4wEImSHtBt4l1leFwkkcA1G4Z+axvX7lgdXhTjGQyw0ExS3x5QpmxedlgtOmAtd1
	 5mYQNzeNzNCmq8Uzqce3T4tGQq6LC15bpedfvOzlUfYTZCiIYoeszSy5BwQ8rVgon1
	 7Bv8P0z0ml59SysqMk6nDkvvTUx3fZd8Jrjgf7re1Eg7AW42bPde5gpjljWqsOwUy5
	 tZHwGnt5oZsOf+d8ZxxzHLkLewndlfJUia9LudYwKT0AI3AUUY/hBWjSF0duWpb6L8
	 dhsTXK19evbp1uGH8HWQJOCzxB44Cb/1pgYo+ybNiPHvLZhhAc9oaEooCDCmwxleGL
	 eqo8iA16mNnzg==
Date: Tue, 7 Apr 2026 20:14:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, horms@kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 linux-kernel@vger.kernel.org, leon@kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [net-next v9 10/10] selftests: drv-net: Add USO test
Message-ID: <20260407201424.34c27d26@kernel.org>
In-Reply-To: <20260407220313.3990909-11-joe@dama.to>
References: <20260407220313.3990909-1-joe@dama.to>
	<20260407220313.3990909-11-joe@dama.to>
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
	TAGGED_FROM(0.00)[bounces-276259-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9252E3B68BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue,  7 Apr 2026 15:03:06 -0700 Joe Damato wrote:
>  tools/testing/selftests/drivers/net/uso.py   | 103 +++++++++++++++++++

It needs to move to net/hw now that we are not planning to carry
the netdevsim glue. Otherwise SW testing sees skips:

# ok 1 uso.test_uso.v4_partial # SKIP Device does not support tx-udp-segmentation
# ok 2 uso.test_uso.v4_exact # SKIP Device does not support tx-udp-segmentation
# ok 3 uso.test_uso.v6_partial # SKIP Device does not support tx-udp-segmentation
# ok 4 uso.test_uso.v6_exact # SKIP Device does not support tx-udp-segmentation
-- 
pw-bot: cr

