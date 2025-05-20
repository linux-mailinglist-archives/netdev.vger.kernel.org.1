Return-Path: <netdev+bounces-191738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B3FABD01E
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 09:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B6137AB0EB
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 07:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB92225CC63;
	Tue, 20 May 2025 07:15:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331A91E835B
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 07:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747725300; cv=none; b=pS6XNsdvQHhy1i1Fdmwas+y7i4wBZarunvvuKJK6YlO/l7JaKHxjCREjQcVW9hUmrxk0Lnp7ZdcldK91U8wqKXw96HIxE1g6awLYGFqoTLQ0e2Tcyf5r9yu2b+iyyFJgtsiFHj0Y5tc4ZsGsEL1B2cKqGtfU3/M2yM7lHzpn4xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747725300; c=relaxed/simple;
	bh=IREzv80m5j72e6q/zzFa1rPtZf6iahZwyOMbpZH3OAI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=QjovhTG3s+Ysd3pe+5SFnajDxZrVKmwolAi5EYFXi7JdL8MSq+X4gkY4aG9XwhQG6oeXHvR8U6bTs1tZv/zzZnZtrbayGqkdCPTxEbK7W6ofmKJm+FBMh33DDCGPIQVtr9n/l23pDGf1gcNwgBazHgKnP7toipo4yyzg+1el/QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas2t1747725188t309t38978
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.119.67.87])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 17508635450058569679
To: "'Simon Horman'" <horms@kernel.org>
Cc: <netdev@vger.kernel.org>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<richardcochran@gmail.com>,
	<linux@armlinux.org.uk>,
	<mengyuanlou@net-swift.com>
References: <20250516093220.6044-1-jiawenwu@trustnetic.com> <CE302004991EAA2C+20250516093220.6044-10-jiawenwu@trustnetic.com> <20250519155833.GI365796@horms.kernel.org>
In-Reply-To: <20250519155833.GI365796@horms.kernel.org>
Subject: RE: [PATCH net-next 9/9] net: txgbe: Implement SRIOV for AML devices
Date: Tue, 20 May 2025 15:13:07 +0800
Message-ID: <003c01dbc956$a2d65ed0$e8831c70$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQLk1vtdni3YVMko5U2XFdZqSkSF9gIMBpUIAflaBqexqMuyEA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NRkWGnbnkwTmq/z9esaQnaUXnzjSOCyQMHg8X7fzOMHXQSJ1dR1hoC+C
	hwjzm8HRaibuY/ytbHIRdxgP2me4n5EWsLPHTAAjdv2CN7vjqFvKV+2rL0jCUgyVblv09Lg
	wd1opvcgF6M39KVe47pSX/5A24LI7sVMIgiWz8vDF9XgCwKuoBYzBriAGCl7VOC4mbzdIx1
	uN/LKO4fcvU5ovBjORuWhRQkrjjnJ7nYGplt1G1NOcTw3x612pA1J75rjidNS3nKwrm9Lvk
	W+oM6Hivvp2fsc4S5qTM3S592OCEkmN9o+BFD6A/jre9yWI7HTCT4WRd0npbs2bR8VOldj7
	l2Bp1qtUL5P2YLskIJlDCZE57nil73KNKgq4GlaX9AQmZZM1reU3qpNPAAgoxyFygGOVJ5k
	sqZAZn9gZW5Cnb5ImKNwa+Qr9icLkIikaeE+UdZBvKBtdDFBDS63Nc+9MhZJESCRVx3gNxj
	bq9ms/pVqlov64NfhI0sWBy2FIDOzmsUkXI95Y7VBO16Z2OrA1ItuzNGH92SZF+ypfbRrqW
	qubdbY2JJvQW4TkI6Cv58X6Tq8xDI2VwzWLcht9BEP8YEEZtoalJPYGBjs50SdOyAqbVS05
	S+08mLO/Mr+HYMnIYGSh1j8RgFBK+iW6Bzhb8TtDpxIlSoTxrPFEeyoEQZ/0QifxPPOhSiw
	2yoYG0Dk7Nbw9+XZTbUu5r9lCVEoxtXbD+5juAXwyToIBoDv1Mu7HrJ1XnJCWvL5h3Zo29k
	ffngIWwH5XMV5EjjhQPu0BLgU9nlux6Hc6ltEp0rNulpeTgsVX5YE/+OjshMcvRMrhK0QDv
	sY9lMf9xNttZPwBUYchbHVb8jpEhE9rXHRTSPNd39qdBUgczWEAN0Aja2VmwclCTCA7cxX5
	tiNm8Ra7kU00G4Za/CmAm8EyGfpFWXprGhiX9Ulr1Vvrmd6ZlYv+W4H+u0uurT4rqHbrtZx
	sDmpu2KtWexKuYO2HHOHyeJa00HYya8VeuvF8DuGAQOTeUfERHlribXW+4qLp8NkAG9SED9
	kPAs2bXQlOLl9Kt56vTsXaHtysctk=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Mon, May 19, 2025 11:59 PM, Simon Horman wrote:
> On Fri, May 16, 2025 at 05:32:20PM +0800, Jiawen Wu wrote:
> > Support to bring VFs link up for AML 25G/10G devices.
> 
> Hi Jiawen,
> 
> I think this warrants a bit more explanation: what is required for
> these devices; and perhaps how that differs from other devices.

For the chip design, the PHY/PCS attached AML 25G/10G devices is
different from SP devices (wx_mac_sp). And the read/write of I2C and
PHY/PCS are controlled by firmware, which is described in patch(4/9).
So the different PHYLINK mode is added for AML devices.
And for this patch, the SRIOV related function is added since the functions
.mac_link_up and .mac_link_down are changed.

> 
> >
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > ---
> >  drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> > index 6bcf67bef576..7dbcf41750c1 100644
> > --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> > +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> > @@ -10,6 +10,7 @@
> >  #include "../libwx/wx_lib.h"
> >  #include "../libwx/wx_ptp.h"
> >  #include "../libwx/wx_hw.h"
> > +#include "../libwx/wx_sriov.h"
> >  #include "txgbe_type.h"
> >  #include "txgbe_aml.h"
> >  #include "txgbe_hw.h"
> > @@ -315,6 +316,8 @@ static void txgbe_mac_link_up_aml(struct phylink_config *config,
> >  	wx->last_rx_ptp_check = jiffies;
> >  	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
> >  		wx_ptp_reset_cyclecounter(wx);
> > +	/* ping all the active vfs to let them know we are going up */
> > +	wx_ping_all_vfs_with_link_status(wx, true);
> >  }
> >
> >  static void txgbe_mac_link_down_aml(struct phylink_config *config,
> > @@ -329,6 +332,8 @@ static void txgbe_mac_link_down_aml(struct phylink_config *config,
> >  	wx->speed = SPEED_UNKNOWN;
> >  	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
> >  		wx_ptp_reset_cyclecounter(wx);
> > +	/* ping all the active vfs to let them know we are going down */
> > +	wx_ping_all_vfs_with_link_status(wx, false);
> >  }
> >
> >  static void txgbe_mac_config_aml(struct phylink_config *config, unsigned int mode,
> > --
> > 2.48.1
> >
> 


