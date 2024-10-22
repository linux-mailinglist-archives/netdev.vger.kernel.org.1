Return-Path: <netdev+bounces-137883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA7A9AADBB
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 15:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C749228414A
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4780319DF48;
	Tue, 22 Oct 2024 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X+omNGm5"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF351E495
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604850; cv=none; b=rcJYTBIOOu4n4c2dhutRk0RVyYXRy6kcy/5jLdOaEMEqKHaMg9miDNF5wiInn3+XEtqkT05vr8/CK9jLetNfyevSzeKGjJReRRl5ME9Enri8vCKlLwNPWFUigJdgoubeq+WcyyqxTup53h/Js/GjnPRGR6QyR24A9FdTZ4RzneY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604850; c=relaxed/simple;
	bh=KHpi65Bhn7mk9mtdT6UHSQb9+Ib0sr8jiGlQQjLHbtY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8rfHdmlCUTgxfK3NOlxq+tuasczPelbpJwrybnA7QQsjpkl32wBjiSLtLT3g9iPhBsrr81Gx5B3KU+hSgFgSdTN3P5eYllcponAP4HYdZIMK4lent/IEwOHI61y6hv0lTvW3/AY7kXGY9kiO+ZCyVcWKzbFEDkIGEidLM/buYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X+omNGm5; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AC1ECC000E;
	Tue, 22 Oct 2024 13:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729604839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SsA6g39Tca2rt91iaCCWiM/uiPe5nngwaTnbl86SsxU=;
	b=X+omNGm581+t0xUlzmotfn/cq2rJs7dooCVy33KToZ12K8THKCB5jlHcOZLlzKWfsUMju9
	hGsDePPNs5SXCcRVMHcq2hhbYT2gZy8fflQzFhx4acgxulbC1QTQryvBksZWpsFY+drI0J
	A/jN1Es+dC/SVc+3JJdhqkcCQzJQawaLby8To4HUpO59VHmLAN12nIhMigycCp55kf5/+e
	1r2CFJ1Eat+GfR3CO73VGDyZztqGx6WweRUjUIAzrVB4jvtV+BoYzSibnwpnE+F0YyWMkJ
	PDO9fhG94AAT3J4/KDrpQL0JiTQI51ZZmDxGrhd0Sql7kBMUpjW7q5Zik0EWLw==
Date: Tue, 22 Oct 2024 15:47:17 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: phylink: add common validation for
 sfp_select_interface()
Message-ID: <20241022154717.08c56cc9@device-21.home>
In-Reply-To: <E1t3DSh-000VxF-IH@rmk-PC.armlinux.org.uk>
References: <ZxeO2oJeQcH5H55X@shell.armlinux.org.uk>
	<E1t3DSh-000VxF-IH@rmk-PC.armlinux.org.uk>
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

On Tue, 22 Oct 2024 12:54:07 +0100
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> Whenever we call sfp_select_interface(), we check the returned value
> and print an error. There are two cases where this happens with the
> same message. Provide a common function to do this.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

I gave the series a test on 2 platforms I have that use phylink with
SFPs:

 - The Macchiatobin, interface eth3 with different copper modules
 - A board that has an Armada 3720 wired to an SFP cage

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

