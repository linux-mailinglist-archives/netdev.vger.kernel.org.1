Return-Path: <netdev+bounces-296352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hiHYEJ0pJmrFSwIAu9opvQ
	(envelope-from <netdev+bounces-296352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 04:31:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE746523F2
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 04:31:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=eeTAaQpw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296352-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296352-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AABC30062E9
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 02:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94702314A6B;
	Mon,  8 Jun 2026 02:31:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ED026E165;
	Mon,  8 Jun 2026 02:31:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780885914; cv=none; b=RIy52fu84aAE7CKSN4NRAY91T2UiqoGipPnsdd66Zn78ALA4dxjMQx/vrLAXzO0NaiiO8dZMf1QK5UkoUs7taEJ6hD/kaNveWvMjyNdRZ1pUWjP8Y00ZfYhTav+vpIPjRs+yTAuj7aM7hj1A0bJ2qsE/H0acRwpKKMyXjUe3CUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780885914; c=relaxed/simple;
	bh=WIGdlLqfb5Qw/icfdcmq8oHzFOQ/OsA0Ac3bwra2uQU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbFWMSU84O/NG54ciqj4uG45l7ag9Hv68j/gfhan535zMuVdiNFN/EpFO/GguyaG+m/jSHPCYe0Hgzc2bsXcCWfiuofxZe0QhnR/qnGW8joVrDTt5d39YMNquKoDCDSjEQjxpt2KycMDW0ZhR69/zbkOeCsPzixJXdvo8E/D1v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eeTAaQpw; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580EsMa1019969;
	Sun, 7 Jun 2026 19:31:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=WIGdlLqfb5Qw/icfdcmq8oHzF
	OQ/OsA0Ac3bwra2uQU=; b=eeTAaQpwFZKGEvpP4WQrXofldCCba6nvmmePaRdFH
	EVpakodOxPBOf2sIHxXwP3MiLQU7/PjohACk1YzLZjlZG6nzG73pKwErU303ZEsE
	5y9hWf2NpGdEYzUkeB0+7KdjQYQ+HRqTzhV8JOrvmh32ygdfYjETMcSFOk82wrJn
	La9ghy0VRHTyA2fYe2zrJB8hVZiYGklzJ9cxpbn8e3zceuinWvhuqaLFWIDAdpDT
	kLE7weA4YKWrpjlpiV6utR7ZUUeRq3JA0keEqI/H3mbCkJ7U+xYD5AV9MMpU1ojX
	rYGudWlL91uQf/tq1bWGOhp6ROmD0sl2Q+6nQhc/oEVXg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4emgwhw5a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 19:31:44 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 7 Jun 2026 19:31:43 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 7 Jun 2026 19:31:43 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 0BE545B6932;
	Sun,  7 Jun 2026 19:31:39 -0700 (PDT)
Date: Mon, 8 Jun 2026 08:01:39 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v19 net-next 8/9] octeontx2: cn20k: Respect NPC MCAM
 X2/X4 profile in flows and DFT alloc
Message-ID: <aiYpi9lP-sZaoOmL@rkannoth-OptiPlex-7090>
References: <20260605063245.3553861-1-rkannoth@marvell.com>
 <20260605063245.3553861-9-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260605063245.3553861-9-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDAyMCBTYWx0ZWRfX0V1Oh4aiopzy
 w1Ukp5zfUPVlX3fDH7cjHnoLg960DztQBEnT+5U1EajOs5YI32b0u8l+T2N0RqGEdI53ys+Uswh
 jVAQIbxdLHG+zkVo9YlLTEP27zyuW2224/aeGdPj0kUFbW7InQd75EZVzokumZ3ciAJkk8FpT0Z
 ep+beeZRL8VHPxX1oi2WArvBKosbAwMFyXUKA1cPM39SPDM5Ws89AWGW+Ij1kvpo+wn5vwEMnSz
 N09r1f70Qge2WEiTkd2kQJ2UQDW05LaO6xsbTKACCMazmvGHgswnc9RbnOyMlPreZd9YpL4vaMo
 46kReYiQOcCdYKCj4VHQStCIYCxM1JLkkACdLuM60X+aHP7IwVp4LRwz45RnflUdE046xVoUAOB
 cAdL7SRbbB9YvFW5ybPQ3Gvaj9UZRO5EAXs8lXVtdu2woOiZu8H+QPVo02YLN805EFfBPYUxiFw
 bgm/vvXKo+Eh90XPMcA==
X-Proofpoint-ORIG-GUID: lACtwvPGUV9qWm4uAckxJalxSrCFawn6
X-Proofpoint-GUID: lACtwvPGUV9qWm4uAckxJalxSrCFawn6
X-Authority-Analysis: v=2.4 cv=Pv2jqQM3 c=1 sm=1 tr=0 ts=6a262990 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=Knl-tBO3iHv-3BrbUGwA:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-296352-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rkannoth-OptiPlex-7090:mid,linux.dev:url,marvell.com:dkim,marvell.com:from_mime,marvell.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ABE746523F2

On 2026-06-05 at 12:02:44, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Default CN20K NPC rule allocation now keys off the active MCAM keyword
> width: use X4 with a bank-masked reference index when the silicon uses
> X4 keys, and X2 with the raw index otherwise (replacing the previous
> always-X2 / eidx + 1 behaviour).
>
> In the AF flow-install path, flows that need more than 256 key bits
> query the NPC profile; if the platform is fixed to X2 entries, fail
> with -EOPNOTSUPP instead of requesting X4. Otherwise select X4 for the
> MCAM alloc.
>
> On the PF, cache and pass the profile kw_type from npc_get_pfl_info
> through otx2_mcam_pfl_info_get(), and use it when allocating MCAM
> entries for RSS/defaults and when installing ethtool flows on CN20K,
> including masking the reference index for X4 slot layout.
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260605063245.3553861-1-rkannoth%40marvell.com says

>The commit message says this replaces the "previous always-X2 /
>eidx + 1 behaviour", but the pre-patch code used ref_entry = eidx
>in the higher-priority allocation and ref_entry = eidx + 1 only in
>the VF lower-priority fallback path.
>Is the commit message description of the prior behavior accurate?
>For the lower-priority fallback in the X2 branch, ref_entry now becomes
>eidx instead of eidx + 1, so the value passed to
>rvu_mbox_handler_npc_mcam_alloc_entry() changes for already-shipping X2
>CN20K silicon, separate from the X4 enablement.
>Was the prior eidx + 1 a deliberate offset (for example to step past
>the higher-priority slot reserved by the first allocation) or an
>off-by-one that is being corrected here?
>If it is a fix, would it make sense to split this into a standalone
>patch with a Fixes: tag so it can be backported and bisected
>independently of the X4 enablement, and could the rationale be added
>to the changelog?
eidx is the oorrect value as eidx + 1 may overflow. initially i submitted this patch
as bug fix, but simon said this is more than a bug fix, so this is part of net-next.

