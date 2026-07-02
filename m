Return-Path: <netdev+bounces-304248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uDQVIGGwRmqmbgsAu9opvQ
	(envelope-from <netdev+bounces-304248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:39:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5F26FC2DD
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:39:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=IbwnMMGv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304248-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304248-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 311A530CBE58
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 18:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C933911B2;
	Thu,  2 Jul 2026 18:03:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F18137A83C
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 18:03:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783015412; cv=pass; b=t5l3Gl4NWbuVwThaMUWK4kPZKDnNnGSBoAk4ca7LfGCfa5+ECVy31ubvhhYvKxOGP255uMLJUrdu7aCbosS+FtjxNdGw9rut3BvWdYIvsv152GDzatbEmuJOPeBVZGlHMZWlUI/pWAMUfhzyABVfHHCco2zyM/ECL0z0xx8xy9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783015412; c=relaxed/simple;
	bh=Cbf20E9lCes9D433pmNWa/Vw2/r8kXIhdolIbVyQdWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8QL/mKQ99HlA9O2UcxfwvdBjHNWzw5fn/0L9ixcy+wJs6TT6ZDqBD3RaFI7gy9mooVVluXOXYE1n0Vxa563dXWFN1hgEh95lvraWyDLflgbxuOxBJ3Pv20Rl7uwGRBLutFwF9K5GxSwzZL9cPrhvi/y7VZvMy0Ym6U6EaLEmH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbwnMMGv; arc=pass smtp.client-ip=209.85.221.46
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4720f3bf164so450366f8f.1
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 11:03:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783015410; cv=none;
        d=google.com; s=arc-20260327;
        b=U2m5I2DLbKKIxheujAAfI2AB6fPF096FEfqLQ6FbfkeP2jjPMlmxFoHYCinLu4/e02
         Sxg7BHqMRmBE7j2V613tJ/UTCVYDO+Cgdjos71VWH2+W+KD4gVdMVAMoFBvweIGMjWac
         /Cqiv6TQgDyJvqtZLz+06OFnw1pYh4aLO2UkrZnxQkDuGp/Puv/KLfjeFnHZEB9Gj00y
         30VWy7oLxYhJTYsG/ejHmzH8V2FbOrumuoRke7FolHVaNHJbKUkka3oqMaTyI34nLVaK
         7+E/ALLchbNJzSD6y7EKGYh3LiHO9ZMsWiLknShMRDjVS7h6zHPvfL0N4hTk3IEZUd+w
         r3YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Cbf20E9lCes9D433pmNWa/Vw2/r8kXIhdolIbVyQdWo=;
        fh=V0GkFinhdI8BKQi69e0ih7Rf0V2a6p6oPfr4XdJ00f8=;
        b=f5mY+GDC5PZ2G3nDzbcBWC9d4WwJAPnQ1oAwMaygrgaoNE8ckUzAthxn3eePxX+YLs
         O3X59f5Rhedc1w2Pkh8IltxLIZtjKZiPosBL0TigZFz7H+9vf5UMjFEMOAdzgtl48rx6
         R67JIkuGfo/qMVE9gvyHHjwsClA7Xqb6D3YfHCosSX0eY/eXY2IQeOwaiRmn6AuXsD9W
         UZ6+gIBynuqty0BC0/SWYB/aULWQX+F+/9Tx2h3Tvtmm1JwC6FX9q1m53K/FPpuzq6NF
         ghpSejMrUTRizAGbFZg03NYjoCdL7jW7lzSlG1g4m8tnicOcLr7bJNTZt4cPz45bKuj7
         be/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783015410; x=1783620210; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cbf20E9lCes9D433pmNWa/Vw2/r8kXIhdolIbVyQdWo=;
        b=IbwnMMGvWkVFy6hkJOr8SzAIVY0ArmEb0koteydfdZxwuG0wE6HDet6tszcmoF17Zm
         GgPYRO7UqLhWxa86S8dyALjuJfcgSQvU4HBQVk0fqKuFjUiYXqNmMq+clGTuo/7GJIjV
         F1mMSOqgpALMIp8QLY5+//7+yCN5rjUjaQ8ljqRWJjInIDYsiBjkiZLsF+HosD0nXPDu
         uXej63k8P3T/Kk+tgJq8qBaJDL0y5frfs3ynMPwta21LAKAgmJB3TNpy2qiBnwnGm8kY
         VMCjSqD2B7pdsMRI3p+BFiSUvyT9GLmMfNK98znRoOnQNPJjzYa8N4He4Pv0oq1vWYgz
         +E4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783015410; x=1783620210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cbf20E9lCes9D433pmNWa/Vw2/r8kXIhdolIbVyQdWo=;
        b=rc6HDysUqpgFlNR0emxBCVmb4p2+7vp8QXntSPjA5A/5qJCZ2xmhiLLyAN1rhRCDXe
         LFnqgEbPYLj6mSS12NpN9aE8oAXga9vm8+mez8zO9+3dEkvN2OR2DFtIrvoqcDjkmvpy
         2JoExh1kXw3hJJ9cKeXqBJ5IEyv7y7KfuETXz7Lvrktj7NLVW/jm6lGFHh5ghoBmNWpU
         ijspYjc37Jr6n5UbvlMnb+kr1fA0VVA1fmtKzWSKgjjXa/ELVOpHjfPrLjkJLUjji4HP
         BM7+oZwBUm1EpGnME7BbggD8lHT3bWMuuQsUeS+oJMS5WDsKXrDt9zue5HwgJPESBq/0
         XILA==
X-Forwarded-Encrypted: i=1; AHgh+RqrsL8yoCV6aCpxl7BbjqtMByU85jwpxhO6hvn3NuCJyGkA6UiZf5luWDmv2I6IuFQ08uRVRe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAwhq95Z4VVpRpdE1bG9pBztAF38eUP4bqGSARCHMTQwPsx1cQ
	nUXTu19VPOhvVwSlQyGj7JqAi9akCDOHkzpuQ4oVVSDhGJ8zupMGBzbxG1aSchxYExTVjpB+82z
	Tw47I6U+8tNKwN8WUVd2stH/xoMyzH3Q=
X-Gm-Gg: AfdE7cm+lkyOjs+704WfzwSi5M9Y+ZHb3IPYq01ZGcUNyMnvDaSHOLT9QWEUT7za3Xu
	SpIiptaj/nGoewc9i0MkCcioZ3rWjgl4Q2I4aCKo7VtWbQMBinnAdKcwPJnYOpQ+QJy3EJWtiBH
	pE3VylDEc652B06ta+qwtiWpakZuX/C+7efxQxUCv3ZE3yghNPRDJb9tep9U9l/s2sLydJ6BfZh
	Np+O4C8eJBtzslsYjMW9nBIbDsx8MRpWwGQQYV4voKGo7VfYcc623zvm9CTr2nKRh93wtg=
X-Received: by 2002:adf:f003:0:b0:473:6590:c42a with SMTP id
 ffacd0b85a97d-47934d75629mr1307154f8f.9.1783015409464; Thu, 02 Jul 2026
 11:03:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701112825.1653044-1-maoyixie.tju@gmail.com>
 <20260701112825.1653044-2-maoyixie.tju@gmail.com> <akUWzu9VjN5WEoJH@boxer>
In-Reply-To: <akUWzu9VjN5WEoJH@boxer>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Fri, 3 Jul 2026 02:03:16 +0800
X-Gm-Features: AVVi8CcOzdOtLYOw_qlNrfAlD6Fe2iJNmFv67Sv1vC7HHKc2ZySmwkhITn64oMc
Message-ID: <CAHPEe=HU_+w5sNu3nW-61XEZDinRdhdC+JWCMN_1=1dgwuAHAg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] octeon_ep: fix skb frags overflow in the RX path
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Veerasenareddy Burru <vburru@marvell.com>, Sathesh Edara <sedara@marvell.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304248-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:vburru@marvell.com,m:sedara@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF5F26FC2DD

Thanks Maciej. v2 addresses your comments. The check now runs before the
skb is built in both drivers. I kept octep_oq_drop_rx() as is, since it
derives data_len itself. The octeon_ep_vf dedup is left for net-next.

One more thing. The drop path does not free the dropped packet's pages. It
unmaps them but never calls put_page(). This is not new. The build_skb
failure path leaks the same way. But v2 makes the leak reachable from an
oversized packet. I will send a separate patch for it.

Thanks,
Maoyi

