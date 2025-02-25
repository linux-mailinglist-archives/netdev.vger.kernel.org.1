Return-Path: <netdev+bounces-169556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAB4A44957
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F4E1896251
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2088207E13;
	Tue, 25 Feb 2025 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="Tg3b31cV"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B445B1DDC18
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506394; cv=none; b=C0XV4sG7c3VzX3QizvvfnyBf+MM88FmbYaXOAJ5mrOyd0C6zUaMBmfaPAxRJhT4XHtokL7oObvbqJMdidUHpAVd0I1HR3OeVZo1tU3TGMEe/Kp/RP3R2eeMiJEzO/dN13t1K/l+mUSu27cVFTMTpXcZk4r3Dqhqmq1WBuV/A5Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506394; c=relaxed/simple;
	bh=e2qrNWHQlrco/TlbJJD9+MqbDCYN9yBYsbRIwg5LMjo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nX+ne7pld1JghcceoNopslOZ66jE/5ifBZeFzdNVGqm5JHRHp9xZBXHaXLDODeufqEB1BnOBre2zHfGb4+qpiKLXVlxfYrWUUczw3lRsaoCQXmfL+wMd74IgOzjdpTbbN5RNMYi9xuhRB2Znq8S8l43BNkczpLrpBEw+gfKmWfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=Tg3b31cV; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 351002061B5D;
	Tue, 25 Feb 2025 18:51:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 351002061B5D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1740505907;
	bh=A8flFULP+aWoFhHR2dXDLbnzvef2/aTEEWDnxClAoLI=;
	h=From:To:Cc:Subject:Date:From;
	b=Tg3b31cVGP3bXzXO1HCtO8mOehOrwgQKolrZqlcmGLnZh97X+z2B1qd0ouX9nUHrR
	 MwraKSrB8EO/whDPgrvdg5RjbKOVUsywbr8aP4JoTQLXifxpmHC9CQ7G9Zutq+fkHV
	 b9gx8t23ACEUr0pkmwYKMUSXGpAnPMYMLTwcJFBt0EhxTXt9Ih6Av5cMwFtbYH6UEb
	 sj5h9LX4z0V4ABC7240c625qHbSHBCLefgnJky1P1RX0HsJYXFGrkjM5ZshZeOHCpT
	 69BBgWyNulNmJDHum0jaK1fwKCzJOk1h0DiTNrsvAmsfDE6B0pGGr/xOfEZ8SO88MD
	 /TfmTRsgGeARw==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net v3 0/2] fixes for seg6 and rpl lwtunnels on input
Date: Tue, 25 Feb 2025 18:51:37 +0100
Message-Id: <20250225175139.25239-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3:
- split patch #1 from -v2 into two separate patches
- drop patches #2 and #3 from -v2: they will be addressed later with
  another series, so that we don't block this one
v2:
- https://lore.kernel.org/netdev/20250211221624.18435-1-justin.iurman@uliege.be/
v1:
- https://lore.kernel.org/netdev/20250209193840.20509-1-justin.iurman@uliege.be/

As a follow up to commit 92191dd10730 ("net: ipv6: fix dst ref loops in
rpl, seg6 and ioam6 lwtunnels"), we also need a conditional dst cache on
input for seg6_iptunnel and rpl_iptunnel to prevent dst ref loops (i.e.,
if the packet destination did not change, we may end up recording a
reference to the lwtunnel in its own cache, and the lwtunnel state will
never be freed). This series provides a fix to respectively prevent a
dst ref loop on input in seg6_iptunnel and rpl_iptunnel.

Justin Iurman (2):
  net: ipv6: fix dst ref loop on input in seg6 lwt
  net: ipv6: fix dst ref loop on input in rpl lwt

 net/ipv6/rpl_iptunnel.c  | 14 ++++++++++++--
 net/ipv6/seg6_iptunnel.c | 14 ++++++++++++--
 2 files changed, 24 insertions(+), 4 deletions(-)

-- 
2.34.1


