Return-Path: <netdev+bounces-28144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0B477E5A9
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 17:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB61281B52
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 15:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC9716415;
	Wed, 16 Aug 2023 15:52:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD1BC8FF
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 15:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891AEC433C8;
	Wed, 16 Aug 2023 15:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692201131;
	bh=TIjmNB9p3Z/mYIestCCsQETqQqkBVHq59rkmx1l98tA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NmQqVHOpb7712AfKgM+B5SW3Twh3u+wfuMdaMR2kdraPNtxc51ZTVcveQS/KsnlI7
	 z5d8o/ARnKgq2cHsoOamkNT7PcIXW/dfBNvMYNyE17sOZpCv6JH9zLXj+iR1RzH6sN
	 +10ByFqwsvqIalj7HygKCrPScZ1NhSqy9RBtaYuTNq4Ne4eaw7lf3qy2TR+8Xwdh7q
	 oVzdbYk5sIhqrwe7MxDX8MuALkWgLbeVCqO/RWvXIJpuvPF6YHTuq2MJQE22mCN4LB
	 j7y0XTEuhaZd+4mqnlR5YrS3t/2aTcEC+Wfu0Q2OvoL/FuzYabSBlIEIH4Jsbc0/qn
	 EverZ1UpwQCnw==
Date: Wed, 16 Aug 2023 23:40:25 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: "G Thomas, Rohan" <rohan.g.thomas@intel.com>
Cc: "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"joabreu@synopsys.com" <joabreu@synopsys.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"peppe.cavallaro@st.com" <peppe.cavallaro@st.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH net-next v3 03/10] net: stmmac: mdio: enlarge the max
 XGMAC C22 ADDR to 31
Message-ID: <ZNzt6cP9fVnGZe9d@xhacker>
References: <DM3PR11MB871491A357B9A12BF1B0CC82DE16A@DM3PR11MB8714.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM3PR11MB871491A357B9A12BF1B0CC82DE16A@DM3PR11MB8714.namprd11.prod.outlook.com>

On Sun, Aug 13, 2023 at 02:18:27PM +0000, G Thomas, Rohan wrote:
> 
> On 8/9/23 18:50, Jisheng Zhang wrote:
> > The IP can support up to 31 xgmac c22 addresses now.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >   drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> > index 3db1cb0fd160..e6d8e34fafef 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> > @@ -40,7 +40,7 @@
> >   #define MII_XGMAC_WRITE			(1 << MII_XGMAC_CMD_SHIFT)
> >   #define MII_XGMAC_READ			(3 << MII_XGMAC_CMD_SHIFT)
> >   #define MII_XGMAC_BUSY			BIT(22)
> > -#define MII_XGMAC_MAX_C22ADDR		3
> > +#define MII_XGMAC_MAX_C22ADDR		31
> >   #define MII_XGMAC_C22P_MASK		GENMASK(MII_XGMAC_MAX_C22ADDR, 0)
> >   #define MII_XGMAC_PA_SHIFT		16
> >   #define MII_XGMAC_DA_SHIFT		21
> 
> Recent commit 10857e677905 ("net: stmmac: XGMAC support for mdio C22
> addr > 3") already addressed this in a different way. As per Synopsis
> IP team until version 2.2, XGMAC supports only MDIO devices 0 - 3. An

I didn't find your patch in mailist when I submit the v1 on 23 July, in
fact my series was earlier than yours.

> XGMAC IP version check is newly added for the same reason. I think this
> covers your commit also. Please have a look and if so you can drop this
> commit.

Dropped in new version.

> 
> BR,
> Rohan
> 

