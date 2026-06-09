Return-Path: <netdev+bounces-297292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9XJAD5uFKGrkFgMAu9opvQ
	(envelope-from <netdev+bounces-297292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:28:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1916643ED
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:28:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AlhLOQPx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297292-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297292-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD18C30E936A
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 21:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A81C41168B;
	Tue,  9 Jun 2026 21:26:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B19748124E
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 21:26:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040403; cv=none; b=f6hM8rFLm4flrV90Lk2ym+fE8bi37OOT6JZBQVNmGH+kBwDfzTyuHoCSKS6MmdmduRG79QarNpRk+lF2JyUd15qP2DlMzk6QcQwso/l9PVB2UQ/dAKENgbrzoD84zdRNG4gxNrFXF/+O8E1xrkgN8c+ySLvyw4f9YeIoBoaOk6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040403; c=relaxed/simple;
	bh=1So86e935Glh56eqlyMowVTl4Y5dmwwTZ3UJ31RJcno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ikpwIpIQpbcakCUTt1lcdvy2z0rx/+JF+COCknHYe9h7i/E6wdzFWu3Ofd2eIC0mIE0mhHIyMaPO+qIroFHrrfWGO9OLVsgsQ5EKWQ8X5rZsIb0R1UdslLB7oubQ9gt6NYfSXntUfPjsNXIN56kaTAlWhLa2YwvvvasMjq+N43A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlhLOQPx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8631F00893;
	Tue,  9 Jun 2026 21:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781040401;
	bh=ZhyaRxrbpS87OsMYKCF7UWJ19PSXMrsCdaZ8xpglsTQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AlhLOQPx240bktU4iPNG5pe54vE+ZSZABpKzwaBKRgGw67udN/EcjBHjgAtPhCnwI
	 muay4Wga81ra2h7z87sqJe98pDFEoumIIj8qeT89/cT74RHNNZXiqpjiRuaqLWNG3W
	 cZ8A+e25d28KtQ/prBTuqWySvrUMP+Ic/oPQhOREZf16CFy2e265SOzCsmAnnkT86Y
	 CRd2+aiUX7NzyNC2UFbp6pEZQGaRx9iveFuhBzhUomeUVkXogLKInDlwH5BFOR/DfA
	 8Y4oHs0dD/TpQsOfPYoIYvXGE89Ujyr8qbyjZe1FMnjGKRWTrEHdYDbvW1/5+EvVeV
	 MY76dEOk7ZkfQ==
Date: Tue, 9 Jun 2026 14:26:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Joyner <eric.joyner@amd.com>
Cc: netdev@vger.kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next v3 2/5] ionic: Get "link_down_count" ext link
 stat from firmware
Message-ID: <20260609142640.261b7d87@kernel.org>
In-Reply-To: <f2d17ae9-ec9f-46db-b46a-a2bb680c3460@amd.com>
References: <20260512224421.25236-3-eric.joyner@amd.com>
	<20260515012747.1292575-1-kuba@kernel.org>
	<f2d17ae9-ec9f-46db-b46a-a2bb680c3460@amd.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297292-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:eric.joyner@amd.com,m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF1916643ED

On Tue, 9 Jun 2026 11:00:03 -0700 Eric Joyner wrote:
> On 5/14/2026 6:27 PM, Jakub Kicinski wrote:
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.  
> 
> Man, it's been forever since I've been able to get back to this.
> 
> > ---
> > [Low]
> > Should this NULL check sit inside the is_physfn branch below? The
> > port_info pointer is only dereferenced on the PF path, so a VF calling
> > ethtool on link ext stats will now log a netdev_err even though the VF
> > path never reads port_info.  
> 
> Sure.
> 
> > 
> > The message is also unrate-limited and reachable from userspace via
> > ethtool. port_info is freed and set to NULL in ionic_port_reset() and
> > reallocated in ionic_port_init() on FW reset / FLR / PCI error recovery
> > paths (ionic_reset_prepare()/ionic_reset_done() in ionic_bus_pci.c, and
> > ionic_restart_lif() in ionic_lif.c), so any ethtool query during that
> > transient window will emit a kernel log line where the previous code
> > silently did nothing.
> >   
> >>
> >> -     if (lif->ionic->pdev->is_physfn)
> >> -             stats->link_down_events = lif->link_down_count;
> >> +     if (ionic->pdev->is_physfn)
> >> +             stats->link_down_events =
> >> +                 le16_to_cpu(ionic->idev.port_info->status.link_down_count);
> >>  }  
> 
> I can use netdev_err_once() here, instead? There's no "netdev_err_ratelimited()"
> like how there is for struct device and "dev_err_ratelimited()", interestingly.
> Would that be more appropriate in the future?
> 
> There's also a similar issue in ionic_get_link_ksettings() below (and maybe
> elsewhere?), but that can be fixed in a separate patch.

This is a nit, up to you.

> > [Medium]
> > The firmware-supplied link_down_count is a __le16 in struct
> > ionic_port_status (ionic_if.h), so the value saturates at 65,535. The
> > previous lif->link_down_count was an unsigned int (32-bit), and the
> > ethtool field stats->link_down_events is u64 and treated as monotonic
> > by userspace consumers (per the comment on struct
> > ethtool_link_ext_stats in include/linux/ethtool.h).
> > 
> > Without driver-side rollover detection that accumulates the carry into
> > a wider counter, after 65,536 link bounces the reported value will
> > appear to go backward to a small number. Should the driver detect a
> > firmware value smaller than the previously-read value and fold the
> > delta into a 32/64-bit running tally before assigning to
> > stats->link_down_events?  
> 
> Is this a big enough issue to deal with? Is link really going to go down
> sixty-five thousand times while the driver is loaded? I guess we could have a
> running tally, but that seems like more effort than this is worth.

Seems unlikely indeed, but drivers routinely deal with such wrapping.
It's like 5 lines of code, no?

	u16 val = le16_to_cpu(...

        if ((u16)stats->link_down_events > val)
               stats->link_down_events += BIT(16);
        stats->link_down_events &= 0xffff0000;
	stats->link_down_events |= val;

> > [Medium]
> > Does this change make link_down_events non-persistent across firmware
> > resets? port_info lives in DMA-coherent memory that
> > ionic_port_reset() frees and clears:
> > 
> > drivers/net/ethernet/pensando/ionic/ionic_main.c:ionic_port_reset() {
> >     ...
> >     dma_free_coherent(...);
> >     idev->port_info = NULL;
> >     ...
> > }
> > 
> > and ionic_port_init() reallocates a fresh zeroed page. These are
> > called from the FLR / PCI error recovery path
> > (ionic_reset_prepare()/ionic_reset_done() in ionic_bus_pci.c) and from
> > ionic_restart_lif() in ionic_lif.c, so FW-reset events that previously
> > left the driver-resident counter untouched will now zero this stat.
> > 
> > The commit message does not mention this behavioral change. Should the
> > driver snapshot the firmware value before each reset and accumulate it
> > across reset boundaries to keep the ethtool counter monotonic?  
> 
> This count doesn't get reset in the firmware when the device the ionic driver
> binds to gets reset; the freshly zeroed page will get the count from the
> firmware again soon after the reset occurs.

This is also not great, operationally. Monitoring systems may expect
counters to start from 0 after boot (IIUC you're saying that unless
the card goes thru a full reset we'll keep the value from previous
boot).


