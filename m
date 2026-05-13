Return-Path: <netdev+bounces-287512-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHfQEnxLBGrNGgIAu9opvQ
	(envelope-from <netdev+bounces-287512-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:59:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A694B5310DB
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BBD9301876D
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8168B3E6DEA;
	Wed, 13 May 2026 09:55:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B03859E0
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778666152; cv=none; b=b48L5q58XvLXKTzlQtKb/gR3d2z6lk4HBIhOHEVMB8TqeoItSS4P+r8x7604CTYIRf9Kd5IIYj1mOSVQy52K7VD0BBZMuD2eyFfutOpiz0+9Z6Tzy0cdPOm2iGJsBYLHGmgqvpqXqOdh+XuHsryUYTF6hQAPqUrOXf7PomYcylo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778666152; c=relaxed/simple;
	bh=HK3AEjdpUCDYcmZMDKscRl09Shu5Uh9iMAdbuP4JJAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dOp9uL7c4Dig46FCZU2vDUqEqKA11yg/eFmOVROxCT9nwGcsw0qqWh3rda4+dW1zCATO5UIwhZ739MwlmETU1LbjOSPSYwdSRRJKbiySQ5MsRETC/kjHn2XmWAPJer6NeXEtqVIANCkJ6Z+P1oK8oKFna7V2MJiyKvU8ehCmI0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-44a74032ff8so4889504f8f.1
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 02:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778666146; x=1779270946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Bmq07OY8R1+Ffy1WSrvxPM6bplPMC10H/ezoamnZ7c=;
        b=f+t7qiqiCuiNrfLCPLHCYjZqO+md8CMWGkZZmwl5XWkQCDA+inJThbeWPLG7qpWXeY
         IAMKqS3cljH3O1ZsHoabXmPxku9H9V8TNWFJGMKW/cARCMgqpckr26VuS8Tf24mkj4wY
         Us2j48AV416bAhV3bqEmIrT1CNYNc278WnEkvkkjqQV0hvQbrfimLG05r5QHSvvEV/J2
         Cfk5TwU7k8/7kxjNj+Uj7QPtgA/jqQxZAVx6m4zdKBaDMO3X/ycVt1maY+L2ryoqLz/2
         bbILZdAKKKOV+xJPq/m9iqwndC2IOBncBQe+hq7XOdwUZIlEwX1PmveiHWh+iKZyrli/
         l1Kw==
X-Gm-Message-State: AOJu0YxZxvdo4pCqDF/sDPoHBiAvGn8sQppyAtYsWl1s8hmndEHE73Kt
	OEYhwTp9kBN9T0mOevoSB2YV3AGUtrGNB5SUdnm7S9FOq04IZ4WGpUccwooiPTSE
X-Gm-Gg: Acq92OHKJ2xMbSoiSYXkL/QcX/8I+OIqVSNse6aTrOH1qn2SVel8Jc1uB8J74eEmvqq
	3K5iAh4ieYgq/IbBlrEffJvGplFdtNqabvr0qXaLy0MStFSiA3DhO7XpT1Qv6LVI6g2Po3UeKi3
	ZJ7g/yv3uMtj2218DD8kWgl/XnPTiv5jud1wq0QCbJn8+7kA4ygh3jGWy8OtyBviEvmVVceOYps
	I38DxzM/LCPK/V8UG9DAFwF/xL6iEMfSQxNv0OJAw5eAkjEGebl0knvSAjTrsn2co6N20BsY/Ua
	D9ZRuuQUXVwtpw3n+XQTOeqn90GXb3r0sQWaOP/d6LJKa0O7lcjMxm/3w7eAPOVAmgS5Lg5fkMx
	IqyEA7VqtrSJmVvv1ptUpvE5WyRPvwsKvOjzWyfytS9RGI0beMgoYFXPZK8lGVUmPoo8znqhbs9
	dfEUnm6bUUthb7+OKKCtwxebR3N5sSiivDtRKSm3pwgrtJL50ECtUWxf7CSG0=
X-Received: by 2002:a05:6000:200f:b0:44b:7ec9:2d76 with SMTP id ffacd0b85a97d-45c790b2abbmr3507243f8f.7.1778666145933;
        Wed, 13 May 2026 02:55:45 -0700 (PDT)
Received: from im-t490s.redhat.com (37-48-40-237.nat.epc.tmcz.cz. [37.48.40.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548eb75c29sm38125865f8f.9.2026.05.13.02.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:55:45 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net] openvswitch: vport: fix race between linking and the device notifier
Date: Wed, 13 May 2026 11:54:56 +0200
Message-ID: <20260513095541.2010516-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A694B5310DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-287512-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ovn.org];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ovn.org:email,ovn.org:mid]
X-Rspamd-Action: no action

Sashiko reports that it is technically possible that we got the device
reference, but by the time we're linking it to the OVS datapath, it
may be already in the process of being deleted.  In this case if the
notifier wins the race for RTNL, it will see that the device is not
yet in the OVS datapath (ovs_netdev_get_vport() will fail in the
dp_device_event()) and will do nothing.  Then the ovs_netdev_link()
will take the RTNL and link the unregistering device to OVS datapath.

Eventually, netdev_wait_allrefs_any() will re-broadcast the event and
the device will be properly detached, but it will take at least a
second before that happens, so it's not something we should rely on.

Let's avoid linking the non-registered device in the first place.

Note: As per documentation, RTNL doesn't protect the reg_state, but
it actually does for all the state transitions we care about here,
so it should not be necessary to use READ_ONCE or taking the instance
lock.  We can still do that, but we have a few more places even in
this file where the reg_state is accessed without those while under
RTNL, and many more places like this across the kernel code, so it
might make more sense to change all of them in a more centralized
fashion in the future, if necessary.

Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/vport-netdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
index c42642075685d..de90d0541e172 100644
--- a/net/openvswitch/vport-netdev.c
+++ b/net/openvswitch/vport-netdev.c
@@ -83,6 +83,11 @@ struct vport *ovs_netdev_link(struct vport *vport, bool tunnel)
 	}
 
 	rtnl_lock();
+	if (vport->dev->reg_state != NETREG_REGISTERED) {
+		err = -ENODEV;
+		goto error_put_unlock;
+	}
+
 	err = netdev_master_upper_dev_link(vport->dev,
 					   get_dpdev(vport->dp),
 					   NULL, NULL, NULL);
-- 
2.53.0


