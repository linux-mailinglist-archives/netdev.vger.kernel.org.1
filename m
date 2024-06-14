Return-Path: <netdev+bounces-103563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8068908A61
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 12:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 323EAB2A97D
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 10:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98A0194A71;
	Fri, 14 Jun 2024 10:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rHe5tIyF"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40AA1946A0
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361792; cv=none; b=SDm0r5GHDsAcAqhU9/p30XeUFEm7ZO17+URsjGR7fhT/zw/rtSRA19u/BR9NudseHQmN4v6BlpiZccmzmgIWEyoFUGISGcrvSU84atOo5m0jtKkRBoH8w99GtSPBx08hQTWqYR+ep/ygbs58ci4wmYcl4lpwt46NnN0kBRYb+6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361792; c=relaxed/simple;
	bh=FD/DV7O2NKNv4PDTR/vHzvphEUionU4UsD94b6WepTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ncab7JvZZRWJahFAwI+xrW6TxZ9eAI2KqOHsZh9MlmT7cKf8ohMkDIGlAYUw3I+GKJp/adg3UJlQXeeO9KbgcSz5z0YvifZ5HsEWDHMPdrr63KdriHDuQ8eU38+RTf9bTODN1OVy3ZsbltXABi4vyF8dBu3A1isR7mDY6Tm0Iv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rHe5tIyF; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: 0x1207@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718361788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SgrqTw+/It1adEehXLmXgK1moXKsGq11xoueSFrMzIE=;
	b=rHe5tIyFpYY8WnnvPWz/uRNkvY1NX0ZvYBVNgMPpFZoqBS5Er8gvmcjyMkxpNGymbke3VK
	rrSwU18WcSDFZhwwFjaNC1iU8syEFiPYTXUIA8KVMF6O3Zz8/R6xbj2f3LDVicpL2eid9F
	rBqWnk88DXauX70HneT4jxMDHcG/uF0=
X-Envelope-To: linux@armlinux.org.uk
X-Envelope-To: davem@davemloft.net
X-Envelope-To: alexandre.torgue@foss.st.com
X-Envelope-To: joabreu@synopsys.com
X-Envelope-To: edumazet@google.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: mcoquelin.stm32@gmail.com
X-Envelope-To: jpinto@synopsys.com
X-Envelope-To: vinschen@redhat.com
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: linux-stm32@st-md-mailman.stormreply.com
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: xfr@outlook.com
X-Envelope-To: rock.xu@nio.com
Message-ID: <0474a247-e5f2-4a7f-879b-c764591a5f28@linux.dev>
Date: Fri, 14 Jun 2024 11:43:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2] net: stmmac: Enable TSO on VLANs
To: Furong Xu <0x1207@gmail.com>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Joao Pinto
 <jpinto@synopsys.com>, Corinna Vinschen <vinschen@redhat.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xfr@outlook.com, rock.xu@nio.com
References: <20240614060349.498414-1-0x1207@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240614060349.498414-1-0x1207@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 14/06/2024 07:03, Furong Xu wrote:
> The TSO engine works well when the frames are not VLAN Tagged.
> But it will produce broken segments when frames are VLAN Tagged.
> 
> The first segment is all good, while the second segment to the
> last segment are broken, they lack of required VLAN tag.
> 
> An example here:
> ========
> // 1st segment of a VLAN Tagged TSO frame, nothing wrong.
> MacSrc > MacDst, ethertype 802.1Q (0x8100), length 1518: vlan 100, p 1, ethertype IPv4 (0x0800), HostA:42643 > HostB:5201: Flags [.], seq 1:1449
> 
> // 2nd to last segments of a VLAN Tagged TSO frame, VLAN tag is missing.
> MacSrc > MacDst, ethertype IPv4 (0x0800), length 1514: HostA:42643 > HostB:5201: Flags [.], seq 1449:2897
> MacSrc > MacDst, ethertype IPv4 (0x0800), length 1514: HostA:42643 > HostB:5201: Flags [.], seq 2897:4345
> MacSrc > MacDst, ethertype IPv4 (0x0800), length 1514: HostA:42643 > HostB:5201: Flags [.], seq 4345:5793
> MacSrc > MacDst, ethertype IPv4 (0x0800), length 1514: HostA:42643 > HostB:5201: Flags [P.], seq 5793:7241
> 
> // normal VLAN Tagged non-TSO frame, nothing wrong.
> MacSrc > MacDst, ethertype 802.1Q (0x8100), length 1022: vlan 100, p 1, ethertype IPv4 (0x0800), HostA:42643 > HostB:5201: Flags [P.], seq 7241:8193
> MacSrc > MacDst, ethertype 802.1Q (0x8100), length 70: vlan 100, p 1, ethertype IPv4 (0x0800), HostA:42643 > HostB:5201: Flags [F.], seq 8193
> ========
> 
> When transmitting VLAN Tagged TSO frames, never insert VLAN tag by HW,
> always insert VLAN tag to SKB payload, then TSO works well on VLANs for
> all MAC cores.
> 
> Tested on DWMAC CORE 5.10a, DWMAC CORE 5.20a and DWXGMAC CORE 3.20a
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>    Changes in v2:
>      - Use __vlan_hwaccel_push_inside() to insert vlan tag to the payload.
> ---
>   .../net/ethernet/stmicro/stmmac/stmmac_main.c | 27 ++++++++++---------
>   1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index bbedf2a8c60f..e8cbfada63ca 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4233,18 +4233,27 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>   {
>   	struct dma_desc *desc, *first, *mss_desc = NULL;
>   	struct stmmac_priv *priv = netdev_priv(dev);
> -	int nfrags = skb_shinfo(skb)->nr_frags;
> -	u32 queue = skb_get_queue_mapping(skb);
>   	unsigned int first_entry, tx_packets;
>   	struct stmmac_txq_stats *txq_stats;
> -	int tmp_pay_len = 0, first_tx;
> +	int tmp_pay_len = 0, first_tx, nfrags;
>   	struct stmmac_tx_queue *tx_q;
> -	bool has_vlan, set_ic;
> +	bool set_ic;
>   	u8 proto_hdr_len, hdr;
> -	u32 pay_len, mss;
> +	u32 pay_len, mss, queue;
>   	dma_addr_t des;
>   	int i;
>   

As there will be another iteration, could you please re-arrange
variables to keep reverse x-mas tree order?



