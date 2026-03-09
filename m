Return-Path: <netdev+bounces-265565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCxnAn7VrmlhJAIAu9opvQ
	(envelope-from <netdev+bounces-265565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:13:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD7F23A539
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36FD9308A406
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 14:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515D33CE49E;
	Mon,  9 Mar 2026 14:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQ9QDWKH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2BF3B9605;
	Mon,  9 Mar 2026 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065511; cv=none; b=jELjAaKZ1K2nyh5dcNaWe/ycBgCMPKE+LpW5CMdJ2SL0OQC5mzuAW5wEQ3y+MsM7UjZ8TSMYMmBnYYT7BHrt5//o10X+UesCNS4kUDQUFy7tLja+IaRZ12hymBk1mn758ZgW0F/QEKJk/E3k4fdRVFnCARQrX4sENxA/UYF8VWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065511; c=relaxed/simple;
	bh=eU3p9YG5GnWj0CimWx09QBU2c22dNqQdlfhvs6jTrCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oa8YJv+fKWUN+HLngTTvDk01dTiuwmQKl6Dk8PJcThICcArpHiHK1vfDQeAOiNSAEVReH5VRlrx4mQTxzmj+bE2zimd4KzFUbF2/pwxl2YljIhf0OWiUF1JUOakjFQbokotyAjN6v03/4vjyG70iSzOgldLIpcc0xjZu0YB5in4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQ9QDWKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D789C4CEF7;
	Mon,  9 Mar 2026 14:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773065510;
	bh=eU3p9YG5GnWj0CimWx09QBU2c22dNqQdlfhvs6jTrCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AQ9QDWKHBsALDsFDu+FCDUGjGJQiCXlQr1xtTVG9N3bn7d3Pi4i9BFYVHPC7FwRGD
	 aNVP+dlyfmorKMEQUyV1tsXJYkg3LjdZDkBw9PrabWG3Xx/clUt4JYHO38m1o/beVv
	 OYay9BxCYGCxQSMkt5tB9TBbfNmHsutbFGaDqi3X4CN2K4n68Whe/N3cts23tKZFaV
	 w+a1lYg/YlcxHtt6LEtYLJRziT6dj5b1317DlhTIoEqSCioRDSVu9eRfZ/KCEJlpq4
	 abDpNFn7CRndEsJz77lp7yRQft7jOk7GGa8ZoCA9xoNmOFmScFDdO8CwTOlv7L8eMl
	 UlZcKEcIYZybQ==
Date: Mon, 9 Mar 2026 14:11:45 +0000
From: Simon Horman <horms@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Meghana Malladi <m-malladi@ti.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next] net: ti: icssg-prueth: Add HSR multicast FDB
 port membership management
Message-ID: <20260309141145.GI461701@kernel.org>
References: <20260305125251.1828326-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305125251.1828326-1-danishanwar@ti.com>
X-Rspamd-Queue-Id: 5FD7F23A539
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-265565-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ti.com:email]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 06:22:51PM +0530, MD Danish Anwar wrote:
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

Hi,

This patch is doing quite a lot.
I understand that there is a relationship between those things.
But I am wondering if you considered breaking the patch up.
Or is there too much interdependency going on?

> ---
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 233 +++++++++++++++++--
>  1 file changed, 217 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c

...

> @@ -1077,8 +1191,95 @@ static void emac_ndo_set_rx_mode_work(struct work_struct *work)
>  	}
>  
>  	if (emac->prueth->is_hsr_offload_mode) {

In a similar vein, this condition is now doing a lot:
about 90 lines more than it used to.

I'm wondering if you considered placing the new logic in a separate function?

...

