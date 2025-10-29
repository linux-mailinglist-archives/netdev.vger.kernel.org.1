Return-Path: <netdev+bounces-234119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 870F1C1CCE5
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 19:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C00D4E04D3
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4926347FE3;
	Wed, 29 Oct 2025 18:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oSCVU7Dz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769ED2FDC59;
	Wed, 29 Oct 2025 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761763169; cv=none; b=f1ls8LJtEGP4bwEwYYM3BL/+QXf3NoV3G+yUHbvG1LIDOe0IUMZxr/MAD2Uie6xahhFB75qeShzFMHZCogUkKQou93v7xaUsULNAQTfnczgZpE2fvEAkaDqwzNo86rLWZ77gw8RoyiskkJWXPnzDA9LA/iyMVc6k/IkzEAQR1lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761763169; c=relaxed/simple;
	bh=9T3jSgMlBdHzbcHxsDO5MAbUCn5wMGz7aiqHAT/Sa6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHHD1giB5MyVIwRi6Tzfumgwtds5hZhoIX3kd+8+GQlD+9imXq+yixzjQ1g5VqK3hORWlySxxfg4XTpCW5P4FINLCio0nGrwGOc9oKLgeacfHBerVymmEw2GwHGsjHCoF6aTgnIqlIo0LAw7VdZYl20+4V3Jty8V4/mNgsYq570=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oSCVU7Dz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QrmhAk9sDkI3i94ZZZ5sHiIDttmrjSlgVlIk0QA+iZ0=; b=oSCVU7DzyZdYIKHEHMtpUC2XgO
	o4QlqgDQZpMWyQhvzSxopXu4KMFzvWPXs3r+ZFxEtQUONGnVqD0aFoE3VzW6dwYO3M9JEz7XU1jhR
	RmbnAvcE5JCkvVxQOw55okj3TqwTuj5W7Hcg1DI/fnwEi5t3gOjkDFkePmlXoE+L/60I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vEB4j-00CR9m-RI; Wed, 29 Oct 2025 19:39:13 +0100
Date: Wed, 29 Oct 2025 19:39:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: phy: micrel: lan8842 errata
Message-ID: <5c9a620d-2984-441a-b857-4fe2bd2db42e@lunn.ch>
References: <20251029072456.392969-1-horatiu.vultur@microchip.com>
 <20251029072456.392969-2-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029072456.392969-2-horatiu.vultur@microchip.com>

On Wed, Oct 29, 2025 at 08:24:55AM +0100, Horatiu Vultur wrote:
> Add errata for lan8842. The errata document can be found here [1].
> This is fixing the module 2 ("Analog front-end not optimized for
> PHY-side shorted center taps").
> 
> [1] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/Errata/LAN8842-Errata-DS80001172.pdf
> 
> Fixes: 5a774b64cd6a ("net: phy: micrel: Add support for lan8842")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

