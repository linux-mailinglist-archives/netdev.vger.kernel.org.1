Return-Path: <netdev+bounces-270214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOwcEH6kvmnqVQMAu9opvQ
	(envelope-from <netdev+bounces-270214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 15:00:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC77A2E5AB1
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 15:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50E7E302A7F6
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 14:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C8F38C415;
	Sat, 21 Mar 2026 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RY4M8rRV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58D838C2B6
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774101610; cv=pass; b=BpAO1DLHvEkrQjBMEjIADS9ogFT0qKFhO9dOqenxdyunbzRLxm3OG86loaLqU0w7RPsBqY3HTfFOnMz6mHagq3Asq1R+csdpqOFwlw3Wz3wh1n1A5jRJMVEk8hMG/LSHUbBynLvSRK0yX3moZnyyrWk5H1lGSz6B/H5c2oF4II4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774101610; c=relaxed/simple;
	bh=ftdk7cRzE9UPHozGlIfScnoMusCKbDW8dF8r2bFK5T8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VkREOmRuf6YCJGklLTLMD62jhUZCkeNJcNRihGtk8qtQDRdmMhyCnwkan4y6mJ2q3LNGIfVJbXt+m9EUhRJ+2uxcx5BKQYTdRr2MVgtxpAX7/0ajnNRGDNa2pp2sCZhx7slpAfKM2P1bMPJKtdkD88DXZKJzopCd1i++NRlln/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RY4M8rRV; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12a71ade78cso2048125c88.0
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 07:00:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774101607; cv=none;
        d=google.com; s=arc-20240605;
        b=GUsB7ST9yal1IwRe88pg37DenQVw76d84vmlDwp0+1jk2oil2J5FiHPkcYC51KrW4i
         9BgOZQ2UxSly0tRLWQgELvvz1qCLk3At4kTXbUCD5cZZHjqaWDpHs2Dq+BR3zPMVgTiU
         QuNTH+KUqTnvcZNIvlqeVSgfQUsT0fKJX5OeslxBmq+ZMpm9/hP6IexN3XdpXbZBfQOI
         MXjx9aRXRqgK/JiGEqTF+TXJcWLUinqs9YcYK88DFhGo6796Y+NCisnxBmR/bUwpDN0n
         Rh8sLYpcY4s3KoBIRfn/lwPhQ87UVC5cfrpQi67WgFv5nvLvnBpt8Brbe5fYOIKwb58n
         I8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nc4KSml3sSwzB5nKSieGomdB+QKrIY3DY4N571e3y/4=;
        fh=aCdahVAE0cdmQ//2Wa8JGuhwgKnEOl8WWiW2ESyDLdc=;
        b=OaBWu4tlJ604vBYOKFM2rGeT38hCI+hPraxX7RDa8Fxd1gZKDwgquW3JdGurrndrfC
         i837Ms+zHMls89ocm9EsF5NfKNHHYXMlkgidR2pQdsLA9KYBWhwUtuJIMGKBA6ORPt3C
         PfX7r1bdvxaD4TDyDBcWIQ6eV99VlkZhoR4mmO77i44x1W/19lHHl88YkN32Tq1AT/85
         MyjIw3mhxKwc37LFovuW9/B57ErY8QIPeOR/utLJtBEJDkL0VxSkFKQSqRGsyanqOMIi
         QuwrGf/tasrwWCSdOWv7v4zVzXF4D2bg7Labd7WAbL2yPZvJF2KAyTGxs6Lt3cRlTyf9
         T2AQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774101607; x=1774706407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nc4KSml3sSwzB5nKSieGomdB+QKrIY3DY4N571e3y/4=;
        b=RY4M8rRVqghqmu3GKI8PchF5EnX/MWzb/B3t+xSJEvPQyFikRMmKXxydtETiOHdoW6
         xmW7eSuP5Jmsnx97dJGwWZgFby3bCg7cijP18eMDQ0GaXoILYSmhq7hzwiddQU1ppK+2
         GJ5ZSrnKdjlAXsW/5kUQ6ep/vKKKYmVo0J7gMEkx85WiMA+HL5vRUgm+KoQFZrlDzblf
         9ukS29ZDEfBSBFxcbrOTm6AzLmhKnviYMhe07fyqYFipN3+Y5bM3H9FGtYBjiOLsG8+U
         li3EWJQmo6qFhwjFYwC5wHMS4ESJ2TOz0qn81XH+jdR2BtUBJqbzDFXUPWD5SZJ+crba
         I2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774101607; x=1774706407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nc4KSml3sSwzB5nKSieGomdB+QKrIY3DY4N571e3y/4=;
        b=cPpif6kvSY0j2ehC8XO36UgHHkplQg9UO1tOemdXdc5A3VAcbeJzID+Jr/X9QFtYQL
         LdDJwFRl0K1bFtY49IbNaPkEsELoVSNVraLu3TmTzNS7MPRSa34jvLFNw0qlu11BDuDh
         mS9ZwsRl+PY1Bo2GJNiYSv0B1HhhJflfRjc1RVQcM89y60eptTm3i11tRMA8TrMERqBf
         e59KSpH2aZFJeZi7QYBg3Yu0AZP9r/TfgrTA1KZLZvaI39Y/mmUJRhHqNcg6KQK9nxX7
         yNJ7koKcua7WeMEY6fF28juAR9P0Y3Hrqx4uOalIHfXfN24WC2YrYfvGLkdY3eWcimdg
         wTyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOXrU/NVJRA8YBZu7me5/CQCTD8lArtuDmbGdk+xBc08I6+ewru4EPGg+dVAwVq+X0x80JPvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDUYJ5A1nfJy/JE5EVgqmM0EhGDLyisM/ejRWcwZeqFAlZyzrs
	IzSyRps+j9/rBJbfla4Bc1RDPWrZuTqO9NjxSD5WZlgzpCUYp8mynfso+4rIw3l4vbWE0tec9d4
	wxEmDoI6bGkMRMo6d11ttXzOyCBRHe0grHn72QNg6
X-Gm-Gg: ATEYQzwSoc/8CLMoNZLYuMpPc/GCc0rHtLcueiFKV+PzBLXgHoHb7LbUW6a2qfMiwN4
	/B6SQxK/tdwZJuTrcQqKq9gM3H+5iq/eEESYwPC/MYF/+VekbizN0kLNRoFwphLrlQjF3DhSpQA
	bEwxGovI1yusjIGlwJb9qWy+L6lgiruM2drWgrTvLqhDe7hHMK19OtMVY9HtDbRdrs4tVj81b98
	X2T0irsQ7tAmYxAZmufqqEh26pQwqFnV62VNV8AHWzrWglhmhp6JxTP1FQuE2kSbo6UNtDTWwq2
	+i8h/NyoaEKr3Q+pyOLz8Ubmoi1GWBPxJlvlDx8=
X-Received: by 2002:a05:7022:628e:b0:128:d6c3:9b27 with SMTP id
 a92af1059eb24-12a726fac38mr2506169c88.37.1774101606192; Sat, 21 Mar 2026
 07:00:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321105951.8314-1-kexinsun@smail.nju.edu.cn>
In-Reply-To: <20260321105951.8314-1-kexinsun@smail.nju.edu.cn>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 21 Mar 2026 06:59:54 -0700
X-Gm-Features: AaiRm52Cq4t9-0gaYxjH2Bp7xyftDi1ateHCC5UUXor_Gd0bKw0O75RspdzpuTU
Message-ID: <CAAVpQUCFqsurJdr-Ze+sdkGUQ2Yy=_xLR93SKiAE4GcfWRnh2A@mail.gmail.com>
Subject: Re: [PATCH] tcp: update outdated comment for removed _decode_session6()
To: Kexin Sun <kexinsun@smail.nju.edu.cn>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, julia.lawall@inria.fr, 
	xutong.ma@inria.fr, yunbolyu@smu.edu.sg, ratnadiraw@smu.edu.sg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270214-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC77A2E5AB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 4:00=E2=80=AFAM Kexin Sun <kexinsun@smail.nju.edu.c=
n> wrote:
>
> The function _decode_session6() was moved to
> net/xfrm/xfrm_policy.c and renamed to decode_session6() by commit
> c53ac41e3720 ("xfrm: remove decode_session indirection from
> afinfo_policy"), and was later refactored to use flow dissector
> instead of accessing IP6CB() directly by commit 7a0207094f1b
> ("xfrm: policy: replace session decode with flow dissector").
>
> Replace the stale function reference with a general description of
> the ordering constraint.
>
> Assisted-by: unnamed:deepseek-v3.2 coccinelle
> Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
> ---
>  net/ipv6/tcp_ipv6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index d10487b4e5bf..84d95e76085a 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1690,7 +1690,7 @@ static void tcp_v6_fill_cb(struct sk_buff *skb, con=
st struct ipv6hdr *hdr,
>  {
>         /* This is tricky: we move IP6CB at its correct location into
>          * TCP_SKB_CB(). It must be done after xfrm6_policy_check(), beca=
use

Is the second sentence still true after the flow dissector
commit ?


> -        * _decode_session6() uses IP6CB().
> +        * the flow decoding during XFRM policy check uses IP6CB().
>          * barrier() makes sure compiler won't play aliasing games.
>          */
>         memmove(&TCP_SKB_CB(skb)->header.h6, IP6CB(skb),
> --
> 2.25.1
>

