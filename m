Return-Path: <netdev+bounces-266234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAz5EAxMsGnFhgIAu9opvQ
	(envelope-from <netdev+bounces-266234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:51:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DAB255150
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1A533081B3E
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590D039DBC6;
	Tue, 10 Mar 2026 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgPsHxCe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70842FE07D
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158027; cv=none; b=Ifa4z9V5djN+oZu0pGDlyQd0Q2bnbm+D1TrJsFjJ7V6UalngkMhn8jnJam3ezXiSXRVYEZhqTAME3Skt/xhz80O2fx2RJXDCeClXSs4sKvSCEv0ffbZDPOBKmTgksQLSYA6fytJHlxpzug35JTwzy8FQzmFvAkEqqLDvBddrmvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158027; c=relaxed/simple;
	bh=xE38PIW7k3Rp8Yz8EXLxoWawWxd6fjo+5oucyDwMeUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWEWBOTv5lifJgiJ/z1tFNpyhz0ZCUBiueKAq5BrmBDVPyt0VbxnQ7bxty/O9p3bKuchOiGZCKSvF5jd4qyyHs1CMQLU5k1VkPfoPB1MU/VNfGQD4NXhsCaaWBxszfyUGU/LMYOMpSsZYOWAfjGfUNBa4frdKFdy5FM6UE5H5zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgPsHxCe; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439b1cf1212so659457f8f.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 08:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773158024; x=1773762824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O1KsDAwNUAjRBEsq0OxxQCbJI4i2M2k1aOeUxShAjKY=;
        b=OgPsHxCekdH5xc7cZbl8XFt3quWpFht38ZtpFpwDsr2eZckDISu5JGaP5Q0fgO9Jvz
         eo1JgJ/wQ6Y/+h63lnhbyl8iLbr0+Qi449kbTCa0R5q58C/hLL32/BXYn4lazzhOhpmd
         F0b6vU31tz8GdqBTr8v43KxedtFNOpcuXhJ/HQ02bbu92WmU/9WJHH3r/jMzi0YllwoP
         y3Rv31Z7EH5bgDTy6+5PIYNENCMxKQwqsZIikISBjFDiRL01HlcxkAeUGOK/fpsSOYdp
         X2EppYfYx33kyEytY9T1l36Fz9+u2AABxcYrusu67eD/48eeL3ThSca3qXenVj9IEqI/
         Riqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773158024; x=1773762824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1KsDAwNUAjRBEsq0OxxQCbJI4i2M2k1aOeUxShAjKY=;
        b=HEB/GdhOW1zpBrGC0dJkj0dnsWstVTHqC7fK0lzH6luOBy6Gs1h6zAspKvGn65TCeD
         IowIQ5rg3tkmn3byY6FhV7X3/ojC2txPIALJdGxwESU2Q0pNvZ9oKywXhYf9+1egY/QV
         nChzAxzZVHY+eKi5s/O2IejWpE/t91DTCTcBfmKn8mcj+TjOcp2jkm6eLW8cufMZibs8
         BQuuNrt6/ZSaPgyn7DnJ6ulC3AfQtWUYFKphy98WgXEMJ9NQ08bj6SqQew8fFF3Xesaw
         0TN5otMpfbzuUUDFDGAaw7tEKNU67m0s3xgSlOCOYRHhNQoLmNCgAglIVn92oyi6Y1qg
         hSpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbAAStvswIOCZ51XotrRV6ng+QsmXBQ6w4UGdpzgC3YT+yzWe8CP+q73LxT/YUWqjURF6QjRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJNtDWD7juRpWbJ6PBH4GJR4A9nInGXdaNvHJUZ6whyEYs/MCW
	V4qiF0ypTRCy1PYNlyXwpk/d3eyLFNrYDAwgENpVlKnovnVkEUKLDa1w
X-Gm-Gg: ATEYQzy+YvpnYNrhCzN/sjGFxSa5ZHMdzVZxNJ0rjKsL6ORR08lqbDMjR8QI4GsNvSp
	2JYbCOlXxz5JUKEi9fUMU1ING51O15zprRxUWtpBBvgLKAE8sFNqpt6q+HeBYlz0oCD5gRXP/0A
	UmlMv+JD95+RkONziGl3t4I/nlMLWNrxPyY9kvODo3yIM9KIJpMd6sGD/bBy9vEiH4356/McOcw
	nWj74LKHfDrsR+jFe4zbsrBt9tjhHjLlYVF+d+Eom/nigmn6KBTul+itQXHP+TVzUxAuhvmnaY4
	WhB33t7tvmfWaQdwTqjKk4bCFBHhK5VNrquzaaRNEhKFuDe0rxE4RvwMN6d+BrKm6m0/ygQsHXf
	YWjiTWmoDNRaQDK+nNN0V3uxCaWmC58EKpyFw++pM9m92dvc3bT2R0e3hKHttNFL/AddoLNtVCE
	4eXRzz7hl0HElVdg==
X-Received: by 2002:a05:6000:2481:b0:439:cb39:9094 with SMTP id ffacd0b85a97d-439da8832acmr15831292f8f.3.1773158023822;
        Tue, 10 Mar 2026 08:53:43 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d00a:e00:43cb:c21c:efe7:d225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d973sm34625690f8f.3.2026.03.10.08.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 08:53:42 -0700 (PDT)
Date: Tue, 10 Mar 2026 17:53:40 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Wunderlich <frankwu@gmx.de>,
	Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v2 2/2] net: dsa: mxl862xx: implement bridge
 offloading
Message-ID: <20260310155340.urq5nudvdxrl6sfx@skbuf>
References: <cover.1773102942.git.daniel@makrotopia.org>
 <f6fb8c9c6d38585c0efce72b3d1aebe923277d5a.1773102942.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6fb8c9c6d38585c0efce72b3d1aebe923277d5a.1773102942.git.daniel@makrotopia.org>
X-Rspamd-Queue-Id: 45DAB255150
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266234-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Daniel,

On Tue, Mar 10, 2026 at 12:40:29AM +0000, Daniel Golle wrote:
>  * drop manually resetting port learning state on bridge<->standalone
>    transitions, DSA framework takes care of that
(...)
> +	/* Revert leaving port to its single-port bridge */
> +	if (!join) {
> +		dp = dsa_to_port(ds, port);
> +
> +		bitmap_zero(priv->ports[port].portmap, MXL862XX_MAX_BRIDGE_PORTS);
> +		__set_bit(dp->cpu_dp->index, priv->ports[port].portmap);
> +		priv->ports[port].flood_block = 0;
> +		priv->ports[port].learning = false;

So is this needed or not? Change log says "drop" but code says "keep".

The core does:
dsa_port_bridge_leave()
-> dsa_port_switchdev_unsync_attrs()
   -> dsa_port_clear_brport_flags()
      -> dsa_port_bridge_flags() // BR_LEARNING in mask and not in val

> +		ret = mxl862xx_set_bridge_port(ds, port);
> +		if (err)
> +			ret = err;
> +
> +		mxl862xx_port_fast_age(ds, port);
> +	}
(...)
>  * manually mxl862xx_port_fast_age() in mxl862xx_port_stp_state_set()
>    to avoid FDB poisoning due to race condition
(...)
> +	/* Revert leaving port to its single-port bridge */
> +	if (!join) {
> +		dp = dsa_to_port(ds, port);
> +
> +		bitmap_zero(priv->ports[port].portmap, MXL862XX_MAX_BRIDGE_PORTS);
> +		__set_bit(dp->cpu_dp->index, priv->ports[port].portmap);
> +		priv->ports[port].flood_block = 0;
> +		priv->ports[port].learning = false;
> +		ret = mxl862xx_set_bridge_port(ds, port);
> +		if (err)
> +			ret = err;
> +
> +		mxl862xx_port_fast_age(ds, port);
> +	}

I only requested this to be done on mxl862xx_port_stp_state_set(), as a
consequence to your workaround, not on mxl862xx_port_bridge_leave() ->
mxl862xx_update_bridge().

The framework actually has logic to fast age the FDB. A standalone port
is in BR_STATE_FORWARDING, and a leaving/joining bridge port goes
through BR_STATE_DISABLED - del_nbp() -> br_stp_disable_port().
So we have a guaranteed STP transition based on which this hook runs:

dsa_port_switchdev_unsync_attrs():
	/* Port left the bridge, put in BR_STATE_DISABLED by the bridge layer,
	 * so allow it to be in BR_STATE_FORWARDING to be kept functional
	 */
	dsa_port_set_state_now(dp, BR_STATE_FORWARDING, true);
->
		/* Fast age FDB entries or flush appropriate forwarding database
		 * for the given port, if we are moving it from Learning or
		 * Forwarding state, to Disabled or Blocking or Listening state.
		 * Ports that were standalone before the STP state change don't
		 * need to fast age the FDB, since address learning is off in
		 * standalone mode.
		 */

		if ((dp->stp_state == BR_STATE_LEARNING ||
		     dp->stp_state == BR_STATE_FORWARDING) &&
		    (state == BR_STATE_DISABLED ||
		     state == BR_STATE_BLOCKING ||
		     state == BR_STATE_LISTENING))
			dsa_port_fast_age(dp);

so I think fast aging is unnecessary here.

Your workaround is different, DSA doesn't know that
dsa_port_set_state(BR_STATE_LEARNING) with dp->learning == false
actually temporarily enables learning. It assumes it doesn't, so it
doesn't call dsa_port_fast_age(). That's why you have to do it.


Did you reply to my comment from v1 to remove the "bool join" false
sharing from mxl862xx_update_bridge()? Because you didn't, and I'm not
sure why.

I meant to see:

static int mxl862xx_sync_bridge_members(struct dsa_switch *ds,
					struct mxl862xx_bridge *mxlbridge)
{
	struct mxl862xx_priv *priv = ds->priv;
	int member, ret = 0;

	/* Update all current bridge members' portmaps */
	for_each_set_bit(member, mxlbridge->portmap,
			 MXL862XX_MAX_BRIDGE_PORTS) {
		struct dsa_port *dp = dsa_to_port(ds, member);
		int err;

		/* Build portmap: CPU port + all bridge members except self */
		bitmap_copy(priv->ports[member].portmap, mxlbridge->portmap,
			    MXL862XX_MAX_BRIDGE_PORTS);
		__clear_bit(member, priv->ports[member].portmap);
		__set_bit(dp->cpu_dp->index, priv->ports[member].portmap);

		err = mxl862xx_set_bridge_port(ds, member);
		if (err)
			ret = err;
	}

	return ret;
}

static int mxl862xx_port_bridge_join(struct dsa_switch *ds, int port,
				     struct dsa_bridge bridge,
				     bool *tx_fwd_offload,
				     struct netlink_ext_ack *extack)
{
	struct mxl862xx_bridge *mxlbridge;

	mxlbridge = mxl862xx_find_bridge(ds, bridge);
	if (!mxlbridge) {
		mxlbridge = mxl862xx_allocate_bridge(ds, bridge.num);
		if (IS_ERR(mxlbridge))
			return PTR_ERR(mxlbridge);
	}

	__set_bit(port, mxlbridge->portmap);
	priv->ports[port].bridge = mxlbridge;

	/* The operation may fail mid way and there is no way to restore
	 * the driver in sync with a known FW state. So we consider FW
	 * I/O failure as catastrophic, no point to complicate the
	 * driver by restoring mxlbridge->portmap or the bridge pointer.
	 */
	return mxl862xx_sync_bridge_members(ds, mxlbridge);
}

static void mxl862xx_port_bridge_leave(struct dsa_switch *ds, int port,
				       struct dsa_bridge bridge)
{
	struct dsa_port *dp = dsa_to_port(ds, port);
	struct mxl862xx_bridge *mxlbridge;
	int err;

	mxlbridge = mxl862xx_find_bridge(ds, bridge);
	if (!mxlbridge)
		return;

	__clear_bit(port, mxlbridge->portmap);
	priv->ports[port].bridge = NULL;

	err = mxl862xx_sync_bridge_members(ds, mxlbridge);
	if (err) {
		dev_err(ds->dev,
			"failed to sync bridge members after port %d left: %pe\n",
			port, ERR_PTR(err));
	}

	/* Revert leaving port, omitted by the sync above, to its
	 * single-port bridge
	 */
	bitmap_zero(priv->ports[port].portmap, MXL862XX_MAX_BRIDGE_PORTS);
	__set_bit(dp->cpu_dp->index, priv->ports[port].portmap);
	priv->ports[port].flood_block = 0;
	err = mxl862xx_set_bridge_port(ds, port);
	if (err) {
		dev_err(ds->dev,
			"failed to update bridge port %d state: %pe\n", port,
			ERR_PTR(err));
	}

	return MXL862XX_API_WRITE(ds->priv, MXL862XX_BRIDGEPORT_CONFIGSET, br_port_cfg);
	if (bitmap_empty(mxlbridge->portmap, MXL862XX_MAX_BRIDGE_PORTS))
		mxl862xx_free_bridge(ds, mxlbridge);
}

