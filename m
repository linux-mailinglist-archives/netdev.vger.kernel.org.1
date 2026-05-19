Return-Path: <netdev+bounces-289280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK91C+X8C2qrTAUAu9opvQ
	(envelope-from <netdev+bounces-289280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:02:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB448577AE6
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D330430547CF
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 05:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B413644C9;
	Tue, 19 May 2026 05:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JmnoS6Yk"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E7535C1B0
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 05:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779170188; cv=none; b=pAwjq44vVBxDHNPKjF0EkEJpa/GsbLiAyT4+3dE75mFKJYNWLh6jhzZLGakyK+HjmNnXi3qVOs0ECBO2BYa7B8p0WnGHiBeAvn/8z6fN1rOdE8wmxUw5abQy08+hzmAUY4gtrMk/w1pvz94G4UMoFVyx2LrCc5DyiwIrL82PXdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779170188; c=relaxed/simple;
	bh=TCLu5MNEcNIL5e7ATwDDhlB3YNv67f7AtXIvfVcNMA8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=E5l+8UBZD0il84NeYh+7vq7G5+5VO3Ul3Lgj28bDThh4ganDnBHKbdZIbTo7c1U/42ai+t7zWdwg0kX+8Cy+SUmn8Tu+I7sURT4lneLpUF1ogNiAuevoEFbwtiiP+15iGUEWsZWmAfYpg6WsphTrpJl37u+vO7YY4+UuPuniVj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JmnoS6Yk; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 19 May 2026 07:55:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779170174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fDUb5wllfZTf/t6wsoMQEEce9T5suMuho2M4U8byo6M=;
	b=JmnoS6YkymUjv5x1woBoN7AX65oKlCbRuqVZaYKNPDvlFcEISydaMEn9eUrvSy17Gal4Ul
	3yjnk5MEtQQLKK7jFO834FSFiXy9WI9MshO8HC+h42iUbC8d2nWTYUVieYUyJnbcC+fbcy
	dmcbRF4bkF1xgNkUpmYJdOMHkxrgrhQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luka Gejak <luka.gejak@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
 Felix Maurer <fmaurer@redhat.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Meghana Malladi <m-malladi@ti.com>, Jacob Keller <jacob.e.keller@intel.com>,
 David Carlier <devnexen@gmail.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Kevin Hao <haokexin@gmail.com>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Vladimir Oltean <vladimir.oltean@nxp.com>, luka.gejak@linux.dev
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_v2_2/2=5D_net=3A_ti=3A?=
 =?US-ASCII?Q?_icssg=3A_Add_HSR_and_LRE_PA_statistics?=
In-Reply-To: <20260518184506.694c584e@kernel.org>
References: <20260514075605.850674-1-danishanwar@ti.com> <20260514075605.850674-3-danishanwar@ti.com> <20260518184506.694c584e@kernel.org>
Message-ID: <E30AAC96-01D2-4A23-B562-126087DEB7FA@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289280-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,lwn.net,linuxfoundation.org,lunn.ch,ti.com,intel.com,gmail.com,linux.dev,vger.kernel.org,lists.infradead.org,nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BB448577AE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On May 19, 2026 3:45:06 AM GMT+02:00, Jakub Kicinski <kuba@kernel=2Eorg> wr=
ote:
>On Thu, 14 May 2026 13:26:05 +0530 MD Danish Anwar wrote:
>> Add new firmware PA statistics counters for HSR and LRE to the ethtool
>> statistics exposed by the ICSSG driver=2E
>>=20
>> New statistics added:
>>  - FW_HSR_FWD_CHECK_FAIL_DROP: Packets dropped on the HSR forwarding pa=
th
>>  - FW_HSR_HE_CHECK_FAIL_DROP: Packets dropped on the HSR host egress pa=
th
>>  - FW_HSR_SKIP_HOST_DUP_DISCARD_FRAMES: Frames with duplicate discard
>>    skipped
>>  - FW_LRE_CNT_UNIQUE/DUPLICATE/MULTIPLE_RX: LRE duplicate detection
>>    counters
>>  - FW_LRE_CNT_RX/TX: LRE per-port frame counters
>>  - FW_LRE_CNT_OWN_RX: Own HSR tagged frames received
>>  - FW_LRE_CNT_ERRWRONGLAN: Frames with wrong LAN identifier (PRP)
>>=20
>> Document the new HSR/LRE statistics in icssg_prueth=2Erst=2E
>
>To an untrained eye these stats look like stuff that could=20
>be standardized across drivers=2E=20
>
>Luka, Felix, others on CC, do you think we should expose these
>from HSR over netlink as "standard" offload stats different drivers=20
>can plug into or not worth it?

Hi Jakub,
I think there is a case for standardizing part of this, but I would=20
not standardize the whole set as-is=2E

The LRE counters look generic enough to me, especially:
 - unique rx
 - duplicate rx
 - multiple rx
 - rx / tx
 - own rx
 - wrong LAN, PRP only

Those are protocol/LRE concepts rather than TI firmware details, so
exposing them from the HSR/PRP layer sounds useful=2E I would expect=20
both the software implementation and offloaded implementations to be=20
able to provide at least some of them, with unsupported counters=20
omitted or reported as not available=2E
I would not put the firmware check/drop counters in the same standard
bucket, though:
 - FW_HSR_FWD_CHECK_FAIL_DROP
 - FW_HSR_HE_CHECK_FAIL_DROP
 - FW_HSR_SKIP_HOST_DUP_DISCARD_FRAMES

Those sound more like implementation/debug counters for the ICSSG
firmware pipeline=2E They are still useful in ethtool driver stats, but=20
I would be hesitant to bake their exact semantics into HSR UAPI=2E
So my preference would be:
 1=2E Keep driver-private ethtool stats for the full firmware counter set=
=2E
 2=2E Add a small HSR/PRP standard stats set separately, limited to
    well-defined LRE counters=2E
 3=2E Make the HSR layer expose them, with offload drivers plugging in via
    an optional callback or offload stats op=2E
 4=2E Define the counters carefully, including whether they are per-HSR
    device or per-port A/B, and what PRP-only counters mean for HSR=2E

I do not think this patch should blindly become the UAPI definition,=20
but I do think it points at a useful follow-up=2E If we want to avoid=20
adding driver-private names first and then standardizing different=20
names later, then it may be worth asking Danish to split the=20
protocol-level LRE counters out and route those through a common HSR=20
stats interface=2E

Best regards,
Luka Gejak

