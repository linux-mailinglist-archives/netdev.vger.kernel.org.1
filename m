Return-Path: <netdev+bounces-255840-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBVTAEeGgGnE8wIAu9opvQ
	(envelope-from <netdev+bounces-255840-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 12:11:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDDBCB846
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 12:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 88545300118F
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 11:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5808035CB8B;
	Mon,  2 Feb 2026 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DaC2urIg"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F108359705;
	Mon,  2 Feb 2026 11:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770030656; cv=none; b=cMYRwwQNTtbRY1BiY36ze/E2TP2eg0NNx7dNjXNDCi047TEgyL1+bDnAYjGyijPDVkUJKkybk+2h6MNWv9yD/RpU4M7YjJL5pRVppyKSXdEnRSYQFy4iOn8EhqB0A2X3bK+Zh4sGCOkVom001mTGWFGRWg14H7WZvQQ2H56u/OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770030656; c=relaxed/simple;
	bh=PvdW6zG91BlRsSnm3kf8E4G23DzcGIWEN4ztyTbjX7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PV3N2W7qxE747kXbp3spGJOrMK4GCmRum0SMcfAKm9VRh/O680KnPhKxxEXV8FASRP+3/5IJ48+lTW+enUzhTUNq0ugd0kMuu4Zi4d29wprHfdvuiGckewYUOrOWvnjNPRCOEJO8/I0JT36EAuqGrHCQGSsOXFILT+mejQpmLUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DaC2urIg; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C71D21A2BA2;
	Mon,  2 Feb 2026 11:10:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9999860767;
	Mon,  2 Feb 2026 11:10:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EC61E119A8888;
	Mon,  2 Feb 2026 12:10:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770030650; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=w6LZrRliaeVEnX1T81VpVKJXHHMQ0PUjevq9rlbhokU=;
	b=DaC2urIgkC2Sad99jrVTCWmvC8OCZU0nmSMTCvXw0TwpaG9OezbkzNQlqLcItEMcYdlHil
	RIC8kKls6NjLJ91dWtar4TyRN23Zr+PxbeJ3pP59xS76ugAooB273+UyzHO+++uzLpIuc6
	bU+nY3xAo6grAj0VO3UPXvms4ipaKvzRYLSAoXxZaUkB9gO03v+3XDD1vTyALsvuG6OoEp
	wNt+aAzx4w7vXXA2PcSfAZRdxCHDDPVgH9GCa49W40UkPQlHYsPGeXzulKLx8+CVFvkjzx
	ENWYT+i+7++svmdRbcqO8PAnO7G1Lf7UegGpS/zm/Lsp2mBd8FvGicJFYXoAtQ==
Message-ID: <267c78c1-4ad2-4f06-be63-0fb506c5134d@bootlin.com>
Date: Mon, 2 Feb 2026 12:10:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: phy: change devlink flag to
 AUTOREMOVE_SUPPLIER for non-SFP PHYs
To: Wei Fang <wei.fang@nxp.com>, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, florian.fainelli@broadcom.com,
 xiaolei.wang@windriver.com, quic_abchauha@quicinc.com,
 quic_sarohasa@quicinc.com
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260202054533.539883-1-wei.fang@nxp.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260202054533.539883-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255840-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,windriver.com,quicinc.com];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1FDDBCB846
X-Rspamd-Action: no action

Hi Wei,

On 02/02/2026 06:45, Wei Fang wrote:
> For the shared MDIO bus use case, multiple MACs will share the same MDIO
> bus. Therefore, these MACs all depend on this MDIO bus. If this shared
> MDIO bus is removed, all the PHY devices attached to this MDIO bus will
> also be removed. Consequently, the MAC driver should not access the PHY
> device, otherwise, it will lead to some potential crashes. Because the
> corresponding phydev and the mii_bus have been freed, some pointers have
> become invalid.
> 
> For example. Abhishek reported a crash issue that occurred if the MDIO
> bus driver was removed first, followed by the MAC driver. The crash log
> is as below.
> 
> Call trace:
>  __list_del_entry_valid_or_report+0xa8/0xe0
>  __device_link_del+0x40/0xf0
>  device_link_put_kref+0xb4/0xc8
>  device_link_del+0x38/0x58
>  phy_detach+0x2c/0x170
>  phy_disconnect+0x4c/0x70
>  phylink_disconnect_phy+0x6c/0xc0 [phylink]
>  stmmac_release+0x60/0x358 [stmmac]
> 
> Another example is the i.MX95-15x15 platform which has two ENETC ports.
> When all the external PHYs are managed the EMDIO (the MDIO controller),
> if the enetc driver is removed after the EMDIO driver. Users will see
> the below crash log and the console is hanged.
> 
> Call trace:
>  _phy_state_machine+0x230/0x36c (P)
>  phy_stop+0x74/0x190
>  phylink_stop+0x28/0xb8
>  enetc_close+0x28/0x8c
>  __dev_close_many+0xb4/0x1d8
>  netif_close_many+0x8c/0x13c
>  enetc4_pf_remove+0x2c/0x84
>  pci_device_remove+0x44/0xe8
> 
> To address this issue, Sarosh Hasan tried to change the devlink flag to
> DL_FLAG_AUTOREMOVE_SUPPLIER [1], so that the MAC driver will be removed
> along with the PHY driver. However, the solution does not take into
> account the hot-swappable PHY devices (SFP PHYs), so when the PHY device
> is unplugged, the MAC driver will automatically be removed, which is not
> the expected behavior. This issue should not exist for SFP PHYs, so based
> on the Sarosh's patch, the flag is changed to DL_FLAG_AUTOREMOVE_SUPPLIER
> for non-SFP PHYs.
> 
> Reported-by: Abhishek Chauhan (ABC) <quic_abchauha@quicinc.com>
> Closes: https://lore.kernel.org/all/d696a426-40bb-4c1a-b42d-990fb690de5e@quicinc.com/
> Link: https://lore.kernel.org/imx/20250703090041.23137-1-quic_sarohasa@quicinc.com/ # [1]
> Fixes: bc66fa87d4fd ("net: phy: Add link between phy dev and mac dev")
> Suggested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

I gave that patch a test, with the following cases :

 - On Macchiatobin (we have PHYs that share an mdiobus).
When unbinding a PHY, the MAC dissapears as well :

#before :

# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 2048
    link/ether 00:51:82:42:42:00 brd ff:ff:ff:ff:ff:ff
3: eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group default qlen 2048
    link/ether 00:51:82:42:42:01 brd ff:ff:ff:ff:ff:ff
4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 2048
    link/ether 00:51:82:42:42:02 brd ff:ff:ff:ff:ff:ff
5: eth3: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group default qlen 2048
    link/ether 00:51:82:42:42:03 brd ff:ff:ff:ff:ff:ff

echo f212a600.mdio-mii:08 > /sys/devices/platform/cp0-bus/cp0-bus:bus@f2000000/f212a600.mdio/mdio_bus/f212a600.mdio-mii/f212a600.mdio-mii:08/driver/unbind

The MAC interface correctly disappears, but for some reason a lot of
other interfaces dissapeared as well (only eth0 is left, where I used to
have 4 different interfaces)

# after :

# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 2048
    link/ether 00:51:82:42:42:00 brd ff:ff:ff:ff:ff:ff



- I also tested the SFP PHY setup on a Cyclone V platform,
and it worked as expected (i.e. MAC didn't disappear under my
feet when removing a Copper SFP, but the devlink was still created when
the module was present) :

# ls /sys/class/devlink/ 
mdio_bus:i2c:sfp:16--platform:ff702000.ethernet

I don't have time to investigate why my interfaces are dissapearing
on mcbin, but OTHO  unbinding the devices manually isn't
something I do very often... It may or may not be related to this patch.

I'll let Russell and Andrew comment more on that as I may
still miss other cases, but as far as I can tell, this looks
OK.

Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime



