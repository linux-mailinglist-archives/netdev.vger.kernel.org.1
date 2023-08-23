Return-Path: <netdev+bounces-29857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CF3784F70
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 05:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C9081C20C19
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 03:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88B720F18;
	Wed, 23 Aug 2023 03:46:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8C820F16
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 03:46:41 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9AF133;
	Tue, 22 Aug 2023 20:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=N/VXJ1kKhYLfRCA+1Lj4YZiKmTWpyloeWrhoq+4MlaQ=; b=yUWfjTrtMjlDrJYFgzuCanW2Fa
	QH/TLa2UDxATA7CpU7uc28PW4H7pYK+G9bK6bRg04R1OABwhXIA12fsneNZfkGuPiZkOp3DBhFnmx
	/Ttgic5OC/4tMAD+snluc5K2XcYy111KxoBnhEZmftijvYig8/VWKy+1/sF3HFHsPK8g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qYep8-004qGu-Rp; Wed, 23 Aug 2023 05:46:26 +0200
Date: Wed, 23 Aug 2023 05:46:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v2 3/4] net: stmmac: Add glue layer for Loongson-1 SoC
Message-ID: <ebcd20c4-b0ba-41aa-b8fa-ad26481c3707@lunn.ch>
References: <20230816111310.1656224-1-keguang.zhang@gmail.com>
 <20230816111310.1656224-4-keguang.zhang@gmail.com>
 <c3454ad9-1874-4301-b1b1-4f76886802fb@lunn.ch>
 <CAJhJPsWVRJg7zNeXPDovkBM4pm7hD+RP21DRxt0726VXtzvCHw@mail.gmail.com>
 <150ae6c1-8a2f-4fd7-b012-a53a909919d4@lunn.ch>
 <CAJhJPsUatqsa_D_RZ8ej33cGPRixhi7A2=2VBOSJVK6xNAA0jA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhJPsUatqsa_D_RZ8ej33cGPRixhi7A2=2VBOSJVK6xNAA0jA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> I understand the delay issue of RGMII.
> Just tried phy-mode = "rgmii-id", it still works.

That indicates something is broken. Both "rgmii-id" and "rgmii" should
not work, just one of them. What PHY driver are you using?

    Andrew


