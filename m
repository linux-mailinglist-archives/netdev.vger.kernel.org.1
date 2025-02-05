Return-Path: <netdev+bounces-163080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62246A2950F
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B3F16143B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED70F186E40;
	Wed,  5 Feb 2025 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="j8IPL+Du"
X-Original-To: netdev@vger.kernel.org
Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DD5156C5E
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770164; cv=pass; b=X5tgQetNagAGlWIiYMBcH3nXlaVJXVbtkYNXTEa4Xm1nMHGBw8Ny6bVmY767r0c8R084j7qrsvLIm8rthQkscHwNkq4VCZgwCyZ+nPERBKJdq75c6YV/73wB835SlipuXiYCrlTjweVJHNMuTNCWSsVimrLO9lG8fv4NbDQ/Ltk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770164; c=relaxed/simple;
	bh=YxqsoO5YRFSxRwF52mpSuo5ohU/ja/zCcFmdgD0i/xY=;
	h=Message-ID:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:Date; b=bU74WrESr22ErntDTe5D6RNe4osFp+IN/VXcFLzz9uxpm8Nw3BTQP8F1zIoqnXHzarnmS3Pw97eqziaymQjL+b8B/YC4zBl4HQUsIRNLvLUE6ejNxLkbRcRxSdK68ro5FQXrFj0ui89ZPqj03sxgEGd/3m2Tvp3N9107udeI/gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=j8IPL+Du; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
X-Sender-Id: hostingeremail|x-authuser|chester.a.unal@arinc9.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C48B890122A;
	Wed,  5 Feb 2025 15:42:41 +0000 (UTC)
Received: from uk-fast-smtpout3.hostinger.io (100-119-10-57.trex-nlb.outbound.svc.cluster.local [100.119.10.57])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8C5B490333A;
	Wed,  5 Feb 2025 15:42:38 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1738770161; a=rsa-sha256;
	cv=none;
	b=OsjNgaApkZXHkKD/sbtUQKjQRhGJ2Zq4aYcD2R2LQ+7V4IHpBZY5MnRt6cd4THcDWdpqrp
	0I1dewPpzuBAhBfRcxTDAR/ECYZKlUjrrsQe8cv7UzXK7Ywd0AhHzELZLzRgOS/uouqzlS
	IJRtyxwnw12iBOZrjnnvhtsU+ZyRYaCdErq3wk9cRDtnNLqgqhwnF4c+MwEl045EZkLX7e
	1oHp7JYLGgdpcL+yVMdYNVXPCG0XGtLj/QWQhx7hZgK77iH+aDxyxlZoPT5uCQSD2SKda9
	izXxs+Qszu/KZrbdp7bzXQUh4QH8heR9CNQMq9DfHGFF4a3QUMI40Zw2wAS4mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1738770161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=YxqsoO5YRFSxRwF52mpSuo5ohU/ja/zCcFmdgD0i/xY=;
	b=t6+W/vx5mso4vB+SWRCH8lmC9dKhTPMhggT7XrhJ96mbDPYsnXo/jUXSMIjceYy4/dhu6w
	8y3jDg5870/ubnGlERD0ICP3XjUf+xZ8waOCaK1rBR+QLmcaWxnEJ2FHUudIVMNpHmGA3c
	BYLnPcW0PgviCjLkB3fVrB84L1kBJ2HVHF7MtC3JPMvsi4wj9jto1Wtsy+dZ3lvkWV4sVc
	TeEEYvH9Bcd15zkE6/RhvMNP+6NrcbNjVqVlRGpfOCVDU9aFW5o8/j4xvOQeHNC0P7BezG
	cmd+HlgTFx3YJf4AGN8LVyP8C67sdFO71FzKYw+ZoYWrMeomwduRGJXJN9PxHg==
ARC-Authentication-Results: i=1;
	rspamd-854f7f575d-hc7pr;
	auth=pass smtp.auth=hostingeremail smtp.mailfrom=chester.a.unal@arinc9.com
X-Sender-Id: hostingeremail|x-authuser|chester.a.unal@arinc9.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|chester.a.unal@arinc9.com
X-MailChannels-Auth-Id: hostingeremail
X-Keen-Shrill: 6d08bb6615a96223_1738770161601_1876515665
X-MC-Loop-Signature: 1738770161601:354085814
X-MC-Ingress-Time: 1738770161601
Received: from uk-fast-smtpout3.hostinger.io (uk-fast-smtpout3.hostinger.io
 [31.220.23.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.119.10.57 (trex/7.0.2);
	Wed, 05 Feb 2025 15:42:41 +0000
Message-ID: <10de11cf-a443-472e-aaec-df9e2ed54090@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com;
	s=hostingermail-a; t=1738770156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YxqsoO5YRFSxRwF52mpSuo5ohU/ja/zCcFmdgD0i/xY=;
	b=j8IPL+DuU8GProATJm/Duv9PuKhykYmg2E302XRtT0REzY7Xwyuw+AODU+wsrNKKnCH0Gq
	Pi8RuEsYTrm8lSe5baEgUQ8WboBnIbhpdjrTaowqnNWEgzMzEGa5ahAkvmbMbfVvbRMaWJ
	kW2tuUGiICsBsneDgqZR60Nm2rk8kKKepv2+l1hxZKdV38DpIrd/z1QHQ9jmgGTed8s/Cc
	2nvhl7M/UkFqNCge5BY93gZfhGoYxQOic8FulAB7rXS8mRZnV5AbKNzyeZlxTj3DBfXlhR
	5drXh2xtuX6XJZhg0Z4dprka1SvB7AMlBMX5XF9n3wugc5pViJx/6jbsGG+sNA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: dsa: mt7530: convert to phylink managed
 EEE
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Daniel Golle <daniel@makrotopia.org>, "David S. Miller"
 <davem@davemloft.net>, DENG Qingfang <dqfext@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>,
 Simon Horman <horms@kernel.org>, Vladimir Oltean <olteanv@gmail.com>
References: <Z6N_ge7H5oTYt6n8@shell.armlinux.org.uk>
 <E1tfh3R-003aRS-3M@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: "Chester A. Unal" <chester.a.unal@arinc9.com>
In-Reply-To: <E1tfh3R-003aRS-3M@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 05 Feb 2025 15:42:30 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=FNtJxPos c=1 sm=1 tr=0 ts=67a386ec a=gmHaVq+lWCOlvlVL1vhg7g==:117 a=gmHaVq+lWCOlvlVL1vhg7g==:17 a=IkcTkHD0fZMA:10 a=6jP-D5u7NbJpRVPPYh4A:9 a=QEXdDO2ut3YA:10
X-CM-Envelope: MS4xfAbWRb9fpDBlM9PTOARaxKCQyT5N9lFLaT9hxBqpt8YY33csIIzo851RrRdUcj5OuWXj7LSHEKhkC6+c5m8RjZidR1ptXPzfh8YMhel7wLhrOeBLbUpf JgMvwFTcDNgAx3ceEmj3huh1o46TpAlX5mSthdlNUUIQ6s1l1yhTlRncANe2sWXi50R9YEKDeu1r5brkFSXnd8aZCi4pMYOoC+ltzo6qC5mVKQ0Eeyxo7pJZ A/LidGzRHjB84GsE/q6zji3shJkrIMh18zrw9S6FoYyLWGc61BvYGM906zB+L5NvO4KAxYMUnhDGlwMlNnRHWNVnFYdGIlEikxpHcUSsz8tTfR8c/ncy0kay rpFcvj9dCveq0qgLroiqbutE249qdK93MlZqSoFgPJmKuFc44LG9ky2wz86e5B5NL8Z2ZYVIFNy4ipvY9BhyF2KirZC9ZMiRR5pX1n+fxDlmEZImQ5+O8Elk V/8ZyDAJq7+sE163uO91r2sDP4m2zdtzVyIAUFjeObQHbv/0T9Qs1EoQFcnoxgsZnIh8rGklhoyCoeTVIunvX58mTuV8YgxCPG1WQsDS8VTZc5dTgh/JlukD B2OnJPwM+GuYpKwpX75MCEGhHlh5wzn0QNxGhwmkclXZJdIfGBq6sWCZRYzH2A+qu5del/RcL2XgBfRcD+GF5+swHwrvSqh0XxYXFM7ohvC9yFM2idldV5mh c9vh3AIl/ffLLXCNTfVReOReLYBeC2Jwa80fuJr6CIjfYzhas2U8xA==
X-AuthUser: chester.a.unal@arinc9.com

Hello Russell.

On 05/02/2025 15:11, Russell King (Oracle) wrote:
> Fixme: doesn't bit 25 and 26 also need to be set in the PMCR for
> PMCR_FORCE_EEE100 and PMCR_FORCE_EEE1G to take effect?

Yes, but only for MT7531 and the switch component of the MT7988 SoC. For
MT7530 and the switch component of the AN7581 SoC, bit 15
(MT7530_FORCE_MODE) must be set. The MT753X DSA subdriver sets these bits
accordingly at the setup function that pertains to the specific switch
model.

Chester A.

