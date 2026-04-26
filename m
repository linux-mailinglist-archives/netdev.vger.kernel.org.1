Return-Path: <netdev+bounces-281164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA/yJ1Qj7mnYqwAAu9opvQ
	(envelope-from <netdev+bounces-281164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 16:38:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A770246A5B9
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 16:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A56530055F5
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 14:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181F1366814;
	Sun, 26 Apr 2026 14:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blWwUekv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E7A36606E
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214262; cv=pass; b=mg4PS1Y/c/hRLrOFtpUPCQha620ltit7EnGE8lvJFRdX1e1IiAShChlKU80do/LinzzmYwAnH7+HAVcBVrOgLXU878uG5SZmNRQGBuypAOeyMggE5vBk8540mwnngIBBHAsbE7IOt7J+t1P5qaTsg7B1d3xN4IKadIIkX0hYErw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214262; c=relaxed/simple;
	bh=xGs9HlAaWh9UwzzisAubXHC6+wSGCrbckBpvHnDMQBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1KxWkkApvjz194vb/Mo3sMcDPdBUn/xOaG49sSj3PddywWX0ZS0DuxlEDtjHm43+zRmq64Nh8HT/YBLnN0gVavw2GhUqpKEnMfXh4NwCP/XSE6b5hbZVNgt/06SzfeCP4GOWMzA8MVPUX3u89JMf2+ZI9ppvLNmvM9bfh0YIX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blWwUekv; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82f8b60e485so3893980b3a.0
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 07:37:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777214260; cv=none;
        d=google.com; s=arc-20240605;
        b=G9IIjKYNCOPgMeaLSufneKyZH3ocNdrLmoIrtPDwC0nt+tZyzqm91GHAnDJvy7GmPi
         DVFyO52peOSBeGttkAfUjtnRj38d1uLNduPeG94+ovtBPbA/XLwxbIbmz3g6vqLTNXVq
         TRiU4hWWNRMNU5jWJ0afUAWveFM+7DF1QpXv078WVIljY6O4jMhhDxRutom5TUFktc9K
         zEK+INQUPdwE7G7+CwbYLRTiuGfWkrBtLP1wR0CBUtEsurh9UYoYODLgUPMBqKLBR8Kh
         bw7kR/TZpiWmLN7s5dHJH2OP5K1uN1IPk0OwOPxNY2zAobQkXdUkcbDQG7vdI7c0MC9y
         9ZDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VjV9i0zLE+j6+k558H0n59YbfuN4/v5ohF11Cgr5kd8=;
        fh=Kk3EXimx/NG4LM1rloSW8uclygoFgoufzUaWGBH/MkI=;
        b=aSqi1lOg8Dl4cjUMh7lKglUkWFDfFNwePz5EWvhzQ1c0asLteSksCKyJy2B7kacOas
         4TR92xBP6NVpkVbhh+Hr2JDAVccdP7uzk3gkabA5GfkLuCbO0E+dzPD2xqE0kbpOZZr0
         6NWfpCKwXsPPPO5tTDXMEdPbiPZCAFEdYnY5B49J7g5mB55snzczOetEY/NfsIrE6JDW
         +ASvZ1FeiPprdjpLNe/Jq3nLA5LeqTZmmdH8ynlG25klD0ghAT9c0mKPFAchmPc0lYqv
         uIzhhbDtSp3L+xhJr0HAXDJYkrD4D0oxg+7Rl7mgD2dsmnaL9xgZQNGeI/tQiQB0R/pT
         jRzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777214260; x=1777819060; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VjV9i0zLE+j6+k558H0n59YbfuN4/v5ohF11Cgr5kd8=;
        b=blWwUekvEzmaUp3k30WGpYZ0reVhPhRemF9Z25qnlTtDnm6Saa+B8cYdzgULLRRhHi
         OZrqoV6Nyxo/Y4HEz2Facp6lRIk26jJQsgPX476rFgdv7FEf6UF9aDq3KI84GIEHCcAo
         Buch9zWf+BNlAg9DWemG0kxctSROCg5R/tACCDmszbYD+E6ENvjQ+Ae2DyzjDoe7lo0V
         S/k2klREGDq77fvqdPO6iaEcVOuQ9ObZya7Nbo3k24hsiirubvK2elzQ183ymwElvJ0U
         qBooSBo1zlNimNyLXEgarIQN1wdsS2fu7qHQG9eDfatNj0elEoVzHcvIEPPWuX1CKPZ1
         rnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777214260; x=1777819060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjV9i0zLE+j6+k558H0n59YbfuN4/v5ohF11Cgr5kd8=;
        b=HuOx/50M+8kJ30ZuaUp4xwsFAXEksfwecODYHbklVhScec59t06Og2B+/9N7IHg4ih
         xaD2GG06qBC1WpAwGrTZL8OcIn4ss2ZWFKy2a4F5NLxrmWenp1yY2w9RcrZYWPqINUHH
         SLRNt1SQmsmQbwEqT0nGqJoBFpUMHgzzL7Rrvqfie3Tm3H0zFA3FHzZXACCUAZieJ+Za
         9avkqsDEbXejWPHroiyWtv6nigsZsUuWazc36fX3ZdXNcVpBKwNkdPeLAC40I8RPSEcr
         +WEEkOAX3S2O8LnkEDYv38agL3D9DlNKtHHWBgr8pll7ugPW6ANfssh6XDOetaSqKTeb
         6yWQ==
X-Gm-Message-State: AOJu0YzPWGuT91Cja18icxPWLw8kc8y+NsdFJgiBaMMaVZZExRbQi5xl
	5hrhIGCf+ZDu5XIsX7g+Im/FeXhQzhHDoT0I1RRcmCNhDUcz/Bb9n4Bb4m2na0B0LHTBo3TIbU9
	JY8oGYmGX0Rq5IiTEkOslUuph9PKIJvWvnrnO
X-Gm-Gg: AeBDieu4cxWh0dSikFW4kG/HeHqKgbzbtxxTIU41T4ePhIggIB70ffupbNQjLd51H7b
	zLnqaivJS6E4uVkZIYOZ53t1kaJKu2CvGkPxQQb0nUpFLeQ2qNIGOX3LtfhRsVvNnkdsLsmsj0y
	/rlDBgerTLmNQARw9Mx5qFDaHHUSgqMiGcZC3erI6KdKntwPNf8REpGLbC98LOH8C+qzRq/IZWp
	17v6BmXXpU0pG99bJU3LyrPSl/1Z8haT9yGhAhtPeUMxZ5AzV67A12eQYq+GycAPhrJh+SH+tpc
	Z+zG4UXP/4m1NY9bh4nLrI8H33MfRXjglmvy5LGFxwxeTbu572gLegT/1+Y9YgxU98v+0EKIgi4
	pTxbtos3sBxpIrjuaq4Ymct7bBMvrDLb+dX9StljQaTU5kXXni2c=
X-Received: by 2002:a05:6a00:992:b0:823:9b7:9c0e with SMTP id
 d2e1a72fcca58-82f8c991215mr40886557b3a.34.1777214259616; Sun, 26 Apr 2026
 07:37:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1775847557.git.lucien.xin@gmail.com> <bea8a0dfcc56b9980cb914b54cffa9dd9948ba75.1775847557.git.lucien.xin@gmail.com>
In-Reply-To: <bea8a0dfcc56b9980cb914b54cffa9dd9948ba75.1775847557.git.lucien.xin@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Sun, 26 Apr 2026 10:37:27 -0400
X-Gm-Features: AVHnY4LLUhOITcQWAb8AID_ay9mkKJOFHS3deCCkTNwHYTo-DoTv-l-YqJ2yjo8
Message-ID: <CADvbK_ebPJqKJJNwPXoYj50QtjCSoeE59M6YWYkqk6qBj96vPw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] sctp: discard stale INIT after handshake completion
To: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Florian Westphal <fw@strlen.de>, Yi Chen <yiche@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A770246A5B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281164-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,strlen.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

> This is an AI-generated review of your patch from:
>
>   https://sashiko.dev/#/patchset/cover.1775847557.git.lucien.xin%40gmail.com
>
> > @@ -1556,6 +1556,12 @@ static enum sctp_disposition sctp_sf_do_unexpected_init(
> >   /* Tag the variable length parameters.  */
> >   chunk->param_hdr.v = skb_pull(chunk->skb, sizeof(struct sctp_inithdr));
> >
> > + if (asoc->state >= SCTP_STATE_ESTABLISHED) {
> > + /* Discard INIT matching peer vtag after handshake completion (stale INIT). */
> > + if (chunk->subh.init_hdr->init_tag == asoc->peer.i.init_tag)
> Does this code compare a network-byte-order value directly with a
> host-byte-order value?
> Looking at the structures, chunk->subh.init_hdr->init_tag is a __be32
> extracted directly from the packet, while asoc->peer.i.init_tag is a __u32.
> During handshake initialization, asoc->peer.i.init_tag is populated using
> ntohl().
> On little-endian architectures, will this comparison always fail and allow
> the stale INIT chunks to pass through instead of discarding them?

Will post v2 to fix this.

Thanks.

