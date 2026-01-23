Return-Path: <netdev+bounces-252963-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBt1GLvWc2kOzAAAu9opvQ
	(envelope-from <netdev+bounces-252963-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 21:14:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE557A8A6
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 21:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEBE4300D9C4
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D3B1D5151;
	Fri, 23 Jan 2026 20:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6ib5QRq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE803EBF06
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 20:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769199288; cv=none; b=R6uRPlaHmFrMt0d21NgrUJxYdNlcgeWR6UCIvMogICgKkvuxlly1kk6IBYpUTiVQRnU9dnONP1uJtZzmYimkINsxejIi1bEhJjSyZLZYdCpKks7PHnNe99bur1dLrt+KP8vWG6jGRVC27NTgDoMAbnRovv5D2e8jH6X2Mq24AEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769199288; c=relaxed/simple;
	bh=GnDzDaAq8IjaJTTGRRh0Qx+PjtEQDotnGHUbuy+Aw5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGE4tyGHLEZwNWlqT83SWsPEVULDr2KIRB2drte+HeDEWsJxHBwfIYlKlOTauT4LAt9aYKP3W4OU9XI0kLp7az3iHt/GoFZOxwbR8+pVpESsElTslxEkz4yRRH2pUb6tnIqzmAThSgBnyb00NHVC0U//A69evNn/K8IeeRTeeWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6ib5QRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F2DC4CEF1;
	Fri, 23 Jan 2026 20:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769199288;
	bh=GnDzDaAq8IjaJTTGRRh0Qx+PjtEQDotnGHUbuy+Aw5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s6ib5QRqY5q/UZdugTHRwCSAOW/VCpLhdswV7ig1ldBOU5PhcYx+wO+KAFlyqlTH/
	 0mrmoNCeaWzkwZ59KqotP5dqvMEE4PY6hUZGy/QHJfFnVCBBJfMJjOdtQAE2qxHC6B
	 HeZC3inlwS2iWvP+6oqrpEBfnNTLEXEhshSgC4Sz+/9C52FOZNNXhLqDQa8oMY+VxY
	 9DHC+rYR0WsiGSO4IgXmxtljx3jaFSHQgxYWY7KvhH+QkpSsYDYzFna3Fk5EVxASY+
	 EQKIdmqH5pXVWfjVpsO1cpK3N0S8PKcS2Xybl02Es0Eq8DHplC1GxEMVAHq9vGHVD6
	 P1LQ+aYkjEFbA==
Date: Fri, 23 Jan 2026 20:14:44 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Mahesh Bandewar <maheshb@google.com>
Subject: Re: [PATCH v2 net-next] ipvlan: remove ipvlan_ht_addr_lookup()
Message-ID: <aXPWtCFRgNZuO1K4@horms.kernel.org>
References: <20260122165049.2366985-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122165049.2366985-1-edumazet@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,google.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-252963-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CBE557A8A6
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 04:50:49PM +0000, Eric Dumazet wrote:
> ipvlan_ht_addr_lookup() is called four times and not inlined.
> 
> Split it to ipvlan_ht_addr_lookup6() and ipvlan_ht_addr_lookup4()
> and rework ipvlan_addr_lookup() to call these helpers once,
> so that they are (auto)inlined.
> 
> After this change, ipvlan_addr_lookup() is faster, and we save
> 350 bytes of text on x86_64.
> 
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/2 grow/shrink: 1/0 up/down: 123/-473 (-350)
> Function                                     old     new   delta
> ipvlan_addr_lookup                           467     590    +123
> __pfx_ipvlan_ht_addr_lookup                   16       -     -16
> ipvlan_ht_addr_lookup                        457       -    -457
> Total: Before=22571833, After=22571483, chg -0.00%
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Mahesh Bandewar <maheshb@google.com>
> ---
> v2: guard ipvlan_ht_addr_lookup6() with CONFIG_IPV6 (kernel test robot)
> v1: https://lore.kernel.org/netdev/20260121215728.560645-1-edumazet@google.com/
>  drivers/net/ipvlan/ipvlan_core.c | 55 ++++++++++++++++++++------------
>  1 file changed, 34 insertions(+), 21 deletions(-)

Reviewed-by: Simon Horman <horms@kernel.org>


