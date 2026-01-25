Return-Path: <netdev+bounces-253217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bzUOIniNdmnKRwEAu9opvQ
	(envelope-from <netdev+bounces-253217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:39:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B209E82850
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CBAB3004638
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 21:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C9A30101F;
	Sun, 25 Jan 2026 21:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhx1HxlV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618CC3FCC;
	Sun, 25 Jan 2026 21:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769377140; cv=none; b=Z2k24Dt7V12WRXsOwZMcqko+YaRH24g0Yrzs+QuXKPJ02Am5D26BhF3weSp/ehbkcNcNIcKIVJXIn0Hwu/UX4nZzhthqgmkTabfwiet8eYHMM37YNFegfdBRFKK526/w/+dCPT+nBQEghM6nx1QTlyk9kmitBp6IiNXw8cfeFVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769377140; c=relaxed/simple;
	bh=+TBgWoKFvievuBS2rkd3TCzs1tI8SPQGl3I+SFbEdEc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XIme8BQeC0yz/DGtysjX3RqYAaElDNB3+LJK4hetEDRClyjHB1VLW8p2k9+s9e29PkzOgOpG9vkL1nLAn2GceB/gp57EDYzd3AHPSftchDgMSkTm94wzY2AkFQkAYW8fSqiMa+6ocatI9WlVsB4AHnYD2k55kNnzBOcsjuh67Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhx1HxlV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510A4C4CEF1;
	Sun, 25 Jan 2026 21:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769377139;
	bh=+TBgWoKFvievuBS2rkd3TCzs1tI8SPQGl3I+SFbEdEc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lhx1HxlVTqt3E1LRGVxc2JGVaUVl8dFGglTdobhNXqlS+2ZShD5SfB+iVsmjo3OWT
	 D4tgcpF8ximCPkfZ3sU0mkWHcEt8GWcN1In/n/PHZD30tnFXsvHEE+m7DwhqAgldbh
	 ok4AibXIKcvD9BFUX+l2TkGpKsFzWtIKGxbyxwE/NCH9736cBU4dbLbCA3sDppE9RU
	 pce8PmLgvh3CC7rtlv4qRWnwhf5lWgJ6ubFZ2tD9A1nvruah9zLKO5awwz2/vjaXMA
	 TMezBLlB0LQKsUT40B+4YtvQ3RAgza0K14D0KLa4lvnMN6w7ND/rhOzKkEox9fp5Vu
	 Qw5Oy9Z6+jFVw==
Date: Sun, 25 Jan 2026 13:38:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Simon Horman <horms@kernel.org>, Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?B?TWlxdcOobA==?= Raynal <miquel.raynal@bootlin.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/8] net: dsa: microchip: Add support for
 KSZ8463's PTP interrupts
Message-ID: <20260125133858.5fdb7532@kernel.org>
In-Reply-To: <20260122-ksz8463-ptp-v2-4-b6683f5ce50b@bootlin.com>
References: <20260122-ksz8463-ptp-v2-0-b6683f5ce50b@bootlin.com>
	<20260122-ksz8463-ptp-v2-4-b6683f5ce50b@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253217-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,se.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B209E82850
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 14:27:38 +0100 Bastien Curutchet (Schneider
Electric) wrote:
> +int ksz8463_ptp_irq_setup(struct dsa_switch *ds)
> +{
> +	struct ksz_device *dev = ds->priv;
> +	const struct ksz_dev_ops *ops = dev->dev_ops;
> +	struct ksz_port *port1, *port2;
> +	struct ksz_irq *ptpirq;
> +	int ret;
> +	int p;
> +
> +	port1 = &dev->ports[0];
> +	port2 = &dev->ports[1];
> +	ptpirq = &port1->ptpirq;
> +
> +	ptpirq->irq_num = irq_find_mapping(dev->girq.domain, KSZ8463_SRC_PTP_INT);
> +	if (!ptpirq->irq_num)
> +		return -EINVAL;
> +
> +	ptpirq->dev = dev;
> +	ptpirq->nirqs = 4;
> +	ptpirq->reg_mask = ops->get_port_addr(p, KSZ8463_PTP_TS_IER);
> +	ptpirq->reg_status = ops->get_port_addr(p, KSZ8463_PTP_TS_ISR);

clang says:

drivers/net/dsa/microchip/ksz_ptp.c:1187:40: warning: variable 'p' is uninitialized when used here [-Wuninitialized]
 1187 |         ptpirq->reg_mask = ops->get_port_addr(p, KSZ8463_PTP_TS_IER);
      |                                               ^
drivers/net/dsa/microchip/ksz_ptp.c:1175:7: note: initialize the variable 'p' to silence this warning
 1175 |         int p;
      |              ^
      |               = 0
-- 
pw-bot: cr

