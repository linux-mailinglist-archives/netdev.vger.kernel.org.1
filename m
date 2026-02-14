Return-Path: <netdev+bounces-258691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCcFJtk8kGlUXwEAu9opvQ
	(envelope-from <netdev+bounces-258691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 10:14:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC4C13B8CB
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 10:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2AEA30120D8
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 09:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EFE23BD05;
	Sat, 14 Feb 2026 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F79JeQzD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24672FFFA4
	for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771060438; cv=none; b=LBkiSNd9KkVrpvItgYZ9DhrSMcwkBcgoSeqI8t4QpSja7OlXjG2PhZeLBbEg/Fyu6rmImLNLuFwrr0Dvcayi6DBYRNn99ZYuLJ9YkfZwzqGp35z4RkjmlEbadpaytWOkM31fdtHqApSWOf+7Z2nb7iS04XwTWD6uFJ8/hBieqlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771060438; c=relaxed/simple;
	bh=liBMeZc72Qtjv7yRUykem/4eBJNi1U8q8UN0TzdRUvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDLShu44fzgAlNV+dYaVez7CdMxhTXonjjhMZ26jXctmv8U0tvYeUUMN1gORIH4OkcYIS8KaLA8+xZQUarrzF3NwoGQApRgF6xlNp4fesVdZOKI3CPH5Ov8LlqCb0/ibNpBM0nkkjkUKYxE8nktYZvHF3v8CS4xrCYXyj9PGLPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F79JeQzD; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c5513f598c0so633000a12.0
        for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 01:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771060437; x=1771665237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jZl4y9pStJSU6qk6qTwvXMuYyQx3eVBDG6C0I9FsTgg=;
        b=F79JeQzDg2OxfeOzqO/JF4yuub4DMBSBivVLTTjtwwELPISEc8E54z4WsTCX5f9NWY
         CSiqLBTNHBL9OTXlNL2GRNiMqZVhcov8w4N68okhuOTU+wwp7THxBzAORyLWHK4GYWFh
         AkD6HVL/43mD9QYNXeHxo7h8X9DytD6E/Rignr9E5ep03AGLiRvt501o2G11dvCXYdCG
         bQu9wbSDP9t1S19Sop+AlEWW3kB8qpgs9d0P7M+IBcax+UGvVCX5OSPBMTHKeLGgQgRs
         cvQ0c9evHXEuRP2wkJhNcXEghU+dSGMjpbYdJ07H79g+yBafek8MN23/3CCt1Kqjl+tf
         QgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771060437; x=1771665237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZl4y9pStJSU6qk6qTwvXMuYyQx3eVBDG6C0I9FsTgg=;
        b=FuF98C/s8H/YfoQQgN5WoHL5lvqeSe1sMndQnUjUH8KBsDo3JT6smSoZ6/QX19LLTt
         ZlOvwxz/Qy7WYoWgmjIwLSkUzgA8yy76ZsYHUB1eQIBjmrWZK8P48by/CXV4b+QE0C6D
         6nZ9Cocjp+KAP3ywUve4MfUylq4abPQ2IhPp5mqqIPY6+cPysKOlIVddh1YvuhfLz8mT
         qpcCpkQIcGkIXii2j6qP99tF+NqLryot6qxwt20bJMTNpIenQAiDeaS+HfZ0sCpcDeMI
         mMZFXpk72YJmxGQmiXxh4PgTeMY6M96CpWCbu1aTf8Mps7F/gQGMreCiFJCfa6qgG/BP
         uZLQ==
X-Gm-Message-State: AOJu0Yx+SgO2nHUfTV2GJ5W/pAbpR0H0RCUyLeaxcYXfYChZVmq+LjKx
	ilZ3oetkfnESQ0M0R6misaGNhjt3kY+cLjX/rGL3pPT18lMX0EOxc1p0
X-Gm-Gg: AZuq6aLXBKYohJLMes2j0HFR3Xz+ehgMNxjGpoc4lFJWpbIw2X3gseGoltZyaZhNZzQ
	naO5e38uDAM5TwB20/8/vclx3uWH6NeBg9ryWd8SB0BbPBY4Ufe7plakB1uTDFKMHCh7bxczhUr
	2/U0TcGVN6vVJGanTvA5I8I0VApUplDy6xpBIGesZIejNiQpUAG/txk9ZH6vlNBpWWjr6/Mk0GH
	0cwNyY4E1ZAvIXpldaYDo1NFdTxGRsxDxnGodCPA9QGDKbWwHXDiVh0bWIwR+uCQwEmC8Blm0MY
	MczeLmU9HQ826rKcCL8O0PwaeUJGzRPKRrIMqtun+1w7VWLgU3sAyitnYw2eo7cPDo+in9+EiJ8
	j1WskObLEwuqg3bMcm3Snh/9qcGwA7L+0t7GxXnoXFnsU93f2daJl1as35njaw1RxE5mAssUCBS
	UL1YWkvuYnO55UrIAFFNVYtgn9zc2AQkkxOJjHbw==
X-Received: by 2002:a17:903:1a44:b0:2a9:62f1:3fbb with SMTP id d9443c01a7336-2ab505b61bbmr46838065ad.37.1771060436915;
        Sat, 14 Feb 2026 01:13:56 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6bb3549sm4993596b3a.59.2026.02.14.01.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 01:13:55 -0800 (PST)
Date: Sat, 14 Feb 2026 09:13:49 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>, Liang Li <liali@redhat.com>
Subject: Re: [PATCH net] bonding: alb: fix UAF in rlb_arp_recv during bond
 up/down
Message-ID: <aZA8zSNByzQBxgaN@fedora>
References: <20260213095424.84636-1-liuhangbin@gmail.com>
 <418608.1771019572@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418608.1771019572@famine>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258691-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0DC4C13B8CB
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 01:52:52PM -0800, Jay Vosburgh wrote:
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> >
> >Fix this by setting recv_probe to NULL before calling
> >bond_alb_deinitialize(), and then calling synchronize_net() to wait
> >for any concurrent RX processing to finish.
> 
> 	I think the change looks good, however, to my reading the
> sentence above describes the order of events as 1) recv_probe = NULL, 2)
> bond_alb_deinitialize(), then 3) synchroninze_net(), whereas the changed
> code below is 1, 3, then 2.
> 
> 	The code order is correct, but I think the commit description
> should match the code.
> 

Got it. I will post v2 version to fix this.

Hangbin

