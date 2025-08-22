Return-Path: <netdev+bounces-215918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 353E1B30E28
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 07:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D741668747A
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 05:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503512E1F12;
	Fri, 22 Aug 2025 05:38:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E3229E10F;
	Fri, 22 Aug 2025 05:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755841084; cv=none; b=UkHGzSVUIkCvMWZMB2sHB8777AGFqepxJ4YXj1u3AYrS/GyeHd09IQmRsWKSeEm4nixIWxXBSe4c7IRXfV8Te0syKUg3Gj+gccZcO0RhtfbhOYfaqnzcxQUfcOHmwZ33s6E/cZh9YMAhSwAYCeyYHPgPIlB2pDUt18TkkTU58xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755841084; c=relaxed/simple;
	bh=P2OpMo8zKi5PbanOBvN3xsHsrhiGUSU6OkaETt+j7ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNNe8+fJp/GL5yxPourjSS2VoakmAxRz8HjPoBhKAwl0TlZ6S1hO74E77XSzQA+I+liBtLOkeNqLzFJ/WMkGr1X7G2OwViaOTwecELqr0NPdvrkkFvmCmHxryBbmkklLztKm2dSib++8XVIjeWzv7cexUJSMN6cNW1pvAcIwu3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz18t1755841062t97b53618
X-QQ-Originating-IP: hLpCTsEsbb/JUu8v3fMtu47Yfigv2mhcD7vKjgfus30=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 22 Aug 2025 13:37:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14988215101374177968
Date: Fri, 22 Aug 2025 13:37:40 +0800
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
Message-ID: <7D780BA46B65623F+20250822053740.GC1931582@nic-Precision-5820-Tower>
References: <20250822023453.1910972-1-dong100@mucse.com>
 <20250822023453.1910972-5-dong100@mucse.com>
 <9fc58eb7-e3d8-4593-9d62-82ec40d4c7d2@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fc58eb7-e3d8-4593-9d62-82ec40d4c7d2@microchip.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NY7N4KDmsCacYkgy9A+vDKp3+1hyQx3R+XJ/UhRJTu4a6qMcvssW4j9X
	pxv4MK/UggwZr+Esxz5KH3mGJx8WMAdm5JH6WAPQcGBvZfC8EU3tzapL+lkZBvHlOteL22U
	nyh1OKXNj3TY7n1qlQiuw9uqjBtHMGHGQSAiqsRYBgtqMQmoFy5zhBKf8XXV4fgg1aYzo0z
	1D0q3ZKCEdTO+YlzM1hTMqtuUXrHi40hF8PLd6Kp002qeEt4Sebw0pjdEOegx3fvkxYI3GS
	LehzcUVtsuL9WfhiPmavQU8fbbrhkB1AM0/5rcr/S6GPIt3BMc/h67cPdlCVSPSzWG0wBSY
	wMMWg6O2NUBAPNAl17J6pvmc1+utHS8qstZERCdeImcBkTxFosc+9s24/Opd44Tif8FaWEq
	zriV9f0ojP4rolvmgsKCBLYxHOMJTBNj9AEfx1yaNsigHfW1bJiugAGvR8CFj94c45wX3se
	Lg8xJ41ueyxRywnpfz+B4DeC/CuBrEeBDkrJF+goD7pJehkjOldva/GP9/hEKNy9RmVTak0
	XSiPQCFegyCLcxtoTjhAjgDI0N0om7uf9/p2AbW8HaEDbIhNm8Z7fztU6YNL96uk+nh5lke
	m1arDInkHqwA00So2BzmCKd3WAas+s3UYGVKmC2FhPxiJ7RpLZtaYK9A5w2Kjg1x9SJZB4H
	+WUOD20uSd21pnMmn+Fk6cV8y8VMrm0RKCvUeKVrIL+h0osMwdCNMbm2KIbC0GHRwkIsysf
	j91gSft8D+Nyq4oc4guc6NvG1i2c1F8uhBIvul3ju3BHqyUOHgV4l+0a5kcCV9fRfZsR6Vz
	p4ozqoIk/xYm39sdZn4ro6f8aMv4V19hlcW7iWrlv4SEDPCNzO8/qaxkLrEPEnjLTUz8jZr
	gf/I96YCtWbJ2Sd/hH2nTbPAnFHUTbgH5KsmF8TWjs1DIKdNZvFrUjHPcKA/f7M8x0L0hEI
	xybLbmYEwd37CC9WsiKdnceo2CfuHPw4TnOwYy7i/MMGDTbvQaVZrVB6X6OATcFSjD+KCuF
	X1/toosl6csANbZ4w3
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Fri, Aug 22, 2025 at 04:49:44AM +0000, Parthiban.Veerasooran@microchip.com wrote:
> On 22/08/25 8:04 am, Dong Yibo wrote:
> > +/**
> > + * mucse_mbx_get_capability - Get hw abilities from fw
> > + * @hw: pointer to the HW structure
> > + *
> > + * mucse_mbx_get_capability tries to get capabities from
> > + * hw. Many retrys will do if it is failed.
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +int mucse_mbx_get_capability(struct mucse_hw *hw)
> > +{
> > +       struct hw_abilities ability = {};
> > +       int try_cnt = 3;
> > +       int err = -EIO;
> Here too you no need to assign -EIO as it is updated in the while.
> 
> Best regards,
> Parthiban V
> > +
> > +       while (try_cnt--) {
> > +               err = mucse_fw_get_capability(hw, &ability);
> > +               if (err)
> > +                       continue;
> > +               hw->pfvfnum = le16_to_cpu(ability.pfnum) & GENMASK_U16(7, 0);
> > +               return 0;
> > +       }
> > +       return err;
> > +}
> > +

err is updated because 'try_cnt = 3'. But to the code logic itself, it should
not leave err uninitialized since no guarantee that codes 'whthin while'
run at least once. Right?

Thanks for your feedback.


