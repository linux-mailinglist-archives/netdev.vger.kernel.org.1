Return-Path: <netdev+bounces-250014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1A9D22B96
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 08:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B245E3021954
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 07:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AABA326921;
	Thu, 15 Jan 2026 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=horizon.auto header.i=@horizon.auto header.b="QTTq/Nkd"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw03.horizon.ai (mailgw03.horizon.ai [42.62.85.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25361325734
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 07:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.62.85.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768460957; cv=none; b=sQTkwLhYz5ZVpsGCu/aGETomxLkU3dgAyUWSvNWd4Q5pnDv9f1xycX673aYsMxtA0RhX6riN0ZvM7Ju5/BwrCAweLBlXaQnw4rLPw0xsLFlKlalykyqxo0V6Ho43aY7B1f7bPgYGks0vckEvflcvQyJvOI8wyQOqKFHvPlGSriw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768460957; c=relaxed/simple;
	bh=nKVIQbO6XhV9gSduTzteXApWMXnjqd2vg2OXsllrwZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UXAw8wmJUideoMXqYQ86NlZs8S0QbcA92lpZbnS6t2q47HCLYGE849A35voEeBx2xhk/5zmFuWuIYYnaZuAwqBhqQo3a2g68b4SFMIXBnq861r1n6y6UaS6QHQZfVm4CQI65zuqtr66Ne5BE0bqcrRFPcvw/Xjih9lFqa7eSE60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto; spf=pass smtp.mailfrom=horizon.auto; dkim=pass (1024-bit key) header.d=horizon.auto header.i=@horizon.auto header.b=QTTq/Nkd; arc=none smtp.client-ip=42.62.85.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horizon.auto
DKIM-Signature: v=1; a=rsa-sha256; d=horizon.auto; s=horizonauto; c=relaxed/simple;
	q=dns/txt; i=@horizon.auto; t=1768460948; x=2632374548;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nKVIQbO6XhV9gSduTzteXApWMXnjqd2vg2OXsllrwZM=;
	b=QTTq/NkduO+RCFTpvnuRHvaILcZZeoNhXlU/jdlWPfdlqToXJHRGT51Y89FIJ7bD
	7PUU2P/hCg/iAdl5i1tht1SpphdPcgElpqcXG+o6s0t09gRAXJxmaC6RX5iN2sYE
	Zv+CI5cna9FYzu+UwhPjlsldVCPY+cmpmk/Wu/AUXzg=;
X-AuditID: 0a0901b2-dfddb70000001406-04-69689293262a
Received: from mailgw03.horizon.ai ( [10.69.1.10])
	by mailgw03.horizon.ai (Anti-spam for msg) with SMTP id CC.C2.05126.49298696; Thu, 15 Jan 2026 15:09:08 +0800 (HKT)
Received: from wangtao-VirtualBox.hobot.cc (10.9.0.252) by
 exchange003.hobot.cc (10.69.1.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.27; Thu, 15 Jan 2026
 15:09:04 +0800
From: Tao Wang <tao03.wang@horizon.auto>
To: <linux@armlinux.org.uk>
CC: <alexandre.torgue@foss.st.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maxime.chevallier@bootlin.com>,
	<mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<tao03.wang@horizon.auto>
Subject: Re: Re: [PATCH net v2] net: stmmac: fix transmit queue timed out after resume
Date: Thu, 15 Jan 2026 15:08:53 +0800
Message-ID: <20260115070853.116260-1-tao03.wang@horizon.auto>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <aWd9WUUGhSU5tWcn@shell.armlinux.org.uk>
References: <aWd9WUUGhSU5tWcn@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exchange001.hobot.cc (10.9.15.110) To exchange003.hobot.cc
 (10.69.1.10)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsXC5crIpTtlUkamwaOZbBY/X05jtFj+YAer
	xZzzLSwWT489Yrd41H+CzeLCtj5Wi4VtS1gsLu+aw2ZxaOpeRouXr7cxW8z7u5bV4tgCMYtv
	p98wOvB6XL52kdlj3ppqjy0rbzJ5PO3fyu6xc9Zddo8Fm0o9Nq3qZPPYueMzk8f7fVfZPD5v
	kgvgiuKySUnNySxLLdK3S+DKuPzyKFvBLZaKtpt3WRsY3zB3MXJySAiYSHS1TgKyuTiEBFYw
	Sqx5OI0NwnnOKPFxYhsTSBWbgIbE3anXWLoYOThEBKQljs3RAKlhFrjPJHHs6G5GkBphgTCJ
	yyd+sIHYLAKqEjee3GQBsXkFbCVetT5nhdgmL3F9ygGwek4BU4lTzf1g9UJAV3R8OMoIUS8o
	cXLmE7BeZqD65q2zmSFsCYmDL14wQ9SrSDSfnM8OMVNO4vWG/WwQdozElQcdTBMYhWYhGTUL
	yahZSEYtYGRexSicm5iZk15uYKyXkV+UWZWfp5eYuYkRFHucjJt2MC5Z8FHvECMTB+MhRgkO
	ZiURXt7faZlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEebUV4zKFBNITS1KzU1MLUotgskwcnFIN
	TF5BbBMzY5h4Ym+KL2a7ENofOym+cpHOXz2N6xeql7qIez1I/lNoI1mq6K3SsOyJRO3uW59u
	cX+cfPmpecK77TOyVmRoMuXM2Lx/695PivNy3mSKnyk89vt6dvNGlqcX11j2arJlRSguPGfg
	cdThwryCJZcKWWz8sz4F7dpudbsnSnt2W82L56fX7Z/ewDkjaP7zhrhVBzhyivQXP9j6b8MS
	STNltWiOu446q/bUvhdPmqJW6vqo+lrowiXbRJkV7lw6adys5P4quYe9J3r2CsFPSrem9i7c
	e/VY6U7Nr4H+Cpuq3I6+Tnl/wdJy6QwBVgGmn+c4dk9aJfQvsc697TP/fVPWqZsDo6z1d3mn
	myqxFGckGmoxFxUnAgAfpW59LAMAAA==

> While I agree with the change for stmmac_tso_xmit(), please explain why
> the change in stmmac_free_tx_buffer() is necessary.
>
> It seems to me that if this is missing in stmmac_free_tx_buffer(), the
> driver should have more problems than just TSO.

The change in stmmac_free_tx_buffer() is intended to be generic for all
users of last_segment, not only for the TSO path.

So far, I have not observed any issues with stmmac_xmit() or
stmmac_xdp_xmit_xdpf(), but this change ensures consistent and correct
handling of last_segment across all relevant transmit paths.

Thanks
Tao Wang

