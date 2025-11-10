Return-Path: <netdev+bounces-237107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 080A0C45243
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 07:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B0EB7346A06
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 06:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB572E8B95;
	Mon, 10 Nov 2025 06:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="w5+Nuj4K"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5D214A60C;
	Mon, 10 Nov 2025 06:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757853; cv=none; b=JVMNroyXNvgLpNTU+/KAfkxFEE+NmOgHVPkM8ZjDcQ2ttV+/g4BPwnSo9zYS8FJEMF9uTtxhGsz0OBz6kV/5QyIKd1HNhGChPDkYQeX7UHQtnm4MDjFeSiWcebJM6Eg06UdpUaYgYoC68foO8nraxYk18vfJM5JFcmE2cdnFEG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757853; c=relaxed/simple;
	bh=1SqMrYP18FymGyJURtzA5MuI3ISTgbkmBySUQpZDmRQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLyfflgJtb3sPa8iRTr7hKUzgo6lOmiL3CVlQxDMYWiMg0t6Gs5p/2hh0P+0ynk6ULTL/OQhYYv8WBzvWIy4R9fahYhzXWsRZgGw30z6B8xmMWuVQISssGtSUMq0Y5IpfMJlmBpMeTR6Zy9xJBW9BrtYuklY79PEcZphd08A+Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=w5+Nuj4K; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762757851; x=1794293851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1SqMrYP18FymGyJURtzA5MuI3ISTgbkmBySUQpZDmRQ=;
  b=w5+Nuj4KK/PMF1MciO1pKXqTh6VUaTzKEfnaj4KUPg0DR843Uxo6KZ0u
   Bz1jBgYLKTBGRgVC6NjIsqwoyp416JQ+YDHckTj122M66jmxdZZYE9nPu
   0aOkU3Roy4ganSSF04lnkzyx7JONkxPrg3IOgdXsiNxpZotOCIwgY+aZ8
   3v5xL0MYYcE+RKqVbpWrjIUOnLF5gt+lRnPATxWMEtPBCmNpRVsu+LVbi
   vfW5pKatqsbQ67QfQGaOOBCZ4SBZ+X9E1iAqQNbfjGys36cV5TylDBrZn
   7bnGchHU03ugEFJm7Q3tBd9zwWyViREGW1D/avpXDqBIga5GDz71AwSYj
   Q==;
X-CSE-ConnectionGUID: BYri1NdbQKqXZYAxeGkImg==
X-CSE-MsgGUID: D3jqOOT7QGi+yvk96naJ9Q==
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="216235639"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 23:57:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Sun, 9 Nov 2025 23:57:04 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Sun, 9 Nov 2025 23:57:01 -0700
Date: Mon, 10 Nov 2025 06:57:01 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Robert Marko <robert.marko@sartura.hr>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<luka.perkov@sartura.hr>
Subject: Re: [PATCH net-next] net: sparx5/lan969x: populate netdev of_node
Message-ID: <20251110065701.rch4wjflap3vicjq@DEN-DL-M70577>
References: <20251107141936.1085679-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251107141936.1085679-1-robert.marko@sartura.hr>

Hi Robert,

> Populate of_node for the port netdevs, to make the individual ports
> of_nodes available in sysfs.

Sounds reasonable :-)

> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
> index 1d34af78166a..284596f1da04 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
> @@ -300,7 +300,11 @@ int sparx5_register_netdevs(struct sparx5 *sparx5)
> 
>         for (portno = 0; portno < sparx5->data->consts->n_ports; portno++)
>                 if (sparx5->ports[portno]) {
> -                       err = register_netdev(sparx5->ports[portno]->ndev);
> +                       struct net_device *port_ndev = sparx5->ports[portno]->ndev;

This line exceeds 80 chars and can easily be wrapped.

> +
> +                       port_ndev->dev.of_node = sparx5->ports[portno]->of_node;
> +
> +                       err = register_netdev(port_ndev);
>                         if (err) {
>                                 dev_err(sparx5->dev,
>                                         "port: %02u: netdev registration failed\n",
> --
> 2.51.1
> 

It seems wrong to me to stuff this into sparx5_register_netdevs() - there are
two better candidates, either: sparx5_create_netdev (where other ndev variables
are assigned) or sparx5_create_port().

/Daniel

