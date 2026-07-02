Return-Path: <netdev+bounces-304201-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZctsIA1wRmpaVAsAu9opvQ
	(envelope-from <netdev+bounces-304201-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 16:05:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D19986F8ACC
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 16:05:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="N6ap/tSF";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304201-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304201-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8E38302D11E
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 14:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892234BCADE;
	Thu,  2 Jul 2026 14:02:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3534BCABE
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 14:02:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000970; cv=none; b=hP4aLLjMWXmusK6DGRFz2lYPZJE9GAp2Ks/20HKN5sfXDfjNgIic0/MeyWhMpGAbSy42OeVDCaHIkvM2lfIxsI7EMzIfVlnTKU2auRUYeCu0N8W84skZLeizzfbLY2kxu8IYOEwy6kQ/D6o7uLmExeS7nAKQK2j7ociLci48Tww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000970; c=relaxed/simple;
	bh=XVXKqpNPkcNdW11yAslFKHJ/xsc+ujYJ3Q2i1JO7L/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Np76FDkVZGPTv0346Ry3O/y3xXFpzdDm+tVKQr8QNeK/XWLcW2RHFXAOFFsYehulzictsv73Edj3w44X1Oyk7uxQXLCeTCHzWojTzTCxsRDw0vEw7K7qNQ5rFoSpNC8WpelqKkfmgt8ImIWKUgyjrN0tusPE5NQ0TcJkhgTylKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6ap/tSF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0729E1F00A3A;
	Thu,  2 Jul 2026 14:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783000968;
	bh=TRLANPogjG6BWRTX1aijmLnnh9jWiE73CCVCRyKbidE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N6ap/tSFutvf35GNTz0GsvSkLAEWYxueVqNTildc9lfjjAsYMBYyhDhhZZQJEh6iY
	 3p3teI3pgWlL4y0/ZxxfsM+5S680oE+4878wOPWz9gjxMdJ0lGOx3hLmeMh64lDaTK
	 DtjWoUmygyb5qEr4HiAgCI59ywtogq3eTDKraP/vxbq3vDo7LXmM8He/sn/p82ndoL
	 Im9/KVEihiF2j5BzZlpds1+uzUMV654VFn2SZ/idZLMS3+lWFGlzZKz4gC4U6caDVw
	 NgPJvyGwULwvCFOxR86dzw3HFroaT0OboKzS2Y5tv7/Te8y1LDHJQjD7Qw74AcCRkt
	 VlLCbHyNc3/4A==
Date: Thu, 2 Jul 2026 16:02:46 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Madhur Agrawal <madhur.agrawal@airoha.com>
Subject: Re: [PATCH net-next v7 3/3] net: airoha: defer GDM3/GDM4 WAN mode
 and GDM2 loopback to QoS offload
Message-ID: <akZvhnIYe-FMfoOo@lore-desk>
References: <20260701-airoha-ethtool-priv_flags-v7-0-b4153bd44428@kernel.org>
 <20260701-airoha-ethtool-priv_flags-v7-3-b4153bd44428@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3joh1UuMhMZBOkHW"
Content-Disposition: inline
In-Reply-To: <20260701-airoha-ethtool-priv_flags-v7-3-b4153bd44428@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304201-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:aleksander.lobakin@intel.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:madhur.agrawal@airoha.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:email,airoha.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D19986F8ACC


--3joh1UuMhMZBOkHW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 01, Lorenzo Bianconi wrote:
> GDM3 and GDM4 ports require GDM2 loopback to be enabled for hardware
> QoS offload to function. Without it, HTB and ETS offload on these ports
> do not work.
> Previously, GDM3/GDM4 ports were automatically configured as WAN with
> GDM2 loopback enabled during ndo_init(). Add the capability to configure
> GDM3/GDM4 as WAN/LAN on demand when QoS offload is created or destroyed.
> Hook airoha_enable_qos_for_gdm34() into TC_HTB_CREATE so that requesting
> HTB offload on a GDM3/GDM4 LAN port switches it to WAN mode and enables
> GDM2 loopback, with proper rollback on failure. Introduce the
> AIROHA_DEV_F_QOS flag to track whether a device has an active HTB
> qdisc; clear it on TC_HTB_DESTROY. The device keeps its WAN role after
> qdisc teardown so that its configuration is preserved until another
> device explicitly needs the WAN role for QoS offload.
> If another GDM3/GDM4 device already holds the WAN role without an active
> QoS qdisc, demote it to LAN before promoting the requesting device. Skip
> the demotion when the requesting device is itself already the WAN device.
> Since airoha_dev_set_qdma() can now be called on a running device to
> migrate between QDMA blocks, make dev->qdma an RCU pointer so the TX
> path can safely dereference it without holding RTNL.
> Hold flow_offload_mutex in airoha_enable_qos_for_gdm34() and
> airoha_disable_qos_for_gdm34() around the dev->flags update,
> airoha_dev_set_qdma() and GDM2 loopback configuration, serializing
> against concurrent airoha_ppe_hw_init() in the TC_SETUP_CLSFLOWER
> offload path.
> Introduce airoha_qdma_deref() helper that wraps rcu_dereference_protected=
()
> with a lockdep condition accepting either rtnl_lock or flow_offload_mutex,
> and use it across all control-path dereferences of the RCU-protected
> dev->qdma pointer.
> Add airoha_disable_gdm2_loopback() to disable GDM2 hw loopback.
>=20
> Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Commenting on Sashiko's report:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260701-airoha-ethtool=
-priv_flags-v7-0-b4153bd44428%40kernel.org

> ---
>  drivers/net/ethernet/airoha/airoha_eth.c  | 219 ++++++++++++++++++++++++=
++----
>  drivers/net/ethernet/airoha/airoha_eth.h  |  13 +-
>  drivers/net/ethernet/airoha/airoha_ppe.c  |   9 +-
>  drivers/net/ethernet/airoha/airoha_regs.h |   1 +
>  4 files changed, 214 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 2c9ceb9f16f8..609a5ea67fb7 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c

[...]

> +static void airoha_disable_qos_for_gdm34(struct net_device *netdev)
> +{
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_gdm_port *port =3D dev->port;
> +	int err;
> +
> +	if (port->id !=3D AIROHA_GDM3_IDX &&
> +	    port->id !=3D AIROHA_GDM4_IDX)
> +		return;
> +
> +	err =3D airoha_disable_gdm2_loopback(dev);
> +	if (err)
> +		netdev_warn(netdev,
> +			    "failed disabling GDM2 loopback: %d\n", err);
> +
> +	dev->flags &=3D ~AIROHA_DEV_F_WAN;
> +	airoha_dev_set_qdma(dev);
> +
> +	airoha_set_macaddr(dev, netdev->dev_addr);

- Should the return value of airoha_set_macaddr() be checked here?
  airoha_set_macaddr() can return -EINVAL when the device MAC MSBs do
  not match other same-role sibling devices:
  	if (!is_zero_ether_addr(ref_addr) && memcmp(ref_addr, addr, 3)) {
  		...
  		return -EINVAL;
  	}
  Since AIROHA_DEV_F_WAN has just been cleared and dev->qdma has been
  switched to QDMA0, the scan now iterates LAN-role peers.  If the
  ex-WAN MAC's top three bytes disagree with the LAN peers, the call
  returns -EINVAL and the HW MAC registers are left unwritten while
  the software state has already been flipped to LAN.
  - The asymmetry is intentional. airoha_disable_qos_for_gdm34() is a
    teardown path that returns void, the demotion has to happen regardless.
    Moreover, airoha_set_macaddr() can fail just if the device is
    misconfigured.


> +	if (netif_running(netdev))
> +		airoha_set_gdm_port_fwd_cfg(dev->eth,
> +					    REG_GDM_FWD_CFG(port->id),
> +					    FE_PSE_PORT_PPE1);
> +}
> +
> +static int airoha_enable_qos_for_gdm34(struct net_device *netdev,
> +				       struct netlink_ext_ack *extack)
> +{
> +	struct airoha_gdm_dev *wan_dev, *dev =3D netdev_priv(netdev);
> +	struct airoha_gdm_port *port =3D dev->port;
> +	struct airoha_eth *eth =3D dev->eth;
> +	int err =3D -EBUSY;
> +
> +	if (port->id !=3D AIROHA_GDM3_IDX &&
> +	    port->id !=3D AIROHA_GDM4_IDX) {
> +		/* HW QoS is always supported by GDM1 and GDM2 */
> +		return 0;
> +	}
> +
> +	if (!airoha_is_lan_gdm_dev(dev)) /* Already enabled */
> +		return 0;
> +
> +	mutex_lock(&flow_offload_mutex);
> +
> +	wan_dev =3D airoha_get_wan_gdm_dev(eth);
> +	if (wan_dev) {
> +		if ((wan_dev->flags & AIROHA_DEV_F_QOS) ||
> +		    wan_dev->port->id =3D=3D AIROHA_GDM2_IDX) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "QoS configured for WAN device");
> +			goto error_unlock;
> +		}
> +		airoha_disable_qos_for_gdm34(netdev_from_priv(wan_dev));
> +	}
> +
> +	dev->flags |=3D AIROHA_DEV_F_WAN;
> +	airoha_dev_set_qdma(dev);
> +	err =3D airoha_enable_gdm2_loopback(dev);
> +	if (err)
> +		goto error_disable_wan;
> +
> +	err =3D airoha_set_macaddr(dev, netdev->dev_addr);
> +	if (err)
> +		goto error_disable_loopback;
> +
> +	if (netif_running(netdev)) {
> +		u32 pse_port;
> +
> +		pse_port =3D airoha_ppe_is_enabled(eth, 1) ? FE_PSE_PORT_PPE2
> +							 : FE_PSE_PORT_PPE1;
> +		airoha_set_gdm_port_fwd_cfg(eth, REG_GDM_FWD_CFG(port->id),
> +					    pse_port);
> +	}
> +
> +	mutex_unlock(&flow_offload_mutex);
> +
> +	return 0;
> +
> +error_disable_loopback:
> +	airoha_disable_gdm2_loopback(dev);
> +error_disable_wan:
> +	dev->flags &=3D ~AIROHA_DEV_F_WAN;
> +	airoha_dev_set_qdma(dev);
> +error_unlock:
> +	mutex_unlock(&flow_offload_mutex);
> +
> +	return err;

- Does this failure path fully implement the "proper rollback on failure"
  described in the commit message?
  Earlier in the function, if a peer wan_dev exists it is demoted via:
  	airoha_disable_qos_for_gdm34(netdev_from_priv(wan_dev));
  That helper clears AIROHA_DEV_F_WAN on wan_dev, swaps its RCU qdma
  pointer to QDMA0, disables GDM2 loopback, rewrites its MAC to the LAN
  registers, and (if wan_dev was running) sets its REG_GDM_FWD_CFG to
  FE_PSE_PORT_PPE1.
  If a later step for the requesting device fails, the error labels
  error_disable_loopback / error_disable_wan / error_unlock only unwind
  the requesting device.  The demoted wan_dev is never re-promoted.
  For example, airoha_set_macaddr(dev, netdev->dev_addr) can return
  -EINVAL when the requesting device's MAC MSBs disagree with the other
  WAN-role peers:
  	if (!is_zero_ether_addr(ref_addr) && memcmp(ref_addr, addr, 3)) {
  		...
  		return -EINVAL;
  	}
  In that case the failed tc qdisc add returns to userspace, the
  requesting device is rolled back to LAN, and no GDM3/GDM4 device holds
  the WAN role anymore.  The previously working WAN device silently loses
  its WAN role and QDMA1 binding.
  Should the error paths re-promote wan_dev, or should the preconditions
  that can fail (MAC MSB check, GDM2 loopback setup) be validated before
  mutating the peer's state?
  - This issue has been already reported in the past. If the configuration
    fails, I think there is no point to move back the previous device as WA=
N.
    The user will be able to log again and re-apply the configuration.
    Moreover, airoha_enable_qos_for_gdm34() can fail just if the device is
    misconfigured (failures in airoha_enable_gdm2_loopback() or
    airoha_set_macaddr()).

Regards,
Lorenzo

> +}
> +
>  static int airoha_tc_htb_destroy(struct net_device *netdev)
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> @@ -3057,6 +3217,8 @@ static int airoha_tc_htb_destroy(struct net_device =
*netdev)
>  	for_each_set_bit(q, dev->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
>  		airoha_tc_remove_htb_queue(netdev, q);
> =20
> +	dev->flags &=3D ~AIROHA_DEV_F_QOS;
> +
>  	return 0;
>  }
> =20
> @@ -3076,24 +3238,33 @@ static int airoha_tc_get_htb_get_leaf_queue(struc=
t net_device *netdev,
>  	return 0;
>  }
> =20
> -static int airoha_tc_setup_qdisc_htb(struct net_device *dev,
> +static int airoha_tc_setup_qdisc_htb(struct net_device *netdev,
>  				     struct tc_htb_qopt_offload *opt)
>  {
>  	switch (opt->command) {
> -	case TC_HTB_CREATE:
> +	case TC_HTB_CREATE: {
> +		struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +		int err;
> +
> +		err =3D airoha_enable_qos_for_gdm34(netdev, opt->extack);
> +		if (err)
> +			return err;
> +
> +		dev->flags |=3D AIROHA_DEV_F_QOS;
>  		break;
> +	}
>  	case TC_HTB_DESTROY:
> -		return airoha_tc_htb_destroy(dev);
> +		return airoha_tc_htb_destroy(netdev);
>  	case TC_HTB_NODE_MODIFY:
> -		return airoha_tc_htb_modify_queue(dev, opt);
> +		return airoha_tc_htb_modify_queue(netdev, opt);
>  	case TC_HTB_LEAF_ALLOC_QUEUE:
> -		return airoha_tc_htb_alloc_leaf_queue(dev, opt);
> +		return airoha_tc_htb_alloc_leaf_queue(netdev, opt);
>  	case TC_HTB_LEAF_DEL:
>  	case TC_HTB_LEAF_DEL_LAST:
>  	case TC_HTB_LEAF_DEL_LAST_FORCE:
> -		return airoha_tc_htb_delete_leaf_queue(dev, opt);
> +		return airoha_tc_htb_delete_leaf_queue(netdev, opt);
>  	case TC_HTB_LEAF_QUERY_QUEUE:
> -		return airoha_tc_get_htb_get_leaf_queue(dev, opt);
> +		return airoha_tc_get_htb_get_leaf_queue(netdev, opt);
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index ac5f571f3e53..a314330fcd48 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -537,11 +537,12 @@ struct airoha_qdma {
> =20
>  enum airoha_dev_flags {
>  	AIROHA_DEV_F_WAN =3D BIT(0),
> +	AIROHA_DEV_F_QOS =3D BIT(1),
>  };
> =20
>  struct airoha_gdm_dev {
> +	struct airoha_qdma __rcu *qdma;
>  	struct airoha_gdm_port *port;
> -	struct airoha_qdma *qdma;
>  	struct airoha_eth *eth;
> =20
>  	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
> @@ -677,6 +678,16 @@ int airoha_get_fe_port(struct airoha_gdm_dev *dev);
>  bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
>  			     struct airoha_gdm_dev *dev);
> =20
> +extern struct mutex flow_offload_mutex;
> +
> +static inline struct airoha_qdma *
> +airoha_qdma_deref(struct airoha_gdm_dev *dev)
> +{
> +	return rcu_dereference_protected(dev->qdma,
> +					 lockdep_rtnl_is_held() ||
> +					 lockdep_is_held(&flow_offload_mutex));
> +}
> +
>  void airoha_ppe_set_cpu_port(struct airoha_gdm_dev *dev, u8 ppe_id, u8 f=
port);
>  bool airoha_ppe_is_enabled(struct airoha_eth *eth, int index);
>  void airoha_ppe_check_skb(struct airoha_ppe_dev *dev, struct sk_buff *sk=
b,
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ether=
net/airoha/airoha_ppe.c
> index 42f4b0f21d17..0f260c50ac3c 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -15,7 +15,10 @@
>  #include "airoha_regs.h"
>  #include "airoha_eth.h"
> =20
> -static DEFINE_MUTEX(flow_offload_mutex);
> +/* Serialize airoha_gdm_dev flags, QDMA pointer and PPE CPU port
> + * configuration.
> + */
> +DEFINE_MUTEX(flow_offload_mutex);
>  static DEFINE_SPINLOCK(ppe_lock);
> =20
>  static const struct rhashtable_params airoha_flow_table_params =3D {
> @@ -86,8 +89,8 @@ static u32 airoha_ppe_get_timestamp(struct airoha_ppe *=
ppe)
> =20
>  void airoha_ppe_set_cpu_port(struct airoha_gdm_dev *dev, u8 ppe_id, u8 f=
port)
>  {
> -	struct airoha_qdma *qdma =3D dev->qdma;
> -	struct airoha_eth *eth =3D qdma->eth;
> +	struct airoha_qdma *qdma =3D airoha_qdma_deref(dev);
> +	struct airoha_eth *eth =3D dev->eth;
>  	u8 qdma_id =3D qdma - &eth->qdma[0];
>  	u32 fe_cpu_port;
> =20
> diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethe=
rnet/airoha/airoha_regs.h
> index 436f3c8779c1..4e17dfbcf2b8 100644
> --- a/drivers/net/ethernet/airoha/airoha_regs.h
> +++ b/drivers/net/ethernet/airoha/airoha_regs.h
> @@ -376,6 +376,7 @@
> =20
>  #define REG_SRC_PORT_FC_MAP6		0x2298
>  #define FC_ID_OF_SRC_PORT_MASK(_n)	GENMASK(4 + ((_n) << 3), ((_n) << 3))
> +#define FC_MAP6_DEF_VALUE		0x1b1a1918
> =20
>  #define REG_CDM5_RX_OQ1_DROP_CNT	0x29d4
> =20
>=20
> --=20
> 2.54.0
>=20

--3joh1UuMhMZBOkHW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCakZvhgAKCRA6cBh0uS2t
rIRYAP9gzcl34KcdQs9GVZfh4viK4ItMdpu29s/BbxNVtTtMNAD/RwZlJOqrEZwM
fGTIrKivFyTiI/EeXxJk4PrT3kNzNwI=
=zq2G
-----END PGP SIGNATURE-----

--3joh1UuMhMZBOkHW--

