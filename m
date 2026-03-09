Return-Path: <netdev+bounces-265346-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIQpGJIZrmk0/gEAu9opvQ
	(envelope-from <netdev+bounces-265346-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 01:51:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A00232F42
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 01:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D9E53019F35
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 00:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D020C239E80;
	Mon,  9 Mar 2026 00:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXaqBm/y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D5419E97B
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 00:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773017474; cv=none; b=bRPzVE1d1GtcW+RM6hxMtUBPBh3UEE3xeA/h5oStmVrLJAUpV0OasPz+4+uU+DZTA0Pf96JVRCnzC4DdYwvMKPfp24AEK+VioC1KGWJ/igNp33b1dVkR1dj8PzJe1UYsJR5MsyDnUszaA6CG9+lwxr/8pZt41roy6F/ZB1sjTgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773017474; c=relaxed/simple;
	bh=RP++oaAENCDfdPEBn0eleqFM3JOYSMJrMeHuCLOSiaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtfV+c5vObp97tdvc5GXyR2Viwji7t6o8OxwB/+4+m2c4umIpcxYkNZPGPswCMPlAf7AWmvM+JmucrBzaNBugsACjFFwX4LnyicxLktaIq8LnSW4V7MJqcJRwfXirahjaqqGomcA4csQUbUnZeQoRq+aSk7472T5WEZ55nRLp8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXaqBm/y; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-829781b2b01so2896291b3a.2
        for <netdev@vger.kernel.org>; Sun, 08 Mar 2026 17:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773017472; x=1773622272; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NyUeO1XqBZxXrzuRGXceTat8xeWAmoV2Pi1+QZtQ4ME=;
        b=bXaqBm/yotArpy56WlkAN21Igl1IxGuBySrTkY2YM5f51n4TOnclOEuITgihMEt1GK
         Z9fn9U/VW5Cixo+HVYjBm+vzJvyYx7QDjlgQQrwDKJK8Ok9/SK5JPgDSje8lvhNjjDhd
         3HWGwoeb9tJ9k3XS34trmDvCss7cXVVWdK/FvxKeZDH2qn3NJEssv7j7vE37dBtB0T9x
         1DvKTZ8ydttoKMNNB+uEn/RFJobRNAkqGRRFzuqVG2f5ylDHPzDSO4TV+yEwf/UrG9y1
         +la8cigHY3/L4eHhuiTl1v4Hvpk2EBvhcdBo5CcQfes1K9EHe1v1sSP/atGuACaZfadH
         xIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773017472; x=1773622272;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NyUeO1XqBZxXrzuRGXceTat8xeWAmoV2Pi1+QZtQ4ME=;
        b=iNsfJ7x28y1n/WgCIwe8Xk38hz/cqGw2qo3s5Mh/+BW5NrOohky4vLNDi0W1zF5JTU
         WgqXxMUvNW0K/0Le4qOlT1kHSFCydlIVf5AsWHweD7DroE6QMMPQ+uKML5xjLaZ+rbLB
         ekIKZT9SZVbbR3ZxSeUwxiHV6yDjv4pr+23hcxGO05MsNS3wfup4wbgWo1i/5Unvl+lL
         y68n3jpYskhz83yoTWAAyFxf+XFLHQUAvmjuzduABJgCqy3mqENRfKROtie2E+XQNjDg
         u0p273Vv7M1C6RlqlVAmNKNtihxwo8oZmi7EyxMC25mCH96HQhvVFBtvKE80xezncTXx
         RKNg==
X-Forwarded-Encrypted: i=1; AJvYcCVMshpuNxjE54Ohfxd+nNrf3O9IN2cRAM/g2XRVuSzkMUSW1B4qPAzI6iclgnz0gMKPhgQ7cKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMNmWYtqh9qyrp2v6rFsPKBixr4BQIgLa0T7NnfZEbjSVlX1gg
	Wg4n6L/RrfIb0x+t4pEJdYHtf5xbEFePgu26rJ3M+ekuAmm1FnPbdyGS
X-Gm-Gg: ATEYQzyJdLszQ2mPX1fMA6fj1d0DAHfBtYR7Yb6GA0bTYyyrRBjCs2txxdnxbIUIC16
	T0TSCsIlY/IbhAXEP1pc74rOQdl366RjXNzVXNZ9snMjcZHXS0quSyF9zPYiO+8Ee7O0YRoekEe
	wx16ASn7ACElYPl5OaLzf6ktwMM00vZWEAr4d46Uu7y8NKv2VoALWq8KwKfBpgMduNLbKO5SqXY
	xIJanQWXOPlBTvXAaI9KtfdpQeqsQihMuRANpfxwpb2wjpQmjDOxOVx8r2t2PgYxUK+ag6t/8SE
	OiqdV6daM9apkZXaVsHqO52WAokkkDInqA9DLfdxQx/Y0lACxfosGf8DtriyNKeeyc8m75DyQ8j
	D0DyxpCOOqScdXc6+bQM4qb2yqlGmVidCcnGUr3ZvY5iPdiR7RS4I85SPjMGaE/qbgxGnb32Zxy
	LF09D+5Ru/t3iZ8sMQ05DhoiuZ9Vg=
X-Received: by 2002:a05:6a00:3cd6:b0:81f:4566:ccde with SMTP id d2e1a72fcca58-829a2dc33c8mr8984256b3a.20.1773017472211;
        Sun, 08 Mar 2026 17:51:12 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4636a92sm8405090b3a.1.2026.03.08.17.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 17:51:11 -0700 (PDT)
Date: Mon, 9 Mar 2026 00:50:59 +0000
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
Subject: Re: [PATCH net v4 2/4] net: bonding: Fix nd_tbl NULL dereference
 when IPv6 is disabled
Message-ID: <aa4Zc3fbvDXor1jn@fedora>
References: <20260307-net-nd_tbl_fixes-v4-0-e2677e85628c@suse.com>
 <20260307-net-nd_tbl_fixes-v4-2-e2677e85628c@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260307-net-nd_tbl_fixes-v4-2-e2677e85628c@suse.com>
X-Rspamd-Queue-Id: 02A00232F42
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265346-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch,suse.de,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.968];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:email,suse.com:email]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 05:50:54PM -0300, Ricardo B. Marlière wrote:
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
> Fix this by checking ipv6_mod_enabled() before dispatching IPv6 packets to
> bond_na_rcv(). If IPv6 is disabled, return early from bond_rcv_validate()
> and avoid the path to ipv6_chk_addr().
> 
> Suggested-by: Fernando Fernandez Mancera <fmancera@suse.de>
> Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
> Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
> ---
>  drivers/net/bonding/bond_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 14ed91391fcc..33fb5f168cef 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -3377,7 +3377,7 @@ int bond_rcv_validate(const struct sk_buff *skb, struct bonding *bond,
>  	} else if (is_arp) {
>  		return bond_arp_rcv(skb, bond, slave);
>  #if IS_ENABLED(CONFIG_IPV6)
> -	} else if (is_ipv6) {
> +	} else if (is_ipv6 && likely(ipv6_mod_enabled())) {
>  		return bond_na_rcv(skb, bond, slave);
>  #endif
>  	} else {
> 
> -- 
> 2.53.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

