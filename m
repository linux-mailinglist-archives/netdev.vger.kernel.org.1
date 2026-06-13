Return-Path: <netdev+bounces-299077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bBDlAhTWLWovlAQAu9opvQ
	(envelope-from <netdev+bounces-299077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:13:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B7967FE5D
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:13:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="hPrd/UVs";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299077-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299077-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0F0C300E5C4
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244BC3A2E39;
	Sat, 13 Jun 2026 22:13:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EDD342509;
	Sat, 13 Jun 2026 22:13:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388816; cv=none; b=bxDy7UW1DNyAtMVqj8UJBDIb59xxTIIAtW8ZtGP1WMvKq435dn0cgLIDFDCN3z9CtB/FJoXf1YA5DNd+t7vAdRNs+aYefFatfe4D0X3i5obr0qrlAqLUx9GatCE+i2cDIbMQptwlcsdJpMrTHZVFEmwDjmWtxSFxpOOWnL5usm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388816; c=relaxed/simple;
	bh=Y8Lezj3lvMaLQ6PwBDR8Aq+/aErLJ9Bsl4xd0v03sp0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kg6LmaFr7qU5PBW1Tbn0YScnxMpZF5qc2yN6J4Eg8/gUe74vwdK0g5ivhgbzyNlg6vuRpliflxEx3T7uf6xEpcVFaS4Rq/a5MmyLhFeJbz/xb2khko1G8Xnc+/XoVIqZ7liGrgAWFMdHT0n18piXOb3NT6zgvtlPV63ZnqwgxsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPrd/UVs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415A51F000E9;
	Sat, 13 Jun 2026 22:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781388815;
	bh=Y8Lezj3lvMaLQ6PwBDR8Aq+/aErLJ9Bsl4xd0v03sp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hPrd/UVsix22kJGWdCA1MGaKCp1oGwPzQh2Dy+5aWn1lcRzAHwn7FL1/RCA3gF+bf
	 ICaEJoeVERVdGIU3t5h6l3er1eCtDo6ITLUpz6zpY6SYSXBEASsOedD0xxHPsxdaHd
	 OLtEEN8fdd6JyW4UH9b4iJf6dH4jMnJJW60HLMXKJbpu7LBbnpoEBNbWsia2V6HQIR
	 pE/gUiMgxo3bVYsdSd7Fm0YHEHnKi/FWpa4sNxbPqpNd5ru/C6t2ZHOj9ODtkcQsqx
	 12bKOXo+4C+yRA+rgxjgC5/q+wT5FDH6TEzXmDup1Z8JNn+VqBmi1gSnewNoeC28GP
	 mmDH1QL7sQawA==
Date: Sat, 13 Jun 2026 15:13:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: netdev@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, bbhushan2@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, amakarov@marvell.com, tduszynski@marvell.com,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, Ratheesh Kannoth
 <rkannoth@marvell.com>
Subject: Re: [PATCH net 0/2] octeontx2: quiesce stale mailbox IRQ state
 before request_irq()
Message-ID: <20260613151333.09de141a@kernel.org>
In-Reply-To: <20260611160014.3202224-1-runyu.xiao@seu.edu.cn>
References: <20260611160014.3202224-1-runyu.xiao@seu.edu.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299077-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:netdev@vger.kernel.org,m:sgoutham@marvell.com,m:gakula@marvell.com,m:sbhatta@marvell.com,m:hkelam@marvell.com,m:bbhushan2@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:amakarov@marvell.com,m:tduszynski@marvell.com,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89B7967FE5D

On Fri, 12 Jun 2026 00:00:12 +0800 Runyu Xiao wrote:
> Both OTX2 mailbox registration paths currently install their IRQ
> handlers before clearing stale local mailbox interrupt state, even
> though the code comments already say that the clear is needed first to
> avoid spurious interrupts.

cc Ratheesh

