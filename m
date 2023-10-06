Return-Path: <netdev+bounces-38621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661FE7BBB70
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 17:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154941C20BBA
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 15:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB482771A;
	Fri,  6 Oct 2023 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O1tb885t"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E20A273F9
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 15:13:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5A9CE
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 08:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696605186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NHY6LRSsGEtAVXNDOjO62ecbXXwm9UaRIIe77pDYtx0=;
	b=O1tb885tyvw3lHkKmR/vywfZwhAGrElo4zLlJnPEQSyoqYgzmGLlXrQYYzbFFuC4wMWzfE
	xdNHWGFTKtYkNqyEgNfjz9d7kqJQehE1xHLYAbO43w3Z700ZbcFrROInIIUk0/wGSDM/LT
	yqnVouVDp9VbSFuI3p3Ipr3wbHuqSSM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-43-ndJne-f3MimyL-7m1yU1rg-1; Fri, 06 Oct 2023 11:13:00 -0400
X-MC-Unique: ndJne-f3MimyL-7m1yU1rg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B244C3801EF5;
	Fri,  6 Oct 2023 15:12:59 +0000 (UTC)
Received: from RHTPC1VM0NT.lan (unknown [10.22.33.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EB37440D1BE;
	Fri,  6 Oct 2023 15:12:58 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Adrian Moreno <amorenoz@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>
Subject: [PATCH net 0/4] selftests: openvswitch: Minor fixes for some systems
Date: Fri,  6 Oct 2023 11:12:54 -0400
Message-Id: <20231006151258.983906-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

A number of corner cases were caught when trying to run the selftests on
older systems.  Missed skip conditions, some error cases, and outdated
python setups would all report failures but the issue would actually be
related to some other condition rather than the selftest suite.

Address these individual cases.

Aaron Conole (4):
  selftests: openvswitch: Add version check for pyroute2
  selftests: openvswitch: Catch cases where the tests are killed
  selftests: openvswitch: Skip drop testing on older kernels
  selftests: openvswitch: Fix the ct_tuple for v4

 .../selftests/net/openvswitch/openvswitch.sh  | 21 ++++++++-
 .../selftests/net/openvswitch/ovs-dpctl.py    | 46 ++++++++++++++++++-
 2 files changed, 65 insertions(+), 2 deletions(-)

-- 
2.40.1


