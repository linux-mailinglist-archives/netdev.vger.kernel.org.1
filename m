Return-Path: <netdev+bounces-51130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1D87F9490
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 18:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 571A9B20D0A
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 17:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D4EDF59;
	Sun, 26 Nov 2023 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M/LA8+g7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21B3110;
	Sun, 26 Nov 2023 09:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nC4aon5pk2Vddavk+mkBxpEuRFmqGyzcXmmWB7ni2oM=; b=M/LA8+g7GXkNi61k1cK6A8J7k3
	lQyLAGvDL8QmB6c4MwkWgGMTNkFt6IMDwPwcaaE6LjC8ZSU+ZPZ55nEUrQJl7VMXwzfZrH0wiksJb
	+bVa5VzvMM0LnakJBKtdrCXz8k9w0EF8K+ynBzJ8QIq1zP+QdcC/8j7yNLgSgq8QO7cw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r7Io6-001GFd-RX; Sun, 26 Nov 2023 18:20:34 +0100
Date: Sun, 26 Nov 2023 18:20:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	hkallweit1@gmail.com, linux@armlinux.org.uk, corbet@lwn.net,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v6 2/6] dt-bindings: net: ethernet-controller: add
 10g-qxgmii mode
Message-ID: <ddcb358c-e26f-4deb-8bde-69421f4a4e28@lunn.ch>
References: <20231126060732.31764-1-quic_luoj@quicinc.com>
 <20231126060732.31764-3-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126060732.31764-3-quic_luoj@quicinc.com>

On Sun, Nov 26, 2023 at 02:07:28PM +0800, Luo Jie wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> Add the new interface mode 10g-qxgmii, which is similar to
> usxgmii but extend to 4 channels to support maximum of 4
> ports with the link speed 10M/100M/1G/2.5G.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

