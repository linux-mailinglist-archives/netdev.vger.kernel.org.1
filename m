Return-Path: <netdev+bounces-306267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hbhrKn6uT2q9mgIAu9opvQ
	(envelope-from <netdev+bounces-306267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:21:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C502F732280
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:21:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=mail header.b=eZ+WEEEt;
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306267-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306267-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D27C931BE1A4
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 14:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AC5366DB6;
	Thu,  9 Jul 2026 14:01:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C3223392C;
	Thu,  9 Jul 2026 14:01:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605713; cv=none; b=cyq5sRPW8ou4x8L1sAXvjkZa+ArpHMtFH3KpSbECnN3S1V4K1Bqd3+LLb/gJgoWx2/adJ/qj6f9BBt4ogeQqo18QU+RiGUNGZsWDM5PFZHBzOAsCmWNcZrCff2pbv9f7Aqa14kjQrJMooOdck83aQiZN2FN3c1x0PhXf37tzNro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605713; c=relaxed/simple;
	bh=8SkAR/Ab8XsPGdgW8BYCG02vOqkW8k+veVBNwe9Ul5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dooEX38fWZLXma/o6Mq5qosjF7+8w1/ks92dj65owJXmLkb2KhEACwMidoNxTY+324wtecwU/BhDULJLfV8F+lxs/kv6W7tGkBj4EKcs999v2ivd4i++aOdC1sktKi4+hv/73BEtzz2rAZdlFCjiP9Nt7r8tNXqtUujCH3wXhGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eZ+WEEEt; arc=none smtp.client-ip=148.251.105.195
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783605710;
	bh=8SkAR/Ab8XsPGdgW8BYCG02vOqkW8k+veVBNwe9Ul5c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eZ+WEEEtNdm44adPY3hOzL/+043uJYdbKHMRPcOv/18YBSEdZMoRnvyyqIL8/9Zt5
	 8fs7GrdxwcKJgwbDNyUcMYbBkx+ZhCs0ij/p1PX0UeHb8IPLBcNL8lTEr7vLCq+DVO
	 TTRNPt+MsiNJ6E+tfrSZPcAh9pn8TGJqfm1uiz71RYzV9ajbnG8D7furdXlRu9ovaX
	 clxJ/Z1QYFaE+9JVTpbx7GrjX1Vp74T6aexce8p5OinZoYqF/3i8vRFiSP4gvaj+T7
	 EzW3N7xkMs+JUCu6VOneil+AMeXom/GfEu89VRtlJGLFu0YRKjHX/WqNgzYiJ7TqEO
	 A3O8/cowCQsNw==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7569317E0D56;
	Thu, 09 Jul 2026 16:01:49 +0200 (CEST)
Message-ID: <fe7dee8d-afe9-441e-898b-695aacf1aa04@collabora.com>
Date: Thu, 9 Jul 2026 16:01:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/18] dt-bindings: clock: mediatek: Make
 '#clock-cells' required for MT8186
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
 <20260709-mt8189-clocks-system-base-v2-1-2926da3db6cf@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260709-mt8189-clocks-system-base-v2-1-2926da3db6cf@collabora.com>
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
	TAGGED_FROM(0.00)[bounces-306267-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:from_mime,collabora.com:email,collabora.com:mid,collabora.com:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C502F732280

On 7/9/26 15:42, Louis-Alexis Eyraud wrote:
> Both MT8186 clock controllers dt-bindings (clock and sys-clock)
> document the '#clock-cells' property but do not enforce it as required
> property.
> As clock provider nodes should define this property in devicetrees, add
> it to the required property list in both its dt-bindings files.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Though you could've done that in one commit, or just skipped the additions in all
of mt8186/92/95 and went directly for the new one... IMO, it's ok as you're showing
that there was an actual mistake on the bindings for clock controllers.

Same comment applies for patch 2 and 3, btw.

Anyway:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


