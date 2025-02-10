Return-Path: <netdev+bounces-164531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F676A2E1CB
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 01:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7D5162B9D
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 00:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D58BA45;
	Mon, 10 Feb 2025 00:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="V7NvbX5q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880379461
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 00:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739147883; cv=none; b=OHjrM9jUpYmPT2CAOvbdb8X+4OeROgenvELGE8MMulVhJXcXfNNp6C0h6zUfhYJY6uQctuKyQNCKASSD9XF7C9qPEopYEwBMTI3E9DBPx1fBA9HBoHDoMaRAD6fzX2nW+0lQ13mXOeQmEt84YA8tPe8sclBN5GL1J4ZKihb00VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739147883; c=relaxed/simple;
	bh=nKXOLRJyPQc3ftqPgkA4Qc5Q6v30fbbzD4Pn2pkNOYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyUhTle/HEGpj+XohjAwiHCF3+u4YWPT41ynjPHJcIYeCeN8uwV24ZF8nslV6TInsZdLaHnfzSU6m4lJnG/dZ11pw4hRE0fG1ZqKyagLB0rN5ZnaIvwnJPOtzLvdq9uXReSTh6wVM66THl2Whkjv9oGvv7JvVQIp+w4gBmsWijQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=V7NvbX5q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=S4vj/tp2MFsaImiB4WRE+ewfkRo+/XmLwbxq/FHe+LI=; b=V7NvbX5qJWpXUjE85PgAPhR0It
	22TeqN+gy7SIel07BTLDmcxnyktOtDCNhpL2ZitiIqHtQy586+WCgYAniHBphRAkHP409QzJ02zk/
	vqmduMczK+/wrSC6eN2uofAJsebkLJ9G8vGB7/Ka/UVtwagwDwMd8t4BghMi3FBLezdQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1thHoA-00CYJS-UI; Mon, 10 Feb 2025 01:37:54 +0100
Date: Mon, 10 Feb 2025 01:37:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: remove unused PHY_INIT_TIMEOUT and
 PHY_FORCE_TIMEOUT
Message-ID: <0f81e346-200e-4dec-b3d7-0d754f596106@lunn.ch>
References: <f8e7b8ed-a665-41ad-b0ce-cbfdb65262ef@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8e7b8ed-a665-41ad-b0ce-cbfdb65262ef@gmail.com>

On Sun, Feb 09, 2025 at 01:12:44PM +0100, Heiner Kallweit wrote:
> Both definitions are unused. Last users have been removed with:
> 
> f3ba9d490d6e ("net: s6gmac: remove driver")
> 2bd229df5e2e ("net: phy: remove state PHY_FORCING")
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

