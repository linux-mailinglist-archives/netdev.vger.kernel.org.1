Return-Path: <netdev+bounces-275345-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDxQO4Lg0GklBgcAu9opvQ
	(envelope-from <netdev+bounces-275345-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 11:57:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7090139AAC1
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 11:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0D44309EA05
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 09:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559383AA50A;
	Sat,  4 Apr 2026 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jU84Vos1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9EA3AC0FC;
	Sat,  4 Apr 2026 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775296280; cv=none; b=e1Zfo2F3VuQE8LUrbMXOutYZgAJlihnw4eNj55ZWsvM6IkSGRrGupt1nWL5x8tjLwjJhjh8T9V8eVjUFP6plXsdW0Ggl7WKdjDC97IXU86iIPcte3gAWDs578cgFifGNNd4DhaiyPcYbNeRsnQlEFCgerT0D4eJx5KPI+kOBe94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775296280; c=relaxed/simple;
	bh=GT2OkmpXdpsGxUqki+l9pSr2rIet+DOLg+SkmYDTcas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGGa+u/7buiX4iM89leCn8tfkwV5EiriJgtBxles4wsbQKpd0iBU8UpURdP82jhe9n9fHFwnw8eJBEw2b3RHdtwIIzzDD12rAjxFIa3mVMzYKo64zdd6TmiV5EmOynZ7StIDnaW+Mq8Ur4wDjxLZ71ZbaSm5w2gzONoV6AgUsYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jU84Vos1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D67C2BCB2;
	Sat,  4 Apr 2026 09:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775296279;
	bh=GT2OkmpXdpsGxUqki+l9pSr2rIet+DOLg+SkmYDTcas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jU84Vos170YwL0dDyz9l3FejTLtBR88W9vbpiIkziMdItKEz/lSLygUA9a2lJ3A+g
	 FwkjUN1oRnu7OCn2KhO9hXmIcuWAsdE1viWNrJiQyCAE4W28dJzZddYIGN3ilGRmPm
	 AQW4onmj/ZTuyM74pqvkTS2IzLC6e7cocwijZX3H74xaMMG4pEcihX8P5LhAX5wyYQ
	 aTJhiS9u3yuzWukaExaYQxjSZt80Om5ZFlrL/Q3oRxU1GXfg7oVUPQwEk4AJ5P2BMa
	 ODH65S7vjDTAWfR6xYS8gYqCEZ2y949saBiinIvA3l1JzBuYA+VqY7s5t0XFB8BWCH
	 lG9ywbrGpPEww==
Date: Sat, 4 Apr 2026 10:51:15 +0100
From: Simon Horman <horms@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yousuk Seung <ysseung@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3 6/7] net/sched: netem: check for invalid slot range
Message-ID: <20260404095115.GZ113102@horms.kernel.org>
References: <20260402202037.176299-1-stephen@networkplumber.org>
 <20260402202037.176299-7-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402202037.176299-7-stephen@networkplumber.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-275345-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid,networkplumber.org:email]
X-Rspamd-Queue-Id: 7090139AAC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 01:19:34PM -0700, Stephen Hemminger wrote:
> Reject slot configuration where min_delay exceeds max_delay.
> The delay range computation in get_slot_next() underflows in
> this case, producing bogus results.
> 
> Fixes: 0a9fe5c375b5 ("netem: slotting with non-uniform distribution")
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Simon Horman <horms@kernel.org>


