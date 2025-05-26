Return-Path: <netdev+bounces-193444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5E2AC40EB
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 16:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6BF3BAB13
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 14:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A704220B80D;
	Mon, 26 May 2025 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YW2RmyBS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9E120D4E3;
	Mon, 26 May 2025 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748268189; cv=none; b=GtrhIowF1zBqruQqiO7Zx1IhYnUfk6YUl11YDCPBq1zptumSLRGv/RKT90e3blG/xvXOge7Oy9/71Pno6MDENhWq4d9Y0liLYNnGYBvw6GJqRab64WAr7f4rdyQMdCLbcWWLlWxx9vtsq7IgR3NxIDzVDA9fRxOFmLbScsc7IPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748268189; c=relaxed/simple;
	bh=zK1jmSQDBJZhWfzIoDGLRviCxmEsHuZaB5jH6OIj7BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBpRuIECpxWJhNhtiu2CJ7xyMqcYg/YisUfqfhtWMpqsuH0OsxWYqze79BVDcDHsMMfoDYj8gJbp0Zohh1HTRsWW0hXxxq1owccoqMjz6ii+unyJPHkq/MOoKfmu0GPMUS54ZfDYhonBbzwa06DdcoFOS6Nb8aRShDxkB990wWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YW2RmyBS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DEQtdizu/K/ZkYN6B72uTJCKEfFiYTb8KeVxrO5XPKg=; b=YW2RmyBSXJIUcTxaBSooKr8ODj
	qctBwjYRO7oyyatJ1fZNTwPlE+Zu6ooS7VgNf/Lb02j/lOs6Z/ZQLXoYCjARru4ZuIZDkqfBhj7I3
	ZGrwYIooQ2LF3R9m1q/fTaz+vo6JU1cUsBhVkV4ddQ8+c4KIukl781JhLc+KZHH+OMo8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uJYPm-00E0Ks-KH; Mon, 26 May 2025 16:02:54 +0200
Date: Mon, 26 May 2025 16:02:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: Add c45_phy_ids sysfs entry
Message-ID: <9e27a19d-c9fc-4942-aa85-55486626473b@lunn.ch>
References: <20250523132606.2814-1-yajun.deng@linux.dev>
 <2eec1d17-a6d1-4859-9cc9-43eeac23edbd@lunn.ch>
 <fad26dc95cbe08a87b30d98a55b7e3d987683589@linux.dev>
 <aDQkLcfeu8zw8CJ_@shell.armlinux.org.uk>
 <552f550315dc503250cc61fdcd13db38c1ea00f5@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <552f550315dc503250cc61fdcd13db38c1ea00f5@linux.dev>

> But the 'c45_phy_ids' directory could not be hidden if it's a c22 device.
> If c45_phy_ids is a file and it has an array of values. We can hide this
> file even if it's a c22 device.

I think it is fine to have an empty directory. We don't hide the c22
id file if it is a C45 device.

	Andrew

