Return-Path: <netdev+bounces-272500-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDZyIOZfxmm+JAUAu9opvQ
	(envelope-from <netdev+bounces-272500-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:45:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 479DC342CF5
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E398330ACCD9
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EB73B4EB5;
	Fri, 27 Mar 2026 10:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkUG3L0s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6011B3B4E9A
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774607969; cv=pass; b=dBFy8LjTmDMgdWGmyIvGmprU8zvSOejwq2mO1l2Rj/mbi5TJU6QYEuaziEwwNprNM/p3R3LxGkc4Q5KOZautcQXbEsFuCPwzfrQzN/tv7FEFp6WJP0PZhV6QTc49DewLm9pMgD0WY/kIuWQHHf/9Q7Z6hIXuyC3xGF37YXOqaCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774607969; c=relaxed/simple;
	bh=N8fq7UtLOxR4Iv+iBktgqxIt69VvXXVbPrs3reH1t6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sVJcwptj/lGr+KqLmTQEnLRFi7sn/x6weASF5oyG6292m2QfsLiu3ZEMdoWht7kV0Ik3JSL7ZNovdlwFLW7EfWQGRGSCxa8K7cR+8ao9RL2B/Doo4h+ln9n6yxiOt5zvue9Q9XOy10QRJ6T17JvfAVLluQg1Hgodd7E+7LDted8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkUG3L0s; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6500040f128so154995d50.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 03:39:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774607967; cv=none;
        d=google.com; s=arc-20240605;
        b=NCCJ+1QIFL0MUBZXs7mqa5V1+N2FQDycRUGHDBNGayK9vSKFlFb81qH0i34bYzzz9I
         DllMlVpe95YdeYPVe3vf/UalUHIGf0WedXK2nphEgPNMf/4YEFlCczefJGt4hPcBU2D0
         FnrGPUBHGdbNcC4oSXbQpHubXKtR96nZ1VQBEEdquahwtsfbVU3F0HbpNfGOT49DbxsL
         zj5sCiAO4xcxSSkqFfIyhs+EG0QTuWgiU2Z5qDYUqrcJMLBReucSGB38R3Rl2n6kqdWM
         nyvhnt0ZufxJIek8Bm93E5zJNE1Bf1oTTfZ579SP1PO058zFwtZeYK9XgHYvdkTAg2sk
         j1eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=J3EDHpPb5AhiaBsdFZsph770IiBUnt3skegE31v5MuI=;
        fh=Bq6fgS7s0Q38dcc+gqeO2s2+Z3aw17K05ERkcVv2ZS8=;
        b=KhWHcnLVkSTHcCZT5U2k1lCtMsj+UV4Elbnr5Fib8bH4oaHT0n1uAQH/qAtjjqwD9b
         X+NPb9MndrUHO7xAYL9fTaNYf/N2d9t3IoADUK0qyHCKkWrEG/q+yvzDkKPVJtaWZ9Ae
         jl+RPZj49bPbup1gP6wNAhuOYZVgudPiI802EoQtVMe6XzIGlp89VyqCT36+j/nFyi/5
         iT3q1Vflj4YO8rUdB9pZR8nayWlj+4tvkDlKRPQimqvv8AAtInHN7QVFiPZ9DYEkPmcQ
         pnXbu/mERAjA/xnLo8KwqJe/fSdOByi63Peijzq3hsakyJvjjSKTPLVdojJsLeQLuq2G
         Wd0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774607967; x=1775212767; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J3EDHpPb5AhiaBsdFZsph770IiBUnt3skegE31v5MuI=;
        b=gkUG3L0sFpuPUFbsvC0dQduTPgXtbVoQggYZ7mSM6oX8y/AI39c/Z0Wu/Xs7XhbC7X
         b5i6OoxR+yhzUtRw1q9lSog5o8L/n9YNHHag7Eun7Qm1zNREchFjzhc0M/Y4Wtixkjqt
         M5M1GkOVZFEBsJyXwASMjqFu3UFXnphWxNuaObVdtgVVoAM29yf6Ru9E3a8fXd1GPiG6
         pi5lshG7+DoIt52x80cYNMPXOpKRmaIs8QKntotlu13FwjD73mYJ2Q4QFt7Jn/NykIHN
         Z1fhk/Rg8bVo+6W+EBNSfrrsOEuXFi5rE4Xl2RHjHy2c4VM0A2Nqb8s9eJmBJlpgmQ1M
         yHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774607967; x=1775212767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3EDHpPb5AhiaBsdFZsph770IiBUnt3skegE31v5MuI=;
        b=aAGuqDNOlByyECLBzWmGhCQ1ccbq1ifO2X1ac65HPj7NeWJysQSsSpWo/XNIVYxq81
         IfGmIc+1ggmTbaCJRiiDVuiotqZMKpFxreDT9WopuhWFmtpMfnyj4LGTHn4Kom33jjA7
         Mk28WcSyiWb5+EdauLry8VzSZJPDhx70l+C0/U8HNYu6IOiHEWk7PsCr8Lf4j4By/ccN
         nYg//+zDLXOtnJBoToDcUNT7rqlJHbtTqxMAP4pCuikWj/EM4BxcDp/EWIH5gGFUgb5J
         Jg0yPr14RGEWUg7ysNvoJ/PBplqaqts16jM7rTw9hZbzvGIW52w4oC+IDVmrfqrnQOTz
         Q7Gw==
X-Forwarded-Encrypted: i=1; AJvYcCXFeF5mXHZSJUUCpgR6XM7clgD9CECWq5TIZ7dGop1mC4Y212j3dWgKAfojk51uFtqBInaMiw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhtBw9jJSoeVDskX00MRlo8B2qFbEFAALnX0ttcNhvDfNRwXqm
	ZrEAhTkLz0GmD1Hv24Llosgb2fs1E+W2gfyKO7H2rG8TK4Q/RLRIO6QHaT4F2MMfEejk4JnOgPS
	wGMJHUgRmWv7yX4Pv+rS+phs2shA0XjM=
X-Gm-Gg: ATEYQzyEQAVr7myRR7xI9vehWECG2qbEbtjqZS3gUXjN01NzM0MxCDPa9AtO+Oop8px
	Wp+Fzp1m6Kr/CoH3QrJtvVLT16gaKOAqjkhr07Bgrj7ltbOoXBlPX/15j7HGeCkpS62l76fgUb9
	RPQWoDjU0W/7uKSbIOVQIZVWXxoqhZT5c0Wo9QSCl4jC8ylWggUXv/V2N3SJoKzlWOfB0xxTI/g
	CgfOyejKs8qIddWRBveYzGSCHLlpAUkxApYSYDaf/HBxrgej9+tGumdpBAcQQF58HATqSmGlW6g
	KnF8WpVjfXRfgSOuOGvXsi0v4883zVuftHosQnn/boIm17kw
X-Received: by 2002:a05:690c:4c09:b0:79a:b46c:e608 with SMTP id
 00721157ae682-79bddd5dedcmr18719737b3.10.1774607967433; Fri, 27 Mar 2026
 03:39:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325125131.53399-1-devnexen@gmail.com> <20260327102924.GF111839@horms.kernel.org>
In-Reply-To: <20260327102924.GF111839@horms.kernel.org>
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 27 Mar 2026 10:39:15 +0000
X-Gm-Features: AQROBzBJJOv5FvWWrA-8SBYmzTxhOKlhxOqal3cqYu71wFo9yUVcl9nKQidk5fw
Message-ID: <CA+XhMqzcdZcztwuar_j2Cv=3rogmaE=Xmn3Y1_avxYm6eGnsyQ@mail.gmail.com>
Subject: Re: [PATCH] net: ti: icssg-prueth: fix missing data copy and wrong
 recycle in ZC RX dispatch
To: Simon Horman <horms@kernel.org>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	m-malladi@ti.com, jacob.e.keller@intel.com, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272500-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 479DC342CF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Simon and thanks for the feedback, will keep this in mind. Cheers !

On Fri, 27 Mar 2026 at 10:29, Simon Horman <horms@kernel.org> wrote:
>
> + Meghana Malladi
>
> On Wed, Mar 25, 2026 at 12:51:30PM +0000, David Carlier wrote:
> > emac_dispatch_skb_zc() allocates a new skb via napi_alloc_skb() but
> > never copies the packet data from the XDP buffer into it. The skb is
> > passed up the stack containing uninitialized heap memory instead of
> > the actual received packet, leaking kernel heap contents to userspace.
> >
> > Copy the received packet data from the XDP buffer into the skb using
> > skb_copy_to_linear_data().
> >
> > Additionally, remove the skb_mark_for_recycle() call since the skb is
> > backed by the NAPI page frag allocator, not page_pool. Marking a
> > non-page_pool skb for recycle causes the free path to return pages to
> > a page_pool that does not own them, corrupting page_pool state.
> >
> > The non-ZC path (emac_rx_packet) does not have these issues because it
> > uses napi_build_skb() to wrap the existing page_pool page directly,
> > requiring no copy, and correctly marks for recycle since the page comes
> > from page_pool_dev_alloc_pages().
> >
> > Fixes: 7a64bb388df3 ("net: ti: icssg-prueth: Add AF_XDP zero copy for RX")
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> >  drivers/net/ethernet/ti/icssg/icssg_common.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Hi David,
>
> Thanks for the update.
> My understanding is that this addresses the review of v1.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>
> v1: https://lore.kernel.org/all/20260324211402.342474-1-devnexen@gmail.com/
>
> Some points to keep in mind for the future:
>
> * Please include a version number in the subject when posting versions >
>   This helps a lot in tracking things.
>
>   Subject: [PATCH v2] ...
>
> * Please include the target tree. As a fix for code, which I asusme
>   is present in net, in this case that would be the net tree.
>
>   Subject: [PATCH net v2] ...
>
>   Otherwise it would probably be the net-next tree.
>
> * Please CC all relevant parties. In this case that would
>   include Meghana as he provided review of v1.
>
> * Please consider including a changelog, along with links to earlier
>   versions below the scissors ("---")
>
> * b4 can help with most of these things
>
> * More information on the Netdev development process can be found at
>   https://docs.kernel.org/process/maintainer-netdev.html
>
> ...

