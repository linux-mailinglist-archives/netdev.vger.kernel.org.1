Return-Path: <netdev+bounces-266288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLXgB61gsGloigIAu9opvQ
	(envelope-from <netdev+bounces-266288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:19:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 840E925654C
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5BD13002A23
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4937E22423A;
	Tue, 10 Mar 2026 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2qJ1qBQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BEC1FC10C
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773166600; cv=none; b=ctkUNGZyRh7pGYpOB6sbeddILAqEBp6BqTrLgQRzuXo7qGX46GMOjk5x9411l4l/OpfiXKBk7ihb0uZYot2ci7z2BLAZa1CGWXMXeRAbjm813KE/pXa5pfWsTjLlz0gR2ZUX0oQ27QR1lIU7v8y6jDQ1VkWraPa/wZIgi/wleqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773166600; c=relaxed/simple;
	bh=GKzNp2kgqQHl2RlujjExvukJo989FzoE0hIn7jde2Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jvXSIRG9fZOaPzgMrOBzhZrM2nHNws9SE849uunzvs2tZNKCPLISgaWTzaYZc3Rgy/M3/iDZWHwzh250C7qXlQ/unCRWAWtzF31gBmfRa1sa+HhPzndNoEdNPhUOAcfx8dxRONySortqVnEV/hgfebG58EIPyreYWeWm+90NsZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2qJ1qBQ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae43042ea7so108810825ad.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 11:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773166598; x=1773771398; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IzKqCfinj2vljd4Q4U9GaPWdnYsR2TKTXccYMMQKcro=;
        b=c2qJ1qBQV4YpzEPFzOIzbDP0QJxndLKLzK6dIdSMEKPiNvDXs8O8y8nCsbZuH3l6bA
         pVHZzHbmvpMhj0w6/q9jx6E3XQ/5BXaEftOHFAJ5U7+a71aYk0wGAWjV0o8vkCx/hNdx
         IfsMPjnQpllb3OfaN/lmm4WN7/hnaXy7iQvVRYveXEcaqwDGuyZF04a6fActGprZ+8sv
         s+E0gmG6RjBNGZYYz6aRzuP9DtQfRccPGGL1hMLRjjn19VjsziniyA5SBCTAtpVCRBUU
         Ai33inKb6essdYeaTkCMiF4my+baODFZs4GPa9+g1BC7CqzWpIahv26b5CuM5pjGYIba
         /l9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773166598; x=1773771398;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzKqCfinj2vljd4Q4U9GaPWdnYsR2TKTXccYMMQKcro=;
        b=de3JhqJAv1B2uSSKWRkaSktsT6z7txqk47HFcj88sGIyv9WtrffHQzaHxVFzb2Ayqg
         4BKWWmxDs0kCejnN/kTb2XVirrl0W6kLhN3vuNwnuq5/BIVfhrN+xuKB8MOC0dBNh+UG
         1OyJ7ZIYdA1QP3zag9ny3bdX6RDGxSHy7aSNLV10K0EK7QcmWprzvLlG/myIsyOgwPzq
         /2r1M9tsOiAXXiLvQImi+NInTUKfWBOxH1vuUhPW2QPPUDzyuaY25r8jQydBM0DLAiqd
         Ldqm9bSvM6hQBP5N7puyMazkkW/S8YGVQJrPAkY8u317ZxKcsljREA7wQGiYZ2F6ShWk
         sH6w==
X-Gm-Message-State: AOJu0YyEZH/y6EoQM9bspORuKNoDiXg1AK4y5o0GEyE24zFBaL+jFkZA
	yOBr1Mm5ULfmB0tGl/GWy4ZzLspMZ3ZPgVRMZq5qv6VOkz0ImqMSCD+c
X-Gm-Gg: ATEYQzxpcmDapG5Ui9C4KbZbEILsfM0XsNYRdJvfApZ49ByOFYrwsuJSguNLoP6Sszj
	LK1CHQ7qFVbbulHVRNx8jiTEPTJOGvXp6rDPbnrYB7+c7F5LMMewv2+LBnbhkJxY0MozB9HU5Ak
	9UTYt/xll2o2RXW3E7EF8HXTR7MW9E5XRg+5Dq72UDW2miaIvDsQUXZ77dRnBGLl2wmOKbrpJYM
	dJ64OzGGk+HjBgIEntA79kQUeiDfH+AdDIouEUTFiePo+QPsyk2+Hqg4VMvbUsJt0AmlaNX/Scp
	u8JxW08EESQl9JDksqMiS1V5sw2Zgn4KIvwm134CClmYNYA6T6W3EAdfclcEGwYQ1cfJtNy6RmM
	VsD6FNwRMwckyu4t6w8ere3nUj7FHeAeRXGRQcfFzUw2akf8PmT1Skw7dra1H002BbeGSaD+FJr
	zmzCnMfK6DaDMZ5qeFGZEzpP3U8ckSReM8pEIbCGp+eA==
X-Received: by 2002:a17:903:2287:b0:2ad:cf11:5048 with SMTP id d9443c01a7336-2ae823a302bmr165215185ad.22.1773166598473;
        Tue, 10 Mar 2026 11:16:38 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e97924sm162763435ad.27.2026.03.10.11.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 11:16:37 -0700 (PDT)
Date: Wed, 11 Mar 2026 03:16:29 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net] xfrm: Fix work re-schedule after cancel in
 xfrm_nat_keepalive_net_fini()
Message-ID: <abBf_R81PYmafhWv@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 840E925654C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266288-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

After cancel_delayed_work_sync() is called from
xfrm_nat_keepalive_net_fini(), xfrm_state_fini() flushes remaining
states via __xfrm_state_delete(), which calls
xfrm_nat_keepalive_state_updated() to re-schedule nat_keepalive_work.

The following is a simple race scenario:

           cpu0                             cpu1

cleanup_net() [Round 1]
  ops_undo_list()
    xfrm_net_exit()
      xfrm_nat_keepalive_net_fini()
        cancel_delayed_work_sync(nat_keepalive_work);
      xfrm_state_fini()
        xfrm_state_flush()
          xfrm_state_delete(x)
            __xfrm_state_delete(x)
              xfrm_nat_keepalive_state_updated(x)
                schedule_delayed_work(nat_keepalive_work);
  rcu_barrier();
  net_complete_free();
  net_passive_dec(net);
    llist_add(&net->defer_free_list, &defer_free_list);

cleanup_net() [Round 2]
  rcu_barrier();
  net_complete_free()
    kmem_cache_free(net_cachep, net);
                                     nat_keepalive_work()
                                       // on freed net

To prevent this, cancel_delayed_work_sync() is replaced with
disable_delayed_work_sync().

Fixes: f531d13bdfe3 ("xfrm: support sending NAT keepalives in ESP in UDP states")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/xfrm/xfrm_nat_keepalive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_nat_keepalive.c b/net/xfrm/xfrm_nat_keepalive.c
index ebf95d48e86c..1856beee0149 100644
--- a/net/xfrm/xfrm_nat_keepalive.c
+++ b/net/xfrm/xfrm_nat_keepalive.c
@@ -261,7 +261,7 @@ int __net_init xfrm_nat_keepalive_net_init(struct net *net)
 
 int xfrm_nat_keepalive_net_fini(struct net *net)
 {
-	cancel_delayed_work_sync(&net->xfrm.nat_keepalive_work);
+	disable_delayed_work_sync(&net->xfrm.nat_keepalive_work);
 	return 0;
 }
 
-- 
2.43.0


