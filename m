Return-Path: <netdev+bounces-139086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A259B01C4
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 13:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01AB81C20E2E
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 11:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741301F708E;
	Fri, 25 Oct 2024 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/FIgcRQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D82E1BC5C
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729857544; cv=none; b=C4NqXsaUJ//0VQKyTTO/IjeYb+iSuM9SevMEihSG00wcliBNlC+wnDZRGyc5DYAgb213PxDKPPaVK2s4C1qZT2I38nocY8JuZZReBERE9554v1lqT4BNw0VZAvX00oFTAoCmg2Zx16H8kFPrv3SXQgbjXovBZd6ebBIUJ+pA/bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729857544; c=relaxed/simple;
	bh=Uh0OlVsfz2LZdL/1BzRCEwj2sqXdc+a9tCXdaNZXHlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfWijCOm8BPi3O79wqJZ0dEbgVoyfifh8/wSO7+2wzwtacL71Qv7L7Pip6gBIOkCRTJwT2cVEYZ1raz8xQgpjookVxId2pzI1zQx4/G6vCe6YRbwEGaW7Zgc5z9NXtttY8OICs8g0QRemngmLUVnGJSrSZBeOCIJsEjSdO8Czuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/FIgcRQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22997C4CEC3;
	Fri, 25 Oct 2024 11:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729857543;
	bh=Uh0OlVsfz2LZdL/1BzRCEwj2sqXdc+a9tCXdaNZXHlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O/FIgcRQl0cSEvMPundnGBUutOz5LIXNxD0ceifDopgIR2dO6qexJdvlVdElbQOA+
	 QqH/BTIYJv2IvZb0QOUsor+u4N46JWOjCpc6qDGORojEig1z8KEuRrGYNeA1tM+NsK
	 aTWZD6MchYB3eb3Q3iUlzpduBDlil++t0svZWWwMDNMg2ztsqQ1pgIZV73OuqJ2Htk
	 nIx9otyka1eoSG02wQz5htgU7ichIThvPGVkmdU+A0EdoSrV+irYme+1D+yVpZWNkd
	 R4jgt7wMMPp9JJpL8x85lpWVJ3fDEyCeS5CpMXFgzoJYBoxIc8rcT/DIs9CnNTVpO/
	 BgNhydDmkvpGw==
Date: Fri, 25 Oct 2024 12:59:00 +0100
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: fix inconsistent indenting in
 rtl8169_get_eth_mac_stats
Message-ID: <20241025115900.GP1202098@kernel.org>
References: <20fd6f39-3c1b-4af0-9adc-7d1f49728fad@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20fd6f39-3c1b-4af0-9adc-7d1f49728fad@gmail.com>

On Thu, Oct 24, 2024 at 10:48:59PM +0200, Heiner Kallweit wrote:
> This fixes an inconsistent indenting introduced with e3fc5139bd8f
> ("r8169: implement additional ethtool stats ops").
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410220413.1gAxIJ4t-lkp@intel.com/
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


