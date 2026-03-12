Return-Path: <netdev+bounces-266962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGYII0GKsmneNQAAu9opvQ
	(envelope-from <netdev+bounces-266962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:41:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B73A526FC0A
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5F25301F4AE
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 09:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B7F383C92;
	Thu, 12 Mar 2026 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="C6Lu4bsi"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F04346E4A
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773308370; cv=none; b=iIYVloql/ScnPryDY4ZcFhiRTIGzCqG0UU6BVddiy2ZEFCPZPHJpEzUC92sj5JyY87/xnTgPzlRgXGXF68VPDBUdU6cv65f/EGIcc3nv3zEloG4nTcpFQTnygcJCyRL275ZH/24bF19aGB3RUi7fTPZhr3KELBNdWMQn56tTsPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773308370; c=relaxed/simple;
	bh=waxn5lg1OkJ81vpAot4XqDo5U1E/0wIZF/8vzZgbHvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=DIGxcg4O+HrWwdIFUenoFkyH1FHFqqYmj8RqfwIeeYOBQouQU+JjNYvqowZqxsHhI5LHtJu74ReGSlH2lmi3lM5Rcydb0SpHL0JlGqOXFjTkPGr2R06NGMmhQA2zwLZjpzK9WlcyUG5rvbUXxGKi5zseLX3Mm/laviDu0hn4SHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=C6Lu4bsi; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260312093920epoutp02528de209f5ff8157c12de17ed8ba24dd~cDo7mwRiK1713417134epoutp02c
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 09:39:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260312093920epoutp02528de209f5ff8157c12de17ed8ba24dd~cDo7mwRiK1713417134epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1773308360;
	bh=+ZCOO/9RglT0wYm4eT3M6QGG29/m5LTiAuu9agdSCWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C6Lu4bsi862/eA3NtwBvQZ3YYKfhG1rK74VVYv6ysaofKo2mdUerjIodggNuKlHzq
	 OAXGHnBoXzzqkbCLieGC4YTlx5fA8o6lYK8QJe4oZQjkhlwb+ohw6OvsmRnQwSq/jI
	 449A7fkSf7JBlePWKUvfWfr21z7tE01q+LlW+Uws=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260312093919epcas5p3050fcddf5a6bf90112f9dacf8a2916c4~cDo6yA-re3207032070epcas5p37;
	Thu, 12 Mar 2026 09:39:19 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4fWjHq1vCfz2SSKk; Thu, 12 Mar
	2026 09:39:19 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260312093918epcas5p31e466058a69bd8e2c585baeddd333f3c~cDo6Q6MOD3207032070epcas5p36;
	Thu, 12 Mar 2026 09:39:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [109.144.5.214]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260312093917epsmtip1c7daa8092ffae22297f8b5d120014f0a~cDo5VCk461145611456epsmtip1Z;
	Thu, 12 Mar 2026 09:39:17 +0000 (GMT)
From: Tailu Shi <tailu.shi@samsung.com>
To: Tailu Shi <tailu.shi@samsung.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>, Pauli Virtanen <pav@iki.fi>, Johan Hedberg
	<johan.hedberg@gmail.com>, "David S . Miller" <davem@davemloft.net>, Eric
	Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: ISO: add timestamp for outgoing HCI ISO
 packet
Date: Thu, 12 Mar 2026 17:38:49 +0800
Message-Id: <20260312165734.8ff3927d@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <9199a462-09be-402a-a47a-447e51a2f5a4@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260312093918epcas5p31e466058a69bd8e2c585baeddd333f3c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20260312093918epcas5p31e466058a69bd8e2c585baeddd333f3c
References: <CGME20260312093918epcas5p31e466058a69bd8e2c585baeddd333f3c@epcas5p3.samsung.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,iki.fi,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-266962-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samsung.com:dkim,samsung.com:email,samsung.com:mid,user.name:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tailu.shi@samsung.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: B73A526FC0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Paul,

Thank you for the review and the helpful suggestion about my name.

I have updated my Git configuration and amended the commit as you advised:

    git config --global user.name "Tailu Shi"
    git commit --amend -s --author="Tailu Shi <tailu.shi@samsung.com>"


On Wed, 11 Mar 2026 09:54:38 +0100 Paul Menzel wrote:
>> A corresponding userspace change is required for full functionality.
>> A reference implementation is available in PipeWire:
>> https://gitlab.freedesktop.org/shitailu/pipewire/-/commit/5b3bd74e15febb974c8737a64f31fd17e18cd11b
> 
> Is the timestamp correctly visible in the btmon trace?

Yes, it can be seen in the btmon trace. The test was performed on the
kernel 7.0.0‑rc1+, using BlueZ 5.85 and PipeWire 1.5.84 with the
'bluez5.iso-tx-timestamp' configuration option enabled.

But seems the btmon v5.85 and v5.86 fails to parse it directly with
the command. However, the 'ts' field can be seen clearly with Wireshark.

The things are like below:

1) btmon v5.86
 $ btmon -r dump.btsnoop -I |grep -A1 'ISO Data TX: Handle 2563'
 < ISO Data TX: Handle 2563 [5/18] SN 2                 #10999 [hci0] 128.571172
         02 00 3c 00 00 00 00 00 00 00 00 00 00 00 00 00  ..<.............
 --

2) Wireshark
 Frame 19604: 72 bytes on wire (576 bits), 72 bytes captured (576 bits)
 Bluetooth
 Bluetooth Linux Monitor Transport
 Bluetooth HCI ISO Packet
     .... 1010 0000 0011 = Connection Handle: 0xa03
     ..10 .... .... .... = PB Flag: Complete SDU (0x2)
     .1.. .... .... .... = Timestamp present: True
     0... .... .... .... = Reserved: 0x0
     ..00 0000 0100 0100 = Data Length: 68
     Data
     [Connect in frame: 18836]
 Bluetooth ISO Data
     Timestamp: 805103660µs
     Sequence Number: 84
     .... 0000 0011 1100 = SDU Length: 60
     SDU

Raw data:
 0000   03 6a 44 00 2c e8 fc 2f 54 00 3c 00 00 00 00 00   .jD.,../T.<.....
 0010   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
 0020   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
 0030   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
 0040   38 24 f9 4a 0d 00 00 03                           8$.J....


Thanks for your time again!

Best regards,

Tailu Shi

