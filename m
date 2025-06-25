Return-Path: <netdev+bounces-201009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E08AE7D89
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B3523B463D
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB8D29ACFA;
	Wed, 25 Jun 2025 09:28:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B872827281C
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843704; cv=none; b=SzkI3Tjm8zMmrhs8Mr8MdlPsYgzqY9xZ8cepn4/Tky0JfH1vFiYi7AJ3jN3LvUDgoiJowVWAMRnqK4Pf/pRYbucVLssU0v4vQ0WfVATfFeONJtmNKIkJCO4nrBM1lAShYXAOyNnvufHbcCnpiwr1vVrL603Ufe/Pi1gsR3SRY54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843704; c=relaxed/simple;
	bh=wcI7V5QGhkjLoPhAFG6witQ+XDKuoal0HBR6Q+nddiM=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=bzTau7Vq6xAIALK8+LyWTV8u6Q30ovLWMJleL8oCceLgdW46zjDJp1I99heUTbY+C6iGQEct3UV/g4b4q4w95PxAigpF6siiX82COo3E6oy1u1vGmKcY9pnj4g+O36N96WexY5e3ukUqtyPEHCXpB3sV2Z/jphF4qpZRfQaXw4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas6t1750843631t919t08497
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [60.186.80.242])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 6573741032297612832
To: "'Michal Swiatkowski'" <michal.swiatkowski@linux.intel.com>
Cc: <netdev@vger.kernel.org>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<horms@kernel.org>,
	<mengyuanlou@net-swift.com>,
	<duanqiangwen@net-swift.com>
References: <20250624085634.14372-1-jiawenwu@trustnetic.com> <20250624085634.14372-4-jiawenwu@trustnetic.com> <aFu6ph+7xhWxwX3W@mev-dev.igk.intel.com>
In-Reply-To: <aFu6ph+7xhWxwX3W@mev-dev.igk.intel.com>
Subject: RE: [PATCH net v2 3/3] net: ngbe: specify IRQ vector when the number of VFs is 7
Date: Wed, 25 Jun 2025 17:27:05 +0800
Message-ID: <030e01dbe5b3$50ee41e0$f2cac5a0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQG8FB25wsfEchebLehyFWt5Oiz5UQJQZy3BAnQi+8O0LRjqsA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M/APdU6Xy1byWBvTcRKjskS3N4yFaR7btmD6Q+xG1sWV2/z56jyGDSwl
	DXUIy62UKW+CwPjBKPCD2y8V9V1s6dTeoxOaI5oNLUg8NtVxaf9veHY+41/QU35VLu2CZZk
	Lf2u/F8mvJW+z/fMlBpo7N3yXY/DBQItvoWPIU/yyTx99lF1i5m68rPQUpuxJbwib9jalXr
	GUTTzCfxduNdM0x/PSCvfzqtdsG/AXd5nxNpvDbY9Flmx4W/WvrZznf1qIdzf+h0q995skV
	Jzxv7bormZ8oWZoUfBT/SmGzUdZOYVdWbIQHv7p7KN26Z0WFiWNj29Uuz4qVuMspEdIkNDy
	c7bEMFUBMnObzEpYCszhOYqpj2+2+/RQTU9+kNQ1KDQG4r9yi0NiL7q8PIv7DPaJ0eX39ka
	I5Jzmgfop7GFK6y9W+7ovgMfPzIraf0JwatJTw50WJfM7DKSbbjcQugXHgtoimP+VWbzJ+7
	/3g/Q/YYEMN4VaI0EWHsEgsKFYN3QiTW/eBmuTwCXNVxGm5BKMKR4MdxlTrgW2c7ljwokz+
	nqiH/rW0WppnDtATCWJ2LlSzwMdjrwIQJa+Ni8Ike59rXKYnxfxV69qlONlgPTwKkc8QE1L
	TSH1jj7xbjKpOz+jb9FiPo+ceWTps0WHIcqAm/Z6j0c4v+DGHkmlBi4PYqXNEhf1JtjDhb/
	aA25mmQuC8dLOlyti2kSnIxphTnqBI8KM+Nnp0WnftKcFFZLxR8lWQkvmQE5IS32ioVx1u2
	kW/dlYEpIjTKph+3Sqgm+jPT7ufRk6AU62I4g7CP4wvkEv87XXjkcsFi1sLI76VpY54MLhG
	7/jd5tZrVuqeooSfYEjdrcEEdQ4eLE67GO7ljGMH4BnpHTR2hbXcRR9SGigOzMxGOOv2nTv
	XJ+V/EdB3/l+wMGwUJ+oo+DuEYN9MD/Yy2At38sBVsJbYdxvcSGYT0kh2u29D4P3d9vo3H3
	LR0BKFZQdmm1kKh3KTYoZ0iH68kxtbWMFuCagwxljWkAqlB+ncz7msDd8ruOZqNY02cjnWi
	XAf2BvizCTn8r0oLil3JTk99kNNWXWDDLG/293Iqu2+RyhoNnHA2ARUI1+GPcW4Zgt7Cnsb
	w==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

> > diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> > index 6eca6de475f7..b6252b272364 100644
> > --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> > +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
> > @@ -87,7 +87,8 @@
> >  #define NGBE_PX_MISC_IC_TIMESYNC		BIT(11) /* time sync */
> >
> >  #define NGBE_INTR_ALL				0x1FF
> > -#define NGBE_INTR_MISC(A)			BIT((A)->num_q_vectors)
> > +#define NGBE_INTR_MISC(A)			((A)->num_vfs == 7 ? \
> > +						 BIT(0) : BIT((A)->num_q_vectors))
> 
> Isn't it problematic that configuring interrupts is done in
> ndo_open/ndo_stop on PF, but it depends on numvfs set in otther context.
> If you start with misc on index 8 and after that set numvfs to 7 isn't
> it fail?

When setting num_vfs, wx->setup_tc() is called to re-init the interrupt scheme.


