Return-Path: <netdev+bounces-221922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8E3B525E1
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DFDE6872EB
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50D11F3B98;
	Thu, 11 Sep 2025 01:41:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2727C134AC;
	Thu, 11 Sep 2025 01:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757554903; cv=none; b=ug9hH4iSdNP0bpkKJX93VNOwxOTeg43hhzF7BgTXcFATZ3CsMvIknqXbkzX2a7MYk7sCd61MHOjk+Crlf9p1Z4P98IsnNlW7OKNWKMgmhxIWOlGaO757kf5L8j/ymJ4bgqAyg/sjN96YxHmHZuSAvDmCerCyJbIdL8szLINtqS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757554903; c=relaxed/simple;
	bh=mo3vajXLH/2QvyUhdCUaJ0EkVJHEWji6L/thoSNnZ64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lz8pTQAdDLwYpFVsd+hgtQ8pgG+opMJofKG4dWgePHeFBa4er45WjKfAZ+WvLrlLaGY6G8Jd6jXhP9pElPWLN6BEXGOH9992fB1mYR+nkUipJaZ5PPWK843pgdW0eEhzPKS/c6Bx+oq2mhAoAjIszx0HMSm9oSarTyrK+ABvqzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz11t1757554872tc579cd9b
X-QQ-Originating-IP: xT4NDMmYFTqBtVk0lcsunVOxMngI/KCKIfxLuoWVbyI=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 11 Sep 2025 09:41:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13489420341655443329
Date: Thu, 11 Sep 2025 09:41:10 +0800
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
Message-ID: <B2AAE00532783CC8+20250911014110.GB1855272@nic-Precision-5820-Tower>
References: <20250909120906.1781444-1-dong100@mucse.com>
 <20250909120906.1781444-5-dong100@mucse.com>
 <68fc2f5c-2cbd-41f6-a814-5134ba06b4b5@ti.com>
 <20250909135822.2ac833fc@kernel.org>
 <00A30C785FE598BA+20250910060821.GB1832711@nic-Precision-5820-Tower>
 <20250910180334.54e55869@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910180334.54e55869@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MiI3m6WAbdszeBSpBgYiegVacIGel61EC591mlZiGjM7aZc4wt+JrB9v
	DfOlkvu3YghshGLSxIYtwJ1ecZPiYfH8lu4WOdB36WQCaht4efqXcoLtxx3K6BWSaCsmnSi
	j7N23dkn8vSHd2QwrvyI/+WsIBCkDeqX5ttZTar9YHEkcQpZHj5J5KgZ4MePD7I9O2q5UmI
	HAnAU7hPMgsPaXR1d/b2//8DkE6ogGxHRvCCjjX+ty2QzGD2GRxDTlRPcS7NuicEc63ZlnV
	Xh5QEZasedmvIcEVZnAOZT/8THJ2i70aS4cA7r0XRUqaSLt6lJ+fgxVi0Y1bsOmOFHbqKCG
	e/e/PGzlYoJZPXso2HbkB+qGzoFzoG8xwHmLkvPUaZjZL6nre4N9stsTDXYzp6aRCU5n547
	wsoo0BJ+hJ1c7cl8hY4BEe0XXYp8MQYH9MbPhmbd1QSGj0R/fTAfu5NfzR+MTwrAOAQE1mT
	NlEo5kvbAPpHGiER5ReMxsR2v65TSTVF/RQybAHroJI5rzL14fQXTxzf1kxJ+es234E40D5
	F5IT2Nb3LenyuT6mMKpwiAF6LLDgd6OpGAz6Q4kJTXD1eP13Aob7L3m8G/DNP5ALDhm/jrF
	yihXpvy9vrybBk7xbTWCes5Zpt5HzgHevCKlmM/DZzQtppoDxgHMWkMo2J0HtE0QZIznll4
	qet4AdNxuW0Q890Q2Y4ksvmMSdct4toZGmGHv2DyJ6mQeuZTzxtuMtxhKsxeuROyzlHCsSD
	CT1F65DnZ7RIwm2jCIAsHkrDqoZjkqZxMw9ubHH/R/2Fkuwt/basl/zS9PpSkfqYEajH66L
	FxCDqm75a/zqC4NnknqsvIYDwIKFropwqYwH2zPvUvPrQi27Vap+39QMrXFT0HHTqEe8Bd3
	99UpKb2j1iyXJNoDjdg4AOwS6TeIKiXeKPTWlswYapCXTzHfHIBCpiwGuinBT67f52DJpUl
	aj1rtU7EuY3nO+sRRv+XOTpAvFzbZiszfPA21SRg6QzuW12tsoT2KbDbPuRtDPUnABQMswh
	EglwTfE19RbORH8xHE2CmOxsAgl9/Arzc/ihWFnttJbQJzaGAD5o9libCWb3TFtLcKOlPhW
	llgDuNPWI3b
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

On Wed, Sep 10, 2025 at 06:03:34PM -0700, Jakub Kicinski wrote:
> On Wed, 10 Sep 2025 14:08:21 +0800 Yibo Dong wrote:
> > 	do {
> > 		err = mucse_mbx_get_info(hw);
> > 		if (err != -ETIMEDOUT)
> > 			break;
> > 		/* only retry with ETIMEDOUT, others just return */
> > 	} while (try_cnt--);
> 
> 	do {
> 		err = bla();
> 	} while (err == -ETIMEDOUT && try_cnt--);
> 

Got it, I will fix it in next version.

Thanks for your feedback.


