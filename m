Return-Path: <netdev+bounces-62691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D23828912
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 16:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068491C23955
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 15:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FDC39FDD;
	Tue,  9 Jan 2024 15:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDvpf4af"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DD03A264
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704814455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QSe46n2sgaqVGu+gacWZG06JFpsVFXYHytEZmABVCXw=;
	b=GDvpf4afppcWy4HnIniMMjH6r9ZwdmZr6RO6QmKiA+xJOuCrU+VZBgtOjpa9kK58peFpts
	2elM8B+GoopbHmCA2kJuBLueAJV86mZqjUZ9C4vCktmj3UqClsfuhY6qbT9Uw7tN8WGEzC
	APL/t+dtopF+ZVm56Izp/RH5cSX6G74=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-bbPNbgavMtCnFQa3wVctmg-1; Tue,
 09 Jan 2024 10:34:12 -0500
X-MC-Unique: bbPNbgavMtCnFQa3wVctmg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADF3B1C04B62;
	Tue,  9 Jan 2024 15:34:11 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.193.254])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E58CC492BC7;
	Tue,  9 Jan 2024 15:34:09 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <hadi@cyberus.ca>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH iproute2 0/2] Fix typos in two error messages
Date: Tue,  9 Jan 2024 16:33:52 +0100
Message-ID: <cover.1704813773.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Fix spelling for "cannot" in two different places.

Andrea Claudi (2):
  iplink_xstats: spelling fix in error message
  genl: ctrl.c: spelling fix in error message

 genl/ctrl.c        | 2 +-
 ip/iplink_xstats.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.43.0


