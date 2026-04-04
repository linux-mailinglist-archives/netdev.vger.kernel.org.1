Return-Path: <netdev+bounces-275394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /YWbGHsr0Wm2GAcAu9opvQ
	(envelope-from <netdev+bounces-275394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 17:17:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A770439B8D1
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 17:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B69603009144
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 15:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB541D88D7;
	Sat,  4 Apr 2026 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RFy3XOyP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D127D7263B
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775315832; cv=none; b=KbVixQ2kZpNDmZ+ZoFxuRtdSXLMNz2pOFuJuTURAHO6U+7BWW2A9Rbcr307k8KC+R9998tWNkDgULSI2te2EcqGQU0BBinVUx0Gd+oTSUtkYRFl7Y+AxwNhP2/8xj7oXScDLyAbOD9Gm+MLAC26vYUmtCCxvxNCvbOAMeZSAPcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775315832; c=relaxed/simple;
	bh=+51q6A0cfXZOdKliwTTVirznNCT5gp7G8odWViyC4pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnE1dXSikWfwbg0KX58N2KmlVvHaky+JnuzJRrQpFej41Yn5P0uv6yq2tmQAatvtH0VCZC3WxvNPfKt3gtj6k0SQ8b8RaHgSMg+uR6GyGrv+UjM3UaB70sVWg4gyFZuk7BuUrnIGwujnKIdAFQOH0NjP7Embqqzb0z+EBP2HXxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RFy3XOyP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lqvtuckNsAKw8rGZiSrTOibKTVZsRAv6ga6pEf3iUUY=; b=RFy3XOyPtko3v/FHxztoFyLZn4
	3bdSa5eMgi7SkSnBmzrikK6OAbPWN/2q0sU65lsuJsY5rAYioG/FBb/6hR+PVmvtvY6lT0WiGE88j
	zdTku6fFVGq0V2qYUJrxoUN1762XQtMSvyOsj3/0BZOQ3KKAcV6Fbf3Hq9rrT4AENnLc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w92kA-00En0T-MK; Sat, 04 Apr 2026 17:17:02 +0200
Date: Sat, 4 Apr 2026 17:17:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Carlier <devnexen@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Qiliang Yuan <realwujing@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2] treewide: use get_random_u{16,32,64}() where
 appropriate
Message-ID: <ad03ee49-7c8d-4582-b566-612a132cda84@lunn.ch>
References: <20260404120043.85411-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404120043.85411-1-devnexen@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275394-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,suse.cz,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: A770439B8D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 01:00:43PM +0100, David Carlier wrote:
> Use the typed random integer helpers instead of
> get_random_bytes() when filling a single integer variable.
> The helpers return the value directly, require no pointer
> or size argument, and better express intent.
> 
> Skipped sites writing into __be16 fields (netdevsim) where
> a direct assignment would trigger sparse endianness warnings.
> 
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  drivers/block/drbd/drbd_main.c                   | 4 ++--
>  drivers/block/drbd/drbd_nl.c                     | 2 +-
>  drivers/gpu/drm/i915/i915_hdcp_gsc.c             | 2 +-
>  drivers/gpu/drm/xe/xe_gsc_submit.c               | 2 +-
>  drivers/md/dm-vdo/indexer/index-layout.c         | 2 +-
>  drivers/net/netdevsim/psample.c                  | 4 ++--
>  drivers/target/iscsi/iscsi_target_seq_pdu_list.c | 2 +-
>  fs/ext2/super.c                                  | 2 +-
>  fs/ocfs2/super.c                                 | 2 +-
>  net/ceph/auth_x.c                                | 2 +-
>  net/core/net_namespace.c                         | 2 +-
>  net/mac80211/mesh_plink.c                        | 2 +-
>  net/mptcp/subflow.c                              | 4 ++--
>  net/openvswitch/flow_table.c                     | 2 +-
>  net/sctp/sm_make_chunk.c                         | 4 ++--
>  net/tipc/node.c                                  | 2 +-

Hi David

You are more likely to get this merged if you break it up per
subsystem.

    Andrew

---
pw-bot: cr

