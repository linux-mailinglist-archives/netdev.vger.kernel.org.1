Return-Path: <netdev+bounces-14974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE98744B95
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 00:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 327C7280ED2
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 22:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F53ADDC7;
	Sat,  1 Jul 2023 22:19:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FDE2F32
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 22:19:17 +0000 (UTC)
X-Greylist: delayed 1293 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 01 Jul 2023 15:19:16 PDT
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC291AC
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 15:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=ESQh2Q+J0+KOjCLAOqWvKR9Wn07hny/kQnYrkVfd2nY=; b=mAwVwZr09EuuZKp7Y+ECNtX51Y
	oI3ITdXfeLoYBRrKusNNTP+RcyoFKTvFyEg8vaAKa6DQ4l8cENWzCoJhljV4y1CloXdDTyRXtjnZH
	J/SNNfOAYXZXfg1vQIQbQvfEIIStc3YA63+ysm+rMCw5qWtgEmP/l8BOP+RCAa5dLbSTOz3z8Gz1E
	B4rlSZ1QcYSpSSCVFOGS0Y/8Nc6jDHOy92CtMjZ36Q83AHZNT/tHIq3pLJR3tlQQFSleuH3G+f0aS
	Vh84GN/g9VrjftL4T+mipsknLVqp7N/JG/F/zUg5BK8Fu9dzLLCERPnHv77CyYQNuyIP2QMLaLdLP
	+ebmeOeg==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1qFib4-00F8qC-PV; Sat, 01 Jul 2023 23:57:38 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1qFib4-00FE57-0Y;
	Sat, 01 Jul 2023 23:57:38 +0200
Date: Sat, 1 Jul 2023 23:57:38 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Guo Samin <samin.guo@starfivetech.com>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Peter Geis <pgwipeout@gmail.com>,
	Yanhong Wang <yanhong.wang@starfivetech.com>
Subject: Re: [PATCH v6 0/8] Add Ethernet driver for StarFive JH7110 SoC
Message-ID: <ZKChUuUpCgh/jPSU@aurel32.net>
Mail-Followup-To: Guo Samin <samin.guo@starfivetech.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Peter Geis <pgwipeout@gmail.com>,
	Yanhong Wang <yanhong.wang@starfivetech.com>
References: <20230313034645.5469-1-samin.guo@starfivetech.com>
 <20230313173330.797bf8e7@kernel.org>
 <51102144-1533-d2f7-5fde-e01160a6f49e@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51102144-1533-d2f7-5fde-e01160a6f49e@starfivetech.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 2023-03-15 09:31, Guo Samin wrote:
> Re: [PATCH v6 0/8] Add Ethernet driver for StarFive JH7110 SoC
> From: Jakub Kicinski <kuba@kernel.org>
> to: Samin Guo <samin.guo@starfivetech.com>
> data: 2023/3/14
> 
> > On Mon, 13 Mar 2023 11:46:37 +0800 Samin Guo wrote:
> >> This series adds ethernet support for the StarFive JH7110 RISC-V SoC.
> >> The series includes MAC driver. The MAC version is dwmac-5.20 (from
> >> Synopsys DesignWare). For more information and support, you can visit
> >> RVspace wiki[1].
> > 
> > I'm guessing the first 6 patches need to go via networking and patches
> > 7 and 8 via riscv trees? Please repost those separately, otherwise
> > the series won't apply and relevant CIs can't run on it.
> 
> Hi Jakub,
> 
> 	Thanks a lot, I will repost those separately.

Unless I am mistaken, this patches haven't been reposted since them.
Could you please do that?

Thanks
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

