Return-Path: <netdev+bounces-298775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I43YIqJULGoUPgQAu9opvQ
	(envelope-from <netdev+bounces-298775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 20:49:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E653D67BD86
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 20:49:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QtirE67P;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298775-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298775-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21BFE30BB52D
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC5D36C9EB;
	Fri, 12 Jun 2026 18:49:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33C033BBB1
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 18:48:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781290140; cv=none; b=ZFSocL/xGLmhiqcto5l6+0mWI7i2I6LBcaMtsSD5nFQXAkUGumyJQmLJrAZ5MA9QKVA/Rgq16h6YiJb5wPEfACG7D7ESrVDwYZM4GspYyCRgUZb+DC3tR0WSPZcbX+Ox7SAAYwsEsDqAb2pl7Y7dOt9KleDptaJsLjg3KT+M4Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781290140; c=relaxed/simple;
	bh=y+YFgf2hGWUgiLxOKrTXIYTGrKlqIDDKqbWS8HcgkYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CX8qVc9E/ahbvGKoSVySlP7FqmFAm2Vpwk8c7PGgo6dwkU1a/klZsphOaowWEOvqgH0ZwRkSu4OWaz+pllDitdq4iIuaRrWf3R8KuOYx6OHjsdVXfXyzdqpdfDA2coWEZdpwDHZ8RbtQaOhAPJYWpPW+Iso2kCQO+WRGhjGDdDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtirE67P; arc=none smtp.client-ip=209.85.221.45
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45ef56d9b67so1034442f8f.2
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 11:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781290137; x=1781894937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jeq0BZdLYCausYeWCmY16Fj4+VhF2lVSQzlnxtNub48=;
        b=QtirE67PxKj4QQmYf7+NBiGK7L6s4ik45OrqtM3YTB3PrBxJpXPBa9aYNtshJcM8DY
         9r+++mAmxeAvbVc0cHgZIoc6IvfGZz1yfzFRbgQJ/+idGGdxGKIdV2ANn6SLsWByuctC
         FlJrE8tQ/nRjw8iPXD/VQLcvXxbKGeNVsVbh0nky/A4r+yAIoTjNHQuGFDO2xg0Qfx7B
         IxpooTZ9c+4k3/VAcnNvM3q5Q+3yK1MVXjDBfTnRs7KyMYsO6gqUSGoIljQ+dPf5XQjL
         jPe4BcdSPcKqud+VVzdVLOWVqA/WU/l2/ZYml9jTTULwBe5Nnd247LcDRFQ+3d2+6TtT
         AZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781290137; x=1781894937;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jeq0BZdLYCausYeWCmY16Fj4+VhF2lVSQzlnxtNub48=;
        b=KTti8wlY0DS+eWfNocsH1dOximYEmlndqqFTEdNE9xzB72ltIK/3sxUBCra8cdW4YZ
         W1AnUc9THPi5PofQoh+CI4om7dE/Jo0khfoTSGB/BpA9Or6TzRxFtqqqF1PweMfUbc8E
         D2l53KobFa1YsSDh7H3fF3rpsnUo7xyzdP1KU+TSAx4KxD96CCz62uTlNsVXy6R8KcRj
         hTugN9ibM7AAmYE/Al0Yg7U50wShH4NAfB0Q0+GCMLnvDd/6MfwW2LukVgXI1fZtoEkc
         mv60wQOnuZkEtEiY0/3gsjySJEBuy+U3rdsBluSuTA7ClOZ9RZ8diNAz/Dy3qWbEbNgO
         RKIA==
X-Forwarded-Encrypted: i=1; AFNElJ/AH3gyrRvEafd4diXfY+GAOYBdOPyLWXPW/ZrY0RQE6VwUc6ofllqcCKAtf5zcweCxFZzBMHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhflcnXuTrvTOO2ggOZUVxe1UShLmqQVApidECgB/dXQToR9Hm
	kCQUfWCEbS4dRUOtnGG6p5tUovHjxCWxhCDCKrU4KEZWGSl280XggLQt
X-Gm-Gg: Acq92OFlCNwMJqE9FJ4Nyku4J9fErOIovLhJUShaqiFYJO35JgQIrJPb48yaNjfGpyv
	7E1mNk+He6IS+IuES9Yqp1LnCvfDGX9p4xVP/R+RYNC3Lax7rJMYUZ017tv35dcAxcvs0nUtlh/
	1vc3KyzoTAznOhbl9HgmvjMTkvkrYVtHMqe6ePpTgq44wd0gS8RLSr2pLpr6Gr/zhkKZPxEaper
	TBHgwCVT6KWMZMVTnRB2UQxvpfq9Ujw+ondPKNIXpYKG/zBMg1Mk7Yl5WC5jlRc6SISeBI96DeG
	t61XGoNN0PsocHiadGeTTcZS+Rq+xQ+vzCLF2xfb8Uw2XslYmJz49/OTXPJLf+4lSUgXNZoA+bl
	G+uZj95sr+vI7SwrCUR3ozUl87nZJmZnyikHw2w1ck7bb92BLAX7T0IEtnNBtCRH6AcFvCCfeCS
	ok/9qY3EG52zg3bvT3AZ2umFIgQlN11Kyct2Ci4yExyhqOUiCS/X8YqBf+1+/9BpTbMAWCuoIpr
	OU=
X-Received: by 2002:a5d:5d83:0:b0:452:11f9:bc40 with SMTP id ffacd0b85a97d-46074a87c47mr532655f8f.2.1781290136967;
        Fri, 12 Jun 2026 11:48:56 -0700 (PDT)
Received: from ?IPV6:2a00:1fa0:742:25a:e03e:6c9c:49d8:2fee? ([2a00:1fa0:742:25a:e03e:6c9c:49d8:2fee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0bbfsm8064894f8f.23.2026.06.12.11.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 11:48:56 -0700 (PDT)
Message-ID: <edbdee99-3cfb-48e6-8fb9-bb8418c4e852@gmail.com>
Date: Fri, 12 Jun 2026 21:48:53 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 6/9] net: ethernet: ravb: Add callback for gPTP probe
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>, Paul Barker <paul@pbarker.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260610102432.3538432-1-niklas.soderlund+renesas@ragnatech.se>
 <20260610102432.3538432-7-niklas.soderlund+renesas@ragnatech.se>
Content-Language: en-US
From: Sergey Shtylyov <sergei.shtylyov@gmail.com>
In-Reply-To: <20260610102432.3538432-7-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298775-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:niklas.soderlund+renesas@ragnatech.se,m:paul@pbarker.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:netdev@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:niklas.soderlund@ragnatech.se,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:geert@glider.be,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sergeishtylyov@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[ragnatech.se,pbarker.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,glider.be,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sergeishtylyov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ragnatech.se:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E653D67BD86

On 6/10/26 1:24 PM, Niklas Söderlund wrote:

> Different generations of the RAVB IP have different needs when it probes
> the gPTP timer clock. Add a callback in the PTP information to allow
> each generation to probe its own way.
> 
> With this the last gPTP specific flag (gptp_ref_clk) can be removed.
> However the primary motivation for the change is to prepare for Gen4
> support, which compared to other generations with gPTP support does not
> have the clock as part of the IP itself.
> 
> Gen4 will not need to compute GTI value as it have no where to write it,

   Nowhere.

> as the gPTP clock is external. For this reason move the computation of
> it into the newly gPTP probe specific callbacks for the RAVB IP's that
> support it.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>

[...]

MBR, Sergey


