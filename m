Return-Path: <netdev+bounces-213333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C05D7B249B5
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 14:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE9A564415
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 12:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A762E172F;
	Wed, 13 Aug 2025 12:44:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447D92E11CB
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755089079; cv=none; b=VMswQim0cWFht7QxByme2/NGz6GEAnxYYUW6Yi3zITYjNlJP5WwZJnYJanHjThB48GU2ZDvLH4H9TI2gfonjW8w+903GRX/0UwJ7sRPBIj10d2iC7T6bfFAnerxyEXqUlhVOWNq5txxJD/ioRY5QVUzjK5nIy72Zj8zHzZHIdho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755089079; c=relaxed/simple;
	bh=jR6dXCBHCycpp6tXXaFEalzyWUvL8750GHQGErf0GcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dt/cM07B4yKsmFpsYwMuTaMPMnRpz+rcvTOitm2OqgdywxExB9CvOZ/C7rVYnZZ7U9Y4IPVYMkRTrWJr07hJdz6r90pb2OVVTlbzBORScFDE9J/30EhsOVUhR0S8HOsmMtCwSHIV1tCnERdPV5IOW9q9hUfLqRHUVsKnMgFRnAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1umAqC-00066E-Ae; Wed, 13 Aug 2025 14:44:28 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1umAqB-0005ki-1i;
	Wed, 13 Aug 2025 14:44:27 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1umAqB-00954v-1L;
	Wed, 13 Aug 2025 14:44:27 +0200
Date: Wed, 13 Aug 2025 14:44:27 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>,
	Dent Project <dentproject@linuxfoundation.org>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH ethtool v2 3/3] ethtool: pse-pd: Add PSE event monitoring
 support
Message-ID: <aJyIqz4T1MWuI-p9@pengutronix.de>
References: <20250813-b4-feature_poe_pw_budget-v2-0-0bef6bfcc708@bootlin.com>
 <20250813-b4-feature_poe_pw_budget-v2-3-0bef6bfcc708@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250813-b4-feature_poe_pw_budget-v2-3-0bef6bfcc708@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Aug 13, 2025 at 10:57:52AM +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
.... 
> diff --git a/netlink/pse-pd.c b/netlink/pse-pd.c
> index 5bde176..3fb0616 100644
> --- a/netlink/pse-pd.c
> +++ b/netlink/pse-pd.c
> @@ -475,6 +475,64 @@ int nl_gpse(struct cmd_context *ctx)
>  	return ret;
>  }
>  
> +static const char *pse_events_name(u64 val)
> +{
> +	switch (val) {
> +	case ETHTOOL_PSE_EVENT_OVER_CURRENT:
> +		return "over-current";
> +	case ETHTOOL_PSE_EVENT_OVER_TEMP:
> +		return "over-temperature";
> +	case ETHTOOL_C33_PSE_EVENT_DETECTION:
> +		return "detection";
> +	case ETHTOOL_C33_PSE_EVENT_CLASSIFICATION:
> +		return "classification";
> +	case ETHTOOL_C33_PSE_EVENT_DISCONNECTION:
> +		return "disconnection";
> +	case ETHTOOL_PSE_EVENT_OVER_BUDGET:
> +		return "over-budget";
> +	case ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR:
> +		return "software power control error";
> +	default:
> +		return "unknown";
> +	}
> +}
> +
> +int pse_ntf_cb(const struct nlmsghdr *nlhdr, void *data)
> +{
> +	const struct nlattr *tb[ETHTOOL_A_PSE_MAX + 1] = {};

s/ETHTOOL_A_PSE_MAX/ETHTOOL_A_PSE_NTF_MAX ?

> +	struct nl_context *nlctx = data;
> +	DECLARE_ATTR_TB_INFO(tb);
> +	u64 val;
> +	int ret, i;
> +
> +	ret = mnl_attr_parse(nlhdr, GENL_HDRLEN, attr_cb, &tb_info);
> +	if (ret < 0)
> +		return MNL_CB_OK;
> +
> +	if (!tb[ETHTOOL_A_PSE_NTF_EVENTS])
> +		return MNL_CB_OK;
> +
> +	nlctx->devname = get_dev_name(tb[ETHTOOL_A_PSE_HEADER]);

s/ETHTOOL_A_PSE_HEADER/ETHTOOL_A_PSE_NTF_HEADER ?

> +	if (!dev_ok(nlctx))
> +		return MNL_CB_OK;
> +
> +	open_json_object(NULL);
> +	print_string(PRINT_ANY, "ifname", "PSE event for %s:\n",
> +		     nlctx->devname);
> +	open_json_array("events", "Events:");
> +	val = attr_get_uint(tb[ETHTOOL_A_PSE_NTF_EVENTS]);

we have here uint but val is u64, is it as expected?

> +	for (i = 0; 1 << i <= ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR; i++)
> +		if (val & 1 << i)
> +			print_string(PRINT_ANY, NULL, " %s",
> +				     pse_events_name(val & 1 << i));

Hm, may be it is better to not limit to ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR
and report unknow numeric value. It will keep even old ethtool at least
partially usable.
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

