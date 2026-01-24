Return-Path: <netdev+bounces-253000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENXWFpIZdGnS2AAAu9opvQ
	(envelope-from <netdev+bounces-253000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 02:00:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C507BD53
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 02:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D23A301468C
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 01:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EF515746E;
	Sat, 24 Jan 2026 00:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1rz8hFw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637A07E110
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 00:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769216399; cv=none; b=lmZ55AGDJK0YWuW9FPMVANEOq3cV9xRdmywX8F3Lufxvi+rESnzmmH/aZFWqdPehWVdzVwr5lnhA1ZCko+UPIq969UjzmegQHxyUv0LeAgedYY6LNkkkugNaeqxSpqsbQEfdZ6T40e9XnfLq89nku2V9WIeiV9nvm7fsa3rqyfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769216399; c=relaxed/simple;
	bh=P0moAP4QUOcnHbcix0kXlraPc2P4nJVJoTdv0t/Our8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeOCgZjs5nWw7JmIe0UWDQITjuXPyt8IQFMLv56K3JuJG1DtW7zPk46Tg+r4XTOQPZ2VLjOQOVmGNf3rik0LnnAY/yxNoO5t39IjUyJBMZLNsbOtMeYG3k9WWaLX6r2ELrhHjf9xgs9oWohTVTKMoW4kML1oTZfkcoDtkcAuUy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1rz8hFw; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fbb061a08so446675f8f.2
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 16:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769216396; x=1769821196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PxQBocjBKjEC4mv4CNajitmiXw7FC5x1mC5Q0V2nZ7g=;
        b=S1rz8hFwq47sda9lP5h0/LBnurRB743RFDymD9Xrrhk8d6Z45R7sm3/Hmx6kOy/qZw
         2EpVH4Yww0Fi2/6wLRko1lQGyNPYzlLxFaGAG7HGQprGs3rlrn1KeFjm+ZeyXuCh+2/1
         bmSEJDQZ34rijPHvZ0gdD987rQFdyavERvFsJKrPhWPFUi+mL4aoCa7iUQ0ynH9L7i6X
         lrGGOPM/U1QsTVJaSazdjBRwILFazmNCfz3EFjZ1y9LYuANWy7aGLf62sul8NineAdng
         1OT+Rd3KfnPPMsh/Wv0DvUDg0r3xd4D9SJQ7dz1jvyul6EhhYsvk4hXGSNRHOwtjEyGt
         VLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769216396; x=1769821196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxQBocjBKjEC4mv4CNajitmiXw7FC5x1mC5Q0V2nZ7g=;
        b=irn0/DSdCeWyKW5Es9O68M3/i6S59mqDdE0wnflyAfAkHgXt/yXyimZdTeBijw09Nj
         32ErqV5GafEUP3FRjryqDuO67FsM1ZqQ6diaMY2uoyZ5XzCCYYEy8+2krzUz6wHam6Hd
         Xbdj/DYHPQ8TVIBZYRN6hpPUsimTw8MmeJJbSQumRcxcWyMRNIHFCrTTHGaGEO0T7WIM
         EIefSpZR8e9rF+jzgmledJum1nQmpy7TfWkEirIPv7l5TXvkvaGB2QxLdr1hQTbB/Wbq
         KwhNjFpcd59+DRhPKvyLHgARkaHihyTbjCMCZXzbLP6zCapsxOir2DLJIIjc+hd+88HB
         ls2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXN2poy2U4Yss3lCBjygcX8ZfkaPdwyI/e/6FkmEpZbNqLJ2rUyNKChp9PJWmWKfI1Fj2R+1uQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1IegtcSym8v1CNhE5z8r9saQFSQvoEtBhQrB7UWKQWhQKCmom
	B6QGHbaS55NJ+Z9yI2TlksLPmDTm7tPtKFNlpCPRt6bIxqWoYIOYMn5n
X-Gm-Gg: AZuq6aJllUEYO3zlMd/u1C2rJ9S3C0djatC7SXcsgiNp/R00r66V1lM1g4f3AOSXiss
	zxDe3/gHwtcSB33HL0vHGmShW6Ego/Z24qrZeAcIS7KCZ7oldcDYICIghflmW7TYY6aouc/qjJf
	ufxOpAa98RhqoSs5KQNN7DuR0ALLW+qD5PdOtVKUJ8Aylebc3OOTCfmDnnrr4yOe0lqSggCHD20
	rF3QbOEV948C+0KtbyjipohgzkEeY1kwdkQKjxwHAM6M4eY0UZxPYbMiwNsSHdT3D9upm90aeDU
	sLCv1GjJz6rUfIFsI3QhFgai6iO8VhulF9D5Zh9lb7aBRd7jwRA8Rq2QE2JQglPConahTXFC8Hx
	a14MuFcYKbuljukMOc0+BbP5KiH46Bzu/wufQkjL6kiw/UzLRff1qQriS+9K0XFx59JNxUWBHve
	hH4Q==
X-Received: by 2002:a05:6000:420c:b0:435:b068:d3d9 with SMTP id ffacd0b85a97d-435bdff681emr1187921f8f.5.1769216395508;
        Fri, 23 Jan 2026 16:59:55 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:1430:8b48:2d45:6c1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e716b6sm10616033f8f.27.2026.01.23.16.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 16:59:54 -0800 (PST)
Date: Sat, 24 Jan 2026 02:59:51 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH net-next v2 05/14] net: stmmac: add stmmac core serdes
 support
Message-ID: <20260124005951.fbkvd2girdqtfxe7@skbuf>
References: <aXNEwBW3OA1xLEUj@shell.armlinux.org.uk>
 <E1vjDrM-00000005fQR-0rmB@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vjDrM-00000005fQR-0rmB@rmk-PC.armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253000-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,foss.st.com,davemloft.net,google.com,kernel.org,lists.infradead.org,vger.kernel.org,st-md-mailman.stormreply.com,bootlin.com,oss.qualcomm.com,linaro.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C5C507BD53
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 09:53:44AM +0000, Russell King (Oracle) wrote:
> Rather than having platform glue implement SerDes PHY support, add it
> to the core driver, specifically to the stmmac integrated PCS driver
> as the SerDes is connected to the integrated PCS.
> 
> Platforms using external PCS can also populate plat->serdes, and the
> core driver will call phy_init() and phy_exit() when the administrative
> state of the interface changes, but the other phy methods will not be
> called.
> 
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> --
> rfc->v1: avoid calling phy_get_mode() with NULL serdes PHY
> v2: add cleanup when dwmac_serdes_set_mode() fails, because AI allegedly
>   knows better than the author and phylink maintainer, even though this
>   will result in dwmac_serdes_power_off() being called multiple times
>   and producing a kernel warning. But if it makes AI happy, then it must
>   be a good thing. It'll also make Vladimir happy.

These gratuitous passive-aggressive comments about what makes me happy,
based on twisted interpretations of conversations, are best kept to yourself.

I remember Jakub's request was only to add a note in the commit message
about the reason behind the lack of cleanup, not to add cleanup which
will be executed twice:
https://lore.kernel.org/netdev/20260120153248.0636f1e9@kernel.org/

I only expressed dissatisfaction with the phylink_pcs calling convention
as it is today, and searched for ways to make the calls balanced. I also
didn't make any suggestion to make the code worse by performing the
SerDes power down twice, just subscribed to Jakub's request to leave a
comment why your v1 is the way that it is:
https://lore.kernel.org/netdev/20260122112913.svzaie4eywk5nc32@skbuf/

Getting over that dissatisfaction and working within the framework of
the existing calling convention, but also inserting the comment that I
was looking to see, I believe that functionally correct code would look
like this (applies on top of your entire v2 patch set):

-- >8 --
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_serdes.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_serdes.c
index d46a071bc383..c4465dca6b93 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_serdes.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_serdes.c
@@ -59,12 +59,27 @@ int dwmac_serdes_power_on(struct stmmac_priv *priv)
 {
 	int ret;
 
+	/* Because the dwmac_integrated_pcs_disable() call path is eventually
+	 * invoked irrespective of the dwmac_integrated_pcs_enable() return
+	 * code, we risk either underflowing the SerDes phy->power_count or
+	 * leaving the lane powered on, depending on the cleanup choice and the
+	 * point of failure. Keeping separate track of the lane power on state
+	 * is a band aid until phylink offers balanced pcs_enable() and
+	 * pcs_disable() calls.
+	 */
+	if (priv->plat->serdes_powered_on)
+		return 0;
+
 	ret = phy_power_on(priv->plat->serdes);
-	if (ret)
+	if (ret) {
 		dev_err(priv->device, "failed to power on SerDes: %pe\n",
 			ERR_PTR(ret));
+		return ret;
+	}
 
-	return ret;
+	priv->plat->serdes_powered_on = true;
+
+	return 0;
 }
 
 int dwmac_serdes_init_mode(struct stmmac_priv *priv, phy_interface_t interface)
@@ -95,10 +110,17 @@ void dwmac_serdes_power_off(struct stmmac_priv *priv)
 {
 	int ret;
 
+	if (!priv->plat->serdes_powered_on)
+		return;
+
 	ret = phy_power_off(priv->plat->serdes);
-	if (ret)
+	if (ret) {
 		dev_err(priv->device, "failed to power off SerDes: %pe\n",
 			ERR_PTR(ret));
+		return;
+	}
+
+	priv->plat->serdes_powered_on = false;
 }
 
 void dwmac_serdes_exit(struct stmmac_priv *priv)
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 6097f4b6dd12..e62bba38ab60 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -225,6 +225,7 @@ struct plat_stmmacenet_data {
 	 */
 	phy_interface_t phy_interface;
 	struct phy *serdes;
+	bool serdes_powered_on;
 	struct stmmac_mdio_bus_data *mdio_bus_data;
 	struct device_node *phy_node;
 	struct fwnode_handle *port_node;
-- >8 --

