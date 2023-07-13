Return-Path: <netdev+bounces-17589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F89975235C
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 15:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A55281D2B
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 13:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52F01078F;
	Thu, 13 Jul 2023 13:20:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9505101C0
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 13:20:43 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C402710
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 06:20:32 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-d28lCVOnM46F5xmYMZv0lA-1; Thu, 13 Jul 2023 09:20:29 -0400
X-MC-Unique: d28lCVOnM46F5xmYMZv0lA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 391B0185A792;
	Thu, 13 Jul 2023 13:20:29 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.224.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 402D02166B27;
	Thu, 13 Jul 2023 13:20:28 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	kuba@kernel.org,
	simon.horman@corigine.com,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v3 0/2] add MACsec offload selftests
Date: Thu, 13 Jul 2023 15:20:22 +0200
Message-Id: <cover.1689173906.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Patch 1 adds MACsec offload to netdevsim (unchanged from v2).

Patch 2 adds a corresponding selftest to the rtnetlink testsuite.

Sabrina Dubroca (2):
  netdevsim: add dummy macsec offload
  selftests: rtnetlink: add MACsec offload tests

 drivers/net/netdevsim/Makefile           |   4 +
 drivers/net/netdevsim/macsec.c           | 356 +++++++++++++++++++++++
 drivers/net/netdevsim/netdev.c           |   3 +
 drivers/net/netdevsim/netdevsim.h        |  34 +++
 tools/testing/selftests/net/rtnetlink.sh |  83 ++++++
 5 files changed, 480 insertions(+)
 create mode 100644 drivers/net/netdevsim/macsec.c

--=20
2.40.1


