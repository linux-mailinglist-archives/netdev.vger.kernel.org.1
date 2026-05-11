Return-Path: <netdev+bounces-286646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HDPIXHTAWryjwEAu9opvQ
	(envelope-from <netdev+bounces-286646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:02:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF1E50E7D2
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D2AD3038539
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AACB3A3E74;
	Mon, 11 May 2026 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryQVz3zY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6448A3A3E68
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778503901; cv=pass; b=qAsvAvpmRT9pIgeCGaRpMstnKlhdXaEueasynwNB17yVwU0JW4Vi1DN6TtCNQeW9oAuPSCMXFVH/UMJdlUry9Qm02fhF1/RD0VypOCLgTKeymtHlkRUbIaJvnp3gCHVnaRCze7nPkFHKkChPspKOF6pDLUpTHjLJR9bzK00YDBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778503901; c=relaxed/simple;
	bh=6Nd+aRmLnrN6tq4Ole5E+cFDdSKj0kHlKORyZ3uhk8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWGvgiNZ2QjVKEe8uSSF7Nah9TwW2p5JQFsmjZbMcmk7S79kfiGTEvc8UeHVCWUFl/owt12KyNPUrEXXIciRg5JY5gZA+jpF+3QZVBOLLfGKOH4MyGe4jbrjm8E8oC9rJaZE+R/px6OpHFzdXUFJkVBUG5VSajtSZB6wdFUIzYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ryQVz3zY; arc=pass smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-132d1b2519eso1685776c88.0
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 05:51:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778503898; cv=none;
        d=google.com; s=arc-20240605;
        b=XtEMTtOwJzWQHsUWWHA2HIungG3DHikAn6cqru9MMS+QIvuGuJ2RjNNmTr7eGjU9ks
         oKhVDiRaCFa05HKIkAB8AxI65v7tnLokS+PieiAhNsuUTVe8SAfQ3GKV5r0Hb6rtUkjn
         glzGRuy4LYXPHvZfzXxBh8QQ2nnIDm6NdQwiwp8tfrAM6Yix1+8SCbBwDzuAOu6rXYfs
         xmGAlTEvcu1ruFtFFurdt/V19FG6a2/xi/6SuuV0WqGcFIwODdww3KX8bd6emIa8Qp71
         C5GUlXxmt0XKtlmKod4nNRoTdxMvS6J3mh3P2ks8pt8KKVCfrnuU8vRpf3S0gWP1KZw1
         UnmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KLpfJUI7ANkWk2FxmqE86hmO2gLdFqLessgqqc/MMP4=;
        fh=d89ehEq0UX+vwNEnzC+QBpdYit2jbpznlCPfA5N80vk=;
        b=Xjh98SuWnh1bUwE0kGPBEWyfNhTUqE5sl4ntS9cFmy+u+PFC9EyWmpd0QbeKnvFo/2
         0VvKvAsz3wvkwbk3SgVAXygBfcgNXy2iPYDH2eYBiiv/4jXaHk9bef7ZjyGnHPgwSmet
         /g4BZkWy+Cy0hILv/b0QPP8ijKPW16FRNRiYCq91V2R1/MMsiqNyxV3u50HA1pPvYCn5
         lFN1dEcwGjIi92YIlY6OOdi5In2vY/zzXkFrdEw0LZcUjdYPxS5zxu82fWEvOXo6Bexs
         dTboNV493PYgrrRGNJPrAhXi5PUSE5djBeZPF6Am4ha/hDgZPtqemVclnMy0iKJOCZ1p
         ifVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778503898; x=1779108698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLpfJUI7ANkWk2FxmqE86hmO2gLdFqLessgqqc/MMP4=;
        b=ryQVz3zYV0+CeF+DGAB7Nw4RRU3E1Z7OT2kmXsVKg2YfqYNpJZvFoQf8tIBmnjiXrr
         U0lqnmyudnL7iBeGJClhbVqcvpJ8gR/R7N9dT6fNa43Bsay4l9JwwnDOVY9VHH9IEpCH
         hUdceS5CDlXyMX1XDtDw5dUaCx7a8Rfawp9IbKq7R02LNbp4zTKeDIH/3GtHLGIN+tYE
         ZOUokEyD5vzcpXhztVEJRJPh+xNDKsdMgVled1yE8LUJANFFFbnAnw3xQlVgx4nNElcp
         40yZvK9falo2b5NbVc1RBn1VGD2kiv/cMsaTWRpDDRm/fbkCm6bH0eKlZUNRcJBUzWbE
         /fWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778503898; x=1779108698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KLpfJUI7ANkWk2FxmqE86hmO2gLdFqLessgqqc/MMP4=;
        b=bMFdisOMsl7R9SNSax9Qo9nF1zc/oq1OWj1ZQXAHlDs/EV/i4pyYo7xkJ0rcsKXhXu
         6mnkY07ZgTP2akn7GoAh7h39AXrLyttlHG5LlwxyhzNYMQxPCkKg0rSomhjANNws7ROx
         bg9NuGUt69huwiILRZibcR0S7ZFfwFj+hiO+Xf8tKWSUoq7nhGrlBtiSBTiZrhLRdjDr
         3N1/7VvWyf7GuvavZmRUARljDOUWt+W2zEk5SKO0EnFRYZ7wkI+tHk0JHQu6yTB0VWNP
         Hkut/zXWVEg5CpOwE/Y7bQcEiN2hBJgVgt6eVHLQRt9oo94zXr67yBCX/Z1JPzsLch5u
         hm0A==
X-Gm-Message-State: AOJu0YzxbfqWshh22uS7vTm4FG3ofstvbxqWLcnnwOHbdGrpe3KCXSRq
	6BwGmXeykqOpbJKHoZ8b87wE1nfLiH94LrsjG5zNobv8uNTD1d4+BpMpBUfDlPjpkNDIRiYsWBs
	8EgMSo2fUDq9oP2A+GKOEh8UFgxHPFDeW1RoZGU3BNcnr
X-Gm-Gg: Acq92OEFLeMxaARqkt4SfnkKWczCAaTNUNT9htAcP9WnxwDHo41ZVgL3SU5QFN2+obe
	M2UHUE6p5S13wqqzV23AAoYDwRrZEnY7zvHwYea9+3QYR4t1fucL7g5pAunQtaCfsgtSLETOOYE
	QO4rbwZGJA5tGghoCtYr9djLIoVnVlZ7ApLxEw1vcQZwVP9MJbyjGYCF/fXtpTL4mbnug4g7xfn
	DxBoRlxhNUfQjOHyEd2E+rAJPIyTy4W7e5npzt7lGPPpE4PfrX5SFJj0WJyKK43n0I+A/MfE6Cr
	z53ObhvHHa1zOLbxMQ==
X-Received: by 2002:a05:7022:61a:b0:12d:de3f:d845 with SMTP id
 a92af1059eb24-1319cf4b792mr12173986c88.40.1778503898311; Mon, 11 May 2026
 05:51:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321033027.4044119-1-v3rdant.xiang@gmail.com>
 <8509360a-21b8-4d28-8999-67a82796b8b6@163.com> <CAFFJMPyDpKwW9O127JkS1B3bgGGzWPpiw5MqFEbGB6Qpq0nsVQ@mail.gmail.com>
 <20260321074155.6fdb79dc@kernel.org>
In-Reply-To: <20260321074155.6fdb79dc@kernel.org>
From: xw x <v3rdant.xiang@gmail.com>
Date: Mon, 11 May 2026 20:51:25 +0800
X-Gm-Features: AVHnY4L-WffnVMXUV9-yEd9LXW2OghGxZTJ1dYDha2T2hTs72zL35G821GzoLgw
Message-ID: <CAFFJMPyGjiaOAE6uui20fyxHfSVB11C-RWvKrzeHMAi7gUJK8A@mail.gmail.com>
Subject: Re: [PATCH] tls: reject attaching TLS to sockets already in sockmap
To: Jakub Kicinski <kuba@kernel.org>, Jiayuan Chen <mrpre@163.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1CF1E50E7D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286646-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,163.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[v3rdantxiang@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

> Also, could you try running the sockmap_ktls selftest
> (tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c) after applying
> your patch?

I have merged my POC into the test, and it triggered a crash when I
ran `./vmtest.sh -- ./test_progs -t sockmap_ktls` locally.

> FWIW you can open a pull request against this repo, and it will run all
> the sockmap+TLS tests for you: https://github.com/kernel-patches/bpf

Do I need to open a pull request to the BPF repository now? This test
suit will cause a crash.


On Sat, Mar 21, 2026 at 10:41=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Sat, 21 Mar 2026 17:47:07 +0800 xw x wrote:
> > I apologize. I fixed it this way because during my exploitation, I
> > discovered that sk_psock_init checks for the existence of ULP in sk,
> > which led me to believe that disabling sk with TLS from being added to
> > sockmap was expected behavior, and I thought this fix might have the
> > least impact.
> >
> > In fact, the other patch which I believe is a more fundamental
> > solution, is similar to CVE-2025-37756. In
> > `tls_strp_load_anchor_with_queue`,
> > `skb_shinfo(strp->anchor)->frag_list =3D first` acquires a reference to
> > an skb but doesn't own it. This causes a  dangling pointer when other
> > kernel components not specifically adapted to TLS (tcp_disconnect in
> > CVE-2025-37756 and bpt in that vuln) release TLS skbs.
> >
> > I will try to add my test program to
> > tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c so that you can
> > test it and understand the root cause.
>
> FWIW you can open a pull request against this repo, and it will run all
> the sockmap+TLS tests for you: https://github.com/kernel-patches/bpf
>
> reminder: please don't top post on the list

