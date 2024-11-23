Return-Path: <netdev+bounces-146906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C32A9D6B26
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 20:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9CB282066
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 19:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E913C15ADA6;
	Sat, 23 Nov 2024 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f7VKHQcX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFA734545;
	Sat, 23 Nov 2024 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732390628; cv=none; b=R4xq0g6gDl0AxxQLDWY0v2H/hJKhFEJco4mpxwJSbSBo5RA9oX45kHQtzMOUHP1OpFecOnvEvSdnqkZaIKrrX/yHPJWLAlt0rPmR0HfUvZJTy48PdS+exy5YE/97Ujad7FG91tM1JINWdDYrhl0d+DtnM3+36HYkh6zmdi9Y9x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732390628; c=relaxed/simple;
	bh=rngSxhuCFJ+uzlzf5CfSOCccr1oI1Ht4c7AbItbbOL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIXxc99Mu98q7ZkyQ+GR6x0v1wF5cZ7Vj1+0I6ZF9TNXyjNYj3NE6o7l/t1I80GYNiSEYV1Lv2/sVZURg00j/PQmglgIg+oFnS3pGPJQVhvt62p1B83kvsEHVqxlnp7aLFf5e13F4TmuDEvZENNggpF4K1LKaUDBdiAW/Ux0N2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f7VKHQcX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=T451uf3FJRW3SLEQhbuE9Lw3J5awZznXo86Z6PYTMZ8=; b=f7VKHQcXjoUjQG0B/8SLl2ywAa
	FlyQ9YDgnVCPJRO3m+pQ/vUCU8nlx5I9jo0zrrvrguTwow0/SeMCvtzvZ0UbSVKw/CY3MBT9lpuQz
	tyR+1dQ5jtOuiDZvNiF8Vl/8buk9nDoI2jRStRnv8ZkyU28m/gKNqAdg2AjjhgCxBCQ8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tEvwA-00EEA4-B4; Sat, 23 Nov 2024 20:36:58 +0100
Date: Sat, 23 Nov 2024 20:36:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yijie Yang <quic_yijiyang@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 1/2] arm64: dts: qcom: qcs8300: add the first 2.5G
 ethernet
Message-ID: <355ff08c-d0a8-49e7-8afc-2e4adddf2c9e@lunn.ch>
References: <20241123-dts_qcs8300-v4-0-b10b8ac634a9@quicinc.com>
 <20241123-dts_qcs8300-v4-1-b10b8ac634a9@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241123-dts_qcs8300-v4-1-b10b8ac634a9@quicinc.com>

> +		ethernet0: ethernet@23040000 {
> +			compatible = "qcom,qcs8300-ethqos", "qcom,sa8775p-ethqos";
> +			reg = <0x0 0x23040000 0x0 0x10000>,
> +			      <0x0 0x23056000 0x0 0x100>;
> +			reg-names = "stmmaceth", "rgmii";

Dumb question which should not stop this getting merged.

Since this is now a MAC using a SERDES, do you still need the rmgii
registers? Can the silicon actually do RGMII?

	Andrew

