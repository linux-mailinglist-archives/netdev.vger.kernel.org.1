Return-Path: <netdev+bounces-275489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBNtI2LU0mm7bQcAu9opvQ
	(envelope-from <netdev+bounces-275489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 23:30:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 458C639FDFA
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 23:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C01F300342D
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 21:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1074E384228;
	Sun,  5 Apr 2026 21:29:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38F2382F0D;
	Sun,  5 Apr 2026 21:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775424582; cv=none; b=Ew5p+CSMmF2+vp6ICBxasGH4pYDvfOGmHatmCEZrzNKz47mx4tlAHvVbmhw0qDG1lYX0r8backoFTz9DhpKmYcJNtSM8omgxvtR/zJEJoE71MKsBFwxefVkozu5dOM909wSZCfo96VxIROYWbEWfuAyw8F/5CPAiVf+rPOZxlG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775424582; c=relaxed/simple;
	bh=ENtHUUCS6TwzO+/QPpuNyTsxeZ/HIpV7yozE2eg8xzU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o99M0RKFWWeiUU1OptG676S+YDw8FDqm/0TQlYLkN6oRLIShPAghAPDOaB13MhNmZS8N1xA56blx/3Kz71BGVvvV1auWXTPnbbJ6tLUigmgssbAZsJE4AtexMbNrPXbklTU/b1vv6G/mhegCZOROs0CzaWc4j52bhBPMUlg3WdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w9V26-000000000jh-3OPx;
	Sun, 05 Apr 2026 21:29:26 +0000
Date: Sun, 5 Apr 2026 22:29:19 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: John Crispin <john@phrozen.org>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH net] selftests: net: bridge_vlan_mcast: wait for h1 before
 querier check
Message-ID: <c830f130860fd2efae08bfb9e5b25fd028e58ce5.1775424423.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275489-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.917];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 458C639FDFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The querier-interval test adds h1 (currently a slave of the VRF created
by simple_if_init) to a temporary bridge br1 acting as an outside IGMP
querier. The kernel VRF driver (drivers/net/vrf.c) calls cycle_netdev()
on every slave add and remove, toggling the interface admin-down then up.
Phylink takes the PHY down during the admin-down half of that cycle.
Since h1 and swp1 are cable-connected, swp1 also loses its link may need
several seconds to re-negotiate.

Use setup_wait_dev $h1 0 which waits for h1 to return to UP state, so the
test can rely on the link being back up at this point.

Fixes: 4d8610ee8bd77 ("selftests: net: bridge: add vlan mcast_querier_interval tests")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
index 72dfbeaf56b92..e8031f68200ad 100755
--- a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
@@ -414,6 +414,7 @@ vlmc_querier_intvl_test()
 	bridge vlan add vid 10 dev br1 self pvid untagged
 	ip link set dev $h1 master br1
 	ip link set dev br1 up
+	setup_wait_dev $h1 0
 	bridge vlan add vid 10 dev $h1 master
 	bridge vlan global set vid 10 dev br1 mcast_snooping 1 mcast_querier 1
 	sleep 2
-- 
2.53.0

