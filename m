Return-Path: <netdev+bounces-206095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E653CB016CB
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 10:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DB017A2BE0
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 08:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7351205E3B;
	Fri, 11 Jul 2025 08:49:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A9718D;
	Fri, 11 Jul 2025 08:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752223794; cv=none; b=CMA11h81knX0zMiVkzaiP1Yx2olAFDn1/h8Nya3QLV0omLoYXLP341A8MIk1ArXDg/EjDvGvsrP6poqCqWDO/2iDbrOlye0SeAADBrx8zovA+Pl7WxUIUdBejwPjedkn7EzFAiyrdYcKS0EDg+e/bCWr9Rq2Oq7+wGlg39JmFgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752223794; c=relaxed/simple;
	bh=C7pfC3S3SyaP+8HHxlqYqJ/aSCWmXYFv+Cc37ymiayw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=oFkM196b+c8+cEoVrIFJaAtpPH0Pbv9QfZm0msTZcVLLaetT9wBJdXLgVCMp/k6uMrlRgWEIEQcuL2iU7PSFjrJZZbQnyJT5GHRDoUHN9ST3dDqBBznMSINKs5JhOmT/921hX5liJGAeKFHmSlHrZj588i8a5cxpplBgKnnmZvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas10t1752223658t787t23244
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.20.45.108])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 6388199071658908415
To: "'Randy Dunlap'" <rdunlap@infradead.org>,
	<linux-kernel@vger.kernel.org>
Cc: "'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	<netdev@vger.kernel.org>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>
References: <20250710230506.3292079-1-rdunlap@infradead.org>
In-Reply-To: <20250710230506.3292079-1-rdunlap@infradead.org>
Subject: RE: [PATCH net-next] net: wangxun: fix VF drivers Kconfig dependencies and help text
Date: Fri, 11 Jul 2025 16:47:29 +0800
Message-ID: <094401dbf240$6f60b880$4e222980$@trustnetic.com>
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
Thread-Index: AQH4l/UqxmfcCRRhuGHFhO8h+3/fV7PzUFMg
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: ML/Dknz1wcqbkh8voadzCAKKnyzL4KIZABSUYRjN26Xgvc2KvKMTIY1B
	fLaRLwNtFnrqqIQW2KgSDFXgkwFU/B5TaAkPcqCS7uZf6phMxn2x7iH6X2/SwJB0/FV5oAE
	gpxBHGNF65jEPh2Xmh1QdnJC073KUURvS3OrSqZCCccMJ/1Kj9w9yApl3dJHthSU+3MrdCe
	w8JUN8NNlDAJlTMW2AwslGvzj25Q4FAjN8A5KNyJhNeR+NvQ0YnPJBLSAqPpzmP9JZtgqcM
	tDuC4xL+d84kr800Fl2Btr3VlNH+luEcQ0KW3qJxckc+AiA+ynRXHE1q1QyotufoHLoxYMr
	49+YYmWyW9azOfvQEhpO+Op5f4oC2S+E21DCW3niOjVELY5avxcuDoWo3xVQm8zz6cYgH2S
	ftI3JnfSdLICTyx4yT8QnEVkJ77/Wlsiy0TZdrtsm6i6ezf8kWNGrNz5kfbI5VX92JFpphA
	n8VEjkL7yP+a8BefpCw2TNa+xq/JC+FbXITobJ4PdXYoyqXwlte02f+kGxEB43Ukfe/Cecc
	HKFq2b4E2LzuFNoJNfEBeuCN3Y1T/dRWq3W1URgCCo3pIj4zvPHZFMQQz5XuLsO64NBpfjn
	hXbLd3mCEvz09Z19PMZCpH7WXB1eF0Ilse/DLLj+Bx+gUbZIfcOBmZnNYqnMngiMun4nzQt
	MRiOQH9iPDrBmVYJt59edzqIsXpVru5vkH/fz4xl+WYYaPwvsDlYLIPA0o7QbBMCrygczh+
	h3AxQsiTfylhlepHKQYwV23NYC9shw8g0nN/ucGpY19EK3OLlB6zcQ9DTkXp0RR3sEdCqTA
	Y6j72RIB3iKsJx7L7pkF1ohX7rwirTSUAKAlkb25SZgTzktUhfPaVUnG9i9RtHLs/UGMV5J
	m9yc8/LEG0KWJoP7yfR4wQlNEa57ox6+pp7WX0VHnFpce/NEoy2oc/nLnH/DWZDAHxLsMMC
	n4z6NPozinz3DrQcfAOMf74WsgE+uvKV2i8l1ij4BJ6eigr7BHqqB2jPsOeYlf8xMmWby2v
	OFmOwqiA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

> --- linux-next-20250710.orig/drivers/net/ethernet/wangxun/Kconfig
> +++ linux-next-20250710/drivers/net/ethernet/wangxun/Kconfig
> @@ -66,35 +66,34 @@ config TXGBE
> 
>  config TXGBEVF
>  	tristate "Wangxun(R) 10/25/40G Virtual Function Ethernet support"
> -	depends on PCI
>  	depends on PCI_MSI
> +	depends on PTP_1588_CLOCK_OPTIONAL
>  	select LIBWX
>  	select PHYLINK

I think "PHYLINK" can be removed together, since the driver doesn't use it.
 


