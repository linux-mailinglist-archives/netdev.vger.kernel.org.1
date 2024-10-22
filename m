Return-Path: <netdev+bounces-137782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5649A9CB2
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 10:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E04EB20EFF
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 08:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17023154C12;
	Tue, 22 Oct 2024 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="t5cQM9Yo"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330B727735;
	Tue, 22 Oct 2024 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585975; cv=none; b=J78uSYXZZqQK/GXIWV6FmLZooFltSYala80ddCB78BdIbmHNvlUg6K2f88SFsjN7CBiA6WEvRc6Q4KxKdGxY1o2HUXR2m1mM/DK4ylVuXEbUOaOdQzOC8wxaFddTAHuQpqtutTHCSluyOQm3pt3b4s6V3HWvP61qeVugkTvQQto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585975; c=relaxed/simple;
	bh=TVV7dhz9ofTn9WbVA2ODRCGehrbEseuGgv5/djMQOFc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnTyfAerKquXtqPAkvxJaK5myLq8B4e364byHrtS+wbsTvsmh9NLdpXffHlU4dKXKqdDJefzJuagVY31IJWzIs8UU1PyqSf4mRg8dKrEp+GDhOZdOSv8uJHM0MYTe2TKl9kVd4EMBKT/qsEud8rHuTWn3LsT5M6dXtqFEJxu3VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=t5cQM9Yo; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729585973; x=1761121973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TVV7dhz9ofTn9WbVA2ODRCGehrbEseuGgv5/djMQOFc=;
  b=t5cQM9YosvX8qmy0SMeejFsciJzaryyM258sTv35WbcCNh3d/esEFhm6
   AO2bL8C18JgMITc7lymB/xoGs4rMM5hRNqP/j1OgVg8K4a3KgR1vMyUh7
   2eOawgClvrmDiVfk0HCzeskEvke3ZscaFx/Si1JPtQWi+aUZZ+y6JuwUB
   tM1dqNzZ5fvlT5mnWkQyk+xnq62kTRLmGZwlbRbGQAWcqq+KBYIkSVMMb
   VLwbbS4dbJwjLRLI5BtWjdu2dXCbEx1R0hrad5fTu38QbrB1tHDG8m/A/
   A17xfi8hGQQpQ7CCyz4zgRywuQLwk7cVf68+0LkCnXySStwDhh3RmElE+
   g==;
X-CSE-ConnectionGUID: kD08ElzXShqXZdCb41rnmQ==
X-CSE-MsgGUID: w3cxbr4nTKustGYwDVs4VA==
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="200747054"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2024 01:32:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 22 Oct 2024 01:32:16 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 22 Oct 2024 01:32:12 -0700
Date: Tue, 22 Oct 2024 08:32:12 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <andrew@lunn.ch>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
	<ast@fiberby.net>, <maxime.chevallier@bootlin.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next 14/15] net: sparx5: add compatible strings for
 lan969x and verify the target
Message-ID: <20241022083212.mvugftw2xpoynje2@DEN-DL-M70577>
References: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
 <20241021-sparx5-lan969x-switch-driver-2-v1-14-c8c49ef21e0f@microchip.com>
 <dj6vmcezdfrrhdofhzt4gs42pzqyd5fntdy66z76oajxvc44p4@k7fd7dhtwqos>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dj6vmcezdfrrhdofhzt4gs42pzqyd5fntdy66z76oajxvc44p4@k7fd7dhtwqos>

Hi Krzysztof,

> On Mon, Oct 21, 2024 at 03:58:51PM +0200, Daniel Machon wrote:
> > @@ -227,6 +229,168 @@ bool is_sparx5(struct sparx5 *sparx5)
> >       }
> >  }
> >
> > +/* Set the devicetree target based on the compatible string */
> > +static int sparx5_set_target_dt(struct sparx5 *sparx5)
> > +{
> > +     struct device_node *node = sparx5->pdev->dev.of_node;
> > +
> > +     if (is_sparx5(sparx5))
> > +             /* For Sparx5 the devicetree target is always the chip target */
> > +             sparx5->target_dt = sparx5->target_ct;
> > +     else if (of_device_is_compatible(node, "microchip,lan9691-switch"))
> > +             sparx5->target_dt = SPX5_TARGET_CT_LAN9691VAO;
> > +     else if (of_device_is_compatible(node, "microchip,lan9692-switch"))
> > +             sparx5->target_dt = SPX5_TARGET_CT_LAN9692VAO;
> > +     else if (of_device_is_compatible(node, "microchip,lan9693-switch"))
> > +             sparx5->target_dt = SPX5_TARGET_CT_LAN9693VAO;
> > +     else if (of_device_is_compatible(node, "microchip,lan9694-switch"))
> > +             sparx5->target_dt = SPX5_TARGET_CT_LAN9694;
> > +     else if (of_device_is_compatible(node, "microchip,lan9695-switch"))
> > +             sparx5->target_dt = SPX5_TARGET_CT_LAN9694TSN;
> > +     else if (of_device_is_compatible(node, "microchip,lan9696-switch"))
> > +             sparx5->target_dt = SPX5_TARGET_CT_LAN9696;
> > +     else if (of_device_is_compatible(node, "microchip,lan9697-switch"))
> > +             sparx5->target_dt = SPX5_TARGET_CT_LAN9696TSN;
> > +     else if (of_device_is_compatible(node, "microchip,lan9698-switch"))
> > +             sparx5->target_dt = SPX5_TARGET_CT_LAN9698;
> > +     else if (of_device_is_compatible(node, "microchip,lan9699-switch"))
> > +             sparx5->target_dt = SPX5_TARGET_CT_LAN9698TSN;
> > +     else if (of_device_is_compatible(node, "microchip,lan969a-switch"))
> > +             sparx5->target_dt = SPX5_TARGET_CT_LAN9694RED;
> > +     else if (of_device_is_compatible(node, "microchip,lan969b-switch"))
> > +             sparx5->target_dt = SPX5_TARGET_CT_LAN9696RED;
> > +     else if (of_device_is_compatible(node, "microchip,lan969c-switch"))
> > +             sparx5->target_dt = SPX5_TARGET_CT_LAN9698RED;
> 
> Do not re-implement match data.
> 
> >

Thank you for your feedback.

I will get rid of this function and instread create match data structs
for each SKU.

/Daniel


