Return-Path: <netdev+bounces-273386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJD8IE4My2msDQYAu9opvQ
	(envelope-from <netdev+bounces-273386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:50:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 348353626DD
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BEA1E301C156
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 23:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C093B9608;
	Mon, 30 Mar 2026 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDyxkL9+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629192222AA;
	Mon, 30 Mar 2026 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774914636; cv=none; b=N+JyhJmsUhYGEbGIZcud11bKuIjUOONsucWvYQ4rwvG+szG857U00Zk7St9+a6aYRtT2gPr1mBznSUQsYXPLMPAimuBuu9AqRhRISgI66pMULmq++ejSwzZttcKjHu6dhFF85U2t4kEvk2SWX4f22MKTuHEM6y/IqyRzgN3pUnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774914636; c=relaxed/simple;
	bh=JVVrzySmnic9rg1EeQ6y1WKifnCxJQGEKcDGIcyoNTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hdxHy4S+erlYoFK9NXz5m5Eej7cqQlyBb7Cjbz3JXu+oolgCyE81WG8gZv30jDiKjtPwxBAxzjwjGFg5fQC1euEKs5WiVrUL/XK8kHNIgG+vzTGgOQz22wO/A5RNFVjU8YZKJBETgz4tHwyVcgenmliA8464SISbLWOaU+xxsOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDyxkL9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D42C4CEF7;
	Mon, 30 Mar 2026 23:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774914636;
	bh=JVVrzySmnic9rg1EeQ6y1WKifnCxJQGEKcDGIcyoNTQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lDyxkL9+3vPulSQJ3j6cAvhHtj/Yk/aq+YaNvRaHzJvA1RFSxfPDLX+2KE0HohecT
	 gNe6r2h+oX8/vAHvA5ooIZUDTsmYRMrFsWO/nSEc8W9OgtBTJt+K8/aW+aeNhbyDOI
	 6ADhAWr90LOu7wsnXfRcsJsHsJdMPBuu4WDPcdaFOvouTZ4yWoS20IEvpVKoJ/OhpN
	 ErHliByO306fv4LIvUfl7jSsjtGmGlSn5YJlK6zr0TpAYPPoAH9mLmqx+YbNDjgx38
	 ZYWDHUZBAu8LqVK0sI9Ixn8ywdbqR5zVJ68fQ3fuMtogUUa8UtL+oZJjY6MbgYUql/
	 rMUBOP9652EPg==
Date: Mon, 30 Mar 2026 16:50:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org, leon@kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [net-next v6 12/12] selftests: drv-net: Add USO test
Message-ID: <20260330165034.2353cb0d@kernel.org>
In-Reply-To: <acqyCOYz7HqvnvQz@devvm20253.cco0.facebook.com>
References: <20260326235238.2940471-1-joe@dama.to>
	<20260326235238.2940471-13-joe@dama.to>
	<20260329153130.61b29766@kernel.org>
	<acqyCOYz7HqvnvQz@devvm20253.cco0.facebook.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-273386-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 348353626DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 30 Mar 2026 10:25:28 -0700 Joe Damato wrote:
> > > +def test_uso_v4_exact(cfg):
> > > +    """USO IPv4: exact multiple of MSS (5 full segments)."""
> > > +    _test_uso(cfg, "4", 1400, 1400 * 5)  
> > 
> > Variants are probably a good fit here.  
> 
> Is the right way to do this by using test_builder?

grep for ksft_variants, I'll send a patch to mention it in the README
shortly cause I think it's missing there

