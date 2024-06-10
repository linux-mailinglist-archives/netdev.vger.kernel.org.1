Return-Path: <netdev+bounces-102151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA462901A27
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 07:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1D11C20943
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 05:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0965010A03;
	Mon, 10 Jun 2024 05:19:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BE8D27E
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 05:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717996790; cv=none; b=rA74LFMGY+A1mqHGNGi4kVqXmnmh+LD94p7CVUHJDDz/B9DLubMaMqLLld89eDJEWK3cq5+/7n7lah36RBGssQ7rGlEy8JJ/O89TBt9FvKyvHuVlGg9UVVZil4zpAr4T95vPi4o7XnVwJ3QNVcqB2eNkjCQnsIQJwPzsp/CbXEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717996790; c=relaxed/simple;
	bh=g8i8kFB4TIVpY3Nz/WcNPFscAVNpwKVeg3EK32oUVTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnYySnpz4Bq9nVR9hgPIcCqWmG4IlY8h1qU48zvwLxhi6ZWpgdQGVXbHmgBs30A0OAUQ2hI7J+TW7KtnvRiuROSby14l6q9ZRr4Dte54ISMkJiuhf7P4nKT6/0JCi0t2/5Cd5clWL9cqj0sO5Ma38BgISAo6sjaisVXSN7AEU3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sGXO8-0004F8-Mh; Mon, 10 Jun 2024 07:16:12 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sGXO5-001E4V-Tt; Mon, 10 Jun 2024 07:16:09 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sGXO5-002foM-2g;
	Mon, 10 Jun 2024 07:16:09 +0200
Date: Mon, 10 Jun 2024 07:16:09 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next v2 2/8] net: ethtool: pse-pd: Expand C33 PSE
 status with class, power and extended state
Message-ID: <ZmaMGWMOvILHy8Iu@pengutronix.de>
References: <20240607-feature_poe_power_cap-v2-0-c03c2deb83ab@bootlin.com>
 <20240607-feature_poe_power_cap-v2-2-c03c2deb83ab@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240607-feature_poe_power_cap-v2-2-c03c2deb83ab@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Köry,

Thank you for your work.

On Fri, Jun 07, 2024 at 09:30:19AM +0200, Kory Maincent wrote:
> From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>

...

>  /**
> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> index 8733a3117902..ef65ad4612d2 100644
> --- a/include/uapi/linux/ethtool.h
> +++ b/include/uapi/linux/ethtool.h
> @@ -752,6 +752,47 @@ enum ethtool_module_power_mode {
>  	ETHTOOL_MODULE_POWER_MODE_HIGH,
>  };
>  
> +/* C33 PSE extended state */
> +enum ethtool_c33_pse_ext_state {
> +	ETHTOOL_C33_PSE_EXT_STATE_UNKNOWN = 1,

I assume, In case the state is unknown, better to set it to 0 and not
report it to the user space in the first place. Do we really need it?

> +	ETHTOOL_C33_PSE_EXT_STATE_DETECTION,
> +	ETHTOOL_C33_PSE_EXT_STATE_CLASSIFICATION_FAILURE,
> +	ETHTOOL_C33_PSE_EXT_STATE_HARDWARE_ISSUE,
> +	ETHTOOL_C33_PSE_EXT_STATE_VOLTAGE_ISSUE,
> +	ETHTOOL_C33_PSE_EXT_STATE_CURRENT_ISSUE,
> +	ETHTOOL_C33_PSE_EXT_STATE_POWER_BUDGET_EXCEEDED,

What is the difference between POWER_BUDGET_EXCEEDED and
STATE_CURRENT_ISSUE->CRT_OVERLOAD? If there is some difference, it
should be commented.

Please provide comments describing how all of this states and substates
should be used.

> +	ETHTOOL_C33_PSE_EXT_STATE_CONFIG,
> +	ETHTOOL_C33_PSE_EXT_STATE_TEMP_ISSUE,
> +};

...

>  /**
>   * enum ethtool_pse_types - Types of PSE controller.
>   * @ETHTOOL_PSE_UNKNOWN: Type of PSE controller is unknown
> diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
> index b49b804b9495..ccbe8294dfd5 100644
> --- a/include/uapi/linux/ethtool_netlink.h
> +++ b/include/uapi/linux/ethtool_netlink.h
> @@ -915,6 +915,10 @@ enum {
>  	ETHTOOL_A_C33_PSE_ADMIN_STATE,		/* u32 */
>  	ETHTOOL_A_C33_PSE_ADMIN_CONTROL,	/* u32 */
>  	ETHTOOL_A_C33_PSE_PW_D_STATUS,		/* u32 */
> +	ETHTOOL_A_C33_PSE_PW_CLASS,		/* u32 */
> +	ETHTOOL_A_C33_PSE_ACTUAL_PW,		/* u32 */
> +	ETHTOOL_A_C33_PSE_EXT_STATE,		/* u8 */
> +	ETHTOOL_A_C33_PSE_EXT_SUBSTATE,		/* u8 */

Please, increase the size to u32 for state and substate.

>  	/* add new constants above here */
>  	__ETHTOOL_A_PSE_CNT,
> diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
> index 2c981d443f27..3d74cfe7765b 100644
> --- a/net/ethtool/pse-pd.c
> +++ b/net/ethtool/pse-pd.c
> @@ -86,7 +86,14 @@ static int pse_reply_size(const struct ethnl_req_info *req_base,
>  		len += nla_total_size(sizeof(u32)); /* _C33_PSE_ADMIN_STATE */
>  	if (st->c33_pw_status > 0)
>  		len += nla_total_size(sizeof(u32)); /* _C33_PSE_PW_D_STATUS */
> -
> +	if (st->c33_pw_class > 0)
> +		len += nla_total_size(sizeof(u32)); /* _C33_PSE_PW_CLASS */
> +	if (st->c33_actual_pw > 0)
> +		len += nla_total_size(sizeof(u32)); /* _C33_PSE_ACTUAL_PW */
> +	if (st->c33_ext_state_info.c33_pse_ext_state)
> +		len += nla_total_size(sizeof(u8)); /* _C33_PSE_EXT_STATE */
> +	if (st->c33_ext_state_info.__c33_pse_ext_substate)
> +		len += nla_total_size(sizeof(u8)); /* _C33_PSE_EXT_SUBSTATE */

Substate can be properly decoded only if state is not zero.

>  	return len;
>  }
>  
> @@ -117,6 +124,26 @@ static int pse_fill_reply(struct sk_buff *skb,
>  			st->c33_pw_status))
>  		return -EMSGSIZE;
>  
> +	if (st->c33_pw_class > 0 &&
> +	    nla_put_u32(skb, ETHTOOL_A_C33_PSE_PW_CLASS,
> +			st->c33_pw_class))
> +		return -EMSGSIZE;
> +
> +	if (st->c33_actual_pw > 0 &&
> +	    nla_put_u32(skb, ETHTOOL_A_C33_PSE_ACTUAL_PW,
> +			st->c33_actual_pw))
> +		return -EMSGSIZE;
> +
> +	if (st->c33_ext_state_info.c33_pse_ext_state > 0 &&
> +	    nla_put_u8(skb, ETHTOOL_A_C33_PSE_EXT_STATE,
> +		       st->c33_ext_state_info.c33_pse_ext_state))
> +		return -EMSGSIZE;
> +
> +	if (st->c33_ext_state_info.__c33_pse_ext_substate > 0 &&
> +	    nla_put_u8(skb, ETHTOOL_A_C33_PSE_EXT_SUBSTATE,
> +		       st->c33_ext_state_info.__c33_pse_ext_substate))
> +		return -EMSGSIZE;

ditto.

Please update Documentation/networking/ethtool-netlink.rst

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

