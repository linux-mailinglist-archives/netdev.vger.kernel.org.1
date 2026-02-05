Return-Path: <netdev+bounces-257080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QF5KJiRkhGkK2wMAu9opvQ
	(envelope-from <netdev+bounces-257080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:34:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A1AF0D86
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B5A6303ABE9
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 09:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A509538F944;
	Thu,  5 Feb 2026 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ez1qzQtT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8187F35F8A6;
	Thu,  5 Feb 2026 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770283253; cv=none; b=IOLt4GO7kHj2GobRXdUm2lN1ydF5YGw+0DRrNArxJl4ow2dm9U1AAlbcW7gEzZVVTuARuYqT/t5umPh9QAHbt82jzOVnDoZkDnMM4ljBEx/n/krw5hjt2SaxjAIjPDUKOxJbZ84geL3iq8EsI6vpYPzJzkV+GTu5FniREdV0F5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770283253; c=relaxed/simple;
	bh=NRd5oHFvHBd6W3hDw0oXwMkQXN1d4sUNHl26Lk8tCEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/NhnK/bU1TWPMsR+EUYktgxW5MvAe4BU2g1VJ0Uo/4ORX+BoSwr3YvB08MPC4jlRP0Rt5lIduN+59si0jmabKcaykU/MFg8oBJrnKRWfkfS/T2hpABJwyw/ZisS33YjBVIzohWh+Fd7LLRuc4hes11A5mkZhH61BDPlqChC4sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ez1qzQtT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAFBC4CEF7;
	Thu,  5 Feb 2026 09:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770283253;
	bh=NRd5oHFvHBd6W3hDw0oXwMkQXN1d4sUNHl26Lk8tCEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ez1qzQtTp6tu3mb1Ub20jyWGn7go7h/4yIexj4UGZgLB67tk6Gwl8kWZT+HPQp3uk
	 rYszlsTGDnAoNuWwirmh/3mO4R9F5w1zeS58t683G+Bjuk+WDWlTV814/k04lv9HMu
	 FLzuuwisxULTORI2i8G1ol2JBopn0pt9+F3C+GdhoEdi2At1eS6q1bmFsnZSz/JY8M
	 q1DOEsLfMx8utTbBoVtxTNsZgAmkNYq9s0VxsARK9PfGMTSR5HPxdpUTMaeHKMKs4z
	 5ARGxy/aS3yOL6oG4CjKYib1vdoBquN1VzidvBxMhjMoYW/1TgJO4O4RwUpK6L9ix+
	 j6CtcKlz2BBMw==
Date: Thu, 5 Feb 2026 10:20:50 +0100
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
Subject: Re: [PATCH v5 01/18] dt-bindings: clock: Add MediaTek MT8189 clock
Message-ID: <20260205-garnet-okapi-of-experience-dd7f84@quoll>
References: <20260202062840.342707-1-irving-ch.lin@mediatek.com>
 <20260202062840.342707-2-irving-ch.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260202062840.342707-2-irving-ch.lin@mediatek.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257080-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,collabora.com,chromium.org,mediatek.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E0A1AF0D86
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 02:28:08PM +0800, irving.ch.lin wrote:
> From: Irving-CH Lin <irving-ch.lin@mediatek.com>
> 
> Add dt schema and IDs for the clocks of MediaTek MT8189 SoC.
> The MT8189 clock IP provide clock control for main system
> (apmixedsys, topcksys and vlpcksys) and
> subsys (eg. peri, mfg, venc/vdec ...).
> 
> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> (cherry picked from commit e2402a4f2db8db0ef3cf8613f42397aaa199ad29)

Drop...

Best regards,
Krzysztof


