Return-Path: <netdev+bounces-15313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 299D4746C23
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 10:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F9D1C203A1
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 08:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058343FEC;
	Tue,  4 Jul 2023 08:39:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF791850
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 08:39:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00858CA
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 01:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688459993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xQgnXOFYPGF1l6ZHDn4M6U8+rcOq2wyJpOzFMS2eYGk=;
	b=LvZQHBITyYiIfy7FUwOAL7JVVvsue8zxesWsJ77tAhXNSV5OWgfPCVVZwr40kP6Ah1m8Hl
	kR405MAv7eVs/7tgzyiaObtZPVJ7tgHDe/1LO5TZJyZLNE06wbTmnkFDEp0Pv1/gzHr5oF
	WuVBnMz9d4vwOLqGGIKjaHQgmNWTiBA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-m0ftQwYcOZOvKoISRfnvAw-1; Tue, 04 Jul 2023 04:39:52 -0400
X-MC-Unique: m0ftQwYcOZOvKoISRfnvAw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-40359e38529so5159031cf.1
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 01:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688459991; x=1691051991;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQgnXOFYPGF1l6ZHDn4M6U8+rcOq2wyJpOzFMS2eYGk=;
        b=in+qwMo8saWuxIZCWvMVuIaAhD0ttPGy8RL3cKRjw9arvVEjzlWHFyZmcm4rBOPGIi
         o3fiyE3M7f9zBr6wE315078zn0uvN1BVjJpWvmkJJc3q6Vshrz1lSv0kKl+pBS1IxmVn
         Jux1Ljw8G0JOB9CD79N5OVvPuTdFSQqfFYCw39qEpXisbYg5CMYLjlvIP8+/6lOJBz9M
         +2cy8mKGormxq9fhy8tUwzHKDntVhPeNbGksBcBfBe1hgyWPVS+4pSrvyRA4uM6uA3/z
         Yj51zTUYuz6W+YoXakgkDDzWCaCNqZxLWWI6pKhwsyGZvdcyx/vjJX+Ige8uYpY9VcE0
         0erg==
X-Gm-Message-State: AC+VfDyKJScyObPnPlbdLQF1V9D8CMDnzGjJRx1fHUo1kbi+wSwp+HDn
	zxnwCeyiMCXvrTmENZss6j1lxoEXeTBfSf5Qt+UD0WTHJlW4EcmnohaHImdxCjJ3mxW7fKL27Uy
	KChF/G7EKSl27fl25LajNKnEi
X-Received: by 2002:a05:620a:1a19:b0:75b:23a1:69f0 with SMTP id bk25-20020a05620a1a1900b0075b23a169f0mr14153907qkb.7.1688459991504;
        Tue, 04 Jul 2023 01:39:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4JydWM2F4bITzOoh8hIdwb6CuJsVTYT83cxOeAAAZ2rIbdBShXE8jsoYGOtnLhzIVc1xjFMQ==
X-Received: by 2002:a05:620a:1a19:b0:75b:23a1:69f0 with SMTP id bk25-20020a05620a1a1900b0075b23a169f0mr14153893qkb.7.1688459991258;
        Tue, 04 Jul 2023 01:39:51 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-156.dyn.eolo.it. [146.241.247.156])
        by smtp.gmail.com with ESMTPSA id da34-20020a05620a362200b0075b2af4a076sm1473503qkb.16.2023.07.04.01.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 01:39:50 -0700 (PDT)
Message-ID: <4086297b6c06518505b77cd5de624086e7d5f9d1.camel@redhat.com>
Subject: Re: [PATCH net v2] nfp: clean mc addresses in application firmware
 when closing port
From: Paolo Abeni <pabeni@redhat.com>
To: Yinjun Zhang <yinjun.zhang@corigine.com>, Alexander Lobakin
	 <aleksander.lobakin@intel.com>, Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jacob Keller <jacob.e.keller@intel.com>, Simon Horman
 <simon.horman@corigine.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>,  oss-drivers <oss-drivers@corigine.com>
Date: Tue, 04 Jul 2023 10:39:47 +0200
In-Reply-To: <DM6PR13MB3705E98ABE2CA8B2B677E055FC2EA@DM6PR13MB3705.namprd13.prod.outlook.com>
References: <20230703120116.37444-1-louis.peens@corigine.com>
	 <4012ae37-f674-9e58-ec2a-672e9136576a@intel.com>
	 <DM6PR13MB3705E98ABE2CA8B2B677E055FC2EA@DM6PR13MB3705.namprd13.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-07-04 at 01:50 +0000, Yinjun Zhang wrote:
> On Tuesday, July 4, 2023 12:11 AM, Alexander Lobakin wrote:
> > From: Louis Peens <louis.peens@corigine.com>
> > Date: Mon,  3 Jul 2023 14:01:16 +0200
> >=20
> > > From: Yinjun Zhang <yinjun.zhang@corigine.com>
> > >=20
> > > When moving devices from one namespace to another, mc addresses are
> > > cleaned in software while not removed from application firmware. Thus
> > > the mc addresses are remained and will cause resource leak.
> > >=20
> > > Now use `__dev_mc_unsync` to clean mc addresses when closing port.
> > >=20
> > > Fixes: e20aa071cd95 ("nfp: fix schedule in atomic context when sync m=
c
> > address")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
> > > Acked-by: Simon Horman <simon.horman@corigine.com>
> > > Signed-off-by: Louis Peens <louis.peens@corigine.com>
> > > ---
> > > Changes since v1:
> > >=20
> > > * Use __dev_mc_unsyc to clean mc addresses instead of tracking mc
> > addresses by
> > >   driver itself.
> > > * Clean mc addresses when closing port instead of driver exits,
> > >   so that the issue of moving devices between namespaces can be fixed=
.
> > > * Modify commit message accordingly.
> > >=20
> > >  .../ethernet/netronome/nfp/nfp_net_common.c   | 171 +++++++++-------=
--
> > >  1 file changed, 87 insertions(+), 84 deletions(-)
> >=20
> > [...]
> >=20
> > > +static int nfp_net_mc_sync(struct net_device *netdev, const unsigned=
 char
> > *addr)
> > > +{
> > > +	struct nfp_net *nn =3D netdev_priv(netdev);
> > > +
> > > +	if (netdev_mc_count(netdev) > NFP_NET_CFG_MAC_MC_MAX) {
> > > +		nn_err(nn, "Requested number of MC addresses (%d)
> > exceeds maximum (%d).\n",
> > > +		       netdev_mc_count(netdev),
> > NFP_NET_CFG_MAC_MC_MAX);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	return nfp_net_sched_mbox_amsg_work(nn,
> > NFP_NET_CFG_MBOX_CMD_MULTICAST_ADD, addr,
> > > +					    NFP_NET_CFG_MULTICAST_SZ,
> > nfp_net_mc_cfg);
> > > +}
> > > +
> > > +static int nfp_net_mc_unsync(struct net_device *netdev, const unsign=
ed
> > char *addr)
> > > +{
> > > +	struct nfp_net *nn =3D netdev_priv(netdev);
> > > +
> > > +	return nfp_net_sched_mbox_amsg_work(nn,
> > NFP_NET_CFG_MBOX_CMD_MULTICAST_DEL, addr,
> > > +					    NFP_NET_CFG_MULTICAST_SZ,
> > nfp_net_mc_cfg);
> > > +}
> >=20
> > You can just declare nfp_net_mc_unsync()'s prototype here, so that it
> > will be visible to nfp_net_netdev_close(), without moving the whole set
> > of functions. Either way works, but that one would allow avoiding big
> > diffs not really related to fixing things going through the net-fixes t=
ree.
>=20
> I didn't know which was preferred. Looks like minimum change is concerned
> more. I'll change it.

That is de-facto mandatory for changes targeting stable:

https://elixir.bootlin.com/linux/latest/source/Documentation/process/stable=
-kernel-rules.rst#L10

Cheers,

Paolo


