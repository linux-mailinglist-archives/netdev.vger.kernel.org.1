Return-Path: <netdev+bounces-193971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9A0AC6AF1
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 15:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258E64E5042
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 13:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1AC27B4E0;
	Wed, 28 May 2025 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vSVthGTD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878F7275873
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748440121; cv=none; b=Eu19Wqk/4yHDl5n2/Ta5ZIhSAxnf2sSZ0YdWRosvCjts3O2HoR5YKergSsElNMHDGnXzB29tKdUzct6z31w4LYM8/rmjkJ3VN286IJuXGS7UAGKZc1FoxytKpqJTxOTCmQ8NQrjVifo0KRhf+B1dmTPS4zElF8jCnSgO+PTRcoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748440121; c=relaxed/simple;
	bh=StYOTLp8FQ33h3/6Pultx9z+z6mqzLj4nsfL6TA0rhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1PBf20fP6B+pTdRzS6UpFJVxk2JPLIxRgVAYUwVWo1OTTS9Psu0kP5f8E0RpHkhhW/EDS4ujhzlgWgkQcvJte/uJs1jJW2TPpF1q/pihifGQU9umE8RfRDATmNL1WseC1xA1F/xXqf0ITy47UCgvqKX1L7nuFzC3eNq/pt8/IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vSVthGTD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mzTKoJp7btfEai826lfMEPDxASAtrCqoVaX/h7XE2tU=; b=vSVthGTDnYSQ+pDcuWMvB+P11m
	ZyY32z4zW/zKsXJ1tdqsju4xzCZuDlvOxaG1lA6tpS9yNkDGU9NAUeadr+6P6PpWZXPevnfGOaCP1
	sMaXGpBPwBWhGX8W7SsJimnoTT+T1nuyKhEDwsihvIC7zXDrTFXEsm6yd6OZGU0QNB9E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uKH91-00EBGC-Cz; Wed, 28 May 2025 15:48:35 +0200
Date: Wed, 28 May 2025 15:48:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oliver Neukum <oneukum@suse.com>
Cc: netdev@vger.kernel.org, n.zhandarovich@fintech.ru, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH] net: usb: aqc111: debug info before sanitation
Message-ID: <4f26ae44-0838-430f-9a83-311d7daf3adc@lunn.ch>
References: <20250528110419.1017471-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528110419.1017471-1-oneukum@suse.com>

On Wed, May 28, 2025 at 01:03:54PM +0200, Oliver Neukum wrote:
> If we sanitize error returns, the debug statements need
> to come before that so that we don't lose information.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> Fixes: 405b0d610745 ("net: usb: aqc111: fix error handling of usbnet read calls")

Is 405b0d610745 in net-next, just about to be merged this merge
window?

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

