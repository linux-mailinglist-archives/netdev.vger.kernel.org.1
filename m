Return-Path: <netdev+bounces-196734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9E3AD61CB
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 23:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6CE1188611E
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 21:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AECE21CC5D;
	Wed, 11 Jun 2025 21:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fA/VcPaY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3EB18A6AD;
	Wed, 11 Jun 2025 21:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749678397; cv=none; b=hX+L94jpAO3qEHebbkmlJ/oiTwfEX6t73HYYyOVPmo/VSY+aFTre+pmy8eVJGFocuu6ZmfmDBq7qmexjYzCDQ0+Natz6zcydA7A+bkjgc2c/eEHcf2/p7h2myzEhdp7UF7/0ZQc+ALvT0ukFsXXmPvg0ByGO10s9DGAYHDCmOcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749678397; c=relaxed/simple;
	bh=pBwBKrSA6Q1Th81r6c9urru5D5rWEbXIy3CKQgIAEZs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hNmSU66ulcB9N8Qj5rSZ7Ey1ZQjsF3y/dmbZlO+Jv/CkEYnpCE7dL0KgIpoRdX7wp7eHY7rempnCIcOyR9877dHbFf/XNzSTiWg3FGH1IlDNvYmxDZmDEbxhZdrxtEqQXCpMWrfrOaozRTJS1aAiNiNruxeXhsp00XUgLqysfRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fA/VcPaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F8FC4CEE3;
	Wed, 11 Jun 2025 21:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749678396;
	bh=pBwBKrSA6Q1Th81r6c9urru5D5rWEbXIy3CKQgIAEZs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fA/VcPaYBOMovMMmuuhvToI/BO10byqlZPxci9AS+gJOWSvysDaejdbza8At9BPgG
	 pcfgV026K/i31JOqJS8axtbzUAz29LByZ6pdCulcaIfangH7FfawMpD5CoDvCLTPTj
	 +O2d89Kwfi0NnH9ruVB9pZMS2afrAo05Ypkjd1omKEqnRpOrEc90FDCNQKsiT+ZMPl
	 gJOjHlDODWctxSo4hVbkjVYMZ9Z1+Zf9xV+zgEQjdy8tRJmI0jlf+7wbgCh9UH+28r
	 HDnW4ZZoOe8LOs9Kk8Sw7qemMFTSN/BYVK2eyKr0DHzI4bEgxafaeKluzXXdmfHcwP
	 IFJZt2iMNZH1A==
Date: Wed, 11 Jun 2025 14:46:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>
Cc: jonas.gorski@gmail.com, florian.fainelli@broadcom.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dgcbueu@gmail.com
Subject: Re: [PATCH net-next v2 2/3] net: dsa: tag_brcm: add support for
 legacy FCS tags
Message-ID: <20250611144635.37207d22@kernel.org>
In-Reply-To: <20250610163154.281454-3-noltari@gmail.com>
References: <20250610163154.281454-1-noltari@gmail.com>
	<20250610163154.281454-3-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Jun 2025 18:31:53 +0200 =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> +	struct dsa_port *dp =3D dsa_user_to_port(dev);
> +	unsigned int fcs_len;
> +	u32 fcs_val;
> +	u8 *brcm_tag;

nit: please reorder the variable declaration lines longest to shortest

> +	/* The Ethernet switch we are interfaced with needs packets to be at
> +	 * least 64 bytes (including FCS) otherwise they will be discarded when
> +	 * they enter the switch port logic. When Broadcom tags are enabled, we
> +	 * need to make sure that packets are at least 70 bytes
> +	 * (including FCS and tag) because the length verification is done after
> +	 * the Broadcom tag is stripped off the ingress packet.
> +	 *
> +	 * Let dsa_user_xmit() free the SKB
> +	 */
> +	if (__skb_put_padto(skb, ETH_ZLEN + BRCM_LEG_TAG_LEN, false))
> +		return NULL;
> +
> +	fcs_len =3D skb->len;
> +	fcs_val =3D cpu_to_le32(crc32(~0, skb->data, fcs_len) ^ ~0);

sparse (C=3D1 build flag) complains about the loss of type annotation:

net/dsa/tag_brcm.c:327:17: warning: incorrect type in assignment (different=
 base types)
net/dsa/tag_brcm.c:327:17:    expected unsigned int [usertype] fcs_val
net/dsa/tag_brcm.c:327:17:    got restricted __le32 [usertype]

> +	skb_push(skb, BRCM_LEG_TAG_LEN);
> +
> +	dsa_alloc_etype_header(skb, BRCM_LEG_TAG_LEN);
> +
> +	brcm_tag =3D skb->data + 2 * ETH_ALEN;
> +
> +	/* Broadcom tag type */
> +	brcm_tag[0] =3D BRCM_LEG_TYPE_HI;
> +	brcm_tag[1] =3D BRCM_LEG_TYPE_LO;
> +
> +	/* Broadcom tag value */
> +	brcm_tag[2] =3D BRCM_LEG_EGRESS | BRCM_LEG_LEN_HI(fcs_len);
> +	brcm_tag[3] =3D BRCM_LEG_LEN_LO(fcs_len);
> +	brcm_tag[4] =3D 0;
> +	brcm_tag[5] =3D dp->index & BRCM_LEG_PORT_ID;
> +
> +	/* Original FCS value */
> +	if (__skb_pad(skb, ETH_FCS_LEN, false))
> +		return NULL;
> +	skb_put_data(skb, &fcs_val, ETH_FCS_LEN);
--=20
pw-bot: cr

