Return-Path: <netdev+bounces-215931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E93C3B30F9A
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 08:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB742172E1D
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 06:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D132E54B6;
	Fri, 22 Aug 2025 06:51:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AEE15E90;
	Fri, 22 Aug 2025 06:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755845508; cv=none; b=XIgYZwLnU6nYE1RzpxgvHUbTOq3jePoSk1mlDxPYlnKIRDPNprKDPyyeRiJatpYj6gWyw2Pt4moM/sxyl/hgl42yYlgQ2GNkdufB+yqEofVEkKqMq9+nqm0JBcEOM3WGM3LoOtrkQL7YFVSNKDAcc1YqQh0dp5nJieM0EgxBlIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755845508; c=relaxed/simple;
	bh=vplvL1nmG6kTSq3roTyiGVMH4b1Ixr3GFIczpAYrtsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbiNbeXQCBpfSvKM6iIT8VW85664sjATCLsVZqVCKGHb4ObRVQdVIsrs7o5z/YvrYUic7R5NKQLKmvd4J+FYSrYhdnw3LQPqLw1FwKfbOfd0CbLpgGstTtbIuW3e0AJOD4PMg663m3wvKC8T8r4OamYQUeK6SMOzTgevprlYWmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz16t1755845493t933f16a6
X-QQ-Originating-IP: KhLwTna69ThfucotKL1WpEwMlyB+8j0yekyAFUzHemw=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 22 Aug 2025 14:51:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17939985140440540817
Date: Fri, 22 Aug 2025 14:51:32 +0800
From: Yibo Dong <dong100@mucse.com>
To: Parthiban.Veerasooran@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	lukas.bulwahn@redhat.com, alexanderduyck@fb.com,
	richardcochran@gmail.com, kees@kernel.org, gustavoars@kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v7 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <A1F3F9E0764A4308+20250822065132.GA1942990@nic-Precision-5820-Tower>
References: <20250822023453.1910972-1-dong100@mucse.com>
 <20250822023453.1910972-5-dong100@mucse.com>
 <9fc58eb7-e3d8-4593-9d62-82ec40d4c7d2@microchip.com>
 <7D780BA46B65623F+20250822053740.GC1931582@nic-Precision-5820-Tower>
 <8fc334ac-cef8-447b-8a5b-9aa899e0d457@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fc334ac-cef8-447b-8a5b-9aa899e0d457@microchip.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NgzJQeCZ3xJjR57YjAfbqcP2p2D5Lh7gDWDDYzURkD0hQ7X06LHYd5ZM
	tRJR5+TQR1jpYoA1tvqxdR0E8gAmAtx0yq3CccoOHrMWZl3FcnpnWePWRzxjO0QYUlRvMpn
	x10T+FFv+wRSMjtCjHcMRBYNDPBfq8fblfT+QrTj2PE1RT5l3veukK3SikUR5Wld1LsnI+a
	BRCTs+hwjh63EnJixZ0gT/Gsro7G/MhUMky/C/TWWat5nMvBYLzF4mAa6hmvB3nBpmqYmV+
	1G8AaZl1mqDXfCqCbhq/FlrOSsJAcB74KGbNyd9ALobeWP+KrhcrYB0LSu4a/lxgUTbt/tr
	jOIiBC6zQaIpy2bA+ANt2W6syjnma7J7e306cEEPauU4xiV5brTwDBu7CsoAVby8pT0lF0P
	ON0O1Mp+NCiE30y+3i47igsr5tq1rxnxv9t432CGkk4HP+rpG5D8mWXxwXFbms3UmyefDj4
	N6l1nhGUYXDlSiYdDW4Pki/QmtciM/0oSOGsiUi+XMJ8fay/bKnJtugihFnKBZbqqAxzCvx
	BmOMuF6EDNsGComt7lCOqCFCN0EP6V/WOW9fVvlbjIanVpX9Ic9DBd457SBc0oll+jDStS/
	Pa+EvnZosTOwWmt/Y2pEGkEqA2/J2iPtntp9CxUndCNxw1OhL4C+DTO8VFT0YHAnOSPV0j8
	TtgfjeFKFyqM8L/dwVbWZxJ4B1W9EDa1ixPKspY25GzilSCRROtkpCwVmx3OxpeAt1NihkQ
	L1ncyUn5//CUZ3VzhN7SQqZfrAnQxCyDHe3ceSfrHJzfY59tz95Gok/lWNUrv4mBUdtxvDG
	9C1OLLiAeExluNJ1MGOFPzXNjS2iq4K/reLn+15h81YC6WGHfcIs4C1EnYsK45uBLiaVFMf
	UG2zPNs17RqpcGLsV6MgwHCpZRaMlmW514Oyx5xny6CDBSDYJI2JGbucCvRjivzhmWsKFFD
	xAMVTXXiuGPtdkjuaefL7wbH0XunPfb/jF4httMbTKlXNnwwBlb0B9v/sUhUFOjqLg//jA/
	NXBTVHES7kChCKqj0zY4kuQVO8hKDqDd8m0IJQbg==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Fri, Aug 22, 2025 at 06:07:51AM +0000, Parthiban.Veerasooran@microchip.com wrote:
> On 22/08/25 11:07 am, Yibo Dong wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Fri, Aug 22, 2025 at 04:49:44AM +0000, Parthiban.Veerasooran@microchip.com wrote:
> >> On 22/08/25 8:04 am, Dong Yibo wrote:
> >>> +/**
> >>> + * mucse_mbx_get_capability - Get hw abilities from fw
> >>> + * @hw: pointer to the HW structure
> >>> + *
> >>> + * mucse_mbx_get_capability tries to get capabities from
> >>> + * hw. Many retrys will do if it is failed.
> >>> + *
> >>> + * @return: 0 on success, negative on failure
> >>> + **/
> >>> +int mucse_mbx_get_capability(struct mucse_hw *hw)
> >>> +{
> >>> +       struct hw_abilities ability = {};
> >>> +       int try_cnt = 3;
> >>> +       int err = -EIO;
> >> Here too you no need to assign -EIO as it is updated in the while.
> >>
> >> Best regards,
> >> Parthiban V
> >>> +
> >>> +       while (try_cnt--) {
> >>> +               err = mucse_fw_get_capability(hw, &ability);
> >>> +               if (err)
> >>> +                       continue;
> >>> +               hw->pfvfnum = le16_to_cpu(ability.pfnum) & GENMASK_U16(7, 0);
> >>> +               return 0;
> >>> +       }
> >>> +       return err;
> >>> +}
> >>> +
> > 
> > err is updated because 'try_cnt = 3'. But to the code logic itself, it should
> > not leave err uninitialized since no guarantee that codes 'whthin while'
> > run at least once. Right?
> Yes, but 'try_cnt' is hard coded as 3, so the 'while loop' will always 
> execute and err will definitely be updated.
> 
> So in this case, the check isn’t needed unless try_cnt is being modified 
> externally with unknown values, which doesn’t seem to be happening here.
> 
> Best regards,
> Parthiban V
> > 
> > Thanks for your feedback.
> > 
> > 
> 

Is it fine if I add some comment like this?
.....
/* Initialized as a defensive measure to handle edge cases
 * where try_cnt might be modified
 */
 int err = -EIO;
.....

Additionally, keeping this initialization ensures we’ll no need to consider
its impact every time 'try_cnt' is modified (Although this situation is
almost impossible). 

Thanks for your feedback.


