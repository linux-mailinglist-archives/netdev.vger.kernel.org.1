Return-Path: <netdev+bounces-122852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DCE962CFE
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 17:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B07112817F3
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 15:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDABC19644C;
	Wed, 28 Aug 2024 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RD8MoDhp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4AE188CD3
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860314; cv=none; b=qzWaUpubv+TBS4Iu0ghiA1NcRw3rW7rCHQuUIbrB6BEyCi/4mZvIaQypL/JPzpS2q+1OxSDYJxRc27Su8r+vsikcYodU65qWdHoBMT7uRwS79qdaQdgMR0s1YzFH9Yf4Ox8p2stqW98rfwauriPz3jgJZRn+OGZpbzYSQ3leg8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860314; c=relaxed/simple;
	bh=0HCzn1yQrp1Kp6Ufl+k2GFpuI10f0tnZj78IYc2DXGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URiZCjhuFQbg1EJ+JTRI64XMGlW8Q8lpwzoiIUhFEy9i5XN6170gyjvWl2SGPk7ooHQjbfqbPTEONpcRwoJsIxsu5ehrDJwPQKLawlS9tzUuXCM68E+NjOP6kwLFcr2kS46ByK+SgIIHlm1Cpr3BG16+tKBC+odLP6aBKI0qmyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RD8MoDhp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wfCzk0Irv4Lecpge/A6MaDoA3cK+V4Sz8xaUWVS71pg=; b=RD8MoDhpRpIQ2ATlJMtZ4Wk7zv
	+6TJ/DhZtAhQ5nFpCNCB4Ikev/VPj3LyKfej5m8Z7RD4rklJkXoeC0RF1FNid2xWAzBiFYt4N4/Ak
	nbuP+Z24vs/C10j5VWNNBi9ponaSSX1hZqpyrb03IfcSr7+BCPQoLklnM1bPskdgKfxM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sjKxJ-005x6j-Dg; Wed, 28 Aug 2024 17:51:33 +0200
Date: Wed, 28 Aug 2024 17:51:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, f.fainelli@gmail.com,
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: realtek: make use of
 dev_err_cast_probe()
Message-ID: <599fe8f2-f551-4554-b08b-5426ac86acb6@lunn.ch>
References: <20240828121805.3696631-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828121805.3696631-1-lihongbo22@huawei.com>

On Wed, Aug 28, 2024 at 08:18:05PM +0800, Hongbo Li wrote:
> Using dev_err_cast_probe() to simplify the code.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

