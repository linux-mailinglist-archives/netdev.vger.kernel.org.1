Return-Path: <netdev+bounces-48459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F177EE67D
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 19:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E051C20A60
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 18:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C417D35883;
	Thu, 16 Nov 2023 18:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="foy417+0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795921A8;
	Thu, 16 Nov 2023 10:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Dy6raJ/CUfjvTNheXRnlkCtCUSg34o+Shs1RwXwxo50=; b=foy417+0rwd88OmjIiXATRdbnM
	ebmY3QKC+9RcmTTKlAaWak/su2hkQZRHoLIkH9q7qaah/Oedanah7hl3YJYYeZPDwZ2B1wKlXmd9c
	cFXJGupiyyk4jm1MdT5u0lxJM/W+vwMS7hAc/yumY+702JR9NA5FULiSMAvSlTjVRm00=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r3gqR-000NVy-Iq; Thu, 16 Nov 2023 19:12:03 +0100
Date: Thu, 16 Nov 2023 19:12:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Conor Dooley <conor@kernel.org>
Cc: Luo Jie <quic_luoj@quicinc.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	corbet@lwn.net, netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 2/6] dt-bindings: net: ethernet-controller: add
 10g-qxgmii mode
Message-ID: <739c89ec-739e-4c5d-8e42-88ed9a89979b@lunn.ch>
References: <20231116112437.10578-1-quic_luoj@quicinc.com>
 <20231116112437.10578-3-quic_luoj@quicinc.com>
 <20231116-flier-washed-eb1a45481323@squawk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116-flier-washed-eb1a45481323@squawk>

On Thu, Nov 16, 2023 at 02:22:41PM +0000, Conor Dooley wrote:
> On Thu, Nov 16, 2023 at 07:24:33PM +0800, Luo Jie wrote:
> > Add the new interface mode 10g-qxgmii, which is similar to
> > usxgmii but extend to 4 channels to support maximum of 4
> > ports with the link speed 10M/100M/1G/2.5G.
> > 
> 
> > This patch is separated from Vladimir Oltean's previous patch
> > <net: phy: introduce core support for phy-mode = "10g-qxgmii">.
> 
> This belongs in the changelog under the --- line.
> 
> > 
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> Are you missing a from: line in this patch?

You probably need to use git commit --am --author=<author> to fix
this.

	Andrew

