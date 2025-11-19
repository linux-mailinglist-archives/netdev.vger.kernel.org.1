Return-Path: <netdev+bounces-240014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DC1C6F2C1
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id C8B3C2ED73
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E22E35E557;
	Wed, 19 Nov 2025 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YNmsIpiu"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6550434CFBD
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561565; cv=none; b=blSmfyOz1rawAB/R7vyaVz2F1rWaYUATFl5vsqbyOBu09eiacmlCEQp2sx9mKRvsgc/eSMdwT1l/JTZS6tXFTAeQSf7sk/i2o4kkd44e0FbAnEaVSfz+iGFkTAYhYegmb3TRirCVMB2PkqTs1PMze6Ka17JghckMLwZNELZEkIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561565; c=relaxed/simple;
	bh=WK0qL5rXM2gg7IXOfmywMDyb9/Lg1NN7JiiKrVL8tF4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D1VhV1suKF5X6dgKiSoS7JBp+iJC9gcpcNOMgAU3+N2U+1KfWSuy/aONFy9cD4cXOO5RmiNtOdauNmA14cTUt7yiqwGEBgEUEpxFERy/vJIoOOZzPQyozmpX7K5vXla1/Xf3MaP1oxI1rfQPVVNkMpAgilsMVOxLd6f4t05TRyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YNmsIpiu; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A6D0F1A1BC9;
	Wed, 19 Nov 2025 14:12:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6FCE960699;
	Wed, 19 Nov 2025 14:12:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 59B2710371A3C;
	Wed, 19 Nov 2025 15:12:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763561555; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WK0qL5rXM2gg7IXOfmywMDyb9/Lg1NN7JiiKrVL8tF4=;
	b=YNmsIpiuSU0lfNdLntCVRUeK+ePW8aUtjJjRigHsdFpHRLX+zGEA2fPzBQZVnpPYmLzu1A
	4V7uAFuMoknC5PRD+PplNXSpG+K2hT+SVNUNYlEk3bAjsIXaK73k1znq7DqLO7FoxcOCsZ
	HbIjtvMhiTqw/Y/xE1yZKtZgwrETSGSAF1Jr8Zvosn9728P7uolIw7UpjLoWJKZNG+HbPI
	z4aQv23ZwrLJZRVMc+qeHAdGdHLo65b1YI23u5oycldHxVIsZNScRU5XfiTuDM2X0BWLhp
	YHJm70uw6OdzW8v4T0OpkomO0G2s1kpqrqRLL8yKEj2BDWUeNpH2x4xsWWnWRw==
Date: Wed, 19 Nov 2025 15:12:31 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrei Botila
 <andrei.botila@oss.nxp.com>, Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Jacob Keller <jacob.e.keller@intel.com>,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/9] net: phy: broadcom: add HW timestamp
 configuration reporting
Message-ID: <20251119151231.628f0784@kmaincent-XPS-13-7390>
In-Reply-To: <20251119124725.3935509-4-vadim.fedorenko@linux.dev>
References: <20251119124725.3935509-1-vadim.fedorenko@linux.dev>
	<20251119124725.3935509-4-vadim.fedorenko@linux.dev>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 19 Nov 2025 12:47:19 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> The driver stores configuration information and can technically report
> it. Implement hwtstamp_get callback to report the configuration.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

