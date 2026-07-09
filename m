Return-Path: <netdev+bounces-306272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XSPKGrW1T2pvnAIAu9opvQ
	(envelope-from <netdev+bounces-306272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:52:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBA57327DD
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:52:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=mail header.b=E2gh5g0k;
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306272-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306272-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 038C5313963E
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 14:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCDB331213;
	Thu,  9 Jul 2026 14:05:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE250263F34;
	Thu,  9 Jul 2026 14:05:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605939; cv=none; b=gspM+2GyKJcjw3A2RpVZzFvkNGesRB+O1YwaG7xm02oizaWHhTNLTctY0DkRl5nuJhvXH/c3phJOcz09Uww/E0kwYTMjWXaEBofsoHAD43N1ogDXuVE2b30XLF/lckWogfrHclYceneGGFWumWZgKqWSbNWJ7rdL+JiVOXO8n9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605939; c=relaxed/simple;
	bh=22XW+V5XF0iLnR9+YP/enVD7BjheUREeDzPkDNifOPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HYc0G1C8cZesJcUJgC7KIsh5N/btGC4DPThN5Sp5nnYH50qcYCaGSyshXvyOT+Ja90J4RAbqcb8JmnRFSRQRqIpi8c+i2vsLwo9PQflJXxBk5ly0FkSmYKDzQdwtJNQtfoNo7dwL2nCfbRE7XEg/vrc2gQ3CDkep8gZv5rGtQ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=E2gh5g0k; arc=none smtp.client-ip=148.251.105.195
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783605936;
	bh=22XW+V5XF0iLnR9+YP/enVD7BjheUREeDzPkDNifOPI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E2gh5g0kBLcL0tlvGP5nqHnNOU9SxBdqIErJCJ08vhsQe96SukRtXPz0bsZ31RePJ
	 heP8e84zIwb2JQlb79rVImPzBDdiu6WMid3f1JVswovoT0UVHBJsLz5cKuu2mPR3J8
	 vdQ//iJB/Ewhm7tFUxQTIUHJt1y8BCctSOj+xi6+swIyxdqNOj5iVKDsfE0E7WA4ih
	 6xXs5SJkWULzDLLjdRtyMDq1reTPelSSTxCaqElhEmaT0j6DOLIfH1caWtr6/yBa65
	 cqEAblwdhI6KY9XPbbO+UhVkiQTtltwIxsSxaX9BOxMkILfdmYaOolzgtpgKutMal6
	 R0XunXKcYLiSQ==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 84B4D17E01AC;
	Thu, 09 Jul 2026 16:05:35 +0200 (CEST)
Message-ID: <39ba7e37-bdd7-41ab-b72d-fed0bdbfc3b6@collabora.com>
Date: Thu, 9 Jul 2026 16:05:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/18] dt-bindings: clock: mediatek: Add MT8189 clocks
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Chun-Jie Chen <chun-jie.chen@mediatek.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Edward-JW Yang <edward-jw.yang@mediatek.com>,
 Richard Cochran <richardcochran@gmail.com>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, Irving-CH Lin <irving-ch.lin@mediatek.com>
References: <20260709-mt8189-clocks-system-base-v2-0-2926da3db6cf@collabora.com>
 <20260709-mt8189-clocks-system-base-v2-8-2926da3db6cf@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260709-mt8189-clocks-system-base-v2-8-2926da3db6cf@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306272-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[collabora.com,baylibre.com,kernel.org,redhat.com,gmail.com,mediatek.com,pengutronix.de];
	FORGED_SENDER(0.00)[angelogioacchino.delregno@collabora.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:louisalexis.eyraud@collabora.com,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:matthias.bgg@gmail.com,m:chun-jie.chen@mediatek.com,m:p.zabel@pengutronix.de,m:edward-jw.yang@mediatek.com,m:richardcochran@gmail.com,m:kernel@collabora.com,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:irving-ch.lin@mediatek.com,m:krzk@kernel.org,m:conor@kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[angelogioacchino.delregno@collabora.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,collabora.com:from_mime,collabora.com:email,collabora.com:mid,collabora.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7EBA57327DD

On 7/9/26 15:42, Louis-Alexis Eyraud wrote:
> Add dt schema and IDs for the clocks of MediaTek MT8189 SoC.
> The MT8189 clock IP provide clock control for main system
> (apmixedsys, topcksys and vlpcksys) and subsys (eg. peri, scp,
> ufs...).
> 
> Also, add compatible for frequency hopping and spread spectrum clock
> functionality and reset controller header file for MT8189 UFS reset
> controller support.
> 
> Co-developed-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Both the commit description and title are misleading, as in, you're not adding
MT8189 clocks, but *both* clocks *and* resets.

Fix it please.

After which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   .../bindings/clock/mediatek,mt8186-clock.yaml      |  15 +
>   .../bindings/clock/mediatek,mt8186-fhctl.yaml      |   1 +
>   .../bindings/clock/mediatek,mt8186-sys-clock.yaml  |   5 +
>   include/dt-bindings/clock/mediatek,mt8189-clk.h    | 433 +++++++++++++++++++++
>   include/dt-bindings/reset/mediatek,mt8189-resets.h |  17 +
>   5 files changed, 471 insertions(+)
> 



