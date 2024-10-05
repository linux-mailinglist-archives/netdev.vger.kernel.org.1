Return-Path: <netdev+bounces-132403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56031991874
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 18:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8B51C20F30
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 16:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F032D15697A;
	Sat,  5 Oct 2024 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EAotX6QC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872461553AB;
	Sat,  5 Oct 2024 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728146991; cv=none; b=D7GBkIvW6PNV9ed15bpXmVcgxVij+ww8JUFpiNCfKdbtyjgPOtCqmT2jSVFw3Xg0cX/EiBAgAXFK9az3QqiEcx6MH47aC1fyBwFMWEE8PaT9jkQk/AgCHw9fT/d43IbCpnzJHUJWSt2v4A7anuTmJkKieXoZUcnrNJoDe9CoTpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728146991; c=relaxed/simple;
	bh=GYzrn89cXRMFdpcAwq59L6KmcfwlUvJPqz4QrSbKB8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRXKA0L0wxnQVT4DyjrMd2ggbg2revpxdXIfQFsORwBm9hAr3UNA2EQMVisn5mBTTX2dyeNYyRQkADwsWYKX+a+133lRoBiLT+8+/zgUv+HYNkyzjndYUIwN6s2QynjcLg42ueACoPJUoR8LwApUlYoIN6/Pzb/ZQdRlWMJ9Ono=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EAotX6QC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RtsfH1ElcWIv4ChNImcw8/GnyitEAy8EPUmcEc2T4qA=; b=EAotX6QCRhba9mABGAqGrEZABp
	R4rbDVDpWGGnERYFtCYu7f13oOtNEYETPJ3q1ndCZnwzi8SZTvah8bUDW7TIn9S4OjZTriXE23t+H
	eSQqWhRL0sUkm8WJSovE0wEtpa5ncix1e7GqgKzxPbSDGedg8FRYphD21M0ufVloUWNo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sx7yW-0098wg-KX; Sat, 05 Oct 2024 18:49:48 +0200
Date: Sat, 5 Oct 2024 18:49:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mohammed Anees <pvmohammedanees2003@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH] net: dsa: Fix conditional handling of Wake-on-Lan
 configuration in dsa_user_set_wol
Message-ID: <8555d3b6-8154-4a79-9828-352641ca0a58@lunn.ch>
References: <20241004220206.7576-1-pvmohammedanees2003@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004220206.7576-1-pvmohammedanees2003@gmail.com>

On Sat, Oct 05, 2024 at 03:32:06AM +0530, Mohammed Anees wrote:
> The WOL configuration now checks if the DSA switch supports setting WOL
> before attempting to apply settings via phylink. This prevents
> unnecessary calls to phylink_ethtool_set_wol when WOL is not supported.

The commit message should say why a change is being made. Why should
phylink_ethtool_set_wol() not be called? Why is it unnecassary? What
if the PHY supports WoL, and does not need any help from DSA?


    Andrew

---
pw-bot: cr

