Return-Path: <netdev+bounces-301403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /Oc2NpOtOmobDggAu9opvQ
	(envelope-from <netdev+bounces-301403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 18:00:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 313F76B8847
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 18:00:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.s=20251104 header.b=0K4HBwyg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301403-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301403-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=riscstar.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CED13008740
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 15:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD9130ACE3;
	Tue, 23 Jun 2026 15:57:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4146D2853FD
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 15:57:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230221; cv=none; b=b9BKPszNmGDJbagzPYSmuByrsPQo3RX+3yskdGppkcTIXbmFQ1TVeYB/1Khi3oqU/vrJsfQJtDLWeFC8GdCVJxipbgtz7G18zvIzVofDxZ6qHXfe8YBpyNyvi8iWbSz4pTY2YHJKW/cw+vE+Uwq77sxmE/71g/4+60moWYcvzOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230221; c=relaxed/simple;
	bh=X8I3A+Gd5xbVF3keweqv65QN4tX5Z5eydFbTsRT6B/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PmkmiuZdHsj8CtiTMMiUzoD1aGEFjXJsf8izYTV7Y9wkrQRVi+xTVrt9ipkYIGiedh5dqctXRfHOArsNQnum992P53J/ShMWG/O0K7Kllgdp6Xh+8uTDjKT7/7IN+QG0VzytgZiVHt7Rm1vEgvh9BZ/5smCX62lqrisgE+b2enw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=0K4HBwyg; arc=none smtp.client-ip=209.85.219.42
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8de7bfa31d5so1023576d6.1
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 08:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782230219; x=1782835019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TPDfmVIzr517SVNMJCXJaTtxqPgE7ofDG9u4XZ/jZQY=;
        b=0K4HBwygbFedkgdPSmoLqaNhzqsbOKlp7HQymWdAKH3wJOe/u9WFiVk4k+SziIIlAF
         5BKnU9NScrwfKXKyipp/j2yKRdLuQGjwPax9x+js2+RHVTmuGyyGcJjzwm/Bke2orBtk
         74DzaALUeQzM9JCud+CAWBVI9PqOeZwzL4qrsnEswM7ik0JgOaNE/v6OBy+l5CBqI0yf
         +EL1bi2tE5YoUoSsf4NeD/Zo6DhMrm47XwN8wU40M14IH1r8hpV4gfzJTBKIWXXx9RGU
         /PFUbsV0Ifhnb4emweHU3R/xL/AdXgJrICxv7vbgLuOCMKA8WR8gxmygcSVIxs7r7ZzN
         v7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782230219; x=1782835019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPDfmVIzr517SVNMJCXJaTtxqPgE7ofDG9u4XZ/jZQY=;
        b=bHed+wVUJcZqRQHD9L6oxnQcdt34tud7NBytjMV1DTpUQaghU7ePp3lBjEDHab7drV
         1NSYMgpF6VW6inwGagBbh81N9A+XcjUNvVIZ7SiLpPFX+3YR7JVR+bqlvVqAXCv0CeQI
         ta+tqmhRx/W0lHDg9+QPsrbsL05j7ddoQxN4C3iUZWm54ZGQf05Fp5qVRCHLDycsjIFF
         6Ij4qNuMxR/lADRUZ8WPlX97Qp1/VV9tDe/snJFFTXYMwM7gC2syZoGTxHE0nGH18kSW
         3kLLycVVfkS9j4NSsYENSXQf37q+2PD1O1edg1eNWRXBOZxn/MjaeaJkFgLQi/mgyIcA
         ywPA==
X-Forwarded-Encrypted: i=1; AHgh+RqQUNETWdy9+J9jUEdx/r9Qtp+QuAQM0SDScQKxskofSnOFbI+Q0go0h3wBd4ceA2UXR0jsqW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfJzJkc1H8amfS7GCNU/7ziyUgGDxqIaNIrLFg7s4P71szt5dC
	uKkYV990DnT998x61RPxPFq39tZbM6eGUyiETsztK80QScbgRMznFn2IyvG06ktNdy0=
X-Gm-Gg: AfdE7cmPR4RJiwJTyvSAclhJLka94w4oLq9MEC+2r5SlOUmfZUoqwL+IVd5T8gRvrnz
	Oom1v5PFeS8nAgl/IRQ8y6LNPHd2ZcgmDi/aPLboMO7mNYjjhp6BfTCmhmQktp7o5WuKgmoBkjz
	PgfkUpmUgA71wD7sNYKA7s0GjOR9S66GvO9cBUJE6BpUsw5B2tiCYnfUOaU8OUjYkt0+dObrKVd
	TjG6dlgBG/Iq+s7ijFL+JXEh0B1U+3VZYgmFjy8XrGHa5acWPFlZEeZrMlHr6XytVNAVeiiFPZL
	fsTv04lkXI5vBHqA36T9ES72wK3PLMbu82U8uZouzZASYPQHItgrVrFNnxrew2PJ4tsASr7IWB3
	SCrWfNPCOGeRNuOqIlaTBCeFiUNkrZkHarjMc4FcuEDfcs9nMlNyQrKehSndhmQyoa3MKOLsBL8
	1K2SX2fhFEysu6Ow==
X-Received: by 2002:a05:6214:4344:b0:8ce:cad9:479a with SMTP id 6a1803df08f44-8e4341be39amr51848766d6.15.1782230219270;
        Tue, 23 Jun 2026 08:56:59 -0700 (PDT)
Received: from [172.22.22.234] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f603b6dsm143054006d6.15.2026.06.23.08.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 08:56:58 -0700 (PDT)
Message-ID: <959db395-ae71-4a50-bd46-ac5add545a52@riscstar.com>
Date: Tue, 23 Jun 2026 10:56:56 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] SM8450 IPA support
To: esteuwu@proton.me, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260622-sm8450-ipa-v1-0-532f0299f96e@proton.me>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260622-sm8450-ipa-v1-0-532f0299f96e@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[riscstar-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[riscstar.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301403-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:esteuwu@proton.me,m:andersson@kernel.org,m:konradybcio@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:elder@kernel.org,m:linux-arm-msm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[elder@riscstar.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elder@riscstar.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,proton.me:email,vger.kernel.org:from_smtp,riscstar-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 313F76B8847

On 6/22/26 8:44 PM, Esteban Urrutia via B4 Relay wrote:
> This series adds support for the IPA subsystem found in the SM8450 SoC.
> While IPA v5.0 is very similar to IPA v5.1 (heck, it even managed to
> properly get the modem up and running), it wasn't perfect, since the
> modem would sometimes hang when rebooting or powering the AP off.
> After a thorough investigation, I managed to create the proper data file
> required for IPA v5.1.
> 
> Regards,
> Esteban

I assume you have implemented this based on what you found in
some downstream code.  And if so, could you please indicate
where to find that (so I can do some cross-referencing myself).
I no longer have access to any Qualcomm internal documentation.

Thanks.

					-Alex

> Signed-off-by: Esteban Urrutia <esteuwu@proton.me>
> ---
> Esteban Urrutia (3):
>        arm64: dts: qcom: sm8450: Add IPA support
>        dt-bindings: net: qcom,ipa: Add SM8450 compatible string
>        net: ipa: Add IPA v5.1 data
> 
>   .../devicetree/bindings/net/qcom,ipa.yaml          |   1 +
>   arch/arm64/boot/dts/qcom/sm8450.dtsi               |  55 ++-
>   drivers/net/ipa/Makefile                           |   2 +-
>   drivers/net/ipa/data/ipa_data-v5.1.c               | 477 +++++++++++++++++++++
>   drivers/net/ipa/gsi_reg.c                          |   1 +
>   drivers/net/ipa/ipa_data.h                         |   1 +
>   drivers/net/ipa/ipa_main.c                         |   4 +
>   drivers/net/ipa/ipa_reg.c                          |   1 +
>   8 files changed, 536 insertions(+), 6 deletions(-)
> ---
> base-commit: 948efecf22e49aa4bf55bb73ec79a0ddcfd38571
> change-id: 20260622-sm8450-ipa-5da81f67eb65
> 
> Best regards,
> --
> Esteban Urrutia <esteuwu@proton.me>
> 
> 


