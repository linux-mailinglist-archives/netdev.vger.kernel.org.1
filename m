Return-Path: <netdev+bounces-300542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lOtwMUptNGqiXwYAu9opvQ
	(envelope-from <netdev+bounces-300542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 00:12:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D1D6A2E9D
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 00:12:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=proton.me header.s=protonmail header.b=Wa711ndb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300542-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300542-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=proton.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C5A3306C6EA
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 22:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32C934D4D6;
	Thu, 18 Jun 2026 22:11:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch [185.70.43.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CD334C141
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 22:11:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781820698; cv=none; b=kb6eu5cvgf7DtxCIrTtXe7uoUn78DpGZsY5GREiX+0C/56tR6tYNQuAbDb4hS0FmTqVSIQbXmtsOonxgDWEq+yRl46gTtr1t9Mq8J0rKuMvt+58s9ysuBXSdh2eeF2IPoUQ6ocx1JwWg9z//431jdkGmRleEFaICfVncvxRIH7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781820698; c=relaxed/simple;
	bh=tIxdSxDXWXfXz+inSGUYt7RDez2Rfbj/IU2DS0DAyw8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJiXQ+/53AiJo6WwtOidylf4EHkqjzHZKzCvCn0uMemSz0KUMt6ABuYgA8Xtg+wmRxlZAQQCBbs91MlcxSbqW+229baVmBaUuCdcP64g6VxytvV3GSS7AhFZ5UQEmCJtBjuZyE+uLwDpoBwMI0uYl/48gXmUbw6V9n4Rv00tpBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Wa711ndb; arc=none smtp.client-ip=185.70.43.102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1781820688; x=1782079888;
	bh=tIxdSxDXWXfXz+inSGUYt7RDez2Rfbj/IU2DS0DAyw8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Wa711ndbzk7S+BcHMmP49JyGOBQ4Z2fSHDIn4YuagQjKTknxqZmaQHCHsFVrb9vkV
	 ZCWrRQpnoVi5wi2sdw2rRUUhdVZeCMlwNHLt8uMx8+cRheepV5X6snBXyfpzKJD58L
	 N1bWg6ak7mOaQAwY+GdO+Ju+5/fYYL4k6CEgJ6Xlz58R7k2h6vPtvjbNUC4KqyCmv6
	 eTJLznC6Qq8mwxLEwSAq7niTUdZxmbRGhS/pnSsJKxW/G1Ex4T2ofPi+jA3LBL7e4L
	 hY/gO5iXRA9dtmdP2AXj4hk6OimFKdCR7pbpceSMlvA4jxmXKjZELUcNdttTDA7Sa1
	 i0ZIA+rhZAXbg==
Date: Thu, 18 Jun 2026 22:11:22 +0000
To: Dust Li <dust.li@linux.alibaba.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, "D . Wythe" <alibuda@linux.alibaba.com>, Sidraya Jayagond <sidraya@linux.ibm.com>, Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, Mahanta Jambigi <mjambigi@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>, Simon Horman <horms@kernel.org>, Ursula Braun <ubraun@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] net/smc: bound the send length to the send buffer in smc_tx_sendmsg()
Message-ID: <20260618221115.236718-1-hexlabsecurity@proton.me>
In-Reply-To: <ajQX7_9xFI9GSaq5@linux.alibaba.com>
References: <20260614-b4-disp-edd64be9-v3-0-551fa514257e@proton.me> <20260614-b4-disp-edd64be9-v3-3-551fa514257e@proton.me> <ajQX7_9xFI9GSaq5@linux.alibaba.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: d1cb6126b360c355cf2d54ae6e61c13ede4385e5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300542-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hexlabsecurity@proton.me,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dust.li@linux.alibaba.com,m:wenjia@linux.ibm.com,m:alibuda@linux.alibaba.com,m:sidraya@linux.ibm.com,m:edumazet@google.com,m:davem@davemloft.net,m:mjambigi@linux.ibm.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:ubraun@linux.ibm.com,m:raspl@linux.ibm.com,m:tonylu@linux.alibaba.com,m:pabeni@redhat.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hexlabsecurity@proton.me,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28D1D6A2E9D

On Fri, 19 Jun 2026 00:08:15 +0800, Dust Li wrote:
> I think this is the same as patch #2.

Same story as 2/3, just on the SMC-D send side: sndbuf_space accumulates
diff_tx =3D smc_curs_diff(sndbuf_desc->len, tx_curs_fin, cons) from the pee=
r's consumer
cursor, so a cons alternating wrap 0<->1 walks it past sndbuf_desc->len (an=
d negative
over time), and smc_tx_sendmsg's wrap-around write then runs off the end of=
 the
buffer. The boundary count check doesn't bound diff_tx here either, so I'd =
keep the
same two-line bound. The same A/B covers it.

Bryam


