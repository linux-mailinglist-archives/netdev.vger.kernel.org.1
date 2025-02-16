Return-Path: <netdev+bounces-166799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B122A37592
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 17:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D7B47A15CD
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 16:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1235E19ABAB;
	Sun, 16 Feb 2025 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BSh/GBfn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADF519A298
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739722521; cv=none; b=DQAcoBXaoFfuuFo6D8OcQq3aah38P72WlAHoD7NibqFOf6pIXrIcSn9bB0GGnckZj5B0WpN0WVJv0vbxKH/wuepy3ihMjG2ej+1NdxqQpapNjwm5LQ/YrGZ9/btz9PST3038i7sgVh8as//GMLL0ALbeVii94vQYJSl8NwVWzJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739722521; c=relaxed/simple;
	bh=ahNNWuwjW4S2cBGFBX4aVVbJILvqPe3UoAzKFco1Stc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQeLegavcVFwB2YMMFydp68CGziVeycO71EznsAabfuymBvzUUo16ju4x2jWsFgFqAnI+MmgI3iE2azjm+THxEKDCKPxGcgxc06qhUVf9F4PF54nGq5RGTF4J+qcEXK4vd95oCgZrWGoCjY51YB2CKldAsZFJh7ieUABEcLyNVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BSh/GBfn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oW2ZLiCx58Sf6K9VKugXXMkOBit82uFTH9Ly1wNuEgY=; b=BSh/GBfngdgAannmnUsAtEhMNi
	1tEJW/sYOGbN6Fjo7F9TeBFZSaCso5805n8AMKCzIiNeifd56BNYQW2A81jP/mVaWosRyvkm2cOm3
	eY7q4gOHjliEFn5uimCIEnkrW0SafK+0afHoAQx3be0ezThUqekLXiVHRDELlv/Gtm9Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tjhIU-00EhIp-VB; Sun, 16 Feb 2025 17:15:10 +0100
Date: Sun, 16 Feb 2025 17:15:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: xpcs: rearrange register definitions
Message-ID: <708f4291-b677-4ec8-8ca4-baa6be9f1547@lunn.ch>
References: <E1tjblS-00448F-8v@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tjblS-00448F-8v@rmk-PC.armlinux.org.uk>

On Sun, Feb 16, 2025 at 10:20:42AM +0000, Russell King (Oracle) wrote:
> Place register number definitions immediately above their field
> definitions and order by register number.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

