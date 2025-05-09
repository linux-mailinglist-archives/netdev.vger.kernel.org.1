Return-Path: <netdev+bounces-189290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16234AB1795
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 16:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79D307BE2E2
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE4F228CB0;
	Fri,  9 May 2025 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Cxoy9r7h"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37530227E87
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746801657; cv=none; b=Gc+lYIEOeUfPuCOFitDPeKbNcGScGSIcpwDiLx/NVGN1TdO3GTHP9dSaMEK0EbtVXrM9B/ku5GlumRnPOnUMMDQNgzoQ1pCa28rorH3wt0GZIMvBtADMtNhbmhWfIS+kImzkWfmRtkpV1q/+gAdrrc+fAsNkZ5lmEmxE5E8EJHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746801657; c=relaxed/simple;
	bh=4yVAJBnAAr6M4zx1sfX3IcM1zaOvpmCjIhGoeuBwgps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIcadZ3GMZvUALl2Z+gtkznQR1JpMn+xkG19ASfM4B9MxPt8B8sqRCUhntUg8ED9+SWiY97i62rehSsJ+D1Shbo1dxxKTxaUvIoISmhMEJJ0XiJCnPQhPzv8+Mi3ICElWXwfMiTPU3rN8QF6gvOOS7w+tq7eOPyMHaI2JNbdiUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Cxoy9r7h; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=k4hgG5ctNXkl8DyQIeS5FOj/RRZxp4TZdPf9lvmO7F0=; b=Cx
	oy9r7hgtmaIr84tWAMTtqb/UmgxnD8Sqj5YTom4FIoKTs7Om67aFScTm9InUYdEfrFDvtzP2yQnMr
	++gmtgDyYYw4p17ZNAjAjrh818kDTK20J6l9eyl1WDepbgOYLXvNhqEKrQhiwz6Dx8Tk74HzeFXF/
	3lHSysZFitfGzvQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uDOuD-00C7lD-Nk; Fri, 09 May 2025 16:40:53 +0200
Date: Fri, 9 May 2025 16:40:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH net-next 00/10] pull request for net-next: ovpn 2025-05-09
Message-ID: <5e2b95fd-4bb5-43fd-bba6-680a6f2d41fa@lunn.ch>
References: <20250509142630.6947-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250509142630.6947-1-antonio@openvpn.net>

On Fri, May 09, 2025 at 04:26:10PM +0200, Antonio Quartulli wrote:
> Hi Jakub,
> 
> here is my first pull request for the ovpn kernel module!
> 
> As you can see in the patches, we have various tags from
> Gert Döring, the main maintainer of openvpn userspace,
> who was eager to test and report malfunctionings.
> He reported bugs, stared at fixes and tested them, hence
> the Reported/Acked/Tested-by tags. If you think such
> combination of tags is not truly appropriate, please let
> me know.

Ideally, all this discussion should have happened on the netdev, where
others can take part and learn more about how ovpn works. If this
happened in the open on some other list, please could you include a
link in the patches.

       Andrew

