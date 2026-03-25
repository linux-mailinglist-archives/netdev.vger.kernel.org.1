Return-Path: <netdev+bounces-271667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDTCI+sbxGnlwQQAu9opvQ
	(envelope-from <netdev+bounces-271667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 18:31:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4B8329D87
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 18:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B03931410D6
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304733FFAAE;
	Wed, 25 Mar 2026 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yez4qwMa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFFE3EFD01
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774459085; cv=pass; b=cdQF1VyLkWYLrP9JdZElkDqXFDDQYJje6bgwZ+8tePrqUCUeY5FqKt5HWlBWhJ/BMp7ABnx7RF2/O68q3DtWrtdskGcWr38pvMOGCigik8MAFd6LhrjNsecP6r0RUevYIgHuqaD9HOtusvLXGGdu8V4NVQ94k3PQf9LiinwqTw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774459085; c=relaxed/simple;
	bh=QKaRPYMdlNzJVsqj6JYa0b5bId1rUEMfyl8IBcSL9bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTMyy7WVRn/dN9Syz0ngDwCZpbFD7YX+YL2l18yewKkvvheZE/q7GnDbLwTvR7qcxs4B13ekw06g3GIh+NWWI3YI7NWHv85A1Lhu01IWpVeLI8peR82iT0F9Yya87QmR/WyDadu75A8AVNLJ4NZhrMAJ/ZtDNwYKaxr5GW2lMsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yez4qwMa; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12a74039dc6so68847c88.0
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 10:18:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774459083; cv=none;
        d=google.com; s=arc-20240605;
        b=J85R3GnTckVCgd03tQVdj1TCuDa2LN69yobLmEzAGBNWZgi9xRZPqm1PTNCdQB9YVC
         WwJ3a3HbkXhBhA0NS/8jdgAAuXLq5RDE3K6K0umYHiCNvX9+WwGky8MlJkdcBybDxGbb
         /ZDlDGMeHgP2TBdtEsv/ktxt9R7x40lfnXucYKbFfxXyK8/9fOtYpDMeK4M8bO1uvCQC
         YJ6u7W95LInnvwh++vP4mWRgPZg49pZ6UJJcVM7PVKkvNWwOPZNJJQgMm9Kn5LXcdSQ1
         THrG+HMFlwDMtuhosvtOGUYRWs/kaQTyU2OI61N2PJjQIaYAI1ExMUJU75Xsb19M3mNC
         jVAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QKaRPYMdlNzJVsqj6JYa0b5bId1rUEMfyl8IBcSL9bU=;
        fh=5+zq43gglk1ua/4klSDxOWybEY70D3EnIBfRSvdomMI=;
        b=gXsniMOBjT0XMl4omdwICtiD+p10496qTMPu6JDazAGRn1jIughdjxpE9gpoO71ckO
         ER3qOUEpcUoDhMlrkw1Yfy7f1qabnVtKhEv7nlmEA5CCf+djjV5WWFtpn3Dm7U2nCejv
         dpuvJN/Zfb5zN3F1MgwYP5rKzyC80896RF1wREHwQwaxfVt8D26w3OMkE9+Dz2f54O+/
         B5hIyuJaDOytQBQOqezkuEKS3i5mWa8TCtvZo2wQqbmngA+rVW0WIV0VCKuO5+ncyJLB
         KOQinZg3IK+c7OBVgavT5ADsBJWNJcW5lKzADMeZySFauHcvR6RF4+yXqt3m8H7bjleP
         OIDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774459083; x=1775063883; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QKaRPYMdlNzJVsqj6JYa0b5bId1rUEMfyl8IBcSL9bU=;
        b=Yez4qwMarx0dKOqNDJ/+pZvuCs5vGMYy4fiYvcvSE9XygkZvkYhMPfRg5VXvGH7UyS
         NXPKNr0qM+JyJlF1Qkr2qfpJz8QFq7LYYSvEuPt+9FMKZESOV4G1S8FtJS++cA/O1/qf
         VfrT6ohWUQN2QleQG+Tt/tGa4pN7nHOdzbyLMFpZ6tvwHIUBBrjCzORlncxIsByLY84A
         uCXkX8nF13Z1c3QRbNRHZO5+BVqT9uzjD9xoJw8PEB4t6CqGgfHI6IEIvJAZFQy59+0W
         nL/uiNi3wEFpWrvmRSSVxKPPTPlIhkwyAv33R77upqoY0ZBe8bit5f5ocKui12QWCMJT
         X/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774459083; x=1775063883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKaRPYMdlNzJVsqj6JYa0b5bId1rUEMfyl8IBcSL9bU=;
        b=LoDh0k21qhfiOR5XVa0H9V9vwkXxd/TTLJzQP5vPeGP/fwO+1End73hJ00YJtr/LoU
         YMxus/r3JvBunD0AtkeLdwmo3WSxQbvfNJRTVStUChzQXz+c0dytcPmE0faj42c9tTgn
         jjn1+5qJvQAOehTxLPAPoYQsZi2uIhOrYiVuIyWAEc8ccwdjSnrjWAh9U82O45dpJkpm
         dE/SGJYueBdRAmHMKabt8lnCTyPxqSt8uJeNfwjr0184c391m9oM6z/k8NorpJSAdMg4
         ttqPFfXRYKQ+1Yjcb2Afjz5lR1fNvgWu4ZFMBosKEel4GqPKkdnQag36XtiGLGAPFRDn
         XgOA==
X-Forwarded-Encrypted: i=1; AJvYcCUjwFMoS/Gvf5MALEdXCBaUuTRH5lehbDKQoqvfqsKjUj3V8abSZSSoOly8ef3OJqBxfeTQu6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+qCLSXlrMUk5E4b89NfqmJNrXm11lWPDf5nqTLtqoJLBJcYpM
	lfaGn4UK83JneR5P2wlEI+p73PMYLtqMGx/c2sccvrvrFGWMZjWnRqhi0d3B9ltSJs0pixOM3iJ
	Mi28Tp+qxsIjzcP2toQyOHb7u9G2sUMQ=
X-Gm-Gg: ATEYQzy8BN9ZQpUgmwOlZwOFyoh7FSMKr+lO3KNn04ebtWoXJE6DXvtI0vKopvEuPsK
	sjk1xYfSI2Xu/Y6ZVIcOTmZyFhbfGdzlKwUdLan8udmqjjg5RCu5ThA3zm+JOERVWLjyP9EyhCc
	x9RVUf7dCTotVVbqDuSS6VOZCCTK+30wFRJlESWn8jehTdNBMjm8KRDek/OJmpqwxOVIE1rG+57
	lsj5FeHN5T8+M6vQNwk9p29XUb6VSisW0NvnotDNcnSmIE37DvP4H3vibKHwdVHNlEFFW1yXVU0
	hSt+96pxOq8r1SJ9/eOeL42/hGHfTcMJGXD0we/f
X-Received: by 2002:a05:7022:620:b0:128:d39a:b141 with SMTP id
 a92af1059eb24-12a96e71260mr1904933c88.17.1774459082953; Wed, 25 Mar 2026
 10:18:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324205301.1361608-1-atwellwea@gmail.com> <acOVlten_N_5evGX@gandalf.schnuecks.de>
 <CANn89iLJJ3EF2-qe4AWJN0teh05x0PPJjOAfB0uG9rNZuJUZUg@mail.gmail.com>
In-Reply-To: <CANn89iLJJ3EF2-qe4AWJN0teh05x0PPJjOAfB0uG9rNZuJUZUg@mail.gmail.com>
From: Wesley Atwell <atwellwea@gmail.com>
Date: Wed, 25 Mar 2026 11:17:52 -0600
X-Gm-Features: AaiRm50q0NC-_83d6Ruz-7T1f7PQXCUqvxlSqVnVeyorauR8lF6UhfNAetRcvxk
Message-ID: <CAN=sVvztL+bc2So8F9x50yQypyLEmEm5bWHzkXOOgdPFLG0MNg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/3] tcp: fix scaled no-shrink rwnd
 quantization slack
To: Eric Dumazet <edumazet@google.com>
Cc: Simon Baatz <gmbnomis@gmail.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271667-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,kernel.org,redhat.com,google.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atwellwea@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C4B8329D87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

I still think 2/3 is a legitimate fix. To clarify, I was not trying to
claim that 84 is some magic number in the abstract, and I agree the
packetdrill is artificial.

My point was only that, in the constructed case, the old code can
preserve a scaled window that is larger than the currently backed
receive space, while 2/3 keeps the stored window representable in
scaled units.
That said, I am probably missing the reason why that is not a problem
according to the feedback you all have given.

So I am going to drop it here.

To be clear this has nothing to do with social engineering, just was
trying to fix something that doesn't need fixed I suppose.

Thanks,
Wesley Atwell

