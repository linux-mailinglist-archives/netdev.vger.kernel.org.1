Return-Path: <netdev+bounces-263117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPw6FNW7pmk7TAAAu9opvQ
	(envelope-from <netdev+bounces-263117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 11:45:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7AB1ECE75
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 11:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 231783049720
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 10:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502AF37FF5A;
	Tue,  3 Mar 2026 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="Ed+TPOC+"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FDB28506C;
	Tue,  3 Mar 2026 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534049; cv=pass; b=h+len7Sh1+LTF7kOJ8FW8+5f6DphY+PUQAYgFmuBfigdEXigfRKUcFmLjqO+6gqxyOPQ68280MEQhJ3o8TH+kWWP18XGAUZcsdA8ODVr6vZlEfCuNhjkMsvA2dOPD6x+k8WVanxVQM3GvretFz0LMne2yjlxw7BwmtfE5ZoghJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534049; c=relaxed/simple;
	bh=YtM6ZAhf2doLYEzWj9OT/mOFfWPnVR0fzUHchlepzRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9B5g5o+tnwpA5VxZO+tfvJSy5GvZvx0DW5U0UMqOLoVbM2XnqV9ZiKqLmCukt4ZTwR72qnQrWSu1vU1HhnaqkYlSO9FEuF2CiPmsTnhjcsdrVvUE02Ks2w/NL2PxFRjIzDtde8l4tLXCY+QNH2fj/gwRxP1UTOqwBoTDsyX4Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=Ed+TPOC+; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1772534002; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VQOMfMUATbLwFue8XJSnkr0LD2wH17JwAI9UIvOezcp+iYBiGn5GMa8hTuMXp98SlSh/JhYh13tXhXuLAbpRyw/qkElSn3m8lgy5jacaqEhjGNJrVKa6neymwYkzn5ZgdRG7MyiOpoJepPo+cRqtWFSDv/jhzeFwLIufTmPYIL8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772534002; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PbCy8PRJgxvl7inL/4lV7PwnbNxjPe8sBUP9fng+MLM=; 
	b=DZZawfMRM3zu95Z/jVMjT57aYA93Ay49vX/9a4FqMW0KSN8Aeed32scT61B1Wy24ZuRPBRdZ+uBOhvrlwA4qJQAdYPXk2Hd9+ndhRJ/LpFOSIr4QbmxxOcdGvacdoSFjTPBxfq6rYJvQ82k36V4DvCxiz+0X2EA4+4hZWdbA6L8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772534002;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=PbCy8PRJgxvl7inL/4lV7PwnbNxjPe8sBUP9fng+MLM=;
	b=Ed+TPOC+fV576dF8loSHtbyPLzFwTZiwE0U3kbDDyPrHVKq6ZFnKJa28v9G8oUb+
	WWsd5SV+xqHo4DPH1RnlroVnd1c2xuRVvK3sicHFl7Pc5e8uROzOBQYoviysuCllr94
	mU8FGSwcwae+mgp+QB9IeMYgm7ZVh1qXi5GsYWtY=
Received: by mx.zohomail.com with SMTPS id 1772533977967751.4643569015835;
	Tue, 3 Mar 2026 02:32:57 -0800 (PST)
Date: Tue, 3 Mar 2026 10:32:38 +0000
From: Yao Zi <me@ziyao.cc>
To: lizhi2@eswincomputing.com, devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk, wens@kernel.org, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, pritesh.patel@einfochips.com,
	weishangjuan@eswincomputing.com
Subject: Re: [PATCH net-next v3 3/3] riscv: dts: eswin:
 eic7700-hifive-premier-p550: enable Ethernet controller
Message-ID: <aaa4xodVNaY0gmBA@pie>
References: <20260303061525.846-1-lizhi2@eswincomputing.com>
 <20260303061732.918-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303061732.918-1-lizhi2@eswincomputing.com>
X-ZohoMailClient: External
X-Rspamd-Queue-Id: EE7AB1ECE75
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [9.34 / 15.00];
	URIBL_BLACK(7.50)[ziyao.cc:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263117-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[ziyao.cc:s=zmail];
	FREEMAIL_TO(0.00)[eswincomputing.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com];
	GREYLIST(0.00)[pass,body];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ziyao.cc:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@ziyao.cc,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[ziyao.cc,quarantine];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	NEURAL_SPAM(0.00)[0.987];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ziyao.cc:dkim,0.0.0.0:email,eswincomputing.com:email]
X-Rspamd-Action: add header
X-Spam: Yes

On Tue, Mar 03, 2026 at 02:17:32PM +0800, lizhi2@eswincomputing.com wrote:
> From: Zhi Li <lizhi2@eswincomputing.com>
> 
> Enable the on-board Gigabit Ethernet controller on the
> HiFive Premier P550 development board.
> 
> Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
> ---
>  .../dts/eswin/eic7700-hifive-premier-p550.dts | 50 +++++++++++++++++
>  arch/riscv/boot/dts/eswin/eic7700.dtsi        | 54 +++++++++++++++++++
>  2 files changed, 104 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts b/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
> index 131ed1fc6b2e..d558f0fdfb38 100644
> --- a/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
> +++ b/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts

...

> @@ -20,6 +22,54 @@ chosen {
>  	};
>  };
>  
> +&gmac0 {
> +	phy-handle = <&gmac0_phy0>;
> +	phy-mode = "rgmii-id";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gpio106_pins>;
> +	rx-internal-delay-ps = <20>;
> +	tx-internal-delay-ps = <100>;
> +	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";

Since it's implemented in the DWMAC IP, I think the mdio bus is
SoC-specific and should be put into the SoC devicetree instead.

Regards,
Yao Zi

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		gmac0_phy0: ethernet-phy@0 {
> +			compatible = "ethernet-phy-id001c.c916";
> +			reg = <0>;
> +			reset-gpios = <&gpioD 10 GPIO_ACTIVE_LOW>;
> +			reset-assert-us = <10000>;
> +			reset-deassert-us = <80000>;
> +		};
> +	};
> +};

