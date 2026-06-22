Return-Path: <netdev+bounces-301218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z4aGHqq5OWrewgcAu9opvQ
	(envelope-from <netdev+bounces-301218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 00:39:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 016966B2AFF
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 00:39:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bTr+wqFe;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301218-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301218-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15FDE3031CB4
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 22:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DB936F916;
	Mon, 22 Jun 2026 22:39:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA331EEE6;
	Mon, 22 Jun 2026 22:39:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782167974; cv=none; b=ILbKf8iJaYn47ctNIPvNvZtzAZE4sJA5M/4BpRyABDJJERMNy+kSz1ySipX1VPECcZXRMeW6bECQ5qUKTZ1LftLDVL8QrrGlmV2PKTaqUkAmd93+2D7W5oN2R3m2FSDi15vhkbfz+WHVh31ZvwNUWqIHV06RFdw6jXxxoj3wfUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782167974; c=relaxed/simple;
	bh=0/OEe/QEc3h7DGHK14nkhOQy31GOGBBvKW82WWvhdbE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xefdkj2aD9ahWQSCxrX0OfS9KF+8ZuCW5XxgTFIA5anXiGt5vXo8r8g8uKaDXUP97s5Aga+P+DJS0LKujRYG8j7xx4hesEiM43gRlRIHTy7FXzEQQsV5HFxXFPGhZlxNjLgE8c+Bb30RCI8EV2pzDVevoJ+3cur1HM5ZfXaMnN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTr+wqFe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFE81F000E9;
	Mon, 22 Jun 2026 22:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782167973;
	bh=0/OEe/QEc3h7DGHK14nkhOQy31GOGBBvKW82WWvhdbE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bTr+wqFeVIJd2zyAA/DyfDxeephOei5nNn+Y71/KhxCam2xU18kXjdayS0bRhwXYD
	 3ZQgjxefUp5DlrapLsjqRwwZkzHSMRrrMVgAG7K9J6k5ncVveVTyB7nL6lGggABhIE
	 re2x7uvFuA24lv9xDgzTY8nAxyThQCtDqc7G9rRkZCqiNau5tgUAYVB0MpA9sr79SZ
	 q5uBX7bFXlT5m/mwtU3DsXW2XMRio91JF1HvGgFWlLPa9dJdqcK9rPUY0/U9dJKHl+
	 jx6796bcg+uXv2ZeRs1gl8r4tYFwHXTBKdk16H7iFk05rYRzIBkMiBUkNLewcZuzob
	 V1EK70anbgm5g==
Date: Mon, 22 Jun 2026 15:39:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com,
 ecree.xilinx@gmail.com, linux-kernel@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, baijiaju1990@gmail.com
Subject: Re: [PATCH net v2] sfc: Use acquire/release for irq_soft_enabled
Message-ID: <20260622153932.6a84a5d2@kernel.org>
In-Reply-To: <20260618091618.3874171-1-hanguidong02@gmail.com>
References: <20260618091618.3874171-1-hanguidong02@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301218-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,amd.com,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hanguidong02@gmail.com,m:netdev@vger.kernel.org,m:linux-net-drivers@amd.com,m:ecree.xilinx@gmail.com,m:linux-kernel@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:baijiaju1990@gmail.com,m:ecreexilinx@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 016966B2AFF

On Thu, 18 Jun 2026 17:16:18 +0800 Gui-Dong Han wrote:
> Subject: [PATCH net v2] sfc: Use acquire/release for irq_soft_enabled

Sorry, I'm not applying driver memory barrier ordering changes of this
complexity because some static analyzer thinks it's wrong. Please don't
repost this unless someone from solarflare asks you to.

