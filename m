Return-Path: <netdev+bounces-262146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DthH+gAo2kJ8wQAu9opvQ
	(envelope-from <netdev+bounces-262146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:51:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3232B1C3B3C
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 651213066766
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173C0449EAA;
	Sat, 28 Feb 2026 14:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3bEd/zQX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BCF4418E9
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772290277; cv=pass; b=B7UCVpUl55UfZj4ggY4YuC8jZS/9kdiXakhzPv641uWMZ1V58Xe9b/FHF2JfM83iCoa+I3ZuPc2dMuqP74Q7iZNUip+pzJwYtfy/oGd0Y4f4qdYRx9x2H1PmqcYkL7Y8wgw5RwVqG79JJvwQVdNYW3gtiPNw25hV/Phbj5H7A0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772290277; c=relaxed/simple;
	bh=DF1v0Dhz8GhqupDoMH+4MuPCNTC15brQSFrqVn+Jxec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIKcCb8rRGrn1O3CBFbC1Y7K28V4aUPjn6RddzCdtyQUVFHOrrw8B3XHcbyNCstdmVa1UjfkJk4hcZKQuifb0WMknlpTTxhLt9yfG+lX49C8BPWQpbnFPWmv8KEarPFBkv5Iw3SbbSYoEm/6R4TiMMk60Zd9l68xDFNbPRGnoYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3bEd/zQX; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-507373bffd9so27812451cf.2
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 06:51:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772290275; cv=none;
        d=google.com; s=arc-20240605;
        b=S5fTPRWJlZ1BtU3RwN9uF65qyGI394+O+zrZUuCQ3ABcyBCMDwQSuWsELHnnPSRyOJ
         irg+r5uYt4bIf+BdTIb7XayaeZemO+j2Qj9fZVhZuDAA6afmcNNk7YKtk/wynS5MzJkM
         miOdYY2glhu0fokXuQdc6H1YuxqQQ+EFJFalr4sne5AUBejAn4S3vg+1TajmKiGsQVjR
         d3fGoJWeMjP0CQM6hjnHuaXTNHGe95N53nll7E9bv/ENb7CH5K9t0LDxQxiMSG15TOY2
         HK+RdY7klrUHWebiimaZzQiVQEtjm5Evjr2LkmVOADQmh3QvkMrexrLTyKda37geDo0g
         xCYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DF1v0Dhz8GhqupDoMH+4MuPCNTC15brQSFrqVn+Jxec=;
        fh=aT+hIgt87I/lmYwfQ4r+otizRVPi5n/L2iJg5kf2iOA=;
        b=Ah2eQdD2B5n1v2708FwPzcEHYpBTIEm4agZWVHkdD6LuBTHyZKh2fFvGXV5S26G79G
         1YAfsbCifNSJkisWNnmVm+mmWgDUY99hdXo4OuoqmsMtOtDrj46fStGKbhm0rLNB7r8V
         HvDDnsPMlPCPLXWihE5jgMvDJ2cuY745jRJJ/5iLe7M9L34m+F9zOA5SIGVQsWHCfYv9
         qwaKjGghlZxtmlB12zs340kt9xKC3igxnmMx7kqYg8R0qYb6I493OtUykqWp3VfhNiYF
         odCsHz0U3sCA7PTDx2jiW1YCAnC5//J/QkyPXOrTp88Jnb9hijOIqcAl0+ir0S4dE7Bs
         TO4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772290275; x=1772895075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DF1v0Dhz8GhqupDoMH+4MuPCNTC15brQSFrqVn+Jxec=;
        b=3bEd/zQXUkPraQlRqOTBU1KWCCvTBxuADo81Cgq2gfNOyO3Dj592ChDPL5ERicAGVa
         5To10tqQ41bEP7+0fYvygCgXBsdzj8RZc4lOjAofsLdZlg3P78wcAzEWVpypCU1ne2qo
         MWHHxaz3ZqONEFsCk7iOunqoLvNuMutSGy2dygpXyxi0GPSJPf1yCBFEbByCH4Fh81b0
         c2M19jmyG2FMvOXijKqJAudSWiZhuLHXoF0MkRLjD+tomPJ6tF5TdNW4rbMh9DSk+E/5
         fRU3JZIJmMGVarHh7uj02JKtzoY1dIYkBqcAZC42wgJJ+mgmt6MBZJwBOJBT7+uvEQAu
         WSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772290275; x=1772895075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DF1v0Dhz8GhqupDoMH+4MuPCNTC15brQSFrqVn+Jxec=;
        b=QoZU25GWXnVjmfBpfbGvgaudMx6EXxbiLkYaduhibq2KYGpwVTngYCWBjq0G+LkDb1
         iJ5xZe+xkqEIOIUknhhciBcME6BYkT9TA2zHcBLyqp5b8hvK3g/GtRGSXzgCtNIRYPPP
         9RahFJpdprUKUZF0S+KgmUCY50tmqnGoPi8ynHtIngVYzXYrhtfbSeKIcidutLSIikQY
         H0vm1LEBOsZLg82zULMhwk40OF0GybIKQJdME8KoNfEyE05jj++dekuD4rauACMZ6wwZ
         ulMaZRuIi38H9Cj7i7dVf1cGTxS//+CRTDpCDy16QmDS9np2MCMZDHMx9ZJ0vkjoJY5A
         MJLA==
X-Forwarded-Encrypted: i=1; AJvYcCX5mAP4l4gy0lueWNXwL5srhJvfI+J590BUWXm4CITeP8D/nBoIEpdpjssz3K1RP94rjby5we8=@vger.kernel.org
X-Gm-Message-State: AOJu0YywAAYtbDVazbvRvouGWWVytrPgOimwMSCRbL+knzkDIxZ7pG5Q
	Ov15M3GTvj9HJIigaNaGM2Y5cAaUJXI86DvrVHtiO5kW32be5qm56UFQuTFNTsnytxd7JU3d/rX
	x4O78FW63xGKQIYnI4MqBOlS3seqgeCDRpXxWQ8Vd
X-Gm-Gg: ATEYQzw10ht3lHWw7teGwlHKUHnZnPfMqxVft8FFUmWY0hRcJ+1Hm2p+X2CFdPw6gbZ
	D9XcN0pj5VirTWmq1fea0B4i+dly9fekrD9+Vc4dY99r7JAaZquFRr1DeZZWrr57oL4m0nTR8EP
	yY6JqwRvKBXrvKR//KqDEJRY3vCN0pfw1QgDqPh+jg1EW1UXPG/czdg0r584bb4FxBDqsXDdM1U
	BlvaqlIRZEF+k7DICk+VLo4EoDKipXyNTTuBbO90VSXRHUswjEsFVySWrPPXvMkzLoKANiLpGTz
	zd8j5+r6
X-Received: by 2002:a05:622a:1787:b0:501:4857:62e3 with SMTP id
 d75a77b69052e-507529a9c8emr69836551cf.50.1772290274254; Sat, 28 Feb 2026
 06:51:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com> <20260227033903.3307272-9-kuniyu@google.com>
In-Reply-To: <20260227033903.3307272-9-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 28 Feb 2026 15:51:02 +0100
X-Gm-Features: AaiRm53_nidD10VAlqYNQUmgfLwp1v-oRkPyAI9vXQy2whMX7LUKKOZlRPMZYiI
Message-ID: <CANn89i+UME4+_mv4Y6041sSB6tw7gdX0AeJ5kKGdvaw-GHHATQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 08/15] ipmr: Move unregister_netdevice_many()
 out of ipmr_free_table().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262146-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3232B1C3B3C
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 4:39=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> This is a prep commit to convert ipmr_net_exit_batch() to
> ->exit_rtnl().
>
> Let's move unregister_netdevice_many() in ipmr_free_table()
> to its callers.
>
> Now ipmr_rules_exit() can do batching all tables per netns.
>
> Note that later we will remove RTNL and unregister_netdevice_many()
> in ipmr_rules_init().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

