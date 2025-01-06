Return-Path: <netdev+bounces-155452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8C4A02616
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 14:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E091884D0F
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C368433C0;
	Mon,  6 Jan 2025 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="mlJ8qwQ5"
X-Original-To: netdev@vger.kernel.org
Received: from fennec.ash.relay.mailchannels.net (fennec.ash.relay.mailchannels.net [23.83.222.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6581D89E9
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736168537; cv=pass; b=LeJbvFafCOR0TdtOoD7k7NZtl0iIdY30VY4EAfR3ebq787NcjUbheEFL95qU0uGG5xLmm13GAY2HqKxKVk0P28yPJWvbFDcXriJ4e0A/NO25p15QA0fVkjifRmu6vrOExdLyEs+Bq/Xhfc0x7a9j5ATLvFL66OjbtwEQ11XUR6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736168537; c=relaxed/simple;
	bh=Spk0dx6uaB+rkbL0ch7L7fEMJvMjc3SyGzOmmbXj8gI=;
	h=Message-ID:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:Date; b=qyEp+Z7hnoa2pyScXWuJz6ocXkQJGT+/MVLWCqW23k2jcWaJWgUCaqedsjpFyG8IwyrDBahKJCVtsa6DK7dzbsfd7A8M0J/18oYYZa0enpZg9EDoFObWI5SzbIIV69lePsTZPm0wdHnuQEUsiACDx0kvD9M0mL/X2HRCRlV7psM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=mlJ8qwQ5; arc=pass smtp.client-ip=23.83.222.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
X-Sender-Id: hostingeremail|x-authuser|chester.a.unal@arinc9.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 885B51641B7;
	Mon,  6 Jan 2025 13:02:08 +0000 (UTC)
Received: from uk-fast-smtpout8.hostinger.io (trex-7.trex.outbound.svc.cluster.local [100.109.217.170])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id E86D2163474;
	Mon,  6 Jan 2025 13:02:04 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1736168528; a=rsa-sha256;
	cv=none;
	b=+MGFwFRWxGnQkdzbUusmcuVsKaD6FqRQXym6aYXyqLZrJRseAwcgfWxW+3Sw03NgXcqS+W
	OzCA3ZMkNwUy9aQfJhDxAIHQ7tMmoHgeJohGMr01IeAkaAHaDU+7kbmWtY23kbxvbtwUDT
	gAmYCVppbOHkrdoJ7Ir9eI0Uuln3wxvExZOF4kMjLYLyoOKDf4UcsqGODojujtqeoZRT9I
	uJFviwW6+4tickeFoKHvAa+OYL1opLkKeN7KtxZqrcJC9NdzUcJkOUGW/tkplYESVgJedc
	cjGG9wL9vJo0hlcepBjQ/sxt6nokilD/mNGcU6Tpi89P+ckUK5fSdA6907qXpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1736168528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=AcDSjeks6TlFjnGYIqpnkk+EjNYuhIl6j1UVmh3/ZuE=;
	b=uENe8QvJ9Lf5GumSpe8pye6l/HupodHK+lj90nHD65kAIdsfs0Edv3phRhro72yLJJY/ne
	T+wzaY6TnEWY7y7vtFm/vyQXDNVN6sp+Ape8jz+fVi7YbRwnr6X2QXKDsDYdhn4yg68XM6
	xAJbKAv/c41/NifN+Ny83P3R0hcySfytwpEWKRijGXnmHaD7T0E5dO7GrEkdkpWYMac1YH
	kOx8VtlGrM7Bc6FUecdEvQ+SjnYW4+sYCXlRATTucZUlDNfK2ACQ1yguC9WUduugIALV7p
	+muQ7tM8XKk/ojJHgtiT9CtvG1GQjLOm+5Ej5sGqbAwQbfzg60kKJ/WOOgmR3g==
ARC-Authentication-Results: i=1;
	rspamd-7c48484bf8-vlhwn;
	auth=pass smtp.auth=hostingeremail smtp.mailfrom=chester.a.unal@arinc9.com
X-Sender-Id: hostingeremail|x-authuser|chester.a.unal@arinc9.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|chester.a.unal@arinc9.com
X-MailChannels-Auth-Id: hostingeremail
X-Company-Spot: 7ca0a4c92aa3c7f7_1736168528359_1456431916
X-MC-Loop-Signature: 1736168528359:626636087
X-MC-Ingress-Time: 1736168528359
Received: from uk-fast-smtpout8.hostinger.io (uk-fast-smtpout8.hostinger.io
 [31.220.23.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.217.170 (trex/7.0.2);
	Mon, 06 Jan 2025 13:02:08 +0000
Message-ID: <bd07fea7-2473-458a-b0f2-f03afb6a8b32@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com;
	s=hostingermail-a; t=1736168522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AcDSjeks6TlFjnGYIqpnkk+EjNYuhIl6j1UVmh3/ZuE=;
	b=mlJ8qwQ5EvPAxtT10MwR1IlP8+211LJMFdbtycwM2pmJc48WD+M2zl6DiEc8LcNvo+Yypd
	pddR5brQ+rQhMO6B4W23cvPjsaC+p0TEsW4fV8hg7Q1zs26KbDBg3RZFyfpq3YK76jCxtt
	XTc+P5pKb0rsHr4TCAIdc8QEgXI9x5JE96+bMMYv3JEj7vE1cYC9aHyYLcv4FvfQ2ikL4j
	HJX7ZnskyC5Ti5+qE3c7X/cX9y/VGkHf9pCEWKp8oBjC3iO9/N/W+ts2kpDbY147l307YX
	fGidqp2ejtV2dH6X2yFVAJqMjkWmeZaDE1fa7x8Xlgj+ZqCZLNxOqM/gek4AVA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/9] net: dsa: mt753x: remove setting of tx_lpi
 parameters
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ar__n__ __NAL <arinc.unal@arinc9.com>, Daniel Golle <daniel@makrotopia.org>,
 "David S. Miller" <davem@davemloft.net>, DENG Qingfang <dqfext@gmail.com>,
 Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger
 <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>,
 Simon Horman <horms@kernel.org>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <olteanv@gmail.com>, Woojung Huh <woojung.huh@microchip.com>
References: <Z3vDwwsHSxH5D6Pm@shell.armlinux.org.uk>
 <E1tUlku-007Uyc-RP@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: "Chester A. Unal" <chester.a.unal@arinc9.com>
In-Reply-To: <E1tUlku-007Uyc-RP@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 06 Jan 2025 13:01:59 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=Ft9X/Hrq c=1 sm=1 tr=0 ts=677bd44a a=xjZdIgyYDteOtQQgkZ0oAw==:117 a=xjZdIgyYDteOtQQgkZ0oAw==:17 a=IkcTkHD0fZMA:10 a=PHq6YzTAAAAA:8 a=GvHEsTVZAAAA:8 a=4-z7pJFQCo3YSGV8thMA:9 a=QEXdDO2ut3YA:10 a=ZKzU8r6zoKMcqsNulkmm:22 a=aajZ2D0djhd3YR65f-bR:22
X-CM-Envelope: MS4xfH9N1taU54asjLrGreSAV/TehiAi7J06EL3eyr/omZSHO8gLmfXKXvQ5bOAI2GJNp5Npok24rRkRfxgEZNYsmmuhu8FmWE96hejcxZi+ChZckJwfPgNK s4fCUM7Wi67jRRhPpmSjwaVPjlzvSDdUx2m0p6yaZgk0lCNF7Hz64D/AOFixAu7ioUOISioX6JPE+EOS0yHgjPVdp3Sh2mqg/3YuRrZbwMHQp0jagjrugYYc sgtyMCkI5Vpw9XC82MXAL228DXBQwubpDkKil5EqUTNp1GoCW4WsYZh7cDotLi/gAO11PwmeDq7QbZ0hWkc+zU3e4S8yCVfPAbYR+ynCb71QtDDEj226R7rj Xg6R6WNbu+GIMDVy9k491mo7mhPaMgudWViHLoxb7wYyseo1t/QO5mPyXv3HjNUL61iJsfwTKPJFW6rTCVzHiVw4Jgo1zHRjEb0MDmZN9tR/jZL2jXbhBkC/ 4zJiaw+ToNXTy4WJPt7UEW2LIYIVnh2nSFhHeiFFZbuBuHTVfOJRNSbyzme7318sbFkKy6IB/ufPRZgKd1XLi+Gpp/TtKvaPJDaRP/3mbRi0HndNpHw5d1T4 8U43j1IYQCYeUjqixfpWbKUQeYYYmzkhYv1Ik7NIK6OzNuIgnc76BYguUhWSsM/C77mrORhSp6DSBFTUl+5bce1PKQnYLdaSFpfEqK+oWaNBB0NbcfFFarYe NiuDv58o7r214sFoVRLYmMbXv6su2hgPKTRRsI/2eA29uzpwYwq4wMbZMl0ompHn+/0xLhmgyM98LM20HDur7Ws6CwiV944ypBhargPWj5vsaslDuvYZavb9 poABEHzwWaHz2/JPKVXW33ZHo8Yg1AlF8PY9332wLdC0XU+2NTdOJx37ZW+Z2HwPY8Pmv9ouPq+/z94dBX8=
X-AuthUser: chester.a.unal@arinc9.com

On 06/01/2025 11:58, Russell King (Oracle) wrote:
> dsa_user_get_eee() calls the DSA switch get_mac_eee() method followed
> by phylink_ethtool_get_eee(), which goes on to call
> phy_ethtool_get_eee(). This overwrites all members of the passed
> ethtool_keee, which means anything written by the DSA switch
> get_mac_eee() method will be discarded.
> 
> Remove setting any members in mt753x_get_mac_eee().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Chester A. Unal <chester.a.unal@arinc9.com>

Chester A.

