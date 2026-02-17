Return-Path: <netdev+bounces-259049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJqoB9J3lGlmEAIAu9opvQ
	(envelope-from <netdev+bounces-259049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:14:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE3C14D107
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AD5730087A8
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E06236BCD2;
	Tue, 17 Feb 2026 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhTHGE0L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0412BB13
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771337654; cv=none; b=VmRM1ThmCDcZqyv74RkqhfP2LdBGnUFR4FzfY9QodTzLtf6EmXy+MZvauV+YeC2fqAEI4FiHE/SOskJEts0/HnJi1wuyZnrXNA6KeI7ibw/U7mY0JRN+tx4+RucWfJqL3y8Ac44jMY+Kov3A0+k3l0nzwSkCUikhM3Ect2WirNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771337654; c=relaxed/simple;
	bh=vx4OdV64kWJu5GthJTkQ5xuxpB/Uf1k3AP+cRSQ7jtE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CVrRl7XihM9dgZ3s76PM/p98eoZpDPPGtzJZX649T3q5LhNOVS7/Zbr1RHu1RJ+yCpnFMSQ0zlyFnnz+pT07SoDfII/yNQ7xAZztIEZLae6xgSPzrY4rP8M4IP2dZY4z8LgaqKTueYVmje4dnn2CEl4v1ym1NqHUPAlkhLCGueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhTHGE0L; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79427f739b0so37635837b3.3
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 06:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771337652; x=1771942452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wb711YoqxUnZlWWEt5NcL1gYCZN0sjxjE5vxt2U+HHU=;
        b=WhTHGE0L1fBGxpOVRww+D+8ezFnw8R/GAnHwQJsZHtGungP43QlC6cVqesW0Q6W6kO
         fwC9AXlLci2681SDaaSdJFgZPIiOdaTXhWECl7PeWv5iqTxa0l2wl9IoDoBy++Yv929A
         VPRYKGqtNe+Wu9agUUUKksd2XjmFBVV+4SYZHh6bIn11/eUNaUQunOGQPFVSMIqAGik9
         OQtYED2hPRHMBB0LPUhh+qnZAl0GOQzWtxldE6ok3oY1R/otDHPUEk/hG9ZYcT8ZjApx
         nb5FY6jCr0/3NAYhtnGsdkJXHlsUiTMkpsswPIXsjIAlqALRrQxCEh/zu+6pYxs4vkCi
         432g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771337652; x=1771942452;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wb711YoqxUnZlWWEt5NcL1gYCZN0sjxjE5vxt2U+HHU=;
        b=dPqer9BWhxiRYFh4SXp4aqlp0t93KqiDRAVNqm9fbpO+HG5tZhW6vTQ60ujjKH/Oig
         bn0ivdzFjyv4Zf5Ee0PXg3TSbfFbN5t+NaWwIG0fOUQ5UnnbYw86AbdYuFlkL77EGk6b
         3intXmeUkCSRDdEQpcByatrPhyIDRDuB0RhcJVHykiZIxBL94O2nDDvJTCY8u86JcWOA
         ubSgdXT9cuExAxM7Cmfv23ZhCUXY+q/TJLgNYTozX3WHFpIW3Ni6jUZP8rjWNy9V5FUW
         DjURhVkKRzEheLgTWRnkCVCbJYhh8J6zPg07H5Ef9kEsoXXL/+YGh/ZS1bJ3rzHP96SP
         79NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBkARbkyw0cyOTNiQwQPm9fSouBfngX8S64n60SA4uM9E3K7oQR5oYeFad1yH/aCeW5yVj6NI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS1UuFJVdh460FJDj3GmtOFEl1h7WO7K+zNzjkGPp9YqWwHcPL
	JXZgBG82dFwWFxMigT7E/1jYK6yt4ui3AuYbzGF3g0pGYpfpEGcbi/n7
X-Gm-Gg: AZuq6aIPiAzJuiIBuHtDTHVoZJmf0mHmIhi8+BGzWpJmtJHFUmqOGwy2dLaL/vcomcI
	QYADFsBrbD++ELMN2juLrW3EXYReKys5n1aO1yLYp6fpNsgfPsgXQFOc/tOeRMKVSTnSM/EsV8t
	0VjP/Z1cP45jri25I928FmA+7sUhoqJ9eZB13nXbVmVpk9repMvKeDpccuEt1BLxf/NQSeGXuk0
	bGoDTVagoEIJCJw7Z42mnljufu6cr4TuLQIsuGCb15JrOa3v+Bj/vgXcP+mN4HQZ9xo74hp3I2R
	PH8CeSCar6Q7+dJRne0+oZoinPtvI+HqEWzIEihD2wWqogjGDeLNT5vf/XU84MOs18nFzG8No22
	ZT/rvspU/kTQSiyLWKMRMeLFlcDxJURkL1MUdcMxeJD2Uth0XNnv5BaQZnTlslXDe7ARiwrMh/r
	yxGmx6XvZjENGOPO5owIzfF3zJoKcQ1Z+qc4UO6wvtZdiDGge+VMeBakR7ZmGefG4NVNmIz2Q=
X-Received: by 2002:a05:690c:368e:b0:793:a3c9:795d with SMTP id 00721157ae682-797a0cf859fmr115910327b3.59.1771337651986;
        Tue, 17 Feb 2026 06:14:11 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7966c16ee7csm112391867b3.6.2026.02.17.06.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 06:14:11 -0800 (PST)
Date: Tue, 17 Feb 2026 09:14:11 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Kurt Kanzenbach <kurt@linutronix.de>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.cb53c17fe3@gmail.com>
In-Reply-To: <20260217132838.kgRAQ87W@linutronix.de>
References: <20260214232456.A37oV4KQ@linutronix.de>
 <willemdebruijn.kernel.1682a93525c87@gmail.com>
 <20260215184608.8dk4hemG@linutronix.de>
 <9130dfca-1e85-4975-8df9-4de8bd9e8f5e@linux.dev>
 <willemdebruijn.kernel.3b597169afaae@gmail.com>
 <20260217132838.kgRAQ87W@linutronix.de>
Subject: Re: [PATCH net] net: Drop the lock in skb_may_tx_timestamp()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259049-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linutronix.de,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BBE3C14D107
X-Rspamd-Action: no action

Sebastian Andrzej Siewior wrote:
> On 2026-02-16 13:08:43 [-0500], Willem de Bruijn wrote:
> > It will be great to have this additional context in the commit
> > message.
> > =

> > And a Link: to the original discussion thread.
> =

> Okay.
> =

> > Btw, the commit states that a few drivers already call this from thei=
r
> > hard interrupt handler. Can you point to one or two?
> =

> - bxcan_tx_isr() -> can_get_echo_skb() -> __can_get_echo_skb() ->
>   skb_tstamp_tx()
> =

> - at91_irq() -> at91_irq_tx() -> can_get_echo_skb() -> =E2=80=A6 ->
>   skb_tstamp_tx()
> =

> - hclge_misc_irq_handle() -> hclge_ptp_clean_tx_hwts() ->
>   skb_tstamp_tx()
> =

> - igc_intr_msi() -> igc_tsync_interrupt() -> igc_ptp_tx_tstamp_event()
>   -> igc_ptp_tx_hwtstamp() -> igc_ptp_tx_reg_to_stamp() ->
>   skb_tstamp_tx()
> =

> > If this is only for new drivers, it would be vastly preferable if thi=
s
> > can go through net-next.
> =

> I found three, I knew about igc. I don't mind net-next but if we keep
> the stable tag, it will be backported anyway, it will just take longer.=

> But if we want to do this in order to catch problems with it before it
> hits stable then it makes sense.

These are more than enough cases to warrant net. Thanks.

