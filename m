Return-Path: <netdev+bounces-260045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEkWFFNdnGmkEwQAu9opvQ
	(envelope-from <netdev+bounces-260045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:59:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6572617792B
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE7CE300869F
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7240725F96B;
	Mon, 23 Feb 2026 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="m93/wLHB"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD64B67A;
	Mon, 23 Feb 2026 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854850; cv=none; b=HJIdCIt0aOvql15NYuXEZ6z0q7h6QnB5XRWjZ6/C6pyt3x8OxvLF5Mxhxd0IcA8RLjBvJaXZ2iwXzijASHLSsmFVD4hY/L38Za7myyLNz+RqXR0MWbtqHR/J95/10sFnc8RWUtGLk6XQ4stV/QBlXCBgjgXFWvT3qe8+MyvrCeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854850; c=relaxed/simple;
	bh=OIrW2x18OBe7MtWg9i3mOOyaUsL/tDgUO70shj0Bbso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHhDq4+vyDSOCZ2q+tA4/6vQDkAF2yU7Y5YS/GxoygRpeXOqXIPN67cvOxt4u2WkQb2TZnxFJZafKKNHYkTOeLBGoegdHC3LJ1IMi9B/hZeUFYleqim3bxCdmx8dvjPQZ4mwtvzreF1p2OEB2kteqbCMgvlObdfsA3kro5xu8ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=m93/wLHB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1771854847;
	bh=OIrW2x18OBe7MtWg9i3mOOyaUsL/tDgUO70shj0Bbso=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m93/wLHBj5MojNg8x/3XhD7n67KrTfMf1tReVhaLtzoyPsAfLd3DUg3IFTsTKNLDM
	 FvvMR4KQM5z3f5HzguS8dhxp6Mp56AQ1GgQYisThGW4yn3jVk0wHSOcuiPGymEOG7r
	 /o+NnKlgY7xGBlX9dvNqg56q6sDH1Sxv8Tr1HhHO+piyXdYJVRz39Cf9HePb/lTdei
	 4HSn9lyT4cUBG+YEjGQHSb92jmqAkyc18+SfSuHs585OOv+un1CLjsYMyGphVD1vSn
	 oiFBhp/mMf/npegCu0Eu9VddNTyh7ekPKcWgq7PE8OxDNCcnqVs9z+2q0zt7BVehdf
	 S8hI9PPpSwoxA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8C91D17E04D4;
	Mon, 23 Feb 2026 14:54:06 +0100 (CET)
Message-ID: <864fe00a-1b4c-4ba0-8f42-c1b04f2999ad@collabora.com>
Date: Mon, 23 Feb 2026 14:54:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/18] clk: mediatek: Add MT8189 vlpckgen clock support
To: David Lechner <dlechner@baylibre.com>,
 "irving.ch.lin" <irving-ch.lin@mediatek.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
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
 <e0b39f90-f4a4-46c5-90ff-54a261c075b4@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <e0b39f90-f4a4-46c5-90ff-54a261c075b4@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[baylibre.com,mediatek.com,kernel.org,gmail.com,chromium.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260045-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[angelogioacchino.delregno@collabora.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:mid,collabora.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mediatek.com:email]
X-Rspamd-Queue-Id: 6572617792B
X-Rspamd-Action: no action

Il 19/02/26 22:10, David Lechner ha scritto:
> On 2/2/26 12:28 AM, irving.ch.lin wrote:
>> From: Irving-CH Lin <irving-ch.lin@mediatek.com>
>>
>> Add support for the MT8189 vlpckgen clock controller, which provides
>> muxes and dividers for clock selection in vlp domain for other IP blocks.
>>
>> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
>> ---
> 
> ...
> 
>> +static const struct mtk_gate vlp_ck_clks[] = {
>> +	GATE_VLP_CK(CLK_VLP_CK_VADSYS_VLP_26M_EN, "vlp_vadsys_vlp_26m", "clk26m", 1),
> 
> In mediatek,mt8189-clk.h, we have:
> 
> #define CLK_VLP_CK_VADSYS_VLP_26M_EN			24
> #define CLK_VLP_CK_SEJ_13M_EN				25
> #define CLK_VLP_CK_SEJ_26M_EN				26
> #define CLK_VLP_CK_FMIPI_CSI_UP26M_CK_EN		27
> 
> Are we missing the middle two clocks here?
> 
> Or should the be omitted from the header file?
> 

The arrays must match bindings, and since the two clocks are missing, this means
that this is completely broken.

Regards,
Angelo

>> +	GATE_VLP_CK_FLAGS(CLK_VLP_CK_FMIPI_CSI_UP26M_CK_EN, "VLP_fmipi_csi_up26m",
>> +			  "osc_d10", 11, CLK_IS_CRITICAL),
>> +};
>> +


