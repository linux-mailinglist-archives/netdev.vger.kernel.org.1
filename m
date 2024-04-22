Return-Path: <netdev+bounces-90142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDE18ACDDB
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 15:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45BC51F2152D
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 13:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7A414F123;
	Mon, 22 Apr 2024 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Y/Axa+nT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9155314F121
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 13:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791345; cv=none; b=Jo4SaxNyVHjjdS2nd3HN1cjh1L6wJfeJOPkSxs6vj3JbxSkoCIhZAoQADS5xAr55NYaSHUd0dHwUv7rhCPxISrFvMlLQC7/JYgd1JwrFdV423amL40Hldrx0GR7IOh+OabVOCaMR2SqYTTgpWqEIXz9l1fyD8d0Etn+UeWo90n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791345; c=relaxed/simple;
	bh=1IFyZIEF5CkhE87tcVH8Y+W3bdgf1GLQBPeC1eWFxnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFg3RtP84aqMgymrjmWaXtJJB4N/wLmimb33gD2wP1uMZLrqcKbzDHqkFJT7u88a702PBlqqFYIzFQNFKhq+47W792hl57JTAjtxiaE50VJEuKXcHPGEX2Zb/yG/Dy328qa9EAVGVi3ENnvVu8i43T0I1xDfP9lCOfUo96yOPqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Y/Axa+nT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=0tExVYQkgh/QamuMLTOQ4cMZPcA9+abAxScGFT1jSxo=; b=Y/
	Axa+nTbrQvLvq+T8cbVslMYPX86wla3eZ8AKqHFrS6GH6lbU8mtUaJrgSqkbtMgN5yTA6xvEM5cGW
	Iz/6CBZVKm3kff2Y0cwMK5XXhVlFPnUF+aBmbk4p3nOJvDN3Qb10QAa5VeDxp6O7uJfi97DYugw3A
	MxH/ONbRO5gUcMk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rytPp-00DcLS-AG; Mon, 22 Apr 2024 15:09:01 +0200
Date: Mon, 22 Apr 2024 15:09:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: netdev@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next 1/2] net: sfp: update comment for FS SFP-10G-T
 quirk
Message-ID: <ac68c1fe-e3b8-4eb0-b3d6-a8b460af858f@lunn.ch>
References: <20240422094435.25913-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240422094435.25913-1-kabel@kernel.org>

On Mon, Apr 22, 2024 at 11:44:34AM +0200, Marek Behún wrote:
> Update the comment for the Fibrestore SFP-10G-T module: since commit
> e9301af385e7 ("net: sfp: fix PHY discovery for FS SFP-10G-T module")
> we also do a 4 second wait before probing the PHY.
> 
> Fixes: e9301af385e7 ("net: sfp: fix PHY discovery for FS SFP-10G-T module")
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

