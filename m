Return-Path: <netdev+bounces-97904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFE98CDD05
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 00:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9971F244B5
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 22:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295A4128377;
	Thu, 23 May 2024 22:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QL982mDn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D862128813
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716504561; cv=none; b=o3yQL4/YtN4M7Jsl9leGlJKNVHrPXDibp60PU1qkNPAh6/LZSi1xz1b/O7ZkbvHcuccNQgI6vikNA2Q1ox6DQOHTJ5qCfvIboxd+jcCjIQazlxIpPA/u05k67bZnYmX6Uov/WQlsoCIQ51Jnz559Oln3MXaA2Y4cuzC7lLpyzSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716504561; c=relaxed/simple;
	bh=f9jMztANsCWaEoyziPm3635UDYjMsvMpqiJJ+YVpNbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCwv658sJSz8y3rOerv/WS9l7uhF9ttuC9M6Xm1PSh5a43fFQ6+gMfy8uEJB9FifvDYjKx54qUcnYsMm9kHB/F0KUfyTfkVNHCH87ij9qyenVHroRG5YFBt9ovIZlZKyyCqvBy1Lr2QG/2qThs3Jq/h6n8Tux/h4prJmZhMgghI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QL982mDn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0uMJD6kECaJZcAvJQmdhtdY+pSHgMJbYsnVQ1CHDGd0=; b=QL982mDnr0aD6n9L9oowfH9QU2
	u5fDCFgQRvbrNHEW1/t9tYBn7omo8FL4A823CcvKshXEW+EKqbC+wjXFnVPl+j3yehnu50B5dXCMH
	Yyfjha/05ffu9BgMVKHrPORfHEFuiHzIWfwfcmY+8kjbdP7RcV7Fmi8aQXDpCgovwjCA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sAHFK-00FvFf-Qv; Fri, 24 May 2024 00:49:14 +0200
Date: Fri, 24 May 2024 00:49:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Glinka <daniel.glinka@avantys.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: net: dsa: mv88e6xxx: Help needed: Serdes with SFP not working
 with mv88e6320 on Linux 5.4
Message-ID: <2f7170c2-af24-420f-a816-0f15c069a212@lunn.ch>
References: <BEZP281MB27764168226DAC7547D7AD6990EB2@BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM>
 <0d5cfd1d-f3a8-485c-944d-f2d193633aa7@lunn.ch>
 <BEZP281MB277651F9154F2814398038C790F42@BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM>
 <6d0f1043-cf3a-4364-84e0-8dec32f8b838@lunn.ch>
 <BEZP281MB27767E9FDEBECA454A503C4090F42@BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BEZP281MB27767E9FDEBECA454A503C4090F42@BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM>

On Thu, May 23, 2024 at 10:38:36PM +0000, Daniel Glinka wrote:
> >> So, assuming you can use 6.9...
> >
> >> mv88e6320_ops does not have a .pcs_ops member. So the SERDES is not
> >> getting configured. Taking a quick look at the datasheet, the SERDES
> >> appears to be similar to the 6352 SERDES. However, the 6532 only has a
> >> single SERDES, where as the 6320 has two of them. And they are at a
> >> different address, 0xC and 0xD, where as the 6532 uses 0xF.
> 
> >> You can probably use pcs-6352.c as a template in order to produce
> >> pcs-6320.c. Actually, you might be able to extend it, adding just
> >> 6320 specific versions of:
> >> 
> >> const struct mv88e6xxx_pcs_ops mv88e6352_pcs_ops = {
> >>        .pcs_init = mv88e6352_pcs_init,
> >>        .pcs_teardown = mv88e6352_pcs_teardown,
> >>        .pcs_select = mv88e6352_pcs_select,
> >>};
> >> 
> >> to the end.
> >>
> >>        Andrew
> >Thanks for the suggestion! I will try this.
> >
> >Daniel
> 
> I had a look at the implementation. But switching to the fiber/serdes page does not work. I did some debugging and it seems the page is not properly set in the  mv88e6xxx_phy_page_get call. The function returns 0, but if I want to read the value back I get 0xFFFF. I also tried to write to the register using the mdio-tools (https://github.com/wkz/mdio-tools) with the same behavior.  But this is only on the SERDES ports. Therefore I would assume mdio works fine.
> I thought it was because we have no phy (cmode is 0x9). Could this be a different issue?

What MDIO address are you using? As i said, 6352 has a single SERDES
using address 0xF. 6320 has two of them, at 0xC and 0xD.

      Andrew

