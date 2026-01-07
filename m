Return-Path: <netdev+bounces-247636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7E4CFCAA2
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 09:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8024300CBA2
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 08:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0B6275B05;
	Wed,  7 Jan 2026 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zuEF6uCZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4643B2AA
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767775325; cv=none; b=ibIvldD8SRTkAoypDywp4XcoFWwvZkDaooPgl/ct+F1c/JgvCIxYpXEtTNj47paQ286FgoXMMlg36v36dwUXe7LQQdeSLMpMA2HKoEU8/0F9100JvSpeqzcaA0dAf8gpNb/tbuPBuVj8JtME2hwPyd9gv/zkqNreyfwFdD9k6iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767775325; c=relaxed/simple;
	bh=Jbk8UjGHnsETzYNHAUM6QTKUS0ds6ZJA/ImjJaUZeJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PITRubweOZv/Z1UdhZ4/OMrgTKYJ7em3AeEgk0+OZ6OaWIYN6VO0XuUAFkRxILa5BYAV548za2Zhk3xIOLXS/hRUYvbM95g8VGsSskVQPiyXdMiBu5IHKJO2d9cmg32vUYjO4gf85g5uW6BRAlNvwQCPm3j113P6bF5kEQMyW2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zuEF6uCZ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2D53B4E41FCB;
	Wed,  7 Jan 2026 08:42:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E323A606F8;
	Wed,  7 Jan 2026 08:42:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A9889103C84BF;
	Wed,  7 Jan 2026 09:41:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767775320; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=S6R5YZXnAQ2jLJpBkyeX/V5VN7/gW0xtPNeUE+gg5Fs=;
	b=zuEF6uCZEW7MAHhZSfYimtePz4dneRVkvsfmd0IFWnS95yRuVQsF9TBXvExxudranQSWB0
	SEkKGmgO6eJIuzbaMi7rV2Bgj/T539Lq0xtJvJt3inSLgNdG/vmh9fb6z2MIgIVQ8YG0um
	wbs1nXmajdpv8IGBU+ehdoe933Tei5wVDoYE8HOesWiJIgx5yszMDQkZ5TVfx5bOShcDMI
	Ad+LaOiIgVvuEC3oP4YDclRNs26m4kVsPb2HREsmVyLc9inzlc7c4DbAFOh4o+mXthR07g
	Kp2VsNImixkFYhhdmICTMZ6Nzfqqxnup8SZiu5NnpQ57KFLXGOo/4VN9ufdKfw==
Message-ID: <0b5a9cb4-3d35-4650-b482-29b3c780ed1a@bootlin.com>
Date: Wed, 7 Jan 2026 09:41:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/9] net: stmmac: dwmac4: fix PTP message type
 field extraction
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aV1w9yxPwL990yZJ@shell.armlinux.org.uk>
 <E1vdDiA-00000002E1W-2X6U@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vdDiA-00000002E1W-2X6U@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 06/01/2026 21:31, Russell King (Oracle) wrote:
> In dwmac4_wrback_get_rx_status(), the code extracts the PTP message
> type from receive descriptor 1 using the dwmac enhanced descriptor
> definitions:
> 
> 	message_type = (rdes1 & ERDES4_MSG_TYPE_MASK) >> 8;
> 
> This is defined as:
> 
>  #define ERDES4_MSG_TYPE_MASK            GENMASK(11, 8)
> 
> The correct definition is RDES1_PTP_MSG_TYPE_MASK, which is also
> defined as:
> 
>  #define RDES1_PTP_MSG_TYPE_MASK         GENMASK(11, 8)
> 
> Use the correct definition, converting to use FIELD_GET() to extract
> it without needing an open-coded shift right that is dependent on the
> mask definition.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

