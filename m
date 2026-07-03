Return-Path: <netdev+bounces-304598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gW1ECqffR2pjgwAAu9opvQ
	(envelope-from <netdev+bounces-304598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:13:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7657042E2
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:13:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=coralogix.com header.s=google header.b=OGPXOgjn;
	dmarc=pass (policy=reject) header.from=coralogix.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304598-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304598-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7B41304D255
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 16:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAE82F1FDE;
	Fri,  3 Jul 2026 16:10:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C1E265CD9
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 16:10:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783095030; cv=pass; b=dqJJ4sCQxdGixek0tWY2nGsA1R4bxWHw/cKYXKYsClTeUyoY85/2qSKp+C1xNdLT7o0OxMW64ijjwAd4+aieYmlkGQpDb9S8O/LysnLRiU0fwWBYGX5j2EKr3MfkAZt/xtBaMhmpZcWT7f5h9uMoBF6ytarVCBkwOGa78QPMEYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783095030; c=relaxed/simple;
	bh=xT/W1+CiZkDKLa+FnudJAe36lqY2hX16tIX2AHkVVoA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=H+FlnYMqdG5xvrB6Mx/UaklEJIO2ft5oPsxIweqq/URyhrNpznuhULdNcr18+mZNuLOQ55jkYoQ0bYDBHyHGIAdIzGaUG53/KS33ifgRfB3o+Vy66h6R2qBnnbLmgOx3Qct4VSX4ZQFtNslLZqoM3QYdRp3Q0TJAfR+8+6T7qkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coralogix.com; spf=pass smtp.mailfrom=coralogix.com; dkim=pass (2048-bit key) header.d=coralogix.com header.i=@coralogix.com header.b=OGPXOgjn; arc=pass smtp.client-ip=209.85.221.174
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5bbc6c99b5cso187348e0c.1
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 09:10:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783095028; cv=none;
        d=google.com; s=arc-20260327;
        b=TBSb2BdorjPAGY35P5CGw24Hu8ucG0Kiug36WHmql60H3IpGDSU1V7oN8wZuD+XbK8
         TTnoLSI+DZr6rvMy5NnB+kDJtQPBF4GuJtdywmiNWtDPURDzK0TliD8VtXgh/Q6POD/D
         ZiQrx0Mv+NgFSBu974IIJjrFamVOQa3FJ5M2EzLDNmjiGJxnVQD0ZuPLAlB9AQUuNWkg
         kJRlcn0PHjXWZF+tjo2WQ706TEEDM0aeI+O5MkBUVr72Ley84qAsHuJF4k/T8HseuA9Y
         XynnpxhXuHH4Vx+jUw/KfwILNet489za/JXifnxaP56PAT8Hf+O0l3OEccj1JyarB7bE
         EdGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=gm26QgpnvRtdkKGeFLWfs6QgocR5OAy7gnfY6eH1ivM=;
        fh=qp7E4f5n0u6cegU9kZtEgcrF+sB11K4/mgAjvmRT6S8=;
        b=YRFeqjLcjYjHy5j42ApC2BZPl5JZgTwo8WqV8xs0pr7FQg+pzEPhMKqzf+uN1qJpn9
         P3ZG6vJsxFamux4z7UPEypX+TeZnUXVD4mmKPGueLPjRNVCCPxGgitytwkGdI/dkBonZ
         HpZNPOCeoc7+H6yI9Xif2w2dcqT5Y9L2QR44NPzg8ZjOX6tqDD3JWx3x2Xpi1FFc6An7
         FkwtIDGfToVsKiprzFGOJ6MNBbUUt7d5riXcSGu5ZoI3XZuxO8eJJgkiFQyy0MVVFAC4
         EH3hJb35HaRWq7x1aNKaeH3Zdc7MMkzhGlR05DtOcwf3brdGwgrQmPrKS1RzdzkyTL2p
         FH7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coralogix.com; s=google; t=1783095028; x=1783699828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gm26QgpnvRtdkKGeFLWfs6QgocR5OAy7gnfY6eH1ivM=;
        b=OGPXOgjn1pf5lz6XfYUA6oJtbp+WaHDf/ry2adx3Wd/NQL21ZXABVNY3kcqFqWE+l3
         V3oeAONwSqw0yvynZLdbHjU25A89/4NS7vTgwjL39/J0FGHvO8NgbY7NL8XtpnX4jgVG
         MEC6v+uEo2Vw42nxgE6bkYCCUiMv5s+vi2KMHZPpR5m/adnkbFmyLvmW4QClk6YgAJys
         SWivxiSYsQcKWrEWP2jvuj413WImJ93cRq6H5coB4gHJHg8HZ1/nefqkaCLHpaHy3xTN
         FoTGpCmOBNQ1OL0c9CUMM9BgHd8N5eGE6nGGyMeX8kCwv9v7uce1/BIf4DklDfz8FATU
         ayTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783095028; x=1783699828;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gm26QgpnvRtdkKGeFLWfs6QgocR5OAy7gnfY6eH1ivM=;
        b=LCpYskTublpoHWvTVOpram6H+Cd4J1+mNkozCN3lFFF0zp2K0EDI8o/jMlCnnKYJW6
         nlluZWe+bW6eu2M0AjjlFkwydUn8zLYLQiBbu+K84AEQfsiKotZ4Ag4sdR9vC3R38Jt/
         vyZBoQFAdnFKZyS8xWNedODs32g+o3dEcOM7eykKncHEfUetcM8YnVDJ/Q5o4MsIKSwT
         Okh8ULzlaeZneUmQ6pdzvDSIllM69ixCCKLl/v78+NvBSvks7PmY33Mz6vWOUiCfC6Ao
         qZ/NWJMhbkW4Yi+j8Fx38ogmITKK/2m88Tiw0rUNCW+YiQhFIygw3h9paQ5UCE+cIplY
         jJ2A==
X-Gm-Message-State: AOJu0YyGMg8ZeL8FInWsAgVUMXTQBC52dTIut29etg0Z5IA6Dri9Y7J+
	TXR2iyuCbC9Ngko48H2iTshcY5lYkxFWHLTvuUd6kunDEQq9ad5TBjgL+gr2bqImtjII9bIwd4H
	LFTNK1tMIpsZN9dStofaQHv2Sc3xJ24A5lgIOWmFEXQ==
X-Gm-Gg: AfdE7cnu+905u/VZ5IVtSiXK5tuwFXbwns+bwPt2abfvpMX7R348lYdhInfXuLFXnG3
	4tdIItjHT5LjzNBFh5oqm0A5NMeMzmlNgQ18M7aDI31qaL47Lq6dPsHAYdbszf3NU5oFvbbF5Bl
	5IRXt9rCBpRtuqA8rtA5xolsQDd/AYbMmHAz4BRcyCBNNzoHGy6jHW0FuFGZs+TSAwGI8SkENYw
	aV5bqgviXfztiEEUYszMditUJXCDAwEftX5FT5sgQR8sls4dHRl47Uhy4t+1hpF1V2HAbccEA==
X-Received: by 2002:a05:6122:4892:b0:5a4:ac74:f5ba with SMTP id
 71dfb90a1353d-5be1025e3ccmr107911e0c.11.1783095028060; Fri, 03 Jul 2026
 09:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mattia Meleleo <mattia.meleleo@coralogix.com>
Date: Fri, 3 Jul 2026 18:10:16 +0200
X-Gm-Features: AVVi8CeAWA_f68Kki9hfUbY5C4CtuCmcJbPuxzmZ-mdiwT2SUSQ6DXPA9ual2KM
Message-ID: <CAOvpEWN6xgFx4GWFnnWLGCB+_1auDcAZPYPSv1PDu3UfXkcriw@mail.gmail.com>
Subject: bpf, sockmap: FIONREAD returns 0 for TCP sockets in a sockmap without
 a verdict program
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "jakub@cloudflare.com" <jakub@cloudflare.com>, jiayuan.chen@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[coralogix.com,reject];
	R_DKIM_ALLOW(-0.20)[coralogix.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[mattia.meleleo@coralogix.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304598-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[coralogix.com:+];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mattia.meleleo@coralogix.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,cloudflare.com,linux.dev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,coralogix.com:from_mime,coralogix.com:dkim,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A7657042E2

Hi,

in OpenTelemetry eBPF instrumentation we use a sockhash to track
outgoing TCP sockets for trace context propagation. Sockets are added
from a sock_ops program, and the map only has an sk_msg program
attached on the egress side - there is no ingress verdict program.

Since commit 929e30f93125 ("bpf, sockmap: Fix FIONREAD for sockmap"),
ioctl(FIONREAD) returns 0 for these sockets even though read() returns
data. tcp_bpf_ioctl() answers from psock->msg_tot_len, which only
accounts for bytes in ingress_msg. Without a verdict program, data
never lands there: it stays in sk_receive_queue and is read through
the tcp_bpf_recvmsg() fallback, so FIONREAD always reports 0.

The commit message explains that sk_receive_queue is intentionally not
counted because a verdict program may redirect or drop its contents.
Without a verdict program, however, all of that data is readable, and
applications that use FIONREAD to size their reads (nginx, Java, .NET)
hang or truncate transfers once their sockets are in the map.

Observed on mainline and on 6.12.75+, 6.6.128+, 6.18.14+.

Reproducer: https://github.com/mmat11/fionread-repro

  pre-insert     FIONREAD=4096 (expect 4096) OK
  in-sockhash    FIONREAD=0 (expect 4096) BROKEN
  post-delete    FIONREAD=4096 (expect 4096) OK

Is this intended for psocks without a verdict program? If not, would
falling back to tcp_inq() (plus msg_tot_len) in that case be an
acceptable fix? Happy to send a patch and test it.

Thanks,
Mattia

