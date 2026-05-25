Return-Path: <netdev+bounces-291375-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GK/MG6Z5FGokNgcAu9opvQ
	(envelope-from <netdev+bounces-291375-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:32:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 238385CCE93
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 906833011074
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D0A31A556;
	Mon, 25 May 2026 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqD4pyse"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E021A23A4;
	Mon, 25 May 2026 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779726755; cv=none; b=thmQPw3ib8vqT2psy154zoaArkeHhp2R6ogQHY61ldrTfkKpxpfVdFDbkdBPO2E33X0GONDcWwSoCPsEAjPGF47UKwXVB7f9b0fxmOMBgqisNgn8/OmJKUx+FloctQFpNc4XaQNIKhSQFmRVu4HQ6eJySfIEYOuaOjd96TcjA5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779726755; c=relaxed/simple;
	bh=JMn/jTvIEqbk1Bge6YUiC7sc/IUKCtFePbxfn77QRdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GR973Kyq77HAeLS1cz7ZlvRt7MgGFyszJZpvioJvRMPw/oIlmNa9OpwuIvvIyQNbPWlfquSl5Ghh8TJ5VdVV1xmm5lYu9uCFeCnOcCcLaxS3qPrXTZ0SvX9HWIStUouzW4v/ziIPV4CHXmVebSJac5pufUNP2cfq120I7EyEB5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqD4pyse; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30711F000E9;
	Mon, 25 May 2026 16:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779726754;
	bh=m7y95Inmu9m2zm/tI9luqN9D8svSjAdVhUGbDgOWXbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oqD4pysedSXXv9rZF3HWuQZu0ErxZTWhkSry6CslLEV9GlOIxzcVU90tILNM7or0n
	 TYMdFCfSZbdWpJSQplFbP/5LGLNLAjMGtF/2vAyKCMxQoCCi0/IMqqgO45BMx0jVQD
	 y+6/VqRyU+Y+hgku10ijRPQc8GTmSfswEfpE6x/MSQrT5JdztfsBPSW0rg7XCTa3AU
	 er91jqcUao48ZsxK+9wTcHAMwMi4KA6agsqXgtpZLxHNEZT+9s2XzbLotPiW2s3OgD
	 kdWivBKnzuLqSIRnpvc0nwAH/x6qx8MIKE0SMc3rYhrtyb9hX/l4CVIAsPj/wWEjwp
	 LZLxF9of+AzPg==
Date: Mon, 25 May 2026 18:32:31 +0200
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
Message-ID: <ahR5n-fdQ6b4q_MA@lore-desk>
References: <20260524224330.3995807-1-hurryman2212@gmail.com>
 <ahQDon-nio0STA4E@lore-desk>
 <a08289e7-641c-489e-8d89-6eae9f092f90@gmail.com>
 <ahRonGRDCqdFTBQm@lore-desk>
 <82d0e4a5-76b1-4c86-a153-2500c60e8063@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="52YazzJl1iU1tUud"
Content-Disposition: inline
In-Reply-To: <82d0e4a5-76b1-4c86-a153-2500c60e8063@gmail.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291375-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 238385CCE93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--52YazzJl1iU1tUud
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> On 5/26/26 00:19, Lorenzo Bianconi wrote:
> >>
> >>
> >> On 5/25/26 17:09, Lorenzo Bianconi wrote:
> >>>> The Linux bridge FDB can resolve a destination station to WDMA even =
when
> >>>> the Airoha PPE driver's L2 offload cache has no entry for that MAC p=
air.
> >>>> The normal bind path only checks the PPE driver's L2 offload cache, =
so an
> >>>> unbound PPE hit for WLAN egress can stay unbound even though the bri=
dge
> >>>> already knows the right output path, unless a later offload event fi=
lls
> >>>> that PPE driver cache.
> >>>>
> >>>> This matters for bridge-visible WLAN egress, such as wired-to-WLAN
> >>>> forwarding or WLAN peer forwarding across another BSS, radio or MLO =
link.
> >>>> Same-link or same-radio intra-BSS forwarding can stay inside the WLAN
> >>>> datapath and is not covered.
> >>>
> >>> Hi Jihong,
> >>
> >> Hi, Lorenzo.
> >>
> >>>
> >>> In order to offload L2 flows, I assume you are using the OpenWrt brid=
ger
> >>> package, right?
> >>
> >> Actually, no.
> >>
> >> I am using Fanboy's OpenWrt `test` build for the Lumen W1700K2,
> >> together with several of my other patches. It does not include the
> >> bridger package specifically. It now uses native nft-based offloading
> >> with `kmod-br-netfilter`.
> >=20
> > according to my understanding this is not merged yet, right? I guess the
> > patches should be based on official/accepted code.
> >=20
>=20
> Yes, you are right. I just checked current net-next and realized that the
> bridge/L2 nft_flow_offload pieces used in my test environment are not
> merged upstream yet. Sorry, I should have checked this before submitting
> the patch.

ack, no worries ;)

>=20
> Since I cannot properly test the current upstream code plus bridger at the
> moment, I will put this patch on hold.
>=20
> I will also check whether this should instead be fixed on the
> nft_flow_offload side.

ack.

Regards,
Lorenzo

>=20
>=20
> Sincerely,
> Jihong Min
>=20
> >>
> >>> IIUC the issue you want to resolve is we are not adding PPE L2 entrie=
s for
> >>> the specified cases (same-link or same-radio intra-BSS forwarding), c=
orrect?
> >>
> >> No. As written in the patch message, this specifically addresses
> >> bridge-visible WLAN egress, such as:
> >>
> >> 1. wired-to-WLAN forwarding
> >> 2. WLAN peer forwarding across another BSS, radio, or MLO link
> >>
> >> Same-link or same-radio intra-BSS forwarding can stay inside the WLAN
> >> datapath and is not covered by this patch, although it did show poor
> >> performance, whether that is due to shared airtime or not. That case
> >> appears to belong to the Wi-Fi stack/driver datapath, such as the
> >> mac80211/mt76/mt7996 path, rather than to this Airoha PPE fallback pat=
h.
> >=20
> > according to my understanding the l2 nft-based offloading solution shou=
ld
> > add the missing info to PPE flow-table. As I pointed out, it should be
> > in-sync with hw flow-table. It seems a bug in the nft code to me.
> >=20
> >>
> >>> Using this approach, we are breaking the assumption PPE flow-table an=
d hw
> >>> flow-table are in sync. If the issue is the one described above, why =
not
> >>> fixing the problem directly in the bridger package?
> >>
> >> Again, this problem exists in an environment without bridger.
> >=20
> > In order to offload L2 traffic bridger is mandatory. Do you mean the is=
sue
> > occurs even on L3 scenario?
> >=20
> >>
> >>> Moreover, I see you developed the patch using Codex:gpt-5.5. Have you=
 tested it
> >>> on a real hw?
> >>
> >> Yes. This has been tested on my Lumen W1700K2 with the environment
> >> described above. MLO Wi-Fi P2P communication and some wired-to-WLAN
> >> cases were indeed left unbound by PPE. CPU usage was high, and the
> >> unbound throughput was close to 50% of what this patch achieves now.
> >=20
> > ack
> >=20
> > Regards,
> > Lorenzo
> >=20
> >>
> >>>
> >>> Some comments inline.
> >>>
> >>> Regards,
> >>> Lorenzo
> >>>>>
> >>>> Before touching the PPE table, resolve the destination MAC through t=
he
> >>>> bridge device above the ingress netdev. If the PPE driver's L2 offlo=
ad
> >>>> cache lookup misses, bind the hardware flow to the resolved CDM4/WDMA
> >>>> path.
> >>>>
> >>>> Assisted-by: Codex:gpt-5.5
> >>>> Signed-off-by: Jihong Min <hurryman2212@gmail.com>
> >>>> ---
> >>>>  drivers/net/ethernet/airoha/airoha_ppe.c | 138 +++++++++++++++++++-=
---
> >>>>  1 file changed, 119 insertions(+), 19 deletions(-)
> >>>>
> >>>> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/=
ethernet/airoha/airoha_ppe.c
> >>>> index 26da519236bf..ea932e6d87f6 100644
> >>>> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> >>>> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> >>>> @@ -803,65 +803,163 @@ static void airoha_ppe_foe_flow_remove_entry(=
struct airoha_ppe *ppe,
> >>>>  }
> >>>> =20
> >>>>  static int
> >>>> -airoha_ppe_foe_commit_subflow_entry(struct airoha_ppe *ppe,
> >>>> -				    struct airoha_flow_table_entry *e,
> >>>> -				    u32 hash, bool rx_wlan)
> >>>> +airoha_ppe_foe_commit_subflow(struct airoha_ppe *ppe,
> >>>> +			      const struct airoha_foe_entry *bridge,
> >>>
> >>> maybe l2_hwe instead of bridge?
> >>>
> >>>> +			      u32 hash, bool rx_wlan)
> >>>>  {
> >>>>  	u32 mask =3D AIROHA_FOE_IB1_BIND_PACKET_TYPE | AIROHA_FOE_IB1_BIND=
_UDP;
> >>>>  	struct airoha_foe_entry *hwe_p, hwe;
> >>>> -	struct airoha_flow_table_entry *f;
> >>>>  	int type;
> >>>> =20
> >>>>  	hwe_p =3D airoha_ppe_foe_get_entry_locked(ppe, hash);
> >>>>  	if (!hwe_p)
> >>>>  		return -EINVAL;
> >>>> =20
> >>>> -	f =3D kzalloc_obj(*f, GFP_ATOMIC);
> >>>> -	if (!f)
> >>>> -		return -ENOMEM;
> >>>> -
> >>>> -	hlist_add_head(&f->l2_subflow_node, &e->l2_flows);
> >>>> -	f->type =3D FLOW_TYPE_L2_SUBFLOW;
> >>>> -	f->hash =3D hash;
> >>>> -
> >>>>  	memcpy(&hwe, hwe_p, sizeof(*hwe_p));
> >>>> -	hwe.ib1 =3D (hwe.ib1 & mask) | (e->data.ib1 & ~mask);
> >>>> +	hwe.ib1 =3D (hwe.ib1 & mask) | (bridge->ib1 & ~mask);
> >>>> =20
> >>>>  	type =3D FIELD_GET(AIROHA_FOE_IB1_BIND_PACKET_TYPE, hwe.ib1);
> >>>>  	if (type >=3D PPE_PKT_TYPE_IPV6_ROUTE_3T) {
> >>>> -		memcpy(&hwe.ipv6.l2, &e->data.bridge.l2, sizeof(hwe.ipv6.l2));
> >>>> -		hwe.ipv6.ib2 =3D e->data.bridge.ib2;
> >>>> +		memcpy(&hwe.ipv6.l2, &bridge->bridge.l2,
> >>>> +		       sizeof(hwe.ipv6.l2));
> >>>> +		hwe.ipv6.ib2 =3D bridge->bridge.ib2;
> >>>>  		/* setting smac_id to 0xf instruct the hw to keep original
> >>>>  		 * source mac address
> >>>>  		 */
> >>>>  		hwe.ipv6.l2.src_mac_hi =3D FIELD_PREP(AIROHA_FOE_MAC_SMAC_ID,
> >>>>  						    0xf);
> >>>>  	} else {
> >>>> -		memcpy(&hwe.bridge.l2, &e->data.bridge.l2,
> >>>> +		memcpy(&hwe.bridge.l2, &bridge->bridge.l2,
> >>>>  		       sizeof(hwe.bridge.l2));
> >>>> -		hwe.bridge.ib2 =3D e->data.bridge.ib2;
> >>>> +		hwe.bridge.ib2 =3D bridge->bridge.ib2;
> >>>>  		if (type =3D=3D PPE_PKT_TYPE_IPV4_HNAPT)
> >>>>  			memcpy(&hwe.ipv4.new_tuple, &hwe.ipv4.orig_tuple,
> >>>>  			       sizeof(hwe.ipv4.new_tuple));
> >>>>  	}
> >>>> =20
> >>>> -	hwe.bridge.data =3D e->data.bridge.data;
> >>>> -	airoha_ppe_foe_commit_entry(ppe, &hwe, hash, rx_wlan);
> >>>> +	hwe.bridge.data =3D bridge->bridge.data;
> >>>> +
> >>>> +	return airoha_ppe_foe_commit_entry(ppe, &hwe, hash, rx_wlan);
> >>>> +}
> >>>> +
> >>>> +static int
> >>>> +airoha_ppe_foe_commit_subflow_entry(struct airoha_ppe *ppe,
> >>>> +				    struct airoha_flow_table_entry *e,
> >>>> +				    u32 hash, bool rx_wlan)
> >>>> +{
> >>>> +	struct airoha_flow_table_entry *f;
> >>>> +	int err;
> >>>> +
> >>>> +	f =3D kzalloc_obj(*f, GFP_ATOMIC);
> >>>> +	if (!f)
> >>>> +		return -ENOMEM;
> >>>> +
> >>>> +	err =3D airoha_ppe_foe_commit_subflow(ppe, &e->data, hash, rx_wlan=
);
> >>>> +	if (err) {
> >>>> +		kfree(f);
> >>>> +		return err;
> >>>> +	}
> >>>> +
> >>>> +	hlist_add_head(&f->l2_subflow_node, &e->l2_flows);
> >>>> +	f->type =3D FLOW_TYPE_L2_SUBFLOW;
> >>>> +	f->hash =3D hash;
> >>>> =20
> >>>>  	return 0;
> >>>>  }
> >>>> =20
> >>>> +static bool
> >>>> +airoha_ppe_foe_prepare_wdma_subflow_dev(struct airoha_ppe *ppe,
> >>>> +					struct net_device *dev,
> >>>> +					struct airoha_flow_data *data,
> >>>> +					struct airoha_foe_entry *hwe)
> >>>> +{
> >>>> +	u32 pse_port;
> >>>> +	int err;
> >>>> +
> >>>> +	err =3D airoha_ppe_foe_entry_prepare(ppe->eth, hwe, dev,
> >>>> +					   PPE_PKT_TYPE_BRIDGE, data, 0);
> >>>> +	if (err)
> >>>> +		return false;
> >>>> +
> >>>> +	pse_port =3D FIELD_GET(AIROHA_FOE_IB2_PSE_PORT, hwe->bridge.ib2);
> >>>> +	if (pse_port !=3D FE_PSE_PORT_CDM4)
> >>>> +		return false;
> >>>> +
> >>>> +	return true;
> >>>
> >>> 	return pse_port =3D=3D FE_PSE_PORT_CDM4;
> >>>
> >>>> +}
> >>>> +
> >>>> +static struct net_device *
> >>>> +airoha_ppe_foe_get_bridge_master(struct net_device *dev)
> >>>> +{
> >>>> +	struct net_device *master =3D NULL;
> >>>> +
> >>>> +	rcu_read_lock();
> >>>> +	master =3D netdev_master_upper_dev_get_rcu(dev);
> >>>> +	if (master && netif_is_bridge_master(master))
> >>>> +		dev_hold(master);
> >>>> +	else
> >>>> +		master =3D NULL;
> >>>> +	rcu_read_unlock();
> >>>> +
> >>>> +	return master;
> >>>> +}
> >>>> +
> >>>> +static bool
> >>>> +airoha_ppe_foe_prepare_wdma_subflow(struct airoha_ppe *ppe,
> >>>> +				    struct sk_buff *skb,
> >>>> +				    struct airoha_foe_entry *hwe)
> >>>> +{
> >>>> +	struct ethhdr *eh =3D eth_hdr(skb);
> >>>> +	struct airoha_flow_data data =3D {};
> >>>> +	struct net_device *master;
> >>>> +
> >>>> +	if (!is_valid_ether_addr(eh->h_source) ||
> >>>> +	    !is_valid_ether_addr(eh->h_dest))
> >>>> +		return false;
> >>>> +
> >>>> +	ether_addr_copy(data.eth.h_dest, eh->h_dest);
> >>>> +	ether_addr_copy(data.eth.h_source, eh->h_source);
> >>>> +
> >>>> +	if (!skb->dev)
> >>>> +		return false;
> >>>> +
> >>>> +	/* WLAN egress unbound hits can arrive before flowtable creates the
> >>>> +	 * L2 master flow normally used for subflow binding. Resolve only
> >>>> +	 * through the bridge master so dev_fill_forward_path() must use t=
he
> >>>> +	 * bridge FDB for the destination MAC. Calling the ingress AP netd=
ev
> >>>> +	 * directly can describe the source station's WDMA path and would
> >>>> +	 * corrupt Wi-Fi-to-wired flows whose real egress is not WDMA.
> >>>> +	 */
> >>>> +	master =3D airoha_ppe_foe_get_bridge_master(skb->dev);
> >>>> +	if (!master)
> >>>> +		return false;
> >>>> +
> >>>> +	if (airoha_ppe_foe_prepare_wdma_subflow_dev(ppe, master, &data,
> >>>> +						    hwe)) {
> >>>> +		dev_put(master);
> >>>> +		return true;
> >>>> +	}
> >>>> +
> >>>> +	dev_put(master);
> >>>> +	return false;
> >>>
> >>> maybe something like:
> >>>
> >>> 	ret =3D airoha_ppe_foe_prepare_wdma_subflow_dev();
> >>> 	dev_put(master);
> >>>
> >>> 	return ret;
> >>>
> >>>> +}
> >>>> +
> >>>>  static void airoha_ppe_foe_insert_entry(struct airoha_ppe *ppe,
> >>>>  					struct sk_buff *skb,
> >>>>  					u32 hash, bool rx_wlan)
> >>>>  {
> >>>> +	struct airoha_foe_entry wdma_hwe =3D {};
> >>>>  	struct airoha_flow_table_entry *e;
> >>>>  	struct airoha_foe_bridge br =3D {};
> >>>>  	struct airoha_foe_entry *hwe;
> >>>>  	bool commit_done =3D false;
> >>>> +	bool wdma_ready =3D false;
> >>>>  	struct hlist_node *n;
> >>>>  	u32 index, state;
> >>>> =20
> >>>> +	wdma_ready =3D airoha_ppe_foe_prepare_wdma_subflow(ppe, skb,
> >>>> +							 &wdma_hwe);
> >>>> +
> >>>>  	spin_lock_bh(&ppe_lock);
> >>>> =20
> >>>>  	hwe =3D airoha_ppe_foe_get_entry_locked(ppe, hash);
> >>>> @@ -899,6 +997,8 @@ static void airoha_ppe_foe_insert_entry(struct a=
iroha_ppe *ppe,
> >>>>  				   airoha_l2_flow_table_params);
> >>>>  	if (e)
> >>>>  		airoha_ppe_foe_commit_subflow_entry(ppe, e, hash, rx_wlan);
> >>>> +	else if (wdma_ready)
> >>>> +		airoha_ppe_foe_commit_subflow(ppe, &wdma_hwe, hash, rx_wlan);
> >>>>  unlock:
> >>>>  	spin_unlock_bh(&ppe_lock);
> >>>>  }
> >>>> --=20
> >>>> 2.53.0
> >>>>
> >>
> >> All inline code-style review comments will be addressed in the next
> >> submission of the patch set, together with the responses to Sashiko's
> >> review, if any.
>=20

--52YazzJl1iU1tUud
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCahR5nwAKCRA6cBh0uS2t
rAcOAP9c+fG1BhTl1BK7HSHTc7vovg9KvZx1Bzth+zGJL2oQtgEA7G0u+TABG3U6
LJacdnw/QSATbtqn40ZK3tCi6T5x2wU=
=IvCl
-----END PGP SIGNATURE-----

--52YazzJl1iU1tUud--

