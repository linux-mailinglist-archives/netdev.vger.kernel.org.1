Return-Path: <netdev+bounces-238723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDA5C5E643
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 18:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 085884F7937
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 16:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DA0329E53;
	Fri, 14 Nov 2025 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Afc24hWy"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403DC329E4B
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763137138; cv=none; b=hdsQ1fWn5dFE70Xgi6+Mzohz4osyXrH//qRp1bYlVn4lYFNmDFvWGtPyLVlF4f30lSd/uOHa2r5o5lbtCGt4nu6brZO/iTncwi0y4ljdi9fNDiwnmOdfGbzTbURyB+hyK39qpX2l3+Dd5ijdMkJeJLY/VfBGjDhN9Z49c9Uf9+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763137138; c=relaxed/simple;
	bh=5qjemkrK2ciqEghuymNMXgEpILcB+MVaSxncrZFV5Lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7bOerPXrON+f4MsALdlOyr7hFV0fZWqqmI9tvFhDDOapos1UojKhURvzhSmsrafcWc82jmAVhuNoQHJz+Uq0sxufV5GcDy4OlyyemnCHPh1M8uXQazjhjiYW2Mj8BDlVJv6RGhv1zwJQgZfLhoKlIkVCqYz1omWUnm8JZwBdXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Afc24hWy; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6886E1A1AA9;
	Fri, 14 Nov 2025 16:18:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3D42E6060E;
	Fri, 14 Nov 2025 16:18:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ACB2110371CCB;
	Fri, 14 Nov 2025 17:18:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763137132; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=LMkOjqxsjW7norErzSJrL8Oj6OE6l49xwWE8YXBOlts=;
	b=Afc24hWy3/GjVSFM4+UMbIHQXpClqNuuQIx2Si3JJpvrLP4yCn5lQ8rPdJaaGmj2PDZbfP
	BSBE5ghYUx0QOlaaXdXN7WrOLqgyD2D7X5dBPxYKliQ+KbTnwRCMknd7kUwX7hMB26EhKF
	K7n+U0OLfFKeVMqyxReUHYdcbIFYbY7rn1HJKodxtFg0PLdubLsgjDEyBj0ksnEC1AL3z+
	zLEdgKmAYfiE1ToBj6oYE8uRxvBd7dVQKpGwxzX00tMAH3JrpYBs9QinwgQ7PA8A2L0byp
	M7c0JtDinSZ3WvQy/FYPTIwXEwqgT2u/6V7eK2do+go0QLFiiNRwCFcUaq+45A==
Message-ID: <62469297-d873-46cb-9c44-0467fd49b732@bootlin.com>
Date: Fri, 14 Nov 2025 17:18:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ethtool: advance phy debug support
To: Andrew Lunn <andrew@lunn.ch>, Lee Trager <lee@trager.us>
Cc: Susheela Doddagoudar <susheelavin@gmail.com>, netdev@vger.kernel.org,
 mkubecek@suse.cz, Hariprasad Kelam <hkelam@marvell.com>,
 Alexander Duyck <alexanderduyck@fb.com>
References: <CAOdo=cNAy4kTrJ7KxEf2CQ_kiuR5sMD6jG3mJSFeSwqD6RdUtw@mail.gmail.com>
 <843c25c6-dd49-4710-b449-b03303c7cf45@bootlin.com>
 <eca707a6-7161-4efc-9831-69fbfa56eb93@lunn.ch>
 <52e1917a-2030-4019-bb9f-a836dc47bda9@trager.us>
 <401e9d39-2c28-480e-b1c4-d3601131c1fb@lunn.ch>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <401e9d39-2c28-480e-b1c4-d3601131c1fb@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

> Linux's understanding of a PHY is a device which takes the bitstream
> from the MAC and turns it into analogue signals on twisted pairs,
> mostly for an RJ45 connector, but automotive uses other
> connectors. Its copper, and 802.3 C22 and parts of C45 define how such
> a PHY should work. There is a second use case, where a PHY converts
> between say RGMII and SGMII, but it basically uses the same registers.
> 
> fbnic is not copper. It has an SFP cage. Linux has a different
> architecture for that, MAC, PCS and SFP driver. Alex abused the design
> and put a PHY into it as a shortcut. It not surprising there was push
> back.
> 
> So, i still think ethtool is the correct API. In general, that
> connects to the MAC driver, although it can shortcut to a PHY
> connected to a MAC. But such a short cut has caused issues in the
> past. So i would probably not do that. Add an API to phylink, which
> the MAC can use. And an API to the PCS driver, which phylink can
> use. And for when the PHY implements PRBS, add an API to phylib and
> get phylib to call the PHY driver.

I also think ethtool is the right spot. In the above explanation, there
may be one more bridge to make between the net world (i.e. the MAC
driver) and the Generic PHY subsystem (drivers/phy). The Comphy driver
for Marvell devices for example is implemented there, for the really low
level, Serdes configuration operations.

If PRBS is implemented there, we may end-up in a situation where ethtool
asks the netdev for PRBS (either directly, or through phylink), which
will in turn ask the generic phy framework for that.

Maxime

