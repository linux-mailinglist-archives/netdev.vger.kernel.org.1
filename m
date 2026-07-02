Return-Path: <netdev+bounces-304041-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Cx2jDmUqRmqvKwsAu9opvQ
	(envelope-from <netdev+bounces-304041-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:07:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE09A6F5117
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:07:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=vxlIj29X;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304041-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304041-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C643E3019443
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 08:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B1740B392;
	Thu,  2 Jul 2026 08:57:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD533C4161;
	Thu,  2 Jul 2026 08:57:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782982657; cv=none; b=M9mOI+Vh3jyBfoqLTAcGWObXPsipv583Io1xSOnfuCU5neZTR1Ocl89SMPgyRUH1UAq/as2G2PxaZUxAqbwa/dmu3X+vZF4yx1sqyWz/7fd7i9DlO39tnPAglg4ZokU3mn0OYLxxf5x2uwxSBjx04m2i6r/9mbG1z8oIaFhEXVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782982657; c=relaxed/simple;
	bh=MSbq6+W3UnipbgRe5OqNXC2h5o+vLMVg75Y2ERCCqF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iw7ZqxGMZLfPK+kLMhf5iFTIV6wRTx8OicfCsq/P4Xqg0dkXdLY5Gv+rfkjuYGP93ibmWkzYqFB0UfFzYivTxn2onGnJsVpkSh1qofex2eZnAmv6nJQsjuE8aOKd3YEJ/1ktG0MLAjwxqhVSGfyJWsgSFlIyC0HMaJzWSKobpvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vxlIj29X; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FF42288E;
	Thu,  2 Jul 2026 01:57:25 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EFFB3F905;
	Thu,  2 Jul 2026 01:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782982649; bh=MSbq6+W3UnipbgRe5OqNXC2h5o+vLMVg75Y2ERCCqF4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vxlIj29X8SyZB1IgbyT7B2lCW/p+J0QTyfWT5aKusya9JNXJDD72C2MXt0nB1jJBq
	 L6w4cZPCwWj8mcv6ihhP+P0n5CwUEWYj6xE0SdD0s6CHqhEAm7j1wIRANnMYUKvYbY
	 gChO0ak5hCTtvm8wzYEpFjegAHoefiu3EimrD+Us=
Message-ID: <17e411b5-f025-4c72-90a7-5bdd5971654c@arm.com>
Date: Thu, 2 Jul 2026 10:57:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/8] clk: sunxi-ng: Add support for Allwinner A733 CCU
 and PRCM
To: Enzo Adriano <enzo.adriano.code@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jerome Brunet <jbrunet@baylibre.com>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 netdev@vger.kernel.org
References: <20260310-a733-clk-v1-0-36b4e9b24457@pigmoral.tech>
 <20260701160055.320000-a733-ccu-status-enzo.adriano.code@gmail.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260701160055.320000-a733-ccu-status-enzo.adriano.code@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304041-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:enzo.adriano.code@gmail.com,m:junhui.liu@pigmoral.tech,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:p.zabel@pengutronix.de,m:jbrunet@baylibre.com,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:richardcochran@gmail.com,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:netdev@vger.kernel.org,m:enzoadrianocode@gmail.com,m:jernejskrabec@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,pigmoral.tech];
	FORGED_SENDER(0.00)[andre.przywara@arm.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,redhat.com,gmail.com,sholland.org,pengutronix.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.przywara@arm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[arm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,arm.com:dkim,arm.com:mid,arm.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE09A6F5117

Hi Enzo,

On 7/1/26 18:07, Enzo Adriano wrote:
> Hi Junhui,
> 
> Thanks for the A733 CCU/PRCM RFC v1. I've been reading through the
> series and the review feedback, including the NSI clock/reset handling,
> the binding naming and ordering comments, the SDM macro cleanup, and the
> question around modeled but otherwise-unused clocks such as the GIC clock.

that's great, but please tell the list, by replying to the respective 
patches. There are still a few patches left that haven't been checked 
against the manual or otherwise reviewed. I will probably do this at 
some point in time, but we could use any help here.
You don't need to be an expert for this: just comparing the numbers in 
the struct (register offsets and bit positions) against the manual is 
already very helpful, and can be done by most people, just with some 
endurance ;-)

Thanks,
Andre

> I do not see a v2 on the list yet, so I wanted to check in: are you still
> planning to take this series forward? No rush at all, and I am happy to
> leave it entirely with you if so.
> 
> If you have moved on to other things, I would be glad to help carry the
> series forward and address the review comments, keeping your authorship
> and prior work intact. I have A733 hardware here and can help test the
> changes.
> 
> Either way, please let me know what works best for you.
> 
> Thanks,
> Enzo


