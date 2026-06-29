Return-Path: <netdev+bounces-302856-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XGG4Muf/QmoyMAoAu9opvQ
	(envelope-from <netdev+bounces-302856-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 01:29:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C509C6DF3A5
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 01:29:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=E9Ob+WDE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302856-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302856-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C45F300A66C
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 23:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94BD3D16E5;
	Mon, 29 Jun 2026 23:29:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3AA3CF1E1
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 23:29:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782775746; cv=none; b=ISaGp9r29U6L4JFEfMB41kRFirUqsjLITORXJDbWPLsIfdCacYn3B4K6Bkypcq1Nejp3QOuozWC6b6rjhS4M8DiOYhFoxTBMrtzJY1rwmzW/VDt0BmSnidkIkAEUp0hj1D5Y1x7af+yVeeIjzFIUUU7I8JVvFaGQmbvHDUpnuTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782775746; c=relaxed/simple;
	bh=qUBM5k/m1LrmRgCeA5fXpdqaFQY5160FihcJbD/JmzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pfndinKHzCZegt24q6bb2BWo2GlhQ3bwxgl6/hijph9ywP3BQApFdCNLE0nz15aehyzWfxJ8so5PwJ0PUmN1VofAGKjBDH7QSANE4mf1ihEVD105xKjdC68xCb0v88w9cXuNeRTZtWEfUyoHfwUh+6Z41BSeTCTLoQB6oDbCMDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9Ob+WDE; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493a287b8c1so13870975e9.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 16:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782775743; x=1783380543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qUBM5k/m1LrmRgCeA5fXpdqaFQY5160FihcJbD/JmzI=;
        b=E9Ob+WDE/z2TsUmR16F9405yKr0TJUzD1r/OTIRuh3lzjGV9qyJk8enlZXHMOeuCYO
         6BPJwqnVsqK5K6Zg6XxbAPqoDT6Mcj/1sEmJW8PJqclEp2uKTnp/zS2cz+P6wUDs03wD
         Jfpc4q5ch+0bidZdIgrrBjfTR9S3E+zscbxOAgeLGYhOk1NKExeb71KefyrbVJGbHhdc
         9jQjlc2Ughk0bKEAW40ydq/ns7s2LTbl+yJYYxfnMZ6OOyrFRsaW8PqMaQWzLXiE1o68
         7tO3Csm9+fH0FhGIp4wYXuOKe668zGGqQfMIpZDl/zEc96LIKlsy4ttHb7xSHuXNs7fK
         kIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782775743; x=1783380543;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qUBM5k/m1LrmRgCeA5fXpdqaFQY5160FihcJbD/JmzI=;
        b=V3SsCgXHz4URgf1tXIUHJVyhfBrxddV8Q68xcHJ4BzQf50XBngvQFNYf1koAGlcPsH
         XDGCqNNM7Pc8Fn3iZiruZhzCUVg19W3OX/HU0iRi+Faf7yDiRcHFt56x8SosS+ugFJX4
         P4EDeL3P5fFS0GdxqvuIAGhtyp5s13uv0/Sb7y3LlKtTIVEzkAOhgNPT8N/193lMVYy+
         xIp+opWEqj34qDHbEe1hfRIlcsywnYYuCdPqbvTPtTkrsJAeRCNKacz5Yf1pK56gd0tm
         JTLw5XKvzAOYjy3Nt0o9EPtL9SWb2EhBYNe6erNc+Tlwtn+WLVAANKzZ7g9fI4B62Gh1
         nVmA==
X-Forwarded-Encrypted: i=1; AFNElJ/Bas579Obc/1gFhsXcOmK/qo5+A5xLusBQ/LbRBb709gup5UMSwHrZf5MAhjJ1FSrhXSn1CVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy85LLO6HFCiQgdWUd1pj33baWTh/4TBO65yEqKuuF6U4QNqwfq
	hURHg44gSOLeh9T25WpP2yODM+Y0gVtAgXyzbAfQRfJ9NKdC1ujadTgt
X-Gm-Gg: AfdE7ck640Kx/7tcSYhuiRkag9b/Tn2aLvn+6zu84aTLcNToQEndJUsJ69DAQocqONP
	iTAZJrw9ZH9aBSBR0IYNCmbc4lOeE30FeNWzxmGQz1OD2dBXoYeO24ial+96UW6BrWeu+2LTjsS
	BNvltSMfptztM2OvHy8v1mLM2XD5I7z9/UCPy3jsS88IALDOOsozU0xk2YJ85nJ5AO0Cd9ZLMdC
	ZQjkdFBWfi/1ABxN2UWRY9duBxxkuH/k6U9SoWmKvwXUtFKvTQjn/s6xEkl5BqA7VTh/idnfxU9
	7NoJzgfHzrDdTix/cDQ+WNpsT/v9pmza11TnleORJk4NjxWPUmBX/e2K8jRn3VW7mBdxw/HLWl7
	WEf3WLgmIOCHyibKMzFFdj5+5SuZpWJUA0pYn1hOJXKjfGV3D4EnEmPGnYkOUNg6RAMkRgYjBHS
	fCV9GYklkBRJ96Rbz23pzQkD5tus8FCtZLpE9aYo6WtqbIr7o5IIRVIBqwPixrTq5WEhs4PuXN1
	66+TrowmtVx
X-Received: by 2002:a05:600c:a43:b0:493:b2c1:b2f9 with SMTP id 5b1f17b1804b1-493b827ed93mr22927465e9.8.1782775743119;
        Mon, 29 Jun 2026 16:29:03 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f114:3501:e823:2f5a:823:f863? ([2001:9e8:f114:3501:e823:2f5a:823:f863])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8cd8bccsm25053065e9.8.2026.06.29.16.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 16:29:02 -0700 (PDT)
Message-ID: <3c565f9d-0114-43c8-a7c6-3541b22176a5@gmail.com>
Date: Tue, 30 Jun 2026 01:29:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/2] net: pse-pd: add Realtek/Broadcom PSE MCU
 support
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
 =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
References: <20260628222705.4052815-1-jelonek.jonas@gmail.com>
 <20260629160635.489e6779@kernel.org>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20260629160635.489e6779@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-302856-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C509C6DF3A5

On 30.06.26 01:06, Jakub Kicinski wrote:
> On Sun, 28 Jun 2026 22:27:02 +0000 Jonas Jelonek wrote:
>> This series adds a PSE-PD driver for the microcontroller (MCU) that
>> fronts the PSE silicon on a range of managed switches, together with its
>> DT binding.
> Sorry, but net-next was still closed when you posted.
> It'd be unfair towards those who follow the announcements to consider
> this posting, you'll have to resend.

I considered the rc1 release as opening, the announcement being
an optional indicator. Sorry for that, I'll keep in mind for the future
and resend.

Best,
Jonas

