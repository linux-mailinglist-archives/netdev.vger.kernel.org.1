Return-Path: <netdev+bounces-256766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMUKONR0g2mFmwMAu9opvQ
	(envelope-from <netdev+bounces-256766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 17:33:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF4BEA4A4
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 17:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74056300CA32
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 16:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7832F25EB;
	Wed,  4 Feb 2026 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUyGXZd7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5F62D061B;
	Wed,  4 Feb 2026 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770222797; cv=none; b=VUgVG8yc2CHFjVebaMKfZeORw/vVOnD7Qzx5JkxWuEoHqUVsrbVJ5HjbIwZjpwWvVYPduiWm5VqRuA8fkJ5wB/AaIrNZJSALNQc5cUZk2b0E9aIkly4aXVq3di9WdP0OfoCJygukJvM4/qd2QM05t09IyzBHJB0kfPn/NwNnLYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770222797; c=relaxed/simple;
	bh=vGUdrP9f8bzyMrk2MhQOk5OCdnX7t/LoR9oHraUNTvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=husK6nVJSYMq1k53T/7DNnARmoxQjiyysjJmuQi25nXFgjt0SuHHFcTpYp+WhhNZpGFMmgW2l+1p920M87FrYBztSn9e/k/eJ3IXUJUsml2H4xLCFGq/NZ6gDRHKDEj7cEm97k3MJ7YlipWGnsJU3GrHKkIho8iSfyBYZf7fj1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUyGXZd7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE50C116C6;
	Wed,  4 Feb 2026 16:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770222796;
	bh=vGUdrP9f8bzyMrk2MhQOk5OCdnX7t/LoR9oHraUNTvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oUyGXZd7nCw58nsV+VJcuJ9CM9+gbjOJU3fst9huZsh/834chl7BkBj5HPNHFqKfb
	 jDg5wH48KKBHUPkhgHo+Odf0QG0EyF+bjlXCQR7wM9HZeI00Pqxe+5RVUZlhZfQ1Px
	 EwvNOQlLo42iPZECRVvCjNIsflWzbso/dNRe1RLId2oVJ9psUKeIUwdc3TAcMjPuTM
	 F04A2ALyINa9fTVD0/X+L5P+UzjYEU0KmMjTsfhW8bHAvNI+vRxnIckerIGu75/wDz
	 EPVsadjDBXdbxtrwP1yPThPoS9Sda8CmE7xagMaJJrxGBeBVeF0xw/qo/BFzOhdqqq
	 iosHNhxhmZ52g==
Date: Wed, 4 Feb 2026 16:33:10 +0000
From: Simon Horman <horms@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com,
	rogerq@kernel.org, pmohan@couthit.com, basharath@couthit.com,
	afd@ti.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, alok.a.tiwari@oracle.com,
	pratheesh@ti.com, j-rameshbabu@ti.com, vigneshr@ti.com,
	praneeth@ti.com, srk@ti.com, rogerq@ti.com, krishna@couthit.com,
	mohan@couthit.com
Subject: Re: [PATCH net-next v13 0/3] STP/RSTP SWITCH support for PRU-ICSSM
 Ethernet driver
Message-ID: <aYN0xmOIaHeAvWNI@horms.kernel.org>
References: <20260130124559.1182780-1-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130124559.1182780-1-parvathi@couthit.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-256766-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 8AF4BEA4A4
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 06:13:42PM +0530, Parvathi Pudi wrote:
> Hi,
> 
> The DUAL-EMAC patch series for Megabit Industrial Communication Sub-system
> (ICSSM), which provides the foundational support for Ethernet functionality
> over PRU-ICSS on the TI SOCs (AM335x, AM437x, and AM57x), was merged into
> net-next recently [1].
> 
> This patch series enhances the PRU-ICSSM Ethernet driver to support bridge
> (STP/RSTP) SWITCH mode, which has been implemented using the "switchdev"
> framework and interacts with the "mstp daemon" for STP and RSTP management
> in userspace.
> 
> When the  SWITCH mode is enabled, forwarding of Ethernet packets using
> either the traditional store-and-forward mechanism or via cut-through is
> offloaded to the two PRU based Ethernet interfaces available within the
> ICSSM. The firmware running on the PRU inspects the bridge port states and
> performs necessary checks before forwarding a packet. This improves the
> overall system performance and significantly reduces the packet forwarding
> latency.
> 
> Protocol switching from Dual-EMAC to bridge (STP/RSTP) SWITCH mode can be
> done as follows.
> 
> Assuming eth2 and eth3 are the two physical ports of the ICSS2 instance:
> 
> >> brctl addbr br0
> >> ip maddr add 01:80:c2:00:00:00 dev br0
> >> ip link set dev br0 address $(cat /sys/class/net/eth2/address)
> >> brctl addif br0 eth2
> >> brctl addif br0 eth3
> >> mstpd
> >> brctl stp br0 on
> # STP to RSTP mode
> >> mstpctl setforcevers br0 rstp
> >> ip link set dev br0 up
> 
> To revert back to the default dual EMAC mode, the steps are as follows:
> 
> >> ip link set dev br0 down
> >> brctl delif br0 eth2
> >> brctl delif br0 eth3
> >> brctl delbr br0
> 
> The patches presented in this series have gone through the patch verification
> tools and no warnings or errors are reported.
> 
> Sample test logs obtained from AM33x, AM43x and AM57x verifying the
> functionality on Linux next kernel are available here:
> 
> [Interface up Testing](https://gist.github.com/ParvathiPudi/91b05f4e6d69d72f55ddd4e95301ab20)
> 
> [Ping Testing](https://gist.github.com/ParvathiPudi/9e7573ea85ef72a3ebcbdb4c902f3b8a)
> 
> [Iperf Testing](https://gist.github.com/ParvathiPudi/30abedf115aba19542e0156486766553)
> 
> [1] https://lore.kernel.org/all/20250912104741.528721-1-parvathi@couthit.com/
> 
> This is the v13 of the patch series [v1]. This version of the patchset
> addresses the comments made on [v12] of the series.
> 
> Changes from v12 to v13:
> 
> *) Reverted the use of kmalloc_obj() and kzalloc_obj() back to kmalloc() and kzalloc(),
> since the corresponding changes are not reflected in the net-next branch.
> *) Addressed AI review warnings on patch 3 of the series.
> *) Rebased the series on latest net-next.

Thanks,

I notice that this series has been marked as Changes Requested in
Patchwork. But overall it looks good to me.

Feel free to add the following for the series:
Reviewed-by: Simon Horman <horms@kernel.org>


