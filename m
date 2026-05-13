Return-Path: <netdev+bounces-287588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKdqHRV6BGoPKgIAu9opvQ
	(envelope-from <netdev+bounces-287588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:18:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9376533DED
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BB753255D0A
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D40F4C8FE5;
	Wed, 13 May 2026 12:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="anv6YcyT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFD34C6F1C
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676594; cv=none; b=EVdxSAJ4SfYomzsdLjkd8a33WhGMrLsbrlbX9sBOQ2qB7VqmfWNzKeYbJxHF3UXqv7a5sIwi1ejcpFaTRN6xTZTE3TfPHE1O1VXISlaJNxBkD89RkDBaBMxJSXjyVLGMIwN5YMWpG3nByF3OvKPNhnJxIHqMUYAdtfppFuC/GSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676594; c=relaxed/simple;
	bh=nI7YOzNufegrzrQMgLxNrwAqGVHXqCpVokhfGj2uJHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXoH5iS15KxoxOS5cT4TJ8pTvAlMvLarcdDHyk7YeE2WqVQlbijD1CQamIE0SUX2rYaKK7tRY0MkuEfkX0wc+OWH5DN/JzpidaTVACIyIJRnppMi9mHmw8A9iu9EiwPn28IGy9qv8wHjnaebWK5xQ+fZOwH1Yqr5lzwf2K5q7pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=anv6YcyT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so42788265e9.3
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 05:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778676590; x=1779281390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u3zF8kES347TPoEbvDwkqQbzfa05yrB1P5lQaxsmy/k=;
        b=anv6YcyT1kkN39tGg5nc5kZAg7zQpsefqN7H9k6nFlR+iDHfySQCgjAqbF1Vit5gd6
         HGvL00FO0ndFtwsAGqbZi7Lq+ftGXgmMie1BQilW144IsLtBbTz8EenRf2GoJtXZXHct
         8L45vMDjh070y3wWVV3Db08kBBIq0CLPhLkZKaHQuey9Hyn9kLtUPM6d/ueYS1lLmDYi
         DWzO+AFK5ewpdDMcSm2BQfdphnr1Dy5xQINNfDbQhJegZhXsUoscwrcjBPJAQ5hersSM
         Dk6KDwz/c9bXB9CgGMtY4vaFx65TH67HQJC9zt82spg6F/gWQGD3VkvQOfMJy9D4lOVf
         BfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778676590; x=1779281390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3zF8kES347TPoEbvDwkqQbzfa05yrB1P5lQaxsmy/k=;
        b=CqTRFSMwhQZN4MKXOYBypzYh/+e88+7W0G0O1q9CB0o3zQi5AQfA66kEnBn9qlN0Mj
         Jz5IAGbT8l3QwAtzSwbR1GIE15WesjRAqEuQIwDJJw2lBISdvCS3deqQMbjgFMsd9lra
         oasOrIBzKT0GuTiV9WXXz27oQa8Vj0l8i47Iy3YSqbb1IG26KlKZZA+6isbxs5QFHtBc
         qV9XpQd9kiN8emXk5H9hgdGKm/Lwuacr/iJaz+cQENnEUYnYFEK70ox8s5DwMyqrER41
         gCcFqV2XCwU+1gXyAAt6F/jyawsjupyAgHL4ym8YDdJhCH9tp1OyOPYmUpfHbnifYZlf
         roFA==
X-Forwarded-Encrypted: i=1; AFNElJ9C35xBbwd+rIZ+CJ2xWrXgKbh6DTI0bsgZHBcj+Dq1/PNgr+m3HL0+ULP84ujwL2JP+lgeg6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTCTmFI1Ynzcr2ciFuXmHaGl6rTICo4w0Pbe7djddv9uD+YRXa
	BP1l4Ye46+i22d6uPqQxZNC1JUnCzsOM/SiShCAqcjpH3VXx6SZIDpjzRor/GAt9gHs=
X-Gm-Gg: Acq92OEIxKWVMlG51dxBJVbvGzutb781QNzdoGdhWc0P0c4lSwSR1TXFxZULIE7wLZP
	P85BnEpkeYMfcf4lEmmUwXGSZvMDyCKZsq5x9HFQ9763K86VbQSd4AwgRKJd2glyaaEgPDVSJzn
	uTcJwGJi+XeY7i9lPYpFns0r2wfLKjO/wJB3Kwght/Z166w6Tk6s0I8osapt22RZiEjEtNUS0YR
	AYDcuI8/X4J84cgc1+B9PMbfjuv09fFLqtfjCkiKyDO1T9+DXmdchIbQMJTJRGxOGXipe4+wmHI
	+eo721WsXhn7saTkkJRXFLe03rhU5EY1PsJnCUQiYpsM+uqGVqKEWNO5JWVPUDohJSyssySGdfl
	WizT/c+/Nz6Q6c4QmvJgBoShtkmOF26uMhAhUF8tbPIvkbPpnPgBir0Um2NVPkA7nSMnULNmTL9
	wdwaVHHJGOA5Mmg2D2ACcqXWTGjEroCUsqZlhPV/ouCNs8ZXUOsdsmXUE8MlVch8Xzfhs8s2ahG
	4Lqorl8oAQgQusU1GpPZxOA20YRkGZyhiJUCHnrEGcsV+hmVsiJpUc5raFhCp/9kESXVVBo28Tr
	R2SP1Ed6
X-Received: by 2002:a05:600c:6305:b0:48a:5301:bb5c with SMTP id 5b1f17b1804b1-48fc9a32aeamr49565525e9.16.1778676590239;
        Wed, 13 May 2026 05:49:50 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8cd49fesm78578015e9.0.2026.05.13.05.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 05:49:49 -0700 (PDT)
Date: Wed, 13 May 2026 13:49:46 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Alex Elder <elder@riscstar.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maxime.chevallier@bootlin.com,
	rmk+kernel@armlinux.org.uk, andersson@kernel.org,
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linusw@kernel.org, brgl@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	mohd.anwar@oss.qualcomm.com, a0987203069@gmail.com,
	alexandre.torgue@foss.st.com, ast@kernel.org,
	boon.khai.ng@altera.com, chenchuangyu@xiaomi.com,
	chenhuacai@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	hkallweit1@gmail.com, inochiama@gmail.com, john.fastabend@gmail.com,
	julianbraha@gmail.com, livelycarpet87@gmail.com,
	matthew.gerlach@altera.com, mcoquelin.stm32@gmail.com, me@ziyao.cc,
	prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
	rohan.g.thomas@altera.com, sdf@fomichev.me,
	siyanteng@cqsoftware.com.cn, weishangjuan@eswincomputing.com,
	wens@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 12/12] arm64: dts: qcom: qcs6490-rb3gen2: enable
 TC9564 with a single QCS8081 phy
Message-ID: <agRzai1UoHEIotZe@aspen.lan>
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-13-elder@riscstar.com>
 <01d6ea18-e022-41c7-a642-ac0321957923@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01d6ea18-e022-41c7-a642-ac0321957923@oss.qualcomm.com>
X-Rspamd-Queue-Id: C9376533DED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[riscstar-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[riscstar.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[riscstar.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk,arndb.de,linuxfoundation.org,oss.qualcomm.com,gmail.com,foss.st.com,altera.com,xiaomi.com,iogearbox.net,ziyao.cc,bp.renesas.com,fomichev.me,cqsoftware.com.cn,eswincomputing.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-287588-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@riscstar.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[riscstar-com.20251104.gappssmtp.com:dkim,riscstar.com:email,aspen.lan:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,checkpatch.pl:url]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 04:03:36PM +0200, Konrad Dybcio wrote:
> On 5/1/26 5:54 PM, Alex Elder wrote:
> > From: Daniel Thompson <daniel@riscstar.com>
> >
> > The QCS6490 RB3Gen2 includes a Toshiba TC9564 (a.k.a. Qualcomm QPS615).
> > TC9564 is an twin Ethernet-AVB/TSN bridge with an integrated PCIe switch.
> >
> > There are multiple builds of RB3Gen2 with components included/excluded.
> > That means whether or not there is a phy attached to eMAC0 depends on
> > the exact board. However all versions include a TC9564 combined with a
> > single QCS8081 attached to eMAC1.
> >
> > Add properties to the existing PCI nodes to describe how the TC9564 and
> > QCS8081 are connected to each other (and to the host SoC).
> >
> > (Note: "pci1179,0220" is documented in the "net/toshiba,tc956x-dwmac.yaml"
> > binding, but checkpatch.pl doesn't recognize that.)
>
> This should probably go under the --- line

I'll leave that with Alex...


> > +	qep_1p8: regulator-qep-1p8 {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "qep_1p8";
> > +		gpio = <&pm7325_gpios 8 GPIO_ACTIVE_HIGH>;
> > +		regulator-min-microvolt = <1800000>;
> > +		regulator-max-microvolt = <1800000>;
> > +		enable-active-high;
> > +		regulator-always-on;
> > +	};
>
> If I'm reading the schematics right, this is only required for the PHY
> - is it collapsible, or does it really need to be a-on?

It could be turned off if the socket isn't in use but it would prevent
hotplug detection from working. In practice that means it can only
collapse during suspend/resume.

However the real reason we jammed this on is because I couldn't find a
way to get the phy/mdio code to turn one on. However it is possible to
add regulator support to MDIO devices by extending their existing logic
to manage resets so it can also manage a regulator. It comes out fairly
clean so we can add that to the patch set and remove the
regulator-always-on.


> > +	qep_irq_pin: qep-irq-state {
> > +		pins = "gpio101";
> > +		function = "gpio";
> > +		drive-strength = <2>;
> > +		bias-disable;
>
> There's no pull-up onboard, should we use the on-chip one?

It is configured the same as lt9611_irq_pin (which I couldn't see a
pull-up for).

I switched the interrupt trigger to active-low based on other feedback
on the patchset and the counts in /proc/interrupts remain unchanged
(with a single figure value). It certainly doesn't look like the irq
line floats when the PHY interrupt is deasserted.


Daniel.

