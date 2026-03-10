Return-Path: <netdev+bounces-266289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDX+L25gsGloigIAu9opvQ
	(envelope-from <netdev+bounces-266289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:18:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5702A25652F
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BDD3C30041DC
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE60D286413;
	Tue, 10 Mar 2026 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0uV5sFm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EA9261B9E
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773166699; cv=none; b=cFW36SUrKFUXLAG24hXAcLi8ZeBdZUHrtHInmbLMtj+UJq/kB8JwuDTpZEMSuWEgVFw6/VefN+OZRw+WmWepeVb/CSj5OtkvaXzfhc1DMOw2DkU5LwklH9Ry6Og8lM7IAQnTXIzwvS7A0NWVRs/X2wMFgHcvpW55LN2MOouZxCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773166699; c=relaxed/simple;
	bh=S0NmHKlyhSFgA8uUlP72LP4EgiMjzY4mLhz3uLdZL2A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cT147R9domIKR/K8jwHiz9jJrcig8YhxgFJe25sTQo9BW0iNE9Jpip/UNZlbCXto6igbgFYikaenfGwUE9N7ELdrC4jc0h8D4PQ2rPgdy7TKxM7INeHoXQXG+mpiIwciYQV/Z0X8q5lCIUAbW4K/TDlqMCg15xiBw3cwZfTzSIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0uV5sFm; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ab39b111b9so59311275ad.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 11:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773166698; x=1773771498; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rocOqQ0GGRQ2FFD3SaYh+qh681ItNUFgfBnjMmi0fOY=;
        b=C0uV5sFmcDnoZT2bhmpU6TDJQmUBOndQ/Gjd4Kfh35/3pb0TwLU2XLrm/uQMsCUYoR
         ZAi2/R1vZX1HGSlyBi9o2/LlkWtn1CojPHe3y60koEssXpeC9OFcalp6OhsnKo/CSnuU
         bdpDT/clLp/4/TXhJZ3o52pQIvdRWK1zpNaB28saEbqrFC1wWQxYZodSphQ7mJP6Ooaw
         cbql0ZT2r85++SEqCX+rxT9PaFMGKDkobY0S7wO3f6VXLYCBoOYBPtelEl2tH1w60osy
         t2vGnI2KqXc3XAVczLP7//rcPh5QC53Vv32yn/rCZkkI69gFCywMUwu5j6jXTMeVtEkz
         0cjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773166698; x=1773771498;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rocOqQ0GGRQ2FFD3SaYh+qh681ItNUFgfBnjMmi0fOY=;
        b=P2gXpxhjDdC66VFh/fc+ihueYY9JsSTzpx2cEpfYZdlbX+EBOwit9YvdAZAVfLZa5v
         bpyH+OBvgJ3XpEG2lfU2bwEV6fgA44/v8oJUxThQ0/PEY0U1QhdWw0sv6pxOd6P1odju
         IIMSUmA7Jobyc4EYzszXYTip7cAs8mFvyF/mWKslARDC80Ys361soGsDFatrf36HlrWy
         mieMDNWilfgWBwLPVNcNTkH4MaHHlr1yRqwTZvGXjGbSst0ukqMwHpTGM4ipVRmkhj9F
         fCmJE9dNffTNnfYlosW+7xD3Hd8TUMG1YZFX1NiHCLuK69zysLf13yn5wmZtdYgOYEOj
         TCLg==
X-Forwarded-Encrypted: i=1; AJvYcCXBRv+UsuG0QTLSF0ye/4y4lBKAlEQuXrxvtaGi5U9chX/bu7D25Xe9RWbz4b49ZWTvkD7HoV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPFkdh7iAS/M1GVWur8a32xVb/1OoYuqmtsXPT6H2KGq7Igk7q
	ajOLoEfQPwAC5IMC9wMqWJFu1fNqpL5TjI9olKShnX4cXkGU4ZEzj3U7
X-Gm-Gg: ATEYQzyh74DpG2LlHWSH91uwZz/ggJj5HOpMvUrKnrtkRYnm431ZbGVTrVnz6myrkDA
	RaH+iJ1PArU2Me8K5GcfGmXJC2J2yaouQSTkw+xnn/mGCALG1tCAcRkNL/tv3ay7fdvakjVoLYf
	8SOcKIrLcXzijveDGQlfTNyAygmjE8kkv/C/c0ARh97Gtfova9OscB4zcLAG4BsAw4BoWa9IO2Y
	sHM9s7NsKxMyWWeO3PIfewSmewE27p52oOPsRmaoF6BxSNA97o6s90xsmCdvx+T3IByVVZITyV4
	gwp5dqMKvXEM0a5JgqGMRi0ff8REbbEhj3ZwV2Mgu+wBU+sDPXcihFK0usWTFUEz6zLxDfm358i
	YmrGtpYLizsG5thrxPf1sJSl+SmLu/dUUBqr1N1/HLWVl6V8FfUM7KSSAarhxUAFaPWGg3H5mqu
	hJDRX+OQkrokwu0GDEx40gPWH6Dq6WtY45+EE4jfB2GA==
X-Received: by 2002:a17:903:1cd:b0:2ae:62c8:771a with SMTP id d9443c01a7336-2ae8241e451mr165342805ad.5.1773166697905;
        Tue, 10 Mar 2026 11:18:17 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aea4eed00fsm51159255ad.80.2026.03.10.11.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 11:18:17 -0700 (PDT)
Date: Wed, 11 Mar 2026 03:18:09 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net] bridge: cfm: Fix race condition in peer_mep deletion
Message-ID: <abBgYT5K_FI9rD1a@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 5702A25652F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266289-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

When a peer MEP is being deleted, cancel_delayed_work_sync() is called
on ccm_rx_dwork before freeing. However, br_cfm_frame_rx() runs in
softirq context under rcu_read_lock (without RTNL) and can re-schedule
ccm_rx_dwork via ccm_rx_timer_start() between cancel_delayed_work_sync()
returning and kfree_rcu() being called.

The following is a simple race scenario:

           cpu0                                     cpu1

mep_delete_implementation()
  cancel_delayed_work_sync(ccm_rx_dwork);
                                           br_cfm_frame_rx()
                                             // peer_mep still in hlist
                                             if (peer_mep->ccm_defect)
                                               ccm_rx_timer_start()
                                                 queue_delayed_work(ccm_rx_dwork)
  hlist_del_rcu(&peer_mep->head);
  kfree_rcu(peer_mep, rcu);
                                           ccm_rx_work_expired()
                                             // on freed peer_mep

To prevent this, cancel_delayed_work_sync() is replaced with
disable_delayed_work_sync() in both peer MEP deletion paths, so
that subsequent queue_delayed_work() calls from br_cfm_frame_rx()
are silently rejected.

The cc_peer_disable() helper retains cancel_delayed_work_sync()
because it is also used for the CC enable/disable toggle path where
the work must remain re-schedulable.

Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM frame RX added.")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/bridge/br_cfm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
index 2c70fe47de38..118c7ea48c35 100644
--- a/net/bridge/br_cfm.c
+++ b/net/bridge/br_cfm.c
@@ -576,7 +576,7 @@ static void mep_delete_implementation(struct net_bridge *br,
 
 	/* Empty and free peer MEP list */
 	hlist_for_each_entry_safe(peer_mep, n_store, &mep->peer_mep_list, head) {
-		cancel_delayed_work_sync(&peer_mep->ccm_rx_dwork);
+		disable_delayed_work_sync(&peer_mep->ccm_rx_dwork);
 		hlist_del_rcu(&peer_mep->head);
 		kfree_rcu(peer_mep, rcu);
 	}
@@ -732,7 +732,7 @@ int br_cfm_cc_peer_mep_remove(struct net_bridge *br, const u32 instance,
 		return -ENOENT;
 	}
 
-	cc_peer_disable(peer_mep);
+	disable_delayed_work_sync(&peer_mep->ccm_rx_dwork);
 
 	hlist_del_rcu(&peer_mep->head);
 	kfree_rcu(peer_mep, rcu);
-- 
2.43.0


