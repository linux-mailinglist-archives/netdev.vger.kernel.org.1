Return-Path: <netdev+bounces-231571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 71240BFAA6F
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 09:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1F7A4E151F
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 07:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3222FB620;
	Wed, 22 Oct 2025 07:44:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CFB2F363E;
	Wed, 22 Oct 2025 07:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761119051; cv=none; b=CkFGgPE166L1CPfiGzjRGs6r6UGj8xLP0TLhHWNXB1vDz2UulEZ86vnkyWSMBLovgp0NoFoP0SDP1oZHshYx2IkQXlsAmWIiYbozmXgePj1NwdMt41kcuAC/gjWwUu+jEMhc60vQvNGuMP115au4oUIufvulkBTA+NerVnY1VMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761119051; c=relaxed/simple;
	bh=XQx3qbe79Kfhx22bv+5o8DNEVPYQT8TWBHY8L+dYOc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rd35Ae63WhY+huhZdSmaAPu9/MByb5WFLDIVjDVjADWZm829BBsukhSEp0up4o/JI6BcI1OHUk+tq7Wd2c3QMNJgVJ6CFOmTNezakGSVtgQ7TLl0v3y5alQo1yolaZjcBd8RvUu3v59YUjOSavVmBwsIH3FKihHVzwmGaf+HODk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vBTVh-000000006x1-3nMh;
	Wed, 22 Oct 2025 07:43:54 +0000
Date: Wed, 22 Oct 2025 08:43:33 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/7] net: dsa: lantiq_gswip: clarify GSWIP
 2.2 VLAN mode in comment
Message-ID: <aPiLJXZu_BaZrYX6@pidgin.makrotopia.org>
References: <cover.1760877626.git.daniel@makrotopia.org>
 <58f05c68362388083cda32805a31bc6b0fcb4bd0.1760877626.git.daniel@makrotopia.org>
 <9d0a589a-23f5-45a9-b3ab-1db10eb56af3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d0a589a-23f5-45a9-b3ab-1db10eb56af3@lunn.ch>

Hi Andrew,

On Wed, Oct 22, 2025 at 04:29:26AM +0200, Andrew Lunn wrote:
> On Sun, Oct 19, 2025 at 01:46:54PM +0100, Daniel Golle wrote:
> 61;8003;1c> The comment above writing the default PVID incorrectly states that
> > "GSWIP 2.2 (GRX300) and later program here the VID directly."
> > The truth is that even GSWIP 2.2 and newer maintain the behavior of
> > GSWIP 2.1 unless the VLANMD bit in PCE Global Control Register 1 is
> > set ("GSWIP2.2 VLAN Mode").
> > Fix the misleading comment accordingly.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thank you for reviewing, however, you've replied to the surperseded v3
submission while v5 is current. The patches for which you sent a
Reviewed-by:-tag have not changed since v3, except for 2/7 which is now
using the `REGMAP_UPSHIFT(2)` macro instead of `-2` as a plain number.
Would you mind sending the Reviewed-by:-tags again in reply to the v5[1]
patches?

Cheers

Daniel

[1]: https://patchwork.kernel.org/project/netdevbpf/list/?series=1013992 


