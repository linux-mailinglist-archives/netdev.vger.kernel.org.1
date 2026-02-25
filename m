Return-Path: <netdev+bounces-260702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOYFGYJXnmkjUwQAu9opvQ
	(envelope-from <netdev+bounces-260702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:59:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFCC190555
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D61C130D275C
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24BF265CBE;
	Wed, 25 Feb 2026 01:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tIrcN2No"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B245F24677D
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 01:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983751; cv=pass; b=EPSgJvD0pLDBU7ddHA2JUYTxkJ+SH7Fq+DKw1U15OaJJ/Ex7ELvtBi4evp6vVCkUYSKVHC76Vexe5amAYueboXZ1BvaMLTqFFwStlPV/lMUtyjfEIpbW+1FP8txJaeEw+yWsiXusVIYBTCoHPfxgYSeMabaS4ydyHYu7uph0mag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983751; c=relaxed/simple;
	bh=OwCKz6DoNXd7WY88RtyvLc4norQmtNz/YpyIYcDLX7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJ4WYrxN7r9llLOpQMjI8Vk9UZR+JIO6c9jmG+WmTIsxZxtuc1PUtwupqQ2vy43BPWz7zVilPEMDuQKBcLOCQprPe1Ip023c2ox/GGL6sqs8ZeQKN4usYeaxVvgwcAXg1LLlJN4OeOCZftYoWYufJAZacET439FLG6b/CmGZRUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tIrcN2No; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506251815a3so59663351cf.0
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 17:42:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771983750; cv=none;
        d=google.com; s=arc-20240605;
        b=fknglScNSPi5XvhQzB0kvD5mNk10vvR9K2yIrZhjJz0X/PcyptmzzO7/Ri/ndHtkto
         +qzbIY3/bL5U94t5n7EzjepfmAXQ61oJ4MgCT7Uept6uyK8j1e3DUILY6hFM2dNBAbOg
         KX49is9RmV4wFsBie6URtJOeJbcQ+ZBS7JYdi9aP+43cDir97Opc9i6LdNa7Dthc4g79
         qdiHrGV9Otry7PHYzEbeV7lFXrNUGzfGQGaabOekMgzcwOZXnP6MhJNw0DBy6SQjpLqW
         sMGfvr7OrqqgWVDIVtq+GJROnCpiEr5lKY1i/ShHgMjuMPZS5XVrfgdZXgxpNXliuxVo
         QtAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EAIHxtxHesjnRTvP6ODrjoH4xwBhFzrGg24YTnZCNzk=;
        fh=8hb/iUWqt5Qzq+DkPrt+huRq5z5YGFtvajFp1vIjnjc=;
        b=MuGrkSPiapnR2qT7onYeRZJbxRWDOHTZgysm26TXW4/F4lOpIFXymfWBy11dJmJtdv
         BxelpcFV3vcGwccufkfJZpEoaApnxkb27N2vuiuIYhSXbJqmr8p8XphaOP92Vg0WH3Z2
         1jURRGDqmkinGHkZQ2HMvL9HOi/DrdPZcK2xOD6Seba8v/XGcSidBq2MNFRGeTlF7VRo
         4l7CJhXoAnp+PHCMvHz44kj8/LyKjFwevIjugZ001NSafuQ2R0vWSJbqYUQ0y6FcQZ83
         DQknb9M6Z6rpQMAxB94yXOSPK4c+wrzemoYdnN0QtmxlSsHaYKRc2ybTNGNfTavUAlFS
         4Ovw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771983750; x=1772588550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAIHxtxHesjnRTvP6ODrjoH4xwBhFzrGg24YTnZCNzk=;
        b=tIrcN2No8qioLBht9lq+4G1nuCsPwmpGob53zQa+YzpSuOpicXHAiwz/BMPJf3HH4f
         WrJhq8q2XsYUjZioW89PNHd08Z0hXHjP/wy5CXypwZMwt59w1oBzB6FtZnV5eqev/Bq1
         dd7Vjscn3cT/4mxDmM8SFBqizgihmjK6UyGu6fO/W2NZf3F31peKp4TFh3xIvfJ74NUr
         IrPSq3eUX+48jBBb9iVzA1SqRn+NRww9tQhaLH7HNCR8izQmUTJLs+S5Ca6sOHIv+Wpa
         tAGxeM836LhagKpl3mtVR7KbQSi33zUNPpmvEHfb75MprqRJ+eL+KndPCpfreshftnrI
         2n5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771983750; x=1772588550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EAIHxtxHesjnRTvP6ODrjoH4xwBhFzrGg24YTnZCNzk=;
        b=kGIzFUPDPmTOraibQ51johhbF/Zr3AS0dtVrwSHj8MFZBzju0xYRRQhTn6Mfnvz9Xw
         QE2bxgj8Pbv6hfj2u3/TCSMjzpQHaLWoz0XfcQiVxWvrDmHjtk8l75lr/DtruCjnHnS2
         mzROXVF6Wf19wx0yNDSVphAVy659uwv1xk5dOwQBtyWGy1puS8I0/scgS6Kza/wXyqmJ
         AL8DwY5cn1TfLY2WRCBRM3GuPP5WZCIYo4L24gNm5CFjSvbv2LOm3QuJSzNMX9KEw1nA
         GXgN3l6Ur81SBd8RdYOo6jDGTr8nnbHvS/suhBV8S4fCTypPNy6gAXnRSNc3S4C5CGbj
         QuDw==
X-Forwarded-Encrypted: i=1; AJvYcCWUSBNUWS8IV1DCEYZpIqe9+dro86M1Lsfd9w4QZSr4OyEtaDm1lnPZU1ALU7n0iwUZUrI+Eb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjpAfRknuN5iv2FANc1bkwwz8/n83rpbFqLw8c91PlcQVi63OH
	tWLP4RX01i/RuFXjVHS4HHlYTHRHHNnQl1G0JyzVlU0mcKA7uexjrDKdhJCIRPd24l5x0YCeGa9
	+i0cZhqjPAWE7sFJNBglQik3R/angu4fJ2TBnjEww
X-Gm-Gg: ATEYQzwEV8ztubyWmvlzNKm4bXsg+kZzrQL5gkaY+BUWAnTrP0Nr1VAJJ5iji9dkonS
	o/PmyIPgXtQDMV7TFPnQh9MfK/amocz+ouUTqkSNHz//yROgsGigA5/ncLQWUf60RxD3Gmb3he9
	1zqeI8OEedNi9XFf5ooskRfLm+zaDsdF8SMUes2FOo8XUzCWKh5XiIrZAI8TAVbtj30Omg7HBMY
	5lb2ipQYFCJNokJ+/OJIYOa1ublsDpinxQ7QxvDWPXdv5+OFFeUhM3hg0IMh+u5beAKH1s0Xb/d
	lN6vUw==
X-Received: by 2002:ac8:5d94:0:b0:506:be2c:a963 with SMTP id
 d75a77b69052e-5070bba1e9dmr198206191cf.5.1771983749151; Tue, 24 Feb 2026
 17:42:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223230749.2376145-1-kuniyu@google.com>
In-Reply-To: <20260223230749.2376145-1-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 25 Feb 2026 02:42:18 +0100
X-Gm-Features: AaiRm52vDF57heYr8hpSBkOsLG-qCG4yAX-OV1At8yiGf0TV2Avs5kv6bwSbEck
Message-ID: <CANn89iJOAzHKNcO-0JjhUTVNgFn_TuajTbecf5X-XHZyGG7a+Q@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] bonding: Optimise is_netpoll_tx_blocked().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[jvosburgh.net,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-260702-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: AAFCC190555
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 12:07=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> bond_start_xmit() spends some cycles in is_netpoll_tx_blocked():
>
>   if (unlikely(is_netpoll_tx_blocked(dev)))
>       return NETDEV_TX_BUSY;
>
> because of the "pushf;pop reg" sequence (aka irqs_disabled()).
>
> Let's swap the conditions in is_netpoll_tx_blocked() and
> convert netpoll_block_tx to a static key.
>

> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!

