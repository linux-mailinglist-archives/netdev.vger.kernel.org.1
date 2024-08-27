Return-Path: <netdev+bounces-122187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B91960492
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 10:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC6B2846D8
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 08:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D667318BC0B;
	Tue, 27 Aug 2024 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mJVqTFzY"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28B614A90;
	Tue, 27 Aug 2024 08:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747866; cv=none; b=NXCXO7BV7raCwY1xNWtmCEZM7X1GhZyEImCEHn9ppXm6JInbCrtBbC0mJidHf48qZjOfMuS/QHxXSHWUEQySCI2hlSKBMOqEW2kqnNinQ/uINnqa4n3jp4AEQ9d0ezVpdodY4iweNVbTelKINZ+d+vcP+f2qcyub/9R0FVtq0uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747866; c=relaxed/simple;
	bh=pJYd3MeHbM+FMXGaSzSNOjHpJNhImUFrqZ/s4G6drms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwtftF7GcUXP+UOVjdyxLQpFOiXM6pdZi54doGNFz1zF7FgXsOPfZhvItPoP0UxcKVSfJJ7mCoqla7aCzoxRXzhUE6Qfqfa3KqYHGi6rgOZEg9duA9fIaKVp40cWUs9e3sXYwf3NwimvXYKiYMeLl6ch3mpNqhV3VFbgljAx3qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mJVqTFzY; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 612D02000B;
	Tue, 27 Aug 2024 08:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724747856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1QUY99BQnRe9MEXDdHrO9LU1xOLBc9OegOD6TyQWubM=;
	b=mJVqTFzYXycsoLCe+NUIJgC4yILgvNqq9PToTnxwc5V3/fgp1p2JUuupgmI1ly9k5+eHH/
	ZipB99yIq7m+Crlu705p/926mn7yIny7fO2ncfm4cD0I8K5PjmL7shxhfdTtLUnCqBmosg
	SSLUmk8//WADlpVMIpOHSOFyxOoUPMFeb0PUiratCNYhx8xA/32Bg4b1xOOOFLQf5BRMWu
	wq4ErU7HpDKdR5MyKG2t5m6rHJWJwI75A2R2dd7Xp/BP5+WDA4Z80iUNAuUiodv+w1rQlf
	KmA3LuAVyPKxWilCEPiB+mG7lXlb8lE9PnANDHcuIOJx29b+Gx6g64qFP0N5rw==
Date: Tue, 27 Aug 2024 10:37:32 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Pengfei Xu <pengfei.xu@intel.com>, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Nathan Chancellor <nathan@kernel.org>, Antoine Tenart
 <atenart@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Romain
 Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v17 11/14] net: ethtool: cable-test: Target the
 command to the requested PHY
Message-ID: <20240827103732.690fb31d@fedora-3.home>
In-Reply-To: <a1642517-366a-4943-a55d-e86155f51310@stanley.mountain>
References: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
	<20240709063039.2909536-12-maxime.chevallier@bootlin.com>
	<Zs1jYMAtYj95XuE4@xpf.sh.intel.com>
	<20240827073359.5d47c077@fedora-3.home>
	<a1642517-366a-4943-a55d-e86155f51310@stanley.mountain>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Dan,

On Tue, 27 Aug 2024 11:27:48 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> On Tue, Aug 27, 2024 at 07:33:59AM +0200, Maxime Chevallier wrote:
> > 
> > This issue has indeed been detected, and is being addressed, see :
> > 
> > https://lore.kernel.org/netdev/20240826134656.94892-1-djahchankoike@gmail.com/
> >   
> 
> There is a similar bug in ethnl_act_cable_test_tdr() that needs to be fixed
> as well.
> 
> net/ethtool/cabletest.c
>    307  int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
>    308  {
>    309          struct ethnl_req_info req_info = {};
>    310          const struct ethtool_phy_ops *ops;
>    311          struct nlattr **tb = info->attrs;
>    312          struct phy_device *phydev;
>    313          struct phy_tdr_config cfg;
>    314          struct net_device *dev;
>    315          int ret;
>    316  
>    317          ret = ethnl_parse_header_dev_get(&req_info,
>    318                                           tb[ETHTOOL_A_CABLE_TEST_TDR_HEADER],
>    319                                           genl_info_net(info), info->extack,
>    320                                           true);
>    321          if (ret < 0)
>    322                  return ret;
>    323  
>    324          dev = req_info.dev;
>    325  
>    326          ret = ethnl_act_cable_test_tdr_cfg(tb[ETHTOOL_A_CABLE_TEST_TDR_CFG],
>    327                                             info, &cfg);
>    328          if (ret)
>    329                  goto out_dev_put;
>    330  
>    331          rtnl_lock();
>                 ^^^^^^^^^^^^
> 
>    332          phydev = ethnl_req_get_phydev(&req_info,
>    333                                        tb[ETHTOOL_A_CABLE_TEST_TDR_HEADER],
>    334                                        info->extack);
>    335          if (!IS_ERR_OR_NULL(phydev)) {
>                     ^
> This test is reversed so it will lead to a crash.
> 
> Could you add some comments to ethnl_req_get_phydev() what the NULL return
> means vs the error pointers?  I figured it out because the callers have comments
> but it should be next to ethnl_req_get_phydev() as well.

Good catch ! I'll send some followup to address this report as
well as update the doc.

Thanks,

Maxime

