Return-Path: <netdev+bounces-180835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14001A82A8D
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 17:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF24189FD25
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 15:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D352E265632;
	Wed,  9 Apr 2025 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qGJ+Qcgd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BB625D908;
	Wed,  9 Apr 2025 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212528; cv=none; b=TLDpdAHuYHutCrPzAqUC3k8HUx4krtz7nRTbx/LCJaFsNUM+bAAJvN1JF3Xw/xyjIUvg9+RNkeFFg4O2BQri5oor23BVejwi+/lGpHDkCkt0TSmNTUefyy4p8Km1r/xNCt42stvGdoxYAAMr/vxgtgcGj5R8hO2e68zLNCSzUxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212528; c=relaxed/simple;
	bh=9e4D7tu8NpiZEjh0zjN7AOEJmEjmxGVQQpxC3EDMjGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVYy66bWBOvbhe/C0a1RU0t4WbDbE/8eGkXIjZwPFMMaW1D/vF2DGRJwD3bDQ5ysMdqBbrlHYa4FOREDve47fjpWFK/I6SH8CzbkmmsgT/rVvL6z8RcD9iydDYKrLhkUhbBvVNVgv06Oy/uJuYhrlD3zqYiY6Z9AXqr8KjkS1kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qGJ+Qcgd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GVms8sZy6YVwer8huqwdL535e2d50tSk6udp7SjsHpk=; b=qGJ+QcgdKd4LJA67qLXYZsIQBD
	ymHrSKgC+FhlSm3H9jhw1TJt/JTJElPeI3AVMc2zG+VNsbQzSKkaDwa2hs7YnBLzYddTM2061/aKq
	rdCKx0uxpXOpAJkRD3yKX9Zo7s/MJalDZK3D6GFtrEe+e2aIRJKTKklWlHdwbnIZ+iCo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2XLs-008Z3N-Sg; Wed, 09 Apr 2025 17:28:32 +0200
Date: Wed, 9 Apr 2025 17:28:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Lucien.Jheng" <lucienx123@gmail.com>
Cc: linux-clk@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, daniel@makrotopia.org, ericwouds@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	joseph.lin@airoha.com, wenshin.chung@airoha.com,
	lucien.jheng@airoha.com
Subject: Re: [PATCH v8 net-next PATCH 1/1] net: phy: air_en8811h: Add clk
 provider for CKO pin
Message-ID: <b8f9732e-bc33-4e73-b7bb-8513d8343983@lunn.ch>
References: <20250409150902.3596-1-lucienx123@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409150902.3596-1-lucienx123@gmail.com>

On Wed, Apr 09, 2025 at 11:09:02PM +0800, Lucien.Jheng wrote:
> EN8811H outputs 25MHz or 50MHz clocks on CKO, selected by GPIO3.
> CKO clock operates continuously from power-up through md32 loading.
> Implement clk provider driver so we can disable the clock output in case
> it isn't needed, which also helps to reduce EMF noise
> 
> Signed-off-by: Lucien.Jheng <lucienx123@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

