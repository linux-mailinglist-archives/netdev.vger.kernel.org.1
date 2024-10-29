Return-Path: <netdev+bounces-139924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E21679B4A22
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 13:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4B51F22D52
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 12:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3351EB9E6;
	Tue, 29 Oct 2024 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g28+V//i"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E90B8F6E;
	Tue, 29 Oct 2024 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206216; cv=none; b=a+AuTkRYpf6G5NImhYtp9emdpSq8wRXVxBFgisBF0ESm9sMSqMgcULJ9wRG8UG8H0uUxbh0xspbNbYEDShJ52k4pC+haX0LKU6TNy+G87oO4F+VZBHO6+RgARty2DfC4KPoJyr6wwoZkKsQAauUvhWjRk5Ol4IJP7kAJVtOH54k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206216; c=relaxed/simple;
	bh=MlzbTF7Jl3zPw6NFycmFTVj7+8NV3jAQh+qkg5T97RI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skoBDbeXwdjUB4AYdnxopgG7pd2aP9cteEH9/RgujR1TAGb7C6BFrbs8lN7/hrYuIKFbH7GUeJ6bA8WPcydSC/tTyd9tnxUS0FABa4DZe9sLr46HYiVt4L2K+mim9inAWEwGvpYtPbdCw4+ZbB6gTsfJAv5V1929dN7Mi41GImo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g28+V//i; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B976A1C0006;
	Tue, 29 Oct 2024 12:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730206211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gB3WSdXjO7v/Iei9P2xSNx89xruiqhNe99fDC+mG5Po=;
	b=g28+V//iv+dZW0GMwuHLqnAZLIYhrPMLE/30kYpzXbU7iSDONAE1h8nzDO1/zqxtJ2RP6/
	aFtkb9n8pfM5Sl8keTKm6+06VRwzs2MjQE59ywRQzU+P8zsG5CkGN/N1OpcHY7zhR91WfZ
	Ni0W3Frrw1x0asdiWU4VLTLkVC/fNDFhIZ4GVYXBAiu30H9KumYpIInvZaQ5fNzx4ygIoH
	eCH+gsa74e/NfromDTeQJ9mleEDF4PIoPeBtr3zrvJsUORUof8E/+IZQ/sanSp63RfN7g1
	mLpzBjNlQ9IpY21e0ABIMQ6S2IhxnwyOR8Co7II0RGjR/eraRfg36zm9ZrE5pA==
Message-ID: <1ca44f81-8c09-4745-939b-a29699fb937b@bootlin.com>
Date: Tue, 29 Oct 2024 13:50:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/7] net: stmmac: Only update the auto-discovered
 PTP clock features
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241029115419.1160201-1-maxime.chevallier@bootlin.com>
 <20241029115419.1160201-4-maxime.chevallier@bootlin.com>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20241029115419.1160201-4-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Maxime,
thanks for reviving this !

On 10/29/24 12:54, Maxime Chevallier wrote:
> Some DWMAC variants such as dwmac1000 don't support disovering the
> number of output pps and auxiliary snapshots. Allow these parameters to
> be defined in default ptp_clock_info, and let them be updated only when
> the feature discovery yielded a result.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

nit: s/disovering/discovering/

Thanks,
Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

