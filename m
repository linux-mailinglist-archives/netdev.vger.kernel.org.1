Return-Path: <netdev+bounces-215738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E087B30157
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 19:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E045E74DF
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC47C338F54;
	Thu, 21 Aug 2025 17:44:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D612E7F2A;
	Thu, 21 Aug 2025 17:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798289; cv=none; b=UvoKSXoqK87taiV37LEu1XMk1VJ4iGbvREb6L4x7E5SFsqLqMBC6fX3ygy2c8jiqfFsKEGdCzOv7RyxlrFqanDx4jLr7YvsI3wkM8D9+lR4x/yUNP6SAC55Y04twzNUtlz+0kQhP8fRjiOr439ZLlAnbQtT8kYggFqz7QuARYG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798289; c=relaxed/simple;
	bh=hwpE2IqqDqaV8DfOpZZZ1DfE3U+1TupPWH8OoWYR4iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2Lr9LZe9fEAwFVWwFW1FfHwA1+8motZPhduG5mYCpxiTSY1LdRbJd6I0u9+6xzuhDzE/ZD7Jlm5mwsYzWMxDjT7BSSP18xPa7XrTZf/Ujhsvyz11umKsNap/d/KKuR7Xx1fzRXBdCTJDsQsmT31IkAA+N9JnNFp80yGIz41Bis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1up9L4-000000008V8-15kK;
	Thu, 21 Aug 2025 17:44:38 +0000
Date: Thu, 21 Aug 2025 18:43:53 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
	"hauke@hauke-m.de" <hauke@hauke-m.de>,
	"olteanv@gmail.com" <olteanv@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arkadis@mellanox.com" <arkadis@mellanox.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"john@phrozen.org" <john@phrozen.org>,
	"Stockmann, Lukas" <lukas.stockmann@siemens.com>,
	"yweng@maxlinear.com" <yweng@maxlinear.com>,
	"fchan@maxlinear.com" <fchan@maxlinear.com>,
	"lxu@maxlinear.com" <lxu@maxlinear.com>,
	"jpovazanec@maxlinear.com" <jpovazanec@maxlinear.com>,
	"Schirm, Andreas" <andreas.schirm@siemens.com>,
	"Christen, Peter" <peter.christen@siemens.com>,
	"ajayaraman@maxlinear.com" <ajayaraman@maxlinear.com>,
	"bxu@maxlinear.com" <bxu@maxlinear.com>,
	"lrosu@maxlinear.com" <lrosu@maxlinear.com>
Subject: Re: [PATCH RFC net-next 12/23] net: dsa: lantiq_gswip: support 4k
 VLANs on API 2.2 or later
Message-ID: <aKdazKJftVzb0yVt@pidgin.makrotopia.org>
References: <aKDhwYPptuC94u-f@pidgin.makrotopia.org>
 <88bdaad0bb744dc401e94d97aba002431ac0b03b.camel@siemens.com>
 <dfb11982-5a7f-495c-8b25-aa1365ab8fe9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dfb11982-5a7f-495c-8b25-aa1365ab8fe9@lunn.ch>

On Thu, Aug 21, 2025 at 07:03:35PM +0200, Andrew Lunn wrote:
> > > @@ -269,7 +270,8 @@ struct gswip_priv {
> > >  	struct dsa_switch *ds;
> > >  	struct device *dev;
> > >  	struct regmap *rcu_regmap;
> > > -	struct gswip_vlan vlans[64];
> > > +	struct gswip_vlan (*vlans)[];
> > 
> > ... if this would be just "struct gswip_vlan *vlans;"?
> 
> Could it be moved to the end of the structure and made into an
> flexible array?

I agree that it would be nice to get rid of the additional indirection,
I will implement it as flexible array when we arrive there (ie. after
both series of preparations have been merged).


