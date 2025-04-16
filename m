Return-Path: <netdev+bounces-183333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCD2A9062E
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACAA8171039
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CC72040B4;
	Wed, 16 Apr 2025 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tfVIvVnD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4061DC04A;
	Wed, 16 Apr 2025 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813053; cv=none; b=H3Uk3mHR7UIFdHA9MnaWEJeeWpArGJV86dQ/AP8K9yC2SPNZBBG+RSeZIK9TBRk56JedR1nHdVXtotj5Nd39gPgwh0ZJ5I5rqONWYjwY9cC8ii3snFVbNjsHn7z4m+7Dv/Gr+6/vQH0eoeQBg7jo1XU8oB+IyYqGjWrcmen11ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813053; c=relaxed/simple;
	bh=Vq0Ny2LLl8ljbYPBqonO5Wv29k8AL8CwdcUshViQV04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jX0bIDHDZS7C1gWplIRmFdvIEUhe9dK4gSsO1Y4FjmoD5liUJCsE4yuUXE1ceBdf3tKknIkppMxNxved3gDw5Qq1YszDQjkOknGO6VH0PxcF9n67BB+cCA8ffvBB1MyKDMs1pPQzNXiwv0Mmv28A80WauvfzFUG7JrGBSk+lC9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tfVIvVnD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=d872widudVVRHs7iqgBlgEcpUVKvycISYwgUF2GnMu4=; b=tfVIvVnDPGNWn/PwSmtIBIteRV
	SUFd0/a/jCK0DtOxOeoWIA42YwuTp74e5CCeClzHMJiCN0Y/ypD0+JRsye48Fwm9WdA7mecQM0dt2
	r2SzHNcew/umGNTXuzdqf0ypcVGx+YlUspT/BmfqrnJR8X7a0a+e70FflHSW0NdOOpWI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u53Zw-009els-2z; Wed, 16 Apr 2025 16:17:28 +0200
Date: Wed, 16 Apr 2025 16:17:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	horms@kernel.org, pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net v2 3/3] rtase: Fix a type error in min_t
Message-ID: <02e4a26c-d89f-4868-95f8-1af3943f07b7@lunn.ch>
References: <20250416124534.30167-1-justinlai0215@realtek.com>
 <20250416124534.30167-4-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416124534.30167-4-justinlai0215@realtek.com>

On Wed, Apr 16, 2025 at 08:45:34PM +0800, Justin Lai wrote:
> Fix a type error in min_t.
> 
> Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

