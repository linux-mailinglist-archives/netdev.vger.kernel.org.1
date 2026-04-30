Return-Path: <netdev+bounces-283014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIbANiHo82mE8gEAu9opvQ
	(envelope-from <netdev+bounces-283014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 01:39:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D9A4A8E50
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 01:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 513D43008090
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 23:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4555D3D3D18;
	Thu, 30 Apr 2026 23:39:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023F63D0917
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 23:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777592347; cv=none; b=mOauoOUvh6gKLg9ZIeqjBBJ4jIRzXSxH7jSpi31kIZ5XYeeZEFn9zylKLYe/93ed5VPDe6xT/3Uvz3yYVd/4ngGgj+6U3VSJEqb5j+bXMwU+KsU8VoR2Zl75FhpHdya3/VCWR7FpKo/1YDj0ulx0yuwu3jadX57KSGT/QgU+VEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777592347; c=relaxed/simple;
	bh=RosUM6xPRIY1oTK9LeKQ/7oZG5o9uW6w4P5hZC7Uc/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZZe8pn6/Zwl7XbzTU8LEJPpyP+YXKOSsz+/YjXORxw+l6pt1r373YxLgjiZBAFIMEpHwIEs+9VEjqJ9mQxDM7kkNruLzbbVJtkq9EJlZ+i+5X+4VVXyuwun+0we9EEm5aiENUHXMZmxg2m6OntiZUaeMpGUpafgSRfZ/KiqlLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-50d87610513so13168661cf.3
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 16:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777592345; x=1778197145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SA+eWHMkILjGV4lZwdF0bh9/zh8ox7+jWKzlWflnjB8=;
        b=XibkjhTArrBoUju478+GGMjTyGd5pbGu5pG+r2KHO8y/Zfik6oieqifU6qbc11ZEvn
         gEv/sA6TR+beeUdMO7VZMasBcT2hu1XLMfjGoaJwtPxhpR4BFG4uyJPLe5O+dPlOAEyg
         AOs7vSviFmYOLm1zXVmA9tVkz4JOCLOj0zA9ZGeLOYe/DnqKOLEN01IPWJjKEhutnBPC
         8hHKmKv9j5zZ8mvpjNGyztMCGt9EkP5N28jgb4UQz1F5j3B0X0SMbCNE3ypaGxjYsk/M
         9Yl/oLVq1o/vIBl+9HMAGnkncKa+YRSg3PDr1uChyNRXkXU8ZzhZAYpM+fNTJI2ZZ4R/
         X8Rw==
X-Gm-Message-State: AOJu0YwG/UkG9Xg4iGdodevCFJFlEumi1G8hLEzxozcuA0FIS+KFox4e
	Qf0+0r/K4tUI5ILKtvvl7y5BQ4wFoEKs/OLBzUwJADlQwshXHdnsSb0VCze7ULpfv7g=
X-Gm-Gg: AeBDieurSkU+0ZjKakQw3CfwGaL5rGZ8w5w1Ze6uGyVuXkMBottvet4XDfjvESij/rU
	8xwYetc8s+3sHnKedFeBMQCkTfsenGn53xTvzq9PYC+d1RH3LBQA+DHf2jKxigC2SGLwAYrR+Qa
	5fEVx9YXgMzTA8jDuRZNadll9TGbBzbUCvPv0n0c5YGsEG3wRk9t6JFOimbqRm4IG7SOP2RrWt1
	VX+9Q91HihSmgpGf+hDWS84ILS4M8Q4uH8X+n5pZaQ7le5HQerE+4ZKgYcLV1wgGIKCRzFbyZIW
	t5Oe1prRQVeE0NeSRggG5TVKv8ehteEFf1ZUhb/cpN4jYfEGXtc5aJcVzRt/N3AcPza8eILm1J4
	rSWIhxLVdQF64+jpYgyDXzhN0mXESU9yUALj0hJxDorkrpgXIYUwCdS36MPUW5XqSuTm06YOhTF
	fz6xpa08AEFlkdxn1/jRK6+o6Kl3HMEDeV7qU6GU5FF7OY9pmJv9zrS6ZGaXvKM8qogTsLRQ==
X-Received: by 2002:ac8:5a0e:0:b0:50d:8db0:7abb with SMTP id d75a77b69052e-5102adc9563mr74431601cf.42.1777592344891;
        Thu, 30 Apr 2026 16:39:04 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040934199sm221cf.13.2026.04.30.16.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 16:39:04 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Yuan Tan <tanyuan98@outlook.com>,
	Yang Yang <n05ec@lzu.edu.cn>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] openvswitch: vport: fix self-deadlock on release of tunnel ports
Date: Fri,  1 May 2026 01:38:37 +0200
Message-ID: <20260430233848.440994-2-i.maximets@ovn.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430233848.440994-1-i.maximets@ovn.org>
References: <20260430233848.440994-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E1D9A4A8E50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[ovn.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283014-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,outlook.com,lzu.edu.cn,openvswitch.org,vger.kernel.org,ovn.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.980];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ovn.org:mid,ovn.org:email]

vports are used concurrently and protected by RCU, so netdev_put()
must happen after the RCU grace period.  So, either in an RCU call or
after the synchronize_net().  The rtnl_delete_link() must happen under
RTNL and so can't be executed in RCU context.  Calling synchronize_net()
while holding RTNL is not a good idea for performance and system
stability under load in general, so calling netdev_put() in RCU call
is the right solution here.

However,
when the device is deleted, rtnl_unlock() will call netdev_run_todo()
and block until all the references are gone.  In the current code this
means that we never reach the call_rcu() and the vport is never freed
and the reference is never released, causing a self-deadlock on device
removal.

Fix that by moving the rcu_call() before the rtnl_unlock(), so the
scheduled RCU callback will be executed when synchronize_net() is
called from the rtnl_unlock()->netdev_run_todo() while the RTNL itself
is already released.

Fixes: 6931d21f87bc ("openvswitch: defer tunnel netdev_put to RCU release")
Cc: stable@vger.kernel.org
Acked-by: Eelco Chaudron <echaudro@redhat.com>
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/vport-netdev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
index 12055af832dc0..a1df551e915bc 100644
--- a/net/openvswitch/vport-netdev.c
+++ b/net/openvswitch/vport-netdev.c
@@ -196,9 +196,13 @@ void ovs_netdev_tunnel_destroy(struct vport *vport)
 	 */
 	if (vport->dev->reg_state == NETREG_REGISTERED)
 		rtnl_delete_link(vport->dev, 0, NULL);
-	rtnl_unlock();
 
+	/* We can't put the device reference yet, since it can still be in
+	 * use, but rtnl_unlock()->netdev_run_todo() will block until all
+	 * the references are released, so the RCU call must be before it.
+	 */
 	call_rcu(&vport->rcu, vport_netdev_free);
+	rtnl_unlock();
 }
 EXPORT_SYMBOL_GPL(ovs_netdev_tunnel_destroy);
 
-- 
2.53.0


