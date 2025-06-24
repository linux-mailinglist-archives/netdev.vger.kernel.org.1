Return-Path: <netdev+bounces-200505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C279AE5BE2
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 07:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A581B66418
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 05:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326BA19F480;
	Tue, 24 Jun 2025 05:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="o9Peqqh1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B1E79F2
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 05:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750743407; cv=none; b=Lrz9wAHOcNI4/UaK92gJ4U6Qoeew9947jgwJwm9+xQIbJ5egLijudyYTY3j7ADFPviuWpecujVqPjhe3EEZzNQTSkUaLZ8qmjlTVfuQRaLVhs3ZYt9ULdV0g0W3zsBASRaZerlhVMBm/eZKDeI8XxsSb39NUemvHMGXMTjDwIfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750743407; c=relaxed/simple;
	bh=hM1eP511aEqGiQ/Oypz2TY+oJg/5LaiXR5FPGNAdMbk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BTZtJoblubFaXcb0R3/rkHss7wny0IuSHExj3ebSUn5o7kOFLPlaZqvq4zirQiwlgupG+aqr6P/IAdN6e5IRE4EXnlZalsZletsOtO6qd8SYYIM1Fph0uhMMNUEmbby0UaBJ05vbUfbRmZW12G81ItC1+hPjukEDw2gZE7RY5SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=o9Peqqh1; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1750743399; x=1751002599;
	bh=hM1eP511aEqGiQ/Oypz2TY+oJg/5LaiXR5FPGNAdMbk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=o9Peqqh19Ed0HPd+buLwlASOt00auKPwcD1ykbwMXnqNJ8gKY9k8uIvw/KZZNNgXH
	 VHQ30bwaS3R0WVNlQOMyzaipjNyQfpM07sGu0zohZ4qFkNJ8/70zeuLQlBzysesvcf
	 qmUkoghbgQ0wqsvP88ADIzQ9p2BT6/ZzWZmAbl223uIwKjPF3HeQIZSfQerALQtJfE
	 omNeuvZPnLBpm5vIaDsZqlzgtjmvuiKp1kjqk6WGWSAkCL0FBtKH/Hgn5g5s5b63bX
	 CVTiQXbu4JJBJuk+RERWkn0DN2KAj3dPeAoHHuPNMm8iY7KoMcXMEGcJXEEI4CMqDV
	 UNIQSJc0uRlzg==
Date: Tue, 24 Jun 2025 05:36:34 +0000
To: netdev@vger.kernel.org
From: William Liu <will@willsroot.io>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, victor@mojatatu.com, pctammela@mojatatu.com, pabeni@redhat.com, kuba@kernel.org, stephen@networkplumber.org, dcaratti@redhat.com, savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, William Liu <will@willsroot.io>
Subject: Re: [PATCH net v2 1/2] net/sched: Restrict conditions for adding duplicating netems to qdisc tree
Message-ID: <sJSFrPAuQr53uFRQlRKAsEZNkDg1umtbxAlgqqhnuvTobg1qwtVa-0sR-IVhFYXdgYlBIZnSD6AKlI6BAzgCrBwo7lZ5AYzX_xhhCTP3P7o=@willsroot.io>
In-Reply-To: <20250624042238.521211-1-will@willsroot.io>
References: <20250624042238.521211-1-will@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 962b88261b723c5ee7e3127afffa0eea461bfbef
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable






On Tuesday, June 24th, 2025 at 4:24 AM, William Liu <will@willsroot.io> wro=
te:

>=20
>=20
> netem_enqueue's duplication prevention logic breaks when a netem
> resides in a qdisc tree with other netems - this can lead to a
> soft lockup and OOM loop in netem_dequeue as seen in [1].
> Ensure that a duplicating netem cannot exist in a tree with other
> netems.
>=20
> [1] https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilx=
sEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=3D@wi=
llsroot.io/
>=20
> Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
> Reported-by: William Liu will@willsroot.io
>=20
> Reported-by: Savino Dicanosa savy@syst3mfailure.io
>=20
> Signed-off-by: William Liu will@willsroot.io
>=20
> Signed-off-by: Savino Dicanosa savy@syst3mfailure.io
>=20
> ---
> net/sched/sch_netem.c | 45 +++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 45 insertions(+)
>=20
> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index fdd79d3ccd8c..be38458ae5bc 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -973,6 +973,46 @@ static int parse_attr(struct nlattr *tb[], int maxty=
pe, struct nlattr *nla,
> return 0;
> }
>=20
> +static const struct Qdisc_class_ops netem_class_ops;
> +
> +static inline bool has_duplication(struct Qdisc *sch)
> +{
> + struct netem_sched_data *q =3D qdisc_priv(sch);
> +
> + return q->duplicate;
>=20
> +}
> +
> +static int check_netem_in_tree(struct Qdisc *sch, bool duplicates,
> + struct netlink_ext_ack *extack)
> +{
> + struct Qdisc *root, *q;
> + unsigned int i;
> +
> + root =3D qdisc_root_sleeping(sch);
> +
> + if (sch !=3D root && root->ops->cl_ops =3D=3D &netem_class_ops) {
>=20
> + if (duplicates || has_duplication(root))
> + goto err;
> + }
> +
> + if (!qdisc_dev(root))
> + return 0;
> +
> + hash_for_each(qdisc_dev(root)->qdisc_hash, i, q, hash) {
>=20
> + if (sch !=3D q && q->ops->cl_ops =3D=3D &netem_class_ops) {
>=20
> + if (duplicates || has_duplication(q))
> + goto err;
> + }
> + }
> +
> + return 0;
> +
> +err:
> + NL_SET_ERR_MSG(extack,
> + "netem: cannot mix duplicating netems with other netems in tree");
> + return -EINVAL;
> +}
> +
> /* Parse netlink message to set options */
> static int netem_change(struct Qdisc *sch, struct nlattr *opt,
> struct netlink_ext_ack *extack)
> @@ -1031,6 +1071,11 @@ static int netem_change(struct Qdisc *sch, struct =
nlattr *opt,
> q->gap =3D qopt->gap;
>=20
> q->counter =3D 0;
>=20
> q->loss =3D qopt->loss;
>=20
> +
> + ret =3D check_netem_in_tree(sch, qopt->duplicate, extack);
>=20
> + if (ret)
> + goto unlock;
> +
> q->duplicate =3D qopt->duplicate;
>=20
>=20
> /* for compatibility with earlier versions.
> --
> 2.43.0

v2 was sent out right after some additional feedback from Cong. Please revi=
ew v3 instead, which I will be posting shortly.

pw-bot: changes-requested

Thanks,
William

