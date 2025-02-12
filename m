Return-Path: <netdev+bounces-165345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2F7A31B8F
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FBE9188730D
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 01:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01366F30C;
	Wed, 12 Feb 2025 01:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="w2T8hvBR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD4E4D599
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 01:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739325123; cv=none; b=Vc5aAlZutRQzZoJOk60/EcbG+pSd/bsvw3wJgoK5J2W8odPrygPyB7N1AEvQ6om7WecQXFNDBx2BsK97W71QfVJT5PoABpopRNV3RmNrsp46DU+uHJBHQ7dCNcQUSEkAH/kOFly85Pj8iMsSSWzTy5rJoSLLLLHSl4+u8ffmOk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739325123; c=relaxed/simple;
	bh=Nkmsxy7dfk/7ulvMydVUkGQRi8Gx6qkF7wxR6DNPwsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1+SczuCRnDq+soObhFDVLyotwWHlWiw2uc3KjLmc/jeFJ9H2KVI8CyLcykqH3NPSeGCcdfQ6/FLRQypuTw1kRzgEAY0pkFPQd8RZza/WAgCN10MZc63mshvpn7ThvNncwXj/RvNS43/N0pTlbmrwYEj9v/RGOmHZprHp09Snow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=w2T8hvBR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bbsaVIqQ+Ve5Pnd0fkoBna9CLxTb77qTLLUBjBjUkKg=; b=w2T8hvBRa1RyRnE0M32nGW1Yrl
	x/vomA6bfqx5zB0E0z63ASlTpyCBv4/5eSVBbcKUujLlPbJ+DyIKq6oV/NuiQUIchfBsGut5X8ohV
	wi0lOUgcdg0UqqrFl735CA6mbBL3Wyz8annGmuJ3wYbAq8+P6jSpDTngkKmnu/Gvn9CA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ti1us-00DF6X-Qk; Wed, 12 Feb 2025 02:51:54 +0100
Date: Wed, 12 Feb 2025 02:51:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6 3/7] net: phy: micrel: Add loopback support
Message-ID: <e52245af-7429-4e86-b7f2-475a7605a47f@lunn.ch>
References: <20250209190827.29128-1-gerhard@engleder-embedded.com>
 <20250209190827.29128-4-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209190827.29128-4-gerhard@engleder-embedded.com>

> +	ret = phy_read_poll_timeout(phydev, MII_BMSR, val, val & BMSR_LSTATUS,
> +				    5000, 500000, true);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

This can be simplified to jus

        return phy_read_poll_timeout(...);

    Andrew

---
pw-bot: cr

