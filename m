Return-Path: <netdev+bounces-214933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF184B2BFEF
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 13:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8681BC19CC
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 11:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864C1322DB1;
	Tue, 19 Aug 2025 11:11:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A034322DD7;
	Tue, 19 Aug 2025 11:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601905; cv=none; b=FVriPEGGVLx8XT5JstmCefBZJFmZxRF9F58407A8YljWdRuiO7fzS0vJcCmT3wSd59sCgS6rJ4gaFy1w98HF4SNJLWMhkNDxXVc6HPBWM2e5DM5h5kd4cAwbbr/tabbp7Zy7t3RD0+Nq77yHBXfBrPowwoqdQLSJBQCtOzumq/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601905; c=relaxed/simple;
	bh=mpxUDVz18ynBNqabvz14g/eRXszloXEeVdJLwZhxGa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0ErWoAPrk3FZKu1sdB+gX4DCh8+NtP3GQfLXLw14cDkO8qxwoMgHSts4IA2ucKnd1ZJMNygLUTuhTt+dRURTojleLcymiEa+lETeVSzASww/zzSNb883NKLtEsO8soaoih7dYNucv3d7JpCgt+nQyQKNAXzMNI3bdEYw1PMzMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uoKFV-000000002YS-2Tuw;
	Tue, 19 Aug 2025 11:11:29 +0000
Date: Tue, 19 Aug 2025 12:11:25 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v2 3/8] net: dsa: lantiq_gswip: move definitions
 to header
Message-ID: <aKRb3R1l9XLr3DHw@pidgin.makrotopia.org>
References: <cover.1755564606.git.daniel@makrotopia.org>
 <cover.1755564606.git.daniel@makrotopia.org>
 <a6dd825d9e3eefa175a578a43e302b6eaae2b9dd.1755564606.git.daniel@makrotopia.org>
 <a6dd825d9e3eefa175a578a43e302b6eaae2b9dd.1755564606.git.daniel@makrotopia.org>
 <20250819105055.tuig57u66sit2mlu@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819105055.tuig57u66sit2mlu@skbuf>

On Tue, Aug 19, 2025 at 01:50:55PM +0300, Vladimir Oltean wrote:
> On Tue, Aug 19, 2025 at 02:33:02AM +0100, Daniel Golle wrote:
> > +#define GSWIP_TABLE_ACTIVE_VLAN		0x01
> > +#define GSWIP_TABLE_VLAN_MAPPING	0x02
> > +#define GSWIP_TABLE_MAC_BRIDGE		0x0b
> > +#define  GSWIP_TABLE_MAC_BRIDGE_KEY3_FID	GENMASK(5, 0)	/* Filtering identifier */
> > +#define  GSWIP_TABLE_MAC_BRIDGE_VAL0_PORT	GENMASK(7, 4)	/* Port on learned entries */
> > +#define  GSWIP_TABLE_MAC_BRIDGE_VAL1_STATIC	BIT(0)		/* Static, non-aging entry */
> > +#define  GSWIP_TABLE_MAC_BRIDGE_VAL1_VALID	BIT(1)		/* Valid bit */
> 
> The VAL1_VALID bit definition sneaked in, there was no such thing in the
> code being moved.
> 
> I'm willing to let this pass (I don't think I have other review comments
> that would justify a resend), but it's not a good practice to introduce
> changes in large quantities of code as you're moving them around.

I agree that this is bad and shouldn't have happened when moving the code.
Already this makes git blame more difficult, so it should be as clean as
possible, source and destination should match byte-by-byte.
It happened because I had the fix for the gswip_port_fdb() (for which Vladimir
is working on a better solution) sitting below the series and that added this
bit.

I can resend just this single patch another time without the rest of the
series, or send it all again. Let me know your preference.


