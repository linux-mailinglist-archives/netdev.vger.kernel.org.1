Return-Path: <netdev+bounces-298765-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5NJ7MtxNLGpmPAQAu9opvQ
	(envelope-from <netdev+bounces-298765-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 20:20:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC95167B9E5
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 20:20:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Knp+OTXm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298765-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298765-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D753D302428B
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850EF395D8E;
	Fri, 12 Jun 2026 18:13:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD9E37BE72;
	Fri, 12 Jun 2026 18:13:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781288015; cv=none; b=HhtoGsyMshRuaJF6H1mRKHLh72TNIJN0j0ZAXQSR7hpwfRKhcwFtsLt2eX0q17PoXqextZOhZP+BesPa5f2ePBaLj0PNmDmY089qtb0sco3etO/uCfprk0UqNPn5FL1xJLbdGyoh43H7Ydq9SZ3taMd3Qv15xO6dOELZft0H/IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781288015; c=relaxed/simple;
	bh=+6z8gqF/pdow2lk8DKYm++IRzUTSm8oNDeHTGnJd4Ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBVXVWMGoyyfQ6UJO7Qf4xTK58RnOuUMT0C/JxV7RY3xPg0GGNjS3BJuRe7VVBwPApOk0l+D9Z5Tkzi20P3Vdkr/De7hqKQtXT/PjDJ9bKfZk+v9oPhkKkWSBaHzPBLATpkrGfMoQPbKjmUT4SRVzqOIR1rcmjIvmsHdGiGK5A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Knp+OTXm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFFA1F000E9;
	Fri, 12 Jun 2026 18:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781288014;
	bh=ZwYCwWeTmmit2nkq41jaq0H1yOqgsyEenFLXnjwhYwo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Knp+OTXmxpJsuycvT2MDrvTJmS28MPVDNDq2Bi4qIf3DU7ohoSsXN4dpusHwxfTKk
	 A2qbx9SD1c1/Glxr/qsTRZn1ErINL+Fk3zpKOHHj+Gw/b3PU25AehhfCh0uMB9qCxU
	 AfUd3l8TypCoN80kz3uiWawkN6ipZh3SVs0qnTqrZtfiwXPcdunyjYpnegriqgQVCO
	 CPBwuRhKcR7iKFf8LhgpdaAla0LT8VQMNoRoMsKF326iRZ6rGf04YG1gOHOgCRhcs2
	 WlJ8WPNJkfsfmm++KPhSNAN631Z/+vzqcwhDjubuQrg9o5lzzP0eH3Ml142HAMpR0e
	 seBbgFVn7ZviA==
Message-ID: <5e024bf5-2d0e-4249-9561-f32081ec29bc@kernel.org>
Date: Fri, 12 Jun 2026 20:13:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] tcp: Remove mmap_lock fallback path
Content-Language: en-US
To: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Alice Ryhl <aliceryhl@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOl?=
 =?UTF-8?Q?g?= <arve@android.com>, Carlos Llamas <cmllamas@google.com>,
 Christian Brauner <christian@brauner.io>, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
 Lorenzo Stoakes <ljs@kernel.org>, netdev@vger.kernel.org,
 Shakeel Butt <shakeel.butt@linux.dev>, Suren Baghdasaryan
 <surenb@google.com>, Todd Kjos <tkjos@android.com>
References: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com>
 <20260610230419.F746395F@davehans-spike.ostc.intel.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260610230419.F746395F@davehans-spike.ostc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dave.hansen@linux.intel.com,m:linux-kernel@vger.kernel.org,m:aliceryhl@google.com,m:akpm@linux-foundation.org,m:arve@android.com,m:cmllamas@google.com,m:christian@brauner.io,m:dsahern@kernel.org,m:davem@davemloft.net,m:gregkh@linuxfoundation.org,m:Liam.Howlett@oracle.com,m:linux-mm@kvack.org,m:ljs@kernel.org,m:netdev@vger.kernel.org,m:shakeel.butt@linux.dev,m:surenb@google.com,m:tkjos@android.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vbabka@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-298765-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC95167B9E5

On 6/11/26 01:04, Dave Hansen wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Previously, the per-VMA locking could fail in the face of writers
> which necessitates a fallback to mmap_lock. The new
> lock_vma_under_rcu_wait() will wait for writers instead of failing.

vma_start_read_unlocked()

> 
> Use the new helper. Wait for writers. Remove the fallback to mmap_lock.
> 
> This really is a nice cleanup.

[obama_medal_meme.jpg] ;)

But yeah, it is!

> It removes the need to pass the lock
> state back and forth to find_tcp_vma().
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Lorenzo Stoakes <ljs@kernel.org>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: linux-mm@kvack.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arve Hjønnevåg <arve@android.com>
> Cc: Todd Kjos <tkjos@android.com>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Carlos Llamas <cmllamas@google.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: netdev@vger.kernel.org
> ---
> 
>  b/net/ipv4/tcp.c |   31 +++++++++----------------------
>  1 file changed, 9 insertions(+), 22 deletions(-)
> 
> diff -puN net/ipv4/tcp.c~ipv4-tcp-vma-waiter net/ipv4/tcp.c
> --- a/net/ipv4/tcp.c~ipv4-tcp-vma-waiter	2026-06-10 15:57:56.972472379 -0700
> +++ b/net/ipv4/tcp.c	2026-06-10 15:57:56.976472521 -0700
> @@ -2171,27 +2171,18 @@ static void tcp_zc_finalize_rx_tstamp(st
>  }
>  
>  static struct vm_area_struct *find_tcp_vma(struct mm_struct *mm,
> -					   unsigned long address,
> -					   bool *mmap_locked)
> +					   unsigned long address)
>  {
> -	struct vm_area_struct *vma = lock_vma_under_rcu(mm, address);
> +	struct vm_area_struct *vma = vma_start_read_unlocked(mm, address);
>  
> -	if (vma) {
> -		if (vma->vm_ops != &tcp_vm_ops) {
> -			vma_end_read(vma);
> -			return NULL;
> -		}
> -		*mmap_locked = false;
> -		return vma;
> -	}
> +	if (!vma)
> +		return NULL;
>  
> -	mmap_read_lock(mm);
> -	vma = vma_lookup(mm, address);
> -	if (!vma || vma->vm_ops != &tcp_vm_ops) {
> -		mmap_read_unlock(mm);
> +	if (vma->vm_ops != &tcp_vm_ops) {
> +		vma_end_read(vma);
>  		return NULL;
>  	}
> -	*mmap_locked = true;
> +
>  	return vma;
>  }
>  
> @@ -2212,7 +2203,6 @@ static int tcp_zerocopy_receive(struct s
>  	u32 seq = tp->copied_seq;
>  	u32 total_bytes_to_map;
>  	int inq = tcp_inq(sk);
> -	bool mmap_locked;
>  	int ret;
>  
>  	zc->copybuf_len = 0;
> @@ -2237,7 +2227,7 @@ static int tcp_zerocopy_receive(struct s
>  		return 0;
>  	}
>  
> -	vma = find_tcp_vma(current->mm, address, &mmap_locked);
> +	vma = find_tcp_vma(current->mm, address);
>  	if (!vma)
>  		return -EINVAL;
>  
> @@ -2319,10 +2309,7 @@ static int tcp_zerocopy_receive(struct s
>  						   zc, total_bytes_to_map);
>  	}
>  out:
> -	if (mmap_locked)
> -		mmap_read_unlock(current->mm);
> -	else
> -		vma_end_read(vma);
> +	vma_end_read(vma);
>  	/* Try to copy straggler data. */
>  	if (!ret)
>  		copylen = tcp_zc_handle_leftover(zc, sk, skb, &seq, copybuf_len, tss);
> _


