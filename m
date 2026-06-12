Return-Path: <netdev+bounces-298806-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3CM5ImOMLGrNSQQAu9opvQ
	(envelope-from <netdev+bounces-298806-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 00:46:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E557667CE00
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 00:46:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MqIpblb0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298806-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298806-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C832300B57F
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 22:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244993D412E;
	Fri, 12 Jun 2026 22:43:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D2A36E48C;
	Fri, 12 Jun 2026 22:43:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781304238; cv=none; b=EdpsGCkSVtOVhm5BD+EB9jMXRFxdtXvJMbXK58UlglW5+bDrLHPvqE6zBtAh+HY4sogX/YUlB+qFv6qPMTLc4jZYieTJD8ZYsoYMK9VDfTScyLO1HXtiJYEw0jC0/gm079OZGW9Ah7LBxnIXfc8OgupJbPZhY5NfGHly1SP1+zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781304238; c=relaxed/simple;
	bh=T35Si9CnEdYuTGRZL8UJRLUR2/bBJ/8hSaxdwXr+WtE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6Smmp8b7+Lnqb4Mmf/+FZn9DLQMi+8Pt0SulhzfyHtd/HuTqwEjEXRqeH4o9XAANMeZXkZU//vNEstiDi9oiyAMvVQg06A5wqz0eA22F+3wBfot5+2UrrIJaPGXiMUMaXSJbco7xG2XCgFi3IJ3vXHJVaYSXqMKhZDwuEjv/X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqIpblb0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0A51F000E9;
	Fri, 12 Jun 2026 22:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781304236;
	bh=AmodO/H1wG/sjuRZupj+eYJxani2PIRdvwql/4iS23o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MqIpblb0ZFcdo/OqrGOSIg4cuBtRsGx2cV4arNg61QJmJBZ1nUo9V06VXlDDO81W3
	 o3ZS0ZMV9FuGKF9AVSNZg7HJFrvV0B5LI+IByMrzDVKfYH/c+kXhq8PoeL4KvtWdys
	 qelwW9oRFKl4Gszr3hBqzzdna6VQULW91j25VrTVhCqqvGeuCnBbTTmED1nijzucGd
	 5rOSpeJVzwKOXZ79Tjfp0DiRmeH2OzU+TF1JlMlyL4roLahohDh/CR0cnZFy9ntL1Z
	 P9HG4WUn51FRejkT3RPJdLvimRUgAv42nir+jWeytGVNVm0ryGl6qaZPusX+DBhrdX
	 nfbFbvKcOxR8w==
Date: Fri, 12 Jun 2026 15:43:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>, Eric
 Dumazet <edumazet@google.com>
Cc: gmbnomis@gmail.com, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tcp: tighten the FIN exception in
 tcp_sequence()
Message-ID: <20260612154355.37bb426d@kernel.org>
In-Reply-To: <20260610-tcp_fin_more_restrictive-v1-1-eefc30d7ddd8@gmail.com>
References: <20260610-tcp_fin_more_restrictive-v1-1-eefc30d7ddd8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298806-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:devnull+gmbnomis.gmail.com@kernel.org,m:edumazet@google.com,m:gmbnomis@gmail.com,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devnull@kernel.org,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,google.com,davemloft.net,redhat.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,gmbnomis.gmail.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E557667CE00

On Wed, 10 Jun 2026 00:09:24 +0200 Simon Baatz via B4 Relay wrote:
> From: Simon Baatz <gmbnomis@gmail.com>
> 
> Commit 1e3bb184e941 ("tcp: re-enable acceptance of FIN packets when
> RWIN is 0") added a special case in tcp_sequence() to mirror the FIN
> exception in tcp_data_queue(), which accepts bare in-order FINs even
> when the advertised window is zero. That behavior is not
> RFC-compliant, but was introduced in commit 2bd99aef1b19 ("tcp: accept
> bare FIN packets under memory pressure") to break tight FIN/ACK loops
> caused by broken clients.
> 
> However, the condition added by commit 1e3bb184e941 ("tcp: re-enable
> acceptance of FIN packets when RWIN is 0") is broader than required
> and allows other non-compliant packets as well.
> 
> Tighten the tcp_sequence() FIN exception to only allow packets where
> the packet is a bare in-order FIN and only the FIN flag extends beyond
> tcp_max_receive_window(). In particular, this exception is only
> reachable if tcp_max_receive_window() is zero. Otherwise the packet is
> already accepted by the normal sequence check.
> 
> The existing packetdrill test tcp_rcv_zero_wnd_fin.pkt exercises this
> behavior already and does not need to be changed.
> 
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>

This is odd. You are sending this patch which shares a lot of
similarities with Eric's patch:
https://lore.kernel.org/all/20260608151452.706822-1-edumazet@google.com/

Why are you submitting your own patch instead of discussing it further
with Eric and letting him send v2?

Eric, how would you like to proceed?

