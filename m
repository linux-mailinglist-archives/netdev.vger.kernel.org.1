Return-Path: <netdev+bounces-145603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EAC9D0095
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 20:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD161F2142E
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 19:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB321922CC;
	Sat, 16 Nov 2024 19:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xIQWahUA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601CF79F6;
	Sat, 16 Nov 2024 19:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731784050; cv=none; b=EvT5dlmBTqKYS/XBv4zJnDEZedAh+meDlERICkBq4SYywn+mD5ZfpFVBMYsHwSnRm+8HHiQmoSSI73yOGuJ+53QOGLBPN255JtEPBqCJvPgywnoEAJIIiOtbwR3dOleU0nGvou3TX+nMJv4SSpKOgM1BYhyLN7ALP7uGwj2dBDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731784050; c=relaxed/simple;
	bh=QGG0kSisYfxhMiSKSBjW6Mg6IYCqM6RD6litW91JUyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEDrSnVvIOLBzP0lBDxtG7ymWv01neJUXrInpZYflZ0BScW4wfu3WeYx7ufV3aHl+EajFjumsUGqRYBnV6F2RGzkhy1LK201Unu3/NjHCsEwUqGDWZp/vdULz+ds0XRqnFZQVvB19CITIOfV+lmLpXb2ocjrf6qN1T307wMPg+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xIQWahUA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7lqTnwwBmKNlBnmwiFv7Fs4kjvB3qTXjJ5WtSHx0T44=; b=xIQWahUAV+c0SClpQpa0inp7kK
	OsbMpZ/GVu76cubAISu91at5V6tW3iiZLfq7AStOm7LuAuNTjJP/jxIq2QCK03cXuNFrle6sM/hxk
	8K3Uy8Sa1wTzM8FfpGPClb6TyNoUyr4DehGYXz4wXasKQ/hH1WvY0tsdiHvHsfh77wnI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tCO8h-00DXVh-Mk; Sat, 16 Nov 2024 20:07:23 +0100
Date: Sat, 16 Nov 2024 20:07:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	horms@kernel.org, pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net v2 3/5] rtase: Add support for RTL907XD-VA PCIe port
Message-ID: <939ab163-a537-417f-9edc-0823644a2a1d@lunn.ch>
References: <20241115095429.399029-1-justinlai0215@realtek.com>
 <20241115095429.399029-4-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115095429.399029-4-justinlai0215@realtek.com>

On Fri, Nov 15, 2024 at 05:54:27PM +0800, Justin Lai wrote:
> 1. Add RTL907XD-VA hardware version id.
> 2. Add the reported speed for RTL907XD-VA.

This is not a fix, it never worked on this device as far as i see. So
this should be for net-next.

Please separate these patches out into real fixes, and new features.

	Andrew

