Return-Path: <netdev+bounces-282939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEw8FBSC82kY4wEAu9opvQ
	(envelope-from <netdev+bounces-282939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:23:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A507D4A5A18
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 608FA300CCAC
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EEE39EF30;
	Thu, 30 Apr 2026 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eO0mTkYr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAA63093A6
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566113; cv=none; b=Ec+kKfAmBHeIuicXtVeSGY2He9Z+8ybtrK10d/kTMdl3dJFWu15z4dq2MAzJ5+wH6jrinahd2zw9SJOxhfeLy13647AWy4PWtfdq8HzI3292wJ4RNm6DW0f+6fMEnwbGyR0FSgmWri8qf4hPqjGb+NNcaPfMa4Jx/S668DNay88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566113; c=relaxed/simple;
	bh=q1y7v3R/mJEb3oVMPBZ0EISfvAz0p1kLishWt8cqbrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDdB6eLIdxjDpbzqIU+0k8M/k1IpQpyWudAGv9h1z/YAzgIHBlhvdgp7KXV2xWDeqNyaBK6wEemn9w2leCa1nw0VBBrNLh0EHr9iP2oAmglVQa3ZEfkBgxTaHn5P8Y8jRyaMkETztVSvOmbRAOm2Wt/Fwe9OCv7XcbBePhaD/gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eO0mTkYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FEBC2BCB3;
	Thu, 30 Apr 2026 16:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777566113;
	bh=q1y7v3R/mJEb3oVMPBZ0EISfvAz0p1kLishWt8cqbrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eO0mTkYr3Mhqw1AVngfjY5nvmPo4IBhVQer5hsPJ+v6G7+sd/JjGDlHl/jk4t3dVN
	 2pHT76YZVtfgEMR0YDt0ktbJCrzs72BsCt5+O9x19ZfdSncCQMpPv6XOTj5IYSH4oO
	 sdmev+eekoP9aGFzO/PdXd3a4xziSKnTymtXKH/bqFThpxHj/j758EuZ2Xc511t/3j
	 IqdEVU5XF+ItKFjpsZPMTAP8IwH2YZTdl6LmsODm+K7P+jBAKV1gb9tb5eLv5wOut3
	 G3PJZNO3tZZHbBzkntysBLFxyIBTkH5eNv+vkpHxQkyEzfN7CB5SdzblUxXrASUcjn
	 rdbyUwEZ0J9FA==
Date: Thu, 30 Apr 2026 17:21:49 +0100
From: Simon Horman <horms@kernel.org>
To: michal.swiatkowski@linux.intel.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jramaseu@redhat.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, aleksandr.loktionov@intel.com
Subject: Re: [PATCH iwl-net v1 2/2] ice: use NETIF_F_HW_CSUM instead of
 IP/IPV6
Message-ID: <20260430162149.GC900403@horms.kernel.org>
References: <20260428070647.777141-3-michal.swiatkowski@linux.intel.com>
 <20260430152948.1683359-2-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430152948.1683359-2-horms@kernel.org>
X-Rspamd-Queue-Id: A507D4A5A18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-282939-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid]

On Thu, Apr 30, 2026 at 04:29:49PM +0100, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev

Sorry, the email I am responding to was supposed to come with
some commentary - it seems my method for adding it is broken :(
So I'm adding it below (as best as I can remember what it was).

> ---
> ice: use NETIF_F_HW_CSUM instead of IP/IPV6
> 
> This commit replaces the IP and IPV6 checksum offload flags with HW_CSUM
> in the ice driver to allow hardware checksumming for IPv6 packets with
> extension headers. It also removes the mutual exclusivity check between
> TSO and GCS.
> 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> > index 5f92377d4dfc..33f252a6a22f 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > @@ -3491,9 +3491,8 @@ void ice_set_netdev_features(struct net_device *netdev)
> >  			NETIF_F_RXHASH;
> >  
> >  	csumo_features = NETIF_F_RXCSUM	  |
> > -			 NETIF_F_IP_CSUM  |
> >  			 NETIF_F_SCTP_CRC |
> > -			 NETIF_F_IPV6_CSUM;
> > +			 NETIF_F_HW_CSUM;
> 
> By advertising NETIF_F_HW_CSUM, the network stack assumes the driver can handle
> checksums for any protocol and passes non-IP packets (e.g., from AF_PACKET
> injected frames) to the driver with CHECKSUM_PARTIAL.
> 
> Since ice_tx_csum() strictly parses the L3 header and expects IPv4 or IPv6,
> returning -1 for other protocols, will this regression cause non-IP packets to
> be silently dropped instead of falling back to software checksums in the kernel?

The problem above seems to be a legitimate concern, if a corner case.
It seems to also exist in i40e.

> Additionally, skb_csum_hwoffload_help() relies on NETIF_F_IPV6_CSUM to
> safely fall back to software checksums when IPv6 extension headers are
> present.
> 
> Does using NETIF_F_HW_CSUM bypass this safeguard, potentially causing
> legacy hardware (like E810) or E830 without GCS descriptors to compute
> incorrect pseudo-headers and silently corrupt IPv6 packets with extension
> headers?

The issue above seems to be a false positive as the ice driver
doesn't rely on the behaviour described. Rather ice_tx_csum()
uses ipv6_skip_exthdr() to correctly handle extension headers.

> 
> Finally, for protocols other than TCP, UDP, or SCTP, the driver falls back to
> calling skb_checksum_help(skb) in the default case of ice_tx_csum().
> 
> However, the driver appears to ignore the return value of skb_checksum_help().
> 
> If skb_checksum_help() fails (e.g., due to -ENOMEM during pskb_expand_head()),
> could this result in the packet being transmitted with an uncomputed checksum?

The problem above seems real to me, but it also seems to be pre-existing.
So I don't think it should delay progress of this patch.

If it is a problem, it also seems to be present in i40e.

