Return-Path: <netdev+bounces-202255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64041AECF3B
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 19:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9746F3B1E49
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 17:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5621AC88B;
	Sun, 29 Jun 2025 17:32:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587C03B7A8;
	Sun, 29 Jun 2025 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751218367; cv=none; b=IlpCKL80wUf32Fy/nEVQdAS3AOHj2NoLHgqr68SdP6MFz8RIjMJxM9RmRE/ZsnUdMvka7EOBpoLD7YhVkQx9VHU9/uuzmZQ4p4u8LW8L7jIv2RdjYhfGqWSVKwJnRx49tw2brWFq6gw55ehng/NSCu2W6YlVk8wlOvcxvK8te6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751218367; c=relaxed/simple;
	bh=iRRBDWS7fH+DB1fmRlKKTFUe1wy/pIKEUTSTVJMi0ls=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HeCYeviSc58sddxVauXls+ub0ritsSvesmR6xgceTLhk3FXmVctQUomm6dXT17Avm6XchttN6MdoZJfL/2QDOnbXXrNFJRp0dJflefFvY0AVFHY9LGkGH68zDGVPp/IvmyHhsrKd3QmxZ9ta3teoefqcq7ISA6Y58OyihmzOnbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; arc=none smtp.client-ip=160.80.4.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from localhost.localdomain ([160.80.103.126])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 55THDW58007121
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 29 Jun 2025 19:13:33 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
        Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [PATCH net-next 0/2] seg6: fix typos in comments within the SRv6 subsystem 
Date: Sun, 29 Jun 2025 19:12:24 +0200
Message-Id: <20250629171226.4988-1-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

In this patchset, we correct some typos found both in the SRv6 Endpoints
implementation (i.e., seg6local) and in some SRv6 selftests, using
codespell.

The patchset is organized as follows:
  Patch 1/2: seg6: fix lenghts typo in a comment
  Patch 2/2: selftests: seg6: fix instaces typo in comments

Thanks,
Andrea

Andrea Mayer (2):
  seg6: fix lenghts typo in a comment
  selftests: seg6: fix instaces typo in comments

 net/ipv6/seg6_local.c                                          | 2 +-
 tools/testing/selftests/net/srv6_end_next_csid_l3vpn_test.sh   | 2 +-
 tools/testing/selftests/net/srv6_end_x_next_csid_l3vpn_test.sh | 2 +-
 tools/testing/selftests/net/srv6_hencap_red_l3vpn_test.sh      | 2 +-
 tools/testing/selftests/net/srv6_hl2encap_red_l2vpn_test.sh    | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.20.1


