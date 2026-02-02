Return-Path: <netdev+bounces-256033-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJq4DeA6gWmUEwMAu9opvQ
	(envelope-from <netdev+bounces-256033-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:01:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BCFD2D00
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EA2C301BC19
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 23:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D6E361DB0;
	Mon,  2 Feb 2026 23:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIR2hMpk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8391318ED4;
	Mon,  2 Feb 2026 23:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770076694; cv=none; b=uGT0SRT5tb31f+Uj6YTXXMFqoGJPvjTZFtw4JS+YpMy/mjRm4zV92T7qBfM0CmR7j2+WeJWyp1MI7RS1C9eCSKfVGupmdDEEueGHN4vsLkj7ZaLw3ksn61vpWjTeA+Ecl2YVmsWGFtYrRf/tlHjrcLBYzKuvCgU/y3o4m0L3zy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770076694; c=relaxed/simple;
	bh=BRzLYgVhduJBkOdpDGMvQh4aM+Uyxm2O3nUvq4ILHMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G4gERo2XMv47I7z4Dxp0I1vI4uToN4PsL93fqiMb9lapu58N09u7rCXzzMhZVQzzLUO8fL6JmdWvYp2ZM4d/kvUdYN8ihwuFEgnyVC8CH0R5Ffs4jRrfBsqHDH4IxP56rQacLf6kTPBK2WHTGKcVe8CmjnjJELxBQ0UFTI0IiXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIR2hMpk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15747C116C6;
	Mon,  2 Feb 2026 23:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770076694;
	bh=BRzLYgVhduJBkOdpDGMvQh4aM+Uyxm2O3nUvq4ILHMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XIR2hMpkUMbhV1MpUhritR1FLGXUgquvWgO+cNXu5uIv3h6mT47Es8QhNileswiVR
	 BZWZgFSxGoU5G8yrZQDufhvQ3Mj0Wqb1knY1oX+J3pPveV1n6c0u9DuUdnmPeSLa9g
	 /rrIDZHPlJwzvMEpL3e8OlvzExblqQrdLksg/Ll0WWbgSiLO0MxudHUM3+kiQn1BTU
	 xiY5lHWFewarOGX+MX7o12YOYAQTiLQR3Z521BySibAmGmXjDIYmUPKNKOhBYslXTU
	 MIw71MZsNU8LpfTMksiQbcSIrzo8r0cdHnu08MkYFHwIRYSuWW4pzY7lu4VxkQRsWu
	 tYf+Rr9Yi3V5A==
Date: Mon, 2 Feb 2026 15:58:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, ivecera@redhat.com, mschmidt@redhat.com, Tony
 Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Stanislav Fomichev <sdf@fomichev.me>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] iavf: fix deadlock in reset handling
Message-ID: <20260202155813.3f8fbc27@kernel.org>
In-Reply-To: <20260202084820.260033-1-poros@redhat.com>
References: <20260202084820.260033-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-256033-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0BCFD2D00
X-Rspamd-Action: no action

On Mon,  2 Feb 2026 09:48:20 +0100 Petr Oros wrote:
> +	netdev_unlock(netdev);
> +	ret = wait_event_interruptible_timeout(adapter->reset_waitqueue,
> +					       !iavf_is_reset_in_progress(adapter),
> +					       msecs_to_jiffies(5000));
> +	netdev_lock(netdev);

Dropping locks taken by the core around the driver callback
is obviously unacceptable. SMH.

