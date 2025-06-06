Return-Path: <netdev+bounces-195414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24270AD0115
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 13:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DACB016D441
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 11:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49703286405;
	Fri,  6 Jun 2025 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stwcx.xyz header.i=@stwcx.xyz header.b="MUt5qEbb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Py0JWDlp"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AD6748D;
	Fri,  6 Jun 2025 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749208297; cv=none; b=h1ez5b/Mlz7Kqhx9kmL/LOEkBQGK4KXjDUJDcYEGAeMZpC8QQEtBqEM6Ur1bVWk5VF0cX4lLukzAC4pNEWsozD/E0bTMMx8JBDC7Xg/p7E4tlfnekeLSevHLX5XxzObYANUHGfEdjP6qmPSfym9Gs9vhqhlmS3fNzppnSRnqOa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749208297; c=relaxed/simple;
	bh=1vgCFAQkENB6Seo2nZE1CTgN18AgUmdUKx/43g0JYuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LY0KLEZVcQOO+zll6HbuTreNskUy/OFhWr5L5ro0r80E1lSTAk/TZU1yoC9GBAVGC+FkTgAihShBxk1AisXQbv1/D2jcD2PFhqlaeGjhyKr5uRRaNY1Qxx0njPrgMcfLupNMg5hXtIyfYDFP11QvdIrZ97DhFOVxxbaNjana7mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stwcx.xyz; spf=pass smtp.mailfrom=stwcx.xyz; dkim=pass (2048-bit key) header.d=stwcx.xyz header.i=@stwcx.xyz header.b=MUt5qEbb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Py0JWDlp; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stwcx.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stwcx.xyz
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2079B11400CE;
	Fri,  6 Jun 2025 07:11:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 06 Jun 2025 07:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1749208293; x=1749294693; bh=MqZdJuGN+ob7h1DLTZpfz
	ebCnXfIj5B9RhXeV6LE7bw=; b=MUt5qEbbe/D180ktxeYtbUO03mwcMMrHN1EHT
	7g6ONS2KHMn6dQqkLGfkoBp/Msg2wgSlCebO97W1pzyPJqAlIZOE4tUKjLxSQk1z
	/un0K/8ydsKmf50Lk2LtGcX3RvbMJ+rWUY0T9tCGCtX73fEy/Y/0i7pSnGEMEg/4
	dmWPvsCcUuWLVViaKtmh+Movv6Phn7HhNiDpHUBvemPYhfm6LuUygkMKdoyi6l0R
	FSblBtg3kQYshd4azAHN3MnYKQMDaT/qYIUqctooTDV3Qq6sAdkuD/SRiZAg+Aj7
	9Pul5hk30f26lrYoAL2pxANo3hzl+dVGCppGf6QDES2jFDEQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749208293; x=1749294693; bh=MqZdJuGN+ob7h1DLTZpfzebCnXfIj5B9RhX
	eV6LE7bw=; b=Py0JWDlpR8yV9FKy/0XlLbYj3BuKqRcGtuyVKHSKekDBEd4qacw
	VlV4OTDDg+TP7jyFUgVhmszcX0tU7+JTiz+AiCP2RJWiXGuFRMpugULmAdyYQQyj
	GQQy6hZWH3lQN9uXZQ6KCcPNMxSxp3jk9ZsOG9CtsuvQAYummOzNb2ZB2CD2Tyw7
	ZzMEiiZjz8wq3pVzpLp+ZgyGULC68FBWX+vPo3H700ZV2ylZ6gG/LnaSkTQ/2wc0
	fv0S1cDH04bOWXFI1m5L+02u+Bx/KHkXrOmG90RelPF8S6Gw7xzQkE5MMhB0VFj1
	kvd9bBdF30bhRT9cTqPFIgdIRrj8taQZ16A==
X-ME-Sender: <xms:48xCaJZI7lDSrzoIeSSTKyxB6BRFWze6fIEUuNm0Y1lFftqeq9Xrjg>
    <xme:48xCaAbI6dB5GvEaaT3Zr8N633n5WY1ndbRC0swQYfr2zwcF_HeGK9f4iuotmPuMa
    NdsUoAc4XO3mu8a6Wc>
X-ME-Received: <xmr:48xCaL_mJ47EASejCxDRyUXoK4mJc_ZfW8n_AWrEo38q_5BGPeFqgFuYX4c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdehtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffo
    ggfgsedtkeertdertddtnecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoe
    hprghtrhhitghksehsthiftgigrdighiiiqeenucggtffrrghtthgvrhhnpedttdevtdeg
    fefggeeuheekgfevkefgteehhedvtdekkeefiedutdfhtdffgffhhfenucffohhmrghinh
    epghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepphgrthhrihgtkhesshhtfigtgidrgiihiidpnhgspghrtghpthhtoh
    epuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjkhestghouggvtghonhhs
    thhruhgtthdrtghomhdrrghupdhrtghpthhtohepmhgrthhtsegtohguvggtohhnshhtrh
    hutghtrdgtohhmrdgruhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhn
    vghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvggu
    hhgrthdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehkuhhnihihuhesrghmrgiiohhnrdgtohhmpdhrtghpthhtohepphgrthhrihgt
    khesshhtfigtgidrgiihii
X-ME-Proxy: <xmx:5MxCaHpFRP8iUhvU2xgWyuFW81GqfSFh_dz5bdCN9_joM4MPmq66ZQ>
    <xmx:5MxCaEr1OBvIl7hl0FQC7EjPN8TLn-nTPTV8DTtw9r38XUplgVVo3w>
    <xmx:5MxCaNSIv5AAB6qZJy6P0YD60HKOf71rhq_WMOEGVbZRBy5a56eQEg>
    <xmx:5MxCaMpLiST6EXj65c8y3FIlhQp7j2_94itPrLDxdV8NXYVDDTHgJg>
    <xmx:5cxCaCDuV2ymvA9CSQr_icCx1UQ5nFOBANOxb_CqZfUAQ7vqATSNL2b9>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Jun 2025 07:11:31 -0400 (EDT)
From: Patrick Williams <patrick@stwcx.xyz>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Patrick Williams <patrick@stwcx.xyz>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: mctp: fix infinite data from mctp_dump_addrinfo
Date: Fri,  6 Jun 2025 07:11:16 -0400
Message-ID: <20250606111117.3892625-1-patrick@stwcx.xyz>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some mctp configurations result in the userspace application
`mctp addr show`, which triggers an `mctp_dump_addrinfo`, to
be given infinite data.  This was introduced by commit 2d20773aec14.

In `mctp_dump_addrinfo`, when the userspace buffer doesn't hold
enough space for all of the addresses, the function keeps the current
index in the netlink_callback so that it can resume on subsequent
calls.  There are two indexes held: interface and address.  When a
all the addresses for an interface has been sent, the code reset
the address to zero and relies on `for_each_netdev_dump` for
incrementing the index.  However, `for_each_netdev_dump` (which is
using `xa_for_each_start`) does not set the index for the last
entry[1].  This can lead to the subsequent userspace request re-sending
the entire last interface.

Fix this by explicitly setting the index to ULONG_MAX[2] when all of
the interfaces and addresses have been successfully sent.  This will
cause subsequent userspace request to be past the last interface in the
next `for_each_netdev_dump` call.

The previous failure could be aggravated by on a system using
aspeed-bmc-facebook-harma.dts by running:
```
    mctp addr add 8 dev mctpi2c1
    mctp addr show
```

[1]: https://github.com/torvalds/linux/blob/e271ed52b344ac02d4581286961d0c40acc54c03/lib/xarray.c#L2261
[2]: https://github.com/torvalds/linux/blob/e271ed52b344ac02d4581286961d0c40acc54c03/include/linux/xarray.h#L481

Fixes: 2d20773aec14 ("mctp: no longer rely on net->dev_index_head[]")
Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
---
 net/mctp/device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mctp/device.c b/net/mctp/device.c
index 4d404edd7446..a865445234af 100644
--- a/net/mctp/device.c
+++ b/net/mctp/device.c
@@ -140,9 +140,11 @@ static int mctp_dump_addrinfo(struct sk_buff *skb, struct netlink_callback *cb)
 		rc = mctp_dump_dev_addrinfo(mdev, skb, cb);
 		mctp_dev_put(mdev);
 		if (rc < 0)
-			break;
+			goto out;
 		mcb->a_idx = 0;
 	}
+	mcb->ifindex = ULONG_MAX;
+out:
 	rcu_read_unlock();
 
 	return skb->len;
-- 
2.49.0


