Return-Path: <netdev+bounces-254806-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JK9Kllie2l2EQIAu9opvQ
	(envelope-from <netdev+bounces-254806-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:36:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 741D9B072C
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B051C30055C8
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F8528851F;
	Thu, 29 Jan 2026 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T5ICcfme"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B0B1624D5
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769693780; cv=pass; b=O+AeBplKEzeziGsfwKYoDFzc7Z7s3a6qNwd+t6I4pHbiFdN+rFfWK+bRSWXYcpOeMNX2jO6iMtV67D00SQRTgA1sqZ9I+I8k3E4xkzG95fx3BEvqrJMbAPQaecOkdLalTs0UJwffU5MCW9kaq5fcu/fSLazYoysmrQOY7cra4vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769693780; c=relaxed/simple;
	bh=T2/nv8JV1Ds7KRLfYUddoQsiK5wsxE0Be89T8jD7vSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agH3C77rx0tyl+hNioe46P2MGoDhhUTviIERlks7s7ipGKtmhueFTOfkBbPkgaikWKzbSKTlhQoQB23d8dG/gFLW5sZqGgFm1ga2Kph972CbZu6WzgbKinlB2iKpbk9yQ/7jykNDxuNeBMrDD7C2O9ueKUf36qp+N9QYZiSOHsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T5ICcfme; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-124afd03fd1so1426158c88.0
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 05:36:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769693778; cv=none;
        d=google.com; s=arc-20240605;
        b=N6/c+Z6Xsco5m21NmD6bGKR/k5yn25EWusDWNF70R2Io7eJRiZvkLFFEO2q+6TXz1V
         AkKwji908OrMUqaFHQ05AwV9HIJ9c7Z3qu9uCUFl/KQHLI7/n1QwaV+0x8SVCyPl+oXW
         JK03xMoIP5OdzURkG32NHBJYCBCHCH4vE1ODe+DK4d/NCinviB6V6BGSiX+dqPd0hTZh
         jubtWBWX002cdV7i2fJPsXm5dUX3CnNrGK1jQQEhD4gQ3Zpi/Ciey/cPahUwY0VBg/Yb
         BmsaJJdglHL5OmZ53Cea1V9DptL4v/QApJM6ggQ9OKlYqkQ9qNrpK+La4ssnBFzWeQ4K
         vxww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OUbc9YmxzZyQuCfYvCcWLpHnYb4bvtYeu1C4sFcAeps=;
        fh=Hz2ABQ4Y6unNqXnS5fFhd0QjTG9a/Bpj/Q223GFrA+Q=;
        b=Wt3wrbp0vtDy+jN8zpvL515tR8CEl1uyZdFGEkNcxWjQEzEDbEOAm09xLd+y/JayZK
         waWNMUpI2FuB8Nx9o+mamKvfp/d6XPV4PPUf1g3qcvmVQRdN+g7qc0kMdT7ZQ1N750Ej
         j2RxHzCbhmT4wDiwFv10TTshZNSd3DMjQc/xlls8c/R5lspe/nbdV+g6spDxb9Xu/4B4
         BuVmhdQfWnSANT6822SsDEJjaT3a3yun+1JpzzNmfsioukaHJfqhaB3mElTOjtoamgI2
         HwEw4YfV6sn9bKQ0qEYvUp+pTMOiLfc4RTgBHySVObH7sPc4Zfk1rZb7H3tm/BWctChy
         QSDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769693778; x=1770298578; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OUbc9YmxzZyQuCfYvCcWLpHnYb4bvtYeu1C4sFcAeps=;
        b=T5ICcfme5PXXSgw9Qv+6I8Lw7XKnEUotqxEMtA8YOwGevsQKP95VFpo5Xc4R/CLV2e
         c7HtnAYqxmPiVtDWPMZH357V2Fz6L8vLZtvcNs9RU1fACvI9wztDtxoH0q0QwMzUZim+
         bV/KxBJh890z0i+I1Pjy2wjc/dCXzIIsiQbcj3jw11STsqUT+Nz88QMUVLDqDifWHIRh
         2qyMdQq72IdC1mgtO7F8PcIy/II62nlSy4wQb23HSF3/93wfGkyRAw1ObALGbyo6V/HC
         /9wcEDrqFcSTJ43zIErTPrya0NdB7cRdRmyM5cisajd/A7SGBzcUvbdfUFvKz0QO8KT+
         tUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769693778; x=1770298578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUbc9YmxzZyQuCfYvCcWLpHnYb4bvtYeu1C4sFcAeps=;
        b=LZhsvJI0xykweklnSslK1WQpRQUf/z+9aY1TccFiM/nX2PNgOQnEdq7T9C6X2S2UHn
         f61yEmXcDeoNNmatPfRsVTKyw+b9B8Ys7hHqZARJmVeo8waUzDPo3Q8jMpnqsyrLxIbJ
         YjZLVXh5SHl7GufouG+kyD55nPCHUtcDostqqg60ct38YZral/Knv06XFJDcdjSE+ftq
         iqTM3Ul686tq7omfsj9k8ZOQX+6cjbeymoxh928vqa7VjfOIsosig+isgUwRMM8WFxAj
         nbRTNzrriTyafsQGrkldxrDxRvZesz1k4SQIyzlFPlD2hQcLHAwzutTrtpNhqzJFFGcr
         tJhw==
X-Forwarded-Encrypted: i=1; AJvYcCWh6kMfWBfJUa5oRUaLCRA7GuCj22uByuMuOcHRK0fWCblMt3F5iulnyNneAfEwJ+bGEB85tww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRXX1Fpy6HYARZxkqsxeUJMgCdspukilvW+1hmKYTxy8UrWD3O
	oCe9qqGzn89cPnAPm+AKIJtnaauw678hqy/3WR9CebLdoMT2k33RtGC+nHtXiEniU2///j9udIx
	v4OylYwcEcXNsO0AJfRxiYF4nE8nfxFJ44bQl5QOJzQ==
X-Gm-Gg: AZuq6aK+FKSFBNOebf8q+w0Ym46BgKczj24QAd9CUiUA/nNm7FJDkGkFfsYpcIvgtR/
	xN6ZbCdhRU48UFY6HF78s/dqfBN4s6221fC4tRlf9qaxMsLKwRoO+KIH7C8B0h2BrWKKVlDPCDD
	PPuhrm888CA3SPzAIMPoOlw3fxFDku75/Bg1+lIWXXfk0csEBLzJw9vXMytv4t0A3oTEVVljcQ6
	WDz3aY0bijZtHTjhFQn/wZLxpccfHN5alvqTqGCWI2Jc4gncUYhF3ww94pJyqrlgcsSaVuk93oO
	Hr5EkCcfH9xzQfoXfe222aQW
X-Received: by 2002:a05:7022:b8f:b0:11b:923d:7753 with SMTP id
 a92af1059eb24-124a005f58amr6177136c88.3.1769693778067; Thu, 29 Jan 2026
 05:36:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126092159.815968-1-vincent.guittot@linaro.org>
 <20260126092159.815968-3-vincent.guittot@linaro.org> <aXsuRTZUUnw0kdzV@horms.kernel.org>
 <CAKfTPtDfnpzq2CB-isVzvh1ZCWo7kit9KRJvVGoU1C3zZTgdXw@mail.gmail.com> <aXtfVUb0eLwP4R28@shell.armlinux.org.uk>
In-Reply-To: <aXtfVUb0eLwP4R28@shell.armlinux.org.uk>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 29 Jan 2026 14:36:01 +0100
X-Gm-Features: AZwV_Qg3uPvaKNdmIviHyRFKK8XsxTqMLqCrJ58tO3_TcY5z3DRE4t2Ah-LnutY
Message-ID: <CAKfTPtCiJcNOdoddZN5N1dKHXfUJBe0=zeWfZ5uENoXDvbMnpQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] phy: s32g: Add serdes subsystem phy
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Simon Horman <horms@kernel.org>, vkoul@kernel.org, neil.armstrong@linaro.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, ciprianmarian.costea@oss.nxp.com, 
	s32@nxp.com, p.zabel@pengutronix.de, ghennadi.procopciuc@nxp.com, 
	bogdan-gabriel.roman@nxp.com, Ionut.Vicovan@nxp.com, 
	alexandru-catalin.ionita@nxp.com, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	Frank.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254806-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.guittot@linaro.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linaro.org:dkim,armlinux.org.uk:url,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 741D9B072C
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 at 14:23, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Jan 29, 2026 at 02:01:13PM +0100, Vincent Guittot wrote:
> > yes, the usual pattern is :
> > - phy_set_mode_ext()
> > - then phy_power_on()
> > but I can add an additional check
>
> Please read Documentation/driver-api/phy/phy.rst section "Order of API
> calls" which suggests phy_set_mode_ext() after phy_power_on().

Fair enough.
That being said, all pcie drivers  that use phy_set_mode_ext(), call
it before phy_power_on()

>
> Having different requirements for different SerDes PHYs quickly becomes
> annoying for users of the SerDes PHYs.
>
> E.g. I'm trying to add SerDes PHY support to stmmac, which is used
> across different platforms. Having all SerDes PHY drivers behave the
> same as far as their PHY API calls are concerned means that the whole
> point of having an abstracted interface is maintained. Otherwise, it's
> completely pointless.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

