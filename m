Return-Path: <netdev+bounces-272110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP9UNsVMxWkU8wQAu9opvQ
	(envelope-from <netdev+bounces-272110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:12:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3B5337538
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 293F73019442
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12A2401A05;
	Thu, 26 Mar 2026 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jg1jV09J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D58D3FB7C2
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774537838; cv=pass; b=RPWUssPulNnYCDKUdqXTaIz4Jn2QrEyAYRY0Td42Gfp3LF5cjUdy0OC0hjB9pzNSt4DkFJlQZQu1yhW50QtuU/CF9wu7sKfBF8JhwgbbET5R3/DpvtG3s9q/teg6FTmsujw1WkEyOXBauK9C9rW5dnKnP45hkko57oCsPoKIRrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774537838; c=relaxed/simple;
	bh=qKz7GeQxZ8sggDV0R8PRl9sGjFfikJ4/Tqa/hBGF7AQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JC0M7XFZjdLb6bRhPTvhPqsDaeIUz0YSC16YxmStWIUG52pUOesRf9PzmHwqPPZVR2PHC+rKkCVZRrWUO/a1r4cTp7SFlYqqWoiB83d9H8OQGE6jxT4La5a+16jHNUd2bUK2hexYg42eCkOuGNzkellzIQBkINzWvO+gxSOxlC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jg1jV09J; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-829ac4670c4so848904b3a.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 08:10:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774537836; cv=none;
        d=google.com; s=arc-20240605;
        b=WQhtm+SotitVrWtmxSVDpsJ9P6huFYXkinPbzkRAMpClWS9tuz87r9tINdozhVI0yC
         AzJCJLJBTEpZLyhW3U2hgMmVXFqsKF7Op4yFpThLsfB+i81b6AN4I9PxP5bc0xJSmZ28
         6imR+sjA8s2DBeiY5x3OFsTTwcEJW8DmFSmyAyjA7Uq88zXn5QyeOvP2v43fb9U/ufFO
         1NnMW6lGij8RD0qDAr4wqRpE9rWIMswhkF9Bo6S9t5HTclQEbxIO9kMvb44OcHa7uUr4
         c3xheew3dU+gVyB7f1GEiGvYkrDUFQP6tCVRWrqwJErXyJzDr+ioxGuAIOj61+SUrpkn
         dgag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mSefNftQWki8QitGf1y0R01W7kHkanHSPeWJVPTl48E=;
        fh=9Rdk8HXD3GS6RvUAdNv38kYiVbkJZfpNDtTDAy/OGVI=;
        b=FrZqXP5kqEuIRRXbXgWzhthRf48T93BO2Aabu1wMDpIMf3uWO0OPyWD6CmICpMzcet
         SYjVnT2ppIM0+solYAVaW5tO9FZO6/HkGI5Idut5ONnn3BtmVLIrw1YKWEkM0xqMvFUG
         C2raqWIjF4s7eK1uiMzwpiclDOWolHPpZfudM+oFksHFyr9mCgq+k4aiT98WGsMCquNg
         zMJfv+KoNm3Br8Kz4Y1L5N0n1pfOOftmFDu4PWCnAua8LX0cEO26KYV3QPhHuZaHpk1C
         Ea/qe7Udc2jBVnOyW1tXfox9WUip79hE7pz6bqx7n2gYx45vIGOy6DjZlQQkkRY1W5Sc
         Qv4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774537836; x=1775142636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSefNftQWki8QitGf1y0R01W7kHkanHSPeWJVPTl48E=;
        b=jg1jV09Jlyvu9VJnn0BkZbueVt/NGyBB2FghscoHIp9UF8ZyGTghcW+rdnPobuhmc/
         FuJOmhCkQcpHBFZnZWTrkQxfDPvFq2/LldKLRP9HsQy7tD0ax5c+bPwL0C1Kpz3Z33ZX
         UJlY1CoK7KgHaNuhqYMdjdVuXdDj2LqzxvBhHNDvVsUO7jD+lESTXVoIOVCUJDtmB1Nx
         spQbUGPxZKTIxF355hZ+KhihLf9boPKhj1mHoDYnWzrV6Rrrm38oyM/tWfKJRPA4600o
         owycm/4gvYNEOXyWUyUIoi5n0R7FPn6L385IbnBt4B8nYWFUSpJCAeUbapJxOPJ9QO2P
         qTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774537836; x=1775142636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mSefNftQWki8QitGf1y0R01W7kHkanHSPeWJVPTl48E=;
        b=M2dKPdyollUbilzXJJHapP1rhdR2O8qJbhpT6LNMjG36STly99PejOqik4PNdEO7WD
         tjp0Wn4YhpyxuiQjeM2S872DiTx5euaGJ+n34Qpk93qpEycORS8quvXas6tVmBSLF/6N
         0m7LL/UibFD/wN4mZzi6Qd6hYhbr6dNid5FY6BaeZYibK/q9oFwpKTL2+vVx1ufpC5Mc
         NdbkGigvYIG71MSD5OwZ3PODV/M+JrxHQQo3qyjkfafCqsnB3JkGntdfstT9kz9DdupP
         5gykp6ThgNswq4J+hlM7IBHzlOGbcDlOqwZElGQEd5Nbdo2uC8CWWZhNuwY2CT8R8tyc
         lzsw==
X-Gm-Message-State: AOJu0Yy5Qa3bT0sBeub97XjntHIOtJSF4l7pc1vvH7AiOVPM3vZoq4NN
	xNDfj4NaXebymDoYzDpH5yhWh+el8CN5x22Vw762xRnmSf57ycG3mPWbNZNEyuK2n0AFeYVu5ah
	Kj6EihQFM4j+SE5Vt3my9DDoHg+e6Lu/c0yAbx0plEA==
X-Gm-Gg: ATEYQzyluxUI3sA8iZKzOlBVcQeQDXIt+C03WowYkskpKCXfBNOgewl6zebQDct1osA
	pjazOUgJjkM4JsbD9E3MVaPiKMBohdm9HYk4HbzkbpY8kldMvnn8Liq5IkyBZEK1VA6os1ktNF1
	RjjN0jgwhzw8rSuobbLL5QhJClpxVgfSGRf//N+rZqhsf5DOdJkaY2UlJgKtIx22NTrjCLunTzI
	nSRC3FvrA/pGhwqFOk/MvZL0FgpdCtQ9c18Z035esnpSTHGlwdShFbNvy7ddm9Im0tw45+ToBnb
	pItn/IWu7gqjqSVTvlwYQbwfgfCODijPXFvqD4vxuoVrqvb1MVNp2QevTv/LoND/zcqSy27TPTV
	75AmEMcbRFbURo20WDJK1PO1zxWB6yf9bS6046UZw
X-Received: by 2002:a05:6a00:2da7:b0:824:374a:13f7 with SMTP id
 d2e1a72fcca58-82c6e15f706mr8408159b3a.55.1774537836342; Thu, 26 Mar 2026
 08:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1774410440.git.lucien.xin@gmail.com> <d86910330339da257534ad93db71949176961522.1774410440.git.lucien.xin@gmail.com>
In-Reply-To: <d86910330339da257534ad93db71949176961522.1774410440.git.lucien.xin@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 26 Mar 2026 11:10:25 -0400
X-Gm-Features: AQROBzCHlIqDJYnoa1tW3FE7PgOFSLHI1Wh5jc_7MECEmTiUBtm70S0dHNsViq8
Message-ID: <CADvbK_d+oVgMNWQ3fT_Rz9WGkU6i6m+Z=3J34_-QiCjEABoCpg@mail.gmail.com>
Subject: Re: [PATCH net-next v11 12/15] quic: add crypto packet encryption and decryption
To: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, Alexander Aring <aahringo@redhat.com>, 
	David Howells <dhowells@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, 
	John Ericson <mail@johnericson.me>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"D . Wythe" <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>, 
	illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Daniel Stenberg <daniel@haxx.se>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, 
	"Marc E . Fiuczynski" <marc@fiuczynski.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272110-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,samba.org,openbsd.org,xiaomi.com,simula.no,vger.kernel.org,gmail.com,manguebit.com,talpey.com,lists.linux.dev,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com,fiuczynski.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C3B5337538
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 11:49=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wr=
ote:
>
> This patch adds core support for packet-level encryption and decryption
> using AEAD, including both payload protection and QUIC header protection.
> It introduces helpers to encrypt packets before transmission and to
> remove header protection and decrypt payloads upon reception, in line
> with QUIC's cryptographic requirements.
>
> - quic_crypto_encrypt(): Perform header protection and payload
>   encryption (TX).
>
> - quic_crypto_decrypt(): Perform header protection removal and
>   payload decryption (RX).
>
> The patch also includes support for Retry token handling. It provides
> helpers to compute the Retry integrity tag, generate tokens for address
> validation, and verify tokens received from clients during the
> handshake phase.
>
> - quic_crypto_get_retry_tag(): Compute tag for Retry packets.
>
> - quic_crypto_generate_token(): Generate retry token.
>
> - quic_crypto_verify_token(): Verify retry token.
>
> These additions establish the cryptographic primitives necessary for
> secure QUIC packet exchange and address validation.
>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
> v3:
>   - quic_crypto_decrypt(): return -EKEYREVOKED to defer key updates to
>     the workqueue when the packet is not marked backlog, since
>     quic_crypto_key_update()/crypto_aead_setkey() must run in process
>     context.
>   - Only perform header decryption if !cb->number_len to avoid double
>     decryption when a key-update packet (with flipped key_phase)
>     re-enters quic_crypto_decrypt() from the workqueue.
> v4:
>   - skb_dst_force() is already called in in quic_udp_rcv() on recv path,
>     so remove its call from quic_crypto_payload_decrypt(), which may be
>     called without RCU protection.
>   - Remove the incorrect (void *) cast to quic_crypto_done.
> v5:
>   - Use skb_cb->crypto_ctx for async crypto context freeing, which is
>     safer than using skb_shinfo(skb)->destructor_arg.
>   - skb_cb->number_max is removed and number is reused as the largest
>     previously seen and update quic_crypto_get_header() accordingly.
>   - Change timestamp variables from u32 to u64 and use quic_ktime_get_us(=
)
>     for current timestamps, as jiffies_to_usecs() is not accurate enough.
> v6:
>   - Rename quic_crypto_get_header() to quic_crypto_get_number(), move
>     key_phase parsing out of it, check cb->length when parsing packet
>     number, and update all callers.
>   - Use hdr->pnl + 1 instead of (*p & QUIC_PN_LEN_BITS_MASK) + 1 to get
>     packet number length, and remove the unnecessary the len variable
>     and QUIC_PN_LEN_BITS_MASK macro from quic_crypto_header_decrypt().
> v8:
>   - Move skb_cow_data() from quic_crypto_payload_decrypt() to
>     quic_crypto_header_decrypt(), as header decryption also writes to
>     the skb and is invoked earlier than payload decryption on RX path.
> v10:
>   - Fix double period at end of the comment for quic_crypto_encrypt().
> v11:
>   - Note for AI review: call quic_crypto_aead_mem_alloc() after
>     skb_cow_data() as it uses the return value for nsg. If the allocation
>     fails, skb is dropped, so no rollback of prior skb modifications is
>     needed.
The AI report on

  https://netdev-ai.bots.linux.dev/ai-review.html?id=3D1624d906-c0b6-4e12-a=
63f-5cbfc51b660e#patch-11

is already explained by this "Note for AI review", not an issue.

