Return-Path: <netdev+bounces-259754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YD9rJ+irmGkuKwMAu9opvQ
	(envelope-from <netdev+bounces-259754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 19:46:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB87D16A2BE
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 19:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 652EF300A657
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 18:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B971F7541;
	Fri, 20 Feb 2026 18:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzO/fjbw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E25F21578D
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 18:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771613154; cv=none; b=WVFZAV8RBMk5A4/i+lQcNN5/6cLff3Rt+5F39BPZN4h22n2Cu70EYdk1TEV36rY7L21W506EN74ONaY833j5s7gMWxEf/HtaV5bON/uK4RCFVZqyF5B56bV4nYxEenlGdlq5xwJH9rNMHkNUUOaDn1kMy+pkJpOPCITtD72/qyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771613154; c=relaxed/simple;
	bh=I+FoKYknpgZW3JgoOfEmuJj4OSlAqRu055MiAvJO+Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsilP/JWaDnsa+Is4fVSbwcgDb8GIkuNxtDG8PkryCqX5a24uBIyb6pkBalWjlCVzyWj2y42MlMiqGR+lWRsIlySqO8e0eXw1VGFOEizAIxbK1Qxf/X6CdICQhQs7t4xaNQ5D085qxfG6O1tJU39xAbB5iFvyYyZwVI9kt7HhY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzO/fjbw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806fd9033bso2484855e9.3
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 10:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771613151; x=1772217951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5sTeqhSgOGnadWEwgGW0D/7x8YD5TEs3siVJeHi3PXc=;
        b=RzO/fjbwWyqTBffDxx+49cNVA2Csay1PZAreoMOO/JTtDph68RCP0yyWTI7RTaM6f3
         UhgYJTG15IgcjEJHpK80pq1PzNKg71Ti6B11P1EPNC5QPZbCvOv5RsUHitaAH6Xvj7B6
         E1QjeeNPfRjXRVB8qtvhKojrmLfREiFnYvO5oA/ftAlUXYTcVcPyT960ARIKPAr6Plyr
         qZUY0fDLmoJJPdEIGTiiQsi0bHpsNah69Jga3GRu6KTcPYWoQfItS4J1NkDGgWIIKqsN
         XxD3hvR8XidzGHWBkavBiBgE5Egqr21rRrSGJ52ailNwXUhmtHvbMFCB2ej5KfCl3Yc9
         RtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771613151; x=1772217951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sTeqhSgOGnadWEwgGW0D/7x8YD5TEs3siVJeHi3PXc=;
        b=pF9ZosTQ2KqytWrdAa0sAKb9Aa84kO0hPkDIqaQecLxmAUQ0X7/jzKpRqzEGwXVpOE
         yoRnGTpGn3od0DKwQSlA/jD06CNWOT6gemroISE0bYjp+ZvWrDBN+7aXitJLPhd1kJxF
         BfzQcvFF4RZ0bBON56yxlQHEtQqlEwwpz7ZndHOwbmH4vr5YT0Ostl+vGqlz5+RAonPW
         OCqkd0tvC3Yl2WpZSaOPpXF2NxTOsHSVx0OeEG4h+Bx3FI/K0PbWqxSZXRqjhZJmzc+u
         oKUILZJy86o34hNwbV3Hx1WSOBUYUKX9fzy6kouMjDXamsKn2CPEnZHvOmMrSNZqtlaf
         df1A==
X-Forwarded-Encrypted: i=1; AJvYcCWHgx4rrupvVoAuHLExn+F+YGCzT0XnAdiTQwNrUtHuNqAdKNNywvh6NF6QcJzXAC5jRkAdfvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi0Ar9H2TzC8F/7xMU9DTyxS7KUNXeOsSiDbRTaZs4Nv5hm+IP
	P+R3V/FKzeU94jxnUvNDVNigsYAOtLBrla2ezSj4pxaK5NeO81uxnsHC
X-Gm-Gg: AZuq6aLlzwzXpISE037oyTfsxtFcJZMzFYAoPkrWiE6EitfrxnbEEtYihbwS/mVsHtm
	LcluldnQw5S5lVkdg7O+ux5er6HQ5DppXc2gHxWzyQfSllicIm9yS5YsKJzxh/Mt80HZ/gct6HX
	mo5TS6CzedY62cBBcCazyB90VT1oCaM0+vXHXMJKo/mgiEQsA3dB3UMoBKEysZidh1IiY3HII1L
	foXZlel7vhJ0rZACYPsKeOeZ9QwCKFlWxNTIO76W8WvztjasaWEmqXIIXRY8w8+evXC6ijL6I1s
	/WXsNvjFgx+h5vxDmZZEETtwLa+xjn+cEuE1WXwDXcAWYbCtGNKlTFFXrc3acGJ7yst24tyE3fV
	mFiFURwU1kS8/pUk6PnKq45jlEFh29sHQ9Pf58cYSLX6dlrgKRNZYn2BUp8iAfou48XuNi2pO42
	4XGdQnHGNTzFhhTzY=
X-Received: by 2002:a05:600c:1c24:b0:477:5ca6:4d51 with SMTP id 5b1f17b1804b1-483a95dc5bfmr5800685e9.3.1771613151137;
        Fri, 20 Feb 2026 10:45:51 -0800 (PST)
Received: from skbuf ([2a02:2f04:d603:6e00:e3bb:35f1:11ae:419e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9caadedsm1162995e9.10.2026.02.20.10.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 10:45:50 -0800 (PST)
Date: Fri, 20 Feb 2026 20:45:47 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v3 5/5] net: dsa: ks8995: Implement port isolation
Message-ID: <20260220184547.o7ygnl4aiu2jufao@skbuf>
References: <20260219-ks8995-fixups-v3-0-a7fc63fe1916@kernel.org>
 <20260219-ks8995-fixups-v3-0-a7fc63fe1916@kernel.org>
 <20260219-ks8995-fixups-v3-5-a7fc63fe1916@kernel.org>
 <20260219-ks8995-fixups-v3-5-a7fc63fe1916@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219-ks8995-fixups-v3-5-a7fc63fe1916@kernel.org>
 <20260219-ks8995-fixups-v3-5-a7fc63fe1916@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259754-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB87D16A2BE
X-Rspamd-Action: no action

Hi Linus,

Some excerpts from AI review which I considered relevant.

On Thu, Feb 19, 2026 at 03:24:21PM +0100, Linus Walleij wrote:
> It is unsound to not have proper port isolation on a
> switch which supports it.
> 
> Set each port as isolated by default in the setup callback
> and de-isolate and isolate the ports in the bridge join/leave
> callbacks.
> 
> Fixes: a7fe8b266f65 ("net: dsa: ks8995: Add basic switch set-up")
> Reported-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/net/dsa/ks8995.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 129 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/ks8995.c b/drivers/net/dsa/ks8995.c
> index 1ed81a8f7d21..dbae218fb015 100644
> --- a/drivers/net/dsa/ks8995.c
> +++ b/drivers/net/dsa/ks8995.c
> @@ -80,6 +80,11 @@
>  #define KS8995_PC0_TAG_REM	BIT(1)	/* Enable tag removal on port */
>  #define KS8995_PC0_PRIO_EN	BIT(0)	/* Enable priority handling */
>  
> +#define KS8995_PC1_SNIFF_PORT	BIT(7)	/* This port is a sniffer port */
> +#define KS8995_PC1_RCV_SNIFF	BIT(6)	/* Packets received goes to sniffer port(s) */
> +#define KS8995_PC1_XMIT_SNIFF	BIT(5)	/* Packets transmitted goes to sniffer port(s) */
> +#define KS8995_PC1_PORT_VLAN	GENMASK(4, 0)	/* Port isolation mask */
> +
>  #define KS8995_PC2_TXEN		BIT(2)	/* Enable TX on port */
>  #define KS8995_PC2_RXEN		BIT(1)	/* Enable RX on port */
>  #define KS8995_PC2_LEARN_DIS	BIT(0)	/* Disable learning on port */
> @@ -441,6 +446,44 @@ dsa_tag_protocol ks8995_get_tag_protocol(struct dsa_switch *ds,
>  
>  static int ks8995_setup(struct dsa_switch *ds)
>  {
> +	struct ks8995_switch *ks = ds->priv;
> +	int ret;
> +	u8 val;
> +	int i;
> +
> +	/* Isolate all user ports so they can only send packets to itself and the CPU port */

This isn't a bug, but the comment terminology might be clearer. The use
of "isolation" could be confused with the BR_ISOLATED bridge port flag
(from "man bridge", isolated bridge ports "will be able to communicate
with non-isolated ports only"). Vladimir Oltean recommended avoiding
"isolation" related terminology for user port separation in v2.

Reference: https://lore.kernel.org/netdev/20260119224805.hjvh5xdjfhd6c6kf@skbuf/

[ you walked past most of my review comments on v2 with no pushback as
to why you won't apply them ]

> +	for (i = 0; i < KS8995_CPU_PORT; i++) {
> +		ret = ks8995_read_reg(ks, KS8995_REG_PC(i, KS8995_REG_PC1), &val);
> +		if (ret) {
> +			dev_err(ks->dev, "failed to read KS8995_REG_PC1 on port %d\n", i);
> +			return ret;
> +		}

Do you need to perform a register read at probe time, or could you just
call ks8995_write_reg() with known good values for the sniff port bits
too? Vladimir Oltean questioned this in v2.

> +
> +		val &= ~KS8995_PC1_PORT_VLAN;
> +		val |= (BIT(i) | BIT(KS8995_CPU_PORT));
> +
> +		ret = ks8995_write_reg(ks, KS8995_REG_PC(i, KS8995_REG_PC1), val);
> +		if (ret) {
> +			dev_err(ks->dev, "failed to write KS8995_REG_PC1 on port %d\n", i);
> +			return ret;
> +		}
> +	}
> +
> +	/* The CPU port should be able to talk to all ports */
> +	ret = ks8995_read_reg(ks, KS8995_REG_PC(KS8995_CPU_PORT, KS8995_REG_PC1), &val);
> +	if (ret) {
> +		dev_err(ks->dev, "failed to read KS8995_REG_PC1 on CPU port\n");
> +		return ret;
> +	}
> +
> +	val |= KS8995_PC1_PORT_VLAN;

Does this enable hairpinning on the CPU port? Writing
KS8995_PC1_PORT_VLAN (GENMASK(4, 0)) includes KS8995_CPU_PORT (4), which
would enable reflection of forwarded traffic on the CPU port. Vladimir
Oltean raised this concern in v2.

> +
> +	ret = ks8995_write_reg(ks, KS8995_REG_PC(KS8995_CPU_PORT, KS8995_REG_PC1), val);
> +	if (ret) {
> +		dev_err(ks->dev, "failed to write KS8995_REG_PC1 on CPU port\n");
> +		return ret;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -466,8 +509,44 @@ static int ks8995_port_bridge_join(struct dsa_switch *ds, int port,
>  				   bool *tx_fwd_offload,
>  				   struct netlink_ext_ack *extack)
>  {
> +	struct ks8995_switch *ks = ds->priv;
> +	u8 port_bitmap = 0;
> +	int ret;
> +	u8 val;
> +	int i;
> +
> +	/* De-isolate this port from any other port on the bridge */
> +	port_bitmap |= BIT(port);
> +	for (i = 0; i < KS8995_CPU_PORT; i++) {
> +		if (i == port)
> +			continue;
> +		if (!dsa_port_offloads_bridge(dsa_to_port(ds, i), &bridge))
> +			continue;
> +		port_bitmap |= BIT(i);
> +	}
> +
> +	/* Update all affected ports with the new bitmask */
> +	for (i = 0; i < KS8995_CPU_PORT; i++) {
> +		if (!dsa_port_offloads_bridge(dsa_to_port(ds, i), &bridge))
> +			continue;
> +
> +		ret = ks8995_read_reg(ks, KS8995_REG_PC(i, KS8995_REG_PC1), &val);
> +		if (ret) {
> +			dev_err(ks->dev, "failed to read KS8995_REG_PC1 on port %d\n", i);
> +			return ret;
> +		}
> +
> +		val |= port_bitmap;

Can this create a hairpinning problem? When a new port joins a bridge,
the existing ports start enabling forwarding to themselves as well since
dsa_port_offloads_bridge() returns true for the currently joining port,
and the port_bitmap written to port i contains BIT(i) set. Vladimir
Oltean raised this concern in v2.

> +
> +		ret = ks8995_write_reg(ks, KS8995_REG_PC(i, KS8995_REG_PC1), val);
> +		if (ret) {
> +			dev_err(ks->dev, "failed to write KS8995_REG_PC1 on port %d\n", i);
> +			return ret;
> +		}
> +	}
> +
>  	/* port_stp_state_set() will be called after to put the port in
> -	 * appropriate state so there is no need to do anything.
> +	 * appropriate state.
>  	 */
>  
>  	return 0;
> @@ -476,8 +555,56 @@ static int ks8995_port_bridge_join(struct dsa_switch *ds, int port,
>  static void ks8995_port_bridge_leave(struct dsa_switch *ds, int port,
>  				     struct dsa_bridge bridge)
>  {
> +	struct ks8995_switch *ks = ds->priv;
> +	u8 port_bitmap = 0;
> +	int ret;
> +	u8 val;
> +	int i;
> +
> +	/* Isolate this port from any other port on the bridge */
> +	for (i = 0; i < KS8995_CPU_PORT; i++) {
> +		/* Current port handled last */
> +		if (i == port)
> +			continue;
> +		/* Not on this bridge */
> +		if (!dsa_port_offloads_bridge(dsa_to_port(ds, i), &bridge))
> +			continue;
> +
> +		ret = ks8995_read_reg(ks, KS8995_REG_PC(i, KS8995_REG_PC1), &val);
> +		if (ret) {
> +			dev_err(ks->dev, "failed to read KS8995_REG_PC1 on port %d\n", i);
> +			return;
> +		}
> +
> +		val &= ~BIT(port);
> +
> +		ret = ks8995_write_reg(ks, KS8995_REG_PC(i, KS8995_REG_PC1), val);
> +		if (ret) {
> +			dev_err(ks->dev, "failed to write KS8995_REG_PC1 on port %d\n", i);
> +			return;
> +		}
> +
> +		/* Accumulate this port for access by current */
> +		port_bitmap |= BIT(i);
> +	}
> +
> +	/* Isolate this port from all other ports formerly on the bridge */
> +	ret = ks8995_read_reg(ks, KS8995_REG_PC(port, KS8995_REG_PC1), &val);
> +	if (ret) {
> +		dev_err(ks->dev, "failed to read KS8995_REG_PC1 on port %d\n", port);
> +		return;
> +	}
> +
> +	val &= ~port_bitmap;
> +
> +	ret = ks8995_write_reg(ks, KS8995_REG_PC(port, KS8995_REG_PC1), val);
> +	if (ret) {
> +		dev_err(ks->dev, "failed to write KS8995_REG_PC1 on port %d\n", port);
> +		return;
> +	}
> +
>  	/* port_stp_state_set() will be called after to put the port in
> -	 * forwarding state so there is no need to do anything.
> +	 * forwarding state.
>  	 */
>  }
>  
> 
> -- 
> 2.53.0
> 


