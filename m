Return-Path: <netdev+bounces-272926-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Db/9GVJAyWmLwgUAu9opvQ
	(envelope-from <netdev+bounces-272926-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 17:08:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE1C352867
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 17:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54BF830099A8
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 15:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB714371051;
	Sun, 29 Mar 2026 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l3r3SgfZ"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A19C36E49F
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774796878; cv=none; b=U95ajOmhQFQUc3PBDRxTFHj03PRxlk2iZmqjL34m0qT0JFBb9Jo2DP+IkPki3g+FQMfixQPbDkQdLngn8NnvhsF4qL7ORhvPbR0kHkHiRJheaT6r6IXxDIRM1vyeG1mm/mm/2MQOKMxMj85XJTJ7v9EdQSEMTWG4GPMhi39uCuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774796878; c=relaxed/simple;
	bh=/rzuWzGawhK7c0sqnN/rIuicKk3bsg9/uHS/1u6fraE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=DpEA1vvC4hY+6yCftUYgqXVrBXoWXCdVFtez1YofC244wB84fCGZiwyEMltiPag1gDoDtONbKOIXBwhBO3syDLSvqxc4jeg3fREQ11WDIeo0dhHSmcIdshs+Jsb13CJYCiY0XBccpizil+ta4NLwESlHOfKEjQp03P5py72t8jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l3r3SgfZ; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774796874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLcO9BJjXEsXKYVh1NSaM1HEFypx4hwCvFjAkhP5F4o=;
	b=l3r3SgfZw+SUochOfzEnYVBCNWmHUspMshEXxXTXqxusToEC/vk1fAEYpbPN3WJeUMWQIK
	GF5XGqVdfmmlBNIAc8Krd8n7iJy3vkaGRG4bHpvyuwUyTR2IYTDXIlSwIZR65/dBdktdXq
	vWgTrKp7/TU921qhrRWc2pXX6ibh6To=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 29 Mar 2026 17:07:50 +0200
Message-Id: <DHFCZEM93FTT.1RWFBIE32K7OT@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Luka Gejak" <luka.gejak@linux.dev>
To: "Fernando Fernandez Mancera" <ffmancera@riseup.net>,
 <netdev@vger.kernel.org>
Cc: <edumazet@google.com>, <pabeni@redhat.com>, <shannon.nelson@amd.com>,
 <horms@kernel.org>, <luka.gejak@linux.dev>, <lukma@denx.de>,
 <kuba@kernel.org>
Subject: Re: [PATCH v3 net-next] net: hsr: sync hw addr of slave2 according
 to slave1 hw addr on PRP
References: <20250409101911.3120-1-ffmancera@riseup.net>
In-Reply-To: <20250409101911.3120-1-ffmancera@riseup.net>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272926-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9AE1C352867
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed Apr 9, 2025 at 12:19 PM CEST, Fernando Fernandez Mancera wrote:
> In order to work properly PRP requires slave1 and slave2 to share the
> same MAC address. To ease the configuration process on userspace tools,
> sync the slave2 MAC address with slave1. In addition, when deleting the
> port from the list, restore the original MAC address.
>
> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
> ---
> v3: restore the original MAC address on slave removal.
> ---
>  net/hsr/hsr_device.c | 5 +++++
>  net/hsr/hsr_main.c   | 9 +++++++++
>  net/hsr/hsr_main.h   | 1 +
>  net/hsr/hsr_slave.c  | 2 ++
>  4 files changed, 17 insertions(+)
>
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 439cfb7ad5d1..e8922e8d9398 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -761,6 +761,11 @@ int hsr_dev_finalize(struct net_device *hsr_dev, str=
uct net_device *slave[2],
>  	if (res)
>  		goto err_unregister;
> =20
> +	if (protocol_version =3D=3D PRP_V1) {
> +		eth_hw_addr_set(slave[1], slave[0]->dev_addr);
> +		call_netdevice_notifiers(NETDEV_CHANGEADDR, slave[1]);
> +	}
> +
>  	if (interlink) {
>  		res =3D hsr_add_port(hsr, interlink, HSR_PT_INTERLINK, extack);
>  		if (res)
> diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
> index d7ae32473c41..192893c3f2ec 100644
> --- a/net/hsr/hsr_main.c
> +++ b/net/hsr/hsr_main.c
> @@ -78,6 +78,15 @@ static int hsr_netdev_notify(struct notifier_block *nb=
, unsigned long event,
>  			eth_hw_addr_set(master->dev, dev->dev_addr);
>  			call_netdevice_notifiers(NETDEV_CHANGEADDR,
>  						 master->dev);
> +
> +			if (hsr->prot_version =3D=3D PRP_V1) {
> +				port =3D hsr_port_get_hsr(hsr, HSR_PT_SLAVE_B);
> +				if (port) {
> +					eth_hw_addr_set(port->dev, dev->dev_addr);
> +					call_netdevice_notifiers(NETDEV_CHANGEADDR,
> +								 port->dev);
> +				}
> +			}
>  		}
> =20
>  		/* Make sure we recognize frames from ourselves in hsr_rcv() */
> diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
> index 1bc47b17a296..135ec5fce019 100644
> --- a/net/hsr/hsr_main.h
> +++ b/net/hsr/hsr_main.h
> @@ -155,6 +155,7 @@ struct hsr_port {
>  	struct hsr_priv		*hsr;
>  	enum hsr_port_type	type;
>  	struct rcu_head		rcu;
> +	unsigned char		original_macaddress[ETH_ALEN];
>  };
> =20
>  struct hsr_frame_info;
> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index 2a802a5de2ac..b87b6a6fe070 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c
> @@ -196,6 +196,7 @@ int hsr_add_port(struct hsr_priv *hsr, struct net_dev=
ice *dev,
>  	port->hsr =3D hsr;
>  	port->dev =3D dev;
>  	port->type =3D type;
> +	ether_addr_copy(port->original_macaddress, dev->dev_addr);
> =20
>  	if (type !=3D HSR_PT_MASTER) {
>  		res =3D hsr_portdev_setup(hsr, dev, port, extack);
> @@ -232,6 +233,7 @@ void hsr_del_port(struct hsr_port *port)
>  		if (!port->hsr->fwd_offloaded)
>  			dev_set_promiscuity(port->dev, -1);
>  		netdev_upper_dev_unlink(port->dev, master->dev);
> +		eth_hw_addr_set(port->dev, port->original_macaddress);
>  	}
> =20
>  	kfree_rcu(port, rcu);

Hi Fernando,

Thanks for the patch. The logic to sync the slave2 MAC address with=20
slave1 for PRP is sound, but there are a few implementation issues here=20
that will cause hardware filtering problems and style violations.

1. Hardware MAC Filtering
In your current implementation:

  if (protocol_version =3D=3D PRP_V1) {

      eth_hw_addr_set(slave[1], slave[0]->dev_addr);

      call_netdevice_notifiers(NETDEV_CHANGEADDR, slave[1]);

  }

eth_hw_addr_set() is appropriate for virtual devices (like the hsr_dev=20
itself), but slave[1] is a physical net_device. By using this helper,=20
you are bypassing dev->netdev_ops->ndo_set_mac_address. This means the=20
physical NIC's hardware MAC filter will not be programmed, and it will=20
silently drop unicast traffic destined for the new PRP MAC address=20
unless the interface happens to be in promiscuous mode. You should use=20
dev_set_mac_address() here instead. Note that unlike eth_hw_addr_set(),=20
dev_set_mac_address() can fail and returns an error code, so you will=20
need to check its return value and handle the error path accordingly.

2. Teardown Notifiers
In hsr_del_port():

  netdev_upper_dev_unlink(port->dev, master->dev);
  eth_hw_addr_set(port->dev, port->original_macaddress);

You have the same issue with eth_hw_addr_set() here. Additionally,=20
unlike the setup paths, this version omits call_netdevice_notifiers
(NETDEV_CHANGEADDR, port->dev). Switching to dev_set_mac_address() for=20
the restoration will handle both the hardware programming and the =20
notifier chain automatically.

3. Coding Style
In hsr_main.h:

  unsigned char original_macaddress[ETH_ALEN];

Please use u8 instead of unsigned char for byte arrays to align with=20
standard netdev coding styles.

Please address these points and submit a v4.

Best regards,
Luka Gejak

