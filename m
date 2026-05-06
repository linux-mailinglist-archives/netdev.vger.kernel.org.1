Return-Path: <netdev+bounces-285066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FVrEUjE+2kREgAAu9opvQ
	(envelope-from <netdev+bounces-285066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 00:44:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA534E15E2
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 00:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB1AB300EC7C
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 22:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F7B3B9D91;
	Wed,  6 May 2026 22:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uWUB+XW7"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16F0372670
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 22:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778107423; cv=none; b=aJHHO3qo3eLTjN546aD/vbvlGHNavQIKgDfDLk8tmB4R4m6doC7OLfycS4XiPmAl6BiI7hSOp88kAb00HW8Uj0+ixytURputfC1Qwp6IzKY7gXDKZhAijnzsqKSP/fj7p3tT15RGu2wGZs9K8ZSpCU/S/0eU30Iro2JAKAUu7Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778107423; c=relaxed/simple;
	bh=tixKAEDJAnYdVt3di29GXUTaszKwxFSltvbjtrfu3uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IoXkhG0p9C6HFy9oUgSreXgDDwhb5Je9xhjjONTyrMqVqY1qozV68W4ce692TXrQ7MMCPNA/SIRDotxAEOJcVcMuu3dtu79bkMxQbjTetlayJ+O29vS6H+s4Y5PWKnhHAWy4BZoQU+20IuOzwwwUEHe5PoBmgw+JNZ+ZOQMsih0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uWUB+XW7; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2a15199c-d48f-4034-a907-6efa883d5d99@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778107403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yURQSTjJQ+qtbFe3jellE7Q5DOMcjnDhP6Zyx8QZf7w=;
	b=uWUB+XW7QNy+t0c5a8ftjrI2v2EcXg2o0Hla2P7R52SadZ7zoeb5GnylS/VJBDmCL2sDIl
	t8TZ6ubt3gSz0uiQglvNMC4GORponHP9vhxzZlkdHNOpzMQ2tpmzIZT4DD3a7lpy8dPZh2
	SUb6RWrCnG2FpUR/suDy6EcNG7slaVo=
Date: Wed, 6 May 2026 23:43:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 6/9] net: atlantic: implement AQC113 L2/L3/L4 RX
 filter management filter management management
To: sukhdeeps@marvell.com, netdev@vger.kernel.org
Cc: irusskikh@marvell.com, epomozov@marvell.com, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
References: <20260506135706.2834-1-sukhdeeps@marvell.com>
 <20260506135706.2834-7-sukhdeeps@marvell.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260506135706.2834-7-sukhdeeps@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 4CA534E15E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_FROM(0.00)[bounces-285066-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Action: no action

On 06/05/2026 14:57, sukhdeeps@marvell.com wrote:
> From: Sukhdeep Singh <sukhdeeps@marvell.com>
> 
> Implement complete RX filter management for AQC113 hardware:
> 
> - Add tag-based filter policy with reference-counted sharing, allowing
>    multiple filter rules to share the same L3 or L4 hardware filter
>    when their match criteria are identical.
> - Implement L3 (IPv4/IPv6 source/destination address and protocol)
>    filter find, get (program HW and increment refcount), and put
>    (decrement refcount and clear HW when last user releases).
> - Implement L4 (TCP/UDP/SCTP source/destination port) filter
>    management with the same find/get/put pattern.
> - Add combined L3L4 filter configuration that translates legacy
>    aq_rx_filter_l3l4 commands into AQC113 separate L3+L4 filter
>    programming with Action Resolver Table (ART) entries.
> - Add L2 ethertype filter set/clear with tag-based ART integration.
> - Add MAC address setup using firmware-provided L2 filter base index.
> 
> Update hardware initialization:
> - Use firmware-reported ART section base and count instead of
>    hardcoded 0xFFFF section enable.
> - Enable L3 v6/v4 select mode for simultaneous IPv4/IPv6 filtering.
> - Initialize L3L4 filter indices to -1 on reset.
> 
> Wire up hw_filter_l2_set, hw_filter_l2_clear, hw_filter_l3l4_set,
> hw_set_mac_address, hw_get_version, and hw_get_regs in hw_atl2_ops.
> 
> Signed-off-by: Sukhdeep Singh <sukhdeeps@marvell.com>
> ---
>   .../net/ethernet/aquantia/atlantic/aq_hw.h    |   2 +
>   .../aquantia/atlantic/hw_atl2/hw_atl2.c       | 582 +++++++++++++++++-
>   2 files changed, 580 insertions(+), 4 deletions(-)

[...]

>   
> @@ -380,6 +422,9 @@ static void hw_atl2_hw_init_new_rx_filters(struct aq_hw_s *self)
>   {
>   	u8 *prio_tc_map = self->aq_nic_cfg->prio_tc_map;
>   	struct hw_atl2_priv *priv = self->priv;
> +	u32 art_first_sec, art_last_sec;
> +	u32 art_sections;
> +	u32 art_mask = 0;

no need to init variable which is overwritten later ...

>   	u16 action;
>   	u8 index;
>   	int i;
> @@ -394,9 +439,14 @@ static void hw_atl2_hw_init_new_rx_filters(struct aq_hw_s *self)
>   	 * REC entry is used for further processing. If multiple entries match,
>   	 * the lowest REC entry, Action field will be selected.
>   	 */
> -	hw_atl2_rpf_act_rslvr_section_en_set(self, 0xFFFF);
> +	art_last_sec = priv->art_base_index / 8 + priv->art_count / 8;
> +	art_first_sec = priv->art_base_index / 8;
> +	art_mask = (BIT(art_last_sec) - 1) - (BIT(art_first_sec) - 1);

... here

> +	art_sections = hw_atl2_rpf_act_rslvr_section_en_get(self) | art_mask;
> +	hw_atl2_rpf_act_rslvr_section_en_set(self, art_sections);
> +	hw_atl2_rpf_l3_v6_v4_select_set(self, 1);
>   	hw_atl2_rpfl2_uc_flr_tag_set(self, HW_ATL2_RPF_TAG_BASE_UC,
> -				     HW_ATL2_MAC_UC);
> +				     priv->l2_filters_base_index);
>   	hw_atl2_rpfl2_bc_flr_tag_set(self, HW_ATL2_RPF_TAG_BASE_UC);
>   
>   	/* FW reserves the beginning of ART, thus all driver entries must
> @@ -530,6 +580,35 @@ static int hw_atl2_hw_init_rx_path(struct aq_hw_s *self)
>   	return aq_hw_err_from_flags(self);
>   }
>   
> +static int hw_atl2_hw_mac_addr_set(struct aq_hw_s *self, const u8 *mac_addr)
> +{
> +	struct hw_atl2_priv *priv = self->priv;
> +	u32 location = priv->l2_filters_base_index;
> +	unsigned int h = 0U;
> +	unsigned int l = 0U;
> +	int err = 0;

here again, h, l and err are not used with init values.

> +
> +	if (!mac_addr) {
> +		err = -EINVAL;
> +		goto err_exit;
> +	}
> +	h = (mac_addr[0] << 8) | (mac_addr[1]);
> +	l = (mac_addr[2] << 24) | (mac_addr[3] << 16) |
> +		(mac_addr[4] << 8) | mac_addr[5];
> +
> +	hw_atl_rpfl2_uc_flr_en_set(self, 0U, location);
> +	hw_atl_rpfl2unicast_dest_addresslsw_set(self, l, location);
> +	hw_atl_rpfl2unicast_dest_addressmsw_set(self, h, location);
> +	hw_atl_rpfl2unicast_flr_act_set(self, 1U, location);
> +	hw_atl2_rpfl2_uc_flr_tag_set(self, HW_ATL2_RPF_TAG_BASE_UC, location);
> +	hw_atl_rpfl2_uc_flr_en_set(self, 1U, location);
> +
> +	err = aq_hw_err_from_flags(self);
> +
> +err_exit:
> +	return err;
> +}
> +
>   static int hw_atl2_hw_init(struct aq_hw_s *self, const u8 *mac_addr)
>   {
>   	static u32 aq_hw_atl2_igcr_table_[4][2] = {

[...]


