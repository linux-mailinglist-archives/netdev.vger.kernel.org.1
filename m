Return-Path: <netdev+bounces-142871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE709C085A
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 15:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6B07B21827
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD6B1A0700;
	Thu,  7 Nov 2024 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4LCmehBY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F6F17BB0D
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988235; cv=none; b=hXU7QMHaQZs2amz5BhHT4PPK52/TWAAUOBjMrASuKUAJK/dzIkeNK+ye+PWjK0ItVqkUiEwq58dRzqGOqF+zPEaTHvJpD/ArhpLxfmmYofKD/GO2B+M0XJDH/AHEYaw+6Q9KSlK6zxgI0pNBJOOQkeaFWAwGDVNh3l/W1gxXX6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988235; c=relaxed/simple;
	bh=8en11BV1slvPG6VZdobFPQ3Y85PhozoRZoXaSXjasT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNW6I+1flmYswCEqjTLa/ahWasrFb33VCLuWFJNlVS2RXBMbc0TyFWH80TBKyEqjNhOLzypXtRWK1o3Fl3NwAuzuDYrCFlM60sgqObg7rOGy1O76/gRC+M13fxGwSsRzgtBt9JG9z1W9Q/pScnlmvUwINWZ2lZv9NDMaYiKcPyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4LCmehBY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4DwvS2d92LyA92yNSBsL9699fC02gfobFow6DYX9Y0U=; b=4LCmehBYQMjHpZtjacsywSO17m
	LQffN0wCoF0m9YWM5gmLxNg6kcTcsGqUJL/vtMSJtX4ZBhzy3qHgA0+1UKqmhXmzJxlo+l1gce+xY
	ZmxY0tqAirkPQ6qlwm2yqQ2shPHj4xGdKBWhh2f8Zex83iV96l5fkG3LnZbhc6NULPAA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t936t-00CT7c-NZ; Thu, 07 Nov 2024 15:03:43 +0100
Date: Thu, 7 Nov 2024 15:03:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	David Miller <davem@davemloft.net>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH net-next 4/4] net: phy: remove genphy_config_eee_advert
Message-ID: <a5eccf2d-0f3b-4394-ac40-2f4ad1f1e280@lunn.ch>
References: <69d22b31-57d1-4b01-bfde-0c6a1df1e310@gmail.com>
 <37da7f3e-b883-4c07-9881-b8c0516822b7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37da7f3e-b883-4c07-9881-b8c0516822b7@gmail.com>

On Wed, Nov 06, 2024 at 09:25:12PM +0100, Heiner Kallweit wrote:
> bcm_config_lre_aneg() doesn't use genphy_config_eee_advert() any longer.
> As this was the only user, we can remove genphy_config_eee_advert() now.

The naming of genphy_config_eee_advert() is also quiet bad, so it is
good to see it go for that reason.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

