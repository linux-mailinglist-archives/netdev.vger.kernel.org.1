Return-Path: <netdev+bounces-289682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKUXMGUKDWrysQUAu9opvQ
	(envelope-from <netdev+bounces-289682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:12:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E0E5867A2
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77244301C896
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 01:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0434F2D0C64;
	Wed, 20 May 2026 01:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxQG8uxn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75292D12EE
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 01:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779239522; cv=none; b=WZlutrsUIbiqejb0VJnMn/S8WEq0C0XMIft/kDzP+ol4G1W5HoChPz9VzVRjuolfd17P11mBbPe7LA8BeqHsw6rRujW0XqRPgHSX1ckPx+mKpcuTQiEBoR/O/kuv9fo2ZYy1zac2IFKil36vXNueI76+S1DW693yBcgmdO0M+yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779239522; c=relaxed/simple;
	bh=q+VFLmb8Pf+p01sgBgpVyXRz6gKOXrysxbmqBSJmS9c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9QU62REObXjdjenm/EFHKw2GWs36ZJvVJc5Kpoecw5G/nJej1LBqRC0hDCElx2F5kqqwXqbilKjJ3jkHGzgqGYzQorQlCs16dnKZsrIBgZ7+iCknd+F/95+8YJ4BAXqm47eDBmXnxPuJaYvM/3kiMMh+hXXtm2ns8vI6uh6ppc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxQG8uxn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA4C1F000E9;
	Wed, 20 May 2026 01:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779239521;
	bh=RXjciv/smbfDlLKxHKDduzDJAPxz8iSSxd4Vmr0Np3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cxQG8uxnKFdT20NXCJ8sr6DRvXA7ojjyo2s8giPNEamwzLgi8mH26hr4uCj9/3Pdt
	 2KY0hzvjZC/sxn6qX8HfmfYMlcDKsCMZKw8/x5537w6tFcxQXax+V+yr8FI5Ec0QlQ
	 yIhxEqOcQXfUcvX4fwIBMGzJY96zF4QvkA7GV1tQqgKzVkLkX8v44Dcz0WGk1fG4qm
	 DLQyMtHeDQpV/B+XqD0JZgjCcRDyJDqnE90VFxM4F3vPk05lkDBTljT68qtLTxU6RC
	 DULJNAVLc5w9Yaf+Cht7U3JijDTNADdjGv38I1aj0ij6WOFU3JIn8ngbIrq9L1dIjK
	 hh6u5OOe52AHQ==
Date: Tue, 19 May 2026 18:12:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>, "Willem de Bruijn" <willemb@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Simon Horman
 <horms@kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, "Alice
 Mikityanska" <alice@isovalent.com>, Matthew Schwartz
 <matthew.schwartz@linux.dev>
Subject: Re: [PATCH net v2 2/2] udp: Fix UDP length on last GSO_PARTIAL
 segment
Message-ID: <20260519181200.323fbaef@kernel.org>
In-Reply-To: <20260518062250.3019914-3-gal@nvidia.com>
References: <20260518062250.3019914-1-gal@nvidia.com>
	<20260518062250.3019914-3-gal@nvidia.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289682-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 49E0E5867A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 18 May 2026 09:22:50 +0300 Gal Pressman wrote:
> +	if (!skb_is_gso(seg))
> +		/* last packet can be partial gso_size, account for that in
> +		 * checksum.
> +		 */

No need to repost but I think we should tweak this comment.
Saying "partial gso_size" when it such segment is in fact
not part of GSO_PARTIAL is a bit confusing. How about:

	/* Unless skb fits perfectly as GSO_PARTIAL, the trailing
	 * segment may not be full MSS, account for that in the checksum
	 */

?

