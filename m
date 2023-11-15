Return-Path: <netdev+bounces-48067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE317EC6CB
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 16:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDCFA1C2091D
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 15:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA99381BA;
	Wed, 15 Nov 2023 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EIR0XTZD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1B0381A3;
	Wed, 15 Nov 2023 15:11:23 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEFC8E;
	Wed, 15 Nov 2023 07:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=i7YKZSA6qMB8/Zl3KGe4aemInnw1HDhtouL6+a5DT9M=; b=EIR0XTZDApPvJ3IE31ymgWm32u
	EFQ8dEr9BELHn6z3k6Eiinb/PA3iH+doSSEQAX22iJtRqmRYBzjNCKSDV36jaFRoXatcjV5zpaq5c
	vQM4uFfE8j30jNdkrE5rOYdAVwYlt1ugJ3bIMw5PCg37bLPw4/eiHsc+gLMWUDNHPWZ4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r3HXr-000Fmw-6Y; Wed, 15 Nov 2023 16:11:11 +0100
Date: Wed, 15 Nov 2023 16:11:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	hkallweit1@gmail.com, linux@armlinux.org.uk,
	robert.marko@sartura.hr, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH 3/9] net: mdio: ipq4019: Enable GPIO reset for ipq5332
 platform
Message-ID: <e740a206-37af-49b1-a6b6-baa3c99165c0@lunn.ch>
References: <20231115032515.4249-1-quic_luoj@quicinc.com>
 <20231115032515.4249-4-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115032515.4249-4-quic_luoj@quicinc.com>

On Wed, Nov 15, 2023 at 11:25:09AM +0800, Luo Jie wrote:
> Before doing GPIO reset on the MDIO slave devices, the common clock
> output to MDIO slave device should be enabled, and the related GCC
> clocks also need to be configured.
> 
> Because of these extra configurations, the MDIO bus level GPIO and
> PHY device level GPIO can't be leveraged.

Its not clear to me why the normal reset cannot be used. The MBIO bus
driver can probe, setup the clocks, and then register the MDIO bus to
the core. The core can then use the GPIO resets.

What am i missing?

     Andrew

