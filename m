Return-Path: <netdev+bounces-168868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6A2A41213
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 23:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EDD11885149
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 22:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4580A15667B;
	Sun, 23 Feb 2025 22:54:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8421035966
	for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 22:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740351276; cv=none; b=SuDg5KVch123AkOde26lCNytp5fYBMqA9C67mqISkvt6ADmFF5sLtq5PJh7YDo81iL6Df2vgv9iPje/pL9p6ITBsW7qlE9cnBJxADH4hYRV/OIvxx6MO5jIq3FXrtvsCXMnMj2Zp2U7qErFy6jaly3NfHGlJYpsYFJYv9MSxmns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740351276; c=relaxed/simple;
	bh=A9tRPwRJg47rbVzydlVKJQe8RfHlCrveWqmVxO+4Agk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I8GNjoUrmEuMErFYc1le1RNGxnZuutNaQThGZAw7oe569WkV0BcHIG+jR3SgdDlQpf5BZ4HC1V8M7RakUvC3SJDV23Xv8hwQsMWMWGkNgdFhCPJ/NhW9rpDVxdsz/HUBuYdwaFP84keZBm8ulAFag/F0SqXRe3MSoHsHG/ZlieM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=fail smtp.mailfrom=iki.fi; arc=none smtp.client-ip=185.67.36.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iki.fi
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id CCE4C240104
	for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 23:52:56 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Z1Jzk60Wtz9rxD;
	Sun, 23 Feb 2025 23:52:50 +0100 (CET)
Message-ID: <3059054fea81ac877d36becf46f248a0aae6f4a1.camel@iki.fi>
Subject: Re: [PATCH v4 1/5] net-timestamp: COMPLETION timestamp on packet tx
 completion
From: Pauli Virtanen <pav@iki.fi>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Xing
	 <kerneljasonxing@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Luiz Augusto von Dentz
	 <luiz.dentz@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, gerhard@engleder-embedded.com
Date: Sun, 23 Feb 2025 22:52:48 +0000
In-Reply-To: <67b7b88c60ea0_292289294bb@willemb.c.googlers.com.notmuch>
References: <cover.1739988644.git.pav@iki.fi>
	 <b278a4f39101282e2d920fed482b914d23ffaac3.1739988644.git.pav@iki.fi>
	 <CAL+tcoBxtxCT1R8pPFF2NvDv=1PKris1Gzg-acfKHN9qHr7RFA@mail.gmail.com>
	 <67b694f08332c_20efb029434@willemb.c.googlers.com.notmuch>
	 <CAL+tcoDJAYDce6Ud49q1+srq-wJ=04JxMm1w-Yzcdd1FGE3U7g@mail.gmail.com>
	 <67b74c47c14c7_261ab62943@willemb.c.googlers.com.notmuch>
	 <67b7b88c60ea0_292289294bb@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

to, 2025-02-20 kello 18:19 -0500, Willem de Bruijn kirjoitti:
> Willem de Bruijn wrote:
[clip]
> >=20
> > Reclaiming space is really up to whoever needs it.
> >=20
> > I'll take a quick look, just to see if there is an obvious path and
> > we can postpone this whole conversation to next time we need a bit.
>=20
> SKBTX_HW_TSTAMP_USE_CYCLES is only true if SOF_TIMESTAMPING_BIND_PHC.
> It cannot be set per cmsg (is not in SOF_TIMESTAMPING_TX_RECORD_MASK),
> so no need to record it per skb.
>=20
> It only has two drivers using it, which can easily be updated:
>=20
> 	-                if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_USE_CYC=
LES)
> 	+                if (skb->sk &&
> 	+                    READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_BIND_P=
HC)
> 					tx_flags |=3D IGC_TX_FLAGS_TSTAMP_TIMER_1;
>=20
> They later call skb_tstamp_tx, which does nothing if !skb->sk.
> Only cost is a higher cost of accessing the sk cacheline.
>=20
> SKBTX_WIFI_STATUS essentially follows the same argument. It can only
> be set in the sockopt. It has a handful more callsites that would need
> to be updated. sock_flag(sk, SOCK_WIFI_STATUS) will be tested without
> the socket lock held. But this is already the case in the UDP lockless
> fast path through ip_make_skb.
>=20
> SKBTX_HW_TSTAMP_NETDEV is only used on Rx. Could shadow another bit
> that is used only on Tx.
>=20
> SKBTX_IN_PROGRESS is only used by the driver to suppress the software
> tx timestamp from skb_tx_timestamp if a later hardware timestamp will
> be generated. Predates SOF_TIMESTAMPING_OPT_TX_SWHW.
>=20
> In short plenty of bits we can reclaim if we try.
>=20
> SKBTX_BPF was just merged, so we will have to reclaim one. The first
> one seems most straightforward.

Ok, I'll go back to tx_flags bit for v5 (=3D v3 + the minor cleanups),
going on top of "net: skb: free up one bit in tx_flags" then.

--=20
Pauli Virtanen

