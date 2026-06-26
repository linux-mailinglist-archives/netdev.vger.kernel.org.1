Return-Path: <netdev+bounces-302116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zRpvKAg2PmoUBgkAu9opvQ
	(envelope-from <netdev+bounces-302116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 10:19:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F040D6CB44C
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 10:19:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="SnRcd/da";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302116-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302116-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C363A3005AC0
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 08:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6774A3D1CB2;
	Fri, 26 Jun 2026 08:18:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1314249EB
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 08:18:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782461927; cv=none; b=e0c+tox6itWhFG2GLRhcnuFUzwRU9clQ4ciV2w4ORUb3b9x549qvFwMsokvJvkq/LO8WwfGKxwmeqmX6w4EXx+ZMIkDCb2hqEoPbynGs6FcRCYgzrzVuPTIsY9wePveHQrGCn5C2XNuRH7lb8vO0h1oMt5J8qLhEGRUOJSVHgMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782461927; c=relaxed/simple;
	bh=o7JHGSPEr05FmWr7e06PcVBRXc6RXcjzhcoE2AaXMVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/QgqW+r/+H3HAvf85rJino5rUtJMPQr75k92l3y8t7GDOSylp6lpHFRuHo80tEVFZi1IlQ8UYBESvpbHhE0+XXzfW+JMf1gNenAhCjvNeSrys3lUd/jtfIHErU7T93NOStmQUfHnZnmYHsCl165tjV2yD6OinFp/oHOk3zrgXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnRcd/da; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598BC1F000E9;
	Fri, 26 Jun 2026 08:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782461925;
	bh=ZtxQhPJu30QBa2gHBza3bH34Gpdki7PPc1OqZ0o6O+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SnRcd/da4ssM836Uj7Ka02pmNfKYkBanvDPZV/Qb97XwSBcdI6RxDOblxnKNdHPBo
	 I/m8XAd2sbwuj1Qu01YSLqcwHUQeA/YfotV2/iU5gBnJTrfH36XhE9ZwysN8VOjekL
	 gJ+CHyZ4u9Cn+D6BAoZJ+owrke+ZdSrUUvcIp+aBc9F9FX/d8taCAlKk+JL+3qgrDU
	 GT2zy+SUwSpsrsUFbzS7lAybbR6oZQBm+RvqpQ+eM7UBsk1spDNX3ENRi4j5w0Li8a
	 Ba4/LslxO7t1u+HiAO8sfIorU3DNx8OwRCgEpDKFvFBoZYAbxYTn/PcbzliveA1FRD
	 XyS8aZHDlpztg==
Date: Fri, 26 Jun 2026 10:18:43 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Madhur Agrawal <madhur.agrawal@airoha.com>
Subject: Re: [PATCH net] net: airoha: fix max receive size configuration
Message-ID: <aj4145PuomGhMM1J@lore-desk>
References: <20260625-airoha-fix-rx-max-len-v1-1-45b9b827358d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BF1a/QprwyKDmdJk"
Content-Disposition: inline
In-Reply-To: <20260625-airoha-fix-rx-max-len-v1-1-45b9b827358d@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302116-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:madhur.agrawal@airoha.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,vger.kernel.org:from_smtp,airoha.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F040D6CB44C


--BF1a/QprwyKDmdJk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Set the GDM maximum receive size to AIROHA_MAX_RX_SIZE unconditionally
> during hardware initialization instead of updating it according to the
> configured MTU. This avoids dropping incoming frames that exceed the
> current MTU but could still be processed by the networking stack, which
> is able to fragment the reply on the TX side (e.g. ICMP echo requests).
> Move the per-port MTU configuration to the PPE egress path where it
> belongs, and set the tx frame size running airoha_ppe_set_xmit_frame_size=
()
> to dynamically track the maximum MTU across running interfaces sharing
> the same PPE instance.
> Fix the PPE MTU register addressing to pack two port entries per
> register word and add WAN_MTU0 configuration for non-LAN GDM devices.

commenting on sashiko's report:
https://sashiko.dev/#/patchset/20260625-airoha-fix-rx-max-len-v1-1-45b9b827=
358d%40kernel.org

>=20
> Fixes: 54d989d58d2a ("net: airoha: Move min/max packet len configuration =
in airoha_dev_open()")
> Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c  | 68 ++++++++++---------------=
------
>  drivers/net/ethernet/airoha/airoha_eth.h  |  2 +
>  drivers/net/ethernet/airoha/airoha_ppe.c  | 39 +++++++++++++-----
>  drivers/net/ethernet/airoha/airoha_regs.h |  9 ++--
>  4 files changed, 58 insertions(+), 60 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 932b3a3df2e5..3f451c2d4c24 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -178,10 +178,15 @@ static void airoha_fe_maccr_init(struct airoha_eth =
*eth)
>  {
>  	int p;
> =20
> -	for (p =3D 1; p <=3D ARRAY_SIZE(eth->ports); p++)
> +	for (p =3D 1; p <=3D ARRAY_SIZE(eth->ports); p++) {
>  		airoha_fe_set(eth, REG_GDM_FWD_CFG(p),
>  			      GDM_TCP_CKSUM_MASK | GDM_UDP_CKSUM_MASK |
>  			      GDM_IP4_CKSUM_MASK | GDM_DROP_CRC_ERR_MASK);
> +		airoha_fe_rmw(eth, REG_GDM_LEN_CFG(p),
> +			      GDM_SHORT_LEN_MASK | GDM_LONG_LEN_MASK,
> +			      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |
> +			      FIELD_PREP(GDM_LONG_LEN_MASK, AIROHA_MAX_RX_SIZE));
> +	}
> =20
>  	airoha_fe_rmw(eth, REG_CDM_VLAN_CTRL(1), CDM_VLAN_MASK,
>  		      FIELD_PREP(CDM_VLAN_MASK, 0x8100));
> @@ -1831,13 +1836,24 @@ static void airoha_update_hw_stats(struct airoha_=
gdm_dev *dev)
>  	spin_unlock(&port->stats_lock);

- This is a pre-existing issue, but can the spin_lock() used in
  airoha_update_hw_stats() cause a deadlock?
  If a process context holds port->stats_lock via spin_lock() and is preemp=
ted
  by a networking softirq on the same CPU that calls dev_get_stats()
  (which invokes ndo_get_stats64 -> airoha_update_hw_stats()), will the sof=
tirq
  spin forever trying to acquire the same lock? Should this use spin_lock_b=
h()
  instead?
  - The reported issue has not been introduced by this patch. Moreover, I do
    not think this is a real problem since in the current codebase
    airoha_update_hw_stats() is always run in process context and not in-irq
    context.

>  }
> =20
> +static void airoha_dev_set_xmit_frame_size(struct net_device *netdev)
> +{
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +
> +	airoha_ppe_set_xmit_frame_size(dev);
> +	if (!airoha_is_lan_gdm_dev(dev))
> +		airoha_fe_rmw(dev->eth, REG_WAN_MTU0, WAN_MTU0_MASK,
> +			      FIELD_PREP(WAN_MTU0_MASK,
> +					 VLAN_ETH_HLEN + netdev->mtu));
> +}

- Does this unconditional write to REG_WAN_MTU0 break sibling network devic=
es
  sharing the same WAN port?=20
  If multiple interfaces share the same hardware port, this appears to over=
write
  the shared register using only the current interface's MTU, ignoring the
  maximum MTU of any active sibling interfaces. Could this cause the hardwa=
re to
  drop frames for sibling interfaces if their MTU is larger than the most
  recently configured interface?
  - This is not a real issue since we can have at most a single WAN port in=
 the
    system

> +
>  static int airoha_dev_open(struct net_device *netdev)
>  {
> -	int err, len =3D ETH_HLEN + netdev->mtu + ETH_FCS_LEN;
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
>  	struct airoha_gdm_port *port =3D dev->port;
> -	u32 cur_len, pse_port =3D FE_PSE_PORT_PPE1;
>  	struct airoha_qdma *qdma =3D dev->qdma;
> +	u32 pse_port =3D FE_PSE_PORT_PPE1;
> +	int err;
> =20
>  	netif_tx_start_all_queues(netdev);
>  	err =3D airoha_set_vip_for_gdm_port(dev, true);

[...]

>  static int airoha_dev_stop(struct net_device *netdev)
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> @@ -1909,7 +1889,7 @@ static int airoha_dev_stop(struct net_device *netde=
v)
>  	airoha_set_vip_for_gdm_port(dev, false);
> =20
>  	if (--port->users)
> -		airoha_set_port_mtu(dev->eth, port);
> +		airoha_ppe_set_xmit_frame_size(dev);

- Does this stop path fail to update the WAN MTU limit?
  When an interface is stopped, airoha_ppe_set_xmit_frame_size() recalculat=
es
  the PPE MTU, but it looks like the global REG_WAN_MTU0 register is not up=
dated
  here. Will this prevent the MTU limit from correctly shrinking when an
  interface is brought down?
  - This is not a real issue since, as pointed out above, we can have at mo=
st a
    single WAN port in the system, so there is no point to reconfigure
    REG_WAN_MTU0 if this interface is stopped.

>  	else
>  		airoha_set_gdm_port_fwd_cfg(qdma->eth,
>  					    REG_GDM_FWD_CFG(port->id),
> @@ -1962,10 +1942,6 @@ static int airoha_enable_gdm2_loopback(struct airo=
ha_gdm_dev *dev)
>  		      FIELD_PREP(LPBK_CHAN_MASK, chan) |
>  		      LBK_GAP_MODE_MASK | LBK_LEN_MODE_MASK |
>  		      LBK_CHAN_MODE_MASK | LPBK_EN_MASK);
> -	airoha_fe_rmw(eth, REG_GDM_LEN_CFG(AIROHA_GDM2_IDX),
> -		      GDM_SHORT_LEN_MASK | GDM_LONG_LEN_MASK,
> -		      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |
> -		      FIELD_PREP(GDM_LONG_LEN_MASK, AIROHA_MAX_MTU));
>  	/* Forward the traffic to the proper GDM port */
>  	pse_port =3D port->id =3D=3D AIROHA_GDM3_IDX ? FE_PSE_PORT_GDM3
>  					       : FE_PSE_PORT_GDM4;
> @@ -2098,7 +2074,7 @@ static int airoha_dev_change_mtu(struct net_device =
*netdev, int mtu)
> =20
>  	WRITE_ONCE(netdev->mtu, mtu);
>  	if (port->users)
> -		airoha_set_port_mtu(dev->eth, port);
> +		airoha_dev_set_xmit_frame_size(netdev);
> =20
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index d7ff8c5200e2..0c3fb6e5d7f1 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -23,6 +23,7 @@
>  #define AIROHA_MAX_DSA_PORTS		7
>  #define AIROHA_MAX_NUM_RSTS		3
>  #define AIROHA_MAX_MTU			9220
> +#define AIROHA_MAX_RX_SIZE		16128
>  #define AIROHA_MAX_PACKET_SIZE		2048
>  #define AIROHA_NUM_QOS_CHANNELS		4
>  #define AIROHA_NUM_QOS_QUEUES		8
> @@ -676,6 +677,7 @@ int airoha_get_fe_port(struct airoha_gdm_dev *dev);
>  bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
>  			     struct airoha_gdm_dev *dev);
> =20
> +void airoha_ppe_set_xmit_frame_size(struct airoha_gdm_dev *dev);
>  void airoha_ppe_set_cpu_port(struct airoha_gdm_dev *dev, u8 ppe_id, u8 f=
port);
>  bool airoha_ppe_is_enabled(struct airoha_eth *eth, int index);
>  void airoha_ppe_check_skb(struct airoha_ppe_dev *dev, struct sk_buff *sk=
b,
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ether=
net/airoha/airoha_ppe.c
> index 42f4b0f21d17..e7c78293002a 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -97,6 +97,33 @@ void airoha_ppe_set_cpu_port(struct airoha_gdm_dev *de=
v, u8 ppe_id, u8 fport)
>  		      __field_prep(DFT_CPORT_MASK(fport), fe_cpu_port));
>  }
> =20
> +void airoha_ppe_set_xmit_frame_size(struct airoha_gdm_dev *dev)
> +{
> +	struct airoha_gdm_port *port =3D dev->port;
> +	struct airoha_eth *eth =3D dev->eth;
> +	int i, ppe_id, index;
> +	u32 len =3D 0;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(port->devs); i++) {
> +		struct airoha_gdm_dev *d =3D port->devs[i];
> +		struct net_device *netdev;
> +
> +		if (!d)
> +			continue;
> +
> +		netdev =3D netdev_from_priv(d);
> +		if (netif_running(netdev))
> +			len =3D max_t(u32, len, netdev->mtu);
> +	}
> +	len +=3D VLAN_ETH_HLEN;
> +
> +	ppe_id =3D !airoha_is_lan_gdm_dev(dev) && airoha_ppe_is_enabled(eth, 1);
> +	index =3D port->id =3D=3D AIROHA_GDM4_IDX ? 7 : port->id;
> +	airoha_fe_rmw(eth, REG_PPE_MTU(ppe_id, index),
> +		      FP_EGRESS_MTU_MASK(index),
> +		      __field_prep(FP_EGRESS_MTU_MASK(index), len));

- Does this leave the egress MTU limit uninitialized for other PPE engines?
  The patch removes the loop in airoha_ppe_hw_init() that previously initia=
lized
  REG_PPE_MTU for all ports on all available PPEs. This function now only
  configures it for a single ppe_id.
  During cross-PPE routing (such as WAN-to-LAN), if PPE1 (WAN) forwards a p=
acket
  to a LAN port, it will check REG_PPE_MTU(1, LAN_port). Since this registe=
r was
  only configured for PPE0, will the uninitialized limit (0) cause the pack=
et to
  be dropped?
  - This is not a real issue since every airoha_gdm_dev/net_device is
    associated to a PPE engine/QDMA according to the logic in
    airoha_dev_open()/airoha_dev_set_qdma(). The other PPE engine's MTU wil=
l be
    updated according to the assigned net_device.

Regards,
Lorenzo

> +}
> +
>  static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
>  {
>  	u32 sram_ppe_num_data_entries =3D PPE_SRAM_NUM_ENTRIES, sram_num_entrie=
s;
> @@ -115,8 +142,6 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
>  		PPE_RAM_NUM_ENTRIES_SHIFT(sram_ppe_num_data_entries);
> =20
>  	for (i =3D 0; i < eth->soc->num_ppe; i++) {
> -		int p;
> -
>  		airoha_fe_wr(eth, REG_PPE_TB_BASE(i),
>  			     ppe->foe_dma + sram_tb_size);
> =20
> @@ -166,15 +191,6 @@ static void airoha_ppe_hw_init(struct airoha_ppe *pp=
e)
>  		airoha_fe_wr(eth, REG_PPE_HASH_SEED(i), PPE_HASH_SEED);
>  		airoha_fe_clear(eth, REG_PPE_PPE_FLOW_CFG(i),
>  				PPE_FLOW_CFG_IP6_6RD_MASK);
> -
> -		for (p =3D 0; p < ARRAY_SIZE(eth->ports); p++)
> -			airoha_fe_rmw(eth, REG_PPE_MTU(i, p),
> -				      FP0_EGRESS_MTU_MASK |
> -				      FP1_EGRESS_MTU_MASK,
> -				      FIELD_PREP(FP0_EGRESS_MTU_MASK,
> -						 AIROHA_MAX_MTU) |
> -				      FIELD_PREP(FP1_EGRESS_MTU_MASK,
> -						 AIROHA_MAX_MTU));
>  	}
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
> @@ -196,6 +212,7 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
>  				 airoha_ppe_is_enabled(eth, 1);
>  			fport =3D airoha_get_fe_port(dev);
>  			airoha_ppe_set_cpu_port(dev, ppe_id, fport);
> +			airoha_ppe_set_xmit_frame_size(dev);
>  		}
>  	}
>  }
> diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethe=
rnet/airoha/airoha_regs.h
> index 436f3c8779c1..6fed63d013b4 100644
> --- a/drivers/net/ethernet/airoha/airoha_regs.h
> +++ b/drivers/net/ethernet/airoha/airoha_regs.h
> @@ -327,9 +327,8 @@
>  #define PPE_SRAM_TABLE_EN_MASK			BIT(0)
> =20
>  #define REG_PPE_MTU_BASE(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x304)
> -#define REG_PPE_MTU(_m, _n)			(REG_PPE_MTU_BASE(_m) + ((_n) << 2))
> -#define FP1_EGRESS_MTU_MASK			GENMASK(29, 16)
> -#define FP0_EGRESS_MTU_MASK			GENMASK(13, 0)
> +#define REG_PPE_MTU(_m, _n)			(REG_PPE_MTU_BASE(_m) + (((_n) / 2) << 2))
> +#define FP_EGRESS_MTU_MASK(_n)			GENMASK(13 + (((_n) % 2) << 4), ((_n) %=
 2) << 4)
> =20
>  #define REG_PPE_RAM_CTRL(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x31c)
>  #define PPE_SRAM_CTRL_ACK_MASK			BIT(31)
> @@ -377,6 +376,10 @@
>  #define REG_SRC_PORT_FC_MAP6		0x2298
>  #define FC_ID_OF_SRC_PORT_MASK(_n)	GENMASK(4 + ((_n) << 3), ((_n) << 3))
> =20
> +#define REG_WAN_MTU0			0x2300
> +#define WAN_MTU1_MASK			GENMASK(29, 16)
> +#define WAN_MTU0_MASK			GENMASK(13, 0)
> +
>  #define REG_CDM5_RX_OQ1_DROP_CNT	0x29d4
> =20
>  /* QDMA */
>=20
> ---
> base-commit: fd1269e454089abda0e4f9e5e25ecd02a90ab009
> change-id: 20260618-airoha-fix-rx-max-len-57654b661646
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo@kernel.org>
>=20

--BF1a/QprwyKDmdJk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaj414wAKCRA6cBh0uS2t
rLvbAP94ZhyV7OMjBDV3xaCqtFSlUkd5Ry2z2BWqSZuABjs1OwEA2sf5yxm2DyBH
I+O1FXfoDBvmOPl6x7yKZX4XXWiYrQM=
=chVI
-----END PGP SIGNATURE-----

--BF1a/QprwyKDmdJk--

