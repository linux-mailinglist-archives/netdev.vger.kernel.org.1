Return-Path: <netdev+bounces-289098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NbmHw8pC2pAEAUAu9opvQ
	(envelope-from <netdev+bounces-289098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:58:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F4956F5F9
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1AAF302A562
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DA828688C;
	Mon, 18 May 2026 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAJPMiK0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160F127FD44;
	Mon, 18 May 2026 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779115916; cv=none; b=rj3UDJrrLQls2/JxysGj0ZWWvIezDvEjAuJJgAdqo7CvpdmN3m+DB40kxnZyv+ZdG7xV5OMb7jx9h0Mo8r9FsLQFpnbizPQEwgJ6ayfQ11moCey4tY+vrIRui32Tai0hMEferPRAby8y+LGqoo57gy/xSta9qhdS9Ez4zvMSetY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779115916; c=relaxed/simple;
	bh=W8mfUZYTFIqWGn2eaAldRGRl+R6AXw6M9nbhx2Tu1r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhfN+M4y1sxUb/3MjuDYtF3D3s07Yps1/ujDEQmav2/bjyvglfmGvyeaShLqhkNF+b8QrAXAWDXilkw9QnwS3VOqf4fYpTTIrAHEYyGgV9P3wav2ZwVVg3VBGQM1nnEBYm+u9x0zXQVykIq7Xfq19LpYTNtCr+95JA3OfYobaik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAJPMiK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50950C2BCB7;
	Mon, 18 May 2026 14:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779115915;
	bh=W8mfUZYTFIqWGn2eaAldRGRl+R6AXw6M9nbhx2Tu1r8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AAJPMiK0PT4VjouMYRJAa9XUqHUK+mHF65PnNreo33z5f3BEe9jwSwwUl9Uy+JlvB
	 YH2wqWkvQMysxopwzf/wWxBezj4S0k0jUnBNzdIwTgfcL2vt7WcOcAEvtLncv6sixH
	 099RCB7OTPr5yetXiUYZzhrwX2cecllrBsU6y4gg/Z/yIm1orxhp5fBhvrEbcOebqI
	 GNMHKSgt0KjGbVTao8jJNrZscEKR6HEZ68Lrzy5+/FIjZnILAHJTw0cjF10h3D1DFv
	 1gzNU3pUFp700oriUdvX9q+Y4FsjLTcuZldm9D0RIiCZvZsKIhBSxIXpsJbSa/OZlL
	 jNREdvZYFBA6A==
Date: Mon, 18 May 2026 16:51:53 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH RESEND net] net: airoha: Fix NPU RX DMA descriptor bits
Message-ID: <agsniX2m-27MEbwl@lore-desk>
References: <20260518134530.3683-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2GLNA2Q/LBTCa/KS"
Content-Disposition: inline
In-Reply-To: <20260518134530.3683-1-ansuelsmth@gmail.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-289098-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 87F4956F5F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--2GLNA2Q/LBTCa/KS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> In an internal review from Airoha, it was notice that the RX DMA descript=
or
> bits and mask are wrong. These values probably refer to an old NPU firmwa=
re
> never published. The previous value works correctly but it was reported
> that in some specific condition in mixed scenario with both Ethernet and
> WiFi offload it's possible that RX DMA descriptor signal wrong value with
> the problem to the RX ring or packets getting dropped.
>=20
> To handle these specific scenario, apply the new suggested bits mask from
> Airoha.
>=20
> Correct functionality of both AN7581 NPU and MT7996 variant were verified
> and confirmed working.
>=20
> Fixes: a7fc8c641cab ("net: airoha: Fix npu rx DMA definitions")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  include/linux/soc/airoha/airoha_offload.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/soc/airoha/airoha_offload.h b/include/linux/so=
c/airoha/airoha_offload.h
> index d01ef4a6b3d7..7589fccfeef6 100644
> --- a/include/linux/soc/airoha/airoha_offload.h
> +++ b/include/linux/soc/airoha/airoha_offload.h
> @@ -71,9 +71,9 @@ static inline void airoha_ppe_dev_check_skb(struct airo=
ha_ppe_dev *dev,
>  #define NPU_RX1_DESC_NUM	512
> =20
>  /* CTRL */
> -#define NPU_RX_DMA_DESC_LAST_MASK	BIT(27)
> -#define NPU_RX_DMA_DESC_LEN_MASK	GENMASK(26, 14)
> -#define NPU_RX_DMA_DESC_CUR_LEN_MASK	GENMASK(13, 1)
> +#define NPU_RX_DMA_DESC_LAST_MASK	BIT(29)
> +#define NPU_RX_DMA_DESC_LEN_MASK	GENMASK(28, 15)
> +#define NPU_RX_DMA_DESC_CUR_LEN_MASK	GENMASK(14, 1)
>  #define NPU_RX_DMA_DESC_DONE_MASK	BIT(0)
>  /* INFO */
>  #define NPU_RX_DMA_PKT_COUNT_MASK	GENMASK(31, 29)
> --=20
> 2.53.0
>=20

--2GLNA2Q/LBTCa/KS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCagsniQAKCRA6cBh0uS2t
rF0EAQD7Sn41ZRgTwWSApcQU7pRgYS27/W7nI0W8nl7AXjQrNgEAuu4cvrkmLawH
hVMBRjNaixQyAOGfGHouajxKt78yGgE=
=q7US
-----END PGP SIGNATURE-----

--2GLNA2Q/LBTCa/KS--

