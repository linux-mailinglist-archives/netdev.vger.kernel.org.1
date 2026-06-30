Return-Path: <netdev+bounces-303363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fGS1FO0oRGpFpwoAu9opvQ
	(envelope-from <netdev+bounces-303363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 22:37:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF7B6E7E1B
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 22:37:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hyDsgJYE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303363-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303363-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27C0630686C9
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA8E47A0D8;
	Tue, 30 Jun 2026 20:32:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211F647A0D0;
	Tue, 30 Jun 2026 20:32:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851539; cv=none; b=RbOg9AIGpQ0/CNdIIXxAUAIzrciKA6fIJPd1cjm6sEi+PNOGxKj+6IKrBk4M9z3HxyewZxQNEPaOYKFr/H76U7Duky8O2giVOzaj//DNwRY0grD6V5p28UF8kXwQORLKSYwb/JIi3OrXLw/x0CV3yxUxZEoX0T3KhDT8hg+Z+fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851539; c=relaxed/simple;
	bh=Sl/HVCwIBdpvGLatq9Q/YI7I4nA3e5gUG5uiiOaegyk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aiXE1keapH9+bKs1mSktaKe0JqCPQ16+bZW3CYS6WSTrb/e40wp4zg1mjKu4x8Mnb23TZuLa/xig9MA1hSGqOKwGU95S8OP82kXKul/7uPZjsPF94Am4+ConDP/FoKcc71Yxhi3SBuPDLcVTq1IrF2vptgJ8e9IoMRhgDuKmLJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyDsgJYE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD901F000E9;
	Tue, 30 Jun 2026 20:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782851537;
	bh=C8uIgIBFik0MqXQz8692wMT0BwXXTwafs8Ww6H6ShcQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hyDsgJYEEo24LaLu6RKYYIrIs9IzSSElGumyU5HdCwtNXqpx2cvoLj8zRS6Zo9d3V
	 leqhJb1Qm/+lpLcKpfvLDZbxrimIoAtGTSREiNDSihxbDq6Vj2cU6WQmtmI9/u9ENl
	 56z8wWb9NCyi1nUmMMlIbiHNSBbJ0yG6ObGVrfG9XpdOOrJwd82PjN4iEcEyr/Yt36
	 VXwNQUsBwXiPyYIYLvVZRj0OD8SHyh1pFA037FWBPQTYeypv1IrW+GA45rVf8oFiDB
	 AxBNbZd+mUOdZSbOxUiJV28pXbAyxvepI1EzXjK/f8D2tkA9up8YSgTQ0TQleeUovX
	 i4Bla6uNmYxoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0DAE393A951;
	Tue, 30 Jun 2026 20:32:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2] MAINTAINERS: Update Jason Wang's email address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178285152138.267316.7554665596051831026.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jun 2026 20:32:01 +0000
References: <20260629014525.16297-1-jasowang@redhat.com>
In-Reply-To: <20260629014525.16297-1-jasowang@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 eperezma@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303363-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jasowang@redhat.com,m:mst@redhat.com,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:eperezma@redhat.com,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8EF7B6E7E1B

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jun 2026 09:45:24 +0800 you wrote:
> I will use jasowangio@gmail.com for future review and discussion.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes since V1:
> - Add mailmap entry
> 
> [...]

Here is the summary with links:
  - [V2] MAINTAINERS: Update Jason Wang's email address
    https://git.kernel.org/netdev/net/c/1398b1014909

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



