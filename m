Return-Path: <netdev+bounces-48476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A9C7EE824
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 21:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29145281048
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 20:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5467A3BB3E;
	Thu, 16 Nov 2023 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MzesG7g3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C34E1A7
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 12:11:54 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b6cb515917so765177b6e.1
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 12:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700165513; x=1700770313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w2peqo+SYVQgbTF6odymZNSu+sZ00cIgIYlcjFlppWM=;
        b=MzesG7g3i8qt5IBoUzsxdwY7I600BmpV87GNM5DQhg0hA+cSya0lonorx7/kcl8Jc0
         yWaAoEHI+tlGAwqjobJh8WHP0axD94ET+YATbdCfT/vphU8d72sh2vtmHQ7uiDvIPIsv
         fysrbH51sTFSLrk9UMQAohFWF5rR9hQBB6W8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700165513; x=1700770313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2peqo+SYVQgbTF6odymZNSu+sZ00cIgIYlcjFlppWM=;
        b=BrfsnK3soPrmBX9uT+8N9HLwyjsfZ84CyrO7V5U3fcB2cKFP/Nx4rpz+91YkYLZwVz
         HftbB8HOHM2lxHHui8UUnuKGEMRZKoIMtThKlB2xqSUz6rGSVTKz+FwI6aNvXrQhVEFp
         gINHq6XBiBBwvZieERwYWRPDDqJkN8kfxZG8O/Gtjl5EpL772hX2iqIeXmCQuVTPWnX+
         sA83mrp57xIs6pEUmMBQL6oXb913mldwx22nOKEpFRgo0zej/97NMjHiQCPeYOlmCpNa
         64Ro/lyAs6Tc4FozeqUjHXHYC2Dtw0DQ35CmCDwp8yHo3c22GxycIlcflPXJexuTPRbg
         NC2w==
X-Gm-Message-State: AOJu0Yzdnww+y+5uVLacUg67ViIovT1ozm2FHRom3i+VJ4NREuylSwqC
	8pOUhGHJVjktU1GbjBDT5iIZAA==
X-Google-Smtp-Source: AGHT+IHHS27q9Zol1WZfao+OWS6LqfHtSOy7auNOYxNNvA5QCM5TNvcbBs4bj/jenhCC5LoEFl+7MQ==
X-Received: by 2002:a05:6808:202a:b0:3ae:a81:55a9 with SMTP id q42-20020a056808202a00b003ae0a8155a9mr23090946oiw.24.1700165513547;
        Thu, 16 Nov 2023 12:11:53 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j26-20020a63551a000000b005b529d633b7sm101355pgb.14.2023.11.16.12.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 12:11:52 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add netdev subsystem profile link
Date: Thu, 16 Nov 2023 12:11:51 -0800
Message-Id: <20231116201147.work.668-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313; i=keescook@chromium.org;
 h=from:subject:message-id; bh=ix3E5+mpX2+wWYY/dmA26qPFSe5TqgzyFgYbY0i+LqA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlVneHMkrUTIl41b1SKNI4TkufbDe3uul9AZl+q
 /WfNMumb3yJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZVZ3hwAKCRCJcvTf3G3A
 Jh0oD/wNsSPwMniWu2bzU9OJhEovajw1GN8hxsOmemJsLBYKdg9R9zO1l7UKgyPjnKJMt5n86IM
 02541MKA1uWNwInV6KZqFiiLB/+6gCJUzsY7DZ06BIDH+z6oDh8kqLw3KGMvPc9CGuhXwBSLeL7
 JunGL2wtooeHHXbsmzqyJRQtY++gfAWDsrMBuudMc41i4TlbBDVxJi9ZrGcrPv/ObKlsK3AdFH0
 m2SEHxhp5aLBn0iYiYKzdNe9XaCQRhY7SrkxaU40R6RooUocbn++yJ/0MnPfVo4JDmwrcBjgmxX
 rYEvPoJSgzUtFp9nrUVbdVzFrbBho7+xAmxnmTZl1FPSrifk3Aka39/BTDfzEvJZHf7u5S0IW4i
 BGm0iMDUvZjO7Gf5VKFW/96pplKslQ5zSEShPQr6+QNL7a5k5aZQyUGC76Vb7vtiTNSt8w8pF2O
 pTRmoutNr8UvyWEIFuhKzWq2fUVRRibVSLmjHRcVd3kTCoiivuKyvzhDVzyx1YtjTLBhRtgjDKk
 HzYRCRDeDXwNvc9yeaKutTpJx1tSiEWbVE8nSPlUx6JckhQpHs3QIXFRKeQSFGhj8dvPK8LNsTh
 6t6hGmbqC4SxSt7aKNpTyW1PPLDP5f1due559QlUJn+m5B3PqVlu+Tj9NRqpGdkKvqp4QjETdkz
 dM3T2Rz vv9xN20Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The netdev subsystem has had a subsystem process document for a while
now. Link it appropriately in MAINTAINERS with the P: tag.

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97f51d5ec1cf..b6d570c4eda6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14995,6 +14995,7 @@ M:	Jakub Kicinski <kuba@kernel.org>
 M:	Paolo Abeni <pabeni@redhat.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
+P:	Documentation/process/maintainer-netdev.rst
 Q:	https://patchwork.kernel.org/project/netdevbpf/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
@@ -15046,6 +15047,7 @@ M:	Jakub Kicinski <kuba@kernel.org>
 M:	Paolo Abeni <pabeni@redhat.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
+P:	Documentation/process/maintainer-netdev.rst
 Q:	https://patchwork.kernel.org/project/netdevbpf/list/
 B:	mailto:netdev@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
-- 
2.34.1


