Return-Path: <netdev+bounces-266123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNaoJV4esGlagAIAu9opvQ
	(envelope-from <netdev+bounces-266123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:36:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D052250782
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E41A352431F
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14F43BF692;
	Tue, 10 Mar 2026 12:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="L6tk2LDG"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28B23BF69C
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773145292; cv=none; b=MBUshDExNiwH19aXu2TFcNfqtFMUVlpXG/txnaw1mRoON+HxxYemLgmx57bXSDvMewid1CGj0gCJuTg4M+l8sWJYIZiW5FpZaurw8zixto7bwqZ0+xv/tKY1V+YJU5EBQv+sZoa9ok4SY2NPYqerUVBWUB94hfbiaS7y9OeaMHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773145292; c=relaxed/simple;
	bh=fx/lvIvL/S3x19RqD/RjUqJrQys9pu/CXG8mO+EI1JQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRWUB3/YkR2yIQMJmyJdEjXFHwewcY/8zwRHdkUejHQL1tdn727KShEJ/1t+rn+1UM2UhuZnsn+XYkVWr1/ZCdofzOkOWasVuUdZWXgWV1Mthi5vYD50AzkqofqLlTQhQ7LizST99eiEFmYW4tojqqcLBvKHE+5FolBs7xyL5i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=L6tk2LDG; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id BE62220764;
	Tue, 10 Mar 2026 13:21:27 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7PJfvpR0dvyL; Tue, 10 Mar 2026 13:21:26 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id CE041201E5;
	Tue, 10 Mar 2026 13:21:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com CE041201E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1773145286;
	bh=3Y+1Ss4rc0Pofv3vspABGOE8TUz5/q99ZY2ILFsB2oI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=L6tk2LDGTnBllIuFd8Yi6a7g+EvW5/FMpOOgncJrKeHCDI+Ys0/TCnUu6K2dErMp+
	 UjIn5jHpM6lkF057TTYmWmeRihtZB5i9RfMPO9MjNSIzT1ew/nh5FTTkMdbQsVbO5A
	 M+copUgl07HlfAtQoXpi7OUkd6B2tYqU9y7xVR3U8iRF/kfc+aNrq5+PkOffj1fIR4
	 2H5bl9eEgjS+wMWQ8+3J0q4vyxxDdi9mtKqFAosni19+iQdS9Mjb3dnGhDbKRvjwtx
	 TwdtBN1cyrJdLFc5ELWEbPIwxVYoaYuN5RLX+Lf0CytO6EpCiyPZxfPg2gR/QSXoWg
	 KgqAVl/CnFcow==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 13:21:25 +0100
Received: (nullmailer pid 152708 invoked by uid 1000);
	Tue, 10 Mar 2026 12:21:25 -0000
Date: Tue, 10 Mar 2026 13:21:25 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
CC: <netdev@vger.kernel.org>, <chopps@labn.net>, <horms@kernel.org>,
	<pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <herbert@gondor.apana.org.au>, Hao Long
	<me@imlonghao.com>
Subject: Re: [PATCH ipsec v2] xfrm: iptfs: fix skb_put() panic on non-linear
 skb during reassembly
Message-ID: <abAMxZbDHa4TfYbX@secunet.com>
References: <20260304140935.19783-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260304140935.19783-1-fmancera@suse.de>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Queue-Id: 0D052250782
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	TAGGED_FROM(0.00)[bounces-266123-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,secunet.com:dkim,secunet.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 03:09:35PM +0100, Fernando Fernandez Mancera wrote:
> In iptfs_reassem_cont(), IP-TFS attempts to append data to the new inner
> packet 'newskb' that is being reassembled. First a zero-copy approach is
> tried if it succeeds then newskb becomes non-linear.
> 
> When a subsequent fragment in the same datagram does not meet the
> fast-path conditions, a memory copy is performed. It calls skb_put() to
> append the data and as newskb is non-linear it triggers
> SKB_LINEAR_ASSERT check.
> 
>  Oops: invalid opcode: 0000 [#1] SMP NOPTI
>  [...]
>  RIP: 0010:skb_put+0x3c/0x40
>  [...]
>  Call Trace:
>   <IRQ>
>   iptfs_reassem_cont+0x1ab/0x5e0 [xfrm_iptfs]
>   iptfs_input_ordered+0x2af/0x380 [xfrm_iptfs]
>   iptfs_input+0x122/0x3e0 [xfrm_iptfs]
>   xfrm_input+0x91e/0x1a50
>   xfrm4_esp_rcv+0x3a/0x110
>   ip_protocol_deliver_rcu+0x1d7/0x1f0
>   ip_local_deliver_finish+0xbe/0x1e0
>   __netif_receive_skb_core.constprop.0+0xb56/0x1120
>   __netif_receive_skb_list_core+0x133/0x2b0
>   netif_receive_skb_list_internal+0x1ff/0x3f0
>   napi_complete_done+0x81/0x220
>   virtnet_poll+0x9d6/0x116e [virtio_net]
>   __napi_poll.constprop.0+0x2b/0x270
>   net_rx_action+0x162/0x360
>   handle_softirqs+0xdc/0x510
>   __irq_exit_rcu+0xe7/0x110
>   irq_exit_rcu+0xe/0x20
>   common_interrupt+0x85/0xa0
>   </IRQ>
>   <TASK>
> 
> Fix this by checking if the skb is non-linear. If it is, linearize it by
> calling skb_linearize(). As the initial allocation of newskb originally
> reserved enough tailroom for the entire reassembled packet we do not
> need to check if we have enough tailroom or extend it.
> 
> Fixes: 5f2b6a909574 ("xfrm: iptfs: add skb-fragment sharing code")
> Reported-by: Hao Long <me@imlonghao.com>
> Closes: https://lore.kernel.org/netdev/DGRCO9SL0T5U.JTINSHJQ9KPK@imlonghao.com/
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

Applied to the ipsec tree, thanks a lot!

