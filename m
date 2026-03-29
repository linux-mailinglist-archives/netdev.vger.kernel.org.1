Return-Path: <netdev+bounces-272955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KG1cO4NkyWlXxwUAu9opvQ
	(envelope-from <netdev+bounces-272955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:42:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF0535366C
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B598B3002B15
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 17:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0EE376496;
	Sun, 29 Mar 2026 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1jBwiTR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D8A33F595
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774806145; cv=none; b=mcqdGthJw1xMWCyDBm7gQTgAhoWxjgx2Z9wgUcNO/kffr5U8WZJ8yLJjwV/V29TGSteyMDZZndy5oVj8VXBIReEHqe0MUzNXvcmxWMiB3z08CqJCKh5FYc2cFcdP20gr6dgVSRMNe7hZeEbi89wqTTcD8W4IjNDO/YY7iRYVyAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774806145; c=relaxed/simple;
	bh=Dgjm5JDJVPVi105xPjT0M4xjKqbcapeMVq6MJrJMHiM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d5BSadXbZM/uNk/EV5LefQAcRtk9mfQ5yTNcxVU/16saQgXk7kOExcFZwhyQ5WtJpch+Of+/HW2ab5IO/adLtSX6cJ3YEacZlesZihAkmkPFnHfKD6akw5g6w1OHJIrwm2VieAWb/3KSmElN3tMTcPwxfPWXQgGNMt6/dCdAWU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1jBwiTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8E1C116C6;
	Sun, 29 Mar 2026 17:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774806145;
	bh=Dgjm5JDJVPVi105xPjT0M4xjKqbcapeMVq6MJrJMHiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K1jBwiTRDPR5JvC58W6u26L8/DtzjfHPUvIDFhoueqTs8Yyh8imbx+gyg0AEbJ/C0
	 E/P0YqYGro7/VjB/9vvmPxzj73HJ4eBS1VwSEaZhQms+WwMizCdiV66lfek0iR+XlR
	 5NYPjEn7exjhGjtri4rs0Qw5sqU9W1VtBOsvxmJGAlzVMVcHt/vdg3iMHgMk/Mu7i0
	 JQlYlUt+FkmspPZR98PWwk1stUEgEOpZBI8PMzOWegLeUSUp8hly7TiljKmUZE3ftQ
	 QXAio38VTVRmvs8A4BEgGzp86HFnRZCx//Kcbr6dkoDVJ3E+xD5Vhk3Y+qWRz05zRX
	 wZwT7h1mgwS0Q==
Date: Sun, 29 Mar 2026 10:42:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org, Ong Boon
 Leong <boon.leong.ong@intel.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 01/10] net: stmmac: fix TSO support when some
 channels have TBS available
Message-ID: <20260329104223.358351ee@kernel.org>
In-Reply-To: <acjzmxY9xmBInSwm@shell.armlinux.org.uk>
References: <achJ1dfeT6Q8rBuX@shell.armlinux.org.uk>
	<E1w6bKj-0000000ELtf-3md9@rmk-PC.armlinux.org.uk>
	<acjzmxY9xmBInSwm@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272955-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7DF0535366C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 29 Mar 2026 10:40:43 +0100 Russell King (Oracle) wrote:
> On Sat, Mar 28, 2026 at 09:36:41PM +0000, Russell King (Oracle) wrote:
> > According to the STM32MP25xx manual, which is dwmac v5.3, TBS (time
> > based scheduling) is not permitted for channels which have hardware
> > TSO enabled. Intel's commit 5e6038b88a57 ("net: stmmac: fix TSO and
> > TBS feature enabling during driver open") concurs with this, but it
> > is incomplete.
> > 
> > This commit avoids enabling TSO support on the channels which have
> > TBS available, which, as far as the hardware is concerned, means we
> > do not set the TSE bit in the DMA channel's transmit control register.
> > 
> > However, the net device's features apply to all queues(channels), which
> > means these channels may still be handed TSO skbs to transmit, and the
> > driver will pass them to stmmac_tso_xmit(). This will generate the
> > descriptors for TSO, even though the channel has the TSE bit clear.
> > 
> > Fix this by checking whether the queue(channel) has TBS available,
> > and if it does, fall back to software GSO support.  
> 
> This is sufficient for the immediate issue of fixing the patch below,
> but I think there's another issue that also needs fixing here.
> 
> TSO requires the hardware to support checksum offload, and there is
> a comment in the driver:
> 
>         /* DWMAC IPs can be synthesized to support tx coe only for a few tx
>          * queues. In that case, checksum offloading for those queues that don't
>          * support tx coe needs to fallback to software checksum calculation.
>          *
>          * Packets that won't trigger the COE e.g. most DSA-tagged packets will
>          * also have to be checksummed in software.
>          */
> 
> So, it seems at the very least we need to add a check (in a subsequent
> patch) for priv->plat->tx_queues_cfg[queue].coe_unsupported to
> stmmac_channel_tso_permitted().
> 
> I'm also wondering about the stmmac_has_ip_ethertype() thing, which
> checks whether the skb can be checksummed by the hardware, and how that
> interacts with TSO, and whether that's yet another hole that needs
> plugging.

If the driver "un-advertises" checksum offload accordingly the core
should automatically clear TSO feature.

