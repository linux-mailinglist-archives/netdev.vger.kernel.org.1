Return-Path: <netdev+bounces-299707-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SPOqDDauMGqwWAUAu9opvQ
	(envelope-from <netdev+bounces-299707-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:00:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9377B68B5C9
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:00:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EvlmTDzj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299707-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299707-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A99E73018C30
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C70E3815E4;
	Tue, 16 Jun 2026 02:00:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066C81D7995;
	Tue, 16 Jun 2026 02:00:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781575218; cv=none; b=uAxa/yn3xrdUyiHymF4Rz6NEXgPdf1p65Ry89oCFHMRJchgjs6FlH6ReHiOYBdneCWLbinZ3cEYTF2X1lfT26Q9ZLwWZfiyc4IT+smVE7x2SEgozo0UgIMFGD1mIinCfHNZla/07Q0197M5taHL4PO7yfP5Ze5PW9oVPia4ju/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781575218; c=relaxed/simple;
	bh=w3tqoDMkP2AtOb/5kwyASTuSFPFJkEFni9980rTHqSY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TvIzvBCHLtaitjOfxqBUDNaManqbnzbGsImYUgrDUTPHntOHIbdUoNuRZ8XlsCunCv5V1+vwp2cnPg2OxQ0kV9V62XNjiq/k5zre2qOPeicxMVbGZBedwfKJKPdRHUdVJKQ5b0EF5EpyVJ5xZeVaN/8YQOiTMlxz5okghgQdZcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvlmTDzj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D461F00A3D;
	Tue, 16 Jun 2026 02:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781575217;
	bh=FOHMFh425tyGpF2+7YN6uA0GU59wRyJzTc7Nyej3d2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EvlmTDzj7oimd8mAGCGNIVcAEAPfwYJMGyosfY6xRe3ypxR+ZYsoqhtUT2jyMQrZA
	 0f+cPgbfwa+WwzKZZeMHpQaQ154ThXLQRbzGVgjm58+g1GkyYK/V57X5mxDkMelSjB
	 saCxWmiegMXFu3PmRstOct8JLNULnW9TExy49e2Jo1UPTMiRtKAU20lwxwfIUBEOIQ
	 J0bktd1J0AiPAIjao/7k2J8/6TsCaCswbhbo6zHpdNTntYnfE7N8yjpP2/gsfiJTsj
	 EDJpR7D97LS94YHJRmuekVlvqVbM0hY5fJqMvF3uCGe6c4AaUCJPIbpK83yVNkJGok
	 OG7ITfb6jklEg==
Date: Mon, 15 Jun 2026 19:00:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Hemendra M. Naik" <hemendranaik@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, jhs@mojatatu.com,
 shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, vishy0777@gmail.com, tahiliani@nitk.edu.in
Subject: Re: [PATCH net-next v2 0/2] net/sched: sch_fq_pie: add per-flow
 class statistics
Message-ID: <20260615190016.060a4ab4@kernel.org>
In-Reply-To: <20260614125000.6058-1-hemendranaik@gmail.com>
References: <20260614125000.6058-1-hemendranaik@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299707-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hemendranaik@gmail.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:jiri@resnulli.us,m:jhs@mojatatu.com,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:vishy0777@gmail.com,m:tahiliani@nitk.edu.in,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,resnulli.us,mojatatu.com,gmail.com,nitk.edu.in];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9377B68B5C9

On Sun, 14 Jun 2026 18:19:58 +0530 Hemendra M. Naik wrote:
>  FQ-PIE runs an independent PIE controller per flow but exposes no
>  per-flow statistics. This series wires up fq_pie_class_ops to expose
>  per-flow AQM state (prob, delay, deficit, avg_dq_rate) 
>  via 'tc -s class show', following a similar pattern as FQ-CoDel.

net-next is closed for the duration of the merge window.
Please see: https://netdev.bots.linux.dev/net-next.html
And of course:
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer

