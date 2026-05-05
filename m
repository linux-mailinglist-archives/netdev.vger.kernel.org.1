Return-Path: <netdev+bounces-284295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKQLKhPA+WlADAMAu9opvQ
	(envelope-from <netdev+bounces-284295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 12:01:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8134CA561
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 12:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3886E308CE3E
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 09:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6151331E82B;
	Tue,  5 May 2026 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDLH58H/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DACF3128CC;
	Tue,  5 May 2026 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974852; cv=none; b=NCpGLtWmdQDYLoezGzsrRGqCPFx9qHExN6t37uyGLW4rHC899hh1g4c5L/jjV6ajAfxKJ3ITE52AiLpQb6wz0wn4hHmd9ARDq3rtVDLbNDyG9ZE0ZkB9Ry4atKYF6Kx3xBk9lqFveOigIIJiL9OjCKmXIWsCSVmJuD8OfJA92B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974852; c=relaxed/simple;
	bh=ljBg5MPuzVyhYDJtkIW+tx52g+ttq1kXUhKBBbphMW8=;
	h=From:Date:Message-ID:To:Cc:Cc:Cc:Cc:Subject; b=qJpmGKQtagDqdijHDvsxi+jBitZdM3+YFDslPAL2F/1XHrDlRAyAxvw/60F9NGZ5slmHraIPncovARF+Ov1NwOWvsIAKu6rotFt4n5kok7GJTckf3P912PIk4VrtBGO6xfMhJmlHySlis7BMRE9uYk5sq2NyDWUXUEE2L7Cl6bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDLH58H/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9B1C2BCB4;
	Tue,  5 May 2026 09:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777974852;
	bh=ljBg5MPuzVyhYDJtkIW+tx52g+ttq1kXUhKBBbphMW8=;
	h=From:Date:To:Cc:Cc:Cc:Cc:Subject:From;
	b=CDLH58H/dwJlBnW/gD4Z2epohc1F2gPiFE8RU93n0+1VxPOkjNQD6BDYi32MrMrj7
	 gNbjFW0CjP77jN0za26N3QD17l9oX2xB4RbTMaGy4JH8q2ZjlGodnyTSqfQ6Q8n7Ag
	 qNxB6DHJs49ToB8I5TZMRC3WkNc9um0eTMo7kPUtRHFfAmMabPJtjuQM/AMbyMAYoa
	 JgQxb7QVLGYoaMJN/R8GRu8D/kJ1d05hmmpjm2NhiJAfGKLUEywKJv/GyVO35E04PD
	 w2xDSaAoLEAhO447Wa6j8r3c00nx9/NtOm29Vg1t1C8NRhEg83/Gf0dcZfnQ/fXZmk
	 t+Twv5sfHlc1g==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Tue, 05 May 2026 11:54:09 +0200
Message-ID: <a7365e4873340f7a5e30411207de3bf9@kernel.org>>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Ujjal Roy <royujjal@gmail.com>
Subject: linux-next: manual merge of the net-next tree with the net/main tree
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 4B8134CA561
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.44 / 15.00];
	INVALID_MSGID(1.70)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	MULTIPLE_UNIQUE_HEADERS(0.70)[Cc];
	MID_MISSING_BRACKETS(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-284295-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thierry.reding@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_SPAM(0.00)[0.726];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[kernel.org:-]

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/ipv4/igmp.c

between commit:

  c6bebaa744f7 ("ipv4: igmp: annotate data-races in igmp_heard_query()")

from the net/main tree and commit:

  726fa7da2d8c ("ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc net/ipv4/igmp.c
index a9ad39064f3b,d7eff36d98c3..27d120183779
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@@ -1028,10 -1015,9 +1028,10 @@@ static bool igmp_heard_query(struct in_
                 * received value was zero, use the default or statically
                 * configured value.
                 */
 -              in_dev->mr_qrv = ih3->qrv ?: READ_ONCE(net->ipv4.sysctl_igmp_qrv);
 -              in_dev->mr_qi = igmpv3_qqi(ih3) * HZ ? : IGMP_QUERY_INTERVAL;
 -
 +              WRITE_ONCE(in_dev->mr_qrv,
 +                         ih3->qrv ?: READ_ONCE(net->ipv4.sysctl_igmp_qrv));
-               mr_qi = IGMPV3_QQIC(ih3->qqic)*HZ ?: IGMP_QUERY_INTERVAL;
++              mr_qi = igmpv3_qqi(ih3) * HZ ? : IGMP_QUERY_INTERVAL;
 +              WRITE_ONCE(in_dev->mr_qi, mr_qi);
                /* RFC3376, 8.3. Query Response Interval:
                 * The number of seconds represented by the [Query Response
                 * Interval] must be less than the [Query Interval].

