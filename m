Return-Path: <netdev+bounces-278250-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMLIHKuI3Wk8fQkAu9opvQ
	(envelope-from <netdev+bounces-278250-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:22:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4173F469F
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F2EF23013724
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A371C84DC;
	Tue, 14 Apr 2026 00:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNUEmmTJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350E4175A61;
	Tue, 14 Apr 2026 00:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126110; cv=none; b=Z02XpiVxdG87MetqOw+iULPhnPe64FuE+z623dVVpRQwkSMqGE+aX/al1D+lq6rS/Lk5qcwQngzV+xbG/E/BW4s041XL5U2IgJjLOrTErc//teIRG2p9WXufYomZ6QcqxmSUk8VglCksUPIJ5y2ItSlxjmElKMYdHa8HS2pQUZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126110; c=relaxed/simple;
	bh=6caI8vNZc/462NGOfNaRR6Uk12AEWf33yErq3u5QKAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEAfLojW0AWCnA1NI+LvebPX2DnAvwb0uSTkMgH90bKemWIZDWxfXuFOXSWi0S8ylZ1Gabbvrz3OQrbZFqDwGigfWESLeQsZX+W/aqik9M8jjQqOwEYR6XP/mSyPeOeVRJ0m0HCLdiVK7HxYR8jGr+dO6w9clp4xRQfTLQH1joI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNUEmmTJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E252CC2BCB4;
	Tue, 14 Apr 2026 00:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776126110;
	bh=6caI8vNZc/462NGOfNaRR6Uk12AEWf33yErq3u5QKAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TNUEmmTJJ4msaRUCxV3wGpXJoKzm34mybZtOHcO0K7rb75Eb2d1bOnsvNOgVVJu/t
	 Ns9NhXHl+L/NocQaEXQvJS/jrBg+aVlFPAX0ikcG2M+3ygMOor0xHmfvAqGWEMZdMf
	 ClDwdfYTC4IOghy/GPhYEJJxwpzlGaZ3JW81qOgy7PQ4HbuuNODENSM5HWMRGpY5wO
	 Mt8yQDmNBlxfeJyvM/sEZi0acopYyVJtai+FheRRoRG2ZoJpn2Waz0Qu7T3tobjxUY
	 POnG/upfGs/JhX8HpPcnwLgEaIesd6DbMb+Rfrwp/yRRax09wu4POkBcNNd8EO9zwQ
	 4Hll3tHqo+ppw==
From: Jakub Kicinski <kuba@kernel.org>
To: devnull+satishkh.cisco.com@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com,
	satishkh@cisco.com
Subject: Re: [PATCH net-next v4 05/10] enic: define MBOX message types and header structures
Date: Mon, 13 Apr 2026 17:21:44 -0700
Message-ID: <20260414002144.3734510-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411-enic-sriov-v2-admin-channel-v2-v4-5-f052326c2a57@cisco.com>
References: <20260411-enic-sriov-v2-admin-channel-v2-v4-5-f052326c2a57@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278250-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,satishkh.cisco.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C4173F469F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
enic: define MBOX message types and header structures

This commit defines the mailbox protocol used for PF-VF communication over
the admin channel. It introduces the request/reply message types and the
structures representing the message headers and payloads.

> --- /dev/null
> +++ b/drivers/net/ethernet/cisco/enic/enic_mbox.h
> @@ -0,0 +1,75 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright 2025 Cisco Systems, Inc.  All rights reserved. */
> +
> +#ifndef _ENIC_MBOX_H_
> +#define _ENIC_MBOX_H_

This isn't a bug, but should this header include <linux/types.h> and
<linux/bits.h>? It uses fixed-width types like __le16, __le32, u8 and the
BIT() macro. Without these includes, it might cause compilation errors if
included in an isolated context.

[ ... ]

> +struct enic_mbox_generic_reply {
> +	__le16 ret_major;
> +	__le16 ret_minor;
> +};

[ ... ]

> +struct enic_mbox_vf_capability_reply_msg {
> +	struct enic_mbox_generic_reply reply;
> +	__le32 version;
> +	__le32 reserved[32];
> +};

Does this structure introduce misaligned memory accesses by violating
structure alignment inheritance rules?

struct enic_mbox_generic_reply consists only of __le16 fields, giving it
a natural 2-byte alignment. struct enic_mbox_vf_capability_reply_msg
embeds this reply struct and subsequently adds __le32 version and
__le32 reserved[32], which require 4-byte alignment.

If the outer structure is cast from a buffer that only guarantees the inner
structure's 2-byte alignment, the 4-byte aligned fields could cause
misaligned memory accesses.

Should the wider 32-bit fields be split into smaller __le16 fields to
strictly preserve the inherited 2-byte alignment?

