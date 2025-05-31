Return-Path: <netdev+bounces-194477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCA8AC9A1D
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 10:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B865B9E5B43
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 08:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2D72376F5;
	Sat, 31 May 2025 08:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="i3bZKa+/"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742AE22D4EB;
	Sat, 31 May 2025 08:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748680883; cv=none; b=LYcX+zbmTU/XI01QkuCk/mtMTQMd6SE02ZjMgM4l40KSpH6+tOgI0NlpZhSn+mMoy4FLKdQ59wbqhGOKJV2vlKzJWshBLYJF1j87OjAiXrdrjuGEPT1Pqz0aYjaKHmSDjwK0kzWRQrsic2Y3bhRZA9Yl+mxTNNKt2jjyKqA8meM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748680883; c=relaxed/simple;
	bh=799jq6gFPy5XEnSwpA8+a+qrM154nWLIKmOn7fwmLLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBHrfle7UTf4/JkvtUqgrc7tDTMJ6iTcunmLxGe473WcQm/rYTGYgxAvT3aVJ8vYtBW6GztZSZyJmxika86wHXVT5erekiYyfbLo/ehRPSqGgspf5GqNe1pSJnaMaJzdhwKohQjH/pp/3898xncUhSBzGa81ELV3+W/AhCjlR6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=i3bZKa+/; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1748680271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jll3XeKX99pWqsCTGFwx78r84HFnraGM4zNForfuar4=;
	b=i3bZKa+/0lAKv8gR00vmayeK2aJiwvdrqTxJxAaXTEBLkXOwvbc+zORX/B0oIwems0YMAN
	tu5Sv+Sn0Pl2VSVzj8GwBCls8lvt8IS8RO+QwBCo8vYYPt+Ib5EHQmEFIACe0fAeXvF+NY
	oiW/bKeKsUqSJdNcoLoAa9ErZ/nl78A=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 Matthias Schiffer <mschiffer@universe-factory.net>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH batadv 1/5] batman-adv: store hard_iface as iflink private data
Date: Sat, 31 May 2025 10:31:07 +0200
Message-ID: <4075596.ElGaqSPkdT@sven-desktop>
In-Reply-To:
 <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
References:
 <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6691312.GXAFRqVoOG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart6691312.GXAFRqVoOG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 May 2025 10:31:07 +0200
Message-ID: <4075596.ElGaqSPkdT@sven-desktop>
MIME-Version: 1.0

On Monday, 19 May 2025 22:46:28 CEST Matthias Schiffer wrote:
> By passing the hard_iface to netdev_master_upper_dev_link() as private
> data, we can iterate over hardifs of a mesh interface more efficiently
> using netdev_for_each_lower_private*() (instead of iterating over the
> global hardif list). In addition, this will enable resolving a hardif
> from its netdev using netdev_lower_dev_get_private() and getting rid of
> the global list altogether in the following patches.
> 
> A similar approach can be seen in the bonding driver.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
>  net/batman-adv/bat_algo.h       |  1 -
>  net/batman-adv/bat_iv_ogm.c     | 25 +++++++--------------
>  net/batman-adv/bat_v.c          |  6 ++---
>  net/batman-adv/bat_v_elp.c      |  7 ++----
>  net/batman-adv/bat_v_ogm.c      | 12 ++++------
>  net/batman-adv/hard-interface.c | 39 ++++++++++++---------------------
>  net/batman-adv/main.c           |  6 ++---
>  net/batman-adv/mesh-interface.c |  6 ++---
>  net/batman-adv/multicast.c      |  6 ++---
>  net/batman-adv/netlink.c        |  6 ++---
>  net/batman-adv/originator.c     |  6 ++---
>  net/batman-adv/send.c           |  6 ++---
>  12 files changed, 43 insertions(+), 83 deletions(-)

Looks mostly good - I just want to modify the includes slightly (if it is ok for you):

index c165dede..ba5bea4c 100644
--- a/net/batman-adv/bat_algo.c
+++ b/net/batman-adv/bat_algo.c
@@ -14,6 +14,7 @@
 #include <linux/skbuff.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
+#include <linux/types.h>
 #include <net/genetlink.h>
 #include <net/netlink.h>
 #include <uapi/linux/batman_adv.h>
diff --git a/net/batman-adv/bat_algo.h b/net/batman-adv/bat_algo.h
index 898c71b5..cdd1ccfe 100644
--- a/net/batman-adv/bat_algo.h
+++ b/net/batman-adv/bat_algo.h
@@ -11,7 +11,6 @@

 #include <linux/netlink.h>
 #include <linux/skbuff.h>
-#include <linux/types.h>

 extern char batadv_routing_algo[];

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 56b6216f..8df2dcc2 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -35,7 +35,6 @@
 #include <net/cfg80211.h>
 #include <uapi/linux/batadv_packet.h>

-#include "bat_algo.h"
 #include "bat_v_ogm.h"
 #include "hard-interface.h"
 #include "log.h"
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 5c955ac2..cab83d37 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -22,7 +22,6 @@
 #include <linux/mutex.h>
 #include <linux/netdevice.h>
 #include <linux/random.h>
-#include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
@@ -33,7 +32,6 @@
 #include <linux/workqueue.h>
 #include <uapi/linux/batadv_packet.h>

-#include "bat_algo.h"
 #include "hard-interface.h"
 #include "hash.h"
 #include "log.h"
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index af1e644b..d41ce799 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -27,7 +27,6 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/printk.h>
-#include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 35d7ecee..5afb1b70 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -20,7 +20,6 @@
 #include <linux/if_vlan.h>
 #include <linux/init.h>
 #include <linux/limits.h>
-#include <linux/list.h>
 #include <linux/minmax.h>
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 5e4168f8..c13e05d3 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -29,7 +29,6 @@
 #include <linux/workqueue.h>
 #include <uapi/linux/batadv_packet.h>

-#include "bat_algo.h"
 #include "distributed-arp-table.h"
 #include "fragmentation.h"
 #include "gateway_client.h"
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 788fcfd1..a9929948 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -21,7 +21,6 @@
 #include <linux/list.h>
 #include <linux/netdevice.h>
 #include <linux/printk.h>
-#include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>

Thanks,
	Sven
--nextPart6691312.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaDq+SwAKCRBND3cr0xT1
y3drAQC++qUIxjP/5zx4qVUE0mPTESzY622rxoVLLdoMxpjWmwEAxQfC0Aj4rQZN
/JLZqkC1kiWXGPIigQVmK6Q+O3cnYQw=
=0ODT
-----END PGP SIGNATURE-----

--nextPart6691312.GXAFRqVoOG--




