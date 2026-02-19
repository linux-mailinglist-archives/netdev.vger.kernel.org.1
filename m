Return-Path: <netdev+bounces-259592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA5LAct8l2kOzQIAu9opvQ
	(envelope-from <netdev+bounces-259592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 22:12:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C83162A79
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 22:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50207304652E
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 21:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F5D327202;
	Thu, 19 Feb 2026 21:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XZFY59iG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4296F302779
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 21:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771535450; cv=none; b=C4Ke1JoXmm9etADOXNERfhS43yaNv7lxp2Y2I4Lu5V/yUSm9uIOva9jXx6Dro2BaW1hhkIIdyDvmXJBiPTuMVNRtwpxTy+5jVqiYZGkTE0sXUwnhhHgTrgUNslVxZoTB8tqXJlWEI9ualM/dkHoVPHzYLzsOSEoPOUcnY/t+0t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771535450; c=relaxed/simple;
	bh=JN6SNwJz/PklshsvOgeHq8ajH+qHNKzC5uQ86LGzgXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2xm87xSHKRIH7rRqtPs12jTTkJEnUqqOIKpredTzCyO08az5qH/6WNie4VzF0pDEVEWGTmTe11uI5XqOEhvNrSA08pZvOYKm2xQl1YZ7qoWy4mEUGWIW6ZcVb40vBt2LAUoI/txUCh5fPgMp0csjB9o4vuZOkSC/CBSPEMr5DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XZFY59iG; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-40f0e14b9f9so812909fac.1
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 13:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771535446; x=1772140246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UrC+PLfTea68FI9Rr5zEv0pamcCsfXyApvn8rTrZCCo=;
        b=XZFY59iG+ON0v2A+mE7aPxY7ovQXFXZCFqAvxBBG7+znDIMC7LE84n2RNsgUlXmY6P
         tp6Q5b/iZDA9YJluflyDw919fSkX/x+aN9tQX8PDM4JN26ufv4WNR17sBNmLZMMHMJjH
         ceDYrln1/COWBy/vuFrK6p3xSjqWjjhLC2L+ILcynRG0Dq8FwbeeQtp2Er4mFJ14FFlu
         b2bQy0rIHQJzTyCq6RoqFE7W9WAWknQjLTYS/o/ov98roir3oapCYFDnhT4WLB/+uAQc
         nkC6cWWsUmWDDRNmOEOP+HxsR+aCf+GhQ2DYEuD1C/qtv6O/ID2FrjJU7AErBk7ZK43x
         mxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771535446; x=1772140246;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UrC+PLfTea68FI9Rr5zEv0pamcCsfXyApvn8rTrZCCo=;
        b=q5uJrO66wJw6iEqQwoYQhnqSzT2Jp6VhCoZw8iQWN3633RS88FAMx5ZBWgIgHjQoJa
         8TPAywv3cmwlyGWWm2Oy6UzDW1nIAkiJdslHAEFrsrItkK1qEalF29DaIYyGwQv2Zu2a
         YWDv0xcUauvh/T3b4lLcQ++YZATgozH/fV/Zz9WWkQDOcKN6SXzyv9AvhLXvtWDGOJFX
         H26Mi+cx2gBi5iFofZzWawtYYECMg0im9/+Ysaq8LLBuoZZQ4THulq+6tPOobs0ZWEDx
         qFU0Og0fJVpGF+HiQfqF5HxIj1+PqXC2IHSo3MXtTN0/pirKc5/bXsqMr1SHvSMw63V0
         F3TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVkN5+fkl/1/U3oOrof/4hqT3Wzb5aQLreWT65Cbu+8tfwQ48al1u1TTNzRyYlQ6797EvfDfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvxItX+tqqc5uKDQXFxnB4gLZRI/90WqWD2h8gRIWPdm7+BIvb
	cLMRnnz3Zss+fjPzSY9JBj8DKmbFEpCIYaVK0gKfNCb6/6djwDdVKlz60rYP9nzHYY0=
X-Gm-Gg: AZuq6aLyUmZsZv3JfDGQxsv9II9QrfqU8VS4Z+2dE+Bg8ywU1GYShK+SCi5cWYJtr+b
	09b5mF8zzErYXgD8U4NYNhn+baM2r5p4Nb0bE/0CYYqYiwamg2jbpZgjbPoKEYEvmRTvJz0n0t5
	2oKhExJ9JJPTkzAPlZqT1c9EC7wJ8YPL20dWI5DUX54/eU7C1htVEcZZEyaIqevPWs5/YcZhlG9
	ybQZ3fxkIgjc1U5Rhv35XPh1iV9pxFvE58LqbIGUljpp34vOdY2Io+C16fcPHnyT3cc2DitQMJn
	M0s9cetjNia3NFUcx3PvsTNKR5LPlUqUVGeir3lKv89z7lsvLtzjql28DmyWeyWCI8xeQJXgSvR
	B+BNrzq2px4Eyb53y3uKm/kdg7S8jGH3vZmjal0U9+ci56bu/3+sV3R3qVGSDvDD7aRbc/tZdnl
	so8Y4oGNPzlgoovNHiReRVVjMc6/l7+ouwcOYS2sdhiSU9avMgZdvo7EPm/wB8tW/e6SkWFQ==
X-Received: by 2002:a05:6870:4596:b0:40a:5a07:3598 with SMTP id 586e51a60fabf-4152913c255mr4207227fac.36.1771535446056;
        Thu, 19 Feb 2026 13:10:46 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:d4c1:bce:26a1:c903? ([2600:8803:e7e4:500:d4c1:bce:26a1:c903])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40ee06756easm22066534fac.13.2026.02.19.13.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 13:10:45 -0800 (PST)
Message-ID: <e0b39f90-f4a4-46c5-90ff-54a261c075b4@baylibre.com>
Date: Thu, 19 Feb 2026 15:10:43 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/18] clk: mediatek: Add MT8189 vlpckgen clock support
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Bartosz Golaszewski <brgl@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>,
 Miles Chen <miles.chen@mediatek.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 Qiqi Wang <qiqi.wang@mediatek.com>, sirius.wang@mediatek.com,
 vince-wl.liu@mediatek.com, jh.hsu@mediatek.com
References: <20260202062840.342707-1-irving-ch.lin@mediatek.com>
 <20260202062840.342707-6-irving-ch.lin@mediatek.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260202062840.342707-6-irving-ch.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259592-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[mediatek.com,baylibre.com,kernel.org,gmail.com,collabora.com,chromium.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre-com.20230601.gappssmtp.com:dkim,baylibre.com:mid,mediatek.com:email]
X-Rspamd-Queue-Id: 60C83162A79
X-Rspamd-Action: no action

On 2/2/26 12:28 AM, irving.ch.lin wrote:
> From: Irving-CH Lin <irving-ch.lin@mediatek.com>
> 
> Add support for the MT8189 vlpckgen clock controller, which provides
> muxes and dividers for clock selection in vlp domain for other IP blocks.
> 
> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> ---

...

> +static const struct mtk_gate vlp_ck_clks[] = {
> +	GATE_VLP_CK(CLK_VLP_CK_VADSYS_VLP_26M_EN, "vlp_vadsys_vlp_26m", "clk26m", 1),

In mediatek,mt8189-clk.h, we have:

#define CLK_VLP_CK_VADSYS_VLP_26M_EN			24
#define CLK_VLP_CK_SEJ_13M_EN				25
#define CLK_VLP_CK_SEJ_26M_EN				26
#define CLK_VLP_CK_FMIPI_CSI_UP26M_CK_EN		27

Are we missing the middle two clocks here?

Or should the be omitted from the header file?

> +	GATE_VLP_CK_FLAGS(CLK_VLP_CK_FMIPI_CSI_UP26M_CK_EN, "VLP_fmipi_csi_up26m",
> +			  "osc_d10", 11, CLK_IS_CRITICAL),
> +};
> +

