Return-Path: <netdev+bounces-267457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG2hNhcWtGlkgwAAu9opvQ
	(envelope-from <netdev+bounces-267457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:50:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A287C2843AB
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6374430E7515
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 13:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1A4395D80;
	Fri, 13 Mar 2026 13:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWjdx58w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5737390CAC;
	Fri, 13 Mar 2026 13:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408680; cv=none; b=twKwn1Yy7YVs9bGIsJPw9cDrMwk//OVQtNCphjSzoMA7lJcTT91Q9O8q2O34Qlt74CWTO4OXBuvip4Pb7ybcy+9jBiAaYnZ1ZmIQXgqJO+mNg+qEYmkCcg9BJQDYF9M0foT+WUrqc3pdS6veRKNy9Rp+dLYroQNcABXsiRYbVSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408680; c=relaxed/simple;
	bh=rjDxboEbN9PBbRfJRIEBNS24aeg6irTXidxj5ateeII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b33C79n3AYIdLw0Md1H3rPhe0ksZK2J30ZlXLEBsi0M/bFm6SqRJPd3EGoQm6Gnwnk2ig8agSfjIAR4RCVBlUs2x1QaTwEfmsDhdyLj+HvlPwSxaivkWwRRAI16m9Y7e99iG3hSwu/6a0dVRioZoPdF2jnORUR+5oJOWq9CnmFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWjdx58w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FCAC19421;
	Fri, 13 Mar 2026 13:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773408680;
	bh=rjDxboEbN9PBbRfJRIEBNS24aeg6irTXidxj5ateeII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWjdx58wOVYhoSoJR4FcnGaavF+YH3YlsFNH428rWhwV0xwvYXeoC869SDVfXZwTV
	 k53lIQ2crmAWyD4Vq2fPYN8YQuTVYH8DI6zS1tR1CzNYAmfob+s2zJlrQWfRulxhd7
	 hZdlFqRNnD5avftUsauqGZR39Wb3yioCecz+S2tAttstBnRtH+aSno0VoWFHU3Dg++
	 2idSw6g9i9+IEUCcxJprhjvWvqrYsAabqzSXznSVLkYGSOZIUi6m308foPG42kniva
	 k8yuh6rGI1K0lbpatLeDoDhHh/jhKLTsd+hg27bIbr28jhSGSzYY1ey74u6ay6kpMo
	 VS9g4dUeIKZKQ==
Date: Fri, 13 Mar 2026 13:31:15 +0000
From: Simon Horman <horms@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Meghana Malladi <m-malladi@ti.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v2] net: ti: icssg-prueth: Add HSR multicast FDB
 port membership management
Message-ID: <20260313133115.GY461701@kernel.org>
References: <20260311082923.2962937-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311082923.2962937-1-danishanwar@ti.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-267457-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ti.com:email]
X-Rspamd-Queue-Id: A287C2843AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 01:59:23PM +0530, MD Danish Anwar wrote:
> In HSR offload mode, multicast addresses can be added via HSR master
> (hsr0) or directly to slave ports (eth1/eth2). The FDB must track port
> membership: P0 (0x1) for HSR master, P1 (0x2) for slave port 1, and P2
> (0x4) for slave port 2. When the same address is added from multiple
> paths, memberships must accumulate.
> 
> Implement a hybrid approach using __dev_mc_sync() callbacks to track
> basic add/delete operations, checking netdev_hw_addr->synced to
> distinguish HSR-synced addresses from direct additions. Post-process
> to handle overlapping memberships by checking refcount:
> - refcount=2 with synced=1: HSR only (P0)
> - refcount>=3 with synced=1: HSR + direct (P0|P1/P2)
> - synced=0 with P0 set: HSR removed, clean up orphaned P0
> 
> On add operations, accumulate new membership with existing ports. On
> delete operations, remove only the specific port and clean up orphaned
> P0 bits if needed.
> 
> Add error handling for icssg_fdb_lookup() which can return negative
> error codes (e.g., -ETIMEDOUT). On lookup failure in add/delete path,
> default to no existing membership. In the post-processing path, skip
> the address update to avoid corrupting FDB entries with garbage values.
> 
> VLAN Interface Handling:
> Add support for multicast addresses added to VLAN interfaces on the HSR
> master (e.g., hsr0.7). These addresses require P0 (HSR master) bit to be
> set along with the port bits, since VLAN-tagged packets use separate FDB
> entries per VLAN ID. Without P0, the HSR master would not receive
> multicast packets on VLAN interfaces.
> 
> Track whether the add/del operation came from a VLAN interface path and
> set P0 when in HSR offload mode with VLAN interfaces. Update orphaned P0
> cleanup logic to preserve P0 for VLAN interfaces.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
> v1 -> v2: 
>    Added a helper function as suggested by Simon Horman <horms@kernel.org>

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

It is unclear to me why this is marked as Not Applicable in patchwork.

