Return-Path: <netdev+bounces-267546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AP2VMElKtGk4kAAAu9opvQ
	(envelope-from <netdev+bounces-267546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 18:32:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC2428825C
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 18:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 288BE30A3060
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 17:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB5C3CA492;
	Fri, 13 Mar 2026 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvAOfddE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E683CCFD3
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773423095; cv=none; b=KMDJY1xbvk/OtMiunCmqXxwgu7IhkOH0ebzRnkQe8N3jubNO25ivsKUpzhWw5Ucr0i157KeZDSp2HZk+qYPvEL8Cb+OEs7ee0nvJcPeHWs/zGZKD+mHwxN2IOqfm0LVmNDqQ9JEw+D7pW35mj+DnU9aHNZNDLjWl2UgC/WKJX5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773423095; c=relaxed/simple;
	bh=2OD3QKJX0BuMOABTQQJG5m/etYMd583kSTssW9ITCLo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OeKIwgYjufA/h8YH4htGfq9vRkTa72uEJ14VHNokIqIEXgC52jU0BkcJNWYSlVwHEDUsi+X2u0TgAZl6/TPqtQWjmKrX2bLxcLUxn6qN1VjiCpDo6Hrt9tkvnQoRv/urhtQ32S2sflF6y7z+VYEnnTddsCKrxcMRq0jxwHD8Mfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvAOfddE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF60C19421;
	Fri, 13 Mar 2026 17:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773423095;
	bh=2OD3QKJX0BuMOABTQQJG5m/etYMd583kSTssW9ITCLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YvAOfddECM9OHDCNVATd3OtuPzVTwbdAIR4qKXpmZyf0ntbXM7QW3isqGakzQ/TkP
	 sAuj/aprrqldMElTll94G04uR2Au/4dGQ6cqMRggw8gdMoR+Bv0+lzTRxlb6PoYEqP
	 A5RHcw1gqQfEjllyKFwmvhV2hp2Perxgo691o2gkxLeOT9WecsF4UTUCbm1GPFR1gt
	 RFDnZVOwjlaE6xP7XjvvHYzck48t6lmx+wTxk34WiPnL2/IUvKks3XoLSJgfUjX6wG
	 OByw319l0yqjFsIIXbW/9Row+ZIBD4YXL815Aw2y6Zhbx/V1Fq3nEAByzyG/MTz4M3
	 2V8IZGoUREA9A==
Date: Fri, 13 Mar 2026 10:31:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: <netdev@vger.kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Dragos
 Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH 0/3] macsec: Add support for VLAN filtering in offload
 mode
Message-ID: <20260313103128.41b0c511@kernel.org>
In-Reply-To: <20260313105227.1884391-1-cratiu@nvidia.com>
References: <20260313105227.1884391-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267546-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1DC2428825C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026 11:52:23 +0100 Cosmin Ratiu wrote:
>  .../selftests/drivers/net/macsec_api.py       | 103 ++++++++++++++
>  .../selftests/drivers/net/macsec_lib.py       |  20 +++
>  .../selftests/drivers/net/macsec_traffic.py   | 126 ++++++++++++++++++

Thanks for converting! I think we're missing MACSEC from
selftests/drivers/net/config cause kernels end up getting built without
it. And we see:

# ok 1 macsec_traffic.test_vlan.offloaded # SKIP macsec-hw-offload not supported
# ok 2 macsec_traffic.test_vlan.software # SKIP macsec-hw-offload not supported
# ok 3 macsec_traffic.test_vlan_toggle.toggle_on # SKIP macsec-hw-offload not supported
# ok 4 macsec_traffic.test_vlan_toggle.toggle_off # SKIP macsec-hw-offload not supported
# # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:4 error:0


Also I'm slightly weary about "frameworkification" of the selftests so
since the selftests aren't huge maybe avoid creating the lib and just
squash all the macsec tests into one file? Or is there a reason?
I know that it feels cleaner to separate things out but in case of
tests which mostly get fly-by contributions having to teach people
about libraries is quite a lift..

