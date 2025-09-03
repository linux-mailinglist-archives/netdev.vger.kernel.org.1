Return-Path: <netdev+bounces-219533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49E2B41CD0
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 13:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB94D7B675F
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 11:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6AC2F6197;
	Wed,  3 Sep 2025 11:13:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1875A2F3C30;
	Wed,  3 Sep 2025 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756897987; cv=none; b=gvLP9bmHgCtMRPYCKtp6OISt8FbbHqSLkpaiFcAixUNdFzVr9kI0TUu5q5kUF144IasGo9b3l0+rRrHvCiBnyQl4rfmR9qfI+ZpyNAz/bgg5OdR75tLHOHXcRvdk/JFCBwYtUl8uCU3QpO12SLNXtJI2pLKhiGrQTCS8sLr3ZSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756897987; c=relaxed/simple;
	bh=N0yivW7jn5Z1mSvRMYL2rfNdR6UowqDDRKNUcCxzqDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJovjDfe7K2GQrvEADUtmwU2hAGVr2fvSRM8m9+GF7/wMD4yqPZpn56l+UlHIjW4jkGkIn5WvKAJmMUFOTK9ifnSFDm5dYrMCQIlHwqQcoOO59ji2P+DsUBx1drAMrluSl4G0m2h6EEDhwYXJYuM6yqXpqBHQO9pPsscW95ZVXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz9t1756897959t4e03ebef
X-QQ-Originating-IP: VAJd5pQQJ95oN8rLwlsllTxtAVzAMd0qsfyejqsVvQM=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Sep 2025 19:12:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7229933252128610487
Date: Wed, 3 Sep 2025 19:12:37 +0800
From: Yibo Dong <dong100@mucse.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, rdunlap@infradead.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v10 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <9156A3C8F1EFA452+20250903111237.GA967815@nic-Precision-5820-Tower>
References: <20250903025430.864836-1-dong100@mucse.com>
 <20250903025430.864836-4-dong100@mucse.com>
 <be2b4af0-838e-4c7c-bae1-e74c027ad8fe@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be2b4af0-838e-4c7c-bae1-e74c027ad8fe@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NyqG2qnv0b2dYadHGYP9NPa/HLNq7YepKwQplj7J45c74QKUcuy2o97F
	j+w03XTV42K6QaDjmtixLFOmHTtzBTo12Wxjz3RhFAogP7IqO2rVCLz1+WK5bkc2IzJ8n8W
	5rKtWxnVvLSLdTpmZCM2PVi2iFxpKaPREh4kQr9qh6wlpiRm15J4s06YeYW/4pm+DsFV8iH
	EnSmMxyWdpJFtOKo/dbw9bVKP6OFUXp8ZuuYHsOzbiKgDq+a48eZmoxVXZPLhRylUyufD/i
	QKcXDRnZwYCCnwPQl1k9u/qNNa4pIAE8Q9T5lczEeXJieyggkQ4glaBo/FRA3iHtqEzDFfy
	4xD/LWFvKkITp+nUYaTAr7R2iBabueU7YzmVMZu6Ghh77hFRBFm3cfV9kke1SE13gFlvAh1
	bgCuru6gr9lNT6pgCb6eU9dv8i/zzScFsjmsW82g3BRQZVVNJdMDoySK22n5HxEV4hbxbKM
	qcf3kVOMNRPNBLUIMfpZCTZlpJjdMAIbu6713pCdIUWDKCkzLlV4joWgSj6Hm6wlw38uVnk
	Jv0bBiIquzja0fJ6Eaa0Eb4unKGpwu66u2oFhs7LoHf3n3UccAsPon2dYCtmYLg65+0bagR
	rLuRKQz7vFcp/2GW75xVgCS7quNruMuAppalqY85C+d70TBxF4DswSqiJqNBRq4JbK9aLUp
	y40a1qpe+Op2YDUyMZPDPNNF+Kp7H8/worV6eLiyuwiImAtTZg7W4MYhxuNkPi4LD87HC2B
	FJGKIZdHtaEdlGZzeumeXN677376+0VQHAUrPkLWTBDR6h4vR6nY/fKVjybxdGHNFv60tam
	WWB5sojP+8IgA+9rHULk2V15z9Q2Ai8cIBwoEGpqQZ3fNvnF0DhzuPzmc2Edjhcu1L0uNhy
	8YwMm3DZCRkYCcPJiq/+72I2ldtBfsgrN+VDJ1By1VkrNma2vDaZrfUXwSorUugEymecC8Y
	1k6aN9lqpb3S1DV8Esrun1Wg4wSrdso5HlnjaXoEtGUPtcXjw0nvYxaQzS3+aOBOB5bnUg+
	kAHK3G5w==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On Wed, Sep 03, 2025 at 11:53:17AM +0100, Vadim Fedorenko wrote:
> On 03/09/2025 03:54, Dong Yibo wrote:
> > Initialize basic mbx function.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > ---
> >   drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
> >   drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  16 +
> >   .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |   3 +
> >   .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 393 ++++++++++++++++++
> >   .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  25 ++
> >   5 files changed, 439 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> >   create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
> > 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > index 179621ea09f3..f38daef752a3 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > @@ -1,8 +1,11 @@
> >   // SPDX-License-Identifier: GPL-2.0
> >   /* Copyright(c) 2020 - 2025 Mucse Corporation. */
> > +#include <linux/string.h>
> 
> I don't see a reason to have string.h included into rnpgbe_chip.c
> 

You are right, I should add it when it is used.

> > +
> >   #include "rnpgbe.h"
> >   #include "rnpgbe_hw.h"
> > +#include "rnpgbe_mbx.h"
> 
> I believe this part has to be done in the previous patch.
> Please, be sure that the code can compile after every patch in the
> patchset.
> 

You mean 'include "rnpgbe_mbx.h"'? But 'rnpgbe_mbx.h' is added in this patch.
I had compiled every patch before submission for this series. And as you
remind, I will keep check this in the future.

Thanks for your feedback.


