Return-Path: <netdev+bounces-301215-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lFv1ADm3OWpjwgcAu9opvQ
	(envelope-from <netdev+bounces-301215-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 00:29:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF396B2A01
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 00:29:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Jlei4Ipy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301215-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301215-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8422D304D72F
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 22:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D88837C923;
	Mon, 22 Jun 2026 22:28:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DFC37BE8D
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 22:28:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782167300; cv=none; b=mNli0FHSFo114RZ6B1D4Vilo1oDWQL1TcgtGyXG2Yk4BixlZJwFTcPTosRrCs0JZbJSO8tEiIgq24QZeq59pdljVIHHg1qruURjKKZ2/1TUKRDcwztp3uEjHf8nnMyrrRaRftuD+c+qd7muVOpWjQ3lPhlg73ilH0E0mBGxEYUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782167300; c=relaxed/simple;
	bh=gry1uQqAa0tANDVkHjkuPNbr5jKjvV245FrhWBFwAuQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KMfu7SxM2zbOUwrAGJdzWQhXJ5bIBmrfKXMM/l4fNrAm0r6UVtlm+VOZGYopHQyg5O/NaMxAGcnWhxJsQAKZtJSynxf5/6DZ6JA6WQJThNKGxta8HaIVIHNfwOXC2aEe6OJvR/c/pUOkVUxdkKEA5OzABdln39Cri+saWZ4vby0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jlei4Ipy; arc=none smtp.client-ip=209.85.210.201
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-845438fbd9cso3622921b3a.2
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 15:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782167298; x=1782772098; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AEqk/nI9MwbHFJChA3EKe7XfZWAt05hBZjjNOpuqeXY=;
        b=Jlei4IpyQ3goNhDa9zVqdgLsY1t+VD5eYju0ZpbPO8QuSAPeurqxXDRSY7iV+6IIhQ
         sdmAeeMfAc1tsz1nq43TlRUXhcYiRH7HOKiiQG3oI5upK9DsmVGsalIxWhymw/qwZFKy
         Q1rBTeOmuhHuuA5dkg2nSH2vA1NzAfCT4x7hESSPUQhpFhQlHJIOlDBqne0RTfCKyVff
         h/DRTFgs3YSeU/59ub8RylBNeotHT7vdVBnIcqwsvvFVALjcESoiCFarcp3igRgwzPcR
         vZv3Kt6rimbn3ZOM4xJ1sPdETWRCJ3ifqEeN4bts96xQ621GHB2k1OexF/gbpHJHtxGZ
         GoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782167298; x=1782772098;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEqk/nI9MwbHFJChA3EKe7XfZWAt05hBZjjNOpuqeXY=;
        b=GgQ+z5IEawV6C+KmoCLV3UsHJ2dqvBZjY1JFK78PIys0UuG9vdJpENExbKk5UAND4K
         CYPUhDg9VYm4Cstje4a27Gmzz2JQ0MIjeqdBUUSQEcCE2zg9fXgQ9QoAsSCWe6f5z9eJ
         2i4eE338T3QbpK9f5kNjWItijTCoLWFDpE6zXuFp7025kjVVSb383rWxYyaGe7A2kRTy
         dd3bwGd4IyhBwWJBY3Lt+Qutrr7oWc/kdATz6qXxyDdlh94lGCQ5GbuwRC9nrlgJSege
         hCgb9Rh0cOa2la5/Jzge0CWIVdPqDpbEJj/xv+2ZnmLz/mE1nIjLFaXL8d/rCaG75sUd
         Sllg==
X-Gm-Message-State: AOJu0YwpQSsphxOCkB5XpPtuMYYAFhR+5RFHTQkxgcbtqKOzY0U1E5Ol
	szZURHcTmvmXdefVXD74199IsPwFsW1NBUqZ2xwBTClD0/KRtCzMlZOxiLCWI0BMMuiOp0dXRSx
	fk61hqpzPf677oE2+pvPsqbpzsQg52ZkRJJW8cY/hzgXv3kDlYGNYfKY09tb6KKLpwT2uYnFq1M
	OlQy/iZ/VNvShUNC2KLOX4uoQiOj7gjoA=
X-Received: from pfn22.prod.google.com ([2002:a05:6a00:a216:b0:842:3963:226a])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:806:b0:845:41e4:3faa
 with SMTP id d2e1a72fcca58-845508bb8a9mr17027325b3a.31.1782167297664; Mon, 22
 Jun 2026 15:28:17 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:27:56 +0000
In-Reply-To: <20260622222757.2130402-1-tavip@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260622222757.2130402-1-tavip@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260622222757.2130402-2-tavip@google.com>
Subject: [PATCH net v3 1/2] iov_iter: export iov_iter_restore
From: Octavian Purdila <tavip@google.com>
To: netdev@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	kvm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Jens Axboe <axboe@kernel.dk>, Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:viro@zeniv.linux.org.uk,m:akpm@linux-foundation.org,m:avkrasnov@salutedevices.com,m:davem@davemloft.net,m:edumazet@google.com,m:eperezma@redhat.com,m:kuba@kernel.org,m:jasowang@redhat.com,m:kvm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mst@redhat.com,m:pabeni@redhat.com,m:horms@kernel.org,m:stefanha@redhat.com,m:sgarzare@redhat.com,m:virtualization@lists.linux.dev,m:xuanzhuo@linux.alibaba.com,m:axboe@kernel.dk,m:tavip@google.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tavip@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301215-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tavip@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8FF396B2A01

Export iov_iter_restore so that it can be used by modules.

This is needed by the virtio vsock transport (which can be built as a
module) to restore the msg_iter state when transmission fails.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Octavian Purdila <tavip@google.com>
---
 lib/iov_iter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 273919b161617..f5df63961fb24 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1491,6 +1491,7 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
 		i->__iov -= state->nr_segs - i->nr_segs;
 	i->nr_segs = state->nr_segs;
 }
+EXPORT_SYMBOL_GPL(iov_iter_restore);
 
 /*
  * Extract a list of contiguous pages from an ITER_FOLIOQ iterator.  This does
-- 
2.55.0.rc0.799.gd6f94ed593-goog


