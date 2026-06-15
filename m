Return-Path: <netdev+bounces-299491-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PTFsO2YSMGqSMwUAu9opvQ
	(envelope-from <netdev+bounces-299491-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:55:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4167668766C
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:55:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b=bg8sQcEN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299491-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299491-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7372530A0EA0
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504023FE365;
	Mon, 15 Jun 2026 14:55:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E093FBB79
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 14:55:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535308; cv=none; b=L0K2Cz4pR2jrdtpOkZ+YYeQsnaxj3m0TpA+4P01jkwCHkCH/W5zqyjswumGMUy+5iI1eizMAH1ZgGWAXRTZNW3pF/RRAkzu4mpG8j6w4VwslXKfH4PatGbyv+s4RBw8uoHiUvpLeTFAd72vzRZ5hJlg7AhxC4PkwFMrqUZU4eV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535308; c=relaxed/simple;
	bh=TMNsHaBtmsq2RZT9rlpxYqnanVi6lepK09rczAvkJgI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RzKeLxmXwiy+p/v5ZuYPI+l9cbucT3+46S7KvRpJYFnJBRilf74QUOMv2G4T8EY5wEQwb52/UbHXoNg8+1GIdDAEYkYbEStVZq3fwwe4XqjaRL0N4QlJYRxdmyNp06rDvvZ4xQSIDLxzddT7uLXP33G5WKFSM4oEN6tI87iI8ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bg8sQcEN; arc=none smtp.client-ip=209.85.218.50
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bf84a2b2077so388273966b.2
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 07:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1781535305; x=1782140105; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TMNsHaBtmsq2RZT9rlpxYqnanVi6lepK09rczAvkJgI=;
        b=bg8sQcENGe97LxqpuelFjqr5bvDEIm1qw8dkRQ6PSJ2WWpHP/NPtKNEviiZI/CBX/W
         +/4800SY/KjxqOq5AiCMWUfKfAh/Zl6JLrYkTag4rr2/4ZFI7co3UVuRcCjRjQjGnbvq
         Lf2jb+vliAXL5hJlTcLzx7+fXyxrui2ujG0+1x8pTiMQiMUfVpzDj50huOeqKis3MYjj
         uLquI8t8gUhe3RM1azEtKylYaKPiczHxIIrVq45pqzd/O93uoCo5ZUNBoYQ/xdZoTqYC
         lnW7CgliDcz6s94bgIar1N5yEQv6sAzjxxbOxs+7nk2ZAXVuKVJWJ6AQJNODlpoiff0W
         Bozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781535305; x=1782140105;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TMNsHaBtmsq2RZT9rlpxYqnanVi6lepK09rczAvkJgI=;
        b=VSFnAHLWpBKuISda0uy9h2GI5z3uz64HYzgCOXDtVBpyXy4799+h5IgR2CnApWHCI1
         yreuPyiBIMC2AZRJ7CWqBQccEN4FRcZFKLalzEAXRqS1wJfKCyeSPV3m4pX6y9GgoVXw
         GDG2anqtNwAlNetfyRVoQowKUzY/ExcF2yDZ7ovbq+SEcQ0VhZKHQhuFpYMkALVcDPWP
         ajunGWNgNidXgIZhu9hBsrjUZudqcl7WkCjWHiwNuzLGehblqAwthUJs4Gu6abjxTpVg
         Ndgd5NnfPJgZ5Bft30U7NjGcBdRT1+FnZRhUS/M59jZkWIF5HUOVKCTAqLG/YBys9SZF
         kq0g==
X-Forwarded-Encrypted: i=1; AFNElJ9kJdAMdAffpSZMh2VfRMN1aOxfi63czSpbgVzrc52zMCTMCIrljBT8yknCt/GgsmHUq9fyu+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF6Y77QOXA4Lgt7cOOy4OIohyQK53psuIUfPXDlmif47osxfBi
	p4zT4qmTAPyMY32K9G/viSJZKAPAsLOQFDmd3KToXwWLnZK8zpJEWiQSnGCDK8AtV+0=
X-Gm-Gg: Acq92OG9Ksbnwik4Sn35SzzkAsBfTXgNKhjQZI/Ulfx2HN2krMEgQ4GYk+c7JHa9/Bb
	1fK0MC1E97VF0OnwjXSNUZDCvGCEn0Dw/iHi9k/MRKzdGcuxuHk5Dt0qNlsRYOI7X2i2lEt8doA
	JB6/+2hWr50xjHaOV1DmTTpdVsaZ+dsMeQq4Goz9NgmSmqhYNkf9LuaLRl8AvOhka7PRoBEQrZZ
	XZUxfpah0/qEpL8qtH79KZdmduvc2vzMivkkZSnmuMqkm5ZSOZsBe2H974xS36dBFLPHwz6a6BC
	2m2gdikEwaXXqY2nhkBKsAXuslrpiBzlu9mse7S7edriOaFe5gjBDn1QN/MRJFHm+R+TES9iHeO
	zOaOgOunwsji4i1kieans6sUqdJ/Jjw0rgE62ftGJUdgbAi+rxM93Ju0x6QPLnx16aHUsrpfviI
	VzBJ/VSV2LvBhsrqX6ZILaBE57AQ==
X-Received: by 2002:a17:907:75f3:b0:bf8:b1ed:43e0 with SMTP id a640c23a62f3a-bfe28d1b424mr498313966b.18.1781535304852;
        Mon, 15 Jun 2026 07:55:04 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb44203c9sm499562266b.12.2026.06.15.07.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 07:55:04 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  bpf@vger.kernel.org,  john.fastabend@gmail.com,  sd@queasysnail.net
Subject: Re: [PATCH net-next 2/5] tls: remove dead sockmap (psock) handling
 from the SW path
In-Reply-To: <20260614014102.461064-3-kuba@kernel.org> (Jakub Kicinski's
	message of "Sat, 13 Jun 2026 18:40:57 -0700")
References: <20260614014102.461064-1-kuba@kernel.org>
	<20260614014102.461064-3-kuba@kernel.org>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Mon, 15 Jun 2026 16:55:03 +0200
Message-ID: <875x3jdfaw.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299491-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:bpf@vger.kernel.org,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid,cloudflare.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4167668766C

On Sat, Jun 13, 2026 at 06:40 PM -07, Jakub Kicinski wrote:
> TLS and sockmap are now mutually exclusive. Try to delete the code
> from sendmsg and recvmsg path which is now obviously dead.
>
> The main goal is to delete enough code for AI security scanners
> to no longer bother us with sockmap related bugs. At the same
> time retain the code in case someone has the cycles to fix
> all of this and make the integration work, again.
>
> If the integration does not get restored we can wipe the rest
> of the skmsg code from TLS in two or three releases.
>
> The changes on the Tx side are deeper since that's where most
> of the bugs are, Rx side simply takes the data from sockmap
> and gives it to the user. On Tx split record handling and
> rolling back the iterator were the two problem areas.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Nice! This unlocks further cleanup in tcp_bpf and tcp_ulp.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>


