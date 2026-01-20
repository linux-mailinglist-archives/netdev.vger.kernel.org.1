Return-Path: <netdev+bounces-251433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 520F6D3C50E
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7AC0E589B62
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DBF3D668B;
	Tue, 20 Jan 2026 10:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rBMPbugF"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9C03624CC;
	Tue, 20 Jan 2026 10:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903982; cv=none; b=dZ7ohhHQbsuHDFmptu9ZY+mvHHBedus7oXU6TP62/9tcISUBiAVn+IRVwRenFVM5ocJ1l5zKl+hs8s57qoIsQARC7PaGM5SgunKMMKc/TA4w2PegwAc89DQck7ECHgkalfxsz3mE1jRJJBEH7V7OflE/pzgcbwKXqvKopPFVBwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903982; c=relaxed/simple;
	bh=fVcL5XtGvi4X3+0G8pp2kIcJKmEDhVX3PeqbJdpboaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZAl2NoTQC5ukhXUSPS53EU4AAOupcsjT1b6SZRikubx7KXs4cj7mcRK8olyXkLw6DyerZD+bvo7C5yqN55E56m61rQcizx4GPOrq1enV53oaCzBEMUBWfc7jTs0pxQ2k9jCo6AUaodDyV6hhfzJqox+kpwBL/5BdGymWr9fG0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rBMPbugF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MfnfHEO5iuaJRI+62YTPm5+K8bMNJD7kcoNtFyzxGKs=; b=rBMPbugFWYyVL5qpyUg71WmJgk
	NsW+d5r8l/3OJR/bH+uny7K63JHwn6EexwsD9LgRY6e5O2AoGA0soxQOIcSdqKe3mQ+gXM9DhhvNo
	3KG7Z5FvIKpjDOcFokazR26jpXg0ukCqkxia45m632A7Xe22PwgqMfLqJI9IRIo84tkzvOmWADB0M
	pv42xrrZ6Rzee5VmvTyIbxH8lOov3zAKwed6WTCS3yxxp6LYPcbJ4QgQ/AJPkBTRGUHVtYWQa06FJ
	UO4Ic0BM3GjKTXZWTbufGLAIVl3iNTAXQw9/5JLdrWJoHlNavESs15lsvZcwxIGTgY+VGhp3SaXto
	6nDc20Fg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43312)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vi8jC-00000000645-2Cga;
	Tue, 20 Jan 2026 10:12:50 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vi8j8-000000007RE-1CJk;
	Tue, 20 Jan 2026 10:12:46 +0000
Date: Tue, 20 Jan 2026 10:12:46 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-phy@lists.infradead.org,
	davem@davemloft.net, maxime.chevallier@bootlin.com,
	alexandre.torgue@foss.st.com, mohd.anwar@oss.qualcomm.com,
	neil.armstrong@linaro.org, hkallweit1@gmail.com,
	mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
	edumazet@google.com, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, vkoul@kernel.org,
	andrew@lunn.ch, pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [net-next,05/14] net: stmmac: add stmmac core serdes support
Message-ID: <aW9VHt6meEJFxV0I@shell.armlinux.org.uk>
References: <E1vhoSH-00000005H1f-2cq9@rmk-PC.armlinux.org.uk>
 <20260119192125.1245102-1-kuba@kernel.org>
 <aW8M9ZiiftGBQIRM@shell.armlinux.org.uk>
 <20260120081844.7e6aq2urhxrylywi@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120081844.7e6aq2urhxrylywi@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

First, I'll say I'm on a very short fuse today; no dinner last night,
at the hospital up until 5:30am, and a fucking cold caller rang the door
bell at 10am this morning. Just fucking our luck.

On Tue, Jan 20, 2026 at 10:18:44AM +0200, Vladimir Oltean wrote:
> Isn't it sufficient to set pl->pcs to NULL when pcs_enable() fails and
> after calling pcs_disable(), though?

No. We've already called mac_prepare(), pcs_pre_config(),
pcs_post_config() by this time, we're past the point of being able to
unwind.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

