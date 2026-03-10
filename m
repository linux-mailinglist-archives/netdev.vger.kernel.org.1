Return-Path: <netdev+bounces-265904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNFOOkbLr2nWcAIAu9opvQ
	(envelope-from <netdev+bounces-265904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:41:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E4D246845
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 178CA30330B2
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 07:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF403D7D76;
	Tue, 10 Mar 2026 07:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ioa+vCv3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85BB359A79;
	Tue, 10 Mar 2026 07:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773128338; cv=none; b=ovOe14baLmLFsDhzyOuX6V5KBSC0Xt+lmu1+6IWXAPnIMSMLr27AtGnczz/vGoKfpq7SF5w/I/aTZ76df7Smi9DYQaTXIQp5DGmDDBTgyH2u9k3YJ+7eNFTdMGadgU4olmrA+HjBOx15MhwmuBc3GrHbQbWW7xJk8h4NyvNKNp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773128338; c=relaxed/simple;
	bh=eigS/zAmAe39yYs+o8HKoJPAI0Rl29kSXCxO5QeFKrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdEpQvLYIfMMQo2ui38Vvp1ZYvqxX4T0z8ivhewTeSWbi2S6ma2BCEX3aXUnSptJePq9sEHl2Bs+t+pVgB3n9H1i+Zt4SafVjueaWKhx/nB62JV+h6Z9AVLYpXl0icwTr+ijQ7Hq8jiydrMiN7iiZ5VgoA9dltMC7rEMVHgnnig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ioa+vCv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBEBC19423;
	Tue, 10 Mar 2026 07:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773128338;
	bh=eigS/zAmAe39yYs+o8HKoJPAI0Rl29kSXCxO5QeFKrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ioa+vCv3zf1suIzQ56s0muplBFPtUWyxbX/mtLahEuzfGKcPw0u1wt4TOY1tn0n/6
	 ybrFCK6eDjaY/nBNHzjF+G7qwIvc3qPT+vS0qKpjjTfPX+owKYUOjJMh7j+TdA/xxS
	 xeACZi8K7y8Ss9NOLB+cR2EBxSyO3Qw7WGKubeqGMjYpvAs4dqqlYHhsoFOLQ0sJ7X
	 2x2vL2Wr9NROMmp4yslHyCXfdZts61+YBbUoC5jPMAHMjfVRjxN/R+R4fRPODd5IVv
	 YmyC8Ud6PxpaRHZkluLjIbNuATJmHa1CK2/pUr1vVMhQa0rWgXkK7u+yXXR7sG5JoH
	 EgnTZI9pQDm3g==
Date: Tue, 10 Mar 2026 08:38:55 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Richard Cochran <richardcochran@gmail.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>, 
	Miles Chen <miles.chen@mediatek.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com, Qiqi Wang <qiqi.wang@mediatek.com>, sirius.wang@mediatek.com, 
	vince-wl.liu@mediatek.com, jh.hsu@mediatek.com
Subject: Re: [PATCH v6 01/18] dt-bindings: clock: Add MediaTek MT8189 clock
Message-ID: <20260310-notorious-manul-of-maturity-facd51@quoll>
References: <20260309120512.3624804-1-irving-ch.lin@mediatek.com>
 <20260309120512.3624804-2-irving-ch.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260309120512.3624804-2-irving-ch.lin@mediatek.com>
X-Rspamd-Queue-Id: 82E4D246845
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265904-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,collabora.com,chromium.org,mediatek.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 08:04:43PM +0800, irving.ch.lin wrote:
> From: Irving-CH Lin <irving-ch.lin@mediatek.com>
> 
> Add dt schema and IDs for the clocks of MediaTek MT8189 SoC.
> The MT8189 clock IP provide clock control for main system
> (apmixedsys, topcksys and vlpcksys) and
> subsys (eg. peri, mfg, venc/vdec ...).
> 
> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> ---
>  .../bindings/clock/mediatek,apmixedsys.yaml   |   1 +
>  .../bindings/clock/mediatek,infracfg.yaml     |   1 +
>  .../bindings/clock/mediatek,pericfg.yaml      |   1 +
>  .../bindings/clock/mediatek,syscon.yaml       |  27 +
>  .../bindings/clock/mediatek,topckgen.yaml     |   2 +
>  .../dt-bindings/clock/mediatek,mt8189-clk.h   | 577 ++++++++++++++++++
>  6 files changed, 609 insertions(+)
>  create mode 100644 include/dt-bindings/clock/mediatek,mt8189-clk.h

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


