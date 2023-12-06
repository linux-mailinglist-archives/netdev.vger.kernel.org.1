Return-Path: <netdev+bounces-54482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00F98073E0
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 16:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934FB281E82
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 15:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA6C4596A;
	Wed,  6 Dec 2023 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XZA5LCAp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F43C9;
	Wed,  6 Dec 2023 07:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=if2j3C6d/+pnayeOlcBvMhQM4c/lS7P9IrW3mrPNswo=; b=XZA5LCAp4+fwMZshvtTDOiUL36
	eMKdjVkMDzCqoD7bsFLtqytEMpeGiRlmA2Fxhp6zNNS2Dpcrot+1S4422F6GOcuY9BHLdMmnAGjwB
	trMc05URJQxwXtFjWpf3EhJUX9n7hQYtZXVnmQXiE/HiaZWzs1no9x3iKWW/TzWK/+VM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rAu2l-002Dmu-7l; Wed, 06 Dec 2023 16:42:35 +0100
Date: Wed, 6 Dec 2023 16:42:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Danzberger <dd@embedd.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: move ksz_chip_id enum
 to platform include
Message-ID: <dc8926e8-0a73-48f8-894c-781292390929@lunn.ch>
References: <20231205164231.1863020-1-dd@embedd.com>
 <20231205164231.1863020-2-dd@embedd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205164231.1863020-2-dd@embedd.com>

On Tue, Dec 05, 2023 at 05:42:31PM +0100, Daniel Danzberger wrote:
> With the ksz_chip_id enums moved to the platform include file for ksz
> switches, platform code that instantiates a device can now use these to
> set ksz_platform_data::chip_id.
> 
> Signed-off-by: Daniel Danzberger <dd@embedd.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

