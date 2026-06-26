Return-Path: <netdev+bounces-302271-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tmVHMOrrPmoMNAkAu9opvQ
	(envelope-from <netdev+bounces-302271-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 23:15:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE2D6D0343
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 23:15:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oJhyeRc4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302271-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302271-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 358FD3020A90
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 21:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FB43BFAE0;
	Fri, 26 Jun 2026 21:14:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BDD37D124;
	Fri, 26 Jun 2026 21:14:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782508492; cv=none; b=QlNfiVmE4OE/N/yGtRr2MpMeNlJE2PPNqt/NWn9xztoCoXW/UKbWuVbzQPEvPKtioM3qQiKGwMO3E7UQFDZ/zJfyuLTFIrVl9G8tcPEgDYhMuOpxXQfBPN9T15arU66Q8zSmFIzjony8cOeSNlJqH404MODd3JyD7I38HdDfNDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782508492; c=relaxed/simple;
	bh=eg52iwAq7d9bopUm/H/1bFhrLyhHwFFRH6aGL8XZYHI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=sjKFBEsKEZ1JCoiCDwXGYY4S6rvoofKiiFqUor3XL+UgmtLYaIeYQ5ZP/TjQNVDUWjwTQVFhGVjzExVCaMU0Jx3xIlrIFVETbCsV30oMooj4c+zIeEGi7V3k6zVAryYX19pSORUkaO22TfM6TkA6yD896dpvV2B42Ka5/y4UBok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJhyeRc4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804B61F000E9;
	Fri, 26 Jun 2026 21:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782508491;
	bh=lbXYKsCuCUgf0KVI/EIkHjtTOP4QQd0BPQJ4Ova8GN0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=oJhyeRc4Lx869y39oZDLx+tylyZrZ7x1Wfm4rIrbH1/MEPHYgQ7j+LemeaI/ZVoRB
	 +eeLoXyukK5xRF4ySo1uoLtEJWZndIS1Ku1iUceg+7wR80PzY00J0FJ4jtIKfoBC/F
	 m72kVTTO6SM8BFvvNLOVW3hkKKqjIiZn8IyAuRYVMOLb5CN4pVqe42DGwWgwwyQ+X5
	 e3d88OvH+P+ftBM1+ysIpmsAt4D9tFtwD1dFDoS2MKT/skskDdG0x25wOVMV2wsjdd
	 3p4wGknD8comUWBz9AhL2czwBQv0+CW9BJKQrvpu2YwjKS58PGcxP3sT0n4sr2n/rA
	 XPo4E4sGeuWCg==
Content-Type: multipart/mixed; boundary="===============5848927899764250450=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2503796768ba9b066c1ff1591c1a2d91c30a30af45823d5739b0ed251b2472ee@mail.kernel.org>
In-Reply-To: <20260626-sockmap-lookup-udp-leak-v2-3-7e7e201c951a@rbox.co>
References: <20260626-sockmap-lookup-udp-leak-v2-3-7e7e201c951a@rbox.co>
Subject: Re: [PATCH bpf v2 3/4] selftests/bpf: Adapt sockmap update error handling
From: bot+bpf-ci@kernel.org
To: mhal@rbox.co,edumazet@google.com,kuniyu@google.com,pabeni@redhat.com,willemb@google.com,john.fastabend@gmail.com,jakub@cloudflare.com,jiayuan.chen@linux.dev,davem@davemloft.net,kuba@kernel.org,horms@kernel.org,ast@kernel.org,cong.wang@bytedance.com,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org
Cc: netdev@vger.kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,mhal@rbox.co,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 26 Jun 2026 21:14:50 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,rbox.co,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302271-lists,netdev=lfdr.de,bpf-ci];
	FORGED_RECIPIENTS(0.00)[m:mhal@rbox.co,m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:ast@kernel.org,m:cong.wang@bytedance.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:martin.lau@kernel.org,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[rbox.co,google.com,redhat.com,gmail.com,cloudflare.com,linux.dev,davemloft.net,kernel.org,bytedance.com,iogearbox.net,etsalapatis.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3BE2D6D0343

--===============5848927899764250450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     selftests/bpf: Adapt sockmap update error handling
>
>     Update sockmap_listen to accommodate the recent change in sockmap that
>     rejects unbound UDP sockets.
>
>     TCP: Reject unbound and bound (unless established or listening).
>     UDP: Accept only bound sockets.
>
>     Signed-off-by: Michal Luczaj <mhal@rbox.co>

This adjusts the test expectations that commit 0c48eefae712 ("sock_map:
Lift socket state restriction for datagram sockets") had introduced, the
per-sotype branching in test_insert_opened() along with the matching
changes in test_insert_bound() and test_ops().

The companion kernel fix 77a34848a723 ("bpf, sockmap: Reject unhashed UDP
sockets on sockmap update") already carries:

  Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagram sockets")

Should this selftest commit carry the same Fixes: tag?

  Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagram sockets")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28264556257
--===============5848927899764250450==--

