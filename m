Return-Path: <netdev+bounces-268283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKvbNiJzuGn5dgEAu9opvQ
	(envelope-from <netdev+bounces-268283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:16:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E192A0AB6
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94383318F966
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 21:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706D1364045;
	Mon, 16 Mar 2026 21:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="J+Mkw5Kc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A10436403A
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773695481; cv=none; b=cgGoBdk+BnwCBkxXoTeIws22WrQNTPr9Z0EyYrZ9YeXNgWamhQDxkd8Trv1sAJZT1oFBxLm359cNq+/5cDTvrmrghkn4M8+cUbWxooDVJMJNx2bjMsm125MGYRV4Kyhd4HhQKMKfJL5h4K6Ys2T20WIoDZQ7hp9ZVB6xTy1wI1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773695481; c=relaxed/simple;
	bh=nUzyV/sgxUcx6TkvjUDR3GCaGMPejUOAqwx81sZhudg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VnMTMkS9sYtHG++qpUgRRGSx/VB6iaHEDMC0FYaiaNrmVbkIATwSwa2muDDFzzv0pX1lSZ/wlGy7VTtHkQFbxnBGiH7n105JUGKXXiI/OVci8QZdz9fiiVTIgXlYDxOxEnKM7f76cUodg7V1WI1+nOj8Xi//aURdpJXavKkIQ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=J+Mkw5Kc; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-89c4f7f8650so24049076d6.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 14:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773695479; x=1774300279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beYXYan8OUOVRGrpxRQNOCrxMs2idVYFC+QNSvXV7fA=;
        b=J+Mkw5KcbaT6gJqeG3GkhIcDTAw8oTv3d2eZ1kMdkKYXH6p+Htlk/4kprHwbu2anMB
         /uXyWCbhDlkth9lutHtjjhRy9SE5EaqfQ6nvIo7xlyVnAj/lExue/X6F4eFvyhvQeSkh
         +aYeWIZjaenjjdpc03CmlATvD8jqQc1ZDElFvbvmNNV0t+1w9D5vWMWZAeTVQIAa4akA
         K7NKoqtftAxQ/71AMZEAfynxxOnhhyBEyjatXHjwOOMpM0wXas5oblVVgYI1mPl8qwgT
         k5apYUglulS1Kw8hZPEa4Vq4lJx5qcLsTJljshaccqEc1Bc+D6TZc8lPIaFN7KhRtfcL
         6WvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773695479; x=1774300279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=beYXYan8OUOVRGrpxRQNOCrxMs2idVYFC+QNSvXV7fA=;
        b=EGbPhN7E59xDHN3tXxCGDS4ne76xTsclzdu3VWgfgheWZyisu9MOL5MTbXpaCbMQ41
         mW2WiKVP22EoXB9k9rgEjLigQWsZaOAnOchMH1dDft6F4bnhTzoJ5J3mpaJFlbShdQcB
         lVQ/uSZyWr9pNtokuFxDQ0o5GTWq/COLv/d3Zfluzfm410Kc9r9xygtzYXBlqfFCaaPV
         1qSPKIba/E/KNgtwEb0o4sIYOLcfBNR8dWFvjpHYFelugNm1+VH90AKJQZjv6+ibErqz
         pkUf5SWOm7RH+HgOVVgWjkc7I+SKUp7Olxezbjv59U37M36U99J9UCXwdUWWgKsDOH4O
         dDFw==
X-Gm-Message-State: AOJu0YytuDvemJ56jpX3VSJxi8444Bc88M/PtMy7F9wD57rRQE2TWT2M
	2Pjm1TO4HKmk7diYQfq8e28YRGUJiPKYSsp9kj/XBdyqH6D8vW9s/TY5qLAPf/IDqCYBVUcX9ZA
	bS+U=
X-Gm-Gg: ATEYQzwbOPJdoHqq5/C9VzLNct4MaEIA34HXAbYIlZIhf8qSVaUk0xo9WtlZbKebM9B
	TXtngbyUrU0+Te3olq9PIx0ax0L5EqisnByRD/La6cXwearIggBe0Ems4BYJNl5U/Tr5QzcplEr
	iClE779JwmZs11Eq5kvtiTRPTUQeMQdaT1hSLXoKlEREvrOQiwYM4nR+ZY4hdj3BBMHwl15vZKX
	7Z1UjX4t+xX8lWNKTGbKOmSw04zXkTn10hh1EoKZCeIUEABSjMpM++z9irr/fWVHMlTNFjxt4kY
	FDbDkD2Xmx3tI7G6GLm/7maOMv2rkJQPzT5E9UO+y7SgQHWtAAVXPMalSAM5haCtlES3rV+i70b
	FcPvfM7K3SVrv8Jk3SNyYzJkvFKcl/k7LqRnWjhBUxGpORD9LPAmsFMqhgCTCpr8ZQ/jZ3MRYaI
	5ydb0JUGORpV2UPpgbBYMevVM=
X-Received: by 2002:a05:6214:5284:b0:89c:5c9f:d1cb with SMTP id 6a1803df08f44-89c5c9feb5dmr31874666d6.58.1773695478733;
        Mon, 16 Mar 2026 14:11:18 -0700 (PDT)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c53374573sm27356266d6.7.2026.03.16.14.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:11:17 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	stephen@networkplumber.org,
	victor@mojatatu.com,
	will@willsroot.io,
	xmei5@asu.edu,
	pctammela@mojatatu.com,
	savy@syst3mfailure.io,
	kuniyu@google.com,
	toke@toke.dk,
	willemdebruijnkernel@gmail.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v2 5/6] net/sched: fix packet loop on netem when duplicate is on
Date: Mon, 16 Mar 2026 17:10:51 -0400
Message-Id: <20260316211052.332383-6-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316211052.332383-1-jhs@mojatatu.com>
References: <20260316211052.332383-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268283-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,mojatatu.com,willsroot.io,asu.edu,syst3mfailure.io,toke.dk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,mojatatu.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu-com.20230601.gappssmtp.com:dkim,syst3mfailure.io:email,willsroot.io:email]
X-Rspamd-Queue-Id: 54E192A0AB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As stated by William [1]:

"netem_enqueue's duplication prevention logic breaks when a netem
resides in a qdisc tree with other netems - this can lead to a
soft lockup and OOM loop in netem_dequeue, as seen in [2].
Ensure that a duplicating netem cannot exist in a tree with other
netems."

In this patch, we use the first approach suggested in [1] (the skb
ttl field) to detect and stop a possible netem duplicate infinite loop.

[1] https://lore.kernel.org/netdev/20250708164141.875402-1-will@willsroot.io/
[2] https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io/

Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
Reported-by: William Liu <will@willsroot.io>
Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
Closes: https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io/
Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_netem.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 0ccf74a9cb82..6949d1b7867a 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -461,7 +461,8 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	skb->prev = NULL;
 
 	/* Random duplication */
-	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
+	if (q->duplicate && !skb->ttl &&
+	    q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
 		++count;
 
 	/* Drop packet? */
@@ -539,11 +540,9 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	 */
 	if (skb2) {
 		struct Qdisc *rootq = qdisc_root_bh(sch);
-		u32 dupsave = q->duplicate; /* prevent duplicating a dup... */
 
-		q->duplicate = 0;
+		skb2->ttl++; /* prevent duplicating a dup... */
 		rootq->enqueue(skb2, rootq, to_free);
-		q->duplicate = dupsave;
 		skb2 = NULL;
 	}
 
-- 
2.34.1


