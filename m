Return-Path: <netdev+bounces-206326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4153B02A86
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 12:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C71917D532
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 10:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81822750FB;
	Sat, 12 Jul 2025 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=novek.ru header.i=@novek.ru header.b="W1qoF3sY"
X-Original-To: netdev@vger.kernel.org
Received: from novek.ru (unknown [31.204.180.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0491C3C30;
	Sat, 12 Jul 2025 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.204.180.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752317915; cv=none; b=qeXdB5Q5ICf5siFFnDJpVhm7BPvPmlzCFKWsCb0Kh1ApoRZefQRQyV80p3l5RMZWPwuv4y7T6kyyR6o7HSe3eKLTueqNSiqDmM9Tggj91MdlfeIXAbvhuM2qxlPFOY3gnkJEbFCmugd4IJHjukRoBqS9BjyZsByi0Mz+DSp7NGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752317915; c=relaxed/simple;
	bh=kEXM2B40+oOTQxkThF9k3u9XibKzeXiZAnLjrmbOZMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKSMiJKjpnuoF01nnJRfxzuYWX0tOMpYTumfeNORo5TFDEaU2JvCJ9ShkCJJg3sS1olXupE3ztt5midY3ZTRhTmomn0jhFEpbrTu1PXZhgrFOoUb9wN488d68ixbHIR2oG+dPouzeqoSiX52+yEKHfjhMY1WNec3ElDZFD46pvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=novek.ru; spf=pass smtp.mailfrom=novek.ru; dkim=permerror (0-bit key) header.d=novek.ru header.i=@novek.ru header.b=W1qoF3sY; arc=none smtp.client-ip=31.204.180.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=novek.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novek.ru
Received: from [10.57.205.117] (unknown [154.14.208.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by novek.ru (Postfix) with ESMTPSA id B1646508CE0;
	Sat, 12 Jul 2025 14:08:23 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 novek.ru B1646508CE0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=novek.ru; s=mail;
	t=1752318507; bh=kEXM2B40+oOTQxkThF9k3u9XibKzeXiZAnLjrmbOZMA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W1qoF3sYX/6mfRHTmA4jCtCG7kO21clq3fzOIrS6TC4RwWtQyt+m7KI1CWNrlq/qk
	 ANyMRdbvypRzRLD3V6rKjpr+AS/hKUTcYf8p00ZCauuR1n38EGYn1Kmyn2+fQZufTp
	 +WtrWDhF0tEmljsuznlJ7SNdb1OtMrGUicMQDfqc=
Message-ID: <c61444a9-6ac6-4fd4-a4ff-d3815bfa40e4@novek.ru>
Date: Sat, 12 Jul 2025 11:58:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/12] net: enetc: Add
 enetc_update_ptp_sync_msg() to process PTP sync packet
Content-Language: en-US
To: Wei Fang <wei.fang@nxp.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: fushi.peng@nxp.com, devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
References: <20250711065748.250159-1-wei.fang@nxp.com>
 <20250711065748.250159-10-wei.fang@nxp.com>
From: Vadim Fedorenko <vfedorenko@novek.ru>
In-Reply-To: <20250711065748.250159-10-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: **

On 11.07.2025 07:57, Wei Fang wrote:
> Currently, the PTP Sync packets are processed in enetc_map_tx_buffs(),
> which makes the function too long and not concise enough. Secondly,
> for the upcoming ENETC v4 one-step support, some appropriate changes
> are also needed. Therefore, enetc_update_ptp_sync_msg() is extracted
> from enetc_map_tx_buffs() as a helper function to process the PTP Sync
> packets.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>   drivers/net/ethernet/freescale/enetc/enetc.c  | 129 ++++++++++--------
>   .../net/ethernet/freescale/enetc/enetc_hw.h   |   1 +
>   2 files changed, 71 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index c1373163a096..ef002ed2fdb9 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -221,12 +221,79 @@ static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int count, int i)
>   	}
>   }
>   
> +static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
> +				     struct sk_buff *skb)
> +{
> +	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
> +	u16 tstamp_off = enetc_cb->origin_tstamp_off;
> +	u16 corr_off = enetc_cb->correction_off;
> +	struct enetc_si *si = priv->si;
> +	struct enetc_hw *hw = &si->hw;
> +	__be32 new_sec_l, new_nsec;
> +	__be16 new_sec_h;
> +	u32 lo, hi, nsec;
> +	u8 *data;
> +	u64 sec;
> +	u32 val;
> +
> +	lo = enetc_rd_hot(hw, ENETC_SICTR0);
> +	hi = enetc_rd_hot(hw, ENETC_SICTR1);
> +	sec = (u64)hi << 32 | lo;
> +	nsec = do_div(sec, 1000000000);
> +
> +	/* Update originTimestamp field of Sync packet
> +	 * - 48 bits seconds field
> +	 * - 32 bits nanseconds field
> +	 *
> +	 * In addition, the UDP checksum needs to be updated
> +	 * by software after updating originTimestamp field,
> +	 * otherwise the hardware will calculate the wrong
> +	 * checksum when updating the correction field and
> +	 * update it to the packet.
> +	 */
> +
> +	data = skb_mac_header(skb);
> +	new_sec_h = htons((sec >> 32) & 0xffff);
> +	new_sec_l = htonl(sec & 0xffffffff);
> +	new_nsec = htonl(nsec);
> +	if (enetc_cb->udp) {
> +		struct udphdr *uh = udp_hdr(skb);
> +		__be32 old_sec_l, old_nsec;
> +		__be16 old_sec_h;
> +
> +		old_sec_h = *(__be16 *)(data + tstamp_off);
> +		inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
> +					 new_sec_h, false);
> +
> +		old_sec_l = *(__be32 *)(data + tstamp_off + 2);
> +		inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
> +					 new_sec_l, false);
> +
> +		old_nsec = *(__be32 *)(data + tstamp_off + 6);
> +		inet_proto_csum_replace4(&uh->check, skb, old_nsec,
> +					 new_nsec, false);
> +	}
> +
> +	*(__be16 *)(data + tstamp_off) = new_sec_h;
> +	*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
> +	*(__be32 *)(data + tstamp_off + 6) = new_nsec;
> +
> +	/* Configure single-step register */
> +	val = ENETC_PM0_SINGLE_STEP_EN;
> +	val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
> +	if (enetc_cb->udp)
> +		val |= ENETC_PM0_SINGLE_STEP_CH;
> +
> +	enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP, val);
> +
> +	return lo & ENETC_TXBD_TSTAMP;
> +}
> +
>   static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>   {
>   	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
>   	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
>   	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
> -	struct enetc_hw *hw = &priv->si->hw;
>   	struct enetc_tx_swbd *tx_swbd;
>   	int len = skb_headlen(skb);
>   	union enetc_tx_bd temp_bd;
> @@ -326,67 +393,11 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>   		}
>   
>   		if (do_onestep_tstamp) {
> -			u16 tstamp_off = enetc_cb->origin_tstamp_off;
> -			u16 corr_off = enetc_cb->correction_off;
> -			__be32 new_sec_l, new_nsec;
> -			u32 lo, hi, nsec, val;
> -			__be16 new_sec_h;
> -			u8 *data;
> -			u64 sec;
> -
> -			lo = enetc_rd_hot(hw, ENETC_SICTR0);
> -			hi = enetc_rd_hot(hw, ENETC_SICTR1);
> -			sec = (u64)hi << 32 | lo;
> -			nsec = do_div(sec, 1000000000);
> +			u32 tstamp = enetc_update_ptp_sync_msg(priv, skb);
>   
>   			/* Configure extension BD */
> -			temp_bd.ext.tstamp = cpu_to_le32(lo & 0x3fffffff);
> +			temp_bd.ext.tstamp = cpu_to_le32(tstamp);
>   			e_flags |= ENETC_TXBD_E_FLAGS_ONE_STEP_PTP;
> -
> -			/* Update originTimestamp field of Sync packet
> -			 * - 48 bits seconds field
> -			 * - 32 bits nanseconds field
> -			 *
> -			 * In addition, the UDP checksum needs to be updated
> -			 * by software after updating originTimestamp field,
> -			 * otherwise the hardware will calculate the wrong
> -			 * checksum when updating the correction field and
> -			 * update it to the packet.
> -			 */
> -			data = skb_mac_header(skb);
> -			new_sec_h = htons((sec >> 32) & 0xffff);
> -			new_sec_l = htonl(sec & 0xffffffff);
> -			new_nsec = htonl(nsec);
> -			if (enetc_cb->udp) {
> -				struct udphdr *uh = udp_hdr(skb);
> -				__be32 old_sec_l, old_nsec;
> -				__be16 old_sec_h;
> -
> -				old_sec_h = *(__be16 *)(data + tstamp_off);
> -				inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
> -							 new_sec_h, false);
> -
> -				old_sec_l = *(__be32 *)(data + tstamp_off + 2);
> -				inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
> -							 new_sec_l, false);
> -
> -				old_nsec = *(__be32 *)(data + tstamp_off + 6);
> -				inet_proto_csum_replace4(&uh->check, skb, old_nsec,
> -							 new_nsec, false);
> -			}
> -
> -			*(__be16 *)(data + tstamp_off) = new_sec_h;
> -+			*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
> -+			*(__be32 *)(data + tstamp_off + 6) = new_nsec;

And again some artifacts...

> -
> -			/* Configure single-step register */
> -			val = ENETC_PM0_SINGLE_STEP_EN;
> -			val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
> -			if (enetc_cb->udp)
> -				val |= ENETC_PM0_SINGLE_STEP_CH;
> -
> -			enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP,
> -					  val);
>   		} else if (do_twostep_tstamp) {
>   			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
>   			e_flags |= ENETC_TXBD_E_FLAGS_TWO_STEP_PTP;
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> index 73763e8f4879..377c96325814 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> @@ -614,6 +614,7 @@ enum enetc_txbd_flags {
>   #define ENETC_TXBD_STATS_WIN	BIT(7)
>   #define ENETC_TXBD_TXSTART_MASK GENMASK(24, 0)
>   #define ENETC_TXBD_FLAGS_OFFSET 24
> +#define ENETC_TXBD_TSTAMP	GENMASK(29, 0)
>   
>   static inline __le32 enetc_txbd_set_tx_start(u64 tx_start, u8 flags)
>   {


