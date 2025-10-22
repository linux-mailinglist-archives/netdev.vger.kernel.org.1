Return-Path: <netdev+bounces-231509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0778DBF9BCF
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 04:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31DA19A63E9
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 02:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7019A21ABD7;
	Wed, 22 Oct 2025 02:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wm0+ZWk/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62FE8F54;
	Wed, 22 Oct 2025 02:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761100181; cv=none; b=Uwzip5fDChBM5Q6PK+Q/rAcfQ5uIDmtSAtMP1dl+9xy90hpxSGxnZ/0UajgOsPmQD7ZSoEgpJkUNrXdO/2G5UJKKD7kza9qraNaWZMyb3C8wOfv3ng4l82TUIWrzH0O/aD4iQ6p/sZ6lwQvoEDdUJssbLwTTodCEATwgy80AKE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761100181; c=relaxed/simple;
	bh=u7G3MSyaJJFcLqXMsW5Y3pWQLkifOfmhb13B/nbhyCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0HM9N2vO01hrIwWu9oQJ5HyJJgMlX8AB3U46lE5kir+59LM7K7oIq7UQCsziW9k8WcOBX+iFSO7p+dvk0x7w2DRqTYL07Ci+ZXrSrV2DV7Y8L1Jg/3VjyCW3ZlyGjIi1kax8QojwsIpsNAp4FuvrBRx0ExFni/toYrzLBHoFl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wm0+ZWk/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Df44MTAgxkkYPJInA2yVjdmTeke9LT+BYhNr0/13xno=; b=wm0+ZWk/Ppieg+AIXZ/mkr2ZVA
	Gi6GbovNf6CGD1cF9vDCzqI0KRkQvT1sqiKr8cGbe3pKEkbThLdjBDsGaaaFpSmzS9elbs3Q4NApI
	MS7r7gpQ31YYmvQnc3SJSpDYyK7ePAM2PtjpPNCQcDpt852YKXwznU8cj8b/MojjwDeY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vBObO-00Bhcd-N5; Wed, 22 Oct 2025 04:29:26 +0200
Date: Wed, 22 Oct 2025 04:29:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/7] net: dsa: lantiq_gswip: clarify GSWIP
 2.2 VLAN mode in comment
Message-ID: <9d0a589a-23f5-45a9-b3ab-1db10eb56af3@lunn.ch>
References: <cover.1760877626.git.daniel@makrotopia.org>
 <58f05c68362388083cda32805a31bc6b0fcb4bd0.1760877626.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58f05c68362388083cda32805a31bc6b0fcb4bd0.1760877626.git.daniel@makrotopia.org>

On Sun, Oct 19, 2025 at 01:46:54PM +0100, Daniel Golle wrote:
61;8003;1c> The comment above writing the default PVID incorrectly states that
> "GSWIP 2.2 (GRX300) and later program here the VID directly."
> The truth is that even GSWIP 2.2 and newer maintain the behavior of
> GSWIP 2.1 unless the VLANMD bit in PCE Global Control Register 1 is
> set ("GSWIP2.2 VLAN Mode").
> Fix the misleading comment accordingly.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

