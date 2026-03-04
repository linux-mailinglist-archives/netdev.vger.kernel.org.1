Return-Path: <netdev+bounces-263983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIuQBSx3qGnpugAAu9opvQ
	(envelope-from <netdev+bounces-263983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:17:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B24A32061EE
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 161B630C88C9
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 18:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8183EB7FB;
	Wed,  4 Mar 2026 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tc4g8VM8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDA23D34BF;
	Wed,  4 Mar 2026 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647565; cv=none; b=lAj1jg0h5D/77MzyT5+qmv5rDz/+i8Ps31MvyKQkyLaNHtl5b6/QgwXQmTDKt0mX2ZJce4G6w4kRkUP+WJXhfUTSFvnjNPyJbeitGNbOwVkKYQy4hSqtKEFkOrUdSD5cCiOaCmp84ncR4q0ICiFiEEeUjzMha+/ztg+o6iqQWNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647565; c=relaxed/simple;
	bh=ecBtvtst316K3uojHIX0kNZYf1XPkxz49GlOWwEqnlE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCVWxzmvUSY6jmhwUBgAP5C516lnqpLK5gvNPaKRTl5v0L0TSP2Xf9XsFGVy3SmCufgvn9tW3z4yhnrTGGoUYVad0kRvLz+EZfjQJikP/9k3W+Yie8qZQO7FK1bvjVqff36jRSGU75MTBbqE6vBOBxAlkveqNhgrOdtvZFfOAHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tc4g8VM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEE0C19425;
	Wed,  4 Mar 2026 18:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772647565;
	bh=ecBtvtst316K3uojHIX0kNZYf1XPkxz49GlOWwEqnlE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tc4g8VM8qv0K7lUJQyxY/jtxpDmvpLq+JHQuRTqsSMQTPDJHATdE+idWJk5VfqCtq
	 NY6Vhku5/t6FPKLsN7T25Yd3RxkyZ0DKhv94UeNnrTszYcodvh81pO3n6b7PWoYUlI
	 b8XQoMlbeQA0zbQ4MTNTYGY6KzSx3ecDWAUC5ADxKQhLiEEgGYol8R+Vz/JnFfIxEV
	 MkQXLvI5QW8ErLfhXhPp3hNo9HFpHZuKBSCA4Xzjjl5jB1B1j8FJkxzHmsDHyNzbDn
	 TFKjMAPa+M18CT/DB9kjb75GgjGr9HtLGuSlwRwJV3VaUCQADZ4eKKiUWFnGVTErYv
	 mPamqB6y47pGw==
Date: Wed, 4 Mar 2026 10:06:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev foundation TSC meeting notes - Jan 13th
Message-ID: <20260304100604.65552d16@kernel.org>
In-Reply-To: <CAL+tcoB0GV3i7sQnLScHjAiRN8uxYYM6_mWR2=gZLj0qr_w23Q@mail.gmail.com>
References: <20260113084605.60d0fc56@kernel.org>
	<CAL+tcoB0GV3i7sQnLScHjAiRN8uxYYM6_mWR2=gZLj0qr_w23Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B24A32061EE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263983-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, 4 Mar 2026 14:28:20 +0800 Jason Xing wrote:
> I wonder if it's the reason why the link below seems invalid?
> 
> https://netdev.bots.linux.dev/netconf/2024/index.html

Fixed now, thanks!

