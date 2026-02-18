Return-Path: <netdev+bounces-259175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMXTAgUJlWk2KQIAu9opvQ
	(envelope-from <netdev+bounces-259175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 01:34:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2B115252D
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 01:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A681F300FEE4
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 00:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18862260580;
	Wed, 18 Feb 2026 00:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SO+TPqOV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DF7259CB2;
	Wed, 18 Feb 2026 00:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771374850; cv=none; b=vB1sNZ55PCRF+0ZDujTu03wQheXspvoAydQLY8HON+UsYRMUT2FQ67863cSoF0ej9JDU82fd+VS03nBK1SCJL9CLZA3+87S0M6k7uxClrw5vUBfGe3HGmh7Si0eMQ2VDmk7udj9jC+P+lG/Fu/x8K+W7cEGRq8rzo+2nxnrx3Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771374850; c=relaxed/simple;
	bh=yB0tQEWiCFqYLhZPbyGnhRDK+LkRBlNQcvhvviUeqgI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QnepkhQwKtjxUFir93kQ7KAq1Mrv4q7GTSzCWUspmNOIur0PfJik0zRs1rNgyYMzDeK3SnbcoRMnB/Co/yfZfxdq6+GMNuBYcIX03gvHE/v1gipXzDDgbDpklXQUsuvYtlHxJIKtNaweNx8QwUd0jTZSv1AeMfDLasoZOBa86Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SO+TPqOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF76BC4CEF7;
	Wed, 18 Feb 2026 00:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771374849;
	bh=yB0tQEWiCFqYLhZPbyGnhRDK+LkRBlNQcvhvviUeqgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SO+TPqOV+ja51p83+LaEU2+oyJrVMspfLKyzV/vBCHH5S3/UtMmAKFvIpnNciNA5N
	 HbBu44pOaiIvNH6nAewtLwudXHiaa1fPbfSnJc0QirjFTkC7DNSU/dJ7pPiaw28JSq
	 YI+uqpE2OoUfudteKfpXpY6UyJNci6YwVPvFEANBSRw+fkYHwhKBDvfTsPB9ORUSly
	 IDBcq8gX0Y8yMXECISffybJ4IUHhAhNUni8M5A+vLFzUdPL4JwOmfX99lGw8UaqwZ2
	 voB6aBNgRlxoWtHhTNHCGwHqBuwQe8+WxldFP4kdThcIRMrMm3KqMzgq1fD1CX23c1
	 TEACXLi9M50VA==
Date: Tue, 17 Feb 2026 16:34:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>,
 bpf@vger.kernel.org, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Subject: Re: [PATCH net-next v4 1/5] net: sched: introduce qdisc-specific
 drop reason tracing
Message-ID: <20260217163408.2afc1921@kernel.org>
In-Reply-To: <177125582938.2500844.3162442443588680144.stgit@firesoul>
References: <177125575993.2500844.8718737675156179479.stgit@firesoul>
	<177125582938.2500844.3162442443588680144.stgit@firesoul>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259175-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,redhat.com,toke.dk,kernel.org,resnulli.us,google.com,mojatatu.com,cloudflare.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B2B115252D
X-Rspamd-Action: no action

On Mon, 16 Feb 2026 16:30:29 +0100 Jesper Dangaard Brouer wrote:
> Create new enum qdisc_drop_reason and trace_qdisc_drop tracepoint
> for qdisc layer drop diagnostics with direct qdisc context visibility.
> 
> The new tracepoint includes qdisc handle, parent, kind (name), and
> device information. Existing SKB_DROP_REASON_QDISC_DROP is retained
> for backwards compatibility via kfree_skb_reason().
> 
> Convert qdiscs with drop reasons to use the new infrastructure.
> 
> Change CAKE's cobalt_should_drop() return type from enum skb_drop_reason
> to enum qdisc_drop_reason to fix implicit enum conversion warnings.
> Use QDISC_DROP_UNSPEC as the 'not dropped' sentinel instead of
> SKB_NOT_DROPPED_YET. Both have the same compiled value (0), so the
> comparison logic remains semantically equivalent.

net/sched/sch_dualpi2.c:594:12: warning: implicit conversion from enumeration type 'enum qdisc_drop_reason' to different enumeration type 'enum skb_drop_reason' [-Wimplicit-enum-enum-cast]
  593 |                         drop_and_retry(q, skb, sch,
      |                         ~~~~~~~~~~~~~~
  594 |                                        QDISC_DROP_CONGESTED);
      |                                        ^~~~~~~~~~~~~~~~~~~~
-- 
pw-bot: cr

