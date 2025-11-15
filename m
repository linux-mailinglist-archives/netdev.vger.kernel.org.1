Return-Path: <netdev+bounces-238891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AAEC60BAE
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 22:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5BF23B3AEC
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 21:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A1F257844;
	Sat, 15 Nov 2025 21:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rMLHQUEi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F651A256B;
	Sat, 15 Nov 2025 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763240919; cv=none; b=ByO13bxYimdhEIaw5Tnpde6DdXKA+K5XCKeuwP9T4NGXPa466A66pIW5+8OZT0jw+IRbVSRRNxSSUEPJ+ZaXLnQOYG8V78jEkNrdEHoRhNxrGJ6uft2z6JXyHVhatad3MgJAlP7iNJzCqyFdosRoWPgAcyJC5mHp+1cKHFgoakc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763240919; c=relaxed/simple;
	bh=JrUmzbpT7hshDrSRW07pHmYBu3wHOEJ/MNkWENAIBWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCUzFUZdujLdSD4HmyNd5p97Ofv0iyQnehw1BKXGN31FnrRppWjDkTxF4oEezdZ3VZNKeiK6jWVsjxnBkSKNF9m7S4Pb2Mu2Tc7B7wzk+Or4YXhtuHQg49tb859bMsbPiP2u4zG/p2gfwKQLHHu+Avg/FvI2V3Uo+jtVXY8UwpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rMLHQUEi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TAHKZHDBYWaKN+9z8GE0EBzEAgkLP88krH4g5YdlDis=; b=rMLHQUEinpnN2QsteMc1lUZaHJ
	ZXijh2MYAGpdCIFKQuSbz6nlcL9lUsBZZ1w57OocPD0tjgXQC2UVBzXJg0D6byYAHh7I7py33X+4q
	gWcSTQtygTxis6AYyoIuBeIlO0ao8iFDxMyyzRZmEvYp4PpX+4TCPTNKpLtzdWDy7FzE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vKNVV-00E76X-2W; Sat, 15 Nov 2025 22:08:29 +0100
Date: Sat, 15 Nov 2025 22:08:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: Re: [v2, net-next 09/12] bng_en: Add ethtool link settings and
 capabilities support
Message-ID: <49930724-74b8-41fe-8f5c-482afc976b82@lunn.ch>
References: <20251114195312.22863-1-bhargava.marreddy@broadcom.com>
 <20251114195312.22863-10-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114195312.22863-10-bhargava.marreddy@broadcom.com>

> +static void bnge_get_ethtool_modes(struct bnge_net *bn,
> +				   struct ethtool_link_ksettings *lk_ksettings)
> +{
> +	struct bnge_dev *bd = bn->bd;
> +	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
> +	struct bnge_link_info *link_info = &bd->link_info;

Reverse Christmas tree please. And other functions have the same
problem.

> +
> +	if (!(bd->phy_flags & BNGE_PHY_FL_NO_PAUSE)) {
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT,
> +				 lk_ksettings->link_modes.supported);
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
> +				 lk_ksettings->link_modes.supported);
> +	}
> +
> +	if (link_info->support_auto_speeds || link_info->support_auto_speeds2 ||
> +	    link_info->support_pam4_auto_speeds)
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
> +				 lk_ksettings->link_modes.supported);

autoneg is more than speed. In fact, 1000BaseX only works are 1G, no
link speed negotiation, but you can negotiate pause. Do any of the
link modes you support work like this?

> +	/* Note ETHTOOL_LINK_MODE_10baseT_Half_BIT == 0 is a legal Linux
> +	 * link mode, but since no such devices exist

10BaseT Half devices definitely do exist, and there are actually more
appearing in the automotive field.


    Andrew

---
pw-bot: cr

