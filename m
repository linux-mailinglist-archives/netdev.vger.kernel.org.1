Return-Path: <netdev+bounces-24347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D1176FE34
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 12:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7EF2825A7
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 10:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6994AD2B;
	Fri,  4 Aug 2023 10:12:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BF9A946
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 10:12:53 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2AF4ECB
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 03:12:49 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe2bc27029so18782415e9.3
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 03:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bisdn-de.20221208.gappssmtp.com; s=20221208; t=1691143968; x=1691748768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/C7WsCzeWtNKXF4JjKGv04AyYEYOUcOiGp518lHpNMk=;
        b=bhkPHcXXNanvvk7wdm0Be1AV1/2LtsUsw1FzcJC7mx+9eAZC5OJt/tZMwU9qk4ibg5
         OILuTRgUnfaYZQvyFZA68lWh9lu1V0lXYY1zT8t4eC9rc3fHf37X+ifp//30wbSrGnUv
         o9kfWDBF1oFQRKkdYQMEC8F9OaTcI6PvgNf8WmykEEor++bGkrMkfN/CXXtcBGEwpLZ2
         HbaASOn9Gte92Os7PYFuXn3TErbZYdLkmBnJYg2OhbV1pGRSFG+YzVLC/a6ERQH/+hsQ
         273qyI5XIdPN6TuFNmB9KxlGtgLCaczhXge4D7EhX7gGpX+BPn+ozBCCfVJMaoZ4Ua+L
         MJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691143968; x=1691748768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/C7WsCzeWtNKXF4JjKGv04AyYEYOUcOiGp518lHpNMk=;
        b=jnhqfy+GOyVALisxFUKsVtFN3urtTjU8RY2OvoGiL8BuaoFe1bJ3odmiBEsKGZwUUi
         3+AKhM8FEkpZw5DCBBdTGLQGJUJW8iROECgKXYsp+FdOZ3HllO8ihj4G+YmiNrrGn09M
         biCx34Jf9iesdLCuZF4KdQukNWBv/x+Ls/ST5JnbLsw4LP6GGEUHeoHTvTaPxzbVQfPK
         3thGwPzmRl0MwQw50RvOB9Py+wHmodUH4/9DIZLAgdULDbq0SGuECml4HDq1L0med8Is
         YduZam+mD3M5kfZk3jSPuV+IFKtAtbOjqZWcYd4oC8mwDvbzIjmekZuP4SN7R39SDSEU
         MAww==
X-Gm-Message-State: AOJu0YxYptHhhb0SJEj5PVOvh5Aokhgq55Un6gq5EGIHtDhaO0gN9veg
	9bJyMLl/a3+QtKkojm+04/2i/OeUkOlvbxrx6UnICUm1t0sEzBo27KnYA3b/Lwgo1tvFPFd0uUD
	4BsY2SfIh7Q==
X-Google-Smtp-Source: AGHT+IEu/0sI7aOwTyWH6ZhnIWToBKxK9pssDCLsh4OeJUZUHqQ4Ecvs852JY015P9nzfoGe8rK+WQ==
X-Received: by 2002:a05:600c:2049:b0:3fe:2f31:8bf7 with SMTP id p9-20020a05600c204900b003fe2f318bf7mr1135097wmg.26.1691143967567;
        Fri, 04 Aug 2023 03:12:47 -0700 (PDT)
Received: from localhost (dslb-088-076-253-094.088.076.pools.vodafone-ip.de. [88.76.253.94])
        by smtp.gmail.com with ESMTPSA id x5-20020adff0c5000000b00316eb7770b8sm2151847wro.5.2023.08.04.03.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 03:12:46 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@bisdn.de>
To: Elad Nachman <enachman@marvell.com>,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yevhen Orlov <yevhen.orlov@plvision.eu>,
	Oleksandr Mazur <oleksandr.mazur@plvision.eu>
Cc: Taras Chornyi <tchornyi@marvell.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: marvell: prestera: fix handling IPv4 routes with nhid
Date: Fri,  4 Aug 2023 12:12:20 +0200
Message-ID: <20230804101220.247515-1-jonas.gorski@bisdn.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix handling IPv4 routes referencing a nexthop via its id by replacing
calls to fib_info_nh() with fib_info_nhc().

Trying to add an IPv4 route referencing a nextop via nhid:

    $ ip link set up swp5
    $ ip a a 10.0.0.1/24 dev swp5
    $ ip nexthop add dev swp5 id 20 via 10.0.0.2
    $ ip route add 10.0.1.0/24 nhid 20

triggers warnings when trying to handle the route:

[  528.805763] ------------[ cut here ]------------
[  528.810437] WARNING: CPU: 3 PID: 53 at include/net/nexthop.h:468 __prest=
era_fi_is_direct+0x2c/0x68 [prestera]
[  528.820434] Modules linked in: prestera_pci act_gact act_police sch_ingr=
ess cls_u32 cls_flower prestera arm64_delta_tn48m_dn_led(O) arm64_delta_tn4=
8m_dn_cpld(O) [last unloaded: prestera_pci]
[  528.837485] CPU: 3 PID: 53 Comm: kworker/u8:3 Tainted: G           O    =
   6.4.5 #1
[  528.845178] Hardware name: delta,tn48m-dn (DT)
[  528.849641] Workqueue: prestera_ordered __prestera_router_fib_event_work=
 [prestera]
[  528.857352] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[  528.864347] pc : __prestera_fi_is_direct+0x2c/0x68 [prestera]
[  528.870135] lr : prestera_k_arb_fib_evt+0xb20/0xd50 [prestera]
[  528.876007] sp : ffff80000b20bc90
[  528.879336] x29: ffff80000b20bc90 x28: 0000000000000000 x27: ffff0001374=
d3a48
[  528.886510] x26: ffff000105604000 x25: ffff000134af8a28 x24: ffff0001374=
d3800
[  528.893683] x23: ffff000101c89148 x22: ffff000101c89000 x21: ffff000101c=
89200
[  528.900855] x20: ffff00013641fda0 x19: ffff800009d01088 x18: 00000000000=
00059
[  528.908027] x17: 0000000000000277 x16: 0000000000000000 x15: 00000000000=
00000
[  528.915198] x14: 0000000000000003 x13: 00000000000fe400 x12: 00000000000=
00000
[  528.922371] x11: 0000000000000002 x10: 0000000000000aa0 x9 : ffff8000013=
d2020
[  528.929543] x8 : 0000000000000018 x7 : 000000007b1703f8 x6 : 000000001ca=
72f86
[  528.936715] x5 : 0000000033399ea7 x4 : 0000000000000000 x3 : ffff0001374=
d3acc
[  528.943886] x2 : 0000000000000000 x1 : ffff00010200de00 x0 : ffff000134a=
e3f80
[  528.951058] Call trace:
[  528.953516]  __prestera_fi_is_direct+0x2c/0x68 [prestera]
[  528.958952]  __prestera_router_fib_event_work+0x100/0x158 [prestera]
[  528.965348]  process_one_work+0x208/0x488
[  528.969387]  worker_thread+0x4c/0x430
[  528.973068]  kthread+0x120/0x138
[  528.976313]  ret_from_fork+0x10/0x20
[  528.979909] ---[ end trace 0000000000000000 ]---
[  528.984998] ------------[ cut here ]------------
[  528.989645] WARNING: CPU: 3 PID: 53 at include/net/nexthop.h:468 __prest=
era_fi_is_direct+0x2c/0x68 [prestera]
[  528.999628] Modules linked in: prestera_pci act_gact act_police sch_ingr=
ess cls_u32 cls_flower prestera arm64_delta_tn48m_dn_led(O) arm64_delta_tn4=
8m_dn_cpld(O) [last unloaded: prestera_pci]
[  529.016676] CPU: 3 PID: 53 Comm: kworker/u8:3 Tainted: G        W  O    =
   6.4.5 #1
[  529.024368] Hardware name: delta,tn48m-dn (DT)
[  529.028830] Workqueue: prestera_ordered __prestera_router_fib_event_work=
 [prestera]
[  529.036539] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[  529.043533] pc : __prestera_fi_is_direct+0x2c/0x68 [prestera]
[  529.049318] lr : __prestera_k_arb_fc_apply+0x280/0x2f8 [prestera]
[  529.055452] sp : ffff80000b20bc60
[  529.058781] x29: ffff80000b20bc60 x28: 0000000000000000 x27: ffff0001374=
d3a48
[  529.065953] x26: ffff000105604000 x25: ffff000134af8a28 x24: ffff0001374=
d3800
[  529.073126] x23: ffff000101c89148 x22: ffff000101c89148 x21: ffff0001364=
1fda0
[  529.080299] x20: ffff000101c89000 x19: ffff000101c89020 x18: 00000000000=
00059
[  529.087471] x17: 0000000000000277 x16: 0000000000000000 x15: 00000000000=
00000
[  529.094642] x14: 0000000000000003 x13: 00000000000fe400 x12: 00000000000=
00000
[  529.101814] x11: 0000000000000002 x10: 0000000000000aa0 x9 : ffff8000013=
cee80
[  529.108985] x8 : 0000000000000018 x7 : 000000007b1703f8 x6 : 00000000000=
00018
[  529.116157] x5 : 00000000d3497eb6 x4 : ffff000105604081 x3 : 000000008e9=
79557
[  529.123329] x2 : 0000000000000000 x1 : ffff00010200de00 x0 : ffff000134a=
e3f80
[  529.130501] Call trace:
[  529.132958]  __prestera_fi_is_direct+0x2c/0x68 [prestera]
[  529.138394]  prestera_k_arb_fib_evt+0x6b8/0xd50 [prestera]
[  529.143918]  __prestera_router_fib_event_work+0x100/0x158 [prestera]
[  529.150313]  process_one_work+0x208/0x488
[  529.154348]  worker_thread+0x4c/0x430
[  529.158030]  kthread+0x120/0x138
[  529.161274]  ret_from_fork+0x10/0x20
[  529.164867] ---[ end trace 0000000000000000 ]---

and results in a non offloaded route:

    $ ip route
    10.0.0.0/24 dev swp5 proto kernel scope link src 10.0.0.1 rt_trap
    10.0.1.0/24 nhid 20 via 10.0.0.2 dev swp5 rt_trap

When creating a route referencing a nexthop via its ID, the nexthop will
be stored in a separate nh pointer instead of the array of nexthops in
the fib_info struct. This causes issues since fib_info_nh() only handles
the nexthops array, but not the separate nh pointer, and will loudly
WARN about it.

In contrast fib_info_nhc() handles both, but returns a fib_nh_common
pointer instead of a fib_nh pointer. Luckily we only ever access fields
from the fib_nh_common parts, so we can just replace all instances of
fib_info_nh() with fib_info_nhc() and access the fields via their
fib_nh_common names.

This allows handling IPv4 routes with an external nexthop, and they now
get offloaded as expected:

    $ ip route
    10.0.0.0/24 dev swp5 proto kernel scope link src 10.0.0.1 rt_trap
    10.0.1.0/24 nhid 20 via 10.0.0.2 dev swp5 offload rt_offload

Fixes: 396b80cb5cc8 ("net: marvell: prestera: Add neighbour cache accountin=
g")
Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
---
 .../ethernet/marvell/prestera/prestera_router.c    | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_router.c b/driv=
ers/net/ethernet/marvell/prestera/prestera_router.c
index a9a1028cb17b..de317179a7dc 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_router.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_router.c
@@ -166,11 +166,11 @@ prestera_util_neigh2nc_key(struct prestera_switch *sw=
, struct neighbour *n,
=20
 static bool __prestera_fi_is_direct(struct fib_info *fi)
 {
-	struct fib_nh *fib_nh;
+	struct fib_nh_common *fib_nhc;
=20
 	if (fib_info_num_path(fi) =3D=3D 1) {
-		fib_nh =3D fib_info_nh(fi, 0);
-		if (fib_nh->fib_nh_gw_family =3D=3D AF_UNSPEC)
+		fib_nhc =3D fib_info_nhc(fi, 0);
+		if (fib_nhc->nhc_gw_family =3D=3D AF_UNSPEC)
 			return true;
 	}
=20
@@ -261,7 +261,7 @@ static bool
 __prestera_util_kern_n_is_reachable_v4(u32 tb_id, __be32 *addr,
 				       struct net_device *dev)
 {
-	struct fib_nh *fib_nh;
+	struct fib_nh_common *fib_nhc;
 	struct fib_result res;
 	bool reachable;
=20
@@ -269,8 +269,8 @@ __prestera_util_kern_n_is_reachable_v4(u32 tb_id, __be3=
2 *addr,
=20
 	if (!prestera_util_kern_get_route(&res, tb_id, addr))
 		if (prestera_fi_is_direct(res.fi)) {
-			fib_nh =3D fib_info_nh(res.fi, 0);
-			if (dev =3D=3D fib_nh->fib_nh_dev)
+			fib_nhc =3D fib_info_nhc(res.fi, 0);
+			if (dev =3D=3D fib_nhc->nhc_dev)
 				reachable =3D true;
 		}
=20
@@ -324,7 +324,7 @@ prestera_kern_fib_info_nhc(struct fib_notifier_info *in=
fo, int n)
 	if (info->family =3D=3D AF_INET) {
 		fen4_info =3D container_of(info, struct fib_entry_notifier_info,
 					 info);
-		return &fib_info_nh(fen4_info->fi, n)->nh_common;
+		return fib_info_nhc(fen4_info->fi, n);
 	} else if (info->family =3D=3D AF_INET6) {
 		fen6_info =3D container_of(info, struct fib6_entry_notifier_info,
 					 info);
--=20
2.41.0


--=20
BISDN GmbH
K=F6rnerstra=DFe 7-10
10785 Berlin
Germany


Phone:=20
+49-30-6108-1-6100


Managing Directors:=A0
Dr.-Ing. Hagen Woesner, Andreas=20
K=F6psel


Commercial register:=A0
Amtsgericht Berlin-Charlottenburg HRB 141569=20
B
VAT ID No:=A0DE283257294


