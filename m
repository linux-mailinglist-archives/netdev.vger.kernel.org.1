Return-Path: <netdev+bounces-297252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cTPIBB9tKGoEEQMAu9opvQ
	(envelope-from <netdev+bounces-297252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:44:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CDA663DCC
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:44:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=multikernel-io.20251104.gappssmtp.com header.s=20251104 header.b=fXMzF7Hs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297252-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297252-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C7CF30BA2C3
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 19:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0BF374A05;
	Tue,  9 Jun 2026 19:39:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0275A3749F2
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 19:39:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781033966; cv=none; b=oCBxj20OwZfuLs58ALgD1kC45bZ3eTL768shGPThYuT7ltu0beqqpPoOV+jpClQXXAwi1dNg1T2OK+1wXHmAgks1qPrlIr1fGuv8vVQk1QLD8X7CLbEJ0a0pjC2IUj6Fveh2ho25cjlUY6kj4G60u/Q8MF48F1CNGVEugGsZvWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781033966; c=relaxed/simple;
	bh=G00YHjqP3bT3ws7OX9mlgD6sNkuOI5ON+qLPcjzJ5rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jouKqxLQgWqtwZ0y5dvC24gscyC+2E7h48SyAbuHbGrInoXC0FMoK46w7c9KlfWnDNLuyxjIOvTq3/EatxG/8glVftwjJnU88LDsMjej9REE06f4vQfIp5qyiQEWMsCIFcY8a4V6Ug+GgFb6WTrniK/sQccGlRlFurhdn4GLf6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b=fXMzF7Hs; arc=none smtp.client-ip=74.125.82.176
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-304f0039c02so10666121eec.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 12:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20251104.gappssmtp.com; s=20251104; t=1781033964; x=1781638764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mP79Pj+AGA3xIgjnkm3qbd2XZJduzfsdCp0zY5QTkXo=;
        b=fXMzF7Hsklq5g5iDJQvb/f+YOtr7R5Q1Ux24mulhEhddXRwK2/UXyS+tD09DRgCrij
         CanzmhEX/OubFqwGk/gYwxPqSiH1ibeA79/wEPw9Y1thtLsurO9YXocaDiU/1esslKh8
         SKoAVwYEKaYw/W8ev/tRvpnlimp6aW9pQF8Br88GChuFz5kBp1taJ6iKEZqdsCGWMndU
         7DLVBsUMzc0zu0n7FmDsPMLStaTP8s6t1ZqZLwMpvukdVPrgWJg81uqW7AsC75x/iZcF
         N8CPVbNoXfb/PXGVBtZK63zb8PnN/2LiOrgbCmvGxeXGxFni3n+3oWAtAXIcR4XeU3vG
         zR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781033964; x=1781638764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mP79Pj+AGA3xIgjnkm3qbd2XZJduzfsdCp0zY5QTkXo=;
        b=ENPZ00K1ysk5KWKJ4d8O9pG7Js/iiz4qQ5ELIHNwHpGzKAJje9TTAT6dVxiI9AQfm0
         Day6dXyw5+zcgvA45AbzUFPKF4YwfLP//99DT5awP+bSBy0w0z93XPrNDqLFsopuV0hy
         nnSkYbXwZBxacxXbp4WEsPVoKPhpTpLPgqFk7CDhZX1Pvw20GhCx4CMSKZvPgNGBHSBS
         pUZplfhTTntlJgn/kklMrxApN2vCh9NppKq1W3TzLLeymIwkHfSlpKLraoaEHBdKqEfb
         h47Fe4yQUh0VojT5kTctibSft2tKXmVq67SmC0EattaQvHTM4oVri+5h1rBi0jiRNDru
         3EsQ==
X-Forwarded-Encrypted: i=1; AFNElJ/y9yupPisVNHXo3JxWJQx9TSWiBw66WrR+EbMHwQ8+70v2vrSiVeDKV8b6r/UYSbZEnc/ZGe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO/R19XnZ61xmjNf8RtNgf99nw3o2YTBPR6fapqUuTGUWDzcIB
	EM8cKiav/EnEC3P6KowkT1eDlqDXnaBgF3iBH3X4DfvgFuUwKcwOkpC5FE6jwTwtdZw=
X-Gm-Gg: Acq92OGqxdr+jAGjIhEhv7aG4IVSylnOOtuM6Dk3pF+T38eCK7z7cWnrYz7fmRLMpsg
	LHGX/+EkeAPWKH386OuIOQYFmm1fBmYMrGaMkRXAFbyo283OUWbdVj2QDZV8FnrBJyZjWvAJVrL
	dOV+V2IVC/tR0jETy2DWV6r8ImaaHb7Yff6jwSnEQcaByntN/TxR+Zg75lQka86ZPIPHusC5XFs
	SRIx0PlDpbcY777l9A5WiPAN5BWNQEpAR9sNpXsOjXwl15qppzaphmQ2Rw4M5brI8j65agMbnwC
	jJrCrh0FfWkEDcnYcESaMV/XSSIYjJpYP0Onzma1lrNR/s3ARlYLxQrfwyC9FL6hLjZp1/witmd
	MSsri2VrkqVVOfdYuMmoEQ697J5zw1LrCmYON9K/ljctaPHQIl/jpCHkoiVDTyliUTNAicnT/xm
	DGhwtHlpqkkKwvoDYFizY2gEqF6JOB1j9fonu0gvcePu5neSGGbXgVZWPd6IOzHrjz4n4=
X-Received: by 2002:a05:7300:7493:b0:2e7:c701:aa85 with SMTP id 5a478bee46e88-307d62db622mr3709830eec.17.1781033963904;
        Tue, 09 Jun 2026 12:39:23 -0700 (PDT)
Received: from localhost ([2601:647:6802:dbc0:cc9d:48e6:8d05:b444])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db56697sm23177016eec.2.2026.06.09.12.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:39:23 -0700 (PDT)
Date: Tue, 9 Jun 2026 12:39:22 -0700
From: Cong Wang <cwang@multikernel.io>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Zijian Zhang <zijianzhang@bytedance.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: fix integer overflow in
 bpf_msg_pop_data() bounds check
Message-ID: <aihr6sPEZ4BDual6@pop-os.localdomain>
References: <20260609183927.4021802-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609183927.4021802-1-rhkrqnwk98@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[multikernel-io.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:sdf@fomichev.me,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:zijianzhang@bytedance.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[multikernel.io];
	FORGED_SENDER(0.00)[cwang@multikernel.io,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-297252-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[multikernel-io.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cwang@multikernel.io,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,bytedance.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,pop-os.localdomain:mid,multikernel.io:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60CDA663DCC

On Tue, Jun 09, 2026 at 06:39:26PM +0000, Sechang Lim wrote:
> start and len are u32, so
> 
> 	u64 last = start + len;
> 
> evaluates start + len in 32-bit and wraps before storing it in last.
> The bounds check
> 
> 	if (start >= offset + l || last > msg->sg.size)
> 		return -EINVAL;
> 
> can then be passed with an out-of-range start/len, after which the pop
> loop runs off the end of the scatterlist and sk_msg_shift_left() calls
> put_page() on the empty msg->sg.end slot:
> 
>   Oops: general protection fault, probably for non-canonical address
>   0xdffffc0000000001: 0000 [#1] SMP KASAN PTI
>   KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
>   RIP: 0010:sk_msg_shift_left net/core/filter.c:2957 [inline]
>   RIP: 0010:____bpf_msg_pop_data net/core/filter.c:3103 [inline]
>   RIP: 0010:bpf_msg_pop_data+0x753/0x1a10 net/core/filter.c:2984
>   Call Trace:
>    <TASK>
>    bpf_prog_4cc92c278f4d5d56+0x1b1/0x1e8
>    bpf_prog_run_pin_on_cpu+0x107/0x320 include/linux/filter.h:746
>    sk_psock_msg_verdict+0x357/0x7f0 net/core/skmsg.c:934
>    tcp_bpf_send_verdict net/ipv4/tcp_bpf.c:420 [inline]
>    tcp_bpf_sendmsg+0x766/0x1ae0 net/ipv4/tcp_bpf.c:583
>    __sock_sendmsg+0x153/0x1c0 net/socket.c:802
>    __sys_sendto+0x326/0x430 net/socket.c:2265
>    __x64_sys_sendto+0xe3/0x100 net/socket.c:2268
>    do_syscall_64+0x14c/0x480
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    </TASK>

If you have a reproducer, please consider adding a selftest either
together this patch or as a follow-up.

Thanks,
Cong

