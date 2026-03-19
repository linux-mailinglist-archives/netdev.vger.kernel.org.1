Return-Path: <netdev+bounces-269566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJc7Oo4vvGnquAIAu9opvQ
	(envelope-from <netdev+bounces-269566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:17:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 624E52CFBA9
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36D143115104
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B111B3CD8C5;
	Thu, 19 Mar 2026 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ux6oIogk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7E637C101
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773940275; cv=none; b=Ss8eXfa6dRbTCer5ckGwJ0MtcA29BPHl78GT0dNWdWghMKSS/O4Ke0SqO6wkb4zRsYyVqn3+9Hc5m4v4p2Y9AQB2Bq7TPG9FdzuvZ4/gte0xZpvl34IHiphjZQJNJgInbfaIQ38ZBh5c9I7423ecTAMjf3Y+91P4WKRg4JLOUNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773940275; c=relaxed/simple;
	bh=7hd7Smy1Awo4W5zP2cf4X5Wovdj0UQ0f6uCrztlwxTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAP6ZXrzjqyD5IjzryefRqEFyoeRdTLwWSceAz8egvkePcfyMKdOJkOxbcLQLVmex+kFNoot35HBNY2Fnk8RqBCxrB7dlycZ3yvnAWz064eETXPelSKEOv0srBRqaNhyv5o3gToaxNu+2fZesMsjzHRAliDCKJIG7abK2dh4M7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ux6oIogk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72529C19424;
	Thu, 19 Mar 2026 17:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773940275;
	bh=7hd7Smy1Awo4W5zP2cf4X5Wovdj0UQ0f6uCrztlwxTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ux6oIogkSXx+NoeaRHRTUvJNFMGpYejAEIHivBemoM0xnjPho8FyLoMxNr8l5FpgV
	 AcCxtzyOIW8DDC2nkNnp1shuJIc9AI1QtGExhbFIgjtexT3I/la3ngx/PYNvL8tQ7w
	 pcof3z/qD8hbBbA327AellQ5WbslXITm0IoV/K8VaWi1rOU2LPcK3BVVsIbewYOpf2
	 sgW5zmgILLYgM+CZjPYRxdMRgiGmZKFK2ULGTXjm7Ot9blUq5Qu82JaKBlFVYDX/ov
	 +9N2ZH3LUleZxsIkkxQ1APREvVyeZKDI0kgvzsSbEFuQqp1oFpBrfVtgpiC4nkaVFS
	 7GUQ24RLyyaJA==
Date: Thu, 19 Mar 2026 17:11:11 +0000
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 0/2] virtchnl/ice: add IEEE 802.1ah (0x88E7)
 VLAN ethertype support
Message-ID: <20260319171111.GM1753385@horms.kernel.org>
References: <20260318080737.3012293-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318080737.3012293-1-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269566-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 624E52CFBA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 09:07:34AM +0100, Aleksandr Loktionov wrote:
> IEEE 802.1ah (Provider Backbone Bridging) defines the Backbone Service
> Tag (B-TAG) with ethertype 0x88E7. In environments that combine Provider
> Backbone Bridging with virtualisation, VFs may receive or transmit frames
> carrying a B-TAG and need to install matching VLAN filters on the PF.
> 
> The existing virtchnl VLAN v2 capability handshake (via
> VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS) has dedicated bitmask entries for
> each supported ethertype (0x8100, 0x88A8, 0x9100) but lacked one for
> 0x88E7, making it impossible for a VF driver to advertise or negotiate
> B-TAG support.
> 
> This series adds the missing capability flag and wires up the three
> software-path checks in the ice PF driver that guard VLAN filter
> installation:
> 
>   Patch 1 adds VIRTCHNL_VLAN_ETHERTYPE_88E7 = BIT(3) to the shared
>   virtchnl_vlan_support enum in include/linux/avf/virtchnl.h.
> 
>   Patch 2 updates ice's TC TPID validation, VSI VLAN filter validation,
>   and the bidirectional virtchnl VLAN v2 translation functions to
>   accept/translate ETH_P_8021AH (0x88E7).
> 
> No hardware offload changes, no datapath modifications.
> 
> Tested on E810 with an iavf VF requesting 0x88E7-tagged VLAN filters:
>   Verified that a TC flower rule matching on VLAN TPID 0x88E7 is now
>   accepted and offloaded by the driver without returning -EINVAL:
> 
>     tc qdisc add dev $VF clsact
>     tc filter add dev $VF ingress protocol 802.1Q flower \
>         vlan_ethtype 0x88e7 action pass
>     # (previously: Error: Failed to offload TC filter - vlan_type was 0)
> 
>   Also verified VF transparent passthrough of triple-tagged frames with
>   0x88E7 as middle and innermost tag using scapy on a back-to-back E810
>   pair (kernel 6.19.0-rc8+, FW 4.91, ICE Triple VLAN Comms DDP 1.3.88.88).
> 
> Aleksandr Loktionov (2):
>   virtchnl: add VIRTCHNL_VLAN_ETHERTYPE_88E7 support
>   ice: add 0x88E7 handling to SW validation paths

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>


