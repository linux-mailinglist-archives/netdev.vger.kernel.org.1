Return-Path: <netdev+bounces-296641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RfprCer0JmrzogIAu9opvQ
	(envelope-from <netdev+bounces-296641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:59:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 833C765902A
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:59:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=nuvgRgbB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296641-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296641-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25016350D28A
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 15:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8963F1AB6;
	Mon,  8 Jun 2026 15:18:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E423D47A9
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 15:18:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931911; cv=pass; b=H1xaFmoaQCfT2kGbsJawWQvhC56s4q+lM9hSomZEzDwxd3RvU7foFRIVboirwmBEr9rl5ND/fehCE/Bjw1FqbUoKo8njnzKBDkfEOodC5q0yNVrBuLmfJ9uLKB/P3qliofQvUOMVpB5fDMSE+B5ivgUoO620pdTQN3Fqe23ASwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931911; c=relaxed/simple;
	bh=Id6xHu57zlTC6nJBZQjVnni72XYWj9CrhzKzuJbP/JA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oA++7Qha4PkiDehOUwjdvDIh0T0RlYaYnQYuXGVncl5i+YhI98Y9RrDwNTALRUsjVSmvPgjsLFb8vu68YhJ7jiviJ5+C2Ni1eo7qDl1MNIzNU6HYKDzYwpx3m6lxQjkq0veuttNK9sa9vr84qRNteC62E9Qq6ylTQcSzFJ4PMO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nuvgRgbB; arc=pass smtp.client-ip=209.85.160.172
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51765531803so1977491cf.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 08:18:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780931909; cv=none;
        d=google.com; s=arc-20240605;
        b=WiXIlZB129Ipb97XrQ+L5mD/u4KLQ6yuxiTSMc4p9gbrAH7F/dewY903EETwcx75Gl
         cBZVsaD6PeR7OdBO4Cy4zrOAa3CwUQvE3I+wiObwS2m3u9oExQa1emVDAqioSxUSC/gt
         cigMgHOvQ8aAPNV9DX1cjq2xNhxCziWJIw5ZBY52taNSSJwabAFuHXro5QPl0wAg3pPs
         F83/lPiAMH2ytseklR6VxSCmDJUGVPt0wctYqVHC2+8rJMAzvq0SvF50iD4MaQukryuT
         BZyjEZP0OODroL79WjDTglfrn/TI1X/vO+lLs2aldcgGPf3NVExvm6NN9Jzn+fiCwq9q
         jE4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Id6xHu57zlTC6nJBZQjVnni72XYWj9CrhzKzuJbP/JA=;
        fh=zUVVjvZUZMu1g+ZwfptIOOHDB1aPoMS5ixPqfj6mRxI=;
        b=h8eUHAmqBc85uRuptLupruim6Q17sJ1Z1ZbyQ/w8HatVZ/o6VzCCsFM8IJ7Cs3JVcW
         /xJ0c6VbOB9PuBL2SJ0+0Mye7yY8yb4oRNgr0DpwGofRr11aO42LZjEGjUKUE0bfq6VB
         XS+UXxH/iDlJ5+jsHGtquLr8pbGvqnMpl0ENS7QJ1XccImNztglbZULKNDMyL34Ba9eF
         1+8cXMg+FwM7LY84Pmbk/p3ErLlFy5JWqp3AB6+p8ZowpDWTO4evC8oyv4D2wRTaRDno
         +4oliMA8o8xZg8qdicwk4quZU9KKsaUe1Sc7pX3H9jmWhTSUuYCjCiuuLhv9d3/QA/HV
         kH6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780931909; x=1781536709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Id6xHu57zlTC6nJBZQjVnni72XYWj9CrhzKzuJbP/JA=;
        b=nuvgRgbBlewPit8gJq3IepuQEOkf39ZE+gtTR4h4bszoP/mj8irWV+zza9y3I1DFKs
         GqctuHDFe/jeukGbCc5ad0b9sIwUICUBhoBtF2BqOKq43/2OvAbnbqg5SLborHNbXrwb
         y7Cp+fa3bhROxeiR/oqNXqEXpZKtdlS0g/YCQJOrunZ/taJzsXB9kXWB3XIomsTSGZSd
         gWWmg18BjaPl5y4bxaUjiZO7fvfBLXTJwE9dlG6OIEkFm/j3aG2hgdTIWvpJxnK9QYpZ
         UzjuQyAXXgohsDMWqOUXfw3Olym7VvMoqBNFsGOdMN2oMG90qEzSwyk0CM78pjt1JNgy
         IaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780931909; x=1781536709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Id6xHu57zlTC6nJBZQjVnni72XYWj9CrhzKzuJbP/JA=;
        b=QKhM+pj9Hx8w/YyIrRXEVbXIKV/5Pv+PxTFn5MVKwbeGjMHdfr7w9LP7i9CoRiuGWj
         ZcS1z3k47tqPO4ZNwPjnu2dBGI9YwQr9KS+VkL9P9fWDfuXPEboAIjPFZuRhOtph25Wz
         JFSN2umUNYbnIkuR59CxPEnAmfNWkvK5c0U4LppQs1Izg8n7uyk9/u0NWT5LCtSfi4cL
         aFGdDqa849V+7R1pS19fPtqoKnPLbcJt5bURW+7eONYDkpTCd6rNd4YQepYyBjJs4ypj
         FzJJpJFx8LP/IAiKA/hirghJz93Q1IBakt+SNZt+iirZryD2T3srQNv7dpX/jRaDjI+K
         xaTw==
X-Forwarded-Encrypted: i=1; AFNElJ++5KZZh5o/JHemUhfpTvkmzSoScDyFu0+opCSxVKSqn1hpAK/TDongYoDicvp6C9jPsVu8C3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxok2XzRJRZHJ/v/tCND+uAQOSKPWdqzAa7QC/ZgyzDqNOrdut
	PWhN7CYBDiJkLvjyRm6xlqagaLaFJbsyxKWNUoTTnZrQ5wQXhFN9UHjuscgxUrybYvF0Z1ueW3I
	5jpjQ09ebH6toCPG830PunsxTgxLChwKiLGhp2XW2
X-Gm-Gg: Acq92OGfrDOZXr7xDPtwCT9zc5h4UsftR1erd/Gns1P7zaNxbpO8T4vJgtGZPvxFXbp
	DZF97rrh0khqjQexmBo/8CbvLxDAqP9XgmDYj+6rZVPAwCTXyAAx89up50DkG3uCSKNhLs9cDyI
	YX2SDZ6hp0WcOrC9naLTs5OmWBJIWnGrIYxlFuC4OVtlkHvgbl1N1pZ+2R/CmYwusleaYbXoF7S
	kTj/O/DYLDDzWp/NEeOZuhqKcxyXoe8T3dqS9wfaqlCxxUQ1xWvyM9RTYDHTkfm8HT5LVNfJxax
	h2ABJ+937BPAbc4SrmsFysYAe0xmOnF21IITHaRGc5YSo25wpM0SwIN6OM0x/meAdcvB/Cz3F8z
	8HxOsQB4=
X-Received: by 2002:ac8:6050:0:b0:516:4f62:85e6 with SMTP id
 d75a77b69052e-517982a09c1mr25199751cf.17.1780931908741; Mon, 08 Jun 2026
 08:18:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608151452.706822-1-edumazet@google.com>
In-Reply-To: <20260608151452.706822-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 8 Jun 2026 11:18:11 -0400
X-Gm-Features: AVVi8Ccx5G39srW59PqezKWJAPpmOyCgCktU9Fpn_JzVTh8MdYTJO7qNc3LrnG0
Message-ID: <CADVnQyk7dut+6PoJcLNXuOmGQx4zjYk3T9XC5PAqaiGNvQOBXA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: refine tcp_sequence() for the FIN exception
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Simon Baatz <gmbnomis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296641-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:gmbnomis@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ncardwell@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncardwell@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 833C765902A

On Mon, Jun 8, 2026 at 11:14=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Commit 0e24d17bd966 ("tcp: implement RFC 7323 window retraction
> receiver requirements") removed the special FIN case that
> was added in commit 1e3bb184e941 ("tcp: re-enable acceptance of
> FIN packets when RWIN is 0").
>
> If a peer sends a segment containing data and a FIN flag before
> it learns about our window retraction and has a buggy TCP stack,
> it might place the FIN one byte beyond what it thinks is the
> right edge of the window (i.e., max_window_edge + 1).
>
> The data portion (end_seq - th->fin) will end exactly at max_window_edge.
> In this case, we will drop the packet if our receive queue is not empty,
> even though the data was sent within the window we previously allowed.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Simon Baatz <gmbnomis@gmail.com>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

