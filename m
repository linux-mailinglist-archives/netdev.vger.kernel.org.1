Return-Path: <netdev+bounces-215446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF73B2EB0E
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 04:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69564A231DA
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 02:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEEA214204;
	Thu, 21 Aug 2025 02:04:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD78119E7E2
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 02:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755741864; cv=none; b=Tm9b0gdyRwGweL9JADCOvQdYOlRJNpnOIQoMo9p7qQG1BnwnI9z/wXC5jAoMlSD02lBCPKgNTGUVtsmAt7mLYRGLqNCFcag+Ws7VCyPMX2faELaps0UJu1umMj4NmedR5pYuGUhHu/ll7Jl/ypu8uuEH2miCgYb47iBaoeCuJHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755741864; c=relaxed/simple;
	bh=FNLBdWhtXd2m9yHwmeI8KFlYBcHkijGv9Sr7nDG2Uyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMdBIZpkd/qkDme/ZnwPgHyQVPu/8uO7cpApmIIyST6wIAut1ztK9U2CCSyR82U6HCvYxW/w/kD1XZuU4qG29wG/JPjGGawbRDUWZdEqu7n6mmPwOCe4V/4gJ+BMaeYY03WjfJO4j4kjIHbePG9pG1c5f78IJ7YhsvAFIz0VJNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz12t1755741849tfda9277f
X-QQ-Originating-IP: CBo+yViVKO1fMalkEw0THj+HBznWJv82D9hIYlQUVFM=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Aug 2025 10:04:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4256339024035975856
Date: Thu, 21 Aug 2025 10:04:08 +0800
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
Subject: Re: [PATCH v5 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <9BFA6532A427F621+20250821020408.GE1742451@nic-Precision-5820-Tower>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-5-dong100@mucse.com>
 <399be32e-5e11-479d-bd2a-bd75de0c2ff5@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <399be32e-5e11-479d-bd2a-bd75de0c2ff5@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OZsapEVPoiO6ZsKYGvtf16iwyFS0uKN/pV9xTYOGIMoVrP5JcYIBOYVp
	EEtkTAClI9A72m8tDx7Osm1xPl2nzPfRKTfkzwJIZqqYXg1erB7hiW0lcOFAutMHx/TDcMW
	Gn7R6j0cGOUTfhc+BcEDjpJsLP6RWfbb5Aeo2gbZiWPGWKLMlaFvlyqSnsrnih1fjTsNeXe
	8rujtuBJ2BnF2BMea+07lD3tMxpi8pcMNmJk8e1oc/Q+Jbr1Ovbf1Dy7flDqdpqisEd5bBG
	K/hY9U2KxXPssrOIBJWq+y5X9ftg80BER7oinv5AvML9L8XYVllN69iZkUsSESVBp08M4wr
	oyS2L5xoXGujPY42kOX05UHu0pXoGrFhUxNhuh3gMxmk9gsJ0Zrez/6cpxzBU/mwizzEIsj
	6xdygnncfYFJVGHEdO8b00v4Y00jKoj874JEf9Sb8lKiiFj5pXfqzGQRd1SF/j0WIj8ZguJ
	Ti2vL1CbHptNBVsANS2kKVbMCX+jAYvEixm0wdnDjbbFSTpMhxOrf6gLHC39QD0xVpoNprn
	Vsp9ExegWwerbh953+UNg/4j3BJyKDwKMly7lxeZH3ckeCmc5z9g627OxgtICXR/eaBSRWe
	9vgvObXFbFLCTEdZgyoZza2nBeNOb2Zy2bw5yMx7Ju9be3LlRsezJzyCh9HIoczk6+p047L
	uFWv9vLxBH8tqmPOlohfOWbM5TirBb9fg41HIocfZ16W5Rk42SSUDMLBXIZ8YA7F7tbYRul
	wGbcC3y+v9+CmvFrPwr8BwJQ8e1sYZktYScYYWjn2o/2DU+P9YDPFvy76MHFUFpFuulxMty
	cmRucQBeTBJa+Y3OrR87huZQp4PdswsWf8s7MNYm0x1HyY1tgpA3Nmn8ouEQq19lCfWidVZ
	2J3/mdSasekGYfxmNcHlrWNr9UosskFNNeI8EsvJnrlKo0CAmxDB+od8Dw8Kc/OH7xEp+bH
	OlTMX9No9fR0YjyQywKeIIOvWkESJbXuJPC9YOO/6skRXeZyvRCFDXOH+XBF27+tVizl6O/
	y127IA2GxjI04byuXSx/7WPjBNm/3IK1+KOS1ZT8jlTL/W4bEb
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On Wed, Aug 20, 2025 at 10:30:17PM +0200, Andrew Lunn wrote:
> > +int mucse_mbx_get_capability(struct mucse_hw *hw)
> > +{
> > +	struct hw_abilities ability = {};
> > +	int try_cnt = 3;
> > +	int err = -EIO;
> > +
> > +	while (try_cnt--) {
> > +		err = mucse_fw_get_capability(hw, &ability);
> > +		if (err)
> > +			continue;
> > +		hw->pfvfnum = le16_to_cpu(ability.pfnum);
> > +		hw->fw_version = le32_to_cpu(ability.fw_version);
> > +		hw->usecstocount = le32_to_cpu(ability.axi_mhz);
> 
> If you can get it from the hardware, why do you need to initialise it
> in the earlier patch?
> 
> I guess you have a bootstrap problem, you need it to get it. But
> cannot you just initialise it to a single pessimistic value which will
> work well enough for all hardware variants until you can actually ask
> the hardware?
> 
>     Andrew
> 

It is a problem related with fw version. Older fw may return with axi_mhz
0, So I init a no-zero default value first. Also, I missed to check the axi_mhz
here. The 'usecstocount' is removed in v6, I will update here like this in
the patch which truely use 'usecstocount':

if (le32_to_cpu(ability.axi_mhz))
	hw->usecstocount = le32_to_cpu(ability.axi_mhz);
/* else keep use the default value */

Thanks for your feedback.

