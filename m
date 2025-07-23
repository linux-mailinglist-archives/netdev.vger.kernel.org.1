Return-Path: <netdev+bounces-209186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 858D8B0E8F7
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 05:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6ED71689DF
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 03:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BB81F3FDC;
	Wed, 23 Jul 2025 03:08:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4201F2382;
	Wed, 23 Jul 2025 03:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753240123; cv=none; b=dP6+r+6mDJUSBVHfb+YeuU9AniCwfakdDklUsFAAS++ACJlkp/M3KsZVTYPKKgNTG0JGuQkwdsyBs8DlMwMERlflH29HLHStuKEk9MhnRwTI9fo0kspetZBjmf0V3wSMviKfI34n2u3Fvx2eIsblwNlxMSZPChCcZfZaAja9a7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753240123; c=relaxed/simple;
	bh=2yg9SG0vvIlVvlZR8JpUpVQxNLZGjH6tRGJV9TpFhS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmfbenEgT9djIEuUfWjy//LIzYzxu9SalOH3uTLIS06REvhf655Kiy4VFvSy3CdI9nWBKENJROpBtfaA8V85GKBfqutlIziUFhXcu4G77kUyZGPO0fXYi7aAK/YSMiengk25XGV2pNJGR+Zao2t8pEq0KknXAY8LcRtWxxXp6po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz5t1753240028t6b29edfa
X-QQ-Originating-IP: NT9ZibIvYk5fNjjauD+gBPoL+YaRUZQrmD9vxnv86+c=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 23 Jul 2025 11:07:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1109793005909151533
Date: Wed, 23 Jul 2025 11:07:05 +0800
From: Yibo Dong <dong100@mucse.com>
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/15] net: rnpgbe: Add basic mbx ops support
Message-ID: <78BE2D403125AFDD+20250723030705.GB169181@nic-Precision-5820-Tower>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-4-dong100@mucse.com>
 <20250722113542.GG2459@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722113542.GG2459@horms.kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NfRA73Gayti6CGR3D1JlkQ2+KrsmWAYUkl9H1DK2aWmQSQG72lYm2EAN
	c74TwYi0o7kfSFslwYgeoZ1xr59cgDC6dPMbyFHs6TRLmCwdQL92FKAV86JFgzXpOEGQPG3
	hYORMAZoQ5i1Ry7crHDGuJ+7hMyK695lpI3EERR6k8SEahkTO7/SvyWj6nk0mayMYnPnRnB
	kXod5ud4dV/EHkHz4prcgLPsVrSl29qjZiWj+vt57o2Q1O/PCbPw6c5KOufwWbvDbEjeJjb
	JAiky/PNwJDTJmhnltdFwuUsVYukv2p009jT/jFobZzu62wg7c2KwNJ2jX5fFafGPpqa0KU
	EDgpwHv+7cVtExEh4OWe72jTVP6pUatXNyfEX5DFDqQYBjveDo7oDRGEokrucC+p3/VvtZD
	ap+us0yG9zjn82ojSkpCX8PrSWOM1+Tj/hy1YnwvQ9mhd1U6iiFGVUfrB6GTk4xGLZ6B1wn
	HM+HzoKXKJtsy7SRCHy4yi3Nwbln1cw4668c2y4lI0CsdmHVQmyrQDxnBV2/2kigLO6BKUk
	07RA93rerTcZ0GaxzOdX9lxZorS6uuI7JGL2sI5sTKhuQkMGdkPVebDXN5lqaHDrWIIrolq
	suUv0E1e7D+ViTpYbanopYYzanDGxkech3MEDVJdePoEL9mFTYby9Z3oidcrfhTovzR+uRX
	q/Q119vfIQpzB8LSw60w9XrZj5zDYUp38RjPwxe4teSR85Ry+vB+kwOPoFSlVwvySfCe5XG
	alQd+eS10ESGwtAKgWKTHR8Q6235E0Yty7DgP2rJknKhEudDq59BfJ0mp9RNnDFmCf2r1/4
	UHbc/PGv+tGACOFqWMvZpjdCLZDut/O7Z5YmZnSc4b+pPS+86zcc3VjDpeMJXC3TywpGsP1
	EsUlROYSyTsKwOk2JJ2QQSCjy6oBbRd/GBvZ/W0CmgZ6TNSrd1DbMnXByxeudFkCL0/JNXq
	Z1S2NLLmnAKt/8w9perumQmHPghxw0rOqnqREbhCRyu/FnbvYdno7QdaPJ0txR3X6CvJxtE
	VyIKhk8Q==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Tue, Jul 22, 2025 at 12:35:42PM +0100, Simon Horman wrote:
> On Mon, Jul 21, 2025 at 07:32:26PM +0800, Dong Yibo wrote:
> > Initialize basic mbx function.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> 
> ...
> 
> > +/**
> > + * mucse_obtain_mbx_lock_pf - obtain mailbox lock
> > + * @hw: pointer to the HW structure
> > + * @mbx_id: Id of vf/fw to obtain
> > + *
> > + * This function maybe used in an irq handler.
> > + *
> > + * @return: 0 if we obtained the mailbox lock
> > + **/
> > +static int mucse_obtain_mbx_lock_pf(struct mucse_hw *hw, enum MBX_ID mbx_id)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	int try_cnt = 5000, ret;
> > +	u32 reg;
> > +
> > +	reg = (mbx_id == MBX_FW) ? PF2FW_MBOX_CTRL(mbx) :
> > +				   PF2VF_MBOX_CTRL(mbx, mbx_id);
> > +	while (try_cnt-- > 0) {
> > +		/* Take ownership of the buffer */
> > +		mbx_wr32(hw, reg, MBOX_PF_HOLD);
> > +		/* force write back before check */
> > +		wmb();
> > +		if (mbx_rd32(hw, reg) & MBOX_PF_HOLD)
> > +			return 0;
> > +		udelay(100);
> > +	}
> > +	return ret;
> 
> ret is declared, and returned here.
> But it is never initialised.
> 
> Perhaps it is appropriate to return an error value here,
> and update the kernel doc for this function accordingly.
> 
> Flagged by W=1 builds with Clang 20.1.8, and Smatch.
> 
> > +}
> 
> ...
> 

Got it, I will fix this.
Maybe my clang (10.0.0) is too old, I will update it and 
try W=1 again.
Thanks for your feedback.


