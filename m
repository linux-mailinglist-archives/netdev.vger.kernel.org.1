Return-Path: <netdev+bounces-252134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIkMBkGBcWk1IAAAu9opvQ
	(envelope-from <netdev+bounces-252134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 02:45:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE59A607A5
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 02:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AEC703CBF81
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C2935CB87;
	Thu, 22 Jan 2026 01:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJPwb6+B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7263035CB7C;
	Thu, 22 Jan 2026 01:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769046307; cv=none; b=coLkie9YAr2HZBcjZh0xmO+7nZbfuBsktD0w0siSqIWXHS1I8eFQNe/8Qc5cwGVNoUL2j6spoOtbtO+eznbn51JckAgmYSul2q8y4DCeUWIGWYyTpnurgeSs/Kaqowx+HcAJ2we+ywG50NDColhtta60JIT6N9iVt13bSCZVrB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769046307; c=relaxed/simple;
	bh=Vcm1qOWkB8oHILUnwnZvnc0LrLfTguH+RX9NkigA/7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f1DiXQr/eGk2AfmuWqJObyguRte1HW5KFzUwx4nQ1/xXpuk3rVU3hM01j/dcybMqJtyf0Qh9DBKpfpWrCdHbs5Q/X+AKZYtZv+9jymiBEUxcWm/4Km+E/9fsPmCO7LkrLb0uUkUKE0P4qefg2KVtHwH0z30lIrdst4q0u6gu8cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJPwb6+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A20C4CEF1;
	Thu, 22 Jan 2026 01:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769046307;
	bh=Vcm1qOWkB8oHILUnwnZvnc0LrLfTguH+RX9NkigA/7E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BJPwb6+BCZSce/4Ucq/sR7FZR0l5p8pfengCDy9M5UHcsTMzoQTi46A2/2QdpuHfU
	 2+w99z9AlbkPS33/D1qslqE8Eeg0SPD9GdGO1vsJCLPnc0jYP2pca+1Ecxv5XGfXqk
	 GxL7n7hDXycJq4Wni1hfZhYbUnQP6D2L/rPPor3gbTX4D0rre1aL9+jLhiFHotyyWY
	 Fj6PeFz4lvs+gzDIsjPCq7OES7nV6AIHDSkaoRcF4erj5kLB524DrpqF0UvlGuZG60
	 EsSJSZ/MbAojH1fOeRLrUEE1aPxzyKGc4FzpbzjSRtUhxvgE7OV19ZBejT2WrQdP1x
	 8OVwO30QJO13w==
Date: Wed, 21 Jan 2026 17:45:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 7/7] selftests: netconsole: validate target
 resume
Message-ID: <20260121174505.5e710b0b@kernel.org>
In-Reply-To: <aXFIk1L8G_dHF6od@archlinux>
References: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
	<20260118-netcons-retrigger-v11-7-4de36aebcf48@gmail.com>
	<20260120172057.6600eefe@kernel.org>
	<aXFIk1L8G_dHF6od@archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-252134-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: AE59A607A5
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 22:04:23 +0000 Andre Carvalho wrote:
> On Tue, Jan 20, 2026 at 05:20:57PM -0800, Jakub Kicinski wrote:
> > On Sun, 18 Jan 2026 11:00:27 +0000 Andre Carvalho wrote:  
> > > +++ b/tools/testing/selftests/drivers/net/netcons_resume.sh  
> > 
> > There's too many of them now and they keep failing on real HW.  
> 
> Since these tests are only using netdevsim I was a bit surprised about the failures
> on real HW runs.

My main point is that even if we fix the HW setups to do the right thing
in systemd policies - the tests are running against netdevsim, not the
precious HW present on those setups. The HW setups have actual physical
NICs, driver tests are expected to use netdevsim if $NETIF is not set,
and if set whatever existing netdev $NETIF is pointing to.

I don't remember the history, it's quite possible that Breno wanted to
have a separate target for netcons from the start and I pushed back.
I think we reached the point where we want to create a target.

