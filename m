Return-Path: <netdev+bounces-289650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGE0BmXtDGp6qAUAu9opvQ
	(envelope-from <netdev+bounces-289650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 01:08:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73172585EE5
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 01:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D213F302A2EF
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 23:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F2835E931;
	Tue, 19 May 2026 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tj+JlzbH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97B230F543;
	Tue, 19 May 2026 23:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779232096; cv=none; b=Ic1nWdXU5KIstrS5WvUsQKb74pzUDnpbAL5/JuF+uPXMvWgtsyrA/hUsg68r8O0mqTASgPA+Cini/qI/YQ9RaAIR7xaRKtXC8iGYoy4J1PMb1ZSV4kV8jOJ3scAjXPeYXp9hihgjWA6485XYXM9R70KjcRDlZKMDqn0RHN4u0MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779232096; c=relaxed/simple;
	bh=m4ouFijZ/f67FvcXcp6pmhPM+pabAiPxP914Yinp8Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZjYxUDCfAhHJf5fatFNbaW1jL+8Y2dx6ezMSk9zM88ClXxkOvNgf17hurvqDeVlM7m7ROM2fnr7hQmwnBGafYSZJ8aj6zvhvsVKitpFD21LORPTtDbJWvp6KMCPpuo98YLbl/j2Raa16pHep2SehR3lyuM74eOZp8A0bOgCtig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tj+JlzbH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197721F000E9;
	Tue, 19 May 2026 23:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779232094;
	bh=m4ouFijZ/f67FvcXcp6pmhPM+pabAiPxP914Yinp8Bw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Tj+JlzbHgJNURYEGo+0/hYiFbcHVdL/fzObe+JCLoCSMHET7hN3Yv4ntxiVTYKwYs
	 nw2xWuCRYrrjdaLc7PQWK9NkJHLwDJzHncPpnXHxLoibfgSEdc+XqgcakScoJPz33e
	 eVjMhXXWD7O/aq/eu+W7UcQ2Vqro4yDwWwZ5E4Dg3tXB0itf1rF4xBW7QQiNslSeMU
	 tQeW5im8oeIkCY306uJ030bee1AJfscNlr5J4Ci5CG7Ycqohjh24r2E7NG1RMxC9sJ
	 clbpLsqzs0ddPd5brHahNnn144N9PGB0lksimyjF+echLBZ1tWTx5+j8rqZ2A2aTd3
	 f1cW+f4zRs5nA==
Date: Tue, 19 May 2026 16:08:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman
 <horms@kernel.org>, Petr Machata <petrm@nvidia.com>, Breno Leitao
 <leitao@debian.org>, Nimrod Oren <noren@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Willem de Bruijn <willemb@google.com>, Dimitri Daskalakis
 <dimitri.daskalakis1@gmail.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] selftests: Use a master ssh connection for
 remote commands
Message-ID: <20260519160812.20678f72@kernel.org>
In-Reply-To: <20260518093653.551166-4-cratiu@nvidia.com>
References: <20260518093653.551166-1-cratiu@nvidia.com>
	<20260518093653.551166-4-cratiu@nvidia.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289650-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,nvidia.com,debian.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 73172585EE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 18 May 2026 12:36:53 +0300 Cosmin Ratiu wrote:
> This finally implements this part of
> tools/testing/selftests/drivers/net/README.rst:
> "Using persistent SSH connections is strongly encouraged to avoid
> the latency of SSH connection setup on every command."

As this part of the README indicates, the expectation was that this
part of the setup will be handled outside of the harness itself.

After all something also has to set up the keys to make sure that
the hosts can actually log into each other, right?

I'm a bit on the fence, some extra Review / support tags would be
useful, and it'd be useful to make the code in patch 3 less ugly.
Patches 1 and 2 make sense.

