Return-Path: <netdev+bounces-218141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 348AEB3B469
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 09:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653C91894E1E
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 07:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B4B26FA6F;
	Fri, 29 Aug 2025 07:35:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B7C26561E;
	Fri, 29 Aug 2025 07:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756452902; cv=none; b=T56vNAUt1qaT+DEO9gf1H+PgFHC/znz11Vh/zDG9aFqA+OYu2MMhvVYp/HshqGOzpuFf8DZ0eBk13VNsHA6yNk4Uo0CHNB3I+zdkuQPflNhJIhpHL5JX3bhDgpsMZpjd/EJ0UQzTmyBRCMrTl5unRLFOOT2LQdS4MoxT0P49/2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756452902; c=relaxed/simple;
	bh=+WVE46uuvxctaL0w0YnwCtu/IBm/gh4OIN3YtU/QZ8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzO3RbskaVOA+Vl6YNppVtO6V5y+gxe9SHmRP1Fs7YTeRKmDSGb7w6rsPc+T9UCZkhkdTMx85lLY/MxdZHyOyVb9q3W9orvqrAZbvOvjsZZqCHXaU8bzWy8RAZXNpcgham9vExE+mOMjOWTgqUQyQOWLDliHqpk2sM5k3m7jZB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29321C4CEF0;
	Fri, 29 Aug 2025 07:35:00 +0000 (UTC)
Date: Fri, 29 Aug 2025 09:34:58 +0200
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Varadarajan Narayanan <quic_varada@quicinc.com>, Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Anusha Rao <quic_anusha@quicinc.com>, Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, 
	Devi Priya <quic_devipriy@quicinc.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Richard Cochran <richardcochran@gmail.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com, quic_leiwei@quicinc.com, 
	quic_pavir@quicinc.com, quic_suruchia@quicinc.com, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 00/10] Add Network Subsystem (NSS) clock controller
 support for IPQ5424 SoC
Message-ID: <20250829-versed-gazelle-of-tempest-edfbf1@kuoka>
References: <20250828-qcom_ipq5424_nsscc-v4-0-cb913b205bcb@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828-qcom_ipq5424_nsscc-v4-0-cb913b205bcb@quicinc.com>

On Thu, Aug 28, 2025 at 06:32:13PM +0800, Luo Jie wrote:
> - Remove the Acked-by tag from the "Add Qualcomm IPQ5424 NSSNOC IDs" patch"
>   as the new NOC IDs are added.

So let's wait for v6 with acking :/

Best regards,
Krzysztof


