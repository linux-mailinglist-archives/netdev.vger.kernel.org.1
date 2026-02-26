Return-Path: <netdev+bounces-261194-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCwyJIf4n2n3fAQAu9opvQ
	(envelope-from <netdev+bounces-261194-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:38:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 105D71A1ECF
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F6DF3026500
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 07:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F0438F229;
	Thu, 26 Feb 2026 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuUKU8Ha"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C483914D29B;
	Thu, 26 Feb 2026 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772091522; cv=none; b=tDQBQIuL0xKBSg6WXGRMxRlLcPuZEFEDO96B56hD2l6iCU8L4wmdGmrJODrVfL8jIpMMs0CauKgscqJyqV/q5sgqMAjKYOaLfkfyYZklpL26ocFSQxo75CCPh9ezi5L+7Kp5TFCnCXeCELqYWVrIYMjuxSXQhR5y5XSb30vqFsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772091522; c=relaxed/simple;
	bh=Wrc4xAun5CwndqcKF0a9rvejO9WBiD5pCK7g3zIJna4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeGfcdgYJoFg84u7SK2vfiFgDnHFIbFK96uOVVMhfGo17l1JLlfClKiswInfa9JzV2ht3AaGOINf3l5aPOk3sTYA3BM9NZRurDGn41jatRwtTfRpr+S169uo1al2EE+U+ytTKqw/6Z9gcAtQCmKePA5vkev5IXDLpfpfSHiaslc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuUKU8Ha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0698DC19424;
	Thu, 26 Feb 2026 07:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772091522;
	bh=Wrc4xAun5CwndqcKF0a9rvejO9WBiD5pCK7g3zIJna4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MuUKU8HaopIuxCmBB3FBoI5xYavpPuRdntHOycIA4tf/iyw0mu44c+PlbVfX5HlI8
	 tKNN3qDS+T2o39hlVjIkJFbLFbbidazicsEVmV0EE7rPRF9nWpLNeuL083/z5vLWCi
	 GhEUWa679c8MByObex9yLlneYIZWL/GMfxJj8bJaKIzKsq6b87YEw6K/LMMzPwXnm8
	 wzXB/6gsTdbZMMi23oQpbE0hEQRuqkYro/rWrJR0htwTugrgCVOa7YbtnZEFjpDWzD
	 wN7YBYghNls8CUdgkBfzjmiZoMDitC1Hc6ZEYLzi2E6T+LK3GjgVYkUseG430trA95
	 6O4pY3UPxw2lA==
Date: Thu, 26 Feb 2026 08:38:39 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Zhengping Zhang <aquapinn@qq.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, zhengping.zhang@airoha.com,
	upstream@airoha.com, Simon Horman <horms@kernel.org>
Subject: Re: [RESEND PATCH net-next] net: airoha: fix typo in function name
Message-ID: <aZ_4f5LrAlKpG6cZ@lore-desk>
References: <tencent_E4FD5D6BC0131E617D848896F5F9FCED6E0A@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ywZFAiZulEAzxkCv"
Content-Disposition: inline
In-Reply-To: <tencent_E4FD5D6BC0131E617D848896F5F9FCED6E0A@qq.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261194-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lists.infradead.org,vger.kernel.org,gmail.com,collabora.com,airoha.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qq.com:email]
X-Rspamd-Queue-Id: 105D71A1ECF
X-Rspamd-Action: no action


--ywZFAiZulEAzxkCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Corrected the typo in the function name from
>  `airhoa_is_lan_gdm_port` to `airoha_is_lan_gdm_port`. This change ensures
>  consistency in the API naming convention.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Signed-off-by: Zhengping Zhang <aquapinn@qq.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
>  drivers/net/ethernet/airoha/airoha_eth.h | 2 +-
>  drivers/net/ethernet/airoha/airoha_ppe.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 62bcbbbe2a95..3779f93b47bc 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -76,7 +76,7 @@ static void airoha_set_macaddr(struct airoha_gdm_port *=
port, const u8 *addr)
>  	struct airoha_eth *eth =3D port->qdma->eth;
>  	u32 val, reg;
> =20
> -	reg =3D airhoa_is_lan_gdm_port(port) ? REG_FE_LAN_MAC_H
> +	reg =3D airoha_is_lan_gdm_port(port) ? REG_FE_LAN_MAC_H
>  					   : REG_FE_WAN_MAC_H;
>  	val =3D (addr[0] << 16) | (addr[1] << 8) | addr[2];
>  	airoha_fe_wr(eth, reg, val);
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index 20e602d61e61..59ed7569f7c3 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -626,7 +626,7 @@ u32 airoha_rmw(void __iomem *base, u32 offset, u32 ma=
sk, u32 val);
>  #define airoha_qdma_clear(qdma, offset, val)			\
>  	airoha_rmw((qdma)->regs, (offset), (val), 0)
> =20
> -static inline bool airhoa_is_lan_gdm_port(struct airoha_gdm_port *port)
> +static inline bool airoha_is_lan_gdm_port(struct airoha_gdm_port *port)
>  {
>  	/* GDM1 port on EN7581 SoC is connected to the lan dsa switch.
>  	 * GDM{2,3,4} can be used as wan port connected to an external
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ether=
net/airoha/airoha_ppe.c
> index 2221bafaf7c9..9e07b4653af1 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -321,7 +321,7 @@ static int airoha_ppe_foe_entry_prepare(struct airoha=
_eth *eth,
>  			/* For downlink traffic consume SRAM memory for hw
>  			 * forwarding descriptors queue.
>  			 */
> -			if (airhoa_is_lan_gdm_port(port))
> +			if (airoha_is_lan_gdm_port(port))
>  				val |=3D AIROHA_FOE_IB2_FAST_PATH;
>  			if (dsa_port >=3D 0)
>  				val |=3D FIELD_PREP(AIROHA_FOE_IB2_NBQ,
> --=20
> 2.43.0
>=20

--ywZFAiZulEAzxkCv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaZ/4fwAKCRA6cBh0uS2t
rFNxAQC51ZWEWtupLqf0J9rgQp3GNeH/exHXOYErWxwPix1qdAEAh4brjMkl6Kj7
jXa2inBVSXHqhZ8HLhfMmH1E28YqxQ8=
=YVf+
-----END PGP SIGNATURE-----

--ywZFAiZulEAzxkCv--

