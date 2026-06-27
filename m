Return-Path: <netdev+bounces-302360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d/6pBZZLQGo8egkAu9opvQ
	(envelope-from <netdev+bounces-302360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 00:15:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB9E6D2BEE
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 00:15:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CtVurek5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302360-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302360-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5857230055F5
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 22:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245431ACED5;
	Sat, 27 Jun 2026 22:15:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310CE4204E
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 22:15:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782598544; cv=none; b=Ahh4wCmxWUOAutbeSqCkmUQAHVtiCLojpR3IiDeFLfIMJzXFWFgtM3V4gton13C/8JdrAKn/HK0gnvG56QtHDcD84ArFyxPoYRSc2JIy178F7f7TVNZWWfCCkWKMC2zCVF9n/YvlhQkq+F13H5Z1gMah/m06uLG/vS/btZcQ6OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782598544; c=relaxed/simple;
	bh=W04uXXvhgO82ttrCtlB+3EwPAZquOJrmaDJSu/S0ReM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1yLLf07/+mCVyTuCl23LqaMz/jggovuyNugiORovjqbRytH1/AmU1n5eUG85y8PLOc0DzAbzrV/W4tsyyjBs2qi/eEFnaoyVLp5q77IaaOL1AjChrCuXNu9lekT6FlxAJzrK1Z450rIq0gSY3DPShMHa1fvrGkrqKuEWjr5dkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtVurek5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718521F000E9;
	Sat, 27 Jun 2026 22:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782598542;
	bh=nK+pf9PlmXmJL5a5Vd6SqrSuHAG0CCQGM/NZvgMcl6k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CtVurek5TIX7Kop4RcGjdI2qQBZ180UhrL+fHjkhwfvi77wq7S4Bi2SsA42FX+Npi
	 dA2jFaWbwF8AaRlkREsdqv5R9dbIWdYEmYwrqA4TxTlCD9pTlp8QBcg04X63cdyjCr
	 wKUxKt9QQQr8mcKXlcFJZnRSped35E4BaAboZm+ca53WH4CkoQmns+mdRgbG6uaJ9l
	 IZ9POkGBE4ptUnJX8QBYIZ56eTnSu/pcVlXGlmZIWhr5FhcSFjADZvOpX+mJGgwWtj
	 1MOlyscr8Pp7gqVdO17mFJxWhs/mCRT+A6gW47+9uK5pYolgxH2LHSrHv9+6HTbf5b
	 uujBnF+E6OjRQ==
Date: Sat, 27 Jun 2026 15:15:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, petrm@mellanox.com, yuantan098@gmail.com,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, zcliangcn@gmail.com,
 bird@lzu.edu.cn, bronzed_45_vested@icloud.com
Subject: Re: [PATCH net v2 1/1] net: sched: ets: avoid deficit wrap and
 bound empty dequeue  rounds
Message-ID: <20260627151541.3b22bdd8@kernel.org>
In-Reply-To: <0e17a0309061300d31036a6a4c139919192f6373.1782379460.git.bronzed_45_vested@icloud.com>
References: <0e17a0309061300d31036a6a4c139919192f6373.1782379460.git.bronzed_45_vested@icloud.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302360-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:petrm@mellanox.com,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:bronzed_45_vested@icloud.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,resnulli.us,davemloft.net,mellanox.com,gmail.com,lzu.edu.cn,icloud.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4AB9E6D2BEE

On Fri, 26 Jun 2026 16:32:00 +0800 Ren Wei wrote:
> @@ -499,6 +501,8 @@ static struct sk_buff *ets_qdisc_dequeue(struct Qdisc *sch)
>  
>  		cl->deficit += READ_ONCE(cl->quantum);
>  		list_move_tail(&cl->alist, &q->active);
> +		if (++loops > max_loops)
> +			goto out;

BTW sashiko says that this will permanently stall the qdisc.
-- 
pw-bot: cr

