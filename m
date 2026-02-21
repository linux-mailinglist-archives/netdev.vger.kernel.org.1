Return-Path: <netdev+bounces-259802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sB8RJMb/mGmmOwMAu9opvQ
	(envelope-from <netdev+bounces-259802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 01:43:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD5416B964
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 01:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFD47302AD3D
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 00:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75193074BA;
	Sat, 21 Feb 2026 00:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAYwSMFu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90883E573;
	Sat, 21 Feb 2026 00:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771634626; cv=none; b=cpGxnheaoK43QXGPsiZj1k1fsEjF1Iq0gkPl9V5UnNdCDhxPVOiAwf4bYeFcxLiBsXTbx89RS2cfWSbqKm6MnsxgzNf2+V+CO0J6V1wRgT48i3afBsdmyETs4ZHof+6wymUlZlk6jt2ewze7bmUau6mHRmO7Uvbw0n8dEj2Yk60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771634626; c=relaxed/simple;
	bh=ni4lmMR1qwcH0aTAzZas8Lc7RHRQIG+P83jf/meWNO4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G23YZn9YVy84tg89TE11Q9lwVpplp8XIFfY/hD8lP2A9/pVq/qJlRWIVAN1DoIaMxUv+OdmZ7QCm1gEekBpww3bT11q5snP11EBfMIGaGH00fEBH5dyUqWpIKX5bq6NmzIZF2TZiJHdnJKcduhCbOw4+erwJpkKU8GT0iLESV4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAYwSMFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB220C116C6;
	Sat, 21 Feb 2026 00:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771634626;
	bh=ni4lmMR1qwcH0aTAzZas8Lc7RHRQIG+P83jf/meWNO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EAYwSMFuTJ+3d2SzzaaQyqEAQLaazsbnnfOqgseOKb5bvLcK/82v9Qg6Fg2+GS8Ur
	 /hg5m2b5ZMrawY8bmSrNuUHezIUYPv0L6lgKBCdCEhHc7nU0Y8lNOIcMSo5uEncfMs
	 kk6zkO4ybpt92zq4NPLuJ8WcRczysrW4kxkNYrDQnhexerrD2Eu2U5xp89B6uo6Q7S
	 gliaHxfyL+dsyjlfMT4ZkphFb4lsXXpTh1UOVcq0+tDBAJDSQVAGyiWSFYPjwiqI07
	 60us8YdwgyBxOtO+oPBi0w71JolstmKQy4CGtzCWmUuIDCD+RI6GeJqV+yIo5RpS1B
	 hZWIj98jrUAsA==
Date: Fri, 20 Feb 2026 16:43:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gabriel Goller <g.goller@proxmox.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] docs: net: document neigh gc_interval and
 gc_stale_time sysctls
Message-ID: <20260220164344.68ab2a6a@kernel.org>
In-Reply-To: <20260219162200.510325-1-g.goller@proxmox.com>
References: <20260219162200.510325-1-g.goller@proxmox.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-259802-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3AD5416B964
X-Rspamd-Action: no action

On Thu, 19 Feb 2026 17:21:58 +0100 Gabriel Goller wrote:
> +neigh/default/gc_interval - INTEGER
> +	How often the garbage collector for neighbor entries should run. This
> +	value applies to the entire table, not individual entries.
> +
> +	Default: 30 seconds

AI suggests that this value is not actually currently used
in our implementation. I can't find any use either, TBH.
It's read and can be written but it's seemingly not used for anything.

> +neigh/default/gc_stale_time - INTEGER
> +	Determines how long a neighbor entry can remain unused before it is
> +	considered stale and eligible for garbage collection. Entries that have
> +	not been used for longer than this time will be removed by the garbage
> +	collector, unless they have active references, are marked as PERMANENT,
> +	or carry the NTF_EXT_LEARNED or NTF_EXT_VALIDATED flag.
> +
> +	Default: 60 seconds

AI adds:

  Important caveat: This check is only reached when total_entries >= gc_thresh1
  (line 1000-1001). Below that threshold, the periodic GC skips the scan
  entirely.

If true I think we should mention that ?
-- 
pw-bot: cr

