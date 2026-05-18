Return-Path: <netdev+bounces-289104-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIouCf0yC2qgEgUAu9opvQ
	(envelope-from <netdev+bounces-289104-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 17:40:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B335457026F
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 17:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BB173057749
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F2F3F54D8;
	Mon, 18 May 2026 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tA1IA9X4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E17A2F7F06
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118478; cv=none; b=hlDoI7QwbcSvDSh3GIB4NRhxqQZ6GbyIEbt8cr8d7kCPZKMTvhOalB3axh6gkY7ce51Z4AyDC07tHZj5nI5WLnygGziCZIO4LJ9mqZatXbDG70ezWXjSQTW4r0KflB7mIeUoseXNqQEJw5DEFSZgLx8UeGZfY3aEv6B6vt6NEdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118478; c=relaxed/simple;
	bh=tbBqVl2Rwq+ug/3pxcSsXUY2Omq/LcBl+AADnhVJGJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGMzSdXaOczI2w+JSPhkIgJUnpXqj0v7Q2jJxeWy+ldtL7xXa4uovMFIU1KZa2lvGhCssYkWWC9pGHrBctqswh8a5dcBRYKAWKhFZLTnckB9hL9K0PL82jGjbWmnFHTNp3QIKpwPa6LJftaCYxT+TAr4o2KYfbpXzAPv4hOIRFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tA1IA9X4; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-7c307937816so17061147b3.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 08:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779118476; x=1779723276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yQbyMvz6XLiuRTxyqtiLM3EHuxR7kEEq3JV9iEUFgR8=;
        b=tA1IA9X4xgPK8efiksGsoB8Im0KF2PQUOu2+0Oe+VxGUj4fbZ0cxjWBgPRwVgT5dIm
         dWQj+f3pq/uQxeuFhtbTPAGXgNyuxFfdo3yo6pphc/0kl0DQwBjbMJRIEPLC8/ukX3A5
         sWet9IW6xWB1MFtEQpFsF6kxrSTYbyBcOaorUaLa8dlfvuTYZCccmCt4u+do+QjWgd7t
         j3U0V3aRsTfmrqpCz3ZNIowJRLQBf2vLzGNrDUSASSRu19hNkl8BRpS4+2wzQJBPnPei
         5e4KqjEx5GFfyrReQuo1s9vWiRiff95nbndkC14jDGzZp6nSO4dMyeJjnoX+b2qFQKLX
         oHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779118476; x=1779723276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQbyMvz6XLiuRTxyqtiLM3EHuxR7kEEq3JV9iEUFgR8=;
        b=ZPG3ISk6oJDvgeLYtKzhIaDC2eXuWhAFKmasKsHoUR+sr8ZauL8rz8/v2dxZY7lM3h
         Oq2k+BqbgHnRKxIa0F9VGSAk1zsF5RME0SU2v+pzFVWRPivX9BJU/Hm9lobb3XW+4/+w
         NOyerijckvI2+ChNXSsqom+Xu6x8Ni0NUn+S0cwG/MqwOl62Fqn5IJQsyK2yX7Y+/k4N
         9KwzoK3XwTj0v08MeDKn2cW3Zl+npgyJXFac3azVTwLDCn1w9hrH4rQtOgapQuIYToYK
         n0xa9ojKtm1LeszcXF1VdNDu0lVmPsWkGIt7GUys3pE1VxeuYO9GK8dhdbqb1FtjNV3B
         vp7Q==
X-Forwarded-Encrypted: i=1; AFNElJ/iuz3IKfKf85KFih8AFWCf2BE46B+l04PVGWQPdlOyWGf27Csv7qA0D85/jyevQUzXi6Oi0l0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP7xTu+InkUpW6VdihIjGIoZLUEYCav5PDcglF6kUX0EcFPT/I
	OzNTuVI5yLsoJYl05x01Z9/I+TZlFoN/Xdu7wnARJjfnQlkOdyD71Z00
X-Gm-Gg: Acq92OEd4J4+xhpTpGnDcOUk85Zmf+Rkez0fP+9tJyEStRQkRA9eLzzwWoUdaC0H9X5
	wKEY3EtNKYHiK9VqA7YsvuAB11kMC/wDCe4CHlweJXyeilJZVtXgiOwpd9a5AXn+M7m8YeQ7rIL
	qJdnYfUJVMM6ZC/kDqoRZJwQaMoKakGNUOk1B7+jJDhTUnhpiT6pLZmmDyifwlC0K7BsocEaW09
	NKUtrmMlLAzqWkN+DMr3yApbjD9p4lUFkx9KzeO4dYkU/Ss5pN42M8eP7HISLjb3XDy8cjcIAv5
	CkDU24a9bYEmW4h428TPWgb3EZfvz9AHJNrSifVnYhxEPlBZdoFXhbWU/uD8U0oqbpOJr4mKoMS
	7ko7EdA0CsDecer9/UM4fE2iW0EMhnY2HuLR6sfJtgoKRtsriUkkOme+uxYzeoor80AdhviBe3X
	oqfyHJLlSVCdXm7ukkm6uSl7P2uHs=
X-Received: by 2002:a05:690c:c1a:b0:7b8:bc4e:a54 with SMTP id 00721157ae682-7c95c7edf69mr180168827b3.29.1779118475483;
        Mon, 18 May 2026 08:34:35 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9bc0eff6sm22692987b3.23.2026.05.18.08.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:34:35 -0700 (PDT)
Date: Mon, 18 May 2026 08:34:34 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, kuniyu@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next 5/6] bpf: enable bpf timestamping rx in TCP layer
Message-ID: <agsxE575ri8iLgxM@devvm7509.cco0.facebook.com>
References: <20260518082344.96647-1-kerneljasonxing@gmail.com>
 <20260518082344.96647-6-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260518082344.96647-6-kerneljasonxing@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289104-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,vger.kernel.org,tencent.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,devvm7509.cco0.facebook.com:mid]
X-Rspamd-Queue-Id: B335457026F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/18, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Add two if statements to accurately isolate bpf timestamping and so
> timestamping. They can work respectively.
> 
> As to so_timestamping, only add a loose condition via report flags
> to avoid duplicate strict checks that is done in tcp_recv_timestamp()
> and performance impact. If the loose condition is hit,
> tcp_recv_timestamp() is able to handle the exact case and doesn't
> hamper the existing timestamping feature.
> 
> Make it work in TCP protocol.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/ipv4/tcp.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 21ece4c71612..64c69bb3578a 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2949,8 +2949,18 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
>  	release_sock(sk);
>  
>  	if ((cmsg_flags | msg->msg_get_inq) && ret >= 0) {
> -		if (cmsg_flags & TCP_CMSG_TS)
> -			tcp_recv_timestamp(msg, sk, &tss);
> +		if (cmsg_flags & TCP_CMSG_TS) {
> +			u32 tsflags = READ_ONCE(sk->sk_tsflags);
> +
> +			if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> +			    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_RX_TIMESTAMPING))
> +				bpf_skops_rx_timestamping(sk, &tss,
> +							  BPF_SOCK_OPS_TSTAMP_RCV_CB);

What about tcp_zc_finalize_rx_tstamp? Do you not want the rx tstamp for
tcp rx zc?

