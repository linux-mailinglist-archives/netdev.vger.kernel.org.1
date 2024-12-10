Return-Path: <netdev+bounces-150694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E13B9EB333
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F1C285FCB
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F881ABED9;
	Tue, 10 Dec 2024 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZM6p6TDR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B590778F4E
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840330; cv=none; b=fRhERBRar7h1KQFNSm39pNRpkGDacMA5ct0zIKbfQ/lyg/keugWqjxzDnQI4WIT6eSpIvPTQwDbjvIy6M0oWxy5rd+wutDWZVru1TjlV4u94wotpQVy5LN3gZx1dKc+zLIjLwNKrVIYi2xxdHyMU/gjDqpT/T7eeiC3e7Hqms0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840330; c=relaxed/simple;
	bh=lhjOMJbivG+NWUc6Yz3aNckepJONFoFsrCPxuXRySCo=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=FAJlo4ckpb4VMThDWuxyko819ZXN3WjoEuB5/V0/ZYVghFIJBQ3NIrt870F5U6KPOzqVFRBmbtKF4nutx6feaisp9ny0x3kWPXIBZk7GHegfDfFzj8RCMW4t7axChyExhdw8obcAANHa+HST5JYOvDzXviAStBqVzDmb08rbVX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ZM6p6TDR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Th5XEizCnNqXk/EU9TbVjgdn9a5uFSC3a1KiqRYzn6I=; b=ZM6p6TDRWaV0ZE8tcw6N+7Pwzb
	KPMUeIePfCWn5BdsGFHhy3PKXcvYk482vE4KRNu4KN0eugE1aWFlZnQUZ7OagJTUhsz445CFDprcj
	0rZHAElR5JObUH95IgZHYdJi8aF/un4IcsYEoIJFCJzFrnLtxZ8bV0+L8MrLyY8a73XQ0bOwFh90H
	LU6782MH2C8oXadoLRoEA3s1vrzAcDu1HyP7YLptQ0SZOlA6LZVWV95jte1qZ7fUTbO3CcbDlEk8U
	tYOZhikzTHnmqMC/4FkyYM7x8krS718+AJuKZbfpV08ggsbuytY/QQe7yi+YNI9PIgo1wxnktsOpN
	2Rah7UvQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:40604 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tL14Q-0002U8-2E;
	Tue, 10 Dec 2024 14:18:39 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tL14O-006cZg-VM; Tue, 10 Dec 2024 14:18:36 +0000
In-Reply-To: <Z1hNkEb13FMuDQiY@shell.armlinux.org.uk>
References: <Z1hNkEb13FMuDQiY@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Ar__n__ __NAL" <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>
Subject: [PATCH net-next 6/9] net: dsa: qca8k: implement .support_eee() method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tL14O-006cZg-VM@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 10 Dec 2024 14:18:36 +0000

Implement the .support_eee() method by using the generic helper as all
user ports support EEE.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 59b4a7240b58..ec74e3c2b0e9 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -2016,6 +2016,7 @@ static const struct dsa_switch_ops qca8k_switch_ops = {
 	.get_ethtool_stats	= qca8k_get_ethtool_stats,
 	.get_sset_count		= qca8k_get_sset_count,
 	.set_ageing_time	= qca8k_set_ageing_time,
+	.support_eee		= dsa_supports_eee,
 	.get_mac_eee		= qca8k_get_mac_eee,
 	.set_mac_eee		= qca8k_set_mac_eee,
 	.port_enable		= qca8k_port_enable,
-- 
2.30.2


