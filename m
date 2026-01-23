Return-Path: <netdev+bounces-252620-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKnhLjjkcmlYrAAAu9opvQ
	(envelope-from <netdev+bounces-252620-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 04:00:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 387866FE0A
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 04:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBE57300DE0D
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADE538887F;
	Fri, 23 Jan 2026 03:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JUOaC9Ic"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2FD37FF47
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 02:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769137202; cv=pass; b=lWORj6xg1xM629hjV/Prn/PpCuIkAiDk8lqjWzDHXcWEFhczlIRJ5JijxakJhysGKxc0Z66sza4xUWgisUICXvo+MFvuMXyHDkWT9Dsy83zTrNbqJ11E5ir0/TTTOiXdX+L5eQ1G27QhczdGuDDPbTMAPbdZc/j7uPP5ylNN/II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769137202; c=relaxed/simple;
	bh=B4tyO7BrrBNrU2HPv8u3NcDCK8ugp2n99euphI61vo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elQwZE1omwBOo8MblsJpyM7AVVuWFn3ZYanNQYfb4MYZIPsaGpkz5WJi+W0QjZjiWj0g3v4zP+s9ZB67unr0AgEoFwtlc9XtmG8anWDZOXZ2j4eWWQ80RhsxUFOyau9fPFklUGrgfG7ud0FWlAVzli4s0dkj4Cpq66jRodGJs5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JUOaC9Ic; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-501502318b1so19166371cf.3
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 18:59:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769137187; cv=none;
        d=google.com; s=arc-20240605;
        b=Xp5zEIJYb4XC5o8akXiuz73SpznGbscW2hbqcDAAXd+bG3ueOVv+xTix44YEI8kZq5
         x2BRNBdYkCbOzE6Xk32Z/NKAijz76Iatj/meFws2tz4YtiQFEidtnI3IW7ADUsl1WoM0
         g9v9Z6mqGS67Ka8aehulrklsIKjpne6HOLDcewmersqK9e1H3WLSruQhnWXsjvp7n7On
         gZh6j73oniQhib7bcXq5PV09ZNohdMqkf9rsCnYNTVI9fI6mli8onLpDIhhkMqiXE4y8
         lrB0uNGPDM5cOmhZcUubLJVouO17MJbkFVDdYgF4qV43ysHxRXYtwS0W9xrpJZjGpYW3
         +Wsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y5us3lfiDV/aHNUfP8fORhofVGPA0AUuS7l05cJeWC0=;
        fh=khqkEG6tqmTXpC5Fn/0ZjfMTizuDRsSCd7K8/Nfaq+E=;
        b=L5k2f+9ak3amVF9Ey9odYfID9HQ/cnUkWHmLNw9QyELs5+THJxCtL+DCrFxEg9DRus
         K4lAmLjOBmn72hAHjwQh5BgnN52H266jUh6Bng7Vsrzqt9hFddXHxC1K+UZijqttY7HL
         kIJodCMIrBVuF81QqvVMGizCIgX+Z1KP6qwYxtnv7J1v8xGD8F+KPyfV1dCdoL8r8mBs
         w/lhO35015jgVNllJIBhb1G3P+7JvYWbsUDvAHABBvEcN96YDMjjvD0WBhEHLy9u8g4l
         VHumt6Ma+yzteT9Ot3a+3oVcFC7iL2dMloN7Dr69tdK+oLvP0i+SNw6a0il6EU9KnBO3
         WuvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769137187; x=1769741987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5us3lfiDV/aHNUfP8fORhofVGPA0AUuS7l05cJeWC0=;
        b=JUOaC9IcTm3sUuLbopCghzN5Jhajxq1s8zhErCqmCo6cLRzgtPK5gEfoknvfOwyd68
         HA20G71NEa4PmjWQ3+k62EMtL5pGRuzEsw7/h3oqqyKLXL52KWqu0f9OV5vgXFcdqlsS
         q1QSPHVF9qs1uie+Q1ZyixQHtnb/xNFnhZUHYHqRqLpMkymBH5mv6rN1MTKGaYn3WehB
         RTZcnsfYWfqQhyI3/hZWRhEwIB+AIlHFP0XgmKci1SARAmtNfyEtU+YKp/XJ6IP2SPIl
         UEUMit8gf0WFLJ5olIW+4tzJTA+hRlYpPk6XGdxmqTihQPN/FvRSP3iMrO0DDrlSO1qn
         e12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769137187; x=1769741987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y5us3lfiDV/aHNUfP8fORhofVGPA0AUuS7l05cJeWC0=;
        b=feQJE9Hsp/RMh4bVG9dg9x4fnjYsbvH92DFfrW8CuvkDuUtqQBLzcSr3eITdf1WTmU
         6b6DtVWQ+Il4Mso5X7ZUcuvYGhjmrqFreBTVTtjP9BDB3zyMyVT/tOJVmt28fuAjK6XI
         IiplcOJAlhKfibUs8nqwipkgRe/rpwIgQaAMkVeaIseKlHABQHklMMxKfD2fnx6I9FMn
         aHP+GX/rMIEbV+ogMxYc1nQ0+H+aTBDwDGJBVhmg/IPgj8rzZVnG7ODuv3cGGF7ATsk+
         waG4eu9vel5+eK8pl/EADAFOiKw6c07jJf0v4Zex7331vAkC9ITY7D5SHHz6I0uh2SKh
         uNUw==
X-Forwarded-Encrypted: i=1; AJvYcCV52z3gV3bd1Gu17tlp+o46uD2IK/XuK0Jo9wJ4RWosppEdjxmbBD4QzNpmrJSa6MG1VwVnBVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKb7OF3mH2rKiNhB5khjhRXo5fjwAq6LkFUJ/jR1vLPluUNR6n
	orN915LyGJQUOEhGeFZAKw62nnNLh9Ebnw4rHvqEdkKUQ5q3z2vGm2bnk5DLK+FzaHutm1vgiLD
	3VnT7pw+RVIbaNbGWXHSyz8+5eKsiKSgsk33KQuj1
X-Gm-Gg: AZuq6aL+MMaltNU1NDj7lDRssvIdaJ5/fFN7TmBi0cfzBiduNEdOLDnKuLF5DqZjI6C
	BnBTUOC9GNGIagnRiFcJjIx3VCW5Y9rXMCIZMJTWcaAp5Xl9O/6N4b2B6C5vDILbP0MQpTzM27w
	G2Xg69nR5UKPDmWqFAZoMGQgHD2QlwnhSyxtU01tHigh+FWavIvZDZ5RlZHdapkretMlRPyE+95
	31NoO40oSjv7jp/dJbp9D1BTsqVHo6Tsadsq41/Yq2zGFvszN+xEJxMpR6pDSLalNrS/+w=
X-Received: by 2002:a05:622a:1195:b0:4f4:de04:2434 with SMTP id
 d75a77b69052e-502f771ba05mr21844541cf.11.1769137187305; Thu, 22 Jan 2026
 18:59:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122131306.2119853-1-edumazet@google.com> <CANn89i+wyDiyq13nn4_NkckA0A9z7ybeKRXaC4A-VS0yFc9GQw@mail.gmail.com>
 <6fdf2b6c-2c92-4b74-b746-6c68ed7cdf59@redhat.com> <681f0f86-fa46-ced3-71c5-f489b67b7fbb@kernel.org>
In-Reply-To: <681f0f86-fa46-ced3-71c5-f489b67b7fbb@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 23 Jan 2026 03:59:36 +0100
X-Gm-Features: AZwV_Qh5Unrujns012_IRPpXYJJK9V-i99PWCPw1SXa8V54c1d7eCIOqt29YyLc
Message-ID: <CANn89iLztyyWjp3X=cFZ-O_OPc_2itOOW9wYgNYQYja9rTdA1g@mail.gmail.com>
Subject: Re: [PATCH net] mptcp: fix race in mptcp_pm_nl_flush_addrs_doit()
To: Mat Martineau <martineau@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, 
	Geliang Tang <geliang.tang@linux.dev>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+5498a510ff9de39d37da@syzkaller.appspotmail.com, 
	Eulgyu Kim <eulgyukim@snu.ac.kr>, Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252620-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,kernel.org,linux.dev,strlen.de,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,snu.ac.kr];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.975];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,5498a510ff9de39d37da];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 387866FE0A
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 2:31=E2=80=AFAM Mat Martineau <martineau@kernel.org=
> wrote:
>
> On Thu, 22 Jan 2026, Paolo Abeni wrote:
>

> > LGTM, thanks Eric!
>
> Likewise, I think the patch (plus squash) is good, no complaints. I'll
> watch for v2.
>
> >
> > Side note: I think is very busy elsewhere and this could go directly vi=
a
> > the net tree.
>
> I agree, straight to the net tree would be best in this case.
>

I am sending the V2 now, a bit in advance, because  I will be OOO
today (and this weekend).

Thanks !

