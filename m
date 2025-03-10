Return-Path: <netdev+bounces-173400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C1EA58A86
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 03:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5FE8188D771
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 02:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE8E19DF8D;
	Mon, 10 Mar 2025 02:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BvcY1dUm"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7529F5D477;
	Mon, 10 Mar 2025 02:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741574524; cv=none; b=Txu6mM7HCt/oQ8JZT4HSZh6v3rOctxYdCVhWZpuN+X40l44ZqqBzarxDwYdDCO4FZwLxi8r/M5cWm8TFnKgDX5prs661tpxnaSdCpnpfkrnBefZUUCLhhQEnVUU9iMYhmcO93I3qf67PpVZYMSDAD3pDPwmpn9JoCps2maxcF7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741574524; c=relaxed/simple;
	bh=3SRpyOgA9duRpslajNlpqiBZkn/Z2zcniTdYt3dUNoc=;
	h=Message-ID:From:Content-Type:Mime-Version:Subject:Date:Cc; b=lvTtsYnwd1TjX4zua7hpYvfYa/TPM1MNyQuqrcDLkvMJf42r2jCrSEKlqi3cIIHDYBGshnap2XlcuulwvRMGBlwY2K57zt287pUyKwZPaRxq7UkunekMRt8PNfVifQNzWtjI4NShxsVPeeEgOAvDMGVW1oT5yyMXZrpbqV+pswA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BvcY1dUm; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1741574510; bh=2Cl3tRVDq1qbWu7JTBmfEOnx9DOF9EVPFt7Dzu8ttYA=;
	h=From:Subject:Date:Cc;
	b=BvcY1dUmmiIT7yz+4yH8mi2RI80HUX/tduQmhpr0/YZfYo08HXBbXPw/9o+HYMCC3
	 EDFG2e5JYH7b3Ysz3wvb3k0sWJiW0Y+nZ5cMO/RwxTp4lw+WPArRFMCkxwTwdm3D9/
	 gT6n/oI6dRU6lQiue0zNaW0NPFlWIifwXi13d4DI=
Received: from smtpclient.apple ([183.173.12.99])
	by newxmesmtplogicsvrszc11-0.qq.com (NewEsmtp) with SMTP
	id A27AB480; Mon, 10 Mar 2025 10:40:39 +0800
X-QQ-mid: xmsmtpt1741574439tsfyi9s9c
Message-ID: <tencent_83CBDD726353E21FBD648E831600C078F205@qq.com>
X-QQ-XMAILINFO: MQ+wLuVvI2LQxFfzNhMpuBJtr5I357/tGpIXmnb75pGtRkxeoLpEC/r0m5dmaH
	 RpvcoVm3J1zK5+QQyLz7TEywmTIqu2L7+JvRyxSzFP9P/WBFv6/hBQ1Q5JJ0zipOCmiZjhLBXthi
	 /WHfFYUMNQc3ZObkUCBPIiz3kS3U8fiDog1hgwoqiIxWG3fXwHfKdbFGbGMP6mHt/w013JFqnZkt
	 o1qDSLadRNf0hrnIpIhPT2tl9vIX7M/u9uA+gUVY1te178Aua5PHmp7RF8hQ+VDjYx4vLf/OKR53
	 IGcuqmtRaTLNiO7d0Guastty1s4qAJbQsgunMlnLORFX63llbWaJ8f5mdHfFDEpwmymKpUxCNIg6
	 CCo30IVBopsjCvAykh2ggzmZ+Z4heMkloDbvMNVHFuZ4C/GRLPMG6NYXxttM5pjC8X1z7phkoh+0
	 cQlyJ7L1dZY81narQVHdzbmQ8yXeLVsqdyAeHFO8D036RGp0cKFXn5RRoBKLCqQAg9ZCotHgUvdR
	 UNxFXqtpGEQQmxbUXgP6XJDOH9LXuwJ9xZYCKwhgIGVj5dBacRbfswcMkv6B+MWaVKrcVTePl/BA
	 e/pt8Ut29qpoC/7Q/AGBPW9jbY4LVOrNU805EKSDDblUg053G752+UEGBEaJBdCNo+7TjHeo7k0B
	 G5MQKupLIHjjSQC0aRFD5aGiw2Qgn023wQqy3w3tYIJSfMK9LaMZMzoXB0r2tznTV8BdfLPwadR6
	 H49UyHSsaEKChr2mcr7KeU7mzDMWpjytCP3jJdaJHioLCL7kRS+2HKhlmPA6LHuhVITkGY4IgnLc
	 UQblvhGxq8sBKPmjXkMow6cSYYpmHHAuEwLGUaNu3kEP9LldoLZEo+srDhm8lq88ElLSvfArKK6D
	 Yjdb/hKq869H1Ut9fqTRP6oE1Shf+nl4ELIgwmekB1iNUrmJKNccZq7Ug0vcwMSi1bqNX07VhXXT
	 0e/MJRGUiFZzmkiVmb8ImTCIYPmC1ixxjpKnhZAuCfRIFaYPlbU/X7QRxR9sMB
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: hanyuan <hanyuan-z@qq.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH 1/2] net: enc28j60: support getting irq number from gpio
 phandle in the device tree
X-OQ-MSGID: <83925314-B455-4BA0-947F-DD0F6685DC2E@qq.com>
Date: Mon, 10 Mar 2025 10:40:29 +0800
Cc: netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3826.400.131.1.6)

Hi Andrew,=20

> My understanding is that you should not need most of this. The IRQ
> core will handle converting a GPIO to an interrupt, if you just list
> is as an interrupt source in the normal way.

> You say:
>
> > Additionally, it is necessary for platforms that do not support pin
> > configuration and properties via the device tree.
>
> Are you talking about ACPI?

Thanks for your review. Let me explain them.

I understand that specifying the interrupt as:

    interrupts =3D <&gpio2 23 IRQ_TYPE_LEVEL_LOW>;

would also work, and the IRQ subsystem will properly handle the
conversion during the SPI probe. However, my problem is that the
GPIO pin itself needs to be explicitly requested and configured a
an input before it can be used as an IRQ pin.

My embedded platform has limited support, it only provides a
hard-coded pin control driver and does not support configuring
pinctrl properties in the device tree. So, there is no generic
way to request the pin and set its direction via device tree bindings.

I noticed that some existing NIC drivers solve this issue by specifying
`irq-gpios` in the device tree, which ensures that the GPIO is properly
initialized before being converted to an IRQ.

That was my motivation for these patches.

And my changes are not related to ACPI in any way=E2=80=94they are =
mainly
focused on device tree handling.

Thanks, =20
Hanyuan Zhao


