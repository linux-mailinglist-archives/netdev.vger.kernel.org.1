Return-Path: <netdev+bounces-298804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pTNsCA6KLGrwSAQAu9opvQ
	(envelope-from <netdev+bounces-298804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 00:37:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A75AE67CC77
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 00:37:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XH0hi3Gm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298804-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298804-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A212300F44F
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 22:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514773672AF;
	Fri, 12 Jun 2026 22:36:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214F437BE72;
	Fri, 12 Jun 2026 22:36:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303819; cv=none; b=ifWfCHcpQvKCERAPtMy0SpfCC+Qo+4bFgBKua+NAxj+rpwc0nAoQtFctF4cOjtf7YyyIfPpwkcxIeQbk1qpniU9Mqy26DQ/Fg7S853lwmwbJHNhSvF+loYJdfiDwShZhW951gIgSTBc66RdeT7HNIiHlJu62y+syhndKtC50Uck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303819; c=relaxed/simple;
	bh=OWEr4UjLTmGYspsAznONo7chNmCR8undxv5dP4aDpeE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=baONrghxtqhMihU5SUlCcIJ0wuKFpqldKlqHZExB6BRHrWsGab2Gg4V7NWwr8eojio+IclYAN/NLNUduzrvza3Wg9hT+1UMoZv7fVeKp/aCJFZxE5hsr+xpgmkgoqR6PfXmutY18gN+auXQo6F9E66ccBm8pDlxwHVtKVfXv49Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XH0hi3Gm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C571F000E9;
	Fri, 12 Jun 2026 22:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781303818;
	bh=KNrgf1ZEwU4rqdtMrzqRZqBtfabpkEyzCcce3f9KUPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XH0hi3GmfGrs5QVuAzmqNHuXEgFGLBxYXhxo8O6541ac2x+AZwhS9jdcv6kZ7BCRz
	 mwlzo6xvSCts3r7vdeSsI1VuJYRgfwMn0E/JrVcz6gxwB+9qA27zglsNZLWdLqvo3W
	 aHSfqAXbRPnlhC7ZOWqrO0S20kd87sW+iGhBETf/tusnDce+lid2C2jH0X/LGhJ7nF
	 4wEhC5FYFeKLGHEe8suHxVl3vZCncnmkbvbpb3/1guPjTIOb1s09iNxo0U68RAc6by
	 JreIuCYHc/2r0nASV5jkcmYFfItaW86EKtIj0+YSMiTXOnUTWUsY0snWvTKVVU/7oa
	 UKTvu4lHZWLOA==
Date: Fri, 12 Jun 2026 15:36:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cedric Jehasse via B4 Relay
 <devnull+cedric.jehasse.luminex.be@kernel.org>
Cc: cedric.jehasse@luminex.be, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Luke Howard
 <lukeh@padl.com>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Cedric
 Jehasse <cedric.jehasse@gmail.com>
Subject: Re: [PATCH net-next v7 2/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
Message-ID: <20260612153656.4c5b8c62@kernel.org>
In-Reply-To: <20260609-net-next-mv88e6xxx-cbs-v7-2-7d5d732df545@luminex.be>
References: <20260609-net-next-mv88e6xxx-cbs-v7-0-7d5d732df545@luminex.be>
	<20260609-net-next-mv88e6xxx-cbs-v7-2-7d5d732df545@luminex.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298804-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:devnull+cedric.jehasse.luminex.be@kernel.org,m:cedric.jehasse@luminex.be,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:kabel@kernel.org,m:cedric.jehasse@gmail.com,m:devnull@kernel.org,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[luminex.be,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,armlinux.org.uk,vger.kernel.org,padl.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,cedric.jehasse.luminex.be];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,luminex.be:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A75AE67CC77

On Tue, 09 Jun 2026 14:10:51 +0200 Cedric Jehasse via B4 Relay wrote:
> From: Cedric Jehasse <cedric.jehasse@luminex.be>
> 
> Some of the chips supported by this driver have credit based shaper
> support. Support is added for the 6341, 6352, 6390 and 6393 families.
> This is configured using the Qav registers in the AVB register block.
> There are small differences in the Qav registers between the chip
> families (eg. the unit used for the rate and number of bits in the
> registers). mv88e6xxx_qav_info is introduced to configure this per chip.
> 
> Eg. setting up 20mbps credit based shaper on a 1GBit link:
> tc qdisc add dev p8 parent root handle 100: mqprio \
>                 num_tc 8 \
>                 map 0 0 6 7 0 5 0 0 0 0 0 0 0 0 0 0 \
>                 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 \
>                 hw 0
> 
> tc qdisc replace dev p8 parent 100:8 cbs locredit -1470 hicredit 30 \
>     sendslope -980000 idleslope 20000 offload 1

Are DSA ports multi-queue? I would have expected a DSA driver to
offload PRIO not MQPRIO.

I seem to recall other discussion on the ML on the topic.
It'd be great to get some review tags from folks familiar with 
the device.

> Note: only idleslope and hicredit can be programmed in the switch
> registers, other parameters won't affect settings.

> +static int mv88e6xxx_setup_tc_cbs(struct dsa_switch *ds, int port,
> +				  struct tc_cbs_qopt_offload *cbs)

please stick an extack into struct tc_cbs_qopt_offload and use it to
report the reason for rejection back to the user

> +{
> +	const struct mv88e6xxx_avb_ops *avb_ops;
> +	struct mv88e6xxx_chip *chip = ds->priv;
> +	const struct mv88e6xxx_qav_info *qav;
> +	const struct mv88e6xxx_ops *ops;
> +	int hilimit_reg;
> +	int rate_reg;
> +	u8 queue_bit;
> +	u32 rate = 0;
> +	u16 hilimit;
> +	int err;
> +
> +	ops = chip->info->ops;
> +	avb_ops = ops->avb_ops;
> +	qav = chip->info->qav;
> +
> +	if (!qav || !avb_ops || !avb_ops->port_qav_write ||
> +	    !ops->port_set_scheduling_mode)
> +		return -EOPNOTSUPP;
> +
> +	if (!dsa_is_user_port(ds, port))
> +		return -EOPNOTSUPP;
> +
> +	if (!(qav->queue_mask & BIT(cbs->queue)))
> +		return -EOPNOTSUPP;
> +
> +	queue_bit = BIT(cbs->queue);
> +	rate_reg = MV88E6XXX_PORT_QAV_CFG_RATE(cbs->queue);
> +	hilimit_reg = MV88E6XXX_PORT_QAV_CFG_HILIMIT(cbs->queue);
> +
> +	if (cbs->enable) {
> +		if (cbs->hicredit <= 0 ||
> +		    cbs->hicredit > qav->hilimit_mask)
> +			return -ERANGE;
> +
> +		rate = DIV_ROUND_UP(cbs->idleslope, qav->rate_unit);
> +		if (rate > qav->rate_mask)
> +			return -ERANGE;
> +		/* avoid using zero rate */
> +		rate = max_t(u16, rate, 1);
> +	}
> +
> +	mv88e6xxx_reg_lock(chip);
> +
> +	if (!cbs->enable) {
> +		err = mv88e6xxx_port_qav_write(chip, port, rate_reg, 0);
> +		if (err)
> +			goto unlock;
> +
> +		if (!(chip->ports[port].cbs_active_queues & ~queue_bit)) {
> +			err = mv88e6xxx_port_set_scheduling_mode(chip, port, 0);
> +			if (err)
> +				goto unlock;
> +		}
> +		chip->ports[port].cbs_active_queues &= ~queue_bit;
> +		goto unlock;
> +	}
> +
> +	hilimit = cbs->hicredit & qav->hilimit_mask;
> +	err = mv88e6xxx_port_qav_write(chip, port, hilimit_reg, hilimit);
> +	if (err)
> +		goto unlock;
> +
> +	err = mv88e6xxx_port_qav_write(chip, port, rate_reg, rate);
> +	if (err)
> +		goto unlock;
> +
> +	if (!chip->ports[port].cbs_active_queues) {
> +		u8 sched_mode = chip->info->num_tx_queues - 1;
> +
> +		err = mv88e6xxx_port_set_scheduling_mode(chip, port,
> +							 sched_mode);
> +		if (err) {
> +			mv88e6xxx_port_qav_write(chip, port, rate_reg, 0);
> +			goto unlock;
> +		}
> +	}
> +	chip->ports[port].cbs_active_queues |= queue_bit;
> +
> +unlock:
> +	mv88e6xxx_reg_unlock(chip);
> +
> +	return err;
> +}

> +int mv88e6390_port_set_scheduling_mode(struct mv88e6xxx_chip *chip, int port,
> +				       u8 mode)
> +{
> +	u16 reg;
> +	int err;
> +
> +	if (mode > MV88E6390_PORT_QUEUE_CTL_SCHEDULE_MASK)
> +		return -EINVAL;
> +
> +	reg = MV88E6390_PORT_QUEUE_CTL_UPDATE |
> +	      (MV88E6390_PORT_QUEUE_CTL_SCHEDULE <<
> +	       MV88E6390_PORT_QUEUE_CTL_PTR_SHIFT) |
> +	      (mode & MV88E6390_PORT_QUEUE_CTL_SCHEDULE_MASK);
> +
> +	err = mv88e6xxx_port_write(chip, port, MV88E6390_PORT_QUEUE_CTL,
> +				   reg);
> +	if (err)
> +		return err;
> +
> +	return mv88e6xxx_port_wait_bit(chip, port, MV88E6390_PORT_QUEUE_CTL,
> +				       __bf_shf(MV88E6390_PORT_QUEUE_CTL_UPDATE)
> +				       , 0);

odd placement of the comma
-- 
pw-bot: cr

