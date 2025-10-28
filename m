Return-Path: <netdev+bounces-233515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 123ECC14B5E
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 13:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850A7188481F
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 12:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547F132E15D;
	Tue, 28 Oct 2025 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ojw6MZqX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB4532F755
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761656017; cv=none; b=PE62PNmcRY9WyaZJUVFK53hl6Az9PGniNaQvb9pJJHcKT1FIq7pdcBi54K5fBGkuHGtZ9CgJD8QkkDfgmAdE90ZopMrG+ykrHdU+8z0F4CriQrwAJzx8TktTW9+OYCN14IO5ErYi8XjxUrcEvXmPsrJrOFgWKM+kO8PZXB8n5gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761656017; c=relaxed/simple;
	bh=QyS2i558JAJUB2gvkxx1/wuO+TJdvXCOWWOrBPe3z+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4O8fP43vOMa/rgc3jBCx7VTdFNLuyzG57TEIZqzcZrDWRTkRa/p7AOum2OoTYrqnVnaN4Qb2JFvliHvXC6nRahYsy9YWG8KlET6EZyQh59MX7eft4qoWotvki88SzbZFejuw0NJJ9b96yp5elmAo/5q0mhdjcjqa1i216Uv6TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ojw6MZqX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NEdGRhxnV78x2j7pKiLRs3z/qy9hrTVdRTECTDa5G9Y=; b=Ojw6MZqX6JlxqZxL14/djpjDHf
	lOM6o3L/y1pAg2g/tcYFcV9vdmvIYyQ6cMrpG32OOJK3W8yjxGNRJdY8dIgonYKHxT+heXp0iDb70
	goh3/Qhz0hfMIbM+7O3Jw7tvt2zcjRAyLQvIz83wZnnvXCNM6Vt7fRNMK9awYMgXDODY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDjCc-00CINz-45; Tue, 28 Oct 2025 13:53:30 +0100
Date: Tue, 28 Oct 2025 13:53:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com,
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	pabeni@redhat.com, davem@davemloft.net
Subject: Re: [net-next PATCH 3/8] net: phy: Add 25G-CR, 50G-CR, 100G-CR2
 support to C45 genphy
Message-ID: <6030113d-6928-44f7-a134-5da3309950a9@lunn.ch>
References: <176133835222.2245037.11430728108477849570.stgit@ahduyck-xeon-server.home.arpa>
 <176133845391.2245037.2378678349333571121.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176133845391.2245037.2378678349333571121.stgit@ahduyck-xeon-server.home.arpa>

On Fri, Oct 24, 2025 at 01:40:53PM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> Add support for 25G-CR, 50G-CR, 50G-CR2, and 100G-CR2 the c45 genphy. Note
> that 3 of the 4 are IEEE compliant so they are a direct copy from the
> clause 45 specification, the only exception to this is 50G-CR2 which is
> part of the Ethernet Consortium specification which never referenced how to
> handle this in the MDIO registers.

Please split this into two patches. Adding standard conforming bits is
not an issue. But we need to be careful of something which is not
clearly define anywhere, and might need to be reverted at some point,
and that is easier to do when it is in a patch of its own.

    Andrew

---
pw-bot: cr

