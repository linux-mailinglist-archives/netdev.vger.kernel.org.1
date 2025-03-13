Return-Path: <netdev+bounces-174609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E4BA5F7F7
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 15:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E50257AEA0E
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E437D267F64;
	Thu, 13 Mar 2025 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ByfpI/Xf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5605267F47
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875919; cv=none; b=TarD6O62pZMinylTTBhzpTqXOq/JETZsYaDkYmq3razLDe/YvT0FNH2ViTow5HGqMu8pSXjrxClSzSCADRbflT8nSSVQvCT8VuhctUxSc3/iIMBqqqN98h8reIleQ7fS4wjTXAGRP+1ZI3w+gFupNUVye3Iv3cxBp/pTOFrhBqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875919; c=relaxed/simple;
	bh=FY15/WK4LnzBZs715NaEgQ7XlU/v7OOjr/+ODOf3CUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kV0Om2pRDsiMJXjj1OpR2Fw/wG+xU5SWBUmVzI76zmyMPQewRIQw2w11ZI1YoXa1a5CtjHiZEYcULPbId2/q36HKjAFgYZZvDlduDP0+Aw7nJesUoKw+HEoJW4Zr09AKjHb5Zu5LkWBB1W+kJ93/Vh9FtDzE84lDrkObqpi+5bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ByfpI/Xf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=jbhdh8KBWh/pqLeL9TtMz7MBpPwyLNkLwMqOZrB1PXA=; b=By
	fpI/XfMO/j/NLhziY90runhv3m7ZdK/Jzebh62lnjInEfWxl8gIYegxUL2SxZNP998MVIwrC0TPEH
	tbgiOsDI/xj60kI26Q4to30YkzVVvzS8NV96KBDMlgOBmP1wBnszN8T3mp19Zx0JXpLsIgXuZCARV
	J2nWkcWTYOCq9+E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tsjUj-0050tr-Ru; Thu, 13 Mar 2025 15:25:09 +0100
Date: Thu, 13 Mar 2025 15:25:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>, netdev@vger.kernel.org,
	Lev Olshvang <lev_o@rad.com>
Subject: Re: [PATCH net 01/13] net: dsa: mv88e6xxx: remove unused
 .port_max_speed_mode()
Message-ID: <c2abf89a-88b7-469c-acb4-40ee72b0a91a@lunn.ch>
References: <20250313134146.27087-1-kabel@kernel.org>
 <20250313134146.27087-2-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313134146.27087-2-kabel@kernel.org>

On Thu, Mar 13, 2025 at 02:41:34PM +0100, Marek Behún wrote:
> The .port_max_speed_mode() method is not used anymore since commit
> 40da0c32c3fc ("net: dsa: mv88e6xxx: remove handling for DSA and CPU ports").
> Drop it.
> 
> Fixes: 40da0c32c3fc ("net: dsa: mv88e6xxx: remove handling for DSA and CPU ports")
> Signed-off-by: Marek Behún <kabel@kernel.org>

I would say this is a cleanup, not a fix, so should be for net-next,
not net. And a Fixes: is not needed.

	Andrew

