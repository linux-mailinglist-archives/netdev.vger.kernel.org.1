Return-Path: <netdev+bounces-264312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yC1EG5tnqWlN6wAAu9opvQ
	(envelope-from <netdev+bounces-264312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:23:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F0614210885
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A9EF30D50B8
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 11:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB8836F40E;
	Thu,  5 Mar 2026 11:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIAwlwOz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BDE388364;
	Thu,  5 Mar 2026 11:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772709416; cv=none; b=bl2TViaOVD8IjIZ2SC2dkU8QuL45N56Lrp3gv2JlI4D80leiqMvMvbJTTKneGXfKybUDtKevG8c/WonGcbGP1DxkGYDPzUt68gQ0cnDeIovb+MFfYgCP76Uy0fb7VKeY3YQkqkFGYxXAPjiMVOe1xrnhpDG2vinxQmsN4l6ftOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772709416; c=relaxed/simple;
	bh=wffDf4FT3dOwIOmwn2q6s5EPtLmLJobTvyH563mzxZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idW0N/XWwIb0bKldaBVfnkznGrHzYRfGCo+VyQcmwc6HFXkME4YbDiHCuzpoUfqkwdLhizzV7ijNyCT9Stf8aH1f/UyqKsmBInrgX3lTU9ONQXNPw5u+H/obCpKfAHFsgMBcFK3mie+L1EXWpYYrqxnVP1snOR+eUoPnBup1Co8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIAwlwOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4BAC116C6;
	Thu,  5 Mar 2026 11:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772709416;
	bh=wffDf4FT3dOwIOmwn2q6s5EPtLmLJobTvyH563mzxZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KIAwlwOzmCYtZ3+VBU8vWrcD8bFqr1zYRlW3e7wDQKt5kmrbtb+hEmj/gWp/05WOj
	 lB0C33AgUEwkDFEjjdbB5ABDKBExpJOJDpv+y2+0oXVUXZom2FnO3zvZLuwy22pZh4
	 Iphcd/jQuBcykpMl/LvLB4jokqPs804F9B1db6xNbo1X+0l4Kdb2R99GclkWejKzot
	 rwAaaHhksYAoHzn/FKgbM0HgRevhqklvCcxevn7bUDNBn7zNAeqAzeCzDDjq9Iqd9x
	 ohaEGzE1LfC427KPqlK3Kvr9ravqbcLuEbXfIwgk3ADbRVjO8Z/Kew4jg6XZpC9Se2
	 13sF3RxHFZtYw==
Date: Thu, 5 Mar 2026 11:16:51 +0000
From: Simon Horman <horms@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Michael Rasmussen <mir@bang-olufsen.dk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>
Subject: Re: [PATCH net-next] net: dsa: realtek: rtl8365mb: remove
 ifOutDiscards from rx_packets
Message-ID: <20260305111651.GC90938@kernel.org>
References: <20260303-realtek_namiltd_fix2-v1-1-bfa433d3401e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303-realtek_namiltd_fix2-v1-1-bfa433d3401e@gmail.com>
X-Rspamd-Queue-Id: F0614210885
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264312-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org,yahoo.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 05:25:12PM -0300, Luiz Angelo Daros de Luca wrote:
> From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> 
> rx_packets should report the number of frames successfully received:
> unicast + multicast + broadcast. Subtracting ifOutDiscards (a TX
> counter) is incorrect and can undercount RX packets. RX drops are
> already reported via rx_dropped (e.g. etherStatsDropEvents), so
> there is no need to adjust rx_packets.
> 
> This patch removes the subtraction of ifOutDiscards from rx_packets
> in rtl8365mb_stats_update().
> 
> Link: https://lore.kernel.org/netdev/878777925.105015.1763423928520@mail.yahoo.com/
> Fixes: 4af2950c50c8 ("net: dsa: realtek-smi: add rtl8365mb subdriver for RTL8365MB-VC")
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---
> I'm taking over the original patch submitted by Mieczyslaw Nalewaj
> (with his authorization). The original message is referenced in the
> Link tag.

Reviewed-by: Simon Horman <horms@kernel.org>


