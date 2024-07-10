Return-Path: <netdev+bounces-110571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CEC92D2D7
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 15:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBC1B1C20B01
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 13:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2422418787A;
	Wed, 10 Jul 2024 13:31:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D875212C491
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 13:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618285; cv=none; b=SGvGYgUD4D2Nj/0dhRwBeXiv96olFplS2JfnL3ZaXyyXYeqJxrgPVUPvJNpBCnMrnVI8bEG0bwb4gJ+lSyi88cTluf9gX8YpiOEvyOSTSVbkIMV9hDxFnggOWQY43778KLZxK7jwbUEzBeaPhblmfKFdqorVcvx3JOVOMb6NLCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618285; c=relaxed/simple;
	bh=jXYoub8u4Pl5k4XDW/f5iyftIp1e+/C6KnFj5e0Wc7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfCaxkUVFCld/Lw1EQrsLNGi+g7OnSRWwGNsCDMAAtqu994mz3CHXL/gSHEcHQIsMT1heXKUEFIDL+eCTj3LjYXTKphHUOh4EPIobQNpc4ViSjCh1iqsbSDPatSz2BQJytgtiDEKWTXl+UkIV33yLe7u9BmUiKP3MqXuGTOeeV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sRXPc-00060e-Ob; Wed, 10 Jul 2024 15:31:12 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sRXPc-008Wfo-Ad; Wed, 10 Jul 2024 15:31:12 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sRXPc-008VRB-0m;
	Wed, 10 Jul 2024 15:31:12 +0200
Date: Wed, 10 Jul 2024 15:31:12 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, kernel@pengutronix.de,
	David Jander <david@protonic.nl>
Subject: Issue with SJA1105QELY on STM32MP151CAA3T over RGMII Interface
Message-ID: <Zo6NIINGn53fIa5M@pengutronix.de>
References: <cover.1720512888.git.0x1207@gmail.com>
 <d142b909d0600b67b9ceadc767c4177be216f5bd.1720512888.git.0x1207@gmail.com>
 <b313d570-e3f3-479f-a469-ba2759313ea4@lunn.ch>
 <20240709171018.7tifdirqjhq6cohy@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240709171018.7tifdirqjhq6cohy@skbuf>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Vladimir,

I hope this email finds you well.

I'm reaching out because I'm having an issue with the SJA1105QELY switch
connected to an STM32MP151CAA3T over an RGMII interface. About 1 in
every 10 starts, the SJA1105 fails to receive frames from the CPU.
Specifically, the p04_n_rxfrm counters stay at 0, and all RX error
counters are zero too, indicating that the port doesn't seem to see any
frames at all.

I can reproduce this issue even without rebooting, just by using the
unbind/bind sequence:

```sh
echo spi0.0 > /sys/bus/spi/drivers/sja1105/unbind
echo spi0.0 > /sys/bus/spi/drivers/sja1105/bind
ip l s dev t10 up
sleep 1
ethtool -t t10
```

Running the ethtool self-test is the most reliable way to reproduce the
problem early without additional software.

I've checked the RX_CTL and RX_CLK lines of the SJA1105 port 4 with an
oscilloscope, and both look correct and identical in both working and
non-working cases.

Interestingly, the external RGMII switch ports are working fine. I can
bridge them and push frames in all directions without issues.
Transferring frames from the switch to the CPU works fine as well, which
makes me suspect that the problem is isolated to the reception of frames
on the CPU RGMII interface.

Is it possible there's some RGMII-specific race condition during the
initialization stage? The bootloader implementation of the SJA1105 on same HW
seems to work fine too, so this seems to be a Linux kernel-specific issue.

Any insights or suggestions you might have would be greatly appreciated!

Thanks a lot for your help.

Best regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

