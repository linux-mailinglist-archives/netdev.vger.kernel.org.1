Return-Path: <netdev+bounces-297734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +ENgEliDKWpvYQMAu9opvQ
	(envelope-from <netdev+bounces-297734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:31:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3881366ACC5
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:31:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HS6PxtTg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297734-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297734-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 70EDF30FAC53
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3693E428470;
	Wed, 10 Jun 2026 15:22:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29644426EC5;
	Wed, 10 Jun 2026 15:22:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104955; cv=none; b=tiE4H94YPsoJUsY2yvyM4oGX5N3FCynPTIK792en7VBfiPvexPlwEQXjTOvAXlGVX93SrWBWn5n+5+7Kdsmwiktplqdh3ACAi0hjKBT47ptfjuxYnyFzAL80WRog74LD848HA1arVeIW4hCH8Yl1vtDvuXqLNKZcQG0vkN8Ny5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104955; c=relaxed/simple;
	bh=+JK8R/7VtnPPWu0kAeq9/YQZvg1IJIk8ICcVdv06DO4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k8+91zV6QVYuV4u1Xhigo1bwwh6ex9fZuDU5AtmhuAykB+PvtjcBiDrI10EmhE4XCxOSjtHXjLTk+yZ2rRxWMLSgjfP3M9IM4RxcTqDqfrLDQgqeDjDwX0r9eI24juJVSIFPKbilD3gHOjg6jVCJE2dbUqTqigiE5L+ee5pavfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HS6PxtTg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DB21F00893;
	Wed, 10 Jun 2026 15:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781104953;
	bh=1z+b6EFtad9PbYUN1KmvNW1k3GO6SZb8m9ge86o3v+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HS6PxtTgczGOj0boeuGs2k4xaiBszzZcoRNwdf9EDDPB/Ey5xslpVTfEUcFCNCpZo
	 pI1+arO84XD96jJQXZAmuUc8OC2IibcKcxkYy3biGS/8YFehKd0gWlNpwo2IhRJ0Ez
	 50BlnUgkQbqfXnYuO+Vatgi7H+/CP+ZIE4GPuzJH91m+AvCKQEeAtIE/SZ6DPKgrwk
	 HPo+UDK3Rhs2oRUO3D4ujt05fjM9zBSfS2U/3gW4X3AzKlgfDAcBBNp9/FiYzQaua7
	 17laYPwKaq+NfPyjJLK/dE9PD4AdFgm1mUOccEWYemf0NbuHOK+oSP9Q2pIaNLpk9z
	 myIuhPcmCvj6w==
Date: Wed, 10 Jun 2026 08:22:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 06/15] mptcp: pm: drop TCP TS with
 ADD_ADDRv6 + port
Message-ID: <20260610082232.50d2a31b@kernel.org>
In-Reply-To: <17ecf803-4ee9-4dbc-ae9f-34da6460b163@kernel.org>
References: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
	<20260605-net-next-mptcp-add-addr6-port-ts-v2-6-758e7ca73f4d@kernel.org>
	<17ecf803-4ee9-4dbc-ae9f-34da6460b163@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297734-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:martineau@kernel.org,m:geliang@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3881366ACC5

On Wed, 10 Jun 2026 17:13:54 +0200 Matthieu Baerts wrote:
> Hello,
> 
> On 05/06/2026 19:21, Matthieu Baerts (NGI0) wrote:
> > With TCP-timestamps (padded) taking 12 bytes and ADD_ADDR IPv6 + port
> > taking 30 bytes, the 40-byte limit for the TCP options is reached. In
> > this case, it is then not possible to send the signal.
> > 
> > To be able to send this ADD_ADDR, the TCP timestamps option can now be
> > dropped. This is done, when needed by setting the *drop_ts parameter
> > from mptcp_established_options. This feature is controlled by a new
> > net.mptcp.add_addr_v6_port_drop_ts sysctl knob, enabled by default.
> > 
> > It is important to keep in mind that dropping the TCP timestamps option
> > for one packet of the connection could eventually disrupt some
> > middleboxes: even if it should be unlikely, they could drop the packet
> > or even block the connection. That's why this new feature can be
> > controlled by a sysctl knob.  
> FYI, Sashiko's new comments about this patch [1] are suggesting issues
> when MPTCP is used in parallel with TCP MD5. But MPTCP cannot be used
> with MD5 because there is not enough space in the TCP options. That's
> why there is an explicit rejection when initiating the connection.
> 
> So I think we can ignore these comments saying that more options could
> be dropped, and the size can be negative.
> 
> https://sashiko.dev/#/patchset/20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d%40kernel.org?part=6

I'll probably pull today, but to explain the delay - Sashiko made me
read the code and while I think the reports are false positives - 
the option handling does not read like awesome code. So the series fell
down the priority list.

