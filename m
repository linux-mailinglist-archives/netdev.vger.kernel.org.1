Return-Path: <netdev+bounces-221558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8860FB50DD8
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 08:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FBA1545CE5
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 06:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A89303A1A;
	Wed, 10 Sep 2025 06:08:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411F22E0914;
	Wed, 10 Sep 2025 06:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757484535; cv=none; b=pDZC3J8aJoS+jn/tlFp7P03vW3DrZ4MFBIY4owgPAtnVl8SU2Jl2wjameckBGM0Qv1wjy/6yTON6xBAfF/QO4UnEvNBrPFHiZ6dWQhwAYc1HOuhxwmhDX+uLA0SMHl7/bQ01C10AUZS5S/4YG2Zmu1owLdRUE3xLUvCx/J4Xe+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757484535; c=relaxed/simple;
	bh=KMmBva1L6oq1petJzWJQavLDOtTPnQ9KGpbg3rqed/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTCQlqpc/0rT6zlyd8mIFELa6D/ILdvZX8I9jWRifEAMEPpQ7rO1HWxPL2LSYuQleiWF4Mx29X3cMJaheowBqGiIw5aa1Ls+1vi6rofpVfVYCADyOHR9DsxFQLaRmObl11anKjI3QzAmLDtoi6Rtrw7xayT7E6lVTpQNy2xpHP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz10t1757484503t08168aa3
X-QQ-Originating-IP: Ew+8s+LzfA5OwEiNafRW2h3+9QZEiFMDofzR3uikl44=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 10 Sep 2025 14:08:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17856896380155524991
Date: Wed, 10 Sep 2025 14:08:21 +0800
From: Yibo Dong <dong100@mucse.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Anwar, Md Danish" <a0501179@ti.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, gur.stavi@huawei.com,
	maddy@linux.ibm.com, mpe@ellerman.id.au, danishanwar@ti.com,
	lee@trager.us, gongfan1@huawei.com, lorenzo@kernel.org,
	geert+renesas@glider.be, Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com, alexanderduyck@fb.com,
	richardcochran@gmail.com, kees@kernel.org, gustavoars@kernel.org,
	rdunlap@infradead.org, vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v11 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <00A30C785FE598BA+20250910060821.GB1832711@nic-Precision-5820-Tower>
References: <20250909120906.1781444-1-dong100@mucse.com>
 <20250909120906.1781444-5-dong100@mucse.com>
 <68fc2f5c-2cbd-41f6-a814-5134ba06b4b5@ti.com>
 <20250909135822.2ac833fc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909135822.2ac833fc@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OQhZ3T0tjf0acGQGaFWgRYFVszEd/j3r0eNAa8ufDCFs+62rEjcOnnS8
	CS6MWBlYQqpnKSLipZyIZ2uklLro6YOj52omPiQtGXuxjyT4w14hCGDBI6ii94TXJoBL3TT
	HN+OvVQRVT+/BRmpixIZ+BLzq4O/KHrE7tSE6nyz1mx4tes9fW7575l7AcoAJjQrIOizucL
	/qomM2YEflJmdEq3gQapPDaCPKTMDlghmJ4+pIYdnAoEA+6/LbtEOUIWP+784/366MwdtG/
	uHE1Z34b6r2pVgtvacjdo4YT50HbFcQAHSc/6nlnc5e1H9ywVwqH3QwWdrB7zN6XDRSjLGT
	GEF6hOtcbMRZ75vp9A8lD0s310sNib+3sIEhfoBEiE2VHr/ubCGjv6RwHNs5ebFZWtIb8rs
	sWVBvSPS4vAxyssS9fCNNBOGPykq6QWgenkvkkV5hV7kSztwy8/Gagp2cT0BlYgbP2CoNjZ
	tyWOPnXjRIxDiHjXMrgJjOkDFsbdC5Ji3GbNQrLknNFy6Fb3eQUBo2t9EG7EEL5EcWQujtR
	2IbRyPXtom1gjxQ2Ojf0PbHG0AlhObCmXRhG2/VRV9pnRyrv1ciBAmt/zqX56Qn55/e0aUD
	HA09wjOwL0qEVkpiP2HlMgmHrOeVD9AEw0kS1boQmaS9elarBhaV2D0XavJGHZ3Ix1NyxRt
	WqDDhqal0VF0lo3f+vRWFRPyizXYk2GQB+dvMtXGGpLVsQu3Oz05nOJqEsGBTXG8Bcpcl6J
	5veAbcwrCWX+nj5EO04oZRSD1ZV4osHcp+/ayoC26hroq1jZ8TdAsyvUH2NRfkLQz1oZhau
	qP02PbEvIAHxaVvV/+xUx4S18crMaBW2yLUqAuh/PoQ7zj09/ZTRroCoVDCgMSVStH1NK92
	24//R+TOlY9UL0iWcm2yXecdWY4fSkAu5RAMIQ5r/ybSLnLoYchVpYT3kmjw2+bnt8Ggxch
	mpzceVHW0a1C28feA53DCDjh5fcR6c2Ahe39RLBewQpswOmgGx/469jXdiVl7CtPU8aGcaC
	8jLxYls9geT1feQiLQ+Fc5d6FNMsIWLXK37yirEcUhWFciUCYP34Yl0vZ7IGjTc82DJxtF1
	J84txDg7zFx
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On Tue, Sep 09, 2025 at 01:58:22PM -0700, Jakub Kicinski wrote:
> On Tue, 9 Sep 2025 19:59:11 +0530 Anwar, Md Danish wrote:
> > > +int mucse_mbx_sync_fw(struct mucse_hw *hw)
> > > +{
> > > +	int try_cnt = 3;
> > > +	int err;
> > > +
> > > +	do {
> > > +		err = mucse_mbx_get_info(hw);
> > > +		if (err == -ETIMEDOUT)
> > > +			continue;
> > > +		break;
> > > +	} while (try_cnt--);
> > > +
> > > +	return err;
> > > +}  
> > 
> > There's a logical issue in the code. The loop structure attempts to
> > retry on ETIMEDOUT errors, but the unconditional break statement after
> > the if-check will always exit the loop after the first attempt,
> > regardless of the error. The do-while loop will never actually retry
> > because the break statement is placed outside of the if condition that
> > checks for timeout errors.
> 

What is expected is 'retry on ETIMEDOUT' and 'no retry others'. 
https://lore.kernel.org/netdev/a066746c-2f12-4e70-b63a-7996392a9132@lunn.ch/

> The other way around. continue; in a do {} while () look does *not*
> evaluate the condition. So this can loop forever.
> 

Maybe I can update like this ?

int mucse_mbx_sync_fw(struct mucse_hw *hw)
{
	int try_cnt = 3;
	int err;

	do {
		err = mucse_mbx_get_info(hw);
		if (err != -ETIMEDOUT)
			break;
		/* only retry with ETIMEDOUT, others just return */
	} while (try_cnt--);

	return err;
}  

Thanks for your feedback.


