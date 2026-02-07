Return-Path: <netdev+bounces-257696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJxcO2OjhmkPPgQAu9opvQ
	(envelope-from <netdev+bounces-257696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 03:28:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F35104A54
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 03:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90A41309E41D
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 02:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003CE33031B;
	Sat,  7 Feb 2026 02:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot9ciEyC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE60C30DD2A;
	Sat,  7 Feb 2026 02:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770431103; cv=none; b=lzgv2/N6a8UhSTQyYlx6wUhnT6ztTWOqWEumR7JoekuGrukv/Ok2A85GmL8UG/ZV4AlAOVjKLrI+Mrnq3lBqLgOx+o1XXoRDdSWhDnsXpTdzRVlxKwMDtHvV3u6f3p0P5DgcgdgrnUe1j6J2yJj12r5+EX6G/TCMAw406N+bMNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770431103; c=relaxed/simple;
	bh=PCXbnF2EQLK44+2o8Oz14Mi1hrN0LEzJ+1wsy1UfbXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kw4BuOUMSgbttwOFxS++MvzntO7C02ZinKk3R2h2nPMYa5OsBoMmMg7yi1yh9rfBCX/zJTiY3cyhDXkC9bvbfS+3DYtKadx1SlXXqx2IJ4n4gu9r6jobT2GJC0tGtXhBiEAQVS2hUvmaMxT1ydpTdb0yfy4Gl5OwZSZCkwoJ02o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ot9ciEyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2329C116C6;
	Sat,  7 Feb 2026 02:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770431101;
	bh=PCXbnF2EQLK44+2o8Oz14Mi1hrN0LEzJ+1wsy1UfbXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ot9ciEyC9Y7Q7C7e493SRWodPfV17QFBDS+zyleKDOtD2WDdRcff03YZ0ET4DdPrY
	 UoM+v2XSVOI2pUxKHFLi0hkjYWQFZj1aSRyMsFlEENbp6Oz+wnf5y5jcTiw2OdAstQ
	 zEGMLFAGBl9BBXvSjMhnJ+vna01AUXbASkKMu52AW+QSBDvKB2tzEFiOBspFlGCR0V
	 JkzT7jNEDfBimYWRMg0FFlR8lH20pUBJJgpXDc3bssblayDNAPEAUycP9LRh93Ic17
	 PU6OzRo6N83iSZhOcJucisBoMDQfVaAk9uSaMgEZ+wLnSUy0BqVy+3jM1CPdx5JirP
	 pqOiFn3Io/fqQ==
From: Jakub Kicinski <kuba@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	sam.chen@nebula-matrix.com,
	lukas.bulwahn@redhat.com,
	dimon.zhao@nebula-matrix.com,
	netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	linux-kernel@vger.kernel.org (open list),
	corbet@lwn.net,
	lorenzo@kernel.org,
	alvin.wang@nebula-matrix.com,
	andrew+netdev@lunn.ch,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org
Subject: Re: [v4,net-next,08/11] net/nebula-matrix: add vsi resource implementation
Date: Fri,  6 Feb 2026 18:24:59 -0800
Message-ID: <20260207022459.4017950-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206021608.85381-9-illusion.wang@nebula-matrix.com>
References: <20260206021608.85381-9-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-257696-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 56F35104A54
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email says "This is an automated AI code reviewer, please treat what
it says with a grain of salt."

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/nebula-matrix: add vsi resource implementation

This patch adds vsi (virtual station interface) resource implementation
to the nebula-matrix driver, including initialization for various
chip modules such as dped, uped, dsch, ustore, dstore, dvn, uvn, and uqm.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> index 837a4591849d..a34dad884b47 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c

[ ... ]

> +static int nbl_ustore_init(struct nbl_hw_mgt *hw_mgt, u8 eth_num)
> +{
> +	struct nbl_ustore_port_drop_th drop_th;
> +	struct ustore_pkt_len pkt_len;
> +	int i;
> +
> +	nbl_hw_rd_regs(hw_mgt, NBL_USTORE_PKT_LEN_ADDR, (u8 *)&pkt_len,
> +		       sizeof(pkt_len));
> +	/* min arp packet length 42 (14 + 28) */
> +	pkt_len.min = 42;
> +	nbl_hw_wr_regs(hw_mgt, NBL_USTORE_PKT_LEN_ADDR, (u8 *)&pkt_len,
> +		       sizeof(pkt_len));
> +
> +	drop_th.en = 1;
> +	if (eth_num == 1)
> +		drop_th.disc_th = NBL_USTORE_SIGNLE_ETH_DROP_TH;
> +	else if (eth_num == 2)
> +		drop_th.disc_th = NBL_USTORE_DUAL_ETH_DROP_TH;
> +	else
> +		drop_th.disc_th = NBL_USTORE_QUAD_ETH_DROP_TH;
> +
> +	for (i = 0; i < 4; i++)
> +		nbl_hw_wr_regs(hw_mgt, NBL_USTORE_PORT_DROP_TH_REG_ARR(i),
> +			       (u8 *)&drop_th, sizeof(drop_th));

Is the drop_th structure fully initialized before writing to hardware?
The structure declaration doesn't initialize its fields, and only 'en'
and 'disc_th' fields are set before the entire structure is written to
hardware registers. Looking at the structure definition in
nbl_hw_leonis.h:775, nbl_ustore_port_drop_th has a 19-bit reserved
field 'rsv':

struct nbl_ustore_port_drop_th {
	u32 disc_th : 12;
	u32 rsv : 19;
	u32 en : 1;
} __packed;

The uninitialized 'rsv' field would contain undefined stack values when
written to hardware.

Other similar structures in this patch use zero-initialization (e.g.,
nbl_shaping_dport, nbl_shaping_dvn_dport, dsch_vn_quanta). Would it be
safer to initialize drop_th with '= { 0 }' to ensure all fields,
including reserved bits, are zeroed?

[ ... ]

Andrew Lunn raised a concern in v3 about the NBL_CORE naming in the
Kconfig (not modified in this commit):

https://lore.kernel.org/netdev/88c7e349-f941-4216-89ca-70a49e82b378@lunn.ch/

"_CORE is a bit unusual for a driver. CORE is generally a library which
is shared by a number of drivers. It does not have a tristate string,
it is just selected by the drivers which need it."

The author acknowledged this feedback but indicated it is still under
discussion. Will this naming issue be addressed in a follow-up patch?

