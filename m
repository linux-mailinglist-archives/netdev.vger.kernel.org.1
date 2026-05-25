Return-Path: <netdev+bounces-291268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0I08FewQFGpeJQcAu9opvQ
	(envelope-from <netdev+bounces-291268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:05:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C26705C8537
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1002C30053F2
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 09:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9809F3D3324;
	Mon, 25 May 2026 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIEcyMxu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4130C3955C8;
	Mon, 25 May 2026 09:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779699663; cv=none; b=J5sD8vhA+ccq3zCRuEC7htj+KhzzdllmqwyUIaPaHWw9VBk6dFsPFxSpcDyR0AUn0F/sUZwbxQH+ivwsnmypy4jwPzePfc4Gxkf0ixEVwid+1vkmQ09Yx8v83jPr/LhfaWdRV5cJa1vbnNp+qiAaaYn2cpPpAnPKgZDKA2x2BPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779699663; c=relaxed/simple;
	bh=FEDOyaRnFzj0vOGFA0I7k72mNoN7ZMCSvVN8Konghnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLKPEqlxHwMSaue0FxRT0Na6eDqE9+5Xb/yf4/h+LEN+zZhQ0n2hxK2rrjJD+zLVu57tNtFev6ilgqSl1A86FlAsikIvYpkL28CF7kRMmoWVMSOH8WL7nsJLUOAm0wsC/sMoxKp1uEOxrrah2Vvm3VXGPzANLw7hjL9l9YAuBZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIEcyMxu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DD81F000E9;
	Mon, 25 May 2026 09:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779699661;
	bh=UeoHQch1oMdstyCnYZH7EQlEUf3dGM6B7qt7LqarNNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YIEcyMxuUeexI/PCE4FsPcLXgrNNaULxh2vwgKcnQTWIApzhV1Wpy8pxfeiuRDLZ5
	 hEFWY6+4m4TxUaSobQSuGragaXcISFUa/WzkCTpkiUnZx7dKvEEdXyuKJKYtPDS9SQ
	 5MyEagbtmM8T12ovSi2n8uw4zcEGGqdl9TY6zDDEHkO3GvkkGjcs7OTTrwE2eEkpja
	 akNJH1Sq2E5wx2/j6F7mBHEC05/Gyrdtscfk4EUHToU3KJoVrLa1pM82iFil3spp4d
	 vj4ou/en0GLntrDY0AZdUOnlEuT1Ra95GM+6n/X1xiyG1pnbTDIQd0X6kvesMkUiXg
	 HiY+GanVH3MIQ==
Date: Mon, 25 May 2026 10:09:06 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jihong Min <hurryman2212@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: bind WLAN-bound flows on PPE
 driver L2 cache miss
Message-ID: <ahQDon-nio0STA4E@lore-desk>
References: <20260524224330.3995807-1-hurryman2212@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rpTEQ6n3Q6FSHVWF"
Content-Disposition: inline
In-Reply-To: <20260524224330.3995807-1-hurryman2212@gmail.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291268-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C26705C8537
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--rpTEQ6n3Q6FSHVWF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The Linux bridge FDB can resolve a destination station to WDMA even when
> the Airoha PPE driver's L2 offload cache has no entry for that MAC pair.
> The normal bind path only checks the PPE driver's L2 offload cache, so an
> unbound PPE hit for WLAN egress can stay unbound even though the bridge
> already knows the right output path, unless a later offload event fills
> that PPE driver cache.
>=20
> This matters for bridge-visible WLAN egress, such as wired-to-WLAN
> forwarding or WLAN peer forwarding across another BSS, radio or MLO link.
> Same-link or same-radio intra-BSS forwarding can stay inside the WLAN
> datapath and is not covered.

Hi Jihong,

In order to offload L2 flows, I assume you are using the OpenWrt bridger
package, right?
IIUC the issue you want to resolve is we are not adding PPE L2 entries for
the specified cases (same-link or same-radio intra-BSS forwarding), correct?
Using this approach, we are breaking the assumption PPE flow-table and hw
flow-table are in sync. If the issue is the one described above, why not
fixing the problem directly in the bridger package?
Moreover, I see you developed the patch using Codex:gpt-5.5. Have you teste=
d it
on a real hw?

Some comments inline.

Regards,
Lorenzo

>=20
> Before touching the PPE table, resolve the destination MAC through the
> bridge device above the ingress netdev. If the PPE driver's L2 offload
> cache lookup misses, bind the hardware flow to the resolved CDM4/WDMA
> path.
>=20
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Jihong Min <hurryman2212@gmail.com>
> ---
>  drivers/net/ethernet/airoha/airoha_ppe.c | 138 +++++++++++++++++++----
>  1 file changed, 119 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ether=
net/airoha/airoha_ppe.c
> index 26da519236bf..ea932e6d87f6 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -803,65 +803,163 @@ static void airoha_ppe_foe_flow_remove_entry(struc=
t airoha_ppe *ppe,
>  }
> =20
>  static int
> -airoha_ppe_foe_commit_subflow_entry(struct airoha_ppe *ppe,
> -				    struct airoha_flow_table_entry *e,
> -				    u32 hash, bool rx_wlan)
> +airoha_ppe_foe_commit_subflow(struct airoha_ppe *ppe,
> +			      const struct airoha_foe_entry *bridge,

maybe l2_hwe instead of bridge?

> +			      u32 hash, bool rx_wlan)
>  {
>  	u32 mask =3D AIROHA_FOE_IB1_BIND_PACKET_TYPE | AIROHA_FOE_IB1_BIND_UDP;
>  	struct airoha_foe_entry *hwe_p, hwe;
> -	struct airoha_flow_table_entry *f;
>  	int type;
> =20
>  	hwe_p =3D airoha_ppe_foe_get_entry_locked(ppe, hash);
>  	if (!hwe_p)
>  		return -EINVAL;
> =20
> -	f =3D kzalloc_obj(*f, GFP_ATOMIC);
> -	if (!f)
> -		return -ENOMEM;
> -
> -	hlist_add_head(&f->l2_subflow_node, &e->l2_flows);
> -	f->type =3D FLOW_TYPE_L2_SUBFLOW;
> -	f->hash =3D hash;
> -
>  	memcpy(&hwe, hwe_p, sizeof(*hwe_p));
> -	hwe.ib1 =3D (hwe.ib1 & mask) | (e->data.ib1 & ~mask);
> +	hwe.ib1 =3D (hwe.ib1 & mask) | (bridge->ib1 & ~mask);
> =20
>  	type =3D FIELD_GET(AIROHA_FOE_IB1_BIND_PACKET_TYPE, hwe.ib1);
>  	if (type >=3D PPE_PKT_TYPE_IPV6_ROUTE_3T) {
> -		memcpy(&hwe.ipv6.l2, &e->data.bridge.l2, sizeof(hwe.ipv6.l2));
> -		hwe.ipv6.ib2 =3D e->data.bridge.ib2;
> +		memcpy(&hwe.ipv6.l2, &bridge->bridge.l2,
> +		       sizeof(hwe.ipv6.l2));
> +		hwe.ipv6.ib2 =3D bridge->bridge.ib2;
>  		/* setting smac_id to 0xf instruct the hw to keep original
>  		 * source mac address
>  		 */
>  		hwe.ipv6.l2.src_mac_hi =3D FIELD_PREP(AIROHA_FOE_MAC_SMAC_ID,
>  						    0xf);
>  	} else {
> -		memcpy(&hwe.bridge.l2, &e->data.bridge.l2,
> +		memcpy(&hwe.bridge.l2, &bridge->bridge.l2,
>  		       sizeof(hwe.bridge.l2));
> -		hwe.bridge.ib2 =3D e->data.bridge.ib2;
> +		hwe.bridge.ib2 =3D bridge->bridge.ib2;
>  		if (type =3D=3D PPE_PKT_TYPE_IPV4_HNAPT)
>  			memcpy(&hwe.ipv4.new_tuple, &hwe.ipv4.orig_tuple,
>  			       sizeof(hwe.ipv4.new_tuple));
>  	}
> =20
> -	hwe.bridge.data =3D e->data.bridge.data;
> -	airoha_ppe_foe_commit_entry(ppe, &hwe, hash, rx_wlan);
> +	hwe.bridge.data =3D bridge->bridge.data;
> +
> +	return airoha_ppe_foe_commit_entry(ppe, &hwe, hash, rx_wlan);
> +}
> +
> +static int
> +airoha_ppe_foe_commit_subflow_entry(struct airoha_ppe *ppe,
> +				    struct airoha_flow_table_entry *e,
> +				    u32 hash, bool rx_wlan)
> +{
> +	struct airoha_flow_table_entry *f;
> +	int err;
> +
> +	f =3D kzalloc_obj(*f, GFP_ATOMIC);
> +	if (!f)
> +		return -ENOMEM;
> +
> +	err =3D airoha_ppe_foe_commit_subflow(ppe, &e->data, hash, rx_wlan);
> +	if (err) {
> +		kfree(f);
> +		return err;
> +	}
> +
> +	hlist_add_head(&f->l2_subflow_node, &e->l2_flows);
> +	f->type =3D FLOW_TYPE_L2_SUBFLOW;
> +	f->hash =3D hash;
> =20
>  	return 0;
>  }
> =20
> +static bool
> +airoha_ppe_foe_prepare_wdma_subflow_dev(struct airoha_ppe *ppe,
> +					struct net_device *dev,
> +					struct airoha_flow_data *data,
> +					struct airoha_foe_entry *hwe)
> +{
> +	u32 pse_port;
> +	int err;
> +
> +	err =3D airoha_ppe_foe_entry_prepare(ppe->eth, hwe, dev,
> +					   PPE_PKT_TYPE_BRIDGE, data, 0);
> +	if (err)
> +		return false;
> +
> +	pse_port =3D FIELD_GET(AIROHA_FOE_IB2_PSE_PORT, hwe->bridge.ib2);
> +	if (pse_port !=3D FE_PSE_PORT_CDM4)
> +		return false;
> +
> +	return true;

	return pse_port =3D=3D FE_PSE_PORT_CDM4;

> +}
> +
> +static struct net_device *
> +airoha_ppe_foe_get_bridge_master(struct net_device *dev)
> +{
> +	struct net_device *master =3D NULL;
> +
> +	rcu_read_lock();
> +	master =3D netdev_master_upper_dev_get_rcu(dev);
> +	if (master && netif_is_bridge_master(master))
> +		dev_hold(master);
> +	else
> +		master =3D NULL;
> +	rcu_read_unlock();
> +
> +	return master;
> +}
> +
> +static bool
> +airoha_ppe_foe_prepare_wdma_subflow(struct airoha_ppe *ppe,
> +				    struct sk_buff *skb,
> +				    struct airoha_foe_entry *hwe)
> +{
> +	struct ethhdr *eh =3D eth_hdr(skb);
> +	struct airoha_flow_data data =3D {};
> +	struct net_device *master;
> +
> +	if (!is_valid_ether_addr(eh->h_source) ||
> +	    !is_valid_ether_addr(eh->h_dest))
> +		return false;
> +
> +	ether_addr_copy(data.eth.h_dest, eh->h_dest);
> +	ether_addr_copy(data.eth.h_source, eh->h_source);
> +
> +	if (!skb->dev)
> +		return false;
> +
> +	/* WLAN egress unbound hits can arrive before flowtable creates the
> +	 * L2 master flow normally used for subflow binding. Resolve only
> +	 * through the bridge master so dev_fill_forward_path() must use the
> +	 * bridge FDB for the destination MAC. Calling the ingress AP netdev
> +	 * directly can describe the source station's WDMA path and would
> +	 * corrupt Wi-Fi-to-wired flows whose real egress is not WDMA.
> +	 */
> +	master =3D airoha_ppe_foe_get_bridge_master(skb->dev);
> +	if (!master)
> +		return false;
> +
> +	if (airoha_ppe_foe_prepare_wdma_subflow_dev(ppe, master, &data,
> +						    hwe)) {
> +		dev_put(master);
> +		return true;
> +	}
> +
> +	dev_put(master);
> +	return false;

maybe something like:

	ret =3D airoha_ppe_foe_prepare_wdma_subflow_dev();
	dev_put(master);

	return ret;

> +}
> +
>  static void airoha_ppe_foe_insert_entry(struct airoha_ppe *ppe,
>  					struct sk_buff *skb,
>  					u32 hash, bool rx_wlan)
>  {
> +	struct airoha_foe_entry wdma_hwe =3D {};
>  	struct airoha_flow_table_entry *e;
>  	struct airoha_foe_bridge br =3D {};
>  	struct airoha_foe_entry *hwe;
>  	bool commit_done =3D false;
> +	bool wdma_ready =3D false;
>  	struct hlist_node *n;
>  	u32 index, state;
> =20
> +	wdma_ready =3D airoha_ppe_foe_prepare_wdma_subflow(ppe, skb,
> +							 &wdma_hwe);
> +
>  	spin_lock_bh(&ppe_lock);
> =20
>  	hwe =3D airoha_ppe_foe_get_entry_locked(ppe, hash);
> @@ -899,6 +997,8 @@ static void airoha_ppe_foe_insert_entry(struct airoha=
_ppe *ppe,
>  				   airoha_l2_flow_table_params);
>  	if (e)
>  		airoha_ppe_foe_commit_subflow_entry(ppe, e, hash, rx_wlan);
> +	else if (wdma_ready)
> +		airoha_ppe_foe_commit_subflow(ppe, &wdma_hwe, hash, rx_wlan);
>  unlock:
>  	spin_unlock_bh(&ppe_lock);
>  }
> --=20
> 2.53.0
>=20

--rpTEQ6n3Q6FSHVWF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCahQDogAKCRA6cBh0uS2t
rN93AP0YUr9JwzmpTsYtCD1Nc5tVXTHXsLjdT1ptc+8TMXpdNgD5AYKClz/UwHmf
1eU6vGiJ+33bsHSq9QKC3z76zf/tNA8=
=zPLM
-----END PGP SIGNATURE-----

--rpTEQ6n3Q6FSHVWF--

