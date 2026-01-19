Return-Path: <netdev+bounces-251084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3180AD3A9F4
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DD8A3045F4E
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 13:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAB7364E87;
	Mon, 19 Jan 2026 13:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="q6ISchpd"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FB729D280;
	Mon, 19 Jan 2026 13:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768828175; cv=none; b=L54N0rUZrmi5Nenx0Nbf44yROrULW3U76Ldfxxn4nk1r2m3I/Vt/m1c0INHQ+x9hQlbMNI9P+i1U9O/W5zPBqr24YX6jdbQxywcRqcrBUAnz1hp7vY9PkprTdipZ5mFgUzy1eZ9ni5VVCIvbEzWlJzaI7bjKQLBLr+M4W6+jIww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768828175; c=relaxed/simple;
	bh=gwTDCSKqc8LSu9yPNc5jngp7QL67XyPXB2CAD6UZF+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=duQ7YEd0+JcQRMLDxqBukQStAJmMsUqiG0CVLzecFCKE7nqnxYjVoT6mj0SgmNX88C59GSCcG3i0knNeJJgKml7stDf1sBJvCQCcaSMJOpJL38JSUTJ6WV/t/HPJO0FTH6kjB1V/6N9arLf0y+20oRZhnTpxtsNMWYpvr66yjd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=q6ISchpd; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1768828174; x=1800364174;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gwTDCSKqc8LSu9yPNc5jngp7QL67XyPXB2CAD6UZF+E=;
  b=q6ISchpd019gSAkZLQZSJAqkH0aJf+COr20XZ3cm7ffDYxd6jJ03p0Po
   4zFstduVlNs0fEg6SJCk4xMOStFwgt47ZA4qmYhuddcMx8Oja8/4/LnMc
   IdgWPZk5GQ6kGdnonqQ2nJzGKwuRV35SUpTcBW20Snpj2eOFrEdrfWBxu
   wb/Uyddv7IFQtv1BZi0M6LV3fYS0GOilQogTpZDN43pBkUAKYRxPEpk63
   c1qHX0uFphpnbTWCw9JBPWWCc6TE49qlpUgX3CvE7sZFSCS5GtzbzbgWY
   nLMnLSmXBB/Z6EZO/ta6Ory4gr8BZy0y2DO01LIUdUfGKuRL2erX7Gxgw
   Q==;
X-CSE-ConnectionGUID: MCMdS/2MS9W3q5v2vYq8nw==
X-CSE-MsgGUID: ohbf7MsMRqSUEgskF7U23Q==
X-IronPort-AV: E=Sophos;i="6.21,238,1763449200"; 
   d="scan'208";a="283467428"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jan 2026 06:09:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 19 Jan 2026 06:08:10 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 19 Jan 2026 06:08:04 -0700
Message-ID: <402feb92-104b-4fe0-b223-a85afd60d084@microchip.com>
Date: Mon, 19 Jan 2026 14:08:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 8/9] net: macb: convert to use .get_rx_ring_count
To: Breno Leitao <leitao@debian.org>, Ajit Khaparde
	<ajit.khaparde@broadcom.com>, Sriharsha Basavapatna
	<sriharsha.basavapatna@broadcom.com>, Somnath Kotur
	<somnath.kotur@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Felix Fietkau
	<nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Shay
 Agroskin" <shayagr@amazon.com>, Arthur Kiyanovski <akiyano@amazon.com>,
	"David Arinzon" <darinzon@amazon.com>, Saeed Bishara <saeedb@amazon.com>,
	"Bryan Whitehead" <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>, Potnuri Bharat Teja
	<bharat@chelsio.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>, Jiawen Wu
	<jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
References: <20260115-grxring_big_v2-v1-0-b3e1b58bced5@debian.org>
 <20260115-grxring_big_v2-v1-8-b3e1b58bced5@debian.org>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <20260115-grxring_big_v2-v1-8-b3e1b58bced5@debian.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 15/01/2026 at 15:37, Breno Leitao wrote:
> Use the newly introduced .get_rx_ring_count ethtool ops callback instead
> of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Looks good to me:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks, best regards,
   Nicolas

> ---
>   drivers/net/ethernet/cadence/macb_main.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 2d5f3eb09530..8135c5c2a51a 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -3850,6 +3850,13 @@ static int gem_get_all_flow_entries(struct net_device *netdev,
>          return 0;
>   }
> 
> +static u32 gem_get_rx_ring_count(struct net_device *netdev)
> +{
> +       struct macb *bp = netdev_priv(netdev);
> +
> +       return bp->num_queues;
> +}
> +
>   static int gem_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
>                  u32 *rule_locs)
>   {
> @@ -3857,9 +3864,6 @@ static int gem_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
>          int ret = 0;
> 
>          switch (cmd->cmd) {
> -       case ETHTOOL_GRXRINGS:
> -               cmd->data = bp->num_queues;
> -               break;
>          case ETHTOOL_GRXCLSRLCNT:
>                  cmd->rule_cnt = bp->rx_fs_list.count;
>                  break;
> @@ -3941,6 +3945,7 @@ static const struct ethtool_ops gem_ethtool_ops = {
>          .set_ringparam          = macb_set_ringparam,
>          .get_rxnfc                      = gem_get_rxnfc,
>          .set_rxnfc                      = gem_set_rxnfc,
> +       .get_rx_ring_count              = gem_get_rx_ring_count,
>   };
> 
>   static int macb_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
> 
> --
> 2.47.3
> 


