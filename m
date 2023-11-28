Return-Path: <netdev+bounces-51534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D227FB051
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 04:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE3D1C20A67
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 03:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E1763BB;
	Tue, 28 Nov 2023 03:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/5Y4FwX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9716FA0
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 03:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AC4C433C8;
	Tue, 28 Nov 2023 03:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701140688;
	bh=0vxwWk/VtiJW0Rl/IFPmfADKzDSf/OCJueWE5wdyi8I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I/5Y4FwXlHyjodxNo0IyDpBLKOgRgfNrb/EIB6ikSZmOTkmzdUneCtLpBvckwvno0
	 sqHJ9px9v6GOF6B1V+jUwkkSi60XoCAeNE/8yQoH5TsAmyuBp12pmZYTKU4BZs5iQ5
	 ODgbqb5yh33cUJxuyPnWZFuSLT3sQFfdf4ieZrs+rr0fDSHw0Gc6W/FwCPdIUt2vqm
	 4cFSdenddOGYWtg2Yvze9OHaawUlbZ1c36aG2bD+PA3FE4f4SVlZMLVGrmUXtt+c9p
	 UDjbYPSFslp9SvhPEiw7ZS7RYL9bp3zRn2AsDirTKt7daJDPscV4P1hDPWboXlHH9F
	 /N7A9M4FD0hyw==
Date: Mon, 27 Nov 2023 19:04:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jianheng Zhang <Jianheng.Zhang@synopsys.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <Jose.Abreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Simon Horman <horms@kernel.org>,
 Andrew Halaney <ahalaney@redhat.com>, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>, Shenwei Wang <shenwei.wang@nxp.com>,
 Johannes Zink <j.zink@pengutronix.de>, "Russell King  (Oracle"
 <rmk+kernel@armlinux.org.uk>, Jochen Henneberg
 <jh@henneberg-systemdesign.com>, Voon Weifeng <weifeng.voon@intel.com>,
 Mohammad Athari Bin Ismail <mohammad.athari.ismail@intel.com>, Ong Boon
 Leong <boon.leong.ong@intel.com>, Tan Tee Min <tee.min.tan@intel.com>,
 "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>, "moderated 
 list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>, Martin McKenny
 <Martin.McKenny@synopsys.com>, James Li <James.Li1@synopsys.com>
Subject: Re: [PATCH v2] net: stmmac: fix FPE events losing
Message-ID: <20231127190446.58f14db6@kernel.org>
In-Reply-To: <CY5PR12MB637218C74342CCAF7AFCB85FBFBDA@CY5PR12MB6372.namprd12.prod.outlook.com>
References: <CY5PR12MB637218C74342CCAF7AFCB85FBFBDA@CY5PR12MB6372.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Nov 2023 07:08:17 +0000 Jianheng Zhang wrote:
> Signed-off-by: jianheng <jianheng@synopsys.com>

Your name and email addr in From are both different than the form used
in the Signed-off-by tag. Please fix that and repost (keep Serge's
review tag).
-- 
pw-bot: cr

