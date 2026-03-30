Return-Path: <netdev+bounces-273336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCSYGMPyymkkBQYAu9opvQ
	(envelope-from <netdev+bounces-273336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:01:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF01361B5B
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B6AF301DECF
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 22:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36B6395242;
	Mon, 30 Mar 2026 22:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="LiDsD8qq"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496D51A9F9F;
	Mon, 30 Mar 2026 22:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774908096; cv=none; b=LwTzC3032XMv4mofv1e7jt08x8cqd2NO82PxAFu8CqMO99/8WU2DTAYP4K6giH0M+zWedSOsyQ+gYmeO2bj3o7TOUFKRrXnVPbNs9KYanJSUCaqKuBYttyuRDNEtLQ9q7LbZNLsMRjksglr9BgGPHVU18w3HBqQeF7N1ipbLpQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774908096; c=relaxed/simple;
	bh=bMPf+xEjjqdbFKN8hfOQRxzjAUCIAtkwWA+GHp+WqU0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=XiwL40bugbwhCQYufxTYzJOTmJetqr8A9Amuog2A2hkG9CtZ3vOKlut4cjHD4tqRBneq3m54HFnB/n+iagQU6fc9gKrYU+0MOsyy4ffv91kIVSAqtwZ68glEN58UdsVknNjgcg5WtezN7ToA6JNFA319cn/3fju1+JogOVewtZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=LiDsD8qq; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 23506A5870;
	Tue, 31 Mar 2026 00:01:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1774908089; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=VvNys7WE0SIS3w3sY19B8xzUaWzWpWcwQCssU6oaEyk=;
	b=LiDsD8qqTL0Un8/aA9l4cHYKe2+AdnrqDdf5qpsUmry2vR1M8mlajXA2/7OCE1A/mDqExx
	woKY6KS44vCL2dKhJGzsbcmJNLyLTzZ3rymceeKG4Rhd5rxLs0vupipKmWSkXaMVH55kH1
	dW0gkURYmXTcTqOk/ThPyVHqac6JowZeGJCTFLQsLT85lLyWVpbhf1/3QbG/w0Y4rxxkEn
	oQkwIInNQB/9Opiu6xg2iotgvMarO/PlHPIiWayfYoZMoGJn9ZSDPxuD43Qvc7yQPWvALt
	vIYohucnwZ57iZ5T6pqS4jh535rYTk8i9pnbkPxeBt441yugBPpPMRroIt57rQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 31 Mar 2026 00:01:27 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/6] net: bcmgenet: add basic XDP support
 (PASS/DROP)
In-Reply-To: <1d551008-3c42-4b7b-9507-03072740a54a@gmail.com>
References: <20260319115402.353509-1-nb@tipi-net.de>
 <20260319115402.353509-4-nb@tipi-net.de>
 <1d551008-3c42-4b7b-9507-03072740a54a@gmail.com>
Message-ID: <56270d59e5e5e79fcd3d104817679d70@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-273336-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	NEURAL_HAM(-0.00)[-0.987];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,fomichev.me];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:dkim,tipi-net.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CCF01361B5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 30.3.2026 20:15, Mohsin Bashir wrote:
>> +static int bcmgenet_xdp_setup(struct net_device *dev,
>> +			      struct netdev_bpf *xdp)
>> +{
>> +	struct bcmgenet_priv *priv = netdev_priv(dev);
>> +	struct bpf_prog *old_prog;
>> +	struct bpf_prog *prog = xdp->prog;
>> +
>> +	if (prog && dev->mtu > PAGE_SIZE - GENET_RX_HEADROOM -
>> +	    SKB_DATA_ALIGN(sizeof(struct skb_shared_info))) {
>> +		NL_SET_ERR_MSG_MOD(xdp->extack,
>> +				   "MTU too large for single-page XDP buffer");
>> +		return -EOPNOTSUPP;
>> +	}
> 
> The MTU check here is great. But I do not see support for 
> .ndo_change_mtu. This would allow users to change MTU size AFTER the 
> program is attached.

Good point. I had planned to add ndo_change_mtu in a follow-up series, 
but this leaves a gap where MTU can be changed while XDP is attached.

Options:
1. Add a minimal ndo_change_mtu to this series that only rejects MTU 
changes incompatible with XDP, default behavior otherwise
2. Reject any MTU change while XDP is attached
3. Defer to the ndo_change_mtu follow-up series

Thoughts?

Thanks
Nicolai

