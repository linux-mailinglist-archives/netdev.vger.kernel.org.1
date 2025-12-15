Return-Path: <netdev+bounces-244779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 580DACBE66E
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 15:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 529C230046E0
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 14:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFDB34A78B;
	Mon, 15 Dec 2025 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOPhB6Fw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F4F34A784
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765810170; cv=none; b=VWFCD6wxEk3n/bf3dBtilDv5o/onwlv1pvNZDuuBSmSqX6URGsCYD98zZ0Hxz9Yr4rWKXDrXpJhhFNRyos8rHISchEp/OW6BCrz6kpT4pRZyYZ/O//eQ5kMN5tkrQd5w0MkodvXRNFPP9Qu9eqES8jgNXhzV/dT7AAlzTsoJALc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765810170; c=relaxed/simple;
	bh=MMw96rEoVR0EA2B0NpL7nlB5oy/n3lDGKbCivBMikPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRw/M5+IKp/y6iTZbPmrwxJm6JLQC7aI2kPjVYIUtkapxhGrRVy/KeVWt5KGjgq6v54HOb+t257ZQrJ6H9LzrFzXtMFhVn1chkqxTqL6zXpNRkYD/Xlrky0UT8PAC/pWVxqM3Nea7sczqGX/bMw5rWAjgKPFD4vw3x9Tnp4jRVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOPhB6Fw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388E0C4CEF5;
	Mon, 15 Dec 2025 14:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765810170;
	bh=MMw96rEoVR0EA2B0NpL7nlB5oy/n3lDGKbCivBMikPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GOPhB6Fw3ffoHY6OYNhppy5it+8yq+VJQldE+FBvsfAIXX7+0zZ/BfvqCC/y5HBCQ
	 U+7LVDr9/0KrxXQuP9CQrSJR/EvpspM7ZaJc4MkL7dx4XrPih92pBMBI/RLitOfAQX
	 TLY5cjwydOMiF1hYwP+ZOazRbI/h6sL0Qhk1gvWZ3HsHnS9wP0RX1AnWg1Dgr5X+2B
	 /YO4NbheifCqyNqy+C3TUB//LrIM7gebNwaWXLGW7O8EPCYYg8OyMm9GBgGFyp/JwT
	 P+AfyhnG+uoq+ylriIzMg6ZMX2dqGhLff3r3Gma7Gry0YmHDRQz/EAjiyvXcRcu1st
	 Vzz9o57lWM+AQ==
Date: Mon, 15 Dec 2025 14:49:25 +0000
From: Simon Horman <horms@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, Edward Cree <ecree.xilinx@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-net-drivers@amd.com
Subject: Re: [PATCH v2 net-next] sfc: correct kernel-doc complaints
Message-ID: <aUAf9Z3BhiGqJ1It@horms.kernel.org>
References: <20251214191603.2169432-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214191603.2169432-1-rdunlap@infradead.org>

On Sun, Dec 14, 2025 at 11:16:03AM -0800, Randy Dunlap wrote:
> Fix kernel-doc warnings by adding 3 missing struct member descriptions
> in struct efx_ef10_nic_data and removing preprocessor directives (which
> are not handled by kernel-doc).
> 
> Fixes these 5 warnings:
> Warning: drivers/net/ethernet/sfc/nic.h:158 bad line: #ifdef CONFIG_SFC_SRIOV
> Warning: drivers/net/ethernet/sfc/nic.h:160 bad line: #endif
> Warning: drivers/net/ethernet/sfc/nic.h:204 struct member 'port_id'
>  not described in 'efx_ef10_nic_data'
> Warning: drivers/net/ethernet/sfc/nic.h:204 struct member 'vf_index'
>  not described in 'efx_ef10_nic_data'
> Warning: drivers/net/ethernet/sfc/nic.h:204 struct member 'licensed_features'
>  not described in 'efx_ef10_nic_data'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> v2: update struct member descriptions based on Edward's comments
> 
> NOTE: gmail usually blocks my email to Edward's gmail address;
>   gmail identifies it as spam.
> 
> Cc: Edward Cree <ecree.xilinx@gmail.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: linux-net-drivers@amd.com
> ---
>  drivers/net/ethernet/sfc/nic.h |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> --- linux-next-20251208.orig/drivers/net/ethernet/sfc/nic.h
> +++ linux-next-20251208/drivers/net/ethernet/sfc/nic.h
> @@ -156,9 +156,9 @@ enum {
>   * @tx_dpcpu_fw_id: Firmware ID of the TxDPCPU
>   * @must_probe_vswitching: Flag: vswitching has yet to be setup after MC reboot
>   * @pf_index: The number for this PF, or the parent PF if this is a VF
> -#ifdef CONFIG_SFC_SRIOV
> - * @vf: Pointer to VF data structure
> -#endif
> + * @port_id: Ethernet address of owning PF, used for phys_port_id
> + * @vf_index: The number for this VF, or 0xFFFF if this is a VF
> + * @vf: for a PF, array of VF data structures indexed by VF's @vf_index
>   * @vport_mac: The MAC address on the vport, only for PFs; VFs will be zero
>   * @vlan_list: List of VLANs added over the interface. Serialised by vlan_lock.
>   * @vlan_lock: Lock to serialize access to vlan_list.
> @@ -166,6 +166,7 @@ enum {
>   * @udp_tunnels_dirty: flag indicating a reboot occurred while pushing
>   *	@udp_tunnels to hardware and thus the push must be re-done.
>   * @udp_tunnels_lock: Serialises writes to @udp_tunnels and @udp_tunnels_dirty.
> + * @licensed_features: Flags for licensed firmware features.
>   */
>  struct efx_ef10_nic_data {
>  	struct efx_buffer mcdi_buf;
> 

Not trimmed in case there is any value in this data getting to
Edward given Randy's comment about spam.

## Form letter - net-next-closed

net-next is currently closed for new drivers, features, code refactoring and
optimizations. We are currently accepting bug fixes only.

net-next was closed when the merge window for v6.19 began. And due to a
combination of the travel commitments of the maintainers, and the holiday
season, net-next will not re-open until after 2nd January.

Please repost when net-next reopens.

RFC patches sent for review only are welcome at any time.

Thanks for your understanding.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

-- 
pw-bot: defer

