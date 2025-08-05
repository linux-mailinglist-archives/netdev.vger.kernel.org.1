Return-Path: <netdev+bounces-211742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2761FB1B6FE
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 17:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CE851653D0
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 15:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E744923F295;
	Tue,  5 Aug 2025 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sVvo6Hvj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B88E13B58A
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406151; cv=none; b=GeBbzK4Z0gZ6oVWxVl3dBpsh8ApwArq4SEArvBvU9+oUtHdWU5bsvhCSp+myrzwVbZYmqw0CDA0se+wDxwBB/ZWXrrmlYL6Y/jywetc/Ugt/3tLsRgjXbKkAmPAo43/xqdxKs6smqYcf6AGsaOAGeSXoLFbDwVD+Ldsgn+0S1aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406151; c=relaxed/simple;
	bh=l+KKV8yNCDWGz4aojCC6AEgST+IeHB2vQrGF5ElRnKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2KwYrhX3+h5jE9L8azvWK4awKupH46GWofcVvh17iHIxchn+sNWxjjszBd8Xnh3ASdagZuus6TVrmONjkXfrWP5B3EuD40QAkNw0Lv+fLSNCl54T6M5CnoBF+v6oCoEBUsk9JqkYIlGesEumUuBL49eMP7ssACBHd3Jvr8ayPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sVvo6Hvj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QzGse9mKnJs4fqGvB5U+DSoz52qWSDo3NJf8dxHcs4Q=; b=sVvo6Hvj7V4ADGp9E0a0mMD8s3
	iaHCb3hQZsAL7Nfr6EBzA/6nwGq/vtIkOWDlBx7sFq9xELn6wDnXECRBLwAA8SpdqUDD3IFzapIyk
	5OVFnJMviL2N8awMriUr3Rv3vNkaFgnZiQdnjrjrxbiDY1eKpHDqt4jTrYJrFRjaOM+0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ujJAj-003nfq-4I; Tue, 05 Aug 2025 17:01:49 +0200
Date: Tue, 5 Aug 2025 17:01:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, m-malladi@ti.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: ti: icss-iep: Fix incorrect type for return
 value in extts_enable()
Message-ID: <7140f850-dd56-4d97-90b9-9c85494dc1a3@lunn.ch>
References: <20250805142323.1949406-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805142323.1949406-1-alok.a.tiwari@oracle.com>

On Tue, Aug 05, 2025 at 07:23:18AM -0700, Alok Tiwari wrote:
> The variable ret in icss_iep_extts_enable() was incorrectly declared
> as u32, while the function returns int and may return negative error
> codes. This will cause sign extension issues and incorrect error
> propagation. Update ret to be int to fix error handling.
> 
> This change corrects the declaration to avoid potential type mismatch.
> 
> Fixes: c1e0230eeaab ("net: ti: icss-iep: Add IEP driver")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

