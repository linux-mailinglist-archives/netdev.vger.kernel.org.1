Return-Path: <netdev+bounces-242973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B62C979B7
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 14:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E5123A59C7
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 13:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12BA313281;
	Mon,  1 Dec 2025 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XE1A3w8B"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFAB313529;
	Mon,  1 Dec 2025 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764595575; cv=none; b=E3/heTtZ2emnQNIB9ovpqs9QkKj5pXZKx3cRj2xH+OytbuR++GOumGXoaIjAlWdffJEfpMgLPM573CRc9uC/5ZwV73atBrYiUcKFXE/pVDK4QvZsOe1eeojJ7UCA9Rm+xmPUB8SGxEl6rgIp8PKJ8qe9Hdm3pDCNbbwFajzgT4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764595575; c=relaxed/simple;
	bh=5QxcHOM5qy8cvYfXCqki44Y2Ts06+G98XfmKNatDr/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAD4uY5QEhfSoiVq6R2vQthC2tl18eGEdYTHiQYF7QJ4bybh1gbw/qD7pAqj8vuTGV7gkQq7eaAKb2aX3CyS8b1K0vhu36TlKgMDvBWdn4ar3MdbJ519Gefb8XZV4TiB9b4LXVrGrZKnBt5GkZXcZYLDDN3eJ1gxidI7tGmSjRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XE1A3w8B; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yH49gsrsFp3aMWFvP4HFzSisqz+FpfUVe2zxx9d3lsE=; b=XE1A3w8ByEpxGgyRYWqkhVHhXS
	tx36hBjuSjMV60CItPD2oAr5qnnhsdulnHKn82egUsam8zqi5yLR4aoGfssELKNQBadLUzvDBrJTz
	bK0D61NoaRhEDe/kgPCRmoat1g9Kh43R/pGz8BQQH8KPCJb53ZsnGTMKBg4QVmDF6vbg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vQ3up-00FZha-Nf; Mon, 01 Dec 2025 14:26:07 +0100
Date: Mon, 1 Dec 2025 14:26:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] net: dsa: yt921x: Use *_ULL bitfield
 macros for VLAN_CTRL
Message-ID: <5fb9e799-6250-43a5-8d0e-a5f5adb69cd2@lunn.ch>
References: <20251201094232.3155105-1-mmyangfl@gmail.com>
 <20251201094232.3155105-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201094232.3155105-2-mmyangfl@gmail.com>

On Mon, Dec 01, 2025 at 05:42:28PM +0800, David Yang wrote:
> VLAN_CTRL should be treated as a 64-bit register. GENMASK and BIT
> macros use unsigned long as the underlying type, which will result in a
> build error on architectures where sizeof(long) == 4.
> 
> Replace them with unsigned long long variants.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

