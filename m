Return-Path: <netdev+bounces-45867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BAF7DFF9D
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 09:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E22AB2124B
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 08:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818AD79D1;
	Fri,  3 Nov 2023 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMVIWKz9"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F7479D0
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 08:11:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AC4D44
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 01:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698999094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JBH8NI3gflS6BfDv3RcBeVDFbPLiB4RONxRHKrnGmXk=;
	b=JMVIWKz92yMaHRx1C8gDPGuiAXIQDbdEFiK4xci1f33Ee6g434Z64Wkr6v2jI4k+nNByh1
	mjCeVuCrhY2f3/DVIVbVDsRELoph7EfPY0QEDlj1oupTp2xSBuwvKunIfGLzAu8letUBVE
	Lw9OWV1tzf5FDyaUZsF8gb0relw0wg0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-CGiopjSmP-OscmcE6w5ZwA-1; Fri, 03 Nov 2023 04:11:30 -0400
X-MC-Unique: CGiopjSmP-OscmcE6w5ZwA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36D7183B8E4;
	Fri,  3 Nov 2023 08:11:30 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.45.225.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3D0DEC1290F;
	Fri,  3 Nov 2023 08:11:28 +0000 (UTC)
From: Artem Savkov <asavkov@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Artem Savkov <asavkov@redhat.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH bpf-next] bpftool: fix prog object type in manpage
Date: Fri,  3 Nov 2023 09:11:26 +0100
Message-ID: <20231103081126.170034-1-asavkov@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

bpftool's man page lists "program" as one of possible values for OBJECT,
while in fact bpftool accepts "prog" instead.

Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 tools/bpf/bpftool/Documentation/bpftool.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool.rst b/tools/bpf/bpftool/Documentation/bpftool.rst
index 6965c94dfdafe..09e4f2ff5658b 100644
--- a/tools/bpf/bpftool/Documentation/bpftool.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool.rst
@@ -20,7 +20,7 @@ SYNOPSIS
 
 	**bpftool** **version**
 
-	*OBJECT* := { **map** | **program** | **link** | **cgroup** | **perf** | **net** | **feature** |
+	*OBJECT* := { **map** | **prog** | **link** | **cgroup** | **perf** | **net** | **feature** |
 	**btf** | **gen** | **struct_ops** | **iter** }
 
 	*OPTIONS* := { { **-V** | **--version** } | |COMMON_OPTIONS| }
-- 
2.41.0


