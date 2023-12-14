Return-Path: <netdev+bounces-57376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EB9812F57
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635942830E6
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFFA405D2;
	Thu, 14 Dec 2023 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YCE9gPAR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D453C1FC0
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=onUGZIEhAdv2IAjbWIqYVGcIsP4gMp0SVDnFIdf29mA=; b=YCE9gPAR77eCXNqBZ0HioeJWZ4
	57dn0uBPSfp4xENLdAJrdOnVhpJ/lsEX13MQkypGysqph32JXDtM7DnejkUNKgyZ/CBGvMK8kWAnK
	4ZN+pbeM8kSYujTIkxCVHcQqDxnzTZ4bgmeFOtgQo67HUzD44TnRJvcNbZGQG7SgXEYA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rDkBN-002v98-2V; Thu, 14 Dec 2023 12:47:13 +0100
Date: Thu, 14 Dec 2023 12:47:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, opendmb@gmail.com,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net v2 2/2] net: mdio: mdio-bcm-unimac: Use
 read_poll_timeout
Message-ID: <f02ba0e8-fff0-4c79-99bc-ccac8a7ae1d8@lunn.ch>
References: <20231213222744.2891184-1-justin.chen@broadcom.com>
 <20231213222744.2891184-3-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213222744.2891184-3-justin.chen@broadcom.com>

On Wed, Dec 13, 2023 at 02:27:44PM -0800, Justin Chen wrote:
> Simplify the code by using read_poll_timeout().
> 
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

