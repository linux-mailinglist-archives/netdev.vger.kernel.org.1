Return-Path: <netdev+bounces-164046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE3CA2C70B
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860C93A1F69
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221A01EB19D;
	Fri,  7 Feb 2025 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwqRvmfq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD46CA6B;
	Fri,  7 Feb 2025 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942004; cv=none; b=No/hTbd2wEDsP07qRifqL8W/ssCKL8a/wmaEzZtQtR/Vu1OMHXMgPDAeTPKjELZJstLlhOpRz0Fn8C0IaJuUxKl7wbj68FN0oQHCvap9aLQEbNqInIkQ3kEn69RT1jnuvGN93EPGZzzZ5/dcMWpponkxazvori3OBJhxliQ2uvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942004; c=relaxed/simple;
	bh=flaTnYwyC44wXsEHNFNLtBOFU+9/hz9ABJTDV9HpMsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdIgkwm/98pj+KUZTZwGJfUh/MpnpmDI6I5AJhZhNmLlhMQIEeT+ZeIVMzUXkBj61j0B0mxkBx5AhklQdpZs1Plxs9GAmrN/IRVp+sCtcZSRba6pz5rViIM9GwvLDVeZYwwDRJb83OljjZgWmsR189jlDUgjyR2vXaK830VrUo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwqRvmfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE14C4CEDF;
	Fri,  7 Feb 2025 15:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738942003;
	bh=flaTnYwyC44wXsEHNFNLtBOFU+9/hz9ABJTDV9HpMsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CwqRvmfqucMrTXmmA/vvtCTgRVPlQvChsM4grllZTt2Bm+xfLlM14ISiXMwnvxJs9
	 UZdSllLMDjI8kUgtklXzGrEtdst/7FK1Luj04EeZ6V42Cp4/C9ZuE3MoXqkRcp5wUD
	 rtVP/OLnxzuA/zfhlPTB4+COPJZK+LkNXMkbZpDHaITT6NeJYhdaYAxj94JVzgh3bq
	 gW/HZvHd6HxjTfVDwZg5bDrOSAwM//ni0Bj+M1P+MsZgpMqVeKuobcof2HNWlvdGDw
	 jtAi5rkwOON/t8s5achVqBhg8LhGvGA1tn/QUDShIYjRWtHbKIBOjAQzX8L4IkXxN8
	 NmL2GMG18YnxA==
Date: Fri, 7 Feb 2025 15:26:39 +0000
From: Simon Horman <horms@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Santosh Puranik <spuranik@nvidia.com>
Subject: Re: [PATCH net-next 2/2] net: mctp: Add MCTP USB transport driver
Message-ID: <20250207152639.GZ554665@kernel.org>
References: <20250206-dev-mctp-usb-v1-0-81453fe26a61@codeconstruct.com.au>
 <20250206-dev-mctp-usb-v1-2-81453fe26a61@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206-dev-mctp-usb-v1-2-81453fe26a61@codeconstruct.com.au>

On Thu, Feb 06, 2025 at 02:48:24PM +0800, Jeremy Kerr wrote:
> Add an implementation for DMTF DSP0283, which defines a MCTP-over-USB
> transport. As per that spec, we're restricted to full speed mode,
> requiring 512-byte transfers.
> 
> Each MCTP-over-USB interface is a peer-to-peer link to a single MCTP
> endpoint, so no physical addressing is required (of course, that MCTP
> endpoint may then bridge to further MCTP endpoints). Consequently,
> interfaces will report with no lladdr data:
> 
>     # mctp link
>     dev lo index 1 address 00:00:00:00:00:00 net 1 mtu 65536 up
>     dev mctpusb0 index 6 address none net 1 mtu 68 up
> 
> This is a simple initial implementation, with single rx & tx urbs, and
> no multi-packet tx transfers - although we do accept multi-packet rx
> from the device.
> 
> Includes suggested fixes from Santosh Puranik <spuranik@nvidia.com>.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> Cc: Santosh Puranik <spuranik@nvidia.com>

...

> diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c

...

> +static void mctp_usb_in_complete(struct urb *urb)
> +{
> +	struct sk_buff *skb = urb->context;
> +	struct net_device *netdev = skb->dev;
> +	struct pcpu_dstats *dstats = this_cpu_ptr(netdev->dstats);
> +	struct mctp_usb *mctp_usb = netdev_priv(netdev);
> +	struct mctp_skb_cb *cb;
> +	unsigned int len;
> +	int status;
> +
> +	status = urb->status;
> +
> +	switch (status) {
> +	case -ENOENT:
> +	case -ECONNRESET:
> +	case -ESHUTDOWN:
> +	case -EPROTO:
> +		kfree_skb(skb);
> +		return;
> +	case 0:
> +		break;
> +	default:
> +		dev_err(&mctp_usb->usbdev->dev, "%s: urb status: %d\n",
> +			__func__, status);
> +		kfree_skb(skb);
> +		return;
> +	}
> +
> +	len = urb->actual_length;
> +	__skb_put(skb, len);
> +
> +	while (skb) {
> +		struct sk_buff *skb2 = NULL;
> +		struct mctp_usb_hdr *hdr;
> +		u8 pkt_len; /* length of MCTP packet, no USB header */
> +
> +		hdr = skb_pull_data(skb, sizeof(*hdr));
> +		if (!hdr)
> +			break;
> +
> +		if (be16_to_cpu(hdr->id) != MCTP_USB_DMTF_ID) {
> +			dev_dbg(&mctp_usb->usbdev->dev, "%s: invalid id %04x\n",
> +				__func__, be16_to_cpu(hdr->id));
> +			break;
> +		}
> +
> +		if (hdr->len <
> +		    sizeof(struct mctp_hdr) + sizeof(struct mctp_usb_hdr)) {
> +			dev_dbg(&mctp_usb->usbdev->dev,
> +				"%s: short packet (hdr) %d\n",
> +				__func__, hdr->len);
> +			break;
> +		}
> +
> +		/* we know we have at least sizeof(struct mctp_usb_hdr) here */
> +		pkt_len = hdr->len - sizeof(struct mctp_usb_hdr);
> +		if (pkt_len > skb->len) {
> +			dev_dbg(&mctp_usb->usbdev->dev,
> +				"%s: short packet (xfer) %d, actual %d\n",
> +				__func__, hdr->len, skb->len);
> +			break;
> +		}
> +
> +		if (pkt_len < skb->len) {
> +			/* more packets may follow - clone to a new
> +			 * skb to use on the next iteration
> +			 */
> +			skb2 = skb_clone(skb, GFP_ATOMIC);
> +			if (skb2) {
> +				if (!skb_pull(skb2, pkt_len)) {
> +					kfree_skb(skb2);
> +					skb2 = NULL;
> +				}
> +			}
> +			skb_trim(skb, pkt_len);
> +		}
> +
> +		skb->protocol = htons(ETH_P_MCTP);
> +		skb_reset_network_header(skb);
> +		cb = __mctp_cb(skb);
> +		cb->halen = 0;
> +		netif_rx(skb);

Hi Jeremy,

skb is dereferenced a few lines further down,
but I don't think it is is safe to do so after calling netif_rx().

> +
> +		u64_stats_update_begin(&dstats->syncp);
> +		u64_stats_inc(&dstats->rx_packets);
> +		u64_stats_add(&dstats->rx_bytes, skb->len);
> +		u64_stats_update_end(&dstats->syncp);
> +
> +		skb = skb2;
> +	}
> +
> +	if (skb)
> +		kfree_skb(skb);
> +
> +	mctp_usb_rx_queue(mctp_usb);
> +}

...

