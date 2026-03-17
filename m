Return-Path: <netdev+bounces-268361-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLI1IICluGkChAEAu9opvQ
	(envelope-from <netdev+bounces-268361-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:51:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D71092A254D
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BF67302979A
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E754D1E5B63;
	Tue, 17 Mar 2026 00:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJfiW6Ye"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C279F25776;
	Tue, 17 Mar 2026 00:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773708658; cv=none; b=GVj+r2zR81C+rs4pbTCY5PuuIbbhc8PT5WPI7LZm27/fzzGAtibwmil283JoQ+TtXR2/Dstr2XTrQOYTxVCIAbA3qpGuFjvaKIV5JVNJtUrI4fbOpuMR+1RwrK2WqHm9kKVBOJ30F9lG4lDqSiY+mnt49+RH69rBEmxluoUynlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773708658; c=relaxed/simple;
	bh=fdzrkSXAkNNJgnxg68yEp+xdEIxlbeKNfJbdDzlcbIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szCjCTg/BQ1WLSQGFogZVf1G/A+H+aunMvBLkJgoLza3nLP0s40g82b5zBVLVXACSSlaMlJEjkkFNWEY4HQdLpxKo8ZzDJbdRceyDZ+OB1BNf9cP/07EzvCqbxsFC559hT/zdAto+Dh76yZSUClM5dNJ8ih2wM2DPAjsEq1eTMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJfiW6Ye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2777EC19425;
	Tue, 17 Mar 2026 00:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773708658;
	bh=fdzrkSXAkNNJgnxg68yEp+xdEIxlbeKNfJbdDzlcbIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nJfiW6YeADlliBUJG6Zni6/s4tJGVGdz2zp9Vq5sWeUTV9POKktu5u0vhWxWAmgRO
	 x3xqGB17IxijI/F341jLQs2LHWvgeIoLI5kMHWjZtVXcGlKF3kh1B74dc/1OXnGRN+
	 ZZxXH1pHZ6UcpNCmW8gZEeQzPoEEn4tiNuQ1zhXmeVEFDCq9qgSvcX6Vd0+2cVT/Qm
	 gg1BhHpX/p7LOGF/TY0Pxr8rWP2TIM9nOCagJsfenNfYBedX0TKtD0w0RGRRyAkaU6
	 pErb4A1Cku3e+3gPMGcWJQA+1IqQT3rgjw5pIwbQN14uxo827UCOrVC4bj0t8NAlSV
	 5KHEbTCoA6BBQ==
Date: Mon, 16 Mar 2026 17:50:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 6/9] r8152: Add support for chip version
 RTL_VER_16
Message-ID: <20260316175057.7eed3fab@kernel.org>
In-Reply-To: <20260314-rtl8157_next-v1-6-9ba77b428afd@birger-koblitz.de>
References: <20260314-rtl8157_next-v1-0-9ba77b428afd@birger-koblitz.de>
	<20260314-rtl8157_next-v1-6-9ba77b428afd@birger-koblitz.de>
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
	TAGGED_FROM(0.00)[bounces-268361-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D71092A254D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 14 Mar 2026 10:31:42 +0100 Birger Koblitz wrote:
> The RTL8157 uses RTL_VER_16. Add support for this version in all
> remaining configuration functions for power management and RX/TX
> configuration.

../drivers/net/usb/r8152.c:1744:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
 1744 |         if (i == 10)
      |             ^~~~~~~
../drivers/net/usb/r8152.c:1747:9: note: uninitialized use occurs here
 1747 |         return ret;
      |                ^~~
../drivers/net/usb/r8152.c:1744:2: note: remove the 'if' if its condition is always true
 1744 |         if (i == 10)
      |         ^~~~~~~~~~~~
 1745 |                 ret = -ETIMEDOUT;
../drivers/net/usb/r8152.c:1734:12: note: initialize the variable 'ret' to silence this warning
 1734 |         int i, ret;
      |                   ^
      |                    = 0

