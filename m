Return-Path: <netdev+bounces-292242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDsiNnbGFmpVrwcAu9opvQ
	(envelope-from <netdev+bounces-292242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:24:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B3B5E2A23
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CA5A309D8BA
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627D030E82B;
	Wed, 27 May 2026 10:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1kgVvWE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C45391E7F;
	Wed, 27 May 2026 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779876968; cv=none; b=M4oWzvN1mJgW+7vlrcnCns6829T26iEYA5Bu4wVq/R5AV0mLqS4Qn08jFJwWre+to76asJnYhVmq5fNQOWrvWAKqZxxVgBr8yA5T9IMiWAAbCe+DhnIHc1XxI1AT8l1yxmbhwMamKndCEmuUnJ2oxcticUe0NX7oIh9fRm6CdMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779876968; c=relaxed/simple;
	bh=u3BslVoHMshasK25tp2kconnlkfIPTIcAjLNf5DK/Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4lAR9NiAKlHJA0ycBsa5991HQTz+zjah9+reuWcBgUwyTrCBZj+cUXeN6H5m8FljkalBKcLRbyVUMdM+KGah4k/K166aWO6hi4fO8G6iYOpsfBceMPTyV8cqIzFQToA52dAzNY6yZE2d49OCSCkUnE3sp7DdDybMekFKqY9tUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1kgVvWE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FF91F000E9;
	Wed, 27 May 2026 10:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779876963;
	bh=3dPLuA4vT67WlsEOzheeR5XKFKVaNwjUTiSu6XRzeEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J1kgVvWEgjVp9TSYzYChMEM+d5y6nWj1RTKgXN0G2jskVcaLXX6/yfiDZ6Cp1nwp5
	 Z9JQSSbLlPgup4j8+jYw5Zw5bJbf4ejioD5iej55uYmDMVHZHrVT1t/ZiOMqiouRXr
	 kKwjZm7FPK3h5GngqtvPJJWfzp7qXYvQMCGsNK4097Uzciv5uAJfZM+uZL1wYm9VcN
	 gGaWLVuM+fG6Qvi1m0TjG8n9/Q9L/p4Kkg1Q+zBwFm4o04sFDmJUWyfZOUOfybU5SB
	 JXYhtHuP3Vlq1GkfIquYZlBG0fLRvp0wXwgM6kHSuE8nNnsJ7iA42LoLy7geeu/nYc
	 ZhN2IEVrY1OLA==
Date: Wed, 27 May 2026 12:16:01 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, Xuegang Lu <xuegang.lu@airoha.com>,
	Madhur Agrawal <madhur.agrawal@airoha.com>
Subject: Re: [PATCH net-next v8 00/10] net: airoha: Support multiple
 net_devices connected to the same GDM port
Message-ID: <ahbEYeiSzB9h3VgQ@lore-desk>
References: <20260519-airoha-eth-multi-serdes-v8-0-6bd70e329df6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="az65s5W1t/JkTr+5"
Content-Disposition: inline
In-Reply-To: <20260519-airoha-eth-multi-serdes-v8-0-6bd70e329df6@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292242-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 78B3B5E2A23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--az65s5W1t/JkTr+5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> EN7581 or AN7583 SoCs support connecting multiple external SerDes (e.g.
> Ethernet or USB SerDes) to GDM3 or GDM4 ports via a hw arbiter that
> manages the traffic in a TDM manner. As a result multiple net_devices can
> connect to the same GDM{3,4} port and there is a theoretical "1:n"
> relation between GDM ports and net_devices.
>=20
>            =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=90
>            =E2=94=82                                 =E2=94=82    =E2=94=
=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>            =E2=94=82                         P1 GDM1 =E2=94=9C=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=96=BAMT7530=E2=94=82
>            =E2=94=82                                 =E2=94=82    =E2=94=
=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>            =E2=94=82                                 =E2=94=82      ETH0 =
(DSA conduit)
>            =E2=94=82                                 =E2=94=82
>            =E2=94=82              PSE/FE             =E2=94=82
>            =E2=94=82                                 =E2=94=82
>            =E2=94=82                                 =E2=94=82
>            =E2=94=82                                 =E2=94=82    =E2=94=
=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>            =E2=94=82                         P0 CDM1 =E2=94=9C=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=96=BAQDMA0=E2=94=82
>            =E2=94=82  P4                     P9 GDM4 =E2=94=82    =E2=94=
=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>            =E2=94=94=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=98
>               =E2=94=82                         =E2=94=82
>            =E2=94=8C=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=94=80=E2=94=
=90                 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BC=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>            =E2=94=82 PPE =E2=94=82                 =E2=94=82   ARB   =E2=
=94=82
>            =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=98                 =E2=94=94=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=98
>                                      =E2=94=82     =E2=94=82
>                                   =E2=94=8C=E2=94=80=E2=94=80=E2=96=BC=E2=
=94=80=E2=94=80=E2=94=90=E2=94=8C=E2=94=80=E2=96=BC=E2=94=80=E2=94=80=E2=94=
=80=E2=94=90
>                                   =E2=94=82 ETH =E2=94=82=E2=94=82 USB =
=E2=94=82
>                                   =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=98=E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=98
>                                    ETH1   ETH2
>=20
> This series introduces support for multiple net_devices connected to the
> same Frame Engine (FE) GDM port (GDM3 or GDM4) via an external hw
> arbiter. Please note GDM1 or GDM2 does not support the connection with
> the external arbiter.

In order to make easier the inclusion of this series I am splitting it in t=
wo
smaller ones:
- a preliminary rework series (just code adjustments)
- a smaller series where we introduce the real support for multiple net_dev=
ices
  connected to the same FE GDM port.

This way we can unlock even other patches in my queue.

Regards,
Lorenzo

>=20
> ---
> Changes in v8:
> - Fix dts schema issues reported by sashiko.
> - Fix possible NULL-pointer dereference in patch 2/10.
> - Fix max mtu computation in airoha_dev_change_mtu().
> - Link to v7: https://lore.kernel.org/r/20260516-airoha-eth-multi-serdes-=
v7-0-99e0093303e2@kernel.org
>=20
> Changes in v7:
> - Fix dma_sync_single_for_cpu() size in airoha_qdma_rx_process().
> - Fix hw stats reset.
> - Fix typos.
> - Add fix for airoha_tc_remove_htb_queue queue index.
> - Fix dts schema issues.
> - Remove hw stats patch from the series.
> - Link to v6: https://lore.kernel.org/r/20260511-airoha-eth-multi-serdes-=
v6-0-c899462c4f75@kernel.org
>=20
> Changes in v6:
> - Reconfigure REG_GDM_LEN_CFG() whit max 'running' MTU in
>   airoha_dev_stop().
> - Fix port staring MIB counters in airoha_update_hw_stats().
> - Fix regression in TC_HTB_NODE_MODIFY command.
> - Fix length check in airoha_qdma_rx_process().
> - Fix dts schema.
> - Link to v5: https://lore.kernel.org/r/20260509-airoha-eth-multi-serdes-=
v5-0-805e38edc2aa@kernel.org
>=20
> Changes in v5:
> - Move qos_sq_bmap bitmap in airoha_gdm_dev struct.
> - Unregister netdevice before running of_node_put().
> - Move stat MIB counters in airoha_gdm_dev struct.
> - Fix airoha_ppe_init_upd_mem() mac address configuration.
> - Do not return -EBUSY if we try to decrease configured MTU of a shared
>   GDM port, just skip hw configuration.
> - use int instead of atomic_t for GDM port users.
> - Add patch "net: airoha: Reserve RX headroom to avoid skb reallocation"
> - Fix typos.
> - Link to v4: https://lore.kernel.org/r/20260507-airoha-eth-multi-serdes-=
v4-0-af613b61ae02@kernel.org
>=20
> Changes in v4:
> - Make ethernet-port property available just for GDM3 and GDM4 in DTS
>   specification
> - Move cpu_tx_packets, fwd_tx_packets qos_sq_bmap fields in airoha_qdma
>   struct
> - Fix of_node leak removing the net_device in airoha_remove() or
>   airoha_probe() error path
> - Fix nbq backward compatibility
> - Link to v3: https://lore.kernel.org/r/20260406-airoha-eth-multi-serdes-=
v3-0-ab6ea49d59ff@kernel.org
>=20
> Changes in v3:
> - Fix MTU and VIP configuration when the GDM port is shared between
>   multiple net_devices.
> - Add sanity check for nbq parameter.
> - Add missing of_node_get() for net_device np node.
> - Check if GDM port is shared before decresing device MTU.
> - Move port forward configuration in airoha_dev_stop() before
>   configuring DMA tx/rx engine.
> - Introduce PRIV_FLAG_WAN parameter.
> - Link to v2: https://lore.kernel.org/r/20260401-airoha-eth-multi-serdes-=
v2-0-ac427ae4beeb@kernel.org
>=20
> Changes in v2:
> - Rename multiplexer in arbiter in the commit logs.
> - Rebase on top of net-next main branch.
> - Add missing PPE cpu port configuration for GDM2 when loopback is
>   enabled.
> - Link to v1: https://lore.kernel.org/r/20260329-airoha-eth-multi-serdes-=
v1-0-00f52dc360ca@kernel.org
>=20
> ---
> Lorenzo Bianconi (10):
>       dt-bindings: net: airoha: Add GDM port ethernet child node
>       net: airoha: Introduce airoha_gdm_dev struct
>       net: airoha: Move airoha_qdma pointer in airoha_gdm_dev struct
>       net: airoha: Rely on airoha_gdm_dev pointer in airoha_is_lan_gdm_po=
rt()
>       net: airoha: Move qos_sq_bmap in airoha_gdm_dev struct
>       net: airoha: Move {cpu,fwd}_tx_packets in airoha_gdm_dev struct
>       net: airoha: Support multiple net_devices for a single FE GDM port
>       net: airoha: Do not stop GDM port if it is shared
>       net: airoha: Introduce WAN device flag
>       net: airoha: Support multiple LAN/WAN interfaces for hw MAC address=
 configuration
>=20
>  .../devicetree/bindings/net/airoha,en7581-eth.yaml |  56 +-
>  drivers/net/ethernet/airoha/airoha_eth.c           | 833 +++++++++++++++=
------
>  drivers/net/ethernet/airoha/airoha_eth.h           |  47 +-
>  drivers/net/ethernet/airoha/airoha_ppe.c           |  43 +-
>  4 files changed, 702 insertions(+), 277 deletions(-)
> ---
> base-commit: 7a348a95f696d20f15c776de4df8b4415bcf3d77
> change-id: 20260324-airoha-eth-multi-serdes-fb4b556ee756
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo@kernel.org>
>=20

--az65s5W1t/JkTr+5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCahbEYQAKCRA6cBh0uS2t
rLVLAP97LnytXlCsUgWwxi7sHBXsDqL4HTn0qSR1j/K68IIUWgEAnGWw3Xw3bdax
jUWz++G6bPA1lorI2Tx+4DUR2tg8UgA=
=FgFf
-----END PGP SIGNATURE-----

--az65s5W1t/JkTr+5--

