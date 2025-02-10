Return-Path: <netdev+bounces-164718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5889A2ED15
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 14:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 119197A111D
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 13:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2651BD01F;
	Mon, 10 Feb 2025 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mQxC+HS9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12BE243378;
	Mon, 10 Feb 2025 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739192450; cv=none; b=TQXry+9Ax7cy0GhSo+G7DSJ5Q4ZEU5nWcnoJzbWMYGFEjXTEDcmkMEXPT2TSxwYLTKqhQoZxZUHJsH8nkAI1Xf7V2DPnO+/MYCKSsdmqw3MGPh4YVlSdsDcuRqz3sgs0dmKRuGbUn8u9XF5+z7R9ZNSVNg/0H53/EzF3OpgMplk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739192450; c=relaxed/simple;
	bh=k8BCw/rCXL9HABA1KoWo1oX3z8/5JPE8FP+EMj8Y+OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mk8842X6JXa97zIUwW/N//zlLt9+aVyFL7LmzcEzFu1+lIe9A1U9KDTtBqZHTEBN7wWaqw9krUHSqLXxMUVGLsnw2gue9eZreLOQucVFJngUB71+KY26DAudUwaXQuo5EpcWb9SQMs8IFReAjQPsiV9zU0YhK7Ci/SVyuMWLFQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mQxC+HS9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wy6vrOoyIm2ACk3He6+xKikKNiwbAEjnjNO36JbVUOU=; b=mQxC+HS9l3/xGYpwW5UNTG2NJz
	wT6tKgHRIjatNJTq8ZJj3+91SIn+JlxLuJosAZ0gRLcTn3Sh6jwCCr7GmbdQoRE5YA8lRgegl29PA
	l7pvvABNcFCYIGSgsTsYj3xZOosXBl/kfJfa0InEXqw7Ek37gU82hSqwebIjwjA+9DZ8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1thTOq-00CiF5-QP; Mon, 10 Feb 2025 14:00:32 +0100
Date: Mon, 10 Feb 2025 14:00:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH RESEND] net: phy: broadcom: don't include
 '<linux/pm_wakeup.h>' directly
Message-ID: <78761890-deb9-43f0-8315-d5b48c02ee38@lunn.ch>
References: <20250210113658.52019-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210113658.52019-2-wsa+renesas@sang-engineering.com>

On Mon, Feb 10, 2025 at 12:36:59PM +0100, Wolfram Sang wrote:
> The header clearly states that it does not want to be included directly,
> only via '<linux/(platform_)?device.h>'. Replace the include accordingly.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

