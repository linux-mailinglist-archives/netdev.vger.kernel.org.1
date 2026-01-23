Return-Path: <netdev+bounces-252991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BXgIrkIdGmE1gAAu9opvQ
	(envelope-from <netdev+bounces-252991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 00:48:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E7F7B899
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 00:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94CF830058CA
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 23:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4C0226CF1;
	Fri, 23 Jan 2026 23:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoLqFaPM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB11A18BC3B
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 23:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769212086; cv=none; b=WSwpKqHHI+yV1LVFTbpxEe7xoVYEhkiki7KK+w7HdMw6KoiWzuf3R+lcO72fJ5fWQusj+3qG/wh3GSG97SM50Bp5F/tqSUgxWJwxFJ2xteLpK9X8Nq6C3wywWrBmDjyEQR/Ni5i4JmH+fztAvgVNua1kh1LCoEsLo4kMS2p+l18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769212086; c=relaxed/simple;
	bh=PndA3WeLOU7rZwJEirsnF4irpC7N4GY9T20GGV7w33k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geclVNEr9scznDchKg756RrQR+R4D0tNCLB4Mq0MON3EeJA7ou/PMH4RazzbvRYckE8ye0mMWgbX9wC12xu+PtoiwaQWkkAp7AG8gWRBta0lwzG2ehyJ+ELwPzfJpUzC5cwuiVDTomtsKwq5djBqyOc1XhrQFrG31G1GOS7e/9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoLqFaPM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47eda5806d7so2534815e9.3
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 15:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769212083; x=1769816883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LrdDh3oo6541XkK84IRM8yuRg1bVj8bq8XmL2yTUb5A=;
        b=YoLqFaPMyHDxF240H5T5SvV+tgtDRnd7FRZ57YGpGKlGw2IKyOHXyew2fgjdBfUDW/
         QJmZdbQTlW+JptVRriGh99dkjfV5RLCpdCIPI1nYT5PeTPp87hqeQLW0KiIfaWmrIeWy
         1YAsfaCccg+D5tv7iiIGTZSRal+dxPF+774Gi/QIYhbbVBmy0r/wEBJRI8SGm4Shn0PK
         LroE/vtUABKY2ochnxzyQFjvvY1U6nhHx3h64nOf3BAZWj91P1xVY75TI2wYYLlMFS4a
         vYayFhdnltinvi2KVSOEqsXU34/VseVv4RqgFiTulU24M92osPK+pl8vBFp+DMWptXiJ
         zaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769212083; x=1769816883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrdDh3oo6541XkK84IRM8yuRg1bVj8bq8XmL2yTUb5A=;
        b=TubNkJ4L4J//Th1oOZOFiX/S9wCsC/JOUoTfoV6+jjRVHQ8I8fhP5CaunjZDO1LpSw
         utjHNchhzR8BF4H0UeU8Vq9cQUzafr8XE3uHmEsOFAc0ny7465UppOfr2xsKnwpQ8zyt
         +ha79D1zWNYRG0IG67mx0/4KVa9WIfS4py53iU7ec4y8ql4ueWkG7/z8e5bhK7iplnk2
         oRiGS7f0TjGxsnt2C/pFGsK9cr79Rnv1G9YNaTVv/ycf/RxLWVEH8+6nFhIKuK3gyPiE
         +Y8tuLP8QP8WUnqQF8+NQsXPpY4jjVhSaeDQmVuOKKHtsNBYB86224whmEPtM67k7np3
         3ZqA==
X-Gm-Message-State: AOJu0YzRZD2rVFsNvCJRptEaMYtLYgPB2MZHWcLlOCYOXvnZ5Nr5O3u7
	VCO2ujrEKRr3qg7BzGsbDzMyCx088pCbGCZA5gI2xJN6Zn8PAESU6M9Q
X-Gm-Gg: AZuq6aLYurjBbupz8D1Y5yGNGZ/HJqCYNb9Do2ExzJYWfaopDfo8TOc25uZ46kqhOVk
	0VMQaIV5KMUK3Xoc5ukCPZ5Zkh7z6ZzyXUlai9kTesnpbUxPFT7TaEUAsZNs3fAsYerR4CjUShG
	6zDl/rWEQtDYO4Ern89odtWul9ZcVzmNbXosBd9gJ+EwJZhbi2+9IAFdDxpkb+0lsusuUpdwqwT
	FAkCnaiC3Cq2r3T3+bpbDfcqmctYYhBuC/tfr1t4aU575TVmm4u/7RBYzPj9bWlhZQhonyKzRGR
	QuBwmmE+imsDlz4X+4yjipnvUc2ke0Keah7zKgY7AZA1LwwUn9FSYACF2r5XpXmDi+oQGHBn0tB
	VF0Mr80jx8oUK08Unt8N2NGX7x4GW8M7zfRL3O1oNQgppoZ2N/LsbExHMVhT55mV3COjrNBrvuJ
	lf4g==
X-Received: by 2002:a05:600c:64c5:b0:477:7bd8:8f2d with SMTP id 5b1f17b1804b1-48054204c10mr10501025e9.8.1769212082760;
        Fri, 23 Jan 2026 15:48:02 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:1430:8b48:2d45:6c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d84588fsm89217015e9.2.2026.01.23.15.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 15:48:01 -0800 (PST)
Date: Sat, 24 Jan 2026 01:47:59 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: David Yang <mmyangfl@gmail.com>,
	Oleksij Rempel <linux@rempel-privat.de>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: dsa: yt921x: Add DCB/priority
 support
Message-ID: <20260123234759.bj2gik3oobluyjs4@skbuf>
References: <20260122194233.2777550-1-mmyangfl@gmail.com>
 <20260122194233.2777550-3-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122194233.2777550-3-mmyangfl@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252991-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,rempel-privat.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 30E7F7B899
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 03:42:30AM +0800, David Yang wrote:
> Set up global DSCP/PCP priority mappings and add related DSA methods.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/net/dsa/Kconfig  |   2 +
>  drivers/net/dsa/yt921x.c | 232 +++++++++++++++++++++++++++++++++++++++
>  drivers/net/dsa/yt921x.h |  54 +++++++--
>  3 files changed, 278 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
> index 7eb301fd987d..d73d7fa7f7d2 100644
> --- a/drivers/net/dsa/Kconfig
> +++ b/drivers/net/dsa/Kconfig
> @@ -158,6 +158,8 @@ config NET_DSA_VITESSE_VSC73XX_PLATFORM
>  config NET_DSA_YT921X
>  	tristate "Motorcomm YT9215 ethernet switch chip support"
>  	select NET_DSA_TAG_YT921X
> +	select NET_IEEE8021Q_HELPERS
> +	select DCB
>  	help
>  	  This enables support for the Motorcomm YT9215 ethernet switch
>  	  chip.
> diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
> index a4b346ddf8dd..5f3287421c94 100644
> --- a/drivers/net/dsa/yt921x.c
> +++ b/drivers/net/dsa/yt921x.c
> @@ -18,8 +18,11 @@
>  #include <linux/of.h>
>  #include <linux/of_mdio.h>
>  #include <linux/of_net.h>
> +#include <linux/sort.h>
>  
>  #include <net/dsa.h>
> +#include <net/dscp.h>
> +#include <net/ieee8021q.h>
>  
>  #include "yt921x.h"
>  
> @@ -2391,6 +2394,140 @@ yt921x_dsa_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
>  			port, res);
>  }
>  
> +static int
> +yt921x_dsa_port_get_default_prio(struct dsa_switch *ds, int port)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	u32 val;
> +	int res;
> +
> +	mutex_lock(&priv->reg_lock);
> +	res = yt921x_reg_read(priv, YT921X_PORTn_QOS(port), &val);
> +	mutex_unlock(&priv->reg_lock);
> +
> +	if (res)
> +		return res;
> +
> +	return FIELD_GET(YT921X_PORT_QOS_PRIO_M, val);
> +}
> +
> +static int
> +yt921x_dsa_port_set_default_prio(struct dsa_switch *ds, int port, u8 prio)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	u32 mask;
> +	u32 ctrl;
> +	int res;
> +
> +	if (prio >= YT921X_PRIO_NUM)
> +		return -EINVAL;
> +
> +	mutex_lock(&priv->reg_lock);
> +	mask = YT921X_PORT_QOS_PRIO_M | YT921X_PORT_QOS_PRIO_EN;
> +	ctrl = YT921X_PORT_QOS_PRIO(prio) | YT921X_PORT_QOS_PRIO_EN;
> +	res = yt921x_reg_update_bits(priv, YT921X_PORTn_QOS(port), mask, ctrl);
> +	mutex_unlock(&priv->reg_lock);
> +
> +	return res;
> +}
> +
> +static const u8 yt921x_apps[] = {
> +	0,	/* MAC SA */
> +	0,	/* MAC DA */
> +	0,	/* VID */
> +	0,	/* ACL */
> +	IEEE_8021QAZ_APP_SEL_DSCP,	/* DSCP */
> +	DCB_APP_SEL_PCP,	/* CVLAN PCP */
> +	0,	/* SVLAN PCP */
> +	0,	/* Port */
> +};

Could you please make an

enum yt921x_app_selector {
	YT921X_APP_SEL_MAC_SA,
	YT921X_APP_SEL_MAC_DA,
	YT921X_APP_SEL_VID,
	YT921X_APP_SEL_ACL,
	YT921X_APP_SEL_DSCP,
	YT921X_APP_SEL_CVLAN_PCP,
	YT921X_APP_SEL_SVLAN_PCP,
	YT921X_APP_SEL_PORT,
	YT921X_APP_SEL_NUM
};

so that you can more clearly express:

static const u8 yt921x_apps[YT921X_APP_SEL_NUM] = {
	[YT921X_APP_SEL_DSCP] = IEEE_8021QAZ_APP_SEL_DSCP,
	[YT921X_APP_SEL_CVLAN_PCP] = DCB_APP_SEL_PCP,
};

and reformulate prios[7] from yt921x_dsa_port_set_apptrust() as
prios[YT921X_APP_SEL_PORT]?

> +
> +static int appprios_cmp(const void *a, const void *b)
> +{
> +	return ((const u8 *)b)[1] - ((const u8 *)a)[1];
> +}
> +
> +static int
> +yt921x_dsa_port_get_apptrust(struct dsa_switch *ds, int port, u8 *sel,
> +			     int *nselp)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	u8 appprios[ARRAY_SIZE(yt921x_apps)][2];
> +	int nsel;
> +	u32 val;
> +	int res;
> +
> +	mutex_lock(&priv->reg_lock);
> +	res = yt921x_reg_read(priv, YT921X_PORTn_PRIO_ORD(port), &val);
> +	mutex_unlock(&priv->reg_lock);
> +
> +	if (res)
> +		return res;
> +
> +	for (int src = 0; src < ARRAY_SIZE(yt921x_apps); src++) {
> +		appprios[src][0] = yt921x_apps[src];
> +		appprios[src][1] = (val >> (3 * src)) & 7;
> +	}
> +	sort(appprios, ARRAY_SIZE(appprios), sizeof(appprios[0]), appprios_cmp,
> +	     NULL);
> +
> +	nsel = 0;
> +	for (int i = 0; i < ARRAY_SIZE(appprios) && appprios[i][1]; i++)
> +		if (appprios[i][0]) {
> +			sel[nsel] = appprios[i][0];
> +			nsel++;
> +		}
> +	*nselp = nsel;
> +
> +	return 0;
> +}
> +
> +static int
> +yt921x_dsa_port_set_apptrust(struct dsa_switch *ds, int port, const u8 *sel,
> +			     int nsel)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	u8 prios[ARRAY_SIZE(yt921x_apps)] = {};
> +	u32 ctrl;
> +	u8 prio;
> +	int res;
> +
> +	if (nsel > ARRAY_SIZE(yt921x_apps))
> +		return -EINVAL;
> +
> +	/* always take the port prio (port_set_default_prio) into
> +	 * consideration, by giving it the lowest priority
> +	 */

Are you sure the "port" selector represents the Ethernet port default
priority? It seems odd for it to have any other trust order in hardware
than last. What would be the use case for that? Sure it's not an L4 port,
which could be mapped over IEEE_8021QAZ_APP_SEL_ANY?

> +	prios[7] = 1;

I'm not following, why is "1" the lowest priority here?

> +	prio = 7;
> +	for (int i = 0; i < nsel; i++) {
> +		bool found = false;
> +
> +		for (int src = 0; src < ARRAY_SIZE(yt921x_apps); src++) {
> +			if (yt921x_apps[src] != sel[i])
> +				continue;
> +
> +			prios[src] = prio;
> +			prio--;
> +			found = true;
> +			break;
> +		}
> +
> +		if (!found)
> +			return -EOPNOTSUPP;

Some feedback to the user regarding the app selector that is invalid,
similar to ksz_apptrust_error(), would be nice / friendlier.

> +	}
> +
> +	ctrl = 0;
> +	for (int src = 0; src < ARRAY_SIZE(yt921x_apps); src++)
> +		ctrl |= YT921X_PORT_PRIO_ORD_SRCm(src, prios[src]);
> +
> +	mutex_lock(&priv->reg_lock);
> +	res = yt921x_reg_write(priv, YT921X_PORTn_PRIO_ORD(port), ctrl);
> +	mutex_unlock(&priv->reg_lock);
> +
> +	return res;
> +}
> +
>  static int yt921x_port_down(struct yt921x_priv *priv, int port)
>  {
>  	u32 mask;
> @@ -2759,6 +2896,58 @@ static int yt921x_dsa_port_setup(struct dsa_switch *ds, int port)
>  	return res;
>  }
>  
> +#define ipm_drop(prio) \
> +	YT921X_IPM_DROP_PRIO((prio) <= IEEE8021Q_TT_EE ? 2 : \
> +			     (prio) <= IEEE8021Q_TT_VO ? 1 : 0)
> +#define ipm_ctrl(prio) (YT921X_IPM_PRIO(prio) | ipm_drop(prio))
> +
> +static int
> +yt921x_dsa_port_get_dscp_prio(struct dsa_switch *ds, int port, u8 dscp)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	u32 val;
> +	int res;
> +
> +	mutex_lock(&priv->reg_lock);
> +	res = yt921x_reg_read(priv, YT921X_IPM_DSCPn(dscp), &val);
> +	mutex_unlock(&priv->reg_lock);
> +
> +	if (res)
> +		return res;
> +
> +	return FIELD_GET(YT921X_IPM_PRIO_M, val);
> +}
> +
> +static int
> +yt921x_dsa_port_del_dscp_prio(struct dsa_switch *ds, int port, u8 dscp, u8 prio)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	int res;
> +
> +	mutex_lock(&priv->reg_lock);
> +	res = yt921x_reg_write(priv, YT921X_IPM_DSCPn(dscp),
> +			       ipm_ctrl(IEEE8021Q_TT_BK));

Question regarding semantics, also for Oleksij: deleting the DSCP app
table entry should cause that DSCP value to be mapped to bulk, as in
your interpretation (or best effort for KSZ), or according to the next
selector in line, as per trust order (for example port default priority,
which may not be bulk)?

> +	mutex_unlock(&priv->reg_lock);
> +
> +	return res;
> +}
> +
> +static int
> +yt921x_dsa_port_add_dscp_prio(struct dsa_switch *ds, int port, u8 dscp, u8 prio)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	int res;
> +
> +	if (prio >= YT921X_PRIO_NUM)
> +		return -EINVAL;
> +
> +	mutex_lock(&priv->reg_lock);
> +	res = yt921x_reg_write(priv, YT921X_IPM_DSCPn(dscp), ipm_ctrl(prio));
> +	mutex_unlock(&priv->reg_lock);
> +
> +	return res;
> +}
> +
>  static int yt921x_edata_wait(struct yt921x_priv *priv, u32 *valp)
>  {
>  	u32 val = YT921X_EDATA_DATA_IDLE;
> @@ -2978,6 +3167,40 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
>  	if (res)
>  		return res;
>  
> +	/* 802.1Q QoS to priority mapping table */
> +	for (u8 pcp = 0; pcp < 8; pcp++) {
> +		u32 drop = ipm_drop(pcp);
> +
> +		for (u8 dei = 0; dei < 2; dei++) {
> +			ctrl = YT921X_IPM_PRIO(pcp);
> +			if (!dei)
> +				ctrl |= drop;
> +			else
> +				ctrl |= YT921X_IPM_DROP_PRIO(2);
> +
> +			for (u8 svlan = 0; svlan < 2; svlan++) {
> +				u32 reg = YT921X_IPM_PCPn(svlan, dei, pcp);
> +
> +				res = yt921x_reg_write(priv, reg, ctrl);
> +				if (res)
> +					return res;
> +			}
> +		}
> +	}
> +
> +	/* DSCP to priority mapping table */
> +	for (u8 dscp = 0; dscp < DSCP_MAX; dscp++) {
> +		int prio = ietf_dscp_to_ieee8021q_tt(dscp);
> +
> +		if (prio < 0)
> +			return prio;
> +
> +		res = yt921x_reg_write(priv, YT921X_IPM_DSCPn(dscp),
> +				       ipm_ctrl(prio));
> +		if (res)
> +			return res;
> +	}
> +

nitpick: yt921x_chip_setup() is already pretty long and it is hard to
follow its control flow (whether any operation needs teardown). Could
you break up the QoS initialization into a separate function rather than
inlining it?

>  	/* Miscellaneous */
>  	res = yt921x_reg_set_bits(priv, YT921X_SENSOR, YT921X_SENSOR_TEMP);
>  	if (res)
> @@ -3087,10 +3310,19 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
>  	.port_mst_state_set	= yt921x_dsa_port_mst_state_set,
>  	.vlan_msti_set		= yt921x_dsa_vlan_msti_set,
>  	.port_stp_state_set	= yt921x_dsa_port_stp_state_set,
> +	/* dcb */
> +	.port_get_default_prio	= yt921x_dsa_port_get_default_prio,
> +	.port_set_default_prio	= yt921x_dsa_port_set_default_prio,
> +	.port_get_apptrust	= yt921x_dsa_port_get_apptrust,
> +	.port_set_apptrust	= yt921x_dsa_port_set_apptrust,
>  	/* port */
>  	.get_tag_protocol	= yt921x_dsa_get_tag_protocol,
>  	.phylink_get_caps	= yt921x_dsa_phylink_get_caps,
>  	.port_setup		= yt921x_dsa_port_setup,
> +	/* dscp */
> +	.port_get_dscp_prio	= yt921x_dsa_port_get_dscp_prio,
> +	.port_del_dscp_prio	= yt921x_dsa_port_del_dscp_prio,
> +	.port_add_dscp_prio	= yt921x_dsa_port_add_dscp_prio,
>  	/* chip */
>  	.setup			= yt921x_dsa_setup,
>  };
> diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
> index bacd4ccaa8e5..6c380bda38fb 100644
> --- a/drivers/net/dsa/yt921x.h
> +++ b/drivers/net/dsa/yt921x.h
> @@ -269,6 +269,37 @@
>  #define YT921X_TPID_EGRn(x)		(0x100300 + 4 * (x))	/* [0, 3] */
>  #define  YT921X_TPID_EGR_TPID_M			GENMASK(15, 0)
>  
> +#define YT921X_IPM_DSCPn(n)		(0x180000 + 4 * (n))	/* Internal Priority Map */
> +#define YT921X_IPM_PCPn(map, dei, pcp)	(0x180100 + 4 * (16 * (map) + 8 * (dei) + (pcp)))
> +#define  YT921X_IPM_PRIO_M			GENMASK(4, 2)
> +#define   YT921X_IPM_PRIO(x)				FIELD_PREP(YT921X_IPM_PRIO_M, (x))
> +#define  YT921X_IPM_DROP_PRIO_M			GENMASK(1, 0)
> +#define   YT921X_IPM_DROP_PRIO(x)			FIELD_PREP(YT921X_IPM_DROP_PRIO_M, (x))
> +#define YT921X_PORTn_QOS(port)		(0x180180 + 4 * (port))
> +#define  YT921X_PORT_QOS_CVLAN_PRIO_MAP_SEL	BIT(5)
> +#define  YT921X_PORT_QOS_SVLAN_PRIO_MAP_SEL	BIT(4)
> +#define  YT921X_PORT_QOS_PRIO_M			GENMASK(3, 1)
> +#define   YT921X_PORT_QOS_PRIO(x)			FIELD_PREP(YT921X_PORT_QOS_PRIO_M, (x))
> +#define  YT921X_PORT_QOS_PRIO_EN			BIT(0)
> +#define YT921X_PORTn_PRIO_ORD(port)	(0x180200 + 4 * (port))
> +#define  YT921X_PORT_PRIO_ORD_SRCm_M(m)		GENMASK(3 * (m) + 2, 3 * (m))
> +#define   YT921X_PORT_PRIO_ORD_SRCm(m, x)		((x) << (3 * (m)))
> +#define  YT921X_PORT_PRIO_ORD_PORT_M		GENMASK(23, 21)
> +#define   YT921X_PORT_PRIO_ORD_PORT(x)			FIELD_PREP(YT921X_PORT_PRIO_ORD_PORT_M, (x))
> +#define  YT921X_PORT_PRIO_ORD_SVLAN_M		GENMASK(20, 18)
> +#define   YT921X_PORT_PRIO_ORD_SVLAN(x)			FIELD_PREP(YT921X_PORT_PRIO_ORD_SVLAN_M, (x))
> +#define  YT921X_PORT_PRIO_ORD_CVLAN_M		GENMASK(17, 15)
> +#define   YT921X_PORT_PRIO_ORD_CVLAN(x)			FIELD_PREP(YT921X_PORT_PRIO_ORD_CVLAN_M, (x))
> +#define  YT921X_PORT_PRIO_ORD_DSCP_M		GENMASK(14, 12)
> +#define   YT921X_PORT_PRIO_ORD_DSCP(x)			FIELD_PREP(YT921X_PORT_PRIO_ORD_DSCP_M, (x))
> +#define  YT921X_PORT_PRIO_ORD_ACL_M		GENMASK(11, 9)
> +#define   YT921X_PORT_PRIO_ORD_ACL(x)			FIELD_PREP(YT921X_PORT_PRIO_ORD_ACL_M, (x))
> +#define  YT921X_PORT_PRIO_ORD_VID_M		GENMASK(8, 6)
> +#define   YT921X_PORT_PRIO_ORD_VID(x)			FIELD_PREP(YT921X_PORT_PRIO_ORD_VID_M, (x))
> +#define  YT921X_PORT_PRIO_ORD_MAC_DA_M		GENMASK(5, 3)
> +#define   YT921X_PORT_PRIO_ORD_MAC_DA(x)		FIELD_PREP(YT921X_PORT_PRIO_ORD_MAC_DA_M, (x))
> +#define  YT921X_PORT_PRIO_ORD_MAC_SA_M		GENMASK(2, 0)
> +#define   YT921X_PORT_PRIO_ORD_MAC_SA(x)		FIELD_PREP(YT921X_PORT_PRIO_ORD_MAC_SA_M, (x))
>  #define YT921X_VLAN_IGR_FILTER		0x180280
>  #define  YT921X_VLAN_IGR_FILTER_PORTn_BYPASS_IGMP(port)	BIT((port) + 11)
>  #define  YT921X_VLAN_IGR_FILTER_PORTn(port)	BIT(port)
> @@ -337,7 +368,7 @@
>  #define YT921X_FDB_OUT0			0x1804b0
>  #define  YT921X_FDB_IO0_ADDR_HI4_M		GENMASK(31, 0)
>  #define YT921X_FDB_OUT1			0x1804b4
> -#define  YT921X_FDB_IO1_EGR_INT_PRI_EN		BIT(31)
> +#define  YT921X_FDB_IO1_EGR_PRIO_EN		BIT(31)
>  #define  YT921X_FDB_IO1_STATUS_M		GENMASK(30, 28)
>  #define   YT921X_FDB_IO1_STATUS(x)			FIELD_PREP(YT921X_FDB_IO1_STATUS_M, (x))
>  #define   YT921X_FDB_IO1_STATUS_INVALID			YT921X_FDB_IO1_STATUS(0)
> @@ -356,9 +387,9 @@
>  #define   YT921X_FDB_IO2_EGR_PORTS(x)			FIELD_PREP(YT921X_FDB_IO2_EGR_PORTS_M, (x))
>  #define  YT921X_FDB_IO2_EGR_DROP		BIT(17)
>  #define  YT921X_FDB_IO2_COPY_TO_CPU		BIT(16)
> -#define  YT921X_FDB_IO2_IGR_INT_PRI_EN		BIT(15)
> -#define  YT921X_FDB_IO2_INT_PRI_M		GENMASK(14, 12)
> -#define   YT921X_FDB_IO2_INT_PRI(x)			FIELD_PREP(YT921X_FDB_IO2_INT_PRI_M, (x))
> +#define  YT921X_FDB_IO2_IGR_PRIO_EN		BIT(15)
> +#define  YT921X_FDB_IO2_PRIO_M			GENMASK(14, 12)
> +#define   YT921X_FDB_IO2_PRIO(x)			FIELD_PREP(YT921X_FDB_IO2_PRIO_M, (x))
>  #define  YT921X_FDB_IO2_NEW_VID_M		GENMASK(11, 0)
>  #define   YT921X_FDB_IO2_NEW_VID(x)			FIELD_PREP(YT921X_FDB_IO2_NEW_VID_M, (x))
>  #define YT921X_FILTER_UNK_UCAST		0x180508
> @@ -406,8 +437,9 @@
>  #define  YT921X_VLAN_CTRL_FID_M			GENMASK_ULL(34, 23)
>  #define   YT921X_VLAN_CTRL_FID(x)			FIELD_PREP(YT921X_VLAN_CTRL_FID_M, (x))
>  #define  YT921X_VLAN_CTRL_LEARN_DIS		BIT_ULL(22)
> -#define  YT921X_VLAN_CTRL_INT_PRI_EN		BIT_ULL(21)
> -#define  YT921X_VLAN_CTRL_INT_PRI_M		GENMASK_ULL(20, 18)
> +#define  YT921X_VLAN_CTRL_PRIO_EN		BIT_ULL(21)
> +#define  YT921X_VLAN_CTRL_PRIO_M		GENMASK_ULL(20, 18)
> +#define   YT921X_VLAN_CTRL_PRIO(x)			FIELD_PREP(YT921X_VLAN_CTRL_PRIO_M, (x))
>  #define  YT921X_VLAN_CTRL_PORTS_M		GENMASK_ULL(17, 7)
>  #define   YT921X_VLAN_CTRL_PORTS(x)			FIELD_PREP(YT921X_VLAN_CTRL_PORTS_M, (x))
>  #define  YT921X_VLAN_CTRL_PORTn(port)		BIT_ULL((port) + 7)
> @@ -433,14 +465,14 @@
>  #define  YT921X_LAG_HASH_SRC_PORT		BIT(0)
>  
>  #define YT921X_PORTn_VLAN_CTRL(port)	(0x230010 + 4 * (port))
> -#define  YT921X_PORT_VLAN_CTRL_SVLAN_PRI_EN	BIT(31)
> -#define  YT921X_PORT_VLAN_CTRL_CVLAN_PRI_EN	BIT(30)
> +#define  YT921X_PORT_VLAN_CTRL_SVLAN_PRIO_EN	BIT(31)
> +#define  YT921X_PORT_VLAN_CTRL_CVLAN_PRIO_EN	BIT(30)
>  #define  YT921X_PORT_VLAN_CTRL_SVID_M		GENMASK(29, 18)
>  #define   YT921X_PORT_VLAN_CTRL_SVID(x)			FIELD_PREP(YT921X_PORT_VLAN_CTRL_SVID_M, (x))
>  #define  YT921X_PORT_VLAN_CTRL_CVID_M		GENMASK(17, 6)
>  #define   YT921X_PORT_VLAN_CTRL_CVID(x)			FIELD_PREP(YT921X_PORT_VLAN_CTRL_CVID_M, (x))
> -#define  YT921X_PORT_VLAN_CTRL_SVLAN_PRI_M	GENMASK(5, 3)
> -#define  YT921X_PORT_VLAN_CTRL_CVLAN_PRI_M	GENMASK(2, 0)
> +#define  YT921X_PORT_VLAN_CTRL_SVLAN_PRIO_M	GENMASK(5, 3)
> +#define  YT921X_PORT_VLAN_CTRL_CVLAN_PRIO_M	GENMASK(2, 0)
>  #define YT921X_PORTn_VLAN_CTRL1(port)	(0x230080 + 4 * (port))
>  #define  YT921X_PORT_VLAN_CTRL1_VLAN_RANGE_EN	BIT(8)
>  #define  YT921X_PORT_VLAN_CTRL1_VLAN_RANGE_PROFILE_ID_M	GENMASK(7, 4)
> @@ -478,6 +510,8 @@ enum yt921x_fdb_entry_status {
>  #define YT921X_LAG_NUM		2
>  #define YT921X_LAG_PORT_NUM	4
>  
> +#define YT921X_PRIO_NUM	8
> +
>  #define YT9215_MAJOR	0x9002
>  #define YT9218_MAJOR	0x9001
>  
> -- 
> 2.51.0
> 

