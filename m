Return-Path: <netdev+bounces-62698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04940828A0B
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 17:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7261C214D3
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 16:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387811E4AF;
	Tue,  9 Jan 2024 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hVfc4zvB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86843A8C2
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704817974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7rLan97r9dfpudmUlqQAPAVhq/qZyL1OofQRtsU1jfI=;
	b=hVfc4zvBrE35OVIwTes7RpIieu7sYG+WmZWiPrAUj685zXtkhhXNpnoTH/dhrtojNwjQzZ
	WhRNCyYUZ0RIx3w5Krp38BeDl15Ni6g3ryNBHSN/u/jNL7A8Oau993NJCSraHUosUFWuY3
	MFziNPmTP8e0DxznNaACeO61EbEKFdc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-wGvH1pzJMP2LPSkWBkotMQ-1; Tue, 09 Jan 2024 11:32:51 -0500
X-MC-Unique: wGvH1pzJMP2LPSkWBkotMQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD3088371C0;
	Tue,  9 Jan 2024 16:32:50 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.193.254])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 515851C060AF;
	Tue,  9 Jan 2024 16:32:48 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: Leon Romanovsky <leon@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jon Maloy <jmaloy@redhat.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH iproute2 0/2] Fix some more typos in docs and comments
Date: Tue,  9 Jan 2024 17:32:33 +0100
Message-ID: <cover.1704816744.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Time for some start-of-the-year cleanup :)

Using codespell, fix most of the typos in iproute2 docs and comments,
except for some false positives. I didn't bother to report a Fixes tag
for all the typos, but I can do that if needed.

Andrea Claudi (2):
  docs, man: fix some typos
  treewide: fix typos in various comments

 devlink/devlink.c           | 2 +-
 doc/actions/actions-general | 2 +-
 examples/bpf/README         | 2 +-
 include/bpf_api.h           | 2 +-
 include/libiptc/libiptc.h   | 2 +-
 include/xt-internal.h       | 2 +-
 lib/json_print.c            | 2 +-
 man/man8/devlink-rate.8     | 2 +-
 rdma/rdma.h                 | 2 +-
 tc/em_canid.c               | 2 +-
 tc/m_gact.c                 | 2 +-
 tc/q_htb.c                  | 3 ++-
 tc/q_netem.c                | 2 +-
 tipc/README                 | 2 +-
 14 files changed, 15 insertions(+), 14 deletions(-)

-- 
2.43.0


