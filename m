Return-Path: <netdev+bounces-197530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F20AD90CE
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 17:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51AA83A4929
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 15:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775B41C84BB;
	Fri, 13 Jun 2025 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0rqnTQju"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2C31AA1DA
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749827331; cv=none; b=BPluJGme7rKXK4pPA/bdbjh1BEhDfL7JJfGVTbqFQ7UrOk7EtUr06NXqKFVzA8YneTVW5aViqbi0lg42jY5dzHZHbSoa+jn74GbTSysf0WtMjs1YBMEF5fc+cc1iUWtsvBHx64FCxDDeWPCIJ+r2BDGk27qND7UoCkwSU+r+d0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749827331; c=relaxed/simple;
	bh=Gna30SyneltghOB4RT2u7YUbwzIDXsp8KIxtSDEHaT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsVxgIBy+KGL2LhshZmugb4bbHbB5BMrJ5nnLKsuxarDKXBSsnvGkMcNdtzrDnL6Q6g2PEEZVLaUM1kLWdzjLU9YueZRWKsB73OMLx65CeZkCm345BFGMj98p8uREJrA1VoF5v0eL02zKIUYbKkPxFaiIxhy7/4SgtLBYrKjoZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0rqnTQju; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LM/G2MfOkREbCesnwPPTd+0/gVXz926Ujgun7m0RKkg=; b=0rqnTQjuJbqBEO3eHExxOyNSpk
	FYbftMf9MUG6q8Yxke02bV5HUxIEkgWuMRa5fLadRdQvN7/MqpTbtJHo3dEppPVO9WOJC7n4nJH47
	rmq+aalJx0uRQelSaghGOaAbcAsMCElVZwsh+o+4IQ9USBAx7SDRypDg2VnCGX/WMPVg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uQ61J-00FjTq-T9; Fri, 13 Jun 2025 17:08:41 +0200
Date: Fri, 13 Jun 2025 17:08:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/4] net: phy: simplify
 mdiobus_setup_mdiodev_from_board_info
Message-ID: <893da33f-7dc9-4ed1-84c9-3c4551a3ef19@lunn.ch>
References: <6ae7bda0-c093-468a-8ac0-50a2afa73c45@gmail.com>
 <f6bbe242-b43d-4c2b-8c51-2cb2cefbaf59@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6bbe242-b43d-4c2b-8c51-2cb2cefbaf59@gmail.com>

On Wed, Jun 11, 2025 at 10:09:36PM +0200, Heiner Kallweit wrote:
> - Move declaration of variable bi into list_for_each_entry_safe()
> - The return value of cb() effectively isn't used, this allows to simplify
>   the code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

