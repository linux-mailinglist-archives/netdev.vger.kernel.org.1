Return-Path: <netdev+bounces-212546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2217B21317
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 19:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8956C4E3B0F
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 17:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50622D481F;
	Mon, 11 Aug 2025 17:25:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from 5.mo560.mail-out.ovh.net (5.mo560.mail-out.ovh.net [87.98.181.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1790E2690D1
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.98.181.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933116; cv=none; b=RekNedhk25JtZv100dSIfCd4TswYO9vBQYhrOpGvklj0YbYrvp41F0yuAuxbKn4O/1XLpmHHJUW984OoGAX8r3YrOJFie3EvpEwFuAT9DoJKveMjymKXQVzyVBeLz2vmh6kC+p0uWCfArK83s8kajTt4Koh8BKWr7GmGqWEbjKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933116; c=relaxed/simple;
	bh=/OgP2fWVJyslPL/uNxCOeQEOl/jSz8lUlRBr9hgwdtU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Ca2SStaQJcAYuQYA+RyYndxoiomVcw67ilZcz2WyLrAX0+lAUvBQeA7KzjtfoaK4iAD72hbSEMaIiGCCvVubAYUb9/wxBee5qvtep+awGFO9CwepQWmfsBbHuH6J2DwVrU//GePD8d+Xwie34QwHm8l1rvrhfHj0l5iHMwfdi/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net; spf=pass smtp.mailfrom=remlab.net; arc=none smtp.client-ip=87.98.181.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remlab.net
Received: from director10.ghost.mail-out.ovh.net (unknown [10.110.54.193])
	by mo560.mail-out.ovh.net (Postfix) with ESMTP id 4c0yRt4MKyzB7vT
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 14:58:02 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-rtb4t (unknown [10.110.188.214])
	by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id C537DC154D;
	Mon, 11 Aug 2025 14:57:48 +0000 (UTC)
Received: from courmont.net ([37.59.142.106])
	by ghost-submission-5b5ff79f4f-rtb4t with ESMTPSA
	id 4gMzMusEmmhy1QEAI4oDMA
	(envelope-from <remi@remlab.net>); Mon, 11 Aug 2025 14:57:48 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-106R006240cf1e2-728d-4c8f-95da-6579b7a637e6,
                    0AE6E86C62881299141D84328603455735AF50AA) smtp.auth=postmaster@courmont.net
X-OVh-ClientIp:205.220.129.228
Date: Mon, 11 Aug 2025 23:57:35 +0900
From: =?ISO-8859-1?Q?R=E9mi_Denis-Courmont?= <remi@remlab.net>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Remi Denis-Courmont <courmisch@gmail.com>
Subject: Re: [PATCH net-next] phonet: add __rcu annotations
User-Agent: K-9 Mail for Android
In-Reply-To: <20250811145252.1007242-1-edumazet@google.com>
References: <20250811145252.1007242-1-edumazet@google.com>
Message-ID: <CF7BAFD9-D698-4639-8AA0-EDF88166794F@remlab.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 358599122912352542
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevufgfjghfkfggtgfgsehtqhhmtddtreejnecuhfhrohhmpeftrohmihcuffgvnhhishdqvehouhhrmhhonhhtuceorhgvmhhisehrvghmlhgrsgdrnhgvtheqnecuggftrfgrthhtvghrnheptdehtedtheegfeejfeetheetgedvveekkeejhffggefgieevveffffelgfehueejnecukfhppeduvdejrddtrddtrddupddvtdehrddvvddtrdduvdelrddvvdekpdefjedrheelrddugedvrddutdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehrvghmihesrhgvmhhlrggsrdhnvghtpdhnsggprhgtphhtthhopedupdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedtmgdpmhhouggvpehsmhhtphhouhht



Le 11 ao=C3=BBt 2025 23:52:52 GMT+09:00, Eric Dumazet <edumazet@google=2Ec=
om> a =C3=A9crit=C2=A0:
>Removes following sparse errors=2E
>
>make C=3D2 net/phonet/socket=2Eo net/phonet/af_phonet=2Eo
>  CHECK   net/phonet/socket=2Ec
>net/phonet/socket=2Ec:619:14: error: incompatible types in comparison exp=
ression (different address spaces):
>net/phonet/socket=2Ec:619:14:    struct sock [noderef] __rcu *
>net/phonet/socket=2Ec:619:14:    struct sock *
>net/phonet/socket=2Ec:642:17: error: incompatible types in comparison exp=
ression (different address spaces):
>net/phonet/socket=2Ec:642:17:    struct sock [noderef] __rcu *
>net/phonet/socket=2Ec:642:17:    struct sock *
>net/phonet/socket=2Ec:658:17: error: incompatible types in comparison exp=
ression (different address spaces):
>net/phonet/socket=2Ec:658:17:    struct sock [noderef] __rcu *
>net/phonet/socket=2Ec:658:17:    struct sock *
>net/phonet/socket=2Ec:677:25: error: incompatible types in comparison exp=
ression (different address spaces):
>net/phonet/socket=2Ec:677:25:    struct sock [noderef] __rcu *
>net/phonet/socket=2Ec:677:25:    struct sock *
>net/phonet/socket=2Ec:726:21: warning: context imbalance in 'pn_res_seq_s=
tart' - wrong count at exit
>net/phonet/socket=2Ec:741:13: warning: context imbalance in 'pn_res_seq_s=
top' - wrong count at exit
>  CHECK   net/phonet/af_phonet=2Ec
>net/phonet/af_phonet=2Ec:35:14: error: incompatible types in comparison e=
xpression (different address spaces):
>net/phonet/af_phonet=2Ec:35:14:    struct phonet_protocol const [noderef]=
 __rcu *
>net/phonet/af_phonet=2Ec:35:14:    struct phonet_protocol const *
>net/phonet/af_phonet=2Ec:474:17: error: incompatible types in comparison =
expression (different address spaces):
>net/phonet/af_phonet=2Ec:474:17:    struct phonet_protocol const [noderef=
] __rcu *
>net/phonet/af_phonet=2Ec:474:17:    struct phonet_protocol const *
>net/phonet/af_phonet=2Ec:486:9: error: incompatible types in comparison e=
xpression (different address spaces):
>net/phonet/af_phonet=2Ec:486:9:    struct phonet_protocol const [noderef]=
 __rcu *
>net/phonet/af_phonet=2Ec:486:9:    struct phonet_protocol const *
>
>Signed-off-by: Eric Dumazet <edumazet@google=2Ecom>
>Cc: Remi Denis-Courmont <courmisch@gmail=2Ecom>


Acked-by: R=C3=A9mi Denis-Courmont <courmisch@gmail=2Ecom>

(We should probably replace that BUG_ON with a WARN_ON but that's a separa=
te issue=2E)

>---
> net/phonet/af_phonet=2Ec |  4 ++--
> net/phonet/socket=2Ec    | 23 ++++++++++++-----------
> 2 files changed, 14 insertions(+), 13 deletions(-)
>
>diff --git a/net/phonet/af_phonet=2Ec b/net/phonet/af_phonet=2Ec
>index a27efa4faa4ef46e64efe6744790c47ec34147ac=2E=2E238a9638d2b0f6a23070b=
0871515302d8cba864f 100644
>--- a/net/phonet/af_phonet=2Ec
>+++ b/net/phonet/af_phonet=2Ec
>@@ -22,7 +22,7 @@
> #include <net/phonet/pn_dev=2Eh>
>=20
> /* Transport protocol registration */
>-static const struct phonet_protocol *proto_tab[PHONET_NPROTO] __read_mos=
tly;
>+static const struct phonet_protocol __rcu *proto_tab[PHONET_NPROTO] __re=
ad_mostly;
>=20
> static const struct phonet_protocol *phonet_proto_get(unsigned int proto=
col)
> {
>@@ -482,7 +482,7 @@ void phonet_proto_unregister(unsigned int protocol,
> 			const struct phonet_protocol *pp)
> {
> 	mutex_lock(&proto_tab_lock);
>-	BUG_ON(proto_tab[protocol] !=3D pp);
>+	BUG_ON(rcu_access_pointer(proto_tab[protocol]) !=3D pp);
> 	RCU_INIT_POINTER(proto_tab[protocol], NULL);
> 	mutex_unlock(&proto_tab_lock);
> 	synchronize_rcu();
>diff --git a/net/phonet/socket=2Ec b/net/phonet/socket=2Ec
>index ea4d5e6533dba737f77bedbba1b1ef2ec3c17568=2E=2E2b61a40b568e91e340130=
a9b589e2b7a9346643f 100644
>--- a/net/phonet/socket=2Ec
>+++ b/net/phonet/socket=2Ec
>@@ -602,7 +602,7 @@ const struct seq_operations pn_sock_seq_ops =3D {
> #endif
>=20
> static struct  {
>-	struct sock *sk[256];
>+	struct sock __rcu *sk[256];
> } pnres;
>=20
> /*
>@@ -654,7 +654,7 @@ int pn_sock_unbind_res(struct sock *sk, u8 res)
> 		return -EPERM;
>=20
> 	mutex_lock(&resource_mutex);
>-	if (pnres=2Esk[res] =3D=3D sk) {
>+	if (rcu_access_pointer(pnres=2Esk[res]) =3D=3D sk) {
> 		RCU_INIT_POINTER(pnres=2Esk[res], NULL);
> 		ret =3D 0;
> 	}
>@@ -673,7 +673,7 @@ void pn_sock_unbind_all_res(struct sock *sk)
>=20
> 	mutex_lock(&resource_mutex);
> 	for (res =3D 0; res < 256; res++) {
>-		if (pnres=2Esk[res] =3D=3D sk) {
>+		if (rcu_access_pointer(pnres=2Esk[res]) =3D=3D sk) {
> 			RCU_INIT_POINTER(pnres=2Esk[res], NULL);
> 			match++;
> 		}
>@@ -688,7 +688,7 @@ void pn_sock_unbind_all_res(struct sock *sk)
> }
>=20
> #ifdef CONFIG_PROC_FS
>-static struct sock **pn_res_get_idx(struct seq_file *seq, loff_t pos)
>+static struct sock __rcu **pn_res_get_idx(struct seq_file *seq, loff_t p=
os)
> {
> 	struct net *net =3D seq_file_net(seq);
> 	unsigned int i;
>@@ -697,7 +697,7 @@ static struct sock **pn_res_get_idx(struct seq_file *=
seq, loff_t pos)
> 		return NULL;
>=20
> 	for (i =3D 0; i < 256; i++) {
>-		if (pnres=2Esk[i] =3D=3D NULL)
>+		if (rcu_access_pointer(pnres=2Esk[i]) =3D=3D NULL)
> 			continue;
> 		if (!pos)
> 			return pnres=2Esk + i;
>@@ -706,7 +706,7 @@ static struct sock **pn_res_get_idx(struct seq_file *=
seq, loff_t pos)
> 	return NULL;
> }
>=20
>-static struct sock **pn_res_get_next(struct seq_file *seq, struct sock *=
*sk)
>+static struct sock __rcu **pn_res_get_next(struct seq_file *seq, struct =
sock __rcu **sk)
> {
> 	struct net *net =3D seq_file_net(seq);
> 	unsigned int i;
>@@ -728,7 +728,7 @@ static void *pn_res_seq_start(struct seq_file *seq, l=
off_t *pos)
>=20
> static void *pn_res_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> {
>-	struct sock **sk;
>+	struct sock __rcu **sk;
>=20
> 	if (v =3D=3D SEQ_START_TOKEN)
> 		sk =3D pn_res_get_idx(seq, 0);
>@@ -747,11 +747,12 @@ static void pn_res_seq_stop(struct seq_file *seq, v=
oid *v)
> static int pn_res_seq_show(struct seq_file *seq, void *v)
> {
> 	seq_setwidth(seq, 63);
>-	if (v =3D=3D SEQ_START_TOKEN)
>+	if (v =3D=3D SEQ_START_TOKEN) {
> 		seq_puts(seq, "rs   uid inode");
>-	else {
>-		struct sock **psk =3D v;
>-		struct sock *sk =3D *psk;
>+	} else {
>+		struct sock __rcu **psk =3D v;
>+		struct sock *sk =3D rcu_dereference_protected(*psk,
>+					lockdep_is_held(&resource_mutex));
>=20
> 		seq_printf(seq, "%02X %5u %lu",
> 			   (int) (psk - pnres=2Esk),

