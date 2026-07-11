Return-Path: <netdev+bounces-306852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vi/iHKZBUmrzNgMAu9opvQ
	(envelope-from <netdev+bounces-306852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 15:14:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD747741A37
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 15:14:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=FfW4S54r;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306852-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306852-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEA043006F2B
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 13:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792B21D54FA;
	Sat, 11 Jul 2026 13:14:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5884215687D
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 13:14:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783775649; cv=pass; b=aQt4ZZ1f3xMjf5eGA9g1KQhIGJooOK9/VMAgLBpLRWhSGQ0lhRck+GsAD5fqMnEU+kCh3GFmolYx/WvUKCiwoquB3nxHDai7P/hPkq47q7fLwS4YpwdykAGTrUMJ5KcpkxTmbbY6LGYpftvDBuMcFqZnhDv5UWeOJzX9w1NSVm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783775649; c=relaxed/simple;
	bh=ZTJ2c3pJolQuqA077PMcdA8W5kgvq03sbfwzhs5fdd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkpoLBfjaMLbVssNa77/xHeZq+k196n7XdkkS+bQCwp9iEMPaVytXhs1VMpCdq4SkZMBamlmpr/fn+gTldoF59JviQyn6MZUOHATkamHHV5Ao5aRMqnuUTpwGAoMyf2BtKmNoM/cEnfhTlF0zKd8DWwH2u2nqIUEdc7PK2qPPJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FfW4S54r; arc=pass smtp.client-ip=209.85.214.175
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cacb8416a1so15288225ad.1
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 06:14:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783775644; cv=none;
        d=google.com; s=arc-20260327;
        b=L0u06iOnqU2G5rrXmJFz6jIzsa9drVIklnarh13f4jmEUR2VzxqJmyIUdPGAqkKHx8
         9uyqkj3UpRgI5iRX9xW+P+miG1+jnELuZRjmTjrfgZeXaunHzAJlWTGnzeTeAzV+JF+E
         4d3P0rANW29eQD2kI8dImg5sh8nnuIgLQbu+39yLCZ4hTSEd35VZUxN6VTrYL4OQc+tP
         w5K/M/agr0AH8WwNH3Ef/qqcIFs+rxc0+jCt0yedndBZ4yQQmoStM2NTtuVsqtkKNGT5
         yZt7tTJWWrP43jndK6Q5Gd2wYdoI65IarMtVtYmxNAG5onBKLXrWAlwrQMyxhNggxv6t
         de+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3S3ssLpixBRf8e5hrXoPkuS8xI2TY8QEPNI7CT1Aa6w=;
        fh=hvisUSahHnI7DGHduTMBNwJQ5LdW45uOEspGGlKvdOc=;
        b=hYwZfrGM51cxvm/fmQ4GAPamAsl3OHWoj19zZgdfKW33Nktjlkuustk/iSZbIPXMs1
         aQE3pcweRpwissAKy+Gr+0VUPZl/Y7pK4AvyOS+hZnIyZzxbwe758KmEEnlF0cHRfEhD
         GnUNFqfsqoIkkYCOJ9X9fY+yXiZgwLWKJst1m3+6AQiUrR/Pj9roOGkX7EICgUBYIEcs
         njn1ndxiq6KC5aivsduO+XvfnrMkjN3XxJ7NFvNi3F1PLsKcpHMYl0rnLMH1eUtZorCJ
         vT4V84oQDiSrGnbYtGvi9V2lwVQEKCWgI9BpI6FsspMAg3Nt3YKUhycEx86EjKT478Dv
         RMiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783775644; x=1784380444; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3S3ssLpixBRf8e5hrXoPkuS8xI2TY8QEPNI7CT1Aa6w=;
        b=FfW4S54r45BbOvPwdGFkpeUqI2UOPC7sQGu9Y5zNM2RnFnKM2a/LQU83eglf1GoOXR
         3D+RAas8ZtslWyhE6wq0ovhcKQ/rM8zr016vfMcidsGNYm8J33vKhX1SovrnIZbZ1wzF
         ox3LBWXjt1oPZts/rwQ1RndGnggDcJURFI8O5TUfDTcwzPEw4Q46BgVTVWy+oYq5oxKU
         +YAXmGaUMsrcNbzGqqqe4Ppl0p+FQIszCgCFAVEFr7NYaVHqJlVY6xGCEvJbjlTHFhtA
         xVriDI9CdP3vvyaCb4zmLXqRfJWwMCcTviQxzwr9JiIKJm/H0GitevcijLD28yC1MilR
         DnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783775644; x=1784380444;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3S3ssLpixBRf8e5hrXoPkuS8xI2TY8QEPNI7CT1Aa6w=;
        b=avztKutIFEZZI4UKcaip77IbKNAswOKjoyo2k4svU3TI/IMxVv7N+FA98Hh2gGbgO0
         PchKbJLYufmVdHkVersl1mE4Q/ADKycv7rHnsmoBzzKy2mfk58utIxhSJBNXG9F9dgpL
         GrQ7rLnhDCe3UEjmCt5mhYB18B4qFC95QwdmIAv8MqgS8CFNwLP0xW54z7CyHS/oQFbs
         YcH76b3GpfdlF1G1124kgMAQ144jXRdf6kcGEYWr8e6lB64k3jEXy2THE0yb9PvJd5yv
         0kuNnX1yOwqUdgvxDVlguU+OVvJ2jhGk9LsuaBq8sxvYgWp3DIzNHujGImdk7jJeGUQD
         8D/w==
X-Forwarded-Encrypted: i=1; AHgh+RpXukqGpy1Aj/9Os2kRy4Iqjx4hUBY0PglBTdDVN2WdutDm+s1NJm56CzmDkfljEd6BH25VvFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY/9wS9XyVZgJ/kl60JAgOks2Jjx7/jWcgr5T68ehIwEkemQsJ
	ks3/iGX3GTc3j3RBWdOR+eB5PnQaCnRC4LAE4+sVTRi6Ep8UwsUTxcLSkfBESCJBeczR4RBJRDP
	rR3DAtI8jNvCGDCno95by6kc/RuUBEF3DjCHWzlC2
X-Gm-Gg: AfdE7cnJVReDT+0prvyEiGiEgzwX+wXrGbw6moD4GIBSWSjDtTEFiULjTgMWH80bfrn
	1Ky8dyGkzHHVnnUDM4PkPtHR2FmTstuq9l3l0DKwffz0rcUW0ficg4GPQh/+MlQgf5IKvuuXtma
	i83o07olMeOEP3XY+x1fe94uLzzSrmrD8bg6ANrHgxocxlmHeKTstALJKHzJxUqWRhpM0xwW7HT
	aoTE6QcsdViAo3CjuOBBuGDjvBklMUbCQaoXdHZiFrhZEGlh39ThFHzoiSkO6ZdUcF9YDTneJ8h
	Cp6PAoqNadltwG9Y1CwOHafL6BFkvqs5q6qBYlixtZYWX/6SfCoIyE2bwx3inGMd4KUr+d1jx1D
	7IwpBWTtmgmPjvWlW8sG5IUqonb0l4VqZe1zZ6vVSoA==
X-Received: by 2002:a05:6a20:b7a7:b0:3bf:c07b:a9ab with SMTP id
 adf61e73a8af0-3c110ad48bcmr3054980637.55.1783775643209; Sat, 11 Jul 2026
 06:14:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711005955.1467140-1-xmei5@asu.edu>
In-Reply-To: <20260711005955.1467140-1-xmei5@asu.edu>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 11 Jul 2026 06:13:51 -0700
X-Gm-Features: AVVi8CdeAKL6nCgvKxspy3ITy37aI9JNfjrAy4WUNuQ17iUdDnSVWc9ejLCXN1k
Message-ID: <CAAVpQUDSMwvOTdWROznQfst-4bqv8krbrhGQTteAkgoqHLqL+g@mail.gmail.com>
Subject: Re: [PATCH net] net: sock: prevent integer overflow in sock_reserve_memory()
To: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Wei Wang <weiwan@google.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com, 
	kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:edumazet@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:weiwan@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-306852-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD747741A37

On Fri, Jul 10, 2026 at 6:00=E2=80=AFPM Xiang Mei (Microsoft) <xmei5@asu.ed=
u> wrote:
>
> sock_reserve_memory() adds 'pages << PAGE_SHIFT' (a plain int) to the int
> sk->sk_forward_alloc. An unprivileged SO_RESERVE_MEM caller can drive the
> accumulating counter past INT_MAX and wrap it negative, either in one
> INT_MAX request (0x80000000) or across several smaller ones.
> The corrupted sk_forward_alloc then trips WARN_ON_ONCE() in
> inet_sock_destruct() on close (a panic under panic_on_warn/oops=3Dpanic).
>
> Bound the field that overflows: compute the new sk_forward_alloc in u64 a=
nd
> reject with -EINVAL anything exceeding INT_MAX.
>
>   Kernel panic - not syncing: kernel: panic_on_warn set ...
>    __warn (kernel/panic.c:1054)
>    ...
>   RIP: 0010:inet_sock_destruct (net/ipv4/af_inet.c:161)
>    __sk_destruct (net/core/sock.c:2357)
>    inet_release (net/ipv4/af_inet.c:442)
>    sock_close (net/socket.c:1501)
>    __fput (fs/file_table.c:512)
>    __x64_sys_close (fs/open.c:1511)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:94)
>
> Fixes: 2bb2f5fb21b0 ("net: add new socket option SO_RESERVE_MEM")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

