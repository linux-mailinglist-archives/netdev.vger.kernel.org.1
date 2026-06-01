Return-Path: <netdev+bounces-293659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LKGC1NTHWp/YwkAu9opvQ
	(envelope-from <netdev+bounces-293659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:39:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3ECE61C9CF
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5279300734C
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 09:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C67133EB1B;
	Mon,  1 Jun 2026 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrtihC/2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEDD349CD0
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306633; cv=none; b=tIYiU9Q4QvJKNhd6c7aB76ll7qtVn0deCTPi8iqeXfi9UwtdWzC+v32RL2hOB0Ithv4eYEDNB38TdG2J1o3iOkzzQfBAjbsY3fUmP7v9LUcoVdakFguDBzku3+iKcOHVDiEmi1mhWJoDN4iIQtNSnylz2HMvaGIklKyFyHmF0m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306633; c=relaxed/simple;
	bh=E887M+7PT0Puyz+jFE2Ef0lCMzJk4CHvC5bqfhSZhQM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h14hanhgdzEhPrBQGg7IrDbY7MkZGmqknZ8mNWatt03HxGO5jyloAwzBPBNpWsGvrAtM2hkGtSwgAnnMf92SIX9ls8DqyC3WdpyoIDEBfZP+3KFrst1YFuPTjYSrqdE6GNvlgjSKwaf0tdXxzYEcLN3rbrtZTY6IlxJJs4IRFjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrtihC/2; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36d98c9b596so709472a91.3
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 02:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780306631; x=1780911431; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zp4NhxOeSbWU1mM8p9fVkrdL+x7FYGH77zoCEYu+vNs=;
        b=BrtihC/2pFl/mFEki8BzvQYtZWFbFhG2YoyPOIiKrSYyra7EOCty3/k1Z8ZG+l2G6G
         kKAxoFkdvyovFY95tWoOyLowmZJJ6K8amXsTG3XZZ3A9YzFayih809HiO3dxcGHoKIXS
         qoyvciXK/dZs12zWLCvRTFSKBjT52pukkK9838NAl2BMfiXzZtcnCUKa2sAnhlGE8pZp
         sXRN3nHmjq9V1Pvs4l1qQxz3uxQETcl0PdhZH5niNebp1eAhYVpeq36Q0zB3UiuqPkMS
         FaIr5QtRG9wy0m1Q0ZjPhQg99e+p1cvuJyjmYhlAkw9XZTO5mJAP0VrnZoTuTKtYdqT9
         ICcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780306631; x=1780911431;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zp4NhxOeSbWU1mM8p9fVkrdL+x7FYGH77zoCEYu+vNs=;
        b=jjvkWUx8gW8xYkZcGDsYvRIEvhi0hC4SVyxt2gX5x6gLviwbnwKXr/fMYbJ19owyml
         l9N4b+Nq07SpEOylWoXp0H8JScwkQ06eF7ZD+8zT0wAeO9r4SOkvgE+DaU1gY6D7T5/D
         TCGmfN8DP2abrIfiv4ee4Zbadci/+bPUtlIPEFhTiNr1kkzXBeihUFEuWUMz/K3RvWnV
         IL3EWjXCnBOeZWtuoCLBpdW+ZbOVedsUl7H5SW+pvlpsduDPCyhnrVfObXfrsRS5Gkby
         NgzzILZtesSF91WBQu1tFk0BBfwMQL1Kd3XEt+XEKtWHMpfERvH3jWvBrCsxr+QYTgjA
         3Dmg==
X-Gm-Message-State: AOJu0Yx1oAGRk3dQxSDo44ez9f3575W/9DvMbVUH1+BBQZmlmoLpOf39
	7X6V+8eoAzA3ba9p3Zv0dkXmFkoGVEtMasRWSa8fEaIh5Yq03JCvxncb
X-Gm-Gg: Acq92OHS9HW53bRW9heE6aXRkrzwxpwV0T71H0uZM/Vf/+ekxPXYHOyfGde79YO7+He
	FDm3g4AfW01+g8OJ6+95QU86VKGabcmIDY1yYwhfuo8HuPdfXPHN6V6WlUm4XUfecmmB1legiU9
	+JK+sIg88iDoPAhBbLqZXPd1hErTgA1iM+PRT5aUaeoOuW2D6hR5U3jxJ8soYEzM4RVI8E3NxhG
	zWdvj/hWayEPUYo9nmBMDiW+MOyZCPMKIHjPmBmU44eq+KH6p3lsSMs58xLSlFZbZBRsUFopd+t
	Af+WxEJg41fzW4xvWLn75Bt+xeI6lyJsUKmCzNPqZj53vNDRrxp5TrcCSAk+yFxSRlk51OxYgTu
	kzuFDX5Vw4Meez7xZkcWxtWCfx3gUa3zpJ94UK9wtSpLo8UlPTOh16yutHxoUFMaOWJQzLrIsAv
	0NvLG22Ht2KfSFzLkGQle5LAw0h6Y2lj6/ysCRet9h1JcDfnPCDDKd0LvWlxjpJCRB
X-Received: by 2002:a05:6a20:2d13:b0:3aa:f9cb:d43e with SMTP id adf61e73a8af0-3b427eb2dfdmr11140342637.18.1780306631332;
        Mon, 01 Jun 2026 02:37:11 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8423828159esm5528210b3a.35.2026.06.01.02.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:37:10 -0700 (PDT)
Date: Mon, 1 Jun 2026 18:37:07 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net] inet: frags: fix use-after-free caused by the
 fqdir_pre_exit() flush
Message-ID: <ah1Sw2g-I89BRRiT@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293659-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A3ECE61C9CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On netns teardown, fqdir_pre_exit() walks the fqdir rhashtable and
flushes every fragment queue that is not yet complete using
inet_frag_queue_flush(). That helper frees all the skbs queued on the
fragment queue but does not set INET_FRAG_COMPLETE, and leaves
q->fragments_tail and q->last_run_head pointing at the freed skbs.
The queue itself stays in the rhashtable.

fqdir_pre_exit() first lowers high_thresh to 0 to stop new queue lookups,
but it cannot stop a fragment that already obtained the queue through
inet_frag_find() earlier and stalled just before taking the queue lock.
Once that fragment resumes after the flush and takes the queue lock,
it passes the INET_FRAG_COMPLETE check and then dereferences the freed
fragments_tail. inet_frag_queue_insert() reads FRAG_CB() and ->len of
that pointer and, on the append path, writes ->next_frag, causing a
slab use-after-free. IPv6, nf_conntrack_reasm6 and 6lowpan reassembly
share the same flush path and are affected as well.

Mark the queue complete and reset its remaining pointers under the same
lock right after the flush. With INET_FRAG_COMPLETE set, the insert in
each reassembly path bails out at its check as soon as it takes the
queue lock and no longer accesses the freed fragments_tail.

Fixes: 006a5035b495 ("inet: frags: flush pending skbs in fqdir_pre_exit()")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/ipv4/inet_fragment.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 393770920abd..d532f6182c8a 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -243,8 +243,13 @@ void fqdir_pre_exit(struct fqdir *fqdir)
 			continue;
 		}
 		spin_lock_bh(&fq->lock);
-		if (!(fq->flags & INET_FRAG_COMPLETE))
+		if (!(fq->flags & INET_FRAG_COMPLETE)) {
 			inet_frag_queue_flush(fq, 0);
+			fq->flags |= INET_FRAG_COMPLETE;
+			fq->rb_fragments = RB_ROOT;
+			fq->fragments_tail = NULL;
+			fq->last_run_head = NULL;
+		}
 		spin_unlock_bh(&fq->lock);
 	}
 
-- 
2.43.0


