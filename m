Return-Path: <netdev+bounces-283308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AxDJAk69Wl8JgIAu9opvQ
	(envelope-from <netdev+bounces-283308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 01:40:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BA64B0570
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 01:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C196130166DC
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 23:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F5A36CDF3;
	Fri,  1 May 2026 23:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwDgQio7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41019366079
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 23:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777678855; cv=none; b=GDn0xNVt5W+ou1ZFe3BhIYEEBlkcvy5fg0GKPV4fZm4bv4PuD1gv05TaIq8lZv6eAkTefw74KTuMBA2CQ+M29jhh69BR+lQDpsF5iWSadx/Yz8HWtVeZjlK0flBMPouz73Fxl2mmlXnw583mvVDrjk1zpT7koCIeo+yupzWya70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777678855; c=relaxed/simple;
	bh=WExdvJ9e3UJXKudyOxvJ7IX9xdwi3Wg7H+r/lMC8Pm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e29tFVXV2mSCoZHMqQOtRhvLJQbIidY6kaMyGC7ZD6ip51tMEgc9d+mgwtBJjVYKirr7I0LKFUHrqnLZGkWANm0c9hMPyXXHMNy6Y8VXVaf+4L7D3oGtskva4u1+lXzxjTw6WfadDJAWbvHkEVX+WvN6UuwapCrddR1rt5iiAUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwDgQio7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90255C2BCB4;
	Fri,  1 May 2026 23:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777678854;
	bh=WExdvJ9e3UJXKudyOxvJ7IX9xdwi3Wg7H+r/lMC8Pm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FwDgQio7/Xp0q7WgJeIVCEXEjOy/bgXXTxqFrbZHAY9fzlbIA+1hBVhroVeCcHPJA
	 W/2blfo4mTfQY2+WDhh1Xl1cUOMbiPmt4yLbui/jK5LpIuwNXjWOczjPOX0EiMptbE
	 O5vhvOwYLLZqQz/EXeNKPwJR/3jLEr/SZSKTbSG5ThH4xEjjhIfS8RVW8StRhJ9XsY
	 FYMxRB9TM0yg4mMDIvw1AE21xR0vdUygdZIs3nTzYckXoXA9wlFPfgMbHleKY9g6Yk
	 t3SBhenvmV5PcKZ/3bmviFiU+vSci+hodC3zgZynykKnHsQ0bmmWyr7yHAo/VI9sBa
	 izulWEyP+18kQ==
Date: Fri, 1 May 2026 16:40:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Joyner <eric.joyner@amd.com>
Cc: <netdev@vger.kernel.org>, Brett Creeley <brett.creeley@amd.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/5] ionic: Update ionic_if.h with new extra
 port stats structure
Message-ID: <20260501164053.23312056@kernel.org>
In-Reply-To: <20260501031555.43259-4-eric.joyner@amd.com>
References: <20260501031555.43259-1-eric.joyner@amd.com>
	<20260501031555.43259-4-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 18BA64B0570
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283308-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, 30 Apr 2026 20:15:53 -0700 Eric Joyner wrote:
> @@ -2951,6 +2959,7 @@ union ionic_port_identity {
>   * @sprom_page17:    Extended Transceiver sprom, page 17
>   * @rsvd:            reserved byte(s)
>   * @pb_stats:        uplink pb drop stats

Looks like the removed field is left behind in the doc?

> + * @extra_stats:     Extra port statistics data
>   */
>  struct ionic_port_info {
>  	union ionic_port_config config;
> @@ -2968,9 +2977,7 @@ struct ionic_port_info {
>  		};
>  	};
>  	u8     rsvd[376];
> -
> -	/* pb_stats must start at 2k offset */
> -	struct ionic_port_pb_stats  pb_stats;
> +	struct ionic_port_extra_stats extra_stats;
>  };

