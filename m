Return-Path: <netdev+bounces-117726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FA394EEC6
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5785B25796
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 13:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1322D18130D;
	Mon, 12 Aug 2024 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrEDbWy4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFA9180A81;
	Mon, 12 Aug 2024 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470675; cv=none; b=dfrQ3WFEjnD1VsWlZByw6zJtEB7DTGvrNQa2DZ8RlcHS+gS7TbyYE2fUAKajwpBhahqbudRw2vPyQSMngXY9D8t/w1PDw7iHe8XPNBhaYr16ffqnC0uItPMbxjzxiqqrGeNdQ9FwxpSJzAtfkO+kVmN5B63ouWwqcCZQUwXpZ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470675; c=relaxed/simple;
	bh=9HRKaxKNfcbf6DCjpxfHUK16aDxW9JFbSx9nuiWZKV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvYXBQ9/0lQz9OFt5oAeI2YTiVC6zG6JMUtjAe3gX0Zl7Uxe/y63LtZlqsNnKv0B3NLl6egrI8Z28pVpeH/vRap2n/ODHElbPaGDIjLjFEbYGrMwbamhU3IV73U/TcKIaNKzF4V8T6A/pSdjUFjZ61w9BTimkU9SyVtnWpu00yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrEDbWy4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E70C32782;
	Mon, 12 Aug 2024 13:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723470674;
	bh=9HRKaxKNfcbf6DCjpxfHUK16aDxW9JFbSx9nuiWZKV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hrEDbWy4L78Q+bYq/lPpMlO2lb6StBpc5br3d0eWx6QZ2rGqXdFNuZWJlV+9ZbpmH
	 JXN+gfal2zeAec5nUIFxMVuHWq81OIlRzlxpiIYTqoRn/eX2PerLIw+RKSJgabyWNa
	 NmT9F5fFfVqns4Fv194nKeg/491INw0ewra53HAUq758K1mnAHBOBXzLEDQfDIvHOn
	 dJMu6BfT0qZGH1O5JvBbpDjW4l3HbXfs7XbXwSZ0plzrfHUTXkGLi9JnTULpiEwutp
	 GDKp8kSuB9v81X3TxKryuMi2YXi3PgHsl8q6r5cKMKsbQrZ2BRy9JRzv1Q2Qz1HRdu
	 NiTtu2KRlHDuA==
Date: Mon, 12 Aug 2024 14:51:08 +0100
From: Simon Horman <horms@kernel.org>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: vsc73xx: implement FDB operations
Message-ID: <20240812135108.GA21855@kernel.org>
References: <20240811195649.2360966-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811195649.2360966-1-paweldembicki@gmail.com>

On Sun, Aug 11, 2024 at 09:56:49PM +0200, Pawel Dembicki wrote:
> This commit introduces implementations of three functions:
> .port_fdb_dump
> .port_fdb_add
> .port_fdb_del
> 
> The FDB database organization is the same as in other old Vitesse chips:
> It has 2048 rows and 4 columns (buckets). The row index is calculated by
> the hash function 'vsc73xx_calc_hash' and the FDB entry must be placed
> exactly into row[hash]. The chip selects the row number by itself.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
>  drivers/net/dsa/vitesse-vsc73xx-core.c | 302 +++++++++++++++++++++++++
>  drivers/net/dsa/vitesse-vsc73xx.h      |   2 +
>  2 files changed, 304 insertions(+)
> 
> diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
> index a82b550a9e40..7da1641b8bab 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx-core.c
> +++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
> @@ -46,6 +46,8 @@
>  #define VSC73XX_BLOCK_MII_EXTERNAL	0x1 /* External MDIO subblock */
>  
>  #define CPU_PORT	6 /* CPU port */
> +#define VSC73XX_NUM_FDB_RECORDS	2048
> +#define VSC73XX_NUM_BUCKETS	4
>  
>  /* MAC Block registers */
>  #define VSC73XX_MAC_CFG		0x00
> @@ -197,6 +199,21 @@
>  #define VSC73XX_SRCMASKS_MIRROR			BIT(26)
>  #define VSC73XX_SRCMASKS_PORTS_MASK		GENMASK(7, 0)
>  
> +#define VSC73XX_MACHDATA_VID			GENMASK(27, 16)
> +#define VSC73XX_MACHDATA_VID_SHIFT		16
> +#define VSC73XX_MACHDATA_MAC0_SHIFT		8
> +#define VSC73XX_MACHDATA_MAC1_SHIFT		0
> +#define VSC73XX_MACLDATA_MAC2_SHIFT		24
> +#define VSC73XX_MACLDATA_MAC3_SHIFT		16
> +#define VSC73XX_MACLDATA_MAC4_SHIFT		8
> +#define VSC73XX_MACLDATA_MAC5_SHIFT		0
> +#define VSC73XX_MAC_BYTE_MASK			GENMASK(7, 0)
> +
> +#define VSC73XX_MACTINDX_SHADOW			BIT(13)
> +#define VSC73XX_MACTINDX_BUCKET_MASK		GENMASK(12, 11)
> +#define VSC73XX_MACTINDX_BUCKET_MASK_SHIFT	11
> +#define VSC73XX_MACTINDX_INDEX_MASK		GENMASK(10, 0)
> +
>  #define VSC73XX_MACACCESS_CPU_COPY		BIT(14)
>  #define VSC73XX_MACACCESS_FWD_KILL		BIT(13)
>  #define VSC73XX_MACACCESS_IGNORE_VLAN		BIT(12)
> @@ -204,6 +221,7 @@
>  #define VSC73XX_MACACCESS_VALID			BIT(10)
>  #define VSC73XX_MACACCESS_LOCKED		BIT(9)
>  #define VSC73XX_MACACCESS_DEST_IDX_MASK		GENMASK(8, 3)
> +#define VSC73XX_MACACCESS_DEST_IDX_MASK_SHIFT	3
>  #define VSC73XX_MACACCESS_CMD_MASK		GENMASK(2, 0)
>  #define VSC73XX_MACACCESS_CMD_IDLE		0
>  #define VSC73XX_MACACCESS_CMD_LEARN		1
> @@ -329,6 +347,13 @@ struct vsc73xx_counter {
>  	const char *name;
>  };
>  
> +struct vsc73xx_fdb {
> +	u16 vid;
> +	u8 port;
> +	u8 mac[6];
> +	bool valid;
> +};
> +
>  /* Counters are named according to the MIB standards where applicable.
>   * Some counters are custom, non-standard. The standard counters are
>   * named in accordance with RFC2819, RFC2021 and IEEE Std 802.3-2002 Annex
> @@ -1829,6 +1854,278 @@ static void vsc73xx_port_stp_state_set(struct dsa_switch *ds, int port,
>  		vsc73xx_refresh_fwd_map(ds, port, state);
>  }
>  
> +static u16 vsc73xx_calc_hash(const unsigned char *addr, u16 vid)
> +{
> +	/* VID 5-0, MAC 47-44 */
> +	u16 hash = ((vid & GENMASK(5, 0)) << 4) | (addr[0] >> 4);
> +
> +	/* MAC 43-33 */
> +	hash ^= ((addr[0] & GENMASK(3, 0)) << 7) | (addr[1] >> 1);
> +	/* MAC 32-22 */
> +	hash ^= ((addr[1] & BIT(0)) << 10) | (addr[2] << 2) | (addr[3] >> 6);
> +	/* MAC 21-11 */
> +	hash ^= ((addr[3] & GENMASK(5, 0)) << 5) | (addr[4] >> 3);
> +	/* MAC 10-0 */
> +	hash ^= ((addr[4] & GENMASK(2, 0)) << 8) | addr[5];

In this function and throughout this patchset I see a lot of mask nd shift
operations, sometimes combined, here and elsewhere in this patchset. It
seems likely that using FIELD_PREP, in conjunction with GENMASK and BIT,
would be appropriate instead. If combined with #defines for the GENMASK and
BIT constants with meaningful names this may significantly improve
readability.

> +
> +	return hash;
> +}

...

