Return-Path: <netdev+bounces-211507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F79B19D2F
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 10:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1AF81899621
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 08:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28802405E3;
	Mon,  4 Aug 2025 08:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFk8EVyC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8022A22EE5;
	Mon,  4 Aug 2025 08:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754294468; cv=none; b=NkTm6nDy6qAyTutGcNWDEtREbJjbrcENeSx0jXXe8RPGr10ROCKNr0/swIYo8Od204vbrdSMLyB4K4h0j+7Kaan2JZkQtkadUdctTA5KFO9RnODZzZYsmLFJ/BLRNmYSteDQFrzgnIu+kHu8IDpPD8G6CcJ6E52cF80u6RUam4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754294468; c=relaxed/simple;
	bh=IUC1iJfUrd7AunKtWmkJmwmHkxnRPv/v3DmPPsymZkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6X/8ja2jK3UFihmk6/QKgKphIDfiMfa5/825lroP6tdltrgJ7ErA+0zsB39KWyF9f9m0jtEwsT/gW9mmMY9H/VWkGGcubuJ5j3aRvZ5W3JGW4jpFQOlUxKTTyEKEbA1V6Xq54qo8Uu4lpHnGoit7/mrEkeqvBh/lXWoBzPGZU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFk8EVyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE21C4CEE7;
	Mon,  4 Aug 2025 08:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754294468;
	bh=IUC1iJfUrd7AunKtWmkJmwmHkxnRPv/v3DmPPsymZkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZFk8EVyC8WyOFWr9EuqFJb4gE9rbRd66yJpsqj23C5H/6Iv7HnMCua18J0kb9mpv+
	 UWp9hjQTUiuXnu/NUizzYJ2+ulFJGfYISP8YwQalLk08xNIVi+ZsBDO8+tHudPjUv8
	 ya9j+2DCNmpiZ+ceGMjWflFVpsyMPW9WURMda5e88Rxx5Z5RmN0/4RWDUGEQ5xSSWM
	 NrWpkfz09NHvfdDFJqUN0vdcktEEKFxua06dMQH6zLXYLTd2+4qfam+rH3V3izb+F7
	 Yz4MUfkRvR1Se/+sfL3szSX0xJvIKzgnj/0dUMHFBldtBdClcoKxg8Zt6+8K5xdOQZ
	 nHVHTdm8sqYCw==
Date: Mon, 4 Aug 2025 10:01:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kernel@oss.qualcomm.com
Subject: Re: [PATCH v2 7/8] dt-bindings: arm: qcom: lemans: Add bindings for
 Lemans Evaluation Kit (EVK)
Message-ID: <20250804-loutish-swallow-of-defense-2a2f8d@kuoka>
References: <20250803110113.401927-1-wasim.nazir@oss.qualcomm.com>
 <20250803110113.401927-8-wasim.nazir@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250803110113.401927-8-wasim.nazir@oss.qualcomm.com>

On Sun, Aug 03, 2025 at 04:31:11PM +0530, Wasim Nazir wrote:
> Introduce new bindings for the Lemans EVK, an IoT board without safety
> features.
> 
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


