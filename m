Return-Path: <netdev+bounces-298168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YsRJAsfOKmobxQMAu9opvQ
	(envelope-from <netdev+bounces-298168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:05:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C679672EBE
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:05:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WGljIyaI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298168-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298168-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD5A5300EEBB
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C0C301465;
	Thu, 11 Jun 2026 15:04:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940C0313546
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 15:04:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190288; cv=none; b=dhyW4TzTcue/tCdSU+bCoaW+wjzgyT3O+pKubTWM5VD+FxTPRq8Hbv3T6/1zu7krf0T/ezW4sACihh7vWGCl62/39UecE59wqUB61QL5Ptw6UW7TjyVwgFgrwz4Xa3O7hqOXVx2Wrunypn2AvRaFLxxtXAvFhm/ZpE5g0Ap7cPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190288; c=relaxed/simple;
	bh=KrrC6Rm84jL2WwiXJpnN0x9shItYJRE3h5vYCnZlRrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ph2JlgO/dMawZSCfk+oxZRHIOax7xnOZ6X2eFw3BJjdC/mt1D8TwO237axNCkAPxRoWC3pR/Wl6qnY0zr5s+9Ksk+fYZRHwzYBL7QZimDqRa+O6eboBFHmEwFqPedmY7XPvFwQLSIBfU8qI7E0ysryrYyilfRaSNnSjC+DZjrwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGljIyaI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC561F00893;
	Thu, 11 Jun 2026 15:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781190286;
	bh=PDRJOUSxfNGFQoBrsDJcmWJf50RsYbuzi43rA4XFrIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WGljIyaIWsNrku9MCKteXhzgj4r/Jw22YTE77zA4Fg8Lq2hlV+MhHqP89hqwuNLhO
	 IgHO5OythtyY457InhI1McQOndgj305mr9HA4Z/AjzsvPQDAs28A0pPoxUAJ1yf+tw
	 fkQHiztW6EQLbqtICHPaLF+j+O6go1z0VfkwMatLKTwW3ELKg1EeoBDE1PZBM3f2k6
	 qBF6J9W5MBKNLa5NyajsId0nBhwsj5UL+ERCL5gXaa6S6ejZPjp/lDkq2EjpfntrGd
	 7HDY6sJGFJG9MeCGin77juZqdFrb9sStYI0v034S/Yfw58o+Yi4iF5DonBRuqz9zb5
	 HVjyvgKNhum4w==
Date: Thu, 11 Jun 2026 17:04:44 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Madhur Agrawal <madhur.agrawal@airoha.com>
Subject: Re: [PATCH net-next v4 2/2] net: airoha: defer GDM3/GDM4 WAN mode
 and GDM2 loopback to QoS offload
Message-ID: <airOjLlxSrA40B-F@lore-desk>
References: <20260610-airoha-ethtool-priv_flags-v4-0-60e89cf28fea@kernel.org>
 <20260610-airoha-ethtool-priv_flags-v4-2-60e89cf28fea@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3W6r5hbEJpuvgYEO"
Content-Disposition: inline
In-Reply-To: <20260610-airoha-ethtool-priv_flags-v4-2-60e89cf28fea@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298168-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:madhur.agrawal@airoha.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	RSPAMD_URIBL_FAIL(0.00)[airoha.com:server fail];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C679672EBE


--3W6r5hbEJpuvgYEO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> GDM3 and GDM4 ports require GDM2 loopback to be enabled for hardware
> QoS offload to function. Without it, HTB and ETS offload on these ports
> do not work.
> Previously, GDM3/GDM4 ports were automatically configured as WAN with
> GDM2 loopback enabled during ndo_init(). Add the capability to configure
> GDM3/GDM4 as WAN/LAN on demand when QoS offload is created or destroyed.
> Hook airoha_enable_qos_for_gdm34() into TC_HTB_CREATE so that requesting
> HTB offload on a GDM3/GDM4 LAN port switches it to WAN mode and enables
> GDM2 loopback, with proper rollback on failure. Hook the counterpart
> airoha_disable_qos_for_gdm34() into TC_HTB_DESTROY to restore LAN mode
> when the offloaded qdisc is torn down.
> Since airoha_dev_set_qdma() can now be called on a running device to
> migrate between QDMA blocks, make dev->qdma an RCU pointer so the TX
> path can safely dereference it without holding RTNL.
> Hold flow_offload_mutex in airoha_dev_set_qdma() around the QDMA pointer
> update and __airoha_ppe_set_cpu_port() call, serializing against
> concurrent airoha_ppe_hw_init() in the TC_SETUP_CLSFLOWER offload path.
> Introduce airoha_qdma_deref() helper that wraps rcu_dereference_protected=
()
> with a lockdep condition accepting either rtnl_lock or flow_offload_mutex,
> and use it across all control-path dereferences of the RCU-protected
> dev->qdma pointer.
> Add airoha_disable_gdm2_loopback() to disable GDM2 hw loopback.
>=20
> Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Please find my comments about the following sashiko's report:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260610-airoha-ethtool=
-priv_flags-v4-0-60e89cf28fea%40kernel.org

> ---
>  drivers/net/ethernet/airoha/airoha_eth.c  | 220 ++++++++++++++++++++++++=
++----
>  drivers/net/ethernet/airoha/airoha_eth.h  |  24 +++-
>  drivers/net/ethernet/airoha/airoha_ppe.c  |  18 ++-
>  drivers/net/ethernet/airoha/airoha_regs.h |   1 +
>  4 files changed, 231 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index aeac66df5f3b..10232470a333 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c

[...]

> +static int airoha_disable_gdm2_loopback(struct airoha_gdm_dev *dev)
> +{
> +	struct airoha_gdm_port *port =3D dev->port;
> +	struct airoha_eth *eth =3D dev->eth;
> +	int i, src_port;
> +	u32 pse_port;
> +
> +	src_port =3D eth->soc->ops.get_sport(dev->port, dev->nbq);
> +	if (src_port < 0)
> +		return src_port;
> +
> +	airoha_fe_clear(eth,
> +			REG_SP_DFT_CPORT(src_port >> fls(SP_CPORT_DFT_MASK)),
> +			SP_CPORT_MASK(src_port & SP_CPORT_DFT_MASK));
> +
> +	airoha_fe_set(eth, REG_GDM_FWD_CFG(AIROHA_GDM2_IDX),
> +		      GDM_STRIP_CRC_MASK);
> +	airoha_set_gdm_port_fwd_cfg(eth, REG_GDM_FWD_CFG(AIROHA_GDM2_IDX),
> +				    FE_PSE_PORT_DROP);
> +	airoha_fe_clear(eth, REG_GDM_LPBK_CFG(AIROHA_GDM2_IDX),
> +			LPBK_CHAN_MASK | LPBK_MODE_MASK | LPBK_EN_MASK);
> +	pse_port =3D airoha_ppe_is_enabled(eth, 1) ? FE_PSE_PORT_PPE2
> +						 : FE_PSE_PORT_PPE1;
> +	airoha_set_gdm_port_fwd_cfg(eth, REG_GDM_FWD_CFG(AIROHA_GDM2_IDX),
> +				    pse_port);
> +
> +	airoha_fe_rmw(eth, REG_FE_WAN_PORT, WAN0_MASK,
> +		      FIELD_PREP(WAN0_MASK, AIROHA_GDM2_IDX));
> +
> +	for (i =3D 0; i < eth->soc->num_ppe; i++)
> +		airoha_ppe_clear_cpu_port(dev, i, AIROHA_GDM2_IDX);
> +
> +	/* Enable VIP and IFC for GDM2 */
> +	airoha_fe_set(eth, REG_FE_VIP_PORT_EN, BIT(AIROHA_GDM2_IDX));
> +	airoha_fe_set(eth, REG_FE_IFC_PORT_EN, BIT(AIROHA_GDM2_IDX));
> +
> +	if (port->id =3D=3D AIROHA_GDM4_IDX && airoha_is_7581(eth)) {
> +		u32 mask =3D FC_ID_OF_SRC_PORT_MASK(dev->nbq);
> +
> +		airoha_fe_rmw(eth, REG_SRC_PORT_FC_MAP6, mask,
> +			      FC_MAP6_DEF_VALUE & mask);
> +	}
> +
> +	return 0;
> +}

- Does this disable counterpart fully undo what airoha_enable_gdm2_loopback=
() does?=20
  I think the current implementation is correct since:
  - 0xffffffff is already the default value for REG_GDM_TXCHN_EN()
  - 0xffff is already the default value for REG_GDM_RXCHN_EN()
  - REG_GDM_LEN_CFG() will be modified by another patch (not in the series).
  - WAN1_MASK/WAN1_EN_MASK default value is 0 and the driver does not confi=
gure WAN1.
  - if the device is configured properly get_sport() callback can't fail.

> +
>  static struct airoha_gdm_dev *
>  airoha_get_wan_gdm_dev(struct airoha_eth *eth)
>  {
> @@ -2005,15 +2055,36 @@ airoha_get_wan_gdm_dev(struct airoha_eth *eth)
>  static void airoha_dev_set_qdma(struct airoha_gdm_dev *dev)
>  {
>  	struct net_device *netdev =3D netdev_from_priv(dev);
> +	struct airoha_qdma *cur_qdma, *qdma;
>  	struct airoha_eth *eth =3D dev->eth;
>  	int ppe_id;

[...]

>  }
> @@ -3027,6 +3112,89 @@ static int airoha_tc_htb_delete_leaf_queue(struct =
net_device *netdev,
>  	return 0;
>  }
> =20
> +static int airoha_enable_qos_for_gdm34(struct net_device *netdev,
> +				       struct netlink_ext_ack *extack)
> +{
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_gdm_port *port =3D dev->port;
> +	struct airoha_eth *eth =3D dev->eth;
> +	int err;
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

- Is there a behavioural regression for GDM3/GDM4 devices that were
  auto-configured as WAN at ndo_init() time?
  I do not think there is any behavioural regression since in the current
  codebase it is not possible modify WAN/LAN configuration at runtime.
  Moreover, using tc APIs to set WAN/LAN configuration as suggested by
  Andrew, in order to configure a second device as WAN (or to set the
  current one as LAN), requires to move the current WAN device to LAN
  destroying the associated Qdisc.

> +	/* Verify the WAN device is not already configured */
> +	if (airoha_get_wan_gdm_dev(eth)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "WAN device already configured");
> +		return -EBUSY;
> +	}

- The commit message says flow_offload_mutex was added to "serialize against
  concurrent airoha_ppe_hw_init() in the TC_SETUP_CLSFLOWER offload path".
  I think this is a bug and I will address the issue on the next revision.

> +
> +	dev->flags |=3D AIROHA_PRIV_F_WAN;
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
> +	return 0;
> +
> +error_disable_loopback:
> +	/* Restore previous LAN configuration */
> +	airoha_disable_gdm2_loopback(dev);
> +error_disable_wan:
> +	dev->flags &=3D ~AIROHA_PRIV_F_WAN;
> +	airoha_dev_set_qdma(dev);
> +
> +	return err;
> +}

- Is the rollback symmetric on the airoha_enable_gdm2_loopback() failure
  path?  airoha_enable_gdm2_loopback() performs many register writes
  before its only failure check (eth->soc->ops.get_sport()):
  - This has been already addressed in
    https://lore.kernel.org/netdev/20260608-airoha_enable_gdm2_loopback-min=
or-change-v1-1-1787a0f42b31@kernel.org/

> +
> +static void airoha_disable_qos_for_gdm34(struct net_device *netdev)
> +{
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_gdm_port *port =3D dev->port;
> +	int err;
> +
> +	if (port->id !=3D AIROHA_GDM3_IDX &&
> +	    port->id !=3D AIROHA_GDM4_IDX) {
> +		return;
> +	}
> +
> +	if (airoha_is_lan_gdm_dev(dev)) /* Already disabled */
> +		return;
> +
> +	err =3D airoha_disable_gdm2_loopback(dev);
> +	if (err)
> +		netdev_warn(netdev,
> +			    "failed disabling GDM2 loopback: %d\n", err);
> +
> +	dev->flags &=3D ~AIROHA_PRIV_F_WAN;
> +	airoha_dev_set_qdma(dev);
> +	airoha_set_macaddr(dev, netdev->dev_addr);
> +	if (netif_running(netdev))
> +		airoha_set_gdm_port_fwd_cfg(dev->eth,
> +					    REG_GDM_FWD_CFG(port->id),
> +					    FE_PSE_PORT_PPE1);
> +}
> +
>  static int airoha_tc_htb_destroy(struct net_device *netdev)
>  {
>  	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> @@ -3035,6 +3203,8 @@ static int airoha_tc_htb_destroy(struct net_device =
*netdev)
>  	for_each_set_bit(q, dev->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
>  		airoha_tc_remove_htb_queue(netdev, q);
> =20
> +	airoha_disable_qos_for_gdm34(netdev);
> +
>  	return 0;
>  }
> =20
> @@ -3059,7 +3229,7 @@ static int airoha_tc_setup_qdisc_htb(struct net_dev=
ice *dev,
>  {
>  	switch (opt->command) {
>  	case TC_HTB_CREATE:
> -		break;
> +		return airoha_enable_qos_for_gdm34(dev, opt->extack);

- Should ETS installed directly on a GDM3/GDM4 LAN-configured device also
  enable the loopback, or should that case be rejected with an extack
  message so the behaviour matches the description in the commit message?
  - ETS can't be used as ROOT Qdisc.

Regards,
Lorenzo

>  	case TC_HTB_DESTROY:
>  		return airoha_tc_htb_destroy(dev);
>  	case TC_HTB_NODE_MODIFY:
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index 8f42973f9cf5..8795af0010b6 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -543,8 +543,8 @@ enum airoha_priv_flags {
>  };
> =20
>  struct airoha_gdm_dev {
> +	struct airoha_qdma __rcu *qdma;
>  	struct airoha_gdm_port *port;
> -	struct airoha_qdma *qdma;
>  	struct airoha_eth *eth;
> =20
>  	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
> @@ -676,7 +676,27 @@ int airoha_get_fe_port(struct airoha_gdm_dev *dev);
>  bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
>  			     struct airoha_gdm_dev *dev);
> =20
> -void airoha_ppe_set_cpu_port(struct airoha_gdm_dev *dev, u8 ppe_id, u8 f=
port);
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
> +void __airoha_ppe_set_cpu_port(struct airoha_gdm_dev *dev, u8 ppe_id, u8=
 fport);
> +void airoha_ppe_clear_cpu_port(struct airoha_gdm_dev *dev, u8 ppe_id, u8=
 fport);
> +
> +static inline void airoha_ppe_set_cpu_port(struct airoha_gdm_dev *dev,
> +					   u8 ppe_id, u8 fport)
> +{
> +	mutex_lock(&flow_offload_mutex);
> +	__airoha_ppe_set_cpu_port(dev, ppe_id, fport);
> +	mutex_unlock(&flow_offload_mutex);
> +}
> +
>  bool airoha_ppe_is_enabled(struct airoha_eth *eth, int index);
>  void airoha_ppe_check_skb(struct airoha_ppe_dev *dev, struct sk_buff *sk=
b,
>  			  u16 hash, bool rx_wlan);
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ether=
net/airoha/airoha_ppe.c
> index 91bcc55a6ac6..0ee0dd385645 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -15,7 +15,7 @@
>  #include "airoha_regs.h"
>  #include "airoha_eth.h"
> =20
> -static DEFINE_MUTEX(flow_offload_mutex);
> +DEFINE_MUTEX(flow_offload_mutex);
>  static DEFINE_SPINLOCK(ppe_lock);
> =20
>  static const struct rhashtable_params airoha_flow_table_params =3D {
> @@ -84,10 +84,10 @@ static u32 airoha_ppe_get_timestamp(struct airoha_ppe=
 *ppe)
>  			     AIROHA_FOE_IB1_BIND_TIMESTAMP);
>  }
> =20
> -void airoha_ppe_set_cpu_port(struct airoha_gdm_dev *dev, u8 ppe_id, u8 f=
port)
> +void __airoha_ppe_set_cpu_port(struct airoha_gdm_dev *dev, u8 ppe_id, u8=
 fport)
>  {
> -	struct airoha_qdma *qdma =3D dev->qdma;
> -	struct airoha_eth *eth =3D qdma->eth;
> +	struct airoha_qdma *qdma =3D airoha_qdma_deref(dev);
> +	struct airoha_eth *eth =3D dev->eth;
>  	u8 qdma_id =3D qdma - &eth->qdma[0];
>  	u32 fe_cpu_port;
> =20
> @@ -97,6 +97,14 @@ void airoha_ppe_set_cpu_port(struct airoha_gdm_dev *de=
v, u8 ppe_id, u8 fport)
>  		      __field_prep(DFT_CPORT_MASK(fport), fe_cpu_port));
>  }
> =20
> +void airoha_ppe_clear_cpu_port(struct airoha_gdm_dev *dev, u8 ppe_id, u8=
 fport)
> +{
> +	mutex_lock(&flow_offload_mutex);
> +	airoha_fe_clear(dev->eth, REG_PPE_DFT_CPORT(ppe_id, fport),
> +			DFT_CPORT_MASK(fport));
> +	mutex_unlock(&flow_offload_mutex);
> +}
> +
>  static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
>  {
>  	u32 sram_ppe_num_data_entries =3D PPE_SRAM_NUM_ENTRIES, sram_num_entrie=
s;
> @@ -195,7 +203,7 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
>  			ppe_id =3D !airoha_is_lan_gdm_dev(dev) &&
>  				 airoha_ppe_is_enabled(eth, 1);
>  			fport =3D airoha_get_fe_port(dev);
> -			airoha_ppe_set_cpu_port(dev, ppe_id, fport);
> +			__airoha_ppe_set_cpu_port(dev, ppe_id, fport);
>  		}
>  	}
>  }
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

--3W6r5hbEJpuvgYEO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCairOiwAKCRA6cBh0uS2t
rCaFAQCSsssJ/9cDud9EdCPVkevjlyVvfflqVljh48ezEuiwGQEA4t/5n7S2ihzS
6WsKS7mr2ZCyWrkozd+lrgR1witfRwo=
=zL3Q
-----END PGP SIGNATURE-----

--3W6r5hbEJpuvgYEO--

