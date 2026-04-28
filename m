Return-Path: <netdev+bounces-281931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFnOJPnE8GloYQEAu9opvQ
	(envelope-from <netdev+bounces-281931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:32:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 35761487039
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7DAD93020FD9
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F58544D6AB;
	Tue, 28 Apr 2026 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lL7RGK5B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B09344102D;
	Tue, 28 Apr 2026 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386281; cv=none; b=UN6LuBK3ktVYbBUwvF3GZiyxP6BY9s7av7v2E9y8mhw587MhSfTuut28Y+VgZUrGfHg20kL+ywHqpXj7UT2TBwNrL0aECgg5UeGkc4uO6Lz1nX662l0keaoywtDWuRLVWpwOFQKmPVuOxNf50lpQHl01FlahiOex1BQz02uqQ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386281; c=relaxed/simple;
	bh=dUj11tovECtb++7ZbLbRkgmhCl35vkiey4e5gOXCPks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AmUy0RRBamY/DCWdoT9RTcVWW5x8AL8taGv7STm+ajVhIO0Afn3Hiuqma1TizIT/pDlhnmntdZm7+PQP71j/FsfEAy4W8lHdgSziQYrWZd9+z3ese1zLQWHFYvzYv5VyVdd5TeWlMzncZAdqeMVfkg559G5ZWfQsVP7FyH6sYtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lL7RGK5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96D49C2BCB5;
	Tue, 28 Apr 2026 14:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777386280;
	bh=dUj11tovECtb++7ZbLbRkgmhCl35vkiey4e5gOXCPks=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=lL7RGK5BPzUBePpgeYVf66A0JHxnj24nR1EuNPza/vneaMWV7ogThrAWiCvWtuyoz
	 b4pIV9BIIXOFLTF7j/UDNT+/3rWd9GZY2ynbLXq7QlCGefVxdK0spqKsWrawxFMJwy
	 tVNYbep/BsnnnzylcsrzR8mIcp9qp0qdyZimP8LUNDw9e/sKC35Hg30x9/wrQ4AVfk
	 Bwp5UPgGJDICdSRbEIiWYpxXs8NqYGglDQF/ZN8p4GdDEZEIThyTv5PM/7Kdrcqlnq
	 7iSM7I4wmqYV751ACoO4RdCMksQx8VLs2FBo0N7HDBqpEUxcrmwhbBjM0YP7Qy5jMf
	 WbX3gbGjiba8w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF5FFF8868;
	Tue, 28 Apr 2026 14:24:40 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Tue, 28 Apr 2026 16:24:38 +0200
Subject: [PATCH net] MAINTAINERS: Add myself as NFC subsystem maintainer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-nfc-maintainer-v1-1-4cb9d9e121f3@ixit.cz>
X-B4-Tracking: v=1; b=H4sIACXD8GkC/x2MQQqAIBAAvxJ7TjCLtL4SHUzX2kNbqEQQ/T3pM
 Ic5zDyQMBImGKsHIl6U6OAiTV2B2yyvKMgXByVVLztlBAcndkucCxiFWgxK3Q5SOw8lOiMGuv/
 hBIwZ5vf9AM4Q/sFlAAAA
X-Change-ID: 20260428-nfc-maintainer-2b8e073907cd
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 oe-linux-nfc@lists.linux.dev, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1098; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=l6GCIdQ39L6+WcAMCIoelwcZypwDUixePdWvyKCAZ8Q=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBp8MMnHps7MFKV1kNGTk/fEYaGbLDN8GvIuYFWB
 j50YZGtST+JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCafDDJwAKCRBgAj/E00kg
 ciVjD/9EOsjFTYPuYzrgDUFKmKvA59BuFz4TJgTbiiIpawkjUtFOxUJOFgT5A4KrWj9q+oAOWoe
 Omkz3QmXQQfeWaT2j3OvVBNT/dhK5TFgmZxxn3lA9D3/TsCP//NA+4kYFKBLHVlLP3xKDws3ewL
 fFFauToM2i6xjl6o4zbsC8dcvxohaSRJUhywQKxBT5CNoy/UJjY1yHOF5unb5LqO1phg4gaFTfM
 V2vvWkcREEUoDeFr/9NnyAtfd/FGIQV0xNR1nGjXajx84pB7sc8MMOaBzV9eV6nPsYxccdbo9XN
 nGHbH48zeHtG73EzHXHNBzeexq3WneJurwOdMm2ZyI4n4hlHre6S2j0s5UWdZJvnI7nHr/3c5QO
 5M8uIaH82aaovaItqnf3JGXmvG842ursIaUZ5nu13AoYnJ7aP0lNc7Wl0X2H1Fff4nTYnEl0p60
 kZfjysqWaX6i2mH/CfHsFOEYl56EadnpMlfhpsPSb/iHn0YftxYHF67Q5PztMvnWC7s+5i9KCt8
 s5vJeZbXkpeWCB9UsxFMl7AlnnsDG6wWw5DECNQ4BMFfq0eHNI0+G/6sfyTbHj3U7WWEpWDsi/z
 +FqJVppBOKOGcFw/cRln0zveKBBcrlFA8DNKZB2u2FUd3Cxk4L9VB0VXLsLVPSvh+LyP+B8lwUd
 6xQBsNV7hXw/B2Q==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz
X-Rspamd-Queue-Id: 35761487039
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281931-lists,netdev=lfdr.de,david.ixit.cz];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[david@ixit.cz];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,codeberg.org:url]

From: David Heidelberg <david@ixit.cz>

Add myself and update the mailing list.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 21288a3a7d930..176390ef4275d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18824,18 +18824,20 @@ M:	David Ahern <dsahern@kernel.org>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	include/net/netns/nexthop.h
 F:	include/net/nexthop.h
 F:	include/uapi/linux/nexthop.h
 F:	net/ipv4/nexthop.c
 
 NFC SUBSYSTEM
-L:	netdev@vger.kernel.org
-S:	Orphan
+M:	David Heidelberg <david+nfc@ixit.cz>
+L:	oe-linux-nfc@lists.linux.dev
+S:	Maintained
+T:	git https://codeberg.org/linux-nfc/linux.git
 F:	Documentation/devicetree/bindings/net/nfc/
 F:	drivers/nfc/
 F:	include/net/nfc/
 F:	include/uapi/linux/nfc.h
 F:	net/nfc/
 
 NFC VIRTUAL NCI DEVICE DRIVER
 M:	Bongsu Jeon <bongsu.jeon@samsung.com>

---
base-commit: 46f74a3f7d57d9cc0110b09cbc8163fa0a01afa2
change-id: 20260428-nfc-maintainer-2b8e073907cd

Best regards,
-- 
David Heidelberg <david@ixit.cz>



