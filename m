Return-Path: <netdev+bounces-273495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFMNO5l7y2lPIQYAu9opvQ
	(envelope-from <netdev+bounces-273495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 09:45:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 851BD3656D1
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 09:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7102230388D7
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9776C3CE49D;
	Tue, 31 Mar 2026 07:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="eHz+Rjai"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02153CCFAC
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 07:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774942883; cv=none; b=KuQgMmxuZXVbvArT+3pnC70vUgrQU0gDPfdLKWwl5yiDPKWT6l9rczf6Mq8vDSHLunZ5RPCItypH5sKTCNsS675RtQyEA8els6czPG6tjwF/PwpbJCrDtx9zwXWY3fWC4LN68JrfDL9vMUx2AYAfyrcxu2QWQ9mNiSFpmOUGAUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774942883; c=relaxed/simple;
	bh=CzfHviRRb4WgI5u8GBb8WCzBLUt3YnhB4UP5WqepO8g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sAiau7GqmClAjOamI93UFwMrPQT50QOKVpubUiQZ+Z5G4fht3qwntye4wZRf7BMLma3Q/yNCids5VPH/8yPbw3ggWQjqVxh6UnbPiT3QiwkBJKGdvHfjACEGIfJMPTxWIo+GxK9zFgMscK+Iyi2EEiOrWYjAa6DVPKnhYk4EYkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=eHz+Rjai; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1774942877;
	bh=kFhTqmyb5vBLQQ9IN9gs3jf4VQ0/t4peB1Fk9r8GXpI=;
	h=From:Subject:Date:To:Cc;
	b=eHz+RjaiLcC02wNq4nz7XfKcgI1X61TqtuqVXdA6WRStktgoTgg26RWierK1wdxo3
	 VlC4X9xJz7fAlixsRg/Nh67wgu/73O0WGz0kV35CalLJoWbptDcQyofo6+wJp1ynsS
	 jopiGwt6xeDNGQnbHzyy4v0dlGziubtv2XK6hOvNdzNN5+QY+TCP5uqcnUybO1ii7W
	 VQld8mWGUdlwQ8n04kSfA5OQO+7yHjROTMr+WiKKNjkUF7ykquTS++qD481rnaZaY6
	 zfpOleFM2tGLRDEuWqRKl5PpAXi7k9IcreP5QZ8T8YeL2KTYHh4Ky3+koYVSOm7/EX
	 7yVqGRRazDlnw==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 79DA665DF3; Tue, 31 Mar 2026 15:41:17 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Subject: [PATCH net-next 0/3] net: mctp: improvements for NULL-EID
 addressing
Date: Tue, 31 Mar 2026 15:41:05 +0800
Message-Id: <20260331-dev-mctp-null-eids-v1-0-b4d047372eaf@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJF6y2kC/yWN0QqDMBAEf0XuuQdJbBT6K8UHMdt6oFebRBHEf
 2+oj8OwswclREGiR3VQxCZJPlrA3ioaxl7fYAmFyRnXmNrdOWDjecgL6zpNDAmJjbe+tdbVHqA
 yXCJesv+jT1JkVuyZustEfNfyki/dnecPdp/O54MAAAA=
X-Change-ID: 20260324-dev-mctp-null-eids-0515711235ee
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273495-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,codeconstruct.com.au:dkim,codeconstruct.com.au:email,codeconstruct.com.au:mid]
X-Rspamd-Queue-Id: 851BD3656D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, our focus for the MCTP routing implementation has been for
MCTP bus-owner devices. In this case, we will generally have an EID
assigned during local transmit, and have routes established before
expecting to receive.

We also want to handle non-bus-owner cases, where:

 - we may need to send control protocol messages (like Discovery Notify)
   before any local addresses have been assigned, particularly as part
   of acquiring a local address assignment; and

 - we will likely want to receive incoming messages before we have
   routing established.

This series improves handling for these cases, by handling NULL EIDs
as source / destination addresses where possible.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
Jeremy Kerr (3):
      net: mctp: perform source address lookups when we populate our dst
      net: mctp: allow local TX with no address assigned
      net: mctp: don't require a route for null-EID ingress

 include/net/mctp.h         |   1 +
 net/mctp/route.c           |  92 +++++++++++------------
 net/mctp/test/route-test.c | 180 ++++++++++++++++++++++++++++++++++++++++++---
 net/mctp/test/utils.c      |  27 +++++++
 net/mctp/test/utils.h      |   1 +
 5 files changed, 242 insertions(+), 59 deletions(-)
---
base-commit: 7fae6616704a17c64438ad4b73a6effa6c03ffda
change-id: 20260324-dev-mctp-null-eids-0515711235ee

Best regards,
-- 
Jeremy Kerr <jk@codeconstruct.com.au>


