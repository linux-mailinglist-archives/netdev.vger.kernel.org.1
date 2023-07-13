Return-Path: <netdev+bounces-17446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2E47519E1
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C00E281C32
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 07:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8056118;
	Thu, 13 Jul 2023 07:26:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE625680
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 07:26:13 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96C02D43;
	Thu, 13 Jul 2023 00:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PzFC7qNxQkAsCR0tnxCCk6SWQGRQ28U1/TaF6Fofsxw=; b=kx82qL2Q33zKRHoO0BsBb9bypQ
	b/QA4Z4g7ZnzMhjGWZuUiXjAVa0VLM1P09FKH2yVnk2KzsCUZ3gg94n64QCCQiMVOLy4HFMF29QAB
	DphIkiOPgi0BxVgyIM3UWf1sgH9kFGKtHmyP5M+GCxNDnIhRL3PUQdO8WD2M9GmvXuaWR1RWgbVq+
	g3SfY4GuCSO3y5Lju41ITXb7zX2YNsChV8wtDJn3PgZNmR/lr+akGUrKuVz7rTwyhVoTsgF/Fo5ni
	p0sSeVKXyWh832EjcVt3zPU8uMANW6yBARuSIC6XymXPEIde7oOQOsOgVd7JA42XsY6aUetKYs3wR
	FK14PNMQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56656)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qJqhx-0005sY-15;
	Thu, 13 Jul 2023 08:25:49 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qJqht-0005w9-QV; Thu, 13 Jul 2023 08:25:45 +0100
Date: Thu, 13 Jul 2023 08:25:45 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	John Crispin <john@phrozen.org>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Greg Ungerer <gerg@kernel.org>
Subject: Re: [PATCH v2 net-next 6/9] net: ethernet: mtk_eth_soc: add
 MTK_NETSYS_V3 capability bit
Message-ID: <ZK+m+ayRW/uaxl6u@shell.armlinux.org.uk>
References: <cover.1689012506.git.daniel@makrotopia.org>
 <6dc1e0ad7e8138835c959fc83a6c1564e8488c59.1689012506.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dc1e0ad7e8138835c959fc83a6c1564e8488c59.1689012506.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

on thu, jul 13, 2023 at 03:19:49am +0100, daniel golle wrote:
> +
> +		if (mtk_has_caps(eth->soc->caps, mtk_netsys_v3)) {

this is a case in point for one of my previous comments...

this code started out believing that testing for mtk_netsys_v2 for v2
features would be sufficient. your first patch ended up having to
change that to !v1. how long until this becomes !v1 && !v2 because
it gets used on v3 and v4 etc?

this is why i think an integer version field would be a much saner
approach.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

