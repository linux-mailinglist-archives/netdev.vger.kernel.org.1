Return-Path: <netdev+bounces-307499-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NJ6XOZZIVmpG2wAAu9opvQ
	(envelope-from <netdev+bounces-307499-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 16:32:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BC4755DD9
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 16:32:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=I7Cipxac;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307499-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307499-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D5583035B90
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 14:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E454448CE9;
	Tue, 14 Jul 2026 14:30:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AA22FC01B
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 14:30:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039409; cv=none; b=oSRO9QX8ZkZn9CKsKXuBpVrU2VEO1gHBFkx3YXuQVmN1HJuSpENOBueEPb92V57gOjFwXor+JUuPyzxw+WUi389oRORJ6j2tm76/1Ncng72wbz9T+AVkVcfQsg68BN54WSMbMFq6nAAjCEJ1xVmsPC/9ZlxXw6bvihnCzt8Jw7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039409; c=relaxed/simple;
	bh=BtV4YlWqSeeVkZLMl7O/Z8uUv5IQpghIyehpmENCIJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9MhDJ8GFhaDFIxvlxzYqCtf+PuOrJgrvgyEnNXWH9xwTd1POSv/q0q7H6ObJ8xpQrnfHVNvh8e1k3QlS1lLVZjwoQM/I6R/5vaMQuEtrJpskcbU3RYSocBgDQsG/kDLfFOD+OjKuZICGrzSd8iQjXE9qTbX9chlCbh13/rMn8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=I7Cipxac; arc=none smtp.client-ip=209.85.221.53
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47de008b020so579455f8f.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 07:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784039406; x=1784644206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FMAXl1cpFneAc8qw41p6eJ7Eq0JeDqgZ4KunEwtw9x4=;
        b=I7CipxacfACQpBFzIV0kdiLsjH5YL5uPNxzHlbHayWvwPnGxpp1AO0dMJrbzcxvSUl
         aCylOdGhA3eFZXX4JRiJp07w6lK/t9MQxdIZqq3/3WC99zUtr6HpuzPg8iDpn/7RfEzJ
         s8AuqXVNyt+oRczuvATMLob05+A+bqb1SXzWcwQRp8KZZsrmavsbOPjpNyTlOPnVoQ1Z
         6S36h90AoKqJaFoKIQr3fSvoV5fZre8VuL/0h/VROorQBUc4MCatVt6O6vTBaHLBT/2G
         jlrdJPB8XDtAAcO3DeEsbp23rLvH0yJ/z4rqIeOhY5QxVSJpr2JH30/qwQ4CEz1x96yt
         rDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039406; x=1784644206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FMAXl1cpFneAc8qw41p6eJ7Eq0JeDqgZ4KunEwtw9x4=;
        b=rngK9X1TikMrjNAQZjvo6SrbGImjFLmcAFvRZ7d5zYLYzlUS1H78D7MM7MSl/APkoO
         29B6Ke4g7QrzW2UFp0MFkbPxEgG4Xl/OmtoExN3eFv79OzVcaJ5WwZp7L1tD46XJCFeA
         Lb04W6FOL9AeP6xuN/MN/NN98BzyotVpL8PUWZ7d28NqEXVgdGW5DkUIZHg2jVkhDoRz
         pBlOwu0QoOasYpTn2gbOyZZDMTZJlVXsS68A2e4KkydHM2wxvNoEBkBckkTMXaVL4UJa
         0v7u2gzHQoPHibj/COvUbgjli/JPE1kxOzxGVrxUQvIwhNfeVlD3zqvO7JX+5bPt8S8+
         NM4Q==
X-Forwarded-Encrypted: i=1; AHgh+Rre+fx8BThrvs4O8LCkNBaRCT4AUOu89PSXbTCVrAbHkGT71Oajt8YG9Kbee0kda78y+IVI/bA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/5m0n3z46QIv2GPKYA6zwnnBrDLxXPS6/5vwLyCOZ7QlOcKO9
	SBipV6hhF1YULLGGaW8YXSafHkBCQt9W65yXiulSWORhuUYvQmmaF9jml5uCIaZVVFg=
X-Gm-Gg: AfdE7cn+Gzg9kw6l+cwXS9LylxYfBgiDuGa5bzK7w3hwrfVqCfiit/2dfFftUJDtLGg
	WIBNfLGBHnm40eqSMS8pB4LA6hfLNmuknfVELS0J3u4QBRmm7dxWXbJf3gbXMslvUP80PlIsYsn
	rsee55t+ju6cvzFjKs1lKM8Our5LzAUruvfT+Zyr3T/XPtmcRVyX2+woog+4ydDeqk2ED3+xu0V
	3cJQafHgj1bkHeMKDlyckTKkEBhDbRcg1PzZ858dfXg26YrFe/vyzcAbN0w0HGxycVP8EjsWoeI
	ILELn4pO13LSnk/Nou8UqFKICyQd1sGTUZWLeatuuNCF2cLZC1sH++aur8CKNC7pQslGrnRqCoC
	Im2VeY5+sO5p5Y7TIYghJ+FL9mdcCPZ88vQtjEh9zgjSOrTywMd7wmgX65czURBC8Jf77uqllbG
	+TyFB23PTiXpwbyXXxAIKLIg==
X-Received: by 2002:a05:6000:184d:b0:474:3708:c8 with SMTP id ffacd0b85a97d-47f2dcc0d79mr16328082f8f.15.1784039405669;
        Tue, 14 Jul 2026 07:30:05 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e029sm9366983f8f.3.2026.07.14.07.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:30:05 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: cgroups@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	cmeiohas@nvidia.com,
	roman.gushchin@linux.dev,
	bvanassche@acm.org,
	zyjzyj2000@gmail.com,
	shuah@kernel.org,
	tj@kernel.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	yanjun.zhu@linux.dev,
	cui.tao@linux.dev
Subject: [PATCH rdma-next v2 09/14] RDMA/cma: Document that CM configfs cannot be net namespace scoped
Date: Tue, 14 Jul 2026 16:29:22 +0200
Message-ID: <20260714142927.1298897-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714142927.1298897-1-jiri@resnulli.us>
References: <20260714142927.1298897-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307499-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,kernel.org,nvidia.com,linux.dev,acm.org,gmail.com,suse.com,cmpxchg.org,linux.alibaba.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:cgroups@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:parav@nvidia.com,m:mbloch@nvidia.com,m:cmeiohas@nvidia.com,m:roman.gushchin@linux.dev,m:bvanassche@acm.org,m:zyjzyj2000@gmail.com,m:shuah@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:hannes@cmpxchg.org,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:yanjun.zhu@linux.dev,m:cui.tao@linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,resnulli.us:from_mime,resnulli.us:mid,resnulli-us.20251104.gappssmtp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7BC4755DD9

From: Jiri Pirko <jiri@nvidia.com>

Document the rdma_cm configfs limitation: configfs is global, so same-named
RDMA devices in different net namespaces cannot both be represented there.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/ABI/testing/configfs-rdma_cm | 4 ++++
 drivers/infiniband/core/cma_configfs.c     | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/ABI/testing/configfs-rdma_cm b/Documentation/ABI/testing/configfs-rdma_cm
index 74f9506f42e7..739f7b6a1259 100644
--- a/Documentation/ABI/testing/configfs-rdma_cm
+++ b/Documentation/ABI/testing/configfs-rdma_cm
@@ -12,6 +12,10 @@ Description: 	Interface is used to configure RDMA-cable HCAs in respect to
 		for this HCA has to be created:
 		mkdir -p /config/rdma_cm/<hca>
 
+		Note: configfs has no network namespace support, so this
+		interface cannot represent two devices that share a name in
+		different network namespaces (possible in exclusive netns mode).
+
 
 What: 		/config/rdma_cm/<hca>/ports/<port-num>/default_roce_mode
 Date: 		November 29, 2015
diff --git a/drivers/infiniband/core/cma_configfs.c b/drivers/infiniband/core/cma_configfs.c
index 891e52afb8f4..c389d4e37b6b 100644
--- a/drivers/infiniband/core/cma_configfs.c
+++ b/drivers/infiniband/core/cma_configfs.c
@@ -65,6 +65,10 @@ static struct cma_dev_port_group *to_dev_port_group(struct config_item *item)
 	return container_of(group, struct cma_dev_port_group, group);
 }
 
+/*
+ * configfs is not net namespace aware, so a name shared by devices in
+ * different namespaces resolves to the first match here.
+ */
 static bool filter_by_name(struct ib_device *ib_dev, void *cookie)
 {
 	return !strcmp(dev_name(&ib_dev->dev), cookie);
-- 
2.54.0


