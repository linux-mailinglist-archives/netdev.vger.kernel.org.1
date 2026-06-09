Return-Path: <netdev+bounces-296828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NyLJMitpJ2pzwQIAu9opvQ
	(envelope-from <netdev+bounces-296828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 03:15:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE0F65B935
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 03:15:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=sVNFKJ1r;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296828-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296828-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C6F930BDD1E
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 01:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDD12EEE67;
	Tue,  9 Jun 2026 01:06:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD0C70808
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 01:06:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967208; cv=pass; b=DMp1CdN9DRjXDQL9kcdH8b3Q36lSRpLoFPYqHGJfkleI5wZUJAjD2IwYbHKzJ1zGNvG19htcn1g7hLCaTFJrhnbzfC0e6nHnNAvr/ByLeVhRpOWG10K+A/NJXMQ/nq+IS6UNde8tF9S+NiaTwfe6CjACDpz/Bm1NQfwI3U3QtrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967208; c=relaxed/simple;
	bh=vsmeg3z4qb4/4XguO1mK502Zh4Hgbjqc82BRiVEEmSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMkz0t5QP22BD75Hzr/wMcz1oRzejU37RK9bWjZpByxma+xZCl7eR/CLViRDjvFAWXZ2RoS3j5XLkNSDt2UhWWCQgghkxbcM79iGfc9vyTbh8rI3XLCOaysOOO1T6IjAlm+FdEQbZxjWfOhpNsJlqlIILRJrL9CIELTYUZiFWAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sVNFKJ1r; arc=pass smtp.client-ip=209.85.160.172
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5176465a4a4so68769841cf.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 18:06:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780967205; cv=none;
        d=google.com; s=arc-20240605;
        b=LyzhUc/mQ5Q2hkpH6x2vcT9Bg1GkgGs1zDVN2PNvAFMdFw2EZldhppvlR+V9Qq6izB
         W91PMAdViI9ZPzkyx9ZzHKqkwQ3xAhRztTG/Y5wH+D/Pk5h3Tr9xkT5BF/suSFRIbrP0
         O1sb71Z6CbEaz+fS0qgf+e6VeDvgokzLuPgCtEdpHJT7iZQZsofJJKQNug0mY4oRnoSt
         Ebj6PJnSwrWPilKknq5BzyxiI/5Wfv8w4R1PXOe8epqCInG5yY7GQg97C9rRCHsykJUQ
         GRqW8yLG7LjpvS5MdTvcuq7wuEhQyMabYWmKs1EXiVlxTT8NKQYZrKYdu1YRTfwvPkCV
         tBZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4qoIqGrQdBgzZF2aU6fDwpwjHcQ9aPjAnheAZ6bTbfs=;
        fh=dtWjvRWOcuS7Rua8SXydDRJlesj0RFe8AUunDi0v474=;
        b=H3YC3FzDsORFsvq/5/L/cuvQ1RcPPnqd/BkzuDn87X4tX1OmTtEm25c0AoX79tPS1h
         QloOu8RCBYoGqBY9VofGXEZjLYVfJOCEIXQTqh80Yu5AuHf9Ph9S0PpHXFRqDuR+QtVW
         2EPI49xnBleC8oOhwdiXGrNJRs95KRTEjI03A5PNg0OykGXuJgFHrwTcWvOJ+nezP/i8
         Xal5b2oX/wZ4kjf4IrcN9S1vl9lV/JMVl8VXjRWnVrEcfUO9QiOEChzEk7BnOM5+CpvV
         ycwnobbroymk/zP421trGK+2rl0xHW3vBaGx4YX9KPHRBRPyRFVCiwwa1T/2nyjm/wO0
         NePw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780967205; x=1781572005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qoIqGrQdBgzZF2aU6fDwpwjHcQ9aPjAnheAZ6bTbfs=;
        b=sVNFKJ1riHpa6F03FbHbsNnN9Vny2yKOFnuXjkHl2GE06beGBzjLdH8nJEeDlGfRGO
         chv9uFyFpkYE6W5MN2upvOFqTefTKiExDVl0dIElRexEu1tcXx4t8jauOaDt8sg1F6yz
         Vb5QBJYHcl4X7Nkt/pL3aih1yeWGuIB2fH0sWSwJbaETvicwaiELtjYoRq6LElWTqSKN
         C1QLeLYwg8PHKTIz0XgjtiNekcRyuETMtC3V4cQwgvxx1rMOyOe5ToWI9732LPxkEcEQ
         xa7F9u/CcRBjV9W3rbmRrObJRDFY2lr8ozaKwYz8RyzDML7Ry2VpcwPqg0qAgRqE/dNb
         tiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780967205; x=1781572005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4qoIqGrQdBgzZF2aU6fDwpwjHcQ9aPjAnheAZ6bTbfs=;
        b=r/cVR9PoHeqWKCrMPqMNMTHM0qksCpg2ek299Xz+5/ZwccyTDBwe8dK8fNTVau3rR4
         hcD9j2nnMT/u8zGMdRkALkXSiHwLAVl1KYyFbBOhode0s7fA1YbSQiko6LnMqcDpSnPw
         o8B0tOHl8SGCbDH3rbn/A9m7MQmqadBZLFzukAqLhDtnqZgj6ma0xZTWPoXPps0hDa35
         3X1Z56jeZzhzldIo+tSpvViyTMjN0WIpN7jM6um+WcklmvxU5Ek+OnIsAyiOFUZdr2MO
         T/+ViaEWcJRBNgE3W0ALS34AN5DXRFXzUWeGUbmfs4lwT1GkyXm8LE94S74oIJyBguwa
         TwzQ==
X-Forwarded-Encrypted: i=1; AFNElJ9gUtZWRzrgLU/wyYGgXNv4wEnZAoZbw6/2krTYeLYLHmhNMpwrV2h4CguzQn5qeBDXQWL/2t0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGbI26UmziqhBgeUjxLu9oMVAuzZD25OGTMj9uE5ne12ivyiOU
	CbgmogFYWVgHnyXLU7LqmSuvSfROCar2FQGrQBVH5wzmjRllnesklrxmUG+iolLBMFZFXjQE696
	RwIpOFPcmKSithAqZe1NeEXMyVQoriSYkYX7dQIgY
X-Gm-Gg: Acq92OGJG5hQlF7bNSQdsZ4OEtsuYBYNUZr9iuwDVGNgGzYcdSRRmbtYYdcnBWsKoVo
	ErZrysRuCYMF+SV6y5egYcX2pH3O6tKIBM5LCmp5LfFvr5tJ3SLv/m84dpWP7vIz1Mf+7eF4wjb
	flK0ZxMWj73N8Qe/N4ZIUMNOKW8I5cEhmn7ygSPTBZglyjFR/d5R9J29Q07WJRX1KA99Tzrmzxc
	+zohwL/8/2thUmlSg3opaT0/7CKeb07nEr4T8+zZTv5axiCtTNmBpmEog8EVzmtZ9G1k9vrQltY
	YQCy1g65yfdigfkNvahbU6dEqzGCa6m0PONMeklBZJLwYGWIcJBC2WXW42+e1b/K0rgdHEjgZzN
	HbaMqXoHoYQH0lXk67j4Wfa1pnXxt
X-Received: by 2002:a05:622a:1808:b0:517:96f0:5658 with SMTP id
 d75a77b69052e-51796f06eadmr252411441cf.14.1780967204755; Mon, 08 Jun 2026
 18:06:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609003658.1237966.5506cf1b9345.dualpi2-filter-no-match@trailofbits.com>
In-Reply-To: <20260609003658.1237966.5506cf1b9345.dualpi2-filter-no-match@trailofbits.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Jun 2026 18:06:33 -0700
X-Gm-Features: AVVi8CfCqijTQAK4eV3JnDZMXEbbES1lZXpFvKQRqeZxD7_c6ANg-m-dv-f45jo
Message-ID: <CANn89iJrhwO4cD4d6mqLpx7+yUFLKBAcmhsGFkEqU8KqsW5QGA@mail.gmail.com>
Subject: Re: [PATCH] net/sched: dualpi2: clear stale classification on filter miss
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "open list:TC subsystem" <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-296828-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sam.moelius@trailofbits.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trailofbits.com:email,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BE0F65B935

On Mon, Jun 8, 2026 at 5:37=E2=80=AFPM Samuel Moelius
<sam.moelius@trailofbits.com> wrote:
>
> DualPI2 leaves previous classification state attached to an skb when
> filter classification returns no match.  The enqueue path can then act
> on stale state from an earlier classification attempt.
>
> A filter miss should fall back to the default path without reusing old
> per-packet classification data.
>
> Clear the classification result when the filter lookup does not match.
>
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> ---

We need a Fixes: tag

pw-bot: cr

