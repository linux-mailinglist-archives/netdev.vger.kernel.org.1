Return-Path: <netdev+bounces-33264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD24079D394
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18EEC1C20EDF
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 14:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5B818B00;
	Tue, 12 Sep 2023 14:28:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F50182CE
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 14:28:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F711CC3
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 07:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694528930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oE11JWnC3jUouoGT5MuENSIwomX89P/A74rN4eXouQU=;
	b=AqGdbi9kVf8fUX4E16DVaLWWCLe7st/KbFUYkchKGD2BEhSQ95cGd4H0ZFd5riDOQN5pY6
	+uNubr+BYoX+A+eyLOpmTAWQMZyhSxVt+anU5Dkzw0WljdMFCSaGp5HjWFutTvGQP9oryu
	v1MvOe/zSGgT2YLW9rpmgon6Zp4pUCQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103-Hba1yqqxPFutbKHoWNXJKg-1; Tue, 12 Sep 2023 10:28:47 -0400
X-MC-Unique: Hba1yqqxPFutbKHoWNXJKg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7ABB29AB3E3;
	Tue, 12 Sep 2023 14:28:46 +0000 (UTC)
Received: from dmendes-thinkpadt14sgen2i.remote.csb (unknown [10.22.18.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C10917B62;
	Tue, 12 Sep 2023 14:28:44 +0000 (UTC)
From: Daniel Mendes <dmendes@redhat.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sd@queasysnail.net
Subject: [PATCH net-next 0/2] kselftest: rtnetlink: add additional command line options
Date: Tue, 12 Sep 2023 10:28:34 -0400
Message-ID: <cover.1694527251.git.dmendes@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5

Many other tests implement options like verbose, pause, and pause
on failure. These patches just add these options to rtnetlink.sh.
The same conventions are used as the tests that already have this
functionality: eg verbose is 0 or 1 but PAUSE is "yes" or "no".

Daniel Mendes (2):
  kselftest: rtnetlink.sh: add verbose flag
  kselftest: rtnetlink: add pause and pause on fail flag

 tools/testing/selftests/net/rtnetlink.sh | 981 +++++++++--------------
 1 file changed, 400 insertions(+), 581 deletions(-)

-- 
2.41.0


