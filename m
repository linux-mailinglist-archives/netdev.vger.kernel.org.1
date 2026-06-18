Return-Path: <netdev+bounces-300523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qcO+FkZBNGpQTAYAu9opvQ
	(envelope-from <netdev+bounces-300523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 21:04:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD686A248A
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 21:04:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=MFKNZsJG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300523-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300523-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 091E7303F7E7
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 19:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7A333D4F2;
	Thu, 18 Jun 2026 19:00:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5C83382F3
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 19:00:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781809245; cv=none; b=i9NCpQ2ETSB4cO4vK0UlNPr7cy8dOcBZGExhRgOw8EpmxIAW3AIEuiqr3tt+LfKBlPa7H//4NM7s4jYiJQ4r1SrhQ/ou+biTsVkt29Y29zEn7cJ6VxOdUWK4C6NAle0UNyOn7R3IwU+3oi9Rap2Ik65Xp9lyWZH9QM0+Uo04G74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781809245; c=relaxed/simple;
	bh=8kJMz9LKQ/8hfHjif49visLmKVnF4eIjhO0ToUzckXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUfkHVNfAUqDTwSl9co8BdnFDybCZYDihZi6JJRVSqAHWFmboxe9CXfDCsMgKoqAEEbFrsQx1D/OKMXPaOG7tn3Ra9AMtRDHOlhJOz5S2yc3vkTVAfW1Lv4QTvLxJZdtSv2vPI77X3aEEn6R+VaX/+uBx50fDpn5OnYWOFyI5y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFKNZsJG; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37c8e7c8137so697719a91.1
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 12:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781809243; x=1782414043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KZJIVkKgNSYCGOK4bX9+88PTNdyEosGt30DWnvoVWjY=;
        b=MFKNZsJGybN51u5DlLE3vuL/c+ZASTuwQ8136Wh7+E648ocRlI9D91DTdsuiTrhVYr
         3FxYFqxZhNebkQggoHO6yNw7/2krANRroyNy1Z7peuTTVQYe7yeRDyucuxfRbzEaADMM
         qALQKFKCDK6T+uDuocjggyLSfjj94Etl14EvJJHX2LAs+jR8aCTE7oiyNmCCjKfONBfy
         sRzXc0aw8JIfWf8BgwJMbDiNHN+W9J8AL1tFC950NJ+FLgSPOlhsBXrPGtiHiNmgrbMF
         sMz8NKBEbnBdHW5+KF2DRp8pFgmemEcjRrNTCDWxVHyheBdY2lAWWIjV7QDlE/83Y+ke
         +XeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781809243; x=1782414043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZJIVkKgNSYCGOK4bX9+88PTNdyEosGt30DWnvoVWjY=;
        b=TYVV3yOX/sZB5qpPJzk3j7y7isE1OhLf42MMSGR7GH7UDG4rokZQIElZIVVJtf7pig
         dIWQlyMmi/BRJ3bRhuVDf1DsBku+p9epwphpeZi3SR2BwEbVShk07+FVj0QbB9Zm9oaw
         5Lm1MG96AC2qLgh6ADQsofDOGUAwzOT7ve9J3N4pfcqmtselZiQlVsTHc3wmY1sxIoPl
         jxIE+m3LunkT+TaaYSnRj/NsCPpfACl7HtIE0qLqEiAuqNnJ19LcUU0V21b/vfdjO6Za
         G1Tlng4MdK6ssB1fWhT/GpPdDbK9hBXIp69rI3/kzCdH2kfCdghB1JtM5Y+79HM34lAl
         uQZg==
X-Forwarded-Encrypted: i=1; AFNElJ9YXLgmwck9LhkWkJsNwzNBfE3cFvKrknHygbccHu7462I9f9KbFPbwrS1RI9yMnnfklqGZFgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpqcgJBegx7X/9aQPp0gwjAebXesaqor4KvkegcUCnTZpyqVEi
	b8Y5uaVi8hIG82aHgwEeo35dkxyi5d0V5HJ1BjXHTv4G4FbWz1fHelJQ
X-Gm-Gg: AfdE7cnC7Zc4m1IjM7ZSMisV4eFcaY+wHewb/sy38MQQgcZCcqVzJ3n3XZsuNvJbIHF
	WpFvYePfO8lc1Drvi535gnjx/syaQ7wUswv7Bz3IuDnxyV+6M4Z+NsNdfioK5xk4uMdeLoBG6Jy
	v4j9+35SDFwUCli0BAQjkhOQMs5ccxeLhvMmvvUbqY5E9IY7LKFetaD/nZu4cmBXgtgW2HrL/qy
	B+aYz4YRJXrEzcNVrDPPAQcitzKNKUIT+zbd6bG/6frCyXJ3+AKKl5xf7jk+U5fAnKmkZ3DcAaY
	OIfiOAcRSAzHXfJKUfXOasmx9OMZ0WhWUdCkI1OhRg+Cp8/AISztGlxm9UQ9h6dm7A8VUdGULh9
	Nmur73d8gwPSI3Dh16oQATEWvElgjPJokj9QY3ZUZP/0rW586bpV/sGdyX62oKEaXIOA7im3NSL
	3lhpSDQ4fmHg==
X-Received: by 2002:a17:90b:5103:b0:369:2e00:1ff0 with SMTP id 98e67ed59e1d1-37d15e170e3mr781639a91.6.1781809242899;
        Thu, 18 Jun 2026 12:00:42 -0700 (PDT)
Received: from john-p8 ([98.97.43.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d1aa48f04sm25097a91.2.2026.06.18.12.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 12:00:42 -0700 (PDT)
Date: Thu, 18 Jun 2026 12:00:40 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Liu Jian <liujian56@huawei.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Cong Wang <cwang@multikernel.io>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: fix BUG_ON in skb_to_sgvec() on a
 resized ingress skb
Message-ID: <ajQ9YXj216btyriM@john-p8>
References: <20260613082442.3252576-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260613082442.3252576-1-rhkrqnwk98@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:jakub@cloudflare.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:liujian56@huawei.com,m:daniel@iogearbox.net,m:cwang@multikernel.io,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-300523-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ACD686A248A

On Sat, Jun 13, 2026 at 08:24:31AM +0000, Sechang Lim wrote:
>sk_psock_skb_ingress_enqueue() maps a received message into a scatterlist
>with skb_to_sgvec(skb, sg, off, len). On the SK_SKB strparser path off and
>len come from the message's strp_msg (stm->offset and stm->full_len), set
>by the stream parser. strparser does not trim the skb, so normally
>skb->len - off >= full_len and len is within the skb.
>
>An SK_SKB verdict (or parser) program may call bpf_skb_change_tail() and
>shrink the skb after full_len was recorded. len then covers more bytes than
>the skb holds, __skb_to_sgvec() walks past the data and trips BUG_ON(len):

FWIW this only happens if the strparser program is also attached. If 
there is no strparser program stm->offset = 0 and stm->full_len will be 
whatever the verdict program set. So there we would get

   len = skb->len; // then if it shrinks to skb->len - X its ok.
   off = 0;


>
>  kernel BUG at net/core/skbuff.c:5286!
>  RIP: 0010:__skb_to_sgvec+0x78c/0x790
>  Call Trace:
>   <IRQ>
>   skb_to_sgvec+0x32/0x90
>   sk_psock_skb_ingress_enqueue+0x42/0x370
>   sk_psock_skb_ingress_self+0x1a8/0x200
>   sk_psock_verdict_apply+0x33c/0x360
>   sk_psock_strp_read+0x24a/0x370
>   __strp_recv+0x66d/0xda0
>   __tcp_read_sock+0x13d/0x590
>   tcp_bpf_strp_read_sock+0x195/0x320
>   strp_data_ready+0x267/0x340
>   sk_psock_strp_data_ready+0x1ce/0x350
>   tcp_data_queue+0x1364/0x2fd0
>   </IRQ>
>
>Clamp len to skb->len - off, and drop the message if off is already past
>the skb. sk_psock_skb_ingress_enqueue() is the only skb_to_sgvec() caller
>and both ingress paths (verdict SK_PASS and the backlog worker) reach it.
>The clamp is a no-op unless the skb was shrunk.
>
>Fixes: 7303524e04af ("skmsg: Lose offset info in sk_psock_skb_ingress")
>Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
>---
> net/core/skmsg.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/net/core/skmsg.c b/net/core/skmsg.c
>index e1850caf1a71..2961178ebd1e 100644
>--- a/net/core/skmsg.c
>+++ b/net/core/skmsg.c
>@@ -550,6 +550,10 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
> {
> 	int num_sge, copied;
>
>+	if (off >= skb->len)
>+		return -EINVAL;
>+	len = min_t(u32, len, skb->len - off);
>+

This is blocking the BUG but will break the socket. We should fix
at the cause. Something like this untested... although I've never
used the strparser program in any of our cases.

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 2521b643fa05..95347f9d140c 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -542,6 +542,20 @@ static struct sk_msg *sk_psock_create_ingress_msg(struct sock *sk,
         return alloc_sk_msg(GFP_KERNEL);
  }

+static bool sk_psock_skb_strp_range(struct sk_buff *skb, u32 *off, u32 *len)
+{
+       struct strp_msg *stm = strp_msg(skb);
+
+       *off = stm->offset;
+       if (unlikely(*off >= skb->len)) {
+               *len = 0;
+               return false;
+       }
+
+       *len = min_t(u32, stm->full_len, skb->len - *off);
+       return *len;
+}
+
  static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
                                         u32 off, u32 len,
                                         struct sk_psock *psock,
@@ -696,12 +710,8 @@ static void sk_psock_backlog(struct work_struct *work)
         while ((skb = skb_peek(&psock->ingress_skb))) {
                 len = skb->len;
                 off = 0;
-               if (skb_bpf_strparser(skb)) {
-                       struct strp_msg *stm = strp_msg(skb);
-
-                       off = stm->offset;
-                       len = stm->full_len;
-               }
+               if (skb_bpf_strparser(skb))
+                       sk_psock_skb_strp_range(skb, &off, &len);

                 /* Resume processing from previous partial state */
                 if (unlikely(state->len)) {
@@ -709,6 +719,9 @@ static void sk_psock_backlog(struct work_struct *work)
                         off = state->off;
                 }

+               if (unlikely(!len))
+                       goto out_free_skb;
+
                 ingress = skb_bpf_ingress(skb);
                 skb_bpf_redirect_clear(skb);
                 do {
@@ -737,7 +750,8 @@ static void sk_psock_backlog(struct work_struct *work)
                         len -= ret;
                 } while (len);

-               /* The entire skb sent, clear state */
+out_free_skb:
+               /* The skb has been handled, clear state. */
                 sk_psock_skb_state(psock, state, 0, 0);
                 skb = skb_dequeue(&psock->ingress_skb);
                 kfree_skb(skb);
@@ -1020,10 +1034,10 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
                         len = skb->len;
                         off = 0;
                         if (skb_bpf_strparser(skb)) {
-                               struct strp_msg *stm = strp_msg(skb);
-
-                               off = stm->offset;
-                               len = stm->full_len;
+                               if (unlikely(!sk_psock_skb_strp_range(skb, &off, &len))) {
+                                       err = 0;
+                                       goto out_free;
+                               }
                         }
                         err = sk_psock_skb_ingress_self(psock, skb, off, len, false);
		}

