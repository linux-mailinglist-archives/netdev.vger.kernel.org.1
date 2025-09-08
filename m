Return-Path: <netdev+bounces-220877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97885B49526
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53FC188B94E
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D155321930B;
	Mon,  8 Sep 2025 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JrNMT+uH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6751946AA;
	Mon,  8 Sep 2025 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348643; cv=none; b=fjmlihqDzDlLXzL+k/BdFk0KHoaoB1e+//kTlkAs/HUhku6+39feRWbovAhKKhwiGkmWqZGn/QbpHruFAMCkEE9LslY4Uxku4CgIx21ihLM6bLJSEBkHEF11jrrIjlMF3HfDtU9vfk5n/zHnLbr4bGqOg1EzoFuckZ/5XhBy99E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348643; c=relaxed/simple;
	bh=JyeAjHr51IerhSLJb5Ne/tUfzY48xuLgCoSapiS0tXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBxRzT2yZkccsepXAaHLiX/N5rf5IxITIrodOMxrxcLjByl5lvtxnF/Prw/xT25qcsUCGiN3SqRJiSEOakPO5/OH+EAZ23nNM39P0rWSn/790fBDiM/Qltxz2vpZHsUt65K8NjTjPWOBK5c8JmTi5PExm1cDzyALtXDCwUYHRKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JrNMT+uH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=y1oX2n1bcYACr1d/N5jIcG0TvrSxDp22BmGSY57OfoI=; b=JrNMT+uHKuZLPfW4kbs+t7RVQC
	4CN4RCqpBUBunLv3rKz7wvuR4akU+wLbt2OfJ/kSBXFZmSzTfn0NOi1UbG+uHsTHSPwmvnet90NP3
	dJQbLN/X/AOktre/hIR0zBPSu022O6nhOaXdI3PMHIgX3qeje7U/4GDyGXuS5BwfqW4A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uveem-007gjr-L4; Mon, 08 Sep 2025 18:23:52 +0200
Date: Mon, 8 Sep 2025 18:23:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Sunil Goutham <sgoutham@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:ARM/CAVIUM THUNDER NETWORK DRIVER" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 net-next 1/2] net: thunder_bgx: check for MAC probe
 defer
Message-ID: <7580c3a8-d502-40a7-868e-838d5fd44e8d@lunn.ch>
References: <20250904213228.8866-1-rosenp@gmail.com>
 <20250904213228.8866-2-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904213228.8866-2-rosenp@gmail.com>

On Thu, Sep 04, 2025 at 02:32:27PM -0700, Rosen Penev wrote:
> of_get_mac_address supports NVMEM, which can load after the driver.
> Check for it and defer in such a case.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

