Return-Path: <netdev+bounces-48021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F371D7EC4F2
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 15:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3019B1C20847
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 14:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7927E2D7BD;
	Wed, 15 Nov 2023 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="TDNW4Bdk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCAA2D63C
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 14:17:40 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C3FB3
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 06:17:39 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9e1021dbd28so1017040666b.3
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 06:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700057858; x=1700662658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Loj6eye+Xg8SMV+GCvDdSe8coR7xpViOIIZYOTm3lQ=;
        b=TDNW4Bdk/HPoG6w5FtX6uYlHYNgAf5HP1uruu5pPkdoY/cJiPzzdPtPa5Z34PgZ6N0
         crcNMVnY244TM6hRg7ZopIr28gnFXsGP7i8j/rtE912vfEWzBCBkcSBVD+TBTbuJuUPe
         jbd+To5DQ0hidsQ+HvV4MdRnxNXQvJaHAOYoTyB3ydPkLn8XRsmFMUZ7fAw5E7P6PyP9
         tj4pdcgWDNaBwDv1nc9zsJ0hOdrJWgRxC6vMmG4tclz2M7nTVg49P+k9XjjI0k5mvt9/
         j8LVf4EVFu1bzL+xphfYwSBh7ZUs2CovHHHhsmGN/eZJMnCtHXHyvpc+8oMtMB87ccwg
         69TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700057858; x=1700662658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Loj6eye+Xg8SMV+GCvDdSe8coR7xpViOIIZYOTm3lQ=;
        b=i+3F66Un73GQx7B6JyJ+Ue2V9kC2NNaqr2YJ/4kHraqHT6+3Rn7a0nKRgLqH5GpRKG
         sHO0OVmeBxD9vvTqNFMMkidHgDwtGgVqvfCjmEq0ARiIlNYsRnpeDk8T3atyJtGQTVgO
         /KYIEX9y18EsLxUuURuloBZ3LqqdqOLr8bDFbmnFi0nxkklMW1Fb4LNcdH9+QOKWF6yq
         eWLI6VFSXH5AmvAmoUQb9YJoqT0GdGCBatlcSWuqwMcjXw35Q3h82BUV+vrx7aIL6Xsj
         BX6mkBBDyNbSqrvi8B8Pr1W17VKgnTWpS1YsvJ17yVqlmV/Q+1yDjHbJjxx/ksnfTP5G
         kfNQ==
X-Gm-Message-State: AOJu0YzVQZoflDlmVknaMvJr01mWw7ineeZfL2v5ZQLVgvOtS+H7ymcN
	fT+29JR1SdmgKSIHPc9qtY18PvFlrGte/YVAN2Y=
X-Google-Smtp-Source: AGHT+IHZV+eno94kc6o9FPkd3ZzBJOM3W8MCatjOBy962L6yPeGoVv90BFQZOxvYS1mHg+O06zYj+g==
X-Received: by 2002:a17:906:6d0:b0:9e6:4923:680a with SMTP id v16-20020a17090606d000b009e64923680amr8661109ejb.3.1700057858207;
        Wed, 15 Nov 2023 06:17:38 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id e27-20020a170906249b00b009b65b2be80bsm7083630ejb.76.2023.11.15.06.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:17:37 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	jhs@mojatatu.com,
	johannes@sipsolutions.net,
	andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com,
	sdf@google.com
Subject: [patch net-next 5/8] genetlink: implement release callback and free sk_user_data there
Date: Wed, 15 Nov 2023 15:17:21 +0100
Message-ID: <20231115141724.411507-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115141724.411507-1-jiri@resnulli.us>
References: <20231115141724.411507-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

If any generic netlink family would like to allocate data store the
pointer to sk_user_data, there is no way to do cleanup in the family
code.

Assume that kfree() is good for now, as the only user introduced by the
follow-up patch (devlink) will use kzalloc() for the allocation of
the memory pointed by a pointer stored in sk_user_data. If later on
this needs to be implemented per-family, a callback is going
to be needed. Until then (if ever), do this in a simple way.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/netlink/genetlink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 92ef5ed2e7b0..905c5a167f53 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1699,12 +1699,18 @@ static int genl_bind(struct net *net, int group)
 	return ret;
 }
 
+static void genl_release(struct sock *sk, unsigned long *groups)
+{
+	kfree(sk->sk_user_data);
+}
+
 static int __net_init genl_pernet_init(struct net *net)
 {
 	struct netlink_kernel_cfg cfg = {
 		.input		= genl_rcv,
 		.flags		= NL_CFG_F_NONROOT_RECV,
 		.bind		= genl_bind,
+		.release	= genl_release,
 	};
 
 	/* we'll bump the group number right afterwards */
-- 
2.41.0


