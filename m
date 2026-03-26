Return-Path: <netdev+bounces-271896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNCoNsXfxGnz4gQAu9opvQ
	(envelope-from <netdev+bounces-271896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:27:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B52330696
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E0DD300CC13
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E912034CFDA;
	Thu, 26 Mar 2026 07:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIz0VaML"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69516349B16;
	Thu, 26 Mar 2026 07:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774509931; cv=none; b=EEkQCWb2rWZq2tJqD9BA0CkSJDUQThLdbkiH+O2l1nUNsUnHbwmQmtAP0NJ/LaxG8ZDL79gizO0Ri3q3wHMsKVhztwudZSVYGVyKtWUoeWip5sQ3tRn1W6254AnSJgUIDDcOgdidzKm98mpVYIHe0MLMz7svykYxQuBcjiCZSg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774509931; c=relaxed/simple;
	bh=cj12Kja1BOAGu3Nk1rs+olrIuJVFqGiDXAjaY0Ktz3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/cG2HmZ+ifc8L2FHbVOE3U7mIwqXbxn1lCgcWU52HT/5T3vip4dHBuZC2ptvTUwHGXN0HmpFg9PT+sLii7fgk7wvDMGj6GoScn+pwkZVaGdUzkj+LuLiAKHN74Qjyas06fanGq1C58tTVWDlrXLgMAMnEB5H7M4bDOzIkdOQAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIz0VaML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C30AC116C6;
	Thu, 26 Mar 2026 07:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774509930;
	bh=cj12Kja1BOAGu3Nk1rs+olrIuJVFqGiDXAjaY0Ktz3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KIz0VaML7axJe9wrMWDR9ULbMHLjOmqpnxhnynzAjlDFl/5xpcPa4dUmV+0kW/uXl
	 8dBoLVNaAnO55y536ZTjpxyJ+gFZFXp446SCnnigeZBD4b+SNckLzndXHbbWimzP7p
	 lK+qP4BSIcLIRj/Aqzh1+pDL5CHcKecQBLomsaAgh1LFv2Md5VtDMnhwl2NiD7jXnY
	 cO03I5aiV87zWENGO172+FGdVof1YAiD6gWOcRWXpjLaC5xsfGd9Z9bMDksPAfgZfv
	 0H4vC/5OG1blR3t+nGqpmeQ7UfiZDmKLKtS52kTyqXakrvEdNO27I0VYHLbLgSoYQS
	 ZvdVhhnRkSOVA==
Date: Thu, 26 Mar 2026 15:25:28 +0800
From: Yixun Lan <dlan@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v6] riscv: dts: spacemit: Add ethernet device for K3
Message-ID: <20260326072528-GKF777612@kernel.org>
References: <20260326014617.1011732-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326014617.1011732-1-inochiama@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271896-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,gentoo.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlan@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 87B52330696
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Inochi,

On 09:46 Thu 26 Mar     , Inochi Amaoto wrote:
> Add all ethernet device nodes for K3 SoC.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
> Require the following patch series:
> 1. Basic DT device patch
> https://lore.kernel.org/spacemit/20260304-01-dts-uart-full-v1-0-50a0aa53a245@kernel.org
> 2. Ethernet driver patch
> https://lore.kernel.org/spacemit/20260316010041.164360-1-inochiama@gmail.com
> 
> Changed from v5:
> 1. Fix DT warning cause by stmmac-axi-config.
> 

It would be great to let people know explicitly that you dropped the tag
they gave, but I can understand you wanna be cautious here, so again

Reviewed-by: Yixun Lan <dlan@kernel.org>

-- 
Yixun Lan (dlan)

