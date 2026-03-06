Return-Path: <netdev+bounces-264625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mB9sDpU8qmlLNwEAu9opvQ
	(envelope-from <netdev+bounces-264625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:31:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB7821A9FC
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1E69300D769
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 02:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F8C34B43F;
	Fri,  6 Mar 2026 02:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrnUNuw7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAF134B68F
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 02:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772764302; cv=none; b=sv2rxfWqv8Th7JMV8wgXBbYfpIw9ZvnBRBChZAlMxS24vBBWvMC0Ri4g2gXMrDwhgFYO48h5Etq9db1tXOMoN99CaV9RV6itItRX5TTdrugxP7DERpAnrItzyMZ6h5V9ZEAzCOhhsqbfRvbgfxoW1Y5CAANvyk4lwxrh4sZ5MGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772764302; c=relaxed/simple;
	bh=fW8gBQOtfNePRqpqKBV9lUkeaR7UovNSaxmofrlbQgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O00FpdFyQIBfkWoVDlyHNE/HYLItGXHbpHGbxNIrPbFBYZ0fIirH7NdpnAgnKSF3jE6vXtVHma5xq4daRTeeHdcZAvVHd3A1T4HYrmiuFSWPSddrLSVtVgES6C3a/34mg9fTjoh6e0AJEv7tQBMY3P2TKl+4V/Vb1SmsxoUUUIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrnUNuw7; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8297310ce0aso1610527b3a.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 18:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772764301; x=1773369101; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rrMFSfOaZamk6DLKrZZgW30i49gOAC5qJ6C+E3QqCSQ=;
        b=hrnUNuw7YMi/37kiHJoeQ3u2A8CKpWbZjeUD1CFNoS8QL/hfK0l+6z48+1umm5sUuq
         Lzn6EuJ5udHmNEnrDAanCRuN4AbIH/lvtC1GgLPvlJS5F9Xt2bMcO32Tt0+wQ+cGPFSH
         AtCwImgLiY9Sad2QbefPPtwlw+CtqyWRIyjDxz+a0AIDXoUayT2/d6zijKxdBjBVsOgs
         l7+xUcKi/NmqTlmdz/ZIZUlWTELQ+gFR1/bmkXR8FM45A37ssig3DPMMNQ8ksU8ZK2GN
         rf59hQJ81Jec5zPWFXwvgmA/eGDZENEokH8ZaAhb182CijODTD7ZOcC1UyQeeEPcIsBu
         y1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772764301; x=1773369101;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rrMFSfOaZamk6DLKrZZgW30i49gOAC5qJ6C+E3QqCSQ=;
        b=NM0vfPO7ZEubexehckUwRTwD1bsTGNf6XWf8RqlIt9dYgcNlBtv9jXMkB7l6LQRsOq
         Mjm8lmPI7+WDOQTJELuqUyI/TSTA0WXmqsxXMdXDUy4Vny6tdWvNZF411hGgFq5WKZTe
         l+4Iw6GQZK1luZnjysC4e2pG+Uk71pholpfHx7Gg7Vyo7M6q0tZP8wIf17snIGu7Rerx
         Ne0eVY8uGHMqAZVX3mNVN3BCHEUrCHvtmM1+McziihkWFOumjBdgJNcuWsvebKfV916q
         FvCxpVKnBzoA9/DsbH2QRJxUfvGV9lGxoXrkYhXU0cKR+3ciNa30z5PSXGwveoDowNC0
         5YOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFTy/LnDdrFaiRgwnYC0DglabsvQeCtcuPc36mEvbqW/0LeSNIukZSI1R8q7jGTTX+Z8Aqvco=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGe5KUjJe6hfEbIW13DjEokf7huNYaH8ftwGQxNMySUYZqJ/76
	a94KGwsbGixIlig4tZUpgXSXcU93eCYnltzjQW8SrIKJcs0m6ieYQnyx
X-Gm-Gg: ATEYQzw9d/B/3V98HWzarvfojSWtTqUhfAf+f2e8LCSHlgf+ljW68FXBl6cIvFJti9+
	sC669bpkr7QKyWuYPcp4qjhTBTmIeZWTI/Zjce/OsNAyD7WGmLbtb/15pvDyA/QtiStbdp7ijwh
	wfxyR+KTCnGFW030vPpLJdht5LFHXfo/xcR/gVqyw930bNGnyq6mX+vFsZQC4DiRpN+A54O0bGE
	2lJF41MLhSD/om0/pD8EPbPUr88peemCbUf0GptNGZzFKQmHyb5R3DvixdQI5kFXTvIuBh9ZloV
	/vuu2I4R4keSJvNxKMexdGP9mpX/Q/YpEhZ5VgStBf18mGh4jPKRaUj1FHLZL2XmqX76hm4I2jg
	v7KqAYoiHm80N8y6gREqAXFeyHpSQwM3TGcGrIXLjmXZGNCclWNoW5LvrhBiKlUteypQtDm3SG1
	EerS+Ei5kMLVArgUVFp8rLr4+N6M0=
X-Received: by 2002:a05:6a00:1882:b0:827:455b:86b1 with SMTP id d2e1a72fcca58-829a2e786c5mr457884b3a.28.1772764300896;
        Thu, 05 Mar 2026 18:31:40 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4867e6asm66368b3a.32.2026.03.05.18.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 18:31:40 -0800 (PST)
Date: Fri, 6 Mar 2026 02:31:28 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	David Ahern <dsahern@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Fernando Fernandez Mancera <fmancera@suse.de>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/3] net: bonding: Fix nd_tbl NULL dereference
 when IPv6 is disabled
Message-ID: <aao8gM6br-_RJ5HO@fedora>
References: <20260305-net-nd_tbl_fixes-v2-0-b7177db1a9f3@suse.com>
 <20260305-net-nd_tbl_fixes-v2-3-b7177db1a9f3@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260305-net-nd_tbl_fixes-v2-3-b7177db1a9f3@suse.com>
X-Rspamd-Queue-Id: 2FB7821A9FC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264625-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch,suse.de,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 05:37:41PM -0300, Ricardo B. Marlière wrote:
> When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
> initialized because inet6_init() exits before ndisc_init() is called
> which initializes it. If bonding ARP/NS validation is enabled, an IPv6
> NS/NA packet received on a slave can reach bond_validate_na(), which
> calls bond_has_this_ip6(). That path calls ipv6_chk_addr() and can
> crash in __ipv6_chk_addr_and_flags().
> 
>  BUG: kernel NULL pointer dereference, address: 00000000000005d8
>  Oops: Oops: 0000 [#1] SMP NOPTI
>  RIP: 0010:__ipv6_chk_addr_and_flags+0x69/0x170
>  Call Trace:
>   <IRQ>
>   ipv6_chk_addr+0x1f/0x30
>   bond_validate_na+0x12e/0x1d0 [bonding]
>   ? __pfx_bond_handle_frame+0x10/0x10 [bonding]
>   bond_rcv_validate+0x1a0/0x450 [bonding]
>   bond_handle_frame+0x5e/0x290 [bonding]
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   __netif_receive_skb_core.constprop.0+0x3e8/0xe50
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? update_cfs_rq_load_avg+0x1a/0x240
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? __enqueue_entity+0x5e/0x240
>   __netif_receive_skb_one_core+0x39/0xa0
>   process_backlog+0x9c/0x150
>   __napi_poll+0x30/0x200
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   net_rx_action+0x338/0x3b0
>   handle_softirqs+0xc9/0x2a0
>   do_softirq+0x42/0x60
>   </IRQ>
>   <TASK>
>   __local_bh_enable_ip+0x62/0x70
>   __dev_queue_xmit+0x2d3/0x1000
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? packet_parse_headers+0x10a/0x1a0
>   packet_sendmsg+0x10da/0x1700
>   ? kick_pool+0x5f/0x140
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? __queue_work+0x12d/0x4f0
>   __sys_sendto+0x1f3/0x220
>   __x64_sys_sendto+0x24/0x30
>   do_syscall_64+0x101/0xf80
>   ? exc_page_fault+0x6e/0x170
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>   </TASK>
> 
> Fix this by adding an early check in bond_confirm_addr6(). If
> ipv6_stub->nd_tbl is NULL, return before calling ipv6_chk_addr().
> 
> Suggested-by: Fernando Fernandez Mancera <fmancera@suse.de>
> Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
> Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
> ---
>  drivers/net/bonding/bond_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 14ed91391fcc..7d32cd231633 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -3256,6 +3256,9 @@ static int bond_confirm_addr6(struct net_device *dev,
>  {
>  	struct in6_addr *addr = (struct in6_addr *)priv->data;
>  
> +	if (unlikely(!ipv6_mod_enabled()))
> +		return 0;
> +
>  	return ipv6_chk_addr(dev_net(dev), addr, dev, 0);
>  }

Hi Ricardo,

Since the ipv6 has been disabled on the host, I'm a little wonder why
don't we check it more early, e.g. in this if check

#if IS_ENABLED(CONFIG_IPV6)
        } else if (is_ipv6) {
                return bond_na_rcv(skb, bond, slave);
#endif

Thanks
Hangbin

