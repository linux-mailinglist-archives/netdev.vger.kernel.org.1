Return-Path: <netdev+bounces-293602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAYXDus7HWoqWQkAu9opvQ
	(envelope-from <netdev+bounces-293602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 09:59:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF75361B350
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 09:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30399301FD7D
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 07:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98595388891;
	Mon,  1 Jun 2026 07:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="CR0AZCu4"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CCA388887;
	Mon,  1 Jun 2026 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300755; cv=none; b=Iy4NQ5qywbA5pt/gWaSxDF5z75Bnqu6zLVDSa6RK/hi96zfablCm+Tq4Gf+GP6Gko9hjGftuVIztS6WbuBSF9BFbE/oEevDaf6xEDDGYr54t/HU49Mgo/c/ioVMzWcWkTeixXEQm91tzMTYYBW6fNlK4YIiCiep7+cuIihR1doI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300755; c=relaxed/simple;
	bh=Bmm+IwN3Qg+F9NisKzCh7Bf9ePUF7lGkwltk3VTlMHk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=grXaGlSVWO7OKDmaDrJ4G7m4OeQg57/kcNuJixDs8qOXCc/XUmBjrccOEQfJRd+t5q5+n5InbNpVEkmYZ023A5f90ENMCMjZDsprqv6VS3lOHwufYJSRz0HdEP02fsYrDVTcrSgiUQlps2C6OkWiir2wsVFCIbhcAEemCN7ZkXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=CR0AZCu4; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 43411A017D;
	Mon,  1 Jun 2026 09:58:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780300740; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BCFalmith6ZKuJe0hwhVJqlHf6HLqtBH/4Pkh+bxtm8=;
	b=CR0AZCu45PHElVOTOgfY2pnmLA90gGjqiZj3/Y9Wtxbsq5J30I01EzffTLM4fQ6Ew9TEjs
	iXJdiuvmWzW7mAZN+wO8a5ump7sb+qZER6cAeRx5Qp57ierVNkFTV486qyMhTPrI3oVQBi
	H6bJ+CvwQXiPF0CZlgBDFUPeEKR6up/7A+6vR+1+/DVjqWSDkVHyxgj85nQc3bQZ5aPsXV
	cc10ZqyZwb32yMMtJSXDLI4eEiJX6ZZmxWZAOncgX/kmoNz8rJbXAxV74mQBiEftwHCArR
	2Wg0gaoCb0oYcv8uAO5S2z08ROIyxxtZPrumGQJRk53584Dwc3FrsJWfpHgFAg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 01 Jun 2026 09:58:57 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: David Thompson <davthompson@nvidia.com>
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: lan743x: permit VLAN-tagged packets up to
 configured MTU
In-Reply-To: <20260529210300.433135-1-davthompson@nvidia.com>
References: <20260529210300.433135-1-davthompson@nvidia.com>
Message-ID: <adca787a7ac46e03dac4da3e66c5c8cf@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293602-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,tipi-net.de:email,tipi-net.de:mid,tipi-net.de:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: BF75361B350
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi David

On 29.5.2026 23:03, David Thompson wrote:
> VLAN-tagged interfaces on lan743x devices were previously unreachable 
> via
> SSH and failed to respond to large ping packets (e.g. "ping -s 1469" 
> given
> MTU=1500). In these scenarios, "ethtool -S" reports non-zero "RX 
> Oversize
> Frame Errors". According to Microchip AN2948, the MAC_RX FSE (VLAN 
> field
> size enforcement) bit determines whether frames with VLAN tags 
> exceeding
> the base MTU plus tag length are discarded.
> 
> The driver must set the MAC_RX.FSE bit before setting MAC_RX.RXEN to 
> allow
> VLAN-tagged frames up to the interface MTU, preventing them from being
> treated as oversized. As a result, both the base and VLAN-tagged 
> interfaces
> can use the same MTU without receive errors.
> 
> Fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x 
> driver")
> Signed-off-by: David Thompson <davthompson@nvidia.com>
> ---
> v2:
> - Added helper function, lan743x_mac_rx_enable_fse(), to set FSE bit 
> properly
> - Added explicit comment about use of distinct write cycle to set FSE 
> bit
> - Moved setting of FSE from lan743x_mac_open() to lan743x_mac_init(), 
> allowing FSE
>   bit to be set upon probe() path or suspend/resume path. This change 
> fixes an
>   issue raised by Sashiko
> ---
>  drivers/net/ethernet/microchip/lan743x_main.c | 32 +++++++++++++++++++
>  drivers/net/ethernet/microchip/lan743x_main.h |  1 +
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c 
> b/drivers/net/ethernet/microchip/lan743x_main.c
> index f3332417162e..ffac22883e49 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -1219,6 +1219,36 @@ static void lan743x_mac_set_address(struct 
> lan743x_adapter *adapter,
>  		   "MAC address set to %pM\n", addr);
>  }
> 
> +static void lan743x_mac_rx_enable_fse(struct lan743x_adapter *adapter)
> +{
> +	u32 mac_rx;
> +	bool rxen;
> +
> +	mac_rx = lan743x_csr_read(adapter, MAC_RX);
> +	if (mac_rx & MAC_RX_FSE_)
> +		return;
> +
> +	rxen = mac_rx & MAC_RX_RXEN_;
> +	if (rxen) {
> +		mac_rx &= ~MAC_RX_RXEN_;
> +		lan743x_csr_write(adapter, MAC_RX, mac_rx);
> +		lan743x_csr_wait_for_bit(adapter, MAC_RX, MAC_RX_RXD_,
> +					 1, 1000, 20000, 100);
> +	}
> +
> +	/* Per AN2948, hardware prevents modification of the FSE bit while 
> the
> +	 * MAC receiver is enabled (RXEN bit set). Use separate register 
> write
> +	 * to assert the FSE bit before enabling the RXEN bit in MAC_RX
> +	 */
> +	mac_rx |= MAC_RX_FSE_;
> +	lan743x_csr_write(adapter, MAC_RX, mac_rx);
> +
> +	if (rxen) {
> +		mac_rx |= MAC_RX_RXEN_;
> +		lan743x_csr_write(adapter, MAC_RX, mac_rx);
> +	}
> +}
> +
>  static int lan743x_mac_init(struct lan743x_adapter *adapter)
>  {
>  	bool mac_address_valid = true;
> @@ -1258,6 +1288,8 @@ static int lan743x_mac_init(struct 
> lan743x_adapter *adapter)
>  	lan743x_mac_set_address(adapter, adapter->mac_address);
>  	eth_hw_addr_set(netdev, adapter->mac_address);
> 
> +	lan743x_mac_rx_enable_fse(adapter);
> +
>  	return 0;
>  }
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.h 
> b/drivers/net/ethernet/microchip/lan743x_main.h
> index 160d94a7cee6..1573c8f9c993 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.h
> +++ b/drivers/net/ethernet/microchip/lan743x_main.h
> @@ -182,6 +182,7 @@
>  #define MAC_RX				(0x104)
>  #define MAC_RX_MAX_SIZE_SHIFT_		(16)
>  #define MAC_RX_MAX_SIZE_MASK_		(0x3FFF0000)
> +#define MAC_RX_FSE_			BIT(2)
>  #define MAC_RX_RXD_			BIT(1)
>  #define MAC_RX_RXEN_			BIT(0)

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Tested-by: Nicolai Buchwitz <nb@tipi-net.de> # lan7430 on arm64 (RevPi 
Connect 5)

Thanks,
Nicolai

