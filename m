Return-Path: <netdev+bounces-277114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TkzBEzIA2GktWAgAu9opvQ
	(envelope-from <netdev+bounces-277114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 21:38:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DDA3CF0FF
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 21:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40F523006B38
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 19:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE6C306486;
	Thu,  9 Apr 2026 19:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="iynxBWZ+"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster4-host3-snip4-10.eps.apple.com [57.103.78.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405B41DC1AB
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 19:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775763503; cv=none; b=hdQuBnSr+ugyX/xTcYuOeLvOnw+tt/WeeqiJ4CApCKFCqn32bgkZpRF2qzfGCHWXrtALxEpap6yUX3map6LSDofCz1AeYIqNONYuYY9Vkq4cJjFYFwOA6ksW4PiexaTLrSkux7sO0s+qfLnbLaTjRrxDFlL3c4QBzYjcxAl2bZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775763503; c=relaxed/simple;
	bh=WF178AMDzQwkc2LObD6a5oKfbRWCItiTHlFKnpEOAk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YuoFvqG/elkv+h9GtuolEX6cEbHPNBKzNULZJfHjgOwOmwGw0otGmbiAsLVEOEXO2TLPhU6G8IIC/N/U38vxEIzVQjcao3UoIa0iL0NOnP/Vw8DsClBebxmcKbiAyDr66SAIANkC4thSvA2c3xCPUoqwM5lvGbAxR99YDJVMzfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=iynxBWZ+; arc=none smtp.client-ip=57.103.78.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-2 (Postfix) with ESMTPS id E85C31800232;
	Thu, 09 Apr 2026 19:38:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775763501; x=1778355501; bh=YSU8lKJUWnXhaPAZOsKBjk/C13kNaE8zIGXjJRNqEIM=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=iynxBWZ+20IDWHqlQxudqTyDuRQ2rhwozIqSWWLJIPR2RhAVqkBSyBZC7XdOOntr5+rjt4MODSdGXPHXqHbkv4fXn4sxUdm9vdKbGkikJ1+u8WBOG/2bMcXEmSDQMJWsnu8OI8N7Og/JqRvd9ioU9I6vyPL4vSb7cb7CCDMQFuP1c7sZTA7Cih9iOL9cuibfBaKpNPKvQshKLdayWX5zZwRIF5HWtVOedZk+7sH3DcNNp/MYPz0avmDdIQrCN9/eE/F5Vqm9qE+1qpn6jwKllQ+7ycyewIkg29mbv0ytwJbrfLqaVOe1mo/dgkK/qq9oFSdjMy95K8ZJXndtzJS5dg==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-2 (Postfix) with ESMTPSA id B3BFC18000BD;
	Thu, 09 Apr 2026 19:38:16 +0000 (UTC)
From: =?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
To: horms@kernel.org
Cc: netdev@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	security@kernel.org,
	framemain@outlook.com
Subject: Re: [PATCH] nfc: nci: fix OOB heap read in nci_core_init_rsp_packet_v1()
Date: Thu,  9 Apr 2026 21:37:41 +0200
Message-ID: <20260409193801.1826509-1-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260408190505.GK469338@kernel.org>
References: <20260408190505.GK469338@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=OcmVzxTY c=1 sm=1 tr=0 ts=69d8002b
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=aYGnAectiCr-H4skEwIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=JKcXVnpmuwdQ7RL0mgk_:22
 a=NDDgNl8OaFIu1Hag6_vS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE4MCBTYWx0ZWRfX+breHxK+5A/k
 FmzLjKj4ax3fP/c9WKM2JutzeMDReNp8U8Gu413WVtRglNmNDVWPDpkCWkusCPVXFHf3sR5jjKg
 cq78vxL7VLwP+oS2q2bE+r5xMNdu8Blc6juCMzP/hBqKNNW11XdDFt+/P+j9X1IjI6Z05q7mcLf
 g1Le1x/6KQ+P4XwucftoWh7Lw9jajQWkPhHGbq3Eu3p7PmdFbH7fFCvp04KanOc2V5DCtJx43Q2
 jjwVlZpC9i9r35H/YSSaKjzJf0z1iZWoeX5WTh1ppDru7TK2Be8Xin/nn+u5aeZE0YUCoSbsXxt
 VVLON0+IpkPkZtNUbyttUxlgG11qMVrKwvFPm/GBamqhkvGCZkQyvqNSczMgtw=
X-Proofpoint-GUID: rppjbLLS3uLUWs6tCvzfcOD9VmFuDtPH
X-Proofpoint-ORIG-GUID: rppjbLLS3uLUWs6tCvzfcOD9VmFuDtPH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 clxscore=1015 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=891 suspectscore=0 lowpriorityscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604090180
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277114-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,google.com,redhat.com,outlook.com];
	DKIM_TRACE(0.00)[icloud.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[icloud.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snowwlake@icloud.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,icloud.com:dkim,icloud.com:mid]
X-Rspamd-Queue-Id: C9DDA3CF0FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks for the review. I will address all three points across both
patches (v1 and v2) and send them together as a patchset:

  - add an early skb->len >= sizeof(*rsp_1) guard before any struct
    field access
  - compute the rsp_2 pointer using the raw chip-supplied
    num_supported_rf_interfaces (validated against skb->len), not the
    already-capped ndev value
  - investigate whether pskb_may_pull is needed in the NCI receive path
    before these handlers are called

Lekë

