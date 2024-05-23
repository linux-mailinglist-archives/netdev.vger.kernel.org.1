Return-Path: <netdev+bounces-97791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053368CD3B5
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 15:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41E2283608
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 13:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270CC14B963;
	Thu, 23 May 2024 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaKmJTU/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF98713A897;
	Thu, 23 May 2024 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470267; cv=none; b=Sx4ad3eBHzjrwJYlShq/Guss6XVqZFfKdlhamt9BBfxLsT8Xt1wrbAVDUDjYVaOMnmetq8MGzSVneDmSaimqRWsQOjlhqiEnujom3z/ORx0IqP8Oh3H+n3llqeV0eU4vyitLc+HRLhOiokT7js4RMgtPM5p9NbFg+z7lJ4J1tAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470267; c=relaxed/simple;
	bh=YjxDl1qQvJLbI7CoFRNnlkwjjIbQpYwYvmdsXfobHJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSGumkf3m3wyT9Skc6y6rH3IxyRpy9MXmaExe735VazthbDpnlMupm1N4aKispMV4YKLCFC2zvg4UL0sdA04/6o05C5LgSP68lV4VvLHJFV3oMi7fv3TiH/ie8s18UuPwTByZuOYIAxyeLo1/FzDqh/QEL2uurtpt9XJFxoGiws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaKmJTU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6053C32786;
	Thu, 23 May 2024 13:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716470266;
	bh=YjxDl1qQvJLbI7CoFRNnlkwjjIbQpYwYvmdsXfobHJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MaKmJTU/iS0pIIfN8usqIyj8MvyBtIJ16dcfxAzoYDE0uFLhzjM60MKbiXIDM7EFj
	 FomaG3mM96YmzQe/dYg7/9hcwYBK21wX37GoqhD0lbnFP4du30TlKfWC7HgqkQ0Tia
	 CQVmKwE2wfblNqTHnw2Ks/zf35Y7NDYwAkGEmmr6KgFhZNTSNljRCxbd/7qtITt7MX
	 OVSI/5vZf6/hDGRM6V/Hf1XA17l6Ec/f1Uy5gGS66/cxZ6IWk+9KWCcjcEfJpVIikC
	 rXgnUk6h/lC7+aDZxaGHZwm1bKASAjWvovD9GaHn1yVGzsO43TKkZXVdzFIFlsoBDS
	 054pHjsu/3IPw==
Date: Thu, 23 May 2024 14:17:41 +0100
From: Simon Horman <horms@kernel.org>
To: Ying Hsu <yinghsu@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
	pmenzel@molgen.mpg.de, chromeos-bluetooth-upstreaming@chromium.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Add vendor-specific packet classification
 for ISO data
Message-ID: <20240523131741.GN883722@kernel.org>
References: <20240523060934.2883716-1-yinghsu@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523060934.2883716-1-yinghsu@chromium.org>

On Thu, May 23, 2024 at 06:09:31AM +0000, Ying Hsu wrote:
> When HCI raw sockets are opened, the Bluetooth kernel module doesn't
> track CIS/BIS connections. User-space applications have to identify
> ISO data by maintaining connection information and look up the mapping
> for each ACL data packet received. Besides, btsnoop log captured in
> kernel couldn't tell ISO data from ACL data in this case.
> 
> To avoid additional lookups, this patch introduces vendor-specific
> packet classification for Intel BT controllers to distinguish
> ISO data packets from ACL data packets.
> 
> Signed-off-by: Ying Hsu <yinghsu@chromium.org>
> ---
> Tested LE audio unicast recording on a ChromeOS device with Intel AX211
> 
> Changes in v2:
> - Adds vendor-specific packet classificaton in hci_dev.
> - Keeps reclassification in hci_recv_frame.
> 
>  drivers/bluetooth/btusb.c        | 19 +++++++++++++++++++
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_core.c         | 16 ++++++++++++++++
>  3 files changed, 36 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 79aefdb3324d..75561e749c50 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -966,6 +966,24 @@ static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
>  	gpiod_set_value_cansleep(reset_gpio, 0);
>  }
>  
> +#define BT_USB_INTEL_ISODATA_HANDLE_BASE 0x900
> +
> +static u8 btusb_intel_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	/*
> +	 * Distinguish ISO data packets form ACL data packets
> +	 * based on their conneciton handle value range.

nit: connection

> +	 */
> +	if (hci_skb_pkt_type(skb) == HCI_ACLDATA_PKT) {
> +		__u16 handle = __le16_to_cpu(hci_acl_hdr(skb)->handle);
> +
> +		if (hci_handle(handle) >= BT_USB_INTEL_ISODATA_HANDLE_BASE)
> +			return HCI_ISODATA_PKT;
> +	}
> +
> +	return hci_skb_pkt_type(skb);
> +}
> +
>  #define RTK_DEVCOREDUMP_CODE_MEMDUMP		0x01
>  #define RTK_DEVCOREDUMP_CODE_HW_ERR		0x02
>  #define RTK_DEVCOREDUMP_CODE_CMD_TIMEOUT	0x03

...

