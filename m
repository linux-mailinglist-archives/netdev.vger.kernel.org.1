Return-Path: <netdev+bounces-112079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B94934DDF
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 15:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C321F23F90
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 13:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0551313C831;
	Thu, 18 Jul 2024 13:13:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B273854645
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721308438; cv=none; b=cbNsqBLTWYL8Tlfj1/f9LwealERhSFfmrXkLhJKyXZyr50viZ+ZEtPf7v3T3PnDqpGCtq7HGU7m1ZmpxHBtCrNDdOeeNrT55IeBZfKGDXoF/dVYPbHK/68fsuae4H2+VxjCpNqma+FW8E/a2xg4F8ecKjPawR+KU4ifJRy41ekk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721308438; c=relaxed/simple;
	bh=GGI3KNYKvq7zRM9Ol1syMcunHqf4olhLeyZGA2hhaN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qQenjQ2IhKh5dzcuxtTnz7TunCKT39h8J8FX0+FAk5/J8RLkVgJxR7BBsLWYl3Zqhy0+rEFx4N6YjekUHDZDW05A5UD7VOWIeTh7vs2vTFxeW1SlRi3njGWEHf0j3DypQjUOPgcsB9QLv7c8LVI1nQMI/TjmAT+6pEusctmuZBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-RW6ogtNQMtSdmDAk4nfSCQ-1; Thu,
 18 Jul 2024 09:13:49 -0400
X-MC-Unique: RW6ogtNQMtSdmDAk4nfSCQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6EE501955D45;
	Thu, 18 Jul 2024 13:13:47 +0000 (UTC)
Received: from hog (unknown [10.39.192.3])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3E931955D47;
	Thu, 18 Jul 2024 13:13:44 +0000 (UTC)
Date: Thu, 18 Jul 2024 15:13:42 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v5 04/17] xfrm: sysctl: allow configuration of
 global default values
Message-ID: <ZpkVBpKC-WdVOge6@hog>
References: <20240714202246.1573817-1-chopps@chopps.org>
 <20240714202246.1573817-5-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240714202246.1573817-5-chopps@chopps.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-07-14, 16:22:32 -0400, Christian Hopps wrote:
> diff --git a/net/xfrm/xfrm_sysctl.c b/net/xfrm/xfrm_sysctl.c
> index ca003e8a0376..b70bb91d6984 100644
> --- a/net/xfrm/xfrm_sysctl.c
> +++ b/net/xfrm/xfrm_sysctl.c
> @@ -10,34 +10,50 @@ static void __net_init __xfrm_sysctl_init(struct net =
*net)
>  =09net->xfrm.sysctl_aevent_rseqth =3D XFRM_AE_SEQT_SIZE;
>  =09net->xfrm.sysctl_larval_drop =3D 1;
>  =09net->xfrm.sysctl_acq_expires =3D 30;
> +#if IS_ENABLED(CONFIG_XFRM_IPTFS)
> +=09net->xfrm.sysctl_iptfs_max_qsize =3D 1024 * 1024; /* 1M */
> +=09net->xfrm.sysctl_iptfs_drop_time =3D 1000000; /* 1s */
> +=09net->xfrm.sysctl_iptfs_init_delay =3D 0; /* no initial delay */
> +=09net->xfrm.sysctl_iptfs_reorder_window =3D 3; /* tcp folks suggested *=
/
> +#endif
>  }
> =20
>  #ifdef CONFIG_SYSCTL
>  static struct ctl_table xfrm_table[] =3D {
> -=09{
> -=09=09.procname=09=3D "xfrm_aevent_etime",
> -=09=09.maxlen=09=09=3D sizeof(u32),
> -=09=09.mode=09=09=3D 0644,
> -=09=09.proc_handler=09=3D proc_douintvec
> -=09},
> -=09{
> -=09=09.procname=09=3D "xfrm_aevent_rseqth",
> -=09=09.maxlen=09=09=3D sizeof(u32),
> -=09=09.mode=09=09=3D 0644,
> -=09=09.proc_handler=09=3D proc_douintvec
> -=09},
> -=09{
> -=09=09.procname=09=3D "xfrm_larval_drop",
> -=09=09.maxlen=09=09=3D sizeof(int),
> -=09=09.mode=09=09=3D 0644,
> -=09=09.proc_handler=09=3D proc_dointvec
> -=09},
> -=09{
> -=09=09.procname=09=3D "xfrm_acq_expires",
> -=09=09.maxlen=09=09=3D sizeof(int),
> -=09=09.mode=09=09=3D 0644,
> -=09=09.proc_handler=09=3D proc_dointvec
> -=09},
> +=09{ .procname =3D "xfrm_aevent_etime",
> +=09  .maxlen =3D sizeof(u32),
> +=09  .mode =3D 0644,
> +=09  .proc_handler =3D proc_douintvec },
> +=09{ .procname =3D "xfrm_aevent_rseqth",
> +=09  .maxlen =3D sizeof(u32),
> +=09  .mode =3D 0644,
> +=09  .proc_handler =3D proc_douintvec },
> +=09{ .procname =3D "xfrm_larval_drop",
> +=09  .maxlen =3D sizeof(int),
> +=09  .mode =3D 0644,
> +=09  .proc_handler =3D proc_dointvec },
> +=09{ .procname =3D "xfrm_acq_expires",
> +=09  .maxlen =3D sizeof(int),
> +=09  .mode =3D 0644,
> +=09  .proc_handler =3D proc_dointvec },
> +#if IS_ENABLED(CONFIG_XFRM_IPTFS)
> +=09{ .procname =3D "xfrm_iptfs_drop_time",
> +=09  .maxlen =3D sizeof(uint),
> +=09  .mode =3D 0644,
> +=09  .proc_handler =3D proc_douintvec },
> +=09{ .procname =3D "xfrm_iptfs_init_delay",
> +=09  .maxlen =3D sizeof(uint),
> +=09  .mode =3D 0644,
> +=09  .proc_handler =3D proc_douintvec },
> +=09{ .procname =3D "xfrm_iptfs_max_qsize",
> +=09  .maxlen =3D sizeof(uint),
> +=09  .mode =3D 0644,
> +=09  .proc_handler =3D proc_douintvec },
> +=09{ .procname =3D "xfrm_iptfs_reorder_window",
> +=09  .maxlen =3D sizeof(uint),
> +=09  .mode =3D 0644,
> +=09  .proc_handler =3D proc_douintvec },
> +#endif

What happened here?

--=20
Sabrina


