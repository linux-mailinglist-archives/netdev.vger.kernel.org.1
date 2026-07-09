Return-Path: <netdev+bounces-306265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z5VPGFKuT2qvmgIAu9opvQ
	(envelope-from <netdev+bounces-306265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:21:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7E3732257
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:21:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=mail header.b=Y94DA6lA;
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306265-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306265-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB06A305897F
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 14:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4E33264DC;
	Thu,  9 Jul 2026 14:01:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593482C029D;
	Thu,  9 Jul 2026 14:01:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605710; cv=none; b=mra7oXZNRpeDcdeP5kTd8yQXiih29aYTx3ze7ZeEb9M14Re6cLL05HlUJvSSSq7hcEMHZVmxk9UOXL132gTMixHhKPvhE+5q7NG1EXVY0jbLjQfp9sQBdws62TuYNnVcFuje7L2LCSxGlT1xCSOIJLT/71adz77WC+trhE+RkXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605710; c=relaxed/simple;
	bh=NsUUyYLiMvVkx3K07K1ak3fXf989M3aFmNYTZApMkJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WoDBap/tsRviMQsFNOudJcU4pg6DfR+5S4mN++opBWda7UF50pjCOKJVuJ2DVAgUyJn/JolEoWWxipPnJ34EOnfu06OI9ySPOp/eYjrAtNFxCGrwB5ukov/POyfA4Gv9mPmwMtoEOtx5EBuY6Jj+sAGhwtMaFQJGVLO1RGbTsyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Y94DA6lA; arc=none smtp.client-ip=148.251.105.195
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783605707;
	bh=NsUUyYLiMvVkx3K07K1ak3fXf989M3aFmNYTZApMkJo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y94DA6lABAfIWKm9mEjfNwpSSs1ze7b4zequXSUlSnjcYU2iBEoHE+09fA9x8+tlG
	 gAMBhdkw+hXVTGiMKO8Qn4xoBLJ5DvM6+FXbkAgeZ+09RMDvYSFNRg0ZO/HH6VQ2mW
	 keAfhg5Ijdh83U32b72/4p5kgV4EqhEUbIJ5Mym9Le39uNfQii6lXmcTd9/bg7CdLi
	 U3Oyp80ASvEE+lkGxl1J1hPnPws/76oNSIJ/GYGx8NCgxZslQJowTiTT5sLNgOvLFK
	 7iJFoG+Rus5j3gV8hCzX4L8BsscHKysfrGVm3aaofUahICkOnVyya9yqYiY2p+olKM
	 p0xXvGGoXADSA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B847317E0D33;
	Thu, 09 Jul 2026 16:01:46 +0200 (CEST)
Message-ID: <122d78b9-7e22-449b-ad27-f456d807f9e5@collabora.com>
Date: Thu, 9 Jul 2026 16:01:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/18] dt-bindings: clock: mediatek: Make
 '#clock-cells' required for MT8195
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
 netdev@vger.kernel.org
References: <20260709-mt8189-clocks-system-base-v2-0-2926da3db6cf@collabora.com>
 <20260709-mt8189-clocks-system-base-v2-3-2926da3db6cf@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260709-mt8189-clocks-system-base-v2-3-2926da3db6cf@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306265-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:louisalexis.eyraud@collabora.com,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:matthias.bgg@gmail.com,m:chun-jie.chen@mediatek.com,m:p.zabel@pengutronix.de,m:edward-jw.yang@mediatek.com,m:richardcochran@gmail.com,m:kernel@collabora.com,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[collabora.com,baylibre.com,kernel.org,redhat.com,gmail.com,mediatek.com,pengutronix.de];
	FORGED_SENDER(0.00)[angelogioacchino.delregno@collabora.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:from_mime,collabora.com:email,collabora.com:mid,collabora.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC7E3732257

On 7/9/26 15:42, Louis-Alexis Eyraud wrote:
> Both MT8195 clock controllers dt-bindings (clock and sys-clock)
> document the '#clock-cells' property but do not enforce it as required
> property.
> As clock provider nodes should define this property in devicetrees, add
> it to the required property list in both its dt-bindings files.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


