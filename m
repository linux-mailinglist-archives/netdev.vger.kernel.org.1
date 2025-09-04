Return-Path: <netdev+bounces-219783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB893B42F59
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 04:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674A13B4205
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 02:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E11192D97;
	Thu,  4 Sep 2025 02:08:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5BA2566;
	Thu,  4 Sep 2025 02:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756951735; cv=none; b=hxVHag6eBEcZKetxw+xgfnjtCQ+Lex3kj9gdz7b+c0bEU+cikMNf5DnBgityl2dBLGCbmn2p6gTzztCKsRLWkoew67/DzDujD+WQufp5pOUnSgIhJ/GTo2zaGUn4RFoiDLMSyQgJiNWZedrUBmC7r8u53HgWyszXZAth+ac+QUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756951735; c=relaxed/simple;
	bh=YL+udEhqYvVb+hkB96hl3dN1ufgilHAKu0jAcG1osME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNfJa34IUQ43jLfgF3BRw5ZPln8fktrRyTRIwyYngEVlNAPtWkWAR+KD0snF4YdOk9aLYFDPVLF9n3Axxl4TzliYbIGmW7788KvvphH2DcdqGo4mL8k6gomG/EKAys9wzr2hty9GKc7buLhucg9H823SUy/PTIR70nT72qLyP6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz3t1756951707tbaada6d1
X-QQ-Originating-IP: OK09plULguSJIyt/VX69yXkyKISF9Tyqscn9kwrKVpk=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 04 Sep 2025 10:08:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1257973263119002270
Date: Thu, 4 Sep 2025 10:08:25 +0800
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
Message-ID: <34F6EA2DE6501A3E+20250904020825.GA1015062@nic-Precision-5820-Tower>
References: <20250903025430.864836-1-dong100@mucse.com>
 <20250903025430.864836-4-dong100@mucse.com>
 <be2b4af0-838e-4c7c-bae1-e74c027ad8fe@linux.dev>
 <9156A3C8F1EFA452+20250903111237.GA967815@nic-Precision-5820-Tower>
 <861c5b23-2d51-40b1-8363-67e666431251@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <861c5b23-2d51-40b1-8363-67e666431251@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NyqG2qnv0b2dYadHGYP9NPZJ1xViYibi4tW62cjiQ9AgQqnnIIphcJRX
	vaRDxu3g4YYYIYXixyIVIHNiuLYD1oEPBCM2dLREAvmmU1wXAWJ21uYqYkhCyjIxxm1W2zi
	gSy9Klrdt1H4CJ3pcb2p1QQiZzjZR4rMaIQCSILtZUg1rwujIL6aVGz3MwwmcjvSi37GpeN
	/aZDwjGCR45sOoStoE+/Xj7ipS1NiUoUcfhHBR6nVvuyOCgRhmni83SCRTIyegUNeB76v4Z
	6yI9Pd+uL8hZeLHqCx5EYBz72aJLZjgTlIZgZXNv4+VECdPMPDsuq/YRgcjQpMJoQCWsQdS
	Fq+AG8j3PSO8+MHPnqmTnCytFM4XkaiOK8C0VP/x7zRBPceGzkj1/n8pbzaT76fZY9E1c8Z
	8OmB7GQl4jJtrF08Qm+FOH7cAHwlVm+NrRvVzN6diXsd66tVOMeJb/RzOWGJDEcTAerJqU8
	7Vdc5gKz3Z8UYP2bD9I0v3nWr+j3q4wkdjgTbS9Nxt0V/tooRE2EeVsRykGGQRTue0GNjW/
	9vQAYyRZBmZuUwJFpxgXV8KRFs1IJ/hFPALqUhkKtzakdULsjVWLbDqmWAawSmB2vIZ2Cvu
	WUArBPN0K2A4qozevRj/Y6T/akvHohD/OEmnX7TnMGpq/FVgPcF9r0dJ3EZaTw3xdkzJdqx
	fy+jXV0FV029B6HcWs5t2qfTrbLF87iJr7ku9ABh4xfvYZJPkDzue5AjP3MEPMNnb9VwdKG
	ZGLWJTxj7iUTCqBCI8HcbZJxWxDfBN8wZdRZJSCJbFbe62vqnJdlmFAH2ewYA0ghP8w/NXY
	O4GvJgae/37dM8qXRja80gAlJH39Ji5JVZUFUHjAjplyXPOJvzZnhJw3KmX3oDIpsLm+lFj
	9N4wm/Typ2FxeVXA6TRjLj+LogDoNer6ED0vM8Dg7eT1yhxr6KDD1lJmq9tTsuZZQlDZ9dp
	h78yAaSR87zHpOgoikNojXFOkjW2RrJ99FviKSERYmyZMKdEkPGpzezLh
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

On Wed, Sep 03, 2025 at 01:43:02PM +0100, Vadim Fedorenko wrote:
> On 03/09/2025 12:12, Yibo Dong wrote:
> > On Wed, Sep 03, 2025 at 11:53:17AM +0100, Vadim Fedorenko wrote:
> > > On 03/09/2025 03:54, Dong Yibo wrote:
> > > > Initialize basic mbx function.
> > > > 
> > > > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > > > ---
> > > >    drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
> > > >    drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  16 +
> > > >    .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |   3 +
> > > >    .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 393 ++++++++++++++++++
> > > >    .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  25 ++
> > > >    5 files changed, 439 insertions(+), 1 deletion(-)
> > > >    create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> > > >    create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
> > > > 
> > > > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > > > index 179621ea09f3..f38daef752a3 100644
> > > > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > > > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > > > @@ -1,8 +1,11 @@
> > > >    // SPDX-License-Identifier: GPL-2.0
> > > >    /* Copyright(c) 2020 - 2025 Mucse Corporation. */
> > > > +#include <linux/string.h>
> > > 
> > > I don't see a reason to have string.h included into rnpgbe_chip.c
> > > 
> > 
> > You are right, I should add it when it is used.
> > 
> > > > +
> > > >    #include "rnpgbe.h"
> > > >    #include "rnpgbe_hw.h"
> > > > +#include "rnpgbe_mbx.h"
> > > 
> > > I believe this part has to be done in the previous patch.
> > > Please, be sure that the code can compile after every patch in the
> > > patchset.
> > > 
> > 
> > You mean 'include "rnpgbe_mbx.h"'? But 'rnpgbe_mbx.h' is added in this patch.
> 
> Ok, so what's in rnpgbe_chip.c which needs rnpgbe_mbx.h to be included?
> If the change is introduced later in patch 5, the move this include to
> it as well.
> 

You are right, I will move it to patch 5.

> > I had compiled every patch before submission for this series. And as you
> > remind, I will keep check this in the future.
> > 
> > Thanks for your feedback.
> > 
> 
> 

Thanks for your feedback.


