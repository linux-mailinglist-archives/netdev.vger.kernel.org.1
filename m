Return-Path: <netdev+bounces-271178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGosNArAwmnalQQAu9opvQ
	(envelope-from <netdev+bounces-271178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:47:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 300DC319502
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C47DE312C886
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7643FD148;
	Tue, 24 Mar 2026 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cl4XwlPN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFCA3E5EC5
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370315; cv=pass; b=AQ+DijFPHwz9eBh84egIi4eiYSSeIjr3s//PARPPlbAakoh+MIk6/Cxy0GZG6vTIiXlIHtPTPOB/CoWmUHcLb6/YvjBoyMn7SQJ7VMvKwpKgTPVlH95o6FYdb1wriLIhQBhzDzRezaD33h+XoIebubjkQD1xlsIO2aWmTznHvm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370315; c=relaxed/simple;
	bh=/44KDZ1ohgTk226waviqQ9P5xfGECUSYs8P4xzjES7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpoB//ZZLQlYF3OQf9vSXiBBhFtmv2R5nkeJmk/WPmYG6TPISsFtc8KrbIy6PUaegwSEd9h3JcPCu/Fu834OyHxA+SIrBFVCMXdKDkisybNTPmuBZ3US6ZhdRprWUBprNvDafpiUHTFSLg6EGiRU3aOEQ2xjCun1yLkjPWcSnlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cl4XwlPN; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-127380532eeso2818011c88.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 09:38:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774370313; cv=none;
        d=google.com; s=arc-20240605;
        b=IEqTi65wYl1Xhi2zMCrXKU9upIAG9Q6bj46KLFge//d/302CFoQ071BekfR33tkXF6
         vyY+Td4MpXpYFLJfz8/6Pu8fynmHKJiLfDpX7VsE2CNnf0MYfMRuLSvQVAgOB6TThu5j
         4ZzJQLFuUEycudFQpa95cEPnIL/faObZD+fmNobbQEoil7cW1uHEGtFqNInN/vIUDmLP
         PX4uaKPD9ZB9XWxoS5fwUPfDl8GLrJLbjYPMfgaThKa5bqsy15VzpKZX/tvHaw5N/YDT
         toDHNtm+jwIKFZ02BSec0aA71DhJwcGMSjkXbGAmQMm6xm8j3+UkoL5T1mtEtOQKyFQt
         Fs0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/44KDZ1ohgTk226waviqQ9P5xfGECUSYs8P4xzjES7s=;
        fh=S+A6+XfLvXhViuIxcWlvKeFVM2WXaRv3ZxbMK1JoR10=;
        b=KujbaQsQnpetc5rjCeWTUoC843tZQTNUnFzONJuDEBH9HoCiZtTG5wCHxwKsETki0M
         l2ELbA397kR7doquWPLJbgFI70sja5/x3GtFbNJMAgqRbQYREs/cqSeDf2D3y+YKAHbg
         v675DQhY3z3IhAtnXFqYuDyDnjoguzavr0l0GINOxwwWdLsbNpfNd8s2leg/tp+Yxg3B
         KczRnl+R6tK0XfXGzY+mA2ugO+x/GnMGvMQlU6V6rzI6QzUTT9dqgZxpxlSlZQHrEKkG
         4ncH8Jgek2rdpzaNCjIRblP6ow40nI6SvWp/ZT8klkdC7cbSZv/Q/G7h7QrPtLruisRL
         58iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774370313; x=1774975113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/44KDZ1ohgTk226waviqQ9P5xfGECUSYs8P4xzjES7s=;
        b=cl4XwlPNTl4K05uPpnZFCFq0s5I/E65NTDVhIxLHovohtQEBGmz0YjOzMWeVJnAd91
         e1k5G6jfvc1j+iIl0tTuqSzNQFfChu2Qg+qcIH5U3+ugaexby/yvA//Ke8bigzOc70rs
         i9lIfyi7oFSQOsyhm5YBdPbAIo9NUlVTIiMJXtizW/5jf0XuBz9H2UZHHuuCB/i/7GcK
         6Q8rW7wsHKvsnnbs9FC6Ort689EjQb7qzJkhKKj/y7G6ksGOaWGwAXMFWXRkYU8VJGT3
         plTc1IIfLC80kyLB/VczUicaAAniZWGkWaWvTj7ZdFyI68ZMa1fvog0Da3SZadMOdCAG
         MAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774370313; x=1774975113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/44KDZ1ohgTk226waviqQ9P5xfGECUSYs8P4xzjES7s=;
        b=MJdkt4/YZ4icvMeht0pLJwSufWm3IwRjGJTEY6uWxoRlFBuVXrw7qKriDDOPj5mv2a
         +Kwc0gBY9wrviWrEa0E8k0rEJm4kKggc8HZyDcSih357bDE5ZnhTreqpL/4aQvogzII2
         t/KxWK+JMCP0yF+PgaACJdSu8ZaCok3WSXhJWzOxR6g59w5+SYaVItXTSWJrHVwjCRQr
         ilEMgMwgjPpvUbzedfgubHwD28yEfddzK0/d3iP997NL+5snZY2RkwJm9JL2tjiCe0+s
         b/rJZHnF+Yvy0VOjmvBxSiJoK0VBXRXJ8yN0Wdy6Dw8uZBLcPWHb9xAzMfu7ZxAHhTsD
         9irQ==
X-Gm-Message-State: AOJu0Yxvotq1RTELgL7hAzqnB1DMfhzaQeGCZn0HolbVx+lUwZvU3T5u
	xwiQbVfAn4pFNmUt6rUVa+KdlGa4BIKLQjubP+xqrEpGVUkKGM23R1XAJRdO8kARGZ+f5VnQ9Eg
	9Oi0ZXIxH71eBmSwEbqvWWQoXXKAPbISwP+1g201HSHUvNbhAgkphqIZJ5ME=
X-Gm-Gg: ATEYQzwrnPSn1V3VX/Tm829zdCOw3EzoTg9Zz1Cf/7Oa8HitF2CHRh3FuWRMyi8iBn/
	NBO/gUTrG30LdesxF25wxCT7sBD2gCyVLsM9SBlpTcKvzqJeJqXAw0Y6oEEMCXm31vnu8td4QaN
	fYmp1ceM5/xydVi8SFALCse1/zesvgUr6++NyN6ccBgcEzPxmipglUiDdvS9LHiwM5iF1FrQKcm
	vrDnno9oG3ZZV0BHAPE74MPlbWIEi1ypTeSwcfrTE1ZUuaFw/ye4dKRJpR56oKR0pL1B2mdUrl8
	BpVJkiiaYwIVvip9V+g6MtkB0HkZBSWsIJIUxm7ZesM53HDxYegq5oZ1JdR9nYlDmrdUBg==
X-Received: by 2002:a05:7022:fc09:b0:119:e56b:c75b with SMTP id
 a92af1059eb24-12a96eeb4cemr93949c88.32.1774370312780; Tue, 24 Mar 2026
 09:38:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e77fe499f9a58c547b33b5212b3596dad417cec6.1774025341.git.sd@queasysnail.net>
In-Reply-To: <e77fe499f9a58c547b33b5212b3596dad417cec6.1774025341.git.sd@queasysnail.net>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 24 Mar 2026 09:38:19 -0700
X-Gm-Features: AaiRm50LjiXS6RpHzCHnAQL94vpSBXhagnImEhJ7xlPnXW4vNq_ThoR8o8PSi4E
Message-ID: <CAAVpQUCs7L01o23MjxNpJMFiOtiTmcdZ+Y6z8DsKBQAdPXRZQA@mail.gmail.com>
Subject: Re: [PATCH v2 net] rtnetlink: fix leak of SRCU struct in rtnl_link_register
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271178-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,queasysnail.net:email]
X-Rspamd-Queue-Id: 300DC319502
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 8:19=E2=80=AFAM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
>
> Commit 6b57ff21a310 ("rtnetlink: Protect link_ops by mutex.") swapped
> the EEXIST check with the init_srcu_struct, but didn't add cleanup of
> the SRCU struct we just allocated in case of error.
>
> Fixes: 6b57ff21a310 ("rtnetlink: Protect link_ops by mutex.")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

