Return-Path: <netdev+bounces-264435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDbABZSYqWm7AgEAu9opvQ
	(envelope-from <netdev+bounces-264435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 15:52:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B16F213DEB
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 15:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C469031FC811
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 14:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712AB3A8FF7;
	Thu,  5 Mar 2026 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/bYLO1b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E3B3A7F72
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721673; cv=none; b=Yji9Q0ukdo0NyLM0z/aBCnp6yam6RWD4AB14gr5I9rXJ7wv5gWHELZV+YNURNZTt3g1k6rUbgx+cLbNqOFNAbcIYmXD1bI46YnMiBpFqQs165Ex8PyCGEhSFtInDNEwPrOzAIJ9yXQO+ZG/3fkMwRJwvD5bpCBIz9qRQ8obbMc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721673; c=relaxed/simple;
	bh=29E5SYsL7g1a74W55CNChrjD/XSjGkHLYxTnYHb+NHE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tpklb6cftUYD2lDLknIX+qyn5pzvCmvgs9CtvL0Zh3azwCTNNALwQp0VTjU7kDxj4pzcR+uWYQnNpUTB10buHngzxDzeAmLVW+I7kdvm6RSdz4Rjg7AbihT9pk1UWTLJSsk9M2pkT4BqNv8PGh+yJ/s9tzDYskrlDrvTM6CJW88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/bYLO1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DE5C116C6;
	Thu,  5 Mar 2026 14:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772721673;
	bh=29E5SYsL7g1a74W55CNChrjD/XSjGkHLYxTnYHb+NHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J/bYLO1bXEDbCXGK3cjgxuxYa/k1sFXUzfav/feb9gSOe+Gy798Nt16Zalxsj6Zn/
	 2gUb+IDTC2lQBj8sd9A6BuEsa9rD0or3gBxq67RjIiAZU7GIU0Xfjid6flv3u+Sr4a
	 kPdVnzmTRrdguQyQCjXSz5hBD/zoonj+JZYkg/C5zWP+oJFFR7wVRVf4N+xLjc29HR
	 b4SasVFa81xgZlTpR+Vv/3OI9juccHy/+m4wL4GXs3RMHr2tcxKPJPxqa8DsAk0+M9
	 vLEpbjQRYTIU4UOtJSA2A0uqULytF9wbT/Pd+TTLe9YMUJrY4rliEyDElPBnmHVqjP
	 9+DA+SI3L230g==
Date: Thu, 5 Mar 2026 06:41:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Felix
 Maurer <fmaurer@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH RFC net-next 1/2] hsr: Allow to send a specific port and
 with HSR header
Message-ID: <20260305064111.13fe5e0b@kernel.org>
In-Reply-To: <20260305080731.xnJ0XtTX@linutronix.de>
References: <20260204-hsr_ptp-v1-0-b421c69a77da@linutronix.de>
	<20260204-hsr_ptp-v1-1-b421c69a77da@linutronix.de>
	<willemdebruijn.kernel.2d4b5c08dd442@gmail.com>
	<20260304145821.TQhzhhjF@linutronix.de>
	<willemdebruijn.kernel.1d699189fce58@gmail.com>
	<20260304161255.VV_7vPBw@linutronix.de>
	<willemdebruijn.kernel.1f5b6b3e8c22d@gmail.com>
	<20260305080731.xnJ0XtTX@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6B16F213DEB
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
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-264435-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, 5 Mar 2026 09:07:31 +0100 Sebastian Andrzej Siewior wrote:
> Let me redo this with the skb-extension variant. 

Expect opposition. HSR is an Orphan full of trouble already and what
you're trying to do very much feels like a one off hack to me.
Can't the Tx path be done with an egress redirect on the HSR upper?

