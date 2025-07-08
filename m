Return-Path: <netdev+bounces-205019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EEDAFCE06
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1DE487734
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B192E03F4;
	Tue,  8 Jul 2025 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KDKE0Pq2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D9A2E0412;
	Tue,  8 Jul 2025 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985742; cv=none; b=fraAqSP83k/UWulgaXpqB2RAToYdOcgRZKTneBXiIndTr5IBPOB5cgBG3OvnRwp+SSLAhrhkkH2kTu4Fqc5BUe2O3yO5LWioq/xaLbWOSpOgV81G94vVzKNUovgMM+qG1we3zFtLhryAQ3OM6NPYaAhV7pSmeD2DoT5kw0L+b2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985742; c=relaxed/simple;
	bh=Ix+oyfKVrqTXOmWvC2xTHsJVSvCUsrrlYPl0Vb3AOuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B15XWcq2BxESrloRXnwu0PTzeLXBHJXHyahIBhws8iZC82/1shgiaBgzZtBmnKtlRlTL2jQKgvKhXqFuRojb0i3C0TlZJabZIR1tU9wmI5qHxzD1IN4YuLgNA8LNkkZRPh91qlU6PY5N2E/Fz74qMfMbnQfrCGAZCzlt9EqgHiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KDKE0Pq2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LnZemOlCSBIHNM98nI0KbP/zo3HqivZbRY0TjB1Qhm0=; b=KDKE0Pq2oMdBqqH2X7tfwSlOAg
	VpIJHZxhBe/JcC0T3wrxpQlJJTG9g7FUC3z5dTwc3CZ8cVJkUQR8XwuIgOvxP6LdyJLP/yfpxnxT4
	Bfc2QTHtfviLACB7BRI28KMfJu3n2sQAL2O/dzUXAt8yHKh/ZkQJA2Ez++BaFF/So5Vc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZ9WO-000pcL-L1; Tue, 08 Jul 2025 16:42:12 +0200
Date: Tue, 8 Jul 2025 16:42:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	arnd@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 11/11] net: hns3: remove the unused code after
 using seq_file
Message-ID: <e966a9be-17ca-4202-9cd7-b0896dce0b1e@lunn.ch>
References: <20250708130029.1310872-1-shaojijie@huawei.com>
 <20250708130029.1310872-12-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708130029.1310872-12-shaojijie@huawei.com>

On Tue, Jul 08, 2025 at 09:00:29PM +0800, Jijie Shao wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> Remove the unused code after using seq_file.
> 
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


