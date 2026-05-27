Return-Path: <netdev+bounces-292009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCffAvM6FmpCjgcAu9opvQ
	(envelope-from <netdev+bounces-292009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:29:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC325DDF29
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7961E301547A
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280EC211A14;
	Wed, 27 May 2026 00:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKnsmo4b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2562127453;
	Wed, 27 May 2026 00:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779841749; cv=none; b=hzH5ynTTfnQ+HJGE02LebtSKzHNLzr7yT1+H0tt216Mf4cqNG1ncIrnQuazDUh/Hxry2EYVy3pyD7Nh+WG8avrpkpoSmDUj578V1Rz46TTYAcz/dQ1fVKvxDMCrXAtpfzHusEJIVOgUjWG+pzYLKexIVJQR2D/dDzbMkEWQzTaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779841749; c=relaxed/simple;
	bh=QtQXhD3FjA7lG+NqovvqFT7aX9bjY8XQu5/RLsllP1E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDMq93jATUXmFGAlU86T1xOgdFIsYVZvAx9Fq7CeePxYHRxvMEU62WOTtAb5ayZoRxzNfaSufJmIkgktyYst2qSm+SsVuYrlR1ITfgvFGEGlOBnjpB1yoTkofWnc1xlMD1CrhBeJum8RfSwxwwaYo2CCslS+PLmzctiNkViGMTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKnsmo4b; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1131F000E9;
	Wed, 27 May 2026 00:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779841747;
	bh=QtQXhD3FjA7lG+NqovvqFT7aX9bjY8XQu5/RLsllP1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QKnsmo4b/6zMV0mkv+rvST9R8KyPjyijjUILTQZqUKAVwWiLCoFQyDwhBSTnjxJFW
	 JDLqGjsK/Ycb3WgLeB4UeBz9wmvGgNNA42ND0U/DAOAMXx3aJ7TG5KpDzY+6sTLTBU
	 n3ddztZiNfSvts7dYkNe3aUXnecFuFMhTmFrNLiWm8knZKSa8KWJXkvSJ60BJi/dX2
	 Md38SwGrnHNG45m2QV0Az2trk137ahdLi7lkhO/Ywjz5y1/NNEi5qPJVdUS9sMAls5
	 aWOHhT8TcNXbP3SOTNpetqQS9SMyYF7UPWS6IdhNbyy5rCuDYFLwAtz1ZVVVGxzlUy
	 45ulIgfETU3sw==
Date: Tue, 26 May 2026 17:29:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next] net: fec_mpc52xx_phy: Add missing
 MODULE_DESCRIPTION()
Message-ID: <20260526172906.39128273@kernel.org>
In-Reply-To: <20260522233231.45609-1-rosenp@gmail.com>
References: <20260522233231.45609-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292009-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9AC325DDF29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 22 May 2026 16:32:31 -0700 Rosen Penev wrote:
> +MODULE_DESCRIPTION("MPC52xx FEC MDIO driver");

bus driver?

