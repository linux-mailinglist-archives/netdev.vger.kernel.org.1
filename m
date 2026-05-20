Return-Path: <netdev+bounces-289693-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA2QJ04RDWoOtAUAu9opvQ
	(envelope-from <netdev+bounces-289693-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:41:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEDD5869A5
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1DE83019B8E
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 01:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013352DE6E6;
	Wed, 20 May 2026 01:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDHyXsqE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA24A25F7A9;
	Wed, 20 May 2026 01:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779241277; cv=none; b=JnkDzbDJQMLWs8OTKhiNo13CgXqpNUn1optAYEcYZCh7UXAc3n6bsPYgMEy7iIxzUsiO7bPSSTC2vcx/gNC3NyGgVXIzPSmewQ827LR8ni/eM4yky5GO9/BsgYtu40og6+YLgcAYj0WjMOm6h1t82yPyyF+oyR8FNU1TMnpA9z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779241277; c=relaxed/simple;
	bh=QSISJm3wisD21ZC3XMsoWmnCg0KeSsHuERBM0fHvDYo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MViZgYfionmZMYMzwWeCn3hhJrLSt8myIl0MNBMNZZsQakUTbWc7SP/TcJiu4bEPD50rm0zpL9Mf1XS3GaCs7RZtxFfTkry8vt+zG3nIJNnbCH4a1U/Ojnny9S817pMWuCfoRCWI4gzXoo1UwxUAwOsOnG4TOxsxHangrlss5m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDHyXsqE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B0C1F000E9;
	Wed, 20 May 2026 01:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779241276;
	bh=W5B9RYtaf+LTErBNmxuOUqPeLuU8hcx+7feOZbc9ko0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EDHyXsqEu+NbpUnUgYvDrz5WaJIidwbGZVhYlZfDCyM8THfM7IOyJaPl8uOnokna+
	 nf8RtZCS6P9KAylcRtglgS8wEaXJMzlc7U95m1ZoImDMWvpUVeRt0hW2XqosCvYkzR
	 GsimQOhT1ZJQE22cR5HzxfWDRS+ozC/LEyymesMM8Q9XcD6LQoPtPPGyCOaDMCwgBi
	 EBz/end7y9QOEiQBydH61He5NEQBK7BrvpDPzORKZgP/XbJSv1/ZqePIzQpR2glpDM
	 aDEl03SJZJPjBzqXYNtxGGiZb3k7jcKU0KpiinkiRSj8l5twov9eAQzWB7zzdGT7wY
	 CsKXjoaAQbTcA==
Date: Tue, 19 May 2026 18:41:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Thompson <davthompson@nvidia.com>
Cc: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: lan743x: avoid netdev-based logging before
 netdev registration
Message-ID: <20260519184115.3c70f2ac@kernel.org>
In-Reply-To: <20260515215229.3881949-1-davthompson@nvidia.com>
References: <20260515215229.3881949-1-davthompson@nvidia.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289693-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EDEDD5869A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 15 May 2026 21:52:29 +0000 David Thompson wrote:
> This patch updates the lan743x driver to prevent the use of netdev-based
> logging APIs (such as netdev_dbg) before the network device has been
> successfully registered. Using netdev-based logging prior to registration
> results in log messages referencing "(unnamed net_device) (uninitialized)",
> which can be confusing and less informative.
> 
> The driver must use netif_msg_x APIs and device-based logging (e.g. dev_dbg)
> until netdev registration is complete. This ensures log entries are
> associated with the correct device context and improves log clarity. After
> registration, netdev-based logging APIs can be used safely.
> 
> Fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x driver")

Not a fix

> Signed-off-by: David Thompson <davthompson@nvidia.com>
> ---
>  drivers/net/ethernet/microchip/lan743x_main.c | 72 ++++++++++++-------
>  1 file changed, 45 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index f3332417162e..53492573f08d 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -108,9 +108,10 @@ static int lan743x_pci_init(struct lan743x_adapter *adapter,
>  	if (ret)
>  		goto return_error;
>  
> -	netif_info(adapter, probe, adapter->netdev,
> -		   "PCI: Vendor ID = 0x%04X, Device ID = 0x%04X\n",
> -		   pdev->vendor, pdev->device);
> +	if (netif_msg_probe(adapter))

please drop these checks. They are always true.
And the message categorization is not encouraged.
-- 
pw-bot: cr

