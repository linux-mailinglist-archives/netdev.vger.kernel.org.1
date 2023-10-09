Return-Path: <netdev+bounces-39267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 505307BE93C
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7C0281DE1
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 18:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5CE3AC3D;
	Mon,  9 Oct 2023 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Flw54V43"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C897D3AC1A
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 18:28:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0DDBA
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 11:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696876094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cJCshGXBIhUp5eoSJv8BhgcaclTM7hneWJVXPfRd5Oo=;
	b=Flw54V434TJb4spMHJMuMu2S4Rpwtiqt00wA9Ct95Qktitc2G1m2TNpUUceQIT2wchQ4D8
	6mLt32ozoJxGmssjy/AFJG9pW85aTY8Qvx0f/uqjCoQYg248TGUe1eYGQYB4yJnhGoUOyf
	dPsi7TjzJJtC3C1AJG1NT2zQ+dBvIGA=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-XbtrnyiwN5aeE2flfErYNg-1; Mon, 09 Oct 2023 14:28:03 -0400
X-MC-Unique: XbtrnyiwN5aeE2flfErYNg-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-59f7d109926so74118387b3.2
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 11:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876083; x=1697480883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJCshGXBIhUp5eoSJv8BhgcaclTM7hneWJVXPfRd5Oo=;
        b=pee2SFrKDDQSGrFZeDO2V3FkbWIQE/6lTseQMH5o4aYa8v6gX/rAc6+9JnUKubV4Rb
         pAukvBE0i9qPejbH175UlN/An+KAGkT1muKtzCOsYx570w0m4jTOIDKs6B1BQ7zBo5Ti
         g58G8piq1VSTbwPOGF9Bf7uvfxtUX0P+XVbsK+jgiXTtG3+Ynw9fr5h8z0DELGGgEO3h
         dKFXQqR9xqYhj2CWd0Gsas/fH9eIPGdccpq/JfV9VDVH2319VSD8zi+683cW0siacXKJ
         esZrdMb9h/x2f0JbvcosavBsNDFBY8kn5v3FL65uep0BUDq/z/OiVeHfAbIk8oYXTQEP
         vqoQ==
X-Gm-Message-State: AOJu0Yys4JGQYW0bv966Z/I5oaBiWoxcRsBMdOnbfeh7/hzr2DcSyPqK
	xn8d4txzgaVqRJT7xFB4823+cryD20fE9XrgtlpOBLnaHBv+gBsT6DTaU83i1xgx/V6zF5OCGIE
	wQaZKU5W2r2aXHItu
X-Received: by 2002:a0d:e28f:0:b0:5a7:a792:a5d7 with SMTP id l137-20020a0de28f000000b005a7a792a5d7mr1541040ywe.15.1696876083054;
        Mon, 09 Oct 2023 11:28:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPxjr/qAaN0GdyTNJWfdAvn+wK2SMrRy2Rcuv/q0h7zt+3+ulHphaw2l3L43J7ftORjeFpyA==
X-Received: by 2002:a0d:e28f:0:b0:5a7:a792:a5d7 with SMTP id l137-20020a0de28f000000b005a7a792a5d7mr1541027ywe.15.1696876082841;
        Mon, 09 Oct 2023 11:28:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id m2-20020a814042000000b005a7b8fddfedsm121032ywn.41.2023.10.09.11.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:28:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 3B27AE58215; Mon,  9 Oct 2023 20:27:57 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: David Ahern <dsahern@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Christian Brauner <brauner@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	David Laight <David.Laight@ACULAB.COM>
Subject: [RFC PATCH iproute2-next 5/5] lib/namespace: Also mount a bpffs instance inside new mount namespaces
Date: Mon,  9 Oct 2023 20:27:53 +0200
Message-ID: <20231009182753.851551-6-toke@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009182753.851551-1-toke@redhat.com>
References: <20231009182753.851551-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When creating a new mount namespace, we remount /sys inside that namespace,
which means there is no bpffs available unless it is manually remounted later.
To make it easier to work with BPF in combination with 'ip netns', make sure we
always mount a bpffs instance to /sys/fs/bpf after creating a new namespace.

Since bpffs may not always be available, we only warn if the mounting fails, but
carry on regardless.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 lib/namespace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/namespace.c b/lib/namespace.c
index 5f2449fb0003..62456ab24e4f 100644
--- a/lib/namespace.c
+++ b/lib/namespace.c
@@ -93,6 +93,9 @@ int prepare_mountns(const char *name, bool do_unshare)
 		return -1;
 	}
 
+	if (mount("bpf", "/sys/fs/bpf", "bpf", mountflags, NULL) < 0)
+		fprintf(stderr, "could not mount /sys/fs/bpf inside namespace: %s. continuing anyway\n",strerror(errno));
+
 	/* Setup bind mounts for config files in /etc */
 	bind_etc(name);
 	return 0;
-- 
2.42.0


