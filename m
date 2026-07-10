Return-Path: <netdev+bounces-306394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xDLLIWI5UGoavQIAu9opvQ
	(envelope-from <netdev+bounces-306394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 02:14:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F37E73652E
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 02:14:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UgDcTE1x;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306394-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306394-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 029B63040FA0
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 00:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D97C78F2E;
	Fri, 10 Jul 2026 00:13:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDD027727
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 00:13:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783642422; cv=none; b=DOIWSynQY34LffGdlbLk2GhrtSXYZI8ovT/zOkA18QUUm/9PvKrGeOnnHuCqQQ4nW7sywcPBGkNvh5vigKUM4YpOLf48dSnQUCnQHImHLU8ajPhH343Bsowd9h9PESNMkxgCgfuX3ZM3YBZmQcPQAP/65vSTqrcMXheW5YtVxl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783642422; c=relaxed/simple;
	bh=U77JBt3rd7KrKi9B6ZSJ5Gotj4ak/N4gpOAn1+GSv0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaFX2+L6dmh+EwtUwO8Cwn4yJ4fJW2Q1+D/vv1t6/xtbfFGpiBZoeOYOjxwTVG4rM0IQm/FXO1ZFURwfX49UH6ia4MOdfc4yFXpvrq4paTluqy3zrviuCo86pa8/pf4wxf6mVov/nu+DYYku9/Ej+U1tDwlk31qokTMZvKVDUns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgDcTE1x; arc=none smtp.client-ip=74.125.228.0
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-ca24d39d8a4so221195a12.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 17:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783642420; x=1784247220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i/r66+UhRj5gZonbxUZ/VbF6Ixd13WSFTkICbzygVdQ=;
        b=UgDcTE1x7h5/pmPK5BzDpThM/svKjucSI6WFLIZtHNa2LqaI5NABDTzdFd3nJBEgw6
         ge4n4GEyWZNOcFltQe2XaaLofh0w0ayISm2Wabauw8HKBuwElHVnK97m9uZC3axfL5ue
         pkUFI0N0/M1UWQG8KiOEB3NPpv2xr1gG5kIMJfE0lUKCqZPjUp6IOyZ7Nd6ZvjvovV3v
         9sQSLgKBsPd1hqXRmod6n2w5WDv23rmjrJdTRTr0J2hlt8+Gc04kvATU0L7k63gPVNLH
         d0kSM+KWgG3bDv07ovDegj82dxGqhJQvqt7NlneSZ4TV7qeNOkvwcyvFWnd3sc2WfUVX
         sAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783642420; x=1784247220;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i/r66+UhRj5gZonbxUZ/VbF6Ixd13WSFTkICbzygVdQ=;
        b=dxVKGS6j36nyb4lULN29VVn3nu92/xDTywMhAhHyfybWQuBKjnI62VzydqSL8kqqvc
         mYDUw7v3Ak0Yme9M8Zn77sVLFis0Hb0fWx1G+WNrbHBQoQYC9NvCtJcxZfgZtskKjUaF
         /g1Vl+BjcSRgVJtdnlg8wKgvaUuoobVdJ61IUX1c5+sQgIkLVv7Coloeln6P6frBi6e3
         NpL01NjiUgCwH9M0W94Hgqe/O6G67EpwEYg51tsV/EWa0+62nOTtkjus2uXOeVK6ldHR
         NbtxzNUxzcnqZ4rB0cHHBGDF0Fc1sG0WrF+TeoT9LeN9C2TgI3hxBb7cY4JM31LTVer4
         ly6A==
X-Forwarded-Encrypted: i=1; AHgh+Rqq5p4K8R/ZIlCf6IwwZiGs4olmBUlBVPlg8HX31xmaPOGmHGEgCFlz97oyVzpE+K0DuIDMPGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YytDh5mJHoyiycIjW+6c0UrOL1pF7QaytlwHXvgSp4Qkgeemvjh
	7faAFfbQPoYCEDOqDaSIpJ6YISkrsa/ho6QMXC6Vdnpp5QpIOPhoz9WT
X-Gm-Gg: AfdE7cmEPlYdSZBHcEL7COfWuQCtHLa9ZUZscG/H8TvxFp0jLe8HOCvgNV17glL7wPH
	3/GqNfx90/77M6AiQFAmYZ/baDej81WFYikg/koAZUvRDBvF/swPvjuDUgbBCrJKeHT6szqaexx
	4PuG8OEj3ZUCDUHcb6Wghxq4L05xWZUCABTurCpoBLNnIC3E9W3ra1/Bp9RA0/tJnRJUK7/U3HW
	7NBT3f2+94F13p/hHmEfHyT5NXlKarP7Ob5g/snqqyh5z7Ukutv91e+Xw/x668bjk5Nq5JTsaAS
	gUSBktzuaSq03ezrUY6t5jfuF7Y/WSvXAfsO32MD/C7zF5fFWkLQYK/Dju6tA0uspS65rXJlhmt
	1tjgsLhmTzPqWiaVUDodA8ROlyuPPRkNhSWlt3DOI93wHQhxr6cunXjJqoeQ4CHyDIZXKMrW9Qj
	QN80mHcJMNPb4x
X-Received: by 2002:a05:6a00:3d0a:b0:847:99bb:b6d8 with SMTP id d2e1a72fcca58-8484302e490mr9433177b3a.26.1783642420202;
        Thu, 09 Jul 2026 17:13:40 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6ddc974sm9519604b3a.60.2026.07.09.17.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 17:13:39 -0700 (PDT)
Date: Thu, 9 Jul 2026 17:12:37 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, jordan@jrife.io, martin.lau@linux.dev, 
	yonghong.song@linux.dev, emil@etsalapatis.com, netdev@vger.kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	horms@kernel.org
Subject: Re: [PATCH bpf-next v11 2/5] selftests/bpf: add bpf_icmp_send kfunc
 cgroup_skb tests
Message-ID: <alA47To0uswUAFf3@devvm7509.cco0.facebook.com>
References: <20260709144900.245904-1-mahe.tardy@gmail.com>
 <20260709144900.245904-3-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260709144900.245904-3-mahe.tardy@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306394-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mahe.tardy@gmail.com,m:bpf@vger.kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:martin.lau@linux.dev,m:yonghong.song@linux.dev,m:emil@etsalapatis.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:horms@kernel.org,m:mahetardy@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,jrife.io,linux.dev,etsalapatis.com,google.com,redhat.com,davemloft.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,devvm7509.cco0.facebook.com:mid,fomichev.me:email,etsalapatis.com:email,jrife.io:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F37E73652E

On 07/09, Mahe Tardy wrote:
> This test opens a server and client, enters a new cgroup, attach a
> cgroup_skb program on egress and calls the bpf_icmp_send function from
> the client egress so that an ICMP unreach control message is sent back
> to the client. It then fetches the message from the error queue to
> confirm the correct ICMP unreach code has been sent.
> 
> Note that, for the client, we have to connect in non-blocking mode to
> let the test execute faster. Otherwise, we need to wait for the TCP
> three-way handshake to timeout in the kernel before reading the errno.
> 
> Also note that we don't set IP_RECVERR on the socket in
> connect_to_fd_nonblock since the error will be transferred anyway in our
> test because the connection is rejected at the beginning of the TCP
> handshake. See in net/ipv4/tcp_ipv4.c:tcp_v4_err for more details.
> 
> Reviewed-by: Jordan Rife <jordan@jrife.io>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

