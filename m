Return-Path: <netdev+bounces-257402-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kG00BYpRhWmV/wMAu9opvQ
	(envelope-from <netdev+bounces-257402-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:27:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B48E9F94A5
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0FE7530151CE
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 02:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964C5274658;
	Fri,  6 Feb 2026 02:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s89TTDhB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720A1262FD0;
	Fri,  6 Feb 2026 02:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770344809; cv=none; b=doUVGDJll5kaewXmRsranPtmWnCLwv2wKYPuJsC/TULzrXTrTKp7f8UJvpR5giddZKxFq6Um3kotU5Mb4cqmyS20KfW/MuWGxtJXBXY7GmoP+jxk51evWphvIV+G8c55gDkz2DoCjNZIm2r9KMzC4HbunIKWpF8vfK0e99mUFTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770344809; c=relaxed/simple;
	bh=dj7PTtngi3WPe/OEqWfgcV5GcRGd74xlx6UV8jRooE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkj+PAtjnKbo39dk2bv7DF1+v3fAk2GF5eZPEZLSTwqHhXZWuTf7V8ilkj2r9zJuUcLOyHq7QF7LRqKReDRE5CyxmKoXztxu6TPKqP01aJHAKyIICsFaflJ+0L3fwkhPwKe8A7Li/dGf0qvepMoKl3WqAMpCxsSULhm8g21x38U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s89TTDhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1969DC4CEF7;
	Fri,  6 Feb 2026 02:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770344809;
	bh=dj7PTtngi3WPe/OEqWfgcV5GcRGd74xlx6UV8jRooE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s89TTDhBQh3DUhn7lYc3Il5oI0nr308KatTIFDICQzTReclDHwfKifpl/pSIfnT99
	 7AKB/SOA650VekL9CQ1I/TqPyroex8GpG0LHjTNAahpZJpJz7TNrDsz7iVIlocugI7
	 LHEW0K27MyNPIBx3JOzZrUKkbF6moDqs0IfDSX2m11A7ZedBGEng7ebvuxBcdWdZkS
	 gF5SmyrucpMItU5NnjS8Knvin9x/R0M7Qb5D1gcaZOOgHp9Ib/vBi4kppVI5Hg9ffL
	 unmlBsc7iiKNdodIvkMcfQT1VoVu5+zDFfkcjrO3xYb1DmpMN/0jz1dP9itFTO0H2F
	 AxCT7FHyH0XlQ==
From: Jakub Kicinski <kuba@kernel.org>
To: lukasz.majewski@mailbox.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	imx@lists.linux.dev,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org,
	krzk+dt@kernel.org,
	davem@davemloft.net,
	kernel@pengutronix.de,
	devicetree@vger.kernel.org,
	horms@kernel.org,
	festevam@gmail.com,
	andrew@lunn.ch,
	conor+dt@kernel.org,
	pabeni@redhat.com,
	shawnguo@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	wahrenst@gmx.net,
	richardcochran@gmail.com,
	s.hauer@pengutronix.de,
	netdev@vger.kernel.org,
	edumazet@google.com,
	robh@kernel.org
Subject: Re: [net-next,v23,5/7] net: mtip: Add mtip_switch_{rx|tx} functions to the L2 switch driver
Date: Thu,  5 Feb 2026 18:26:45 -0800
Message-ID: <20260206022646.3197202-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204232135.1024665-6-lukasz.majewski@mailbox.org>
References: <20260204232135.1024665-6-lukasz.majewski@mailbox.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,lunn.ch,vger.kernel.org,davemloft.net,pengutronix.de,gmail.com,redhat.com,lists.infradead.org,gmx.net,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-257402-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: B48E9F94A5
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: mtip: Add mtip_switch_{rx|tx} functions to the L2 switch driver

This patch provides mtip_switch_tx and mtip_switch_rx functions code for
MTIP L2 switch.

> diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> index 4c64681602d6..61a624f3df2b 100644
> --- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> +++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> @@ -246,6 +246,39 @@ struct mtip_port_info *mtip_portinfofifo_read(struct switch_enet_private *fep)
>  	return info;
>  }
>
> +static void mtip_atable_get_entry_port_number(struct switch_enet_private *fep,
> +					      unsigned char *mac_addr, u8 *port)
> +{
> +	int block_index, block_index_end, entry;
> +	u32 mac_addr_lo, mac_addr_hi;
> +	u32 read_lo, read_hi;
> +
> +	mac_addr_lo = (u32)((mac_addr[3] << 24) | (mac_addr[2] << 16) |
> +			    (mac_addr[1] << 8) | mac_addr[0]);
> +	mac_addr_hi = (u32)((mac_addr[5] << 8) | (mac_addr[4]));
> +
> +	block_index = GET_BLOCK_PTR(crc8_calc(mac_addr));
> +	block_index_end = block_index + ATABLE_ENTRY_PER_SLOT;
> +
> +	/* now search all the entries in the selected block */
> +	for (entry = block_index; entry < block_index_end; entry++) {
> +		mtip_read_atable(fep, entry, &read_lo, &read_hi);
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Can this create a torn read of the address table entry?

mtip_read_atable() performs two separate readl() operations to read a
64-bit address table entry:

    *read_lo = readl(&atable_base[index].lo);
    *read_hi = readl(&atable_base[index].hi);

If another thread holding fep->learn_lock updates the same entry between
these two reads, the lookup would see an inconsistent state (old low word
with new high word, or vice versa).

Looking at the call chain:

    Thread 1 (no lock):
    mtip_switch_rx()->mtip_atable_get_entry_port_number()->mtip_read_atable()

    Thread 2 (lock held):
    mtip_mgnt_timer()->mtip_atable_dynamicms_learn_migration()->
    mtip_update_atable_dynamic1()->mtip_write_atable()

The race could cause a MAC address lookup to fail or match the wrong entry,
delivering packets to the wrong port.

All other functions that read or write the address table acquire
fep->learn_lock before calling mtip_read_atable() or mtip_write_atable().

Should this function also hold the lock during the lookup loop?

> +		*port = MTIP_PORT_FORWARDING_INIT;
> +
> +		if (read_lo == mac_addr_lo &&
> +		    ((read_hi & 0x0000FFFF) ==
> +		     (mac_addr_hi & 0x0000FFFF))) {
> +			/* found the correct address */
> +			if ((read_hi & (1 << 16)) && (!(read_hi & (1 << 17))))
> +				*port = FIELD_GET(AT_PORT_MASK, read_hi);
> +			break;
> +		}
> +	}
> +
> +	dev_dbg(&fep->pdev->dev, "%s: MAC: %pM PORT: 0x%x\n", __func__,
> +		mac_addr, *port);
> +}

[ ... ]

