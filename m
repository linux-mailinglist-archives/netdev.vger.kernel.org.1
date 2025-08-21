Return-Path: <netdev+bounces-215486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7BAB2EC6F
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 05:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8973F5E71C0
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 03:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C852E8889;
	Thu, 21 Aug 2025 03:52:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFA02E8B75
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 03:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755748330; cv=none; b=twAfeb6gZQZjpwp0tI/bMIWa2eXvVH6b367etRd6rIUB2X1PFVrFSnn5fqy2B8YyYONDd3AK0U/8/bAUraJabYdzo9rbgyPLayjt+bXOhqlcg2IhgdBuq5ClX7LV5yCiZLCE19YrVGuQ63sY40EBteFzEkaG9RLaE9VuapAZ5Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755748330; c=relaxed/simple;
	bh=c+dzYgwegckKBE8DwdjCoqLZMH/ed06q6NOgQtARQeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCVXMeB1wtXCnmqtWcTTdO1rK2erFDYiiQ2KEw7eTUeu4OkHrPVyvrmIanvpwCE0R+OCKAs7xDFLwsWf3DZaGPOCvV2aD5yAFinwI0ZDVG0vl7z079dBbS9MeXOMm9wmDsZJD6L65L4pWiNgax27yYC20koTk3STUzlLjrgiLss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz4t1755748320t06463bcc
X-QQ-Originating-IP: BnGfIoXIObhF7yKbto78D0xs0V9ppX65sKZt2uAFk+o=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Aug 2025 11:51:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4102684638845518998
Date: Thu, 21 Aug 2025 11:51:58 +0800
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
Subject: Re: [PATCH v5 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <135DA1E6DB034659+20250821035158.GC1754449@nic-Precision-5820-Tower>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-4-dong100@mucse.com>
 <5cced097-52db-41c9-93e4-927aab5ffb2e@lunn.ch>
 <6981CF6C1312658E+20250821014411.GB1742451@nic-Precision-5820-Tower>
 <f0c9aee0-0e57-429e-8918-d91bf307018e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0c9aee0-0e57-429e-8918-d91bf307018e@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MoR4tCOgKU4aBpl3gCAqSVOMkXH8Dl0iOqLSE3Bn6Ga2x8Uph9WPfxK6
	m9u01nHDABkM5NUUOxLmPkYH/fFWo8ao0uqnyVdxDoe3/MbwM/rSMBwW429YpX419+b4Iho
	E6oKSwVZZ55zNOlOdopRKeiFCYCVYdX89s7i5IltmN3FgvMAMX00I7dCRwzYkSOaEb7Ds9j
	uQ6ONA0xvHtYkJkQx3hVWOQBKd3TPONIlHOjgaoF5UDNDNvr5MgnY/412TJHiQOdaaKNkX4
	lFpO3S9Klwro4u/gg3/BPhskBcorEju6EgxDeE3CBlqMeEdBmTodfsdUhuVH9sHikvQ8aNv
	LVvpCGS0SHczExY894Bav2LaFroDM4PrafczrNzdm7hPMJPqvinJ6/v83oOseRgQRw+XAYC
	WAvxcaHv831qSgelL7+au89pACkmJ8P4N4gdtYwjlpK6Tvp8XAuheaABq52BgtHbW9rFQLu
	D4S9oIRjNzUOcfiIzLNsUR0EnesVYkoxDpaupw3gSYfHNmhg+iJRFz/ZOxuC4G+7rGLibo3
	PDlL9bGabMG7YmqfML2r8R5uW7BWz6lwyjBbjC7sjM9am0REb3seWy1u9LJa+rXJp6YYEHu
	AI9/usFq/c7iYYuwk+99EvkKhG3RalYDRJkovPzyZq699RfyAohJf68Ox5iH4dEhTKRblWD
	a0KNksa6WTP+7/Ty0PmkpFnSdBRghOlRd00/eKeABh1y2WDHizu2lo2twwQn3pDfV3888sz
	ctb1lIzSo0dN0Y4n9NC/U5UWeQLQIyr7Hs5Gety3sT1k+Skggs/wWHJfs1iQ19FRwkBL95C
	tVMxvQ4RYE88kFFoUAt3v+b2bh1qzyCv9y+jeJYtYWLw4NXrG6i36UPHp04Y/6lkW1KVBKH
	pPjtt6jlYr8lt98kCIYGqwy9nByC+Xg0sOyCL9SdhuOyl31kYMaojx+hZPiTxyrtAoRwvjG
	jWWHCi1V5teRF1uKozsfr6sDhM5oxIXvWBsZ2DfLs/c3pwngSfg36aNgdTDzLC5q/PsxUYn
	VtxC9bxROpPwtVbLpewkHVrNmtpfCX4UBxjlUruOjohG3/2RMenr7T1flV9DE=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Thu, Aug 21, 2025 at 05:06:50AM +0200, Andrew Lunn wrote:
> On Thu, Aug 21, 2025 at 09:44:11AM +0800, Yibo Dong wrote:
> > On Wed, Aug 20, 2025 at 10:23:44PM +0200, Andrew Lunn wrote:
> > > > +/**
> > > > + * mucse_mbx_get_ack - Read ack from reg
> > > > + * @mbx: pointer to the MBX structure
> > > > + * @reg: register to read
> > > > + *
> > > > + * @return: the ack value
> > > > + **/
> > > > +static u16 mucse_mbx_get_ack(struct mucse_mbx_info *mbx, int reg)
> > > > +{
> > > > +	return (mbx_data_rd32(mbx, reg) >> 16);
> > > > +}
> > > 
> > > > +static int mucse_check_for_ack_pf(struct mucse_hw *hw)
> > > > +{
> > > > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > > > +	u16 hw_fw_ack;
> > > > +
> > > > +	hw_fw_ack = mucse_mbx_get_ack(mbx, MBX_FW2PF_COUNTER);
> > > 
> > > > +int mucse_write_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size)
> > > > +{
> > > > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > > > +	int size_inwords = size / 4;
> > > > +	u32 ctrl_reg;
> > > > +	int ret;
> > > > +	int i;
> > > > +
> > > > +	ctrl_reg = PF2FW_MBOX_CTRL(mbx);
> > > > +	ret = mucse_obtain_mbx_lock_pf(hw);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	for (i = 0; i < size_inwords; i++)
> > > > +		mbx_data_wr32(mbx, MBX_FW_PF_SHM_DATA + i * 4, msg[i]);
> > > > +
> > > > +	/* flush msg and acks as we are overwriting the message buffer */
> > > > +	hw->mbx.fw_ack = mucse_mbx_get_ack(mbx, MBX_FW2PF_COUNTER);
> > > 
> > > It seems like the ACK is always at MBX_FW2PF_COUNTER. So why pass it
> > > to mucse_mbx_get_ack()? Please look at your other getters and setters.
> > > 
> > 
> > 'mucse_mbx_get_ack' is always at MBX_FW2PF_COUNTER now, just for pf-fw mbx. 
> > But, in the future, there will be pf-vf mbx with different input.
> > Should I move 'MBX_FW2PF_COUNTER' to function 'mucse_mbx_get_ack', and
> > update the function when I add vf relative code in the future?
> 
> Maybe add mucse_mbx_get_pf_ack() so you can later add
> mucse_mbx_get_vf_ack()?
> 
> The problem is, our crystal ball about what will come next is not very
> good. So we review the code we see now, and make comments about it
> now. You can add comments explaining why something is the way it is
> because in the future it needs to be more generic to handle additional
> use cases, etc. Or explain in the commit message.
> 
> 	Andrew
> 

Got it, I will move MBX_FW2PF_COUNTER to mucse_mbx_get_ack and rename
the fucntion. And add new function later.

Thanks for your feedback.


Thanks for your feedback.

