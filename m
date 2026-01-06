Return-Path: <netdev+bounces-247333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF82CF7A34
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 10:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48CF6315982A
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 09:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4D2322C70;
	Tue,  6 Jan 2026 09:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Eg0giomd"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C31322C77
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 09:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767692565; cv=none; b=I5GRgIOVQ/EQtXMitubA4AFjuvv2RSzGXNP1Ft6HB6YW3kx/Mv+QHwMtlwXXRD81qwfTDAdm7NC+lqjy0toO1AY1J37A8Xkg8jS4ORqjRr7tj72kA5eXkkoB2RATnVN8Kkn5fo0L1k6CbAkIECI/+GT8UtmLqBz5Iu/8xSiwCbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767692565; c=relaxed/simple;
	bh=uCg5LE1awkD4IvDTHcBajScqvE5FFewvys9HL+daHlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Gs6TmNwym+k0tgt7atHbghSF2Gliso//yYG4FNfDS3lLL1zhHW9qAKBLJz294vTwZCXdrRcmo5yNYr04lvAK4gFqb3Jo19CJ46WPmx8k3UUM+m+kxSoYOeZxhEETKq1Shuz816HVvhfLbi+XwWixTc1hgt3c2C6S/8fpPvY7Nlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Eg0giomd; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A34C71A2694;
	Tue,  6 Jan 2026 09:42:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 75D5560739;
	Tue,  6 Jan 2026 09:42:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9B602103C81A0;
	Tue,  6 Jan 2026 10:42:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767692554; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=XPYPcHd5Ki9QVbQ61NZ1G6T7KP+uNtCnjIDbW1nzNFc=;
	b=Eg0giomd4cyqgDgbKLX73h3iGLZ6rSizyDqYWbyRY1BFW6v4VYFSrANR4glxC9DGGwtnii
	wOn2+ErO2UuHLvfat8Pxh3hsulPEMiH1vjvXKbnnU6MXibjbPLqAo7KpMjaBgv0zRMVlJi
	Rb5NiBR/GYm0VzsKWgeNc8db6ymxL4+3LVcdDDtSf8zuTCPhmNRHPpBL2Z2N+5z8WY0PFw
	N36neWs+tlBswfQJRQ2VL4X/A+n3mzR8tUQOUVFW6qxi8ctSTQqkgdGQcHf+PaL/tMtniA
	X1hgIePSeZH8dervP+ZvHVrtdYt74oxAUp5HMAD5qJQSERalKD16uZT+f68o4A==
Message-ID: <4564a756-ec4e-4038-8a84-35410e9c6779@bootlin.com>
Date: Tue, 6 Jan 2026 10:42:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/5] net: phy: realtek: get rid of magic
 number in rtlgen_read_status()
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Michael Klein <michael@fossekall.de>, Aleksander Jan Bajkowski
 <olek2@wp.pl>, Bevan Weiss <bevan.weiss@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1767630451.git.daniel@makrotopia.org>
 <a53d4577335fdda4d363db9bc4bf614fd3a56c9b.1767630451.git.daniel@makrotopia.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <a53d4577335fdda4d363db9bc4bf614fd3a56c9b.1767630451.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 05/01/2026 17:39, Daniel Golle wrote:
> Use newly introduced helper macros RTL822X_VND2_TO_PAGE and
> RTL822X_VND2_TO_PAGE_REG to access RTL_VEND2_PHYSR register over Clause-22
> paged access instead of using magic numbers.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

That's nicer indeed !

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime



