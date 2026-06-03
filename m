Return-Path: <netdev+bounces-294966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id El8cLo+5IGrD7AAAu9opvQ
	(envelope-from <netdev+bounces-294966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 01:32:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D64763BDF2
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 01:32:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LRydAeaG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294966-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294966-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2ABA53046348
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 23:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C3E4D90D2;
	Wed,  3 Jun 2026 23:27:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF1338734D
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 23:27:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780529244; cv=none; b=R0OhzeyXTzDo5oGRKfRN0EFtoXTUvlvlqyP8PnboJzDaMwhm2bF+1aVz3PpmqhlxN0DXqqe+LYXpLLFZGHhdpuXixhj9gCtKiMTJryNJwgehLpoi2oOZz220YGuIAdsbK3xXuuHxPJJlITIFdzl5YGcAx6sXixYm9agyXe630+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780529244; c=relaxed/simple;
	bh=WhkDCV8MRWCpI+s9gfqDUKBwNNe2xrKESkRmMARl7Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKaFKgJpDfljl9Dq5xIy05hyumEF3Vt3QcrzF1NcUGNuFAsmzXec6L8yi0ejn31OL4RpGuQhBft2HXiSctuS2wCqJh1jCs15Z/pUE4g1K9Zm47OIeLvLUjsL00xzz/0goHBpikfCKkHZPJ33YvUge5UGBgiw8b83OEla0c0ZkNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRydAeaG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E131F00893;
	Wed,  3 Jun 2026 23:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780529243;
	bh=ECJq2k0//e+KfT9lEIHzgkXSu8ZoOMqmHUI6DkW7+/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LRydAeaGHDukJxXctVXVgnPaCdwMrNNtdaY4m7MsJWfwA/7cXFRFTLT+lQNyb/FpI
	 0h2iuV9Gd4PdFgE9IJg1H6FY3m84JORX3PqDHmWg0wQasyoSPEb8gpvd5LY5/voULW
	 32gWGErj1fe4MOVQL81Lv0eYdru98CcohiimLkBMgH+ntBFOnkYuyo1cm+9eJCCmrg
	 Nk+eEahhWoslw5ClkY2tqemQcuVJMD4CJSuz7cp6O7Q66yYjXQJ/+z1Ttj5CZ/Vjky
	 Tx/ytIAiG1Xwpdm//22DZCjhJ7s8pJWWOTV7W4DTXBtwWenIkVLTz+rscyAR/dVJzj
	 mUM380XdklKFA==
Date: Wed, 3 Jun 2026 16:27:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next 2/3] net_sched: sch_fq: convert skb->tstamp if
 not monotonic
Message-ID: <20260603162722.43c5b2b1@kernel.org>
In-Reply-To: <willemdebruijn.kernel.f08367f74d8@gmail.com>
References: <20260603190243.2789335-1-willemdebruijn.kernel@gmail.com>
	<20260603190243.2789335-3-willemdebruijn.kernel@gmail.com>
	<20260603152224.596d46b6@kernel.org>
	<willemdebruijn.kernel.f08367f74d8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294966-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:willemdebruijn.kernel@gmail.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:willemb@google.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D64763BDF2

On Wed, 03 Jun 2026 18:59:31 -0400 Willem de Bruijn wrote:
> > fq_skb_tstamp_to_mono() has a likely() around monotonic, this one does not?
> > Is there a reason?  
> 
> Thought process is that the first is a standalone if, so predicted
> not to be taken. While this is an if/else, where the if is predicted
> taken (which is why it's first even if not first in the enum).

Oh, I see, makes sense. I should probably learn the prediction defaults.

