Return-Path: <netdev+bounces-286356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPGXJrrBAGppMQEAu9opvQ
	(envelope-from <netdev+bounces-286356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:34:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 396EF505704
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9FA943001FD1
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89DD3B2FC0;
	Sun, 10 May 2026 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3xAe9PU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5992390C90;
	Sun, 10 May 2026 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778434487; cv=none; b=JMeZjZezw/KEbnACSb1bTgOj0f98wvUjPCi7aJMfGTX5k+Ya1OC4XmBQqrAdD41WVhq4mmsg8UAs0QVoNpLe+cvn/04SH5QNEeBJoQq+d5rakKr50CRg+hx93VlcA1VSN9Pde/0g/LNMXrAx1ifbRzD2hqw8/GNbclR47/MxVAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778434487; c=relaxed/simple;
	bh=OOsI+5HllTxEMuiDYLXP1yV+AiWhZw68Mg+PB8B4cv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X56b9tfZ9OuAhXgNc+dOI42rNsk2qL4CcGid1oEik3K9qel1IgN6UckA7bSEgMmkGhkQNR8vhl70DmACfJcIsfPubqI2QFwRAIZS8VlOvAnqcJao9RA3kM8pxQhYakD0L12mf/OAWLG8p8UfFeEQtq1PZbvTVrxfnvA2E4cvw+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3xAe9PU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5444C2BCB8;
	Sun, 10 May 2026 17:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778434487;
	bh=OOsI+5HllTxEMuiDYLXP1yV+AiWhZw68Mg+PB8B4cv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G3xAe9PUM8ptgU41d9PYDooGaa5hMFnSlOwX9n/JgSTzgVuepCSXgsqUxALfkTcf+
	 78q+giI78TBJlt7SpTs/uIngYBrpCNA6EK8QMO1CV940qPIB2vnWq//tGyiuPRjunD
	 wrVXUGATgRH7Bb3RdYCVVM53SQ8Q8ueCL7RjreaZgO0w3xgL+DvaC9aglPEbJZ0F+y
	 LvU+OLAPzYQSdn5tPOXiCKN5qewiUJSa0Ga5jbVTUsbTnDbuGBNr2Mt3OGMvmiGwHe
	 McDv8on4qnbiQKD+tsujfBEpnBX/tvsPiLZ5u1iW6GHLum09MIl5OAsG02F4EOJx76
	 ycaZRux2dtolw==
From: Jakub Kicinski <kuba@kernel.org>
To: luizluca@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linusw@kernel.org,
	alsi@bang-olufsen.dk,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v3 2/8] net: dsa: realtek: rtl8365mb: use dsa helpers for port iteration
Date: Sun, 10 May 2026 10:34:45 -0700
Message-ID: <20260510173445.3919786-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506-realtek_forward-v3-2-1d87c5f85a3b@gmail.com>
References: <20260506-realtek_forward-v3-2-1d87c5f85a3b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 396EF505704
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286356-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: realtek: rtl8365mb: use dsa helpers for port iteration

This commit refactors rtl8365mb port iteration to use the
dsa_switch_for_each_*() helpers, adds a blocking setup phase for all
ports up front, and extends CPU-port isolation to include all user
ports.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
> index edbc16345d0d..7ddb82fcd026 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb.c

[ ... ]

> @@ -1943,11 +1946,11 @@ static int rtl8365mb_reset_chip(struct realtek_priv *priv)
>  static int rtl8365mb_setup(struct dsa_switch *ds)
>  {
>  	struct realtek_priv *priv = ds->priv;
> +	struct dsa_port *cpu_dp, *dp;
>  	struct rtl8365mb_cpu *cpu;
> -	struct dsa_port *cpu_dp;
>  	struct rtl8365mb *mb;
> +	u32 userports_mask;
>  	int ret;
> -	int i;
>  
>  	mb = priv->chip_data;
>  	cpu = &mb->cpu;

[ ... ]

> +	/* Start with all ports blocked, including unused ports */
> +	dsa_switch_for_each_port(dp, ds) {
> +		struct rtl8365mb_port *p = &mb->ports[dp->index];
> +
> +		/* Set the initial STP state of all ports to DISABLED, otherwise
> +		 * ports will still forward frames to the CPU despite being
> +		 * administratively down by default.
> +		 */
> +		rtl8365mb_port_stp_state_set(ds, dp->index, BR_STATE_DISABLED);
> +
> +		/* Start with all port completely isolated */
> +		ret = rtl8365mb_port_set_isolation(priv, dp->index, 0);
> +		if (ret)
> +			goto out_teardown_irq;
> +
> +		/* Disable learning */
> +		ret = rtl8365mb_port_set_learning(priv, dp->index, false);
> +		if (ret)
> +			goto out_teardown_irq;
> +
> +		/* Set up per-port private data */
> +		p->priv = priv;
> +		p->index = dp->index;
> +	}
> +
> +	userports_mask = dsa_user_ports(ds);
> +
>  	/* Configure CPU tagging */
>  	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
> -		cpu->mask |= BIT(cpu_dp->index);
> -
> +		/* Use the first CPU port as trap_port */
>  		if (cpu->trap_port == RTL8365MB_MAX_NUM_PORTS)
>  			cpu->trap_port = cpu_dp->index;
> +
> +		/* Forward to all user ports */
> +		ret = rtl8365mb_port_set_isolation(priv, cpu_dp->index,
> +						   userports_mask);
> +		if (ret)
> +			goto out_teardown_irq;
>  	}
> +
> +	cpu->mask = dsa_cpu_ports(ds);
>  	cpu->enable = cpu->mask > 0;
>  	ret = rtl8365mb_cpu_config(priv);
>  	if (ret)
>  		goto out_teardown_irq;
>  
> -	/* Configure ports */
> -	for (i = 0; i < priv->num_ports; i++) {
> -		struct rtl8365mb_port *p = &mb->ports[i];
> -
> -		if (dsa_is_unused_port(ds, i))
> -			continue;
> -
> +	/* Configure user ports */
> +	dsa_switch_for_each_user_port(dp, ds) {
>  		/* Forward only to the CPU */
> -		ret = rtl8365mb_port_set_isolation(priv, i, cpu->mask);
> +		ret = rtl8365mb_port_set_isolation(priv, dp->index, cpu->mask);
>  		if (ret)
>  			goto out_teardown_irq;

[Medium]
Does this refactor change behaviour for DSA-type ports (DSA_PORT_TYPE_DSA)?

Before the patch, the configuration loop iterated every non-unused port
and applied cpu->mask as the isolation mask, which included DSA-type
ports:

	for (i = 0; i < priv->num_ports; i++) {
		...
		if (dsa_is_unused_port(ds, i))
			continue;
		/* Forward only to the CPU */
		ret = rtl8365mb_port_set_isolation(priv, i, cpu->mask);
		...
	}

After the patch, the first pass sets isolation to 0 for every port, and
the subsequent passes only match CPU ports and user ports:

	#define dsa_switch_for_each_cpu_port(_dp, _ds) \
		dsa_switch_for_each_port((_dp), (_ds)) \
			if (dsa_port_is_cpu((_dp)))

	#define dsa_switch_for_each_user_port(_dp, _ds) \
		dsa_switch_for_each_port((_dp), (_ds)) \
			if (dsa_port_is_user((_dp)))

So a DSA-type port keeps isolation=0 from the initial pass and is never
reconfigured.

In addition, the masks derived from dsa_user_ports() and dsa_cpu_ports()
exclude DSA-type ports, so CPU and user ports will not include DSA link
ports in their isolation masks either, which looks like it would block
forwarding across cascaded switches in both directions.

The commit message describes the behaviour change only as "CPU isolation
now includes all user ports"; is the loss of DSA-port configuration
intentional, and if so should it be called out in the commit message?
-- 
pw-bot: cr

