Return-Path: <netdev+bounces-255317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHMECzthfWkARwIAu9opvQ
	(envelope-from <netdev+bounces-255317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:56:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B84E4C0263
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93C7B3053B99
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 01:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724E7333725;
	Sat, 31 Jan 2026 01:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6jsBIXW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D630283686;
	Sat, 31 Jan 2026 01:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769824480; cv=none; b=WVmSBo+7eflFT5dHpl7vjnbn0NAY+w0HRNeUtoYAHHnv1EzitJ6/64D4TO6bcVHJdSWQ6Spq9froLUrah1xPavum8Mh+gg0bEn2hirGB2yDU/B28iCOSoXrIbT+MPYZdRhnkrUl54zaGll9i1W7nxhV/uD7Euln/a872HkDl+XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769824480; c=relaxed/simple;
	bh=mwWaS4H/LxHe5XEFQqTOAXnZqbeC9QaLnwYKAnsw5zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=erYG1Hb8Y4OqlTY0vNyGB2QZqi58eKljV4x0foCMkBmUyQbz/hQFFCcjrSVvLjRN+wTMQhU42yRI7LfJEMouO0hA6Ja/aDsYkDyUwDYLz58rgmw6xD3EN+sq7B0pvh/dVDmNClEjvhCHqHxbdS0Els1Dx+1vLLUOlBGdmVQj9ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6jsBIXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307CFC19421;
	Sat, 31 Jan 2026 01:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769824480;
	bh=mwWaS4H/LxHe5XEFQqTOAXnZqbeC9QaLnwYKAnsw5zA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A6jsBIXW6Zwo5I+kZ/SjmoTdAmJhFmdiNiMuU9spwWhbSDAK5BSn6E018EOXF1RKX
	 eLnJOnRCxSd63EKnPdwRYh+q9TXS4HoTLUwcDSYxgfd0WUPNZT6Q1KAfHuG91C7kjp
	 oJbKG79e9JmT3w0ATU6qRap31lvoBppmcOtfWRZY/g3ynv3yEcDdIfqrZIlype8/a7
	 /4AgqSAJiRnReNTQzEOtBAWSU14RFeYus/4f6fkRw+6nbEXCh7+LLxyhpko81LQlhq
	 FWDWLT6Ca0XPk6S5KnT0WlCsCrf4Wh7i7EVtXUixtyIQmG577FAklQ+9w3L9yQWzld
	 gF5wLQSIWRP7A==
From: Jakub Kicinski <kuba@kernel.org>
To: lukasz.majewski@mailbox.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	devicetree@vger.kernel.org,
	horms@kernel.org,
	krzk+dt@kernel.org,
	s.hauer@pengutronix.de,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	richardcochran@gmail.com,
	shawnguo@kernel.org,
	edumazet@google.com,
	linux-arm-kernel@lists.infradead.org,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	wahrenst@gmx.net,
	davem@davemloft.net,
	festevam@gmail.com,
	conor+dt@kernel.org,
	imx@lists.linux.dev,
	andrew@lunn.ch,
	robh@kernel.org
Subject: Re: [net-next,v21,6/7] net: mtip: Extend the L2 switch driver with management operations
Date: Fri, 30 Jan 2026 17:54:37 -0800
Message-ID: <20260131015438.972436-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129110154.1699976-7-lukasz.majewski@mailbox.org>
References: <20260129110154.1699976-7-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255317-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,pengutronix.de,gmail.com,google.com,lists.infradead.org,lunn.ch,redhat.com,gmx.net,davemloft.net,lists.linux.dev];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B84E4C0263
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: mtip: Extend the L2 switch driver with management operations

This patch adds management functions for the L2 switch including VLAN
configuration, port learning/blocking, multicast/broadcast control,
and forced forwarding for port separation.

> diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c

[ ... ]

> +int mtip_vlan_input_process(struct switch_enet_private *fep,
> +			    int port, int mode, unsigned short port_vlanid,
> +			    int vlan_verify_en, int vlan_domain_num,
> +			    int vlan_domain_port)
> +{
> +	/* Only modes from 1 to 4 are valid*/
> +	if (mode < 0 || mode > 4) {
                       ^^^^

The comment says modes 1-4 are valid, but the condition allows mode 0
to pass through. Should the check be "mode < 1" instead, or is the
comment incorrect and mode 0 is actually valid?

> +		dev_err(&fep->pdev->dev,
> +			"%s: VLAN input processing mode (%d) not supported\n",
> +			__func__, mode);
> +		return -EINVAL;
> +	}

[ ... ]

