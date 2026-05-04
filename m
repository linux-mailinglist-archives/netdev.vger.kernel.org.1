Return-Path: <netdev+bounces-283748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0F22AtNa+GlStQIAu9opvQ
	(envelope-from <netdev+bounces-283748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 10:37:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CFA4BA508
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 10:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB4CF301AA51
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 08:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E788C33FE1F;
	Mon,  4 May 2026 08:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V3c+ECGM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5A0308F3E
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883662; cv=pass; b=oIwlVfuO07L7ikR85w+o1/xECF/ikjuYKaOVJam9/jeRb+fk+mFfjExSPO780zEDFHhJFxdyvxCTs9lb6L6SKoMFDZ3fheb+uUTbkRkuQ+ab/mhGjVTcvmVcXFjUO0n4zKv14a9e20yfD8qT9McAjzmZrwlFFqSsle4HrCgjsnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883662; c=relaxed/simple;
	bh=bTExqUWesGWj14rqmgcSagqu9B67yS2fYcp6s+nvHLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ijx6RLP2eb6bRCvW9XGFcJbVMnj00sOjvF5f0mhBaY3RdeiEUYxbMiFzKqSXjnSi2ApaT28zyw2uSTfQqDLjnFfAJ2wauY6U6fBK3ZpW+EJH90RdkUjUfhpw4Y9/ubz4/L8OJnm0CoAQCu8WTp8P/NXCoS6DmCZxSLAHpI1qux8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V3c+ECGM; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a41099fa86so4406175e87.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 01:34:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777883660; cv=none;
        d=google.com; s=arc-20240605;
        b=F6tZn2/uN2NiwgePJ4iBQoMt8UWEx1xNEweSIPAl0MhVfhAk+4h6EoyZ1oe4hn8e/R
         jOI9V2ZoUrKJeSa6FfJapG3oBP2WEtsr2TydEReTluaaamWtcaE4j5ZDtnKtPa70lVNM
         XFI3kOW1KEyADuKHzsRa+zR5wQ8z0KfFXiWi8DrXWaB/Na5OF3B7u063dCkYKLqi/bvb
         Sz2vJKYM87s5XOdpftEWWXilkya72vEZ+MBNaaUMQ7/o9V4Xbu+Dt6AYQSyIu8KJXDYu
         wO/v4J5Sai+r2rQgwuw7/6LiVzX9dbPd6Osgg1ubIpD1Mv44pVgMFm4eeLIN/0D+9XB+
         y5dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bTExqUWesGWj14rqmgcSagqu9B67yS2fYcp6s+nvHLY=;
        fh=GQG81KEndCNWQZLJ1d5JEKAb8AB/l7go2vMJoH93RYk=;
        b=QbgdfZZKwFp35R8k2s8eS7Sh6ufMMZmhvcA6tFNU4AuTri6HmMck2p9AfymnAP+kAI
         4dKS9jhsV/KM4/vA9nefgVwz1x3qzB82bJxVi0I8zigmaDCgD6D5cRwT85Df/M6GR6hp
         WdrF8vUKf0dSuPGbnXbS/W/fMqFsJewCsy0owMzrphEvMV2ecV/nwUd32myX9G9JL0q9
         sod74GR1NXslVkSbSsuq1JI9Zvx5+6OvG+aPbZrO7GW8du3YTjU6F1KRBIFZuQX8muSA
         zXYaWB5HrbAZN8ShlGFMKB8gE7EDKwFR5Aoh86nPiVUEQpoEJPbuZAOBzGlzoWIwgX0/
         o75A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777883660; x=1778488460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTExqUWesGWj14rqmgcSagqu9B67yS2fYcp6s+nvHLY=;
        b=V3c+ECGMNeNws7cpRZL7mGxuMxzpqUICgNa68nwlge+e5OpJlw++ZUWQwxjEITCT1S
         rege2EqldZOc6voAjo+6QSEVweay7NPemKA9Ewhbyxn10RuIqYgy1iBgJvds1nFHHu4Z
         MM4mjMbYXEhi41C69hjpO4/jHWT4XHp/4rgI+jpF/cjyyIvFIhwsgQqWpREyhbbkA0Il
         9Gi6yx1UVvXQlD/Al/Srhd4lKMrOTtk0ynHo8QwKhDffKCCMDcVYUIzxl1kSKeB3QlIL
         iZZZpWWVx08KDN+zAb8GVDsmCkCsATrXEd3kYeX/paBtAUcUOeDtZgyC4ScKygem0aKY
         dthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777883660; x=1778488460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bTExqUWesGWj14rqmgcSagqu9B67yS2fYcp6s+nvHLY=;
        b=Levv/rjeJAwyCpLscdFtAJU2ET/h1bBAg0pzZ/WJ8/Gpu0N+kxkp24yMVBS/PW8EAL
         KyNcVwJtEkWJC4sQbu40dkz3vhXVPnZksXAsevoUFdy0VOubBSsJIXpDXUGqbfrsYVW6
         WXFft7cpPzFWPKco4eyDryP3cVzzPVygYKqXzQxenYj8pxPateArBWxGws5ds+XVAaTZ
         cv2cDxeU7dSESks/znkrhUh/8aRah0zdXuC/NIqEyxiC5CMkedzOUbaf0d5mpjMc2riY
         ooB7YYJ5clNubEQ3zd9jra56RLcAtmZt+gkaAi4xb1HLwGwV/NP0wpm9SROQaeQTHdhB
         vHPw==
X-Forwarded-Encrypted: i=1; AFNElJ9Xh2BJHyG2u0n1/1wCCONyfCtkZ22KNZvaWk7zAxYRuGUTNUBdc3COJZu/XaY1gOziueVOEm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJUl3ufi+E0gVbphjFaD+oJRJfLYsYPsDtQ3b9kH1+gTCP1LSN
	OgqPgLw9VzraEHVXWyl+4qJhgoEzlUyVs/bXO3av9oTFisVw7XB4wZtTAQtrlhbKwgD6nLLQsua
	3OXvtXIxxGM59OqdLZB0yp3xCJMP8YSKLW4bIESKAvQ==
X-Gm-Gg: AeBDieufk/K5tDDp4G0hHII0noeOjqtlD4P2elTk9A1ea+lfyk6RY8G9ikUJZDcJhHk
	2rz56Bpewj72JkAP7WPkdoRqt4Tvytm5rXDuzL8g57YHmsVdoHtDLNXCTMogCJjaOjvVYMhhfbs
	SpRQnpMDV2+EymRun4UxY55YDNfRyRfzrVondrh4gRKhNu/FW8l5vHdvmQjmfPGkPB3n4G9tFEY
	z4JkRbZ4wrA3n4iOlv/m/sioyl2DVj8NKjVDEwgJYejyfWj1fpto00tL4MkfeHWJSZTXDaM6f2d
	zTnECHvweJkMulEBgKP6WwtSQaH8GLKshrYPym8uqcUNp1vtE68=
X-Received: by 2002:a05:6512:220c:b0:5a8:73c3:f27b with SMTP id
 2adb3069b0e04-5a873c3f374mr608834e87.15.1777883659699; Mon, 04 May 2026
 01:34:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430085412.96961-1-marco.crivellari@suse.com>
 <8d1eff7b-3712-4039-87d6-028a4118e210@app.fastmail.com> <afNguCraI6AvmZrR@localhost.localdomain>
 <1e220a70-4318-49de-aaac-332c0a1cfab4@app.fastmail.com> <afNvZKtiQPLbi-3F@localhost.localdomain>
 <4edf7abf-8f48-4433-98f0-2ed2d97a32f5@app.fastmail.com>
In-Reply-To: <4edf7abf-8f48-4433-98f0-2ed2d97a32f5@app.fastmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 4 May 2026 10:34:07 +0200
X-Gm-Features: AVHnY4J16ygGjVvEIBbe2vlcSe4Mr-lVUzQBWrZHQB6R7WSpDdVqMuTZa6g545w
Message-ID: <CAAofZF4HSbzEAvHj9--TP7QuogE03GXAhY=qecU4BnXBebemZA@mail.gmail.com>
Subject: Re: [RFC PATCH] xprtrdma: Move long delayed work on system_dfl_long_wq
To: Chuck Lever <cel@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 50CFA4BA508
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283748-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,linutronix.de,suse.com,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Thu, Apr 30, 2026 at 5:09=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
> [...]
> The light dawns (for me). That's what I'd like to see in the commit messa=
ge.
>
> I don't have any technical objections to the code change.

Hello Chuck,

Thanks for all your feedback.
I will improve the commit log with your suggestion and then send v2.

Thanks.

--=20

Marco Crivellari

SUSE Labs

