Return-Path: <netdev+bounces-209307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B62AB0EFD2
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 12:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81CF1AA505F
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA8028CF44;
	Wed, 23 Jul 2025 10:28:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA37B19A
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753266504; cv=none; b=kzfGxRLDBG82Ze9ojvAhoH2T8SOmZg3EdD3kTmpHt4Pa5nI77dWXPZiVfUTAgu/yKHxrVWeg2/E5BrJ6I72cotUVXYZAZlC0jKJDPCATa6W/hLGSQf+SHqQkVa24CDIUzhqW4GEHsnIKxFuU4PTy/EtpCXD5GK4JcNRQlhdjDws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753266504; c=relaxed/simple;
	bh=Y2hBbsRsSjb0//xxcUnnqm+dx2pboI7dZeXSdkFfqjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tp08T52+/cdHLo/fSewxQWDwq1oAxmkvUe5qUb4RKQJC/RwDlRgMGUp4CQ1zW2RBAWBgRjGkSuB/aKpZBT9g9NDUjN/hZq6aBLWVW3bnUXOj1KBI1FHmCJT2cjWjkmCLDJNx98zNMxMkywKMinsyQ3/Q1ajNjCx/HVvWFaIe6gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz11t1753266484t705774a7
X-QQ-Originating-IP: 5vaOYJs96fmAx4dCayhfdSYZKhupt7js6Gtv9Q2cBvI=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 23 Jul 2025 18:28:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14126020564848538954
Date: Wed, 23 Jul 2025 18:27:57 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/15] net: rnpgbe: Add basic mbx ops support
Message-ID: <C01D5678EB05D185+20250723102757.GA672677@nic-Precision-5820-Tower>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-4-dong100@mucse.com>
 <e66591a1-0ffa-4135-9347-52dc7745728f@lunn.ch>
 <D81C71402E58DF29+20250722064530.GC99399@nic-Precision-5820-Tower>
 <942d3782-16af-4b20-9480-9bdf2d6a1222@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <942d3782-16af-4b20-9480-9bdf2d6a1222@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M0wYV6TTeeWiEeYxizJD87qfeEDItjcm6qAclfba4XMYxMiwwBqFLQoe
	JOyHFohwlTPWxERM5yNs8whJ62Zym4/4wrD2qLQ2uiFwaa8EogxzrZ/UKpyq/IfpXmjy/g2
	s0Qfpo38Xm/axid1PwEkDzHN/TekanSsQlCrFa4crQbxTt1jBTNRTLlUUNmc+YHN8CO+eYf
	/wWIW3J8CWFwfPZzfBVUTpGkcwJ3PqMDSZ1VrYEDeD657IjUZz/mpwzko2796Ojgw96VSfB
	giOUOHCH5ap4+d1uSHr9qLW5vo3lAQTFEM8aAxH1X+NwMqHKES/ucCUjiDLg9vOUv9JCOAy
	5py7JOqYMs2EBlRg2W7jRYucxQvR5PtJ4SAI3v/SWwb0CLJj1+vQSW4+jyQfoUC5Bmb5hQf
	spDnRSyV8JoZoM8zPa0/Nee9kTR0UHk/oH/ICG3kP8oBgPzcH29raPT+1mFOO0kOkHGWEdJ
	sc/664xL3p3FxP34BWPXWe0cwJG/2xNsYuOUDYKgiPzzitm7FjgobrEmXJyG+lpULdEK8sS
	VLFVn6nnnlMJaERxX3LaXtlML3qUfV/4bKDe33LK0DWVhIe6585pRIKbPpF0ILWz1aR8RjO
	2jGeOpvFUK1HltS/J02IAovKr0kCTj2CBDPo9iVSqxHppJhOs7Mkatzce38Z+xVnzeHaEh1
	bI8WvT6DgdDX3QtNTNKPJVUxBl94/wZUGIyCc8HlQukLVwjxy44sZlm9DmJDiS5/pbRITyW
	EmzmBj1vtLzCHB4HHniSLTLv29zTEj1kzWxg1aTjP6KZykAjs5HtjNeM9vIYoZnSSCPvgFS
	UMD+p/qSEUKjSkAuAlJR48TavLa5nhL4lvtAYnvWPgMi8olXyilCCV0i3fpcG7KHCY0QA8M
	4GqJYEWiC3NqH/chduCVWom2B/GVd/cLOoFp2+xSdkiR71tf2hyu/tEHz6ANsEUl8YgvjYo
	BWAskutFiqI7H0ISNdsjyJUd3HWJ95sIeSHEtDJ+mPzBC2ty38dfJpz1j+0+VNIhAncw=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Tue, Jul 22, 2025 at 03:50:01PM +0200, Andrew Lunn wrote:
> On Tue, Jul 22, 2025 at 02:45:30PM +0800, Yibo Dong wrote:
> > On Mon, Jul 21, 2025 at 05:43:41PM +0200, Andrew Lunn wrote:
> > > >  #define MAX_VF_NUM (8)
> > > 
> > > > +	hw->max_vfs = 7;
> > > 
> > > ???
> > 
> > This is mistake, max vfs is 7. 8 is '7 vfs + 1 pf'.
> 
> So it seems like you need to add a new #define for MAX_FUNCS_NUM, and
> set MAX_VF_NUM to 7. And then actually use MAX_VP_NUM. When reviewing
> your own code, seeing the number 7, not a define, should of been a
> warning, something is wrong....
> 

Got it, I'll update this.

> > > > +static int mucse_obtain_mbx_lock_pf(struct mucse_hw *hw, enum MBX_ID mbx_id)
> > > > +{
> > > > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > > > +	int try_cnt = 5000, ret;
> > > > +	u32 reg;
> > > > +
> > > > +	reg = (mbx_id == MBX_FW) ? PF2FW_MBOX_CTRL(mbx) :
> > > > +				   PF2VF_MBOX_CTRL(mbx, mbx_id);
> > > > +	while (try_cnt-- > 0) {
> > > > +		/* Take ownership of the buffer */
> > > > +		mbx_wr32(hw, reg, MBOX_PF_HOLD);
> > > > +		/* force write back before check */
> > > > +		wmb();
> > > > +		if (mbx_rd32(hw, reg) & MBOX_PF_HOLD)
> > > > +			return 0;
> > > > +		udelay(100);
> > > > +	}
> > > > +	return ret;
> > > 
> > > I've not compiled this, but isn't ret uninitialized here? I would also
> > > expect it to return -ETIMEDOUT?
> > > 
> > > 	Andrew
> > > 
> > 
> > Yes, ret is uninitialized. I will fix this.
> 
> Did the compiler give a warning? Code should be warning free. We also
> expect networking code to be W=1 warning free.
> 
> 	Andrew
> 

I can get this warning with 'make CC=clang-16 W=1' now.
I did't make with clang before, I'll add this step for future patches.

Thanks for your feedback.


