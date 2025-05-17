Return-Path: <netdev+bounces-191262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4ECABA7CD
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 04:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BB6E1BA6C60
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 02:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EAC481C4;
	Sat, 17 May 2025 02:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VdRsgW8A"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C83E136A
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 02:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747448668; cv=none; b=kXlZ6ZekkWEOBwi5E96hMDX6yB6/MMFBDl4q1GiplxKzcyqjhYUQLNyrCYN4mQyW0EUYGynND67MuLf9nTKNsc4ujUMJkxtEwA2skf7Q2jf4Oc+HupQvoVlZc9wItrkvphK4y6Cjs294Dp3zUtKg7NxdX7olEUbOH//VOu9A0yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747448668; c=relaxed/simple;
	bh=h7aX2ssPnt1Kb4y6lpm12xn6PV/MDkOMHQyrn++Kd2w=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=tqdgnC7zoa3yLnLeAc0StWHvo7HCxmOk+cRPLoc/KJrYh8NADaNea9Rdb/3i+xq6NvvDcOWpXPrkdex4GOgs+lIs1/h0UN6u9QF1osNlotThhdvavwv9/RkzuF6+PgYpTy3LEz4J11oAj0UIcwBA+h0TF/3CRCbqnIqXSlwHe1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VdRsgW8A; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747448663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gv5pST7Dgsy3sMDFeBeFuSKUbKMzzt5YcOXi+MoeozQ=;
	b=VdRsgW8AVT+jpp/7rrc2sj2jNqScfvPUwA/Br5SnXhzbU9CN2IKbaRhOch/lWQTUOe0gV0
	sX0DvzLiIZmlEA1ifjyGFLHYy4jUB/2fq3ZrVd5lOxXpYn3B6Oi8PtjcoPQSy8Q6+EuHTe
	1eKE7Uc3evoipD4zf6urfhzgIJuhpKo=
Date: Sat, 17 May 2025 02:24:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <3f8cd57a8c9456bf65fe7d83e48f090f2dfa2999@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net-next] net: sysfs: Implement is_visible for
 phys_(port_id, port_name, switch_id)
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org
In-Reply-To: <20250516152611.5945afae@kernel.org>
References: <20250515130205.3274-1-yajun.deng@linux.dev>
 <20250516152611.5945afae@kernel.org>
X-Migadu-Flow: FLOW_OUT

May 17, 2025 at 6:26 AM, "Jakub Kicinski" <kuba@kernel.org> wrote:



>=20
>=20On Thu, 15 May 2025 21:02:05 +0800 Yajun Deng wrote:
>=20
>=20>=20
>=20> +static struct attribute *netdev_phys_attrs[] __ro_after_init =3D {
> >=20
>=20
> Why __ro_after_init and not const? I can't find the reason with=20
>=20
> a quick grep. This is just an array of pointers, not objects.
>=20

These=20attributes in net_class_attrs had __ro_after_init before this pat=
ch.


> >=20
>=20> + &dev_attr_phys_port_id.attr,
> >=20
>=20>  + &dev_attr_phys_port_name.attr,
> >=20
>=20>  + &dev_attr_phys_switch_id.attr,
> >=20
>=20>  + NULL,
> >=20
>=20>  +};
> >=20
>=20>  +
> >=20
>=20>  +static umode_t netdev_phys_is_visible(struct kobject *kobj,
> >=20
>=20>  + struct attribute *attr, int index)
> >=20
>=20>  +{
> >=20
>=20>  + struct device *dev =3D kobj_to_dev(kobj);
> >=20
>=20>  + struct net_device *netdev =3D to_net_dev(dev);
> >=20
>=20>  +
> >=20
>=20>  + if (attr =3D=3D &dev_attr_phys_port_id.attr) {
> >=20
>=20>  + /* The check is also done in dev_get_phys_port_id; this helps re=
turning
> >=20
>=20>  + * early without hitting the locking section below.
> >=20
>=20>  + */
> >=20
>=20>  + if (!netdev->netdev_ops->ndo_get_phys_port_id)
> >=20
>=20>  + return 0;
> >=20
>=20>  + } else if (attr =3D=3D &dev_attr_phys_port_name.attr) {
> >=20
>=20>  + /* The checks are also done in dev_get_phys_port_name; this help=
s
> >=20
>=20>  + * returning early without hitting the locking section below.
> >=20
>=20>  + */
> >=20
>=20>  + if (!netdev->netdev_ops->ndo_get_phys_port_name &&
> >=20
>=20>  + !netdev->devlink_port)
> >=20
>=20>  + return 0;
> >=20
>=20>  + } else if (attr =3D=3D &dev_attr_phys_switch_id.attr) {
> >=20
>=20>  + /* The checks are also done in dev_get_phys_port_name; this help=
s
> >=20
>=20>  + * returning early without hitting the locking section below. Thi=
s works
> >=20
>=20>  + * because recurse is false when calling dev_get_port_parent_id.
> >=20
>=20>  + */
> >=20
>=20>  + if (!netdev->netdev_ops->ndo_get_port_parent_id &&
> >=20
>=20>  + !netdev->devlink_port)
> >=20
>=20>  + return 0;
> >=20
>=20
> I'm slightly worried some user space depends on the files existing,
>=20
>=20but maybe ENOENT vs EOPNOTSUPP doesn't make a big difference.
>=20
>=20Can you remove the comments, tho? I don't think they add much value.
>=20
Okay.

>=20--=20
>=20
> pw-bot: cr
>

