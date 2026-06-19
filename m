Return-Path: <netdev+bounces-300735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JJhOOtd3NWqjxAYAu9opvQ
	(envelope-from <netdev+bounces-300735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 19:09:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8706A73CC
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 19:09:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b=QMZuoc3p;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300735-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300735-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE6953011061
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 17:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17833C109A;
	Fri, 19 Jun 2026 17:09:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4093E3822AA
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 17:09:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781888979; cv=none; b=LIf/ajLrexVZT+GS1Uqdb1XilBmPIvRiBblzTCEZcK6HjSGV5F5/qWGTMD9MSF+4N+HcP6rju5VVi4Md3EWmtc3VTk/t9DvqG/qtBECduJ+CjDN+eR1pq1vuzLwZsLyNZnk6+Aw7s3yjY/PVTgIWpFnK+ecHIxmm9cnoI/rPE3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781888979; c=relaxed/simple;
	bh=6k9NCq244tVcKlPUICoCvV945KqyAh1Xg2L2evCIIwo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TTnIpLdlBwFG4ZkEV+qyvfhwguIgnZxA1MEr/oh4DaY1csNXqwIQtg3Xqwy+jqQjDjI9Up/7zX8QFjsAD5VzQ3xoEs6WsnHd0njzeMZqyfSZCf6D2fv79y4hqm/lYf/CkDQouRE913FHIuS2tZi4mrnzmTTvO41Xe0ZbskxP3Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QMZuoc3p; arc=none smtp.client-ip=209.85.218.51
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bec43ee8ff0so377837466b.1
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 10:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1781888977; x=1782493777; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fZVUN9gi5V0LCniL2G8xbRaPGKKOWind99J453gh/2Q=;
        b=QMZuoc3p9t35JkrCK19Axvsw13YKuFtO4ARGR/iApFRPxmQUloOtgDy9NrYRIlzWTv
         ZgLhBuqU+0tzDa10oniUch+VMxSxjOd27gcWzh9VKyNQvPUb6xp5rmLjzPFrX7vJWeyR
         R09Zf6RCPNgHEDiAmq2ET+/s8Gh5DPEk+12cipp40VWH/v+k8V60FCMpbB+K9omfLLV8
         nna+51vkUq2UoQp4nlE4ESfVot/CBmfefHe+RVwKDmR3eH0iePTMM9M6mDGJfupRZ6Wm
         Cwt8rXKQeCTMQLghVvV5NrtxXQ91lkRRCyTC/xjIrsXNVQ2QOCYjTOk/NU9ZwEJatMkc
         QaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781888977; x=1782493777;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZVUN9gi5V0LCniL2G8xbRaPGKKOWind99J453gh/2Q=;
        b=bVDvNl8xgosWoj0vVod9kVTP1Vs+OFiGdJoR+qp93K0X26i6nXf4ohPxsoeNaHVwov
         cT+d0SABDeDjv9QePR6rQf3oU6SPg7jUw/V72WtbKzRr1tfw9L3Vnvb8gtIcVuZsZ8E4
         T+ng8CW6xs24PbMj0mj/iauFSS5s1eoI8JXNf28Vdm8hYpoqLc6mQL7hqDv4WvGcYLxf
         leE6bzH4viCo6FmEfPhZzYTr0JGaZIPqWEZIPEbI3pfYlDCA6eRUktVilks/upUq36Jf
         G6J3xa/8uPFiRyc/g1awxepG/S/uTGKtpfViWmY2zzKK+Xyq/H9dieCc9wCD+matUt+u
         3bOg==
X-Gm-Message-State: AOJu0Yx6CN73J/w8qrgmSodOac44e6yr263Kc+YOm1eDqIYGnR58/S3w
	Nb7wLH8lWIq1B5O1g7JzjjhLeNfjwnyfBdp7vyQ5dxd3u9uHEUkoTel3oTyGvMm91QY=
X-Gm-Gg: AfdE7clw/Uui58i1TD9DpzsbMV8CHRZX5ZWMouUEHZxu68xsB7TxTbAUVVm6t7XMMSz
	SIv9x5hpVOnxxEFGXcy2Dgcmgr20iTRhcrCBcRlmmKGo7cXbhOaGnu04/iaMgLnNLTSD5iZF/KR
	P61kVJOwJ6qqNZ2L9bZL5NKsrb3+hWaAWMgU1G6LREqujbP7DO/d+BOR7rkerigKIIrqSI8JD2t
	/XHTL0SGGnjedAgmgZcVX/lEDZ4dImKsYm/WkFacaIhMPHgc9cLMOkdiar4vB7arNOPiApypZnR
	Ib+XIPfD9lzkE1u9GYzEm3BxDBZyTpId5hQdtoroW/ioOMS/9jMf5n0nuSZvg5oFXJHDf9okH3G
	UyZDt21p4SdaS8KVJRXdCpcUlNpRBdwxXKNJIpGoQn9E7YR2yOBuX78+cI166QwuPHK+vQaRM0K
	2vsC5L8voBHGrRdhYJJjq3qfTRHCjMaY7nCbX2+mm7X3lZdqEAqu6+6vwe+A8=
X-Received: by 2002:a17:907:d17:b0:bf7:7d79:e7c0 with SMTP id a640c23a62f3a-c09b8f8f60fmr237382066b.13.1781888976678;
        Fri, 19 Jun 2026 10:09:36 -0700 (PDT)
Received: from cloudflare.com (79.184.207.15.ipv4.supernova.orange.pl. [79.184.207.15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5b304722sm7221666b.0.2026.06.19.10.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 10:09:36 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH net v3 0/2] Drop skb metadata before LWT encapsulation
Date: Fri, 19 Jun 2026 19:09:27 +0200
Message-Id: <20260619-bpf-lwt-drop-skb-metadata-v3-0-71d6a33ab76b@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMd3NWoC/32Oy04DMQxFf6XKGleTdF5lxX9ULBzHYSIyk1GSp
 qBq/p10kGCBxPLa1+f4LhJHx0k8H+4icnHJhaWG09NB0ITLG4MzNQvVqL5p1Qh6teBvGUwMK6R
 3DTNnNJgRzii1IR6aDlnU+zWydR87+yIWzuK1DieXcoifu6/IffWDvrlvog+EHh49rH4bwwyJI
 maaoEiQMNqB8KxPw0j8Qj5cjfUY+Uhh3h1F/XI72f7zclEV13Zj37dsSOnuD27bti/VG/PiJAE
 AAA==
X-Change-ID: 20260428-bpf-lwt-drop-skb-metadata-9a1bdce705ae
To: Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300735-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:martin.lau@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:kernel-team@cloudflare.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid,cloudflare.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B8706A73CC

See description for patch 1.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Changes in v3:
- Clear metadata for non-BPF LWT encaps as well (Sashiko)
- Add selftests for LWT encap + XDP metadata
- Link to v2: https://lore.kernel.org/r/20260514-bpf-lwt-drop-skb-metadata-v2-1-458664edc2b5@cloudflare.com

Changes in v2:
- Clear metadata in bpf_xmit to allow access from tc(x) egress (Daniel)
- Add WARNING snippet to the description
- Link to v1: https://lore.kernel.org/r/20260428-wip-skb-local-storage-from-scratch-v1-1-8f7ca9b378ce@cloudflare.com

---
Jakub Sitnicki (2):
      net: lwtunnel: Drop skb metadata before LWT encapsulation
      selftests/bpf: Add LWT encap tests for skb metadata

 net/core/lwtunnel.c                                |   6 +
 tools/testing/selftests/bpf/config                 |   3 +
 .../bpf/prog_tests/xdp_context_test_run.c          | 175 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 123 +++++++++------
 4 files changed, 255 insertions(+), 52 deletions(-)


