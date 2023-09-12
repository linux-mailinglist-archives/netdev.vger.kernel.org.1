Return-Path: <netdev+bounces-33218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BACA279D0BA
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 14:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D1C281238
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 12:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5151803C;
	Tue, 12 Sep 2023 12:07:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933469443
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 12:07:25 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D7A10D0;
	Tue, 12 Sep 2023 05:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sgzBNOAWFKoowxyC05sVul7gVRvqwao9EVd/Og49pRU=; b=yEDTjDA8sU308ewOW6gaFkgd3x
	z2OoyevlGR5HvPphDokC2bAd7+BgOjgTEvEbiI8ppMW2JrVgsEZrfzpPLpMoG7X3DCL9pvdf0rYfx
	bPxKLw1PSSktabPZS1LvNNMUUPNkEalgo4vcOJ+VyweygvRIDSnYG/+8fQEvvGkbrveE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qg2Ag-006Dqs-BU; Tue, 12 Sep 2023 14:07:10 +0200
Date: Tue, 12 Sep 2023 14:07:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: kuba@kernel.org, piergiorgio.beruto@gmail.com, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, horatiu.vultur@microchip.com,
	Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
	Thorsten.Kummermehr@microchip.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net v2] ethtool: plca: fix plca enable data type while
 parsing the value
Message-ID: <f7d8ec5a-eb65-433e-aeb1-8fd16e5c8cd9@lunn.ch>
References: <20230908044548.5878-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908044548.5878-1-Parthiban.Veerasooran@microchip.com>

On Fri, Sep 08, 2023 at 10:15:48AM +0530, Parthiban Veerasooran wrote:
> The ETHTOOL_A_PLCA_ENABLED data type is u8. But while parsing the
> value from the attribute, nla_get_u32() is used in the plca_update_sint()
> function instead of nla_get_u8(). So plca_cfg.enabled variable is updated
> with some garbage value instead of 0 or 1 and always enables plca even
> though plca is disabled through ethtool application. This bug has been
> fixed by parsing the values based on the attributes type in the policy.
> 
> Fixes: 8580e16c28f3 ("net/ethtool: add netlink interface for the PLCA RS")
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

