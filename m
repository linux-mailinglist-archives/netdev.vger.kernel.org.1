Return-Path: <netdev+bounces-33795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F08EC7A02D7
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 13:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C227B20A2E
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 11:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E91218E30;
	Thu, 14 Sep 2023 11:41:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11731208A3
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 11:41:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F0B41A2
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 04:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694691684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WJrmtIdyNgkWRQXMOwgX0SfKmYd1et+026FQ2JOXjug=;
	b=XQ7MsnJVOv7EIidKuPcOCN1saqMMx0hzCrgbbYJbBzuPZNNINSmOzvqUqLmhMcWxCXMEWE
	SDvZ7ZyxH84a8n2pKoyyznW4/CFp1CdQHgwnCVgWTkJ/BB291vNuydD8p79G02ZLZ1xqdT
	FWl4sh94H42545AuIxAtbNgynWC1Fgc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-99fKtYeQOdOO_7zHlFCQGw-1; Thu, 14 Sep 2023 07:41:22 -0400
X-MC-Unique: 99fKtYeQOdOO_7zHlFCQGw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31fdb15efbeso384155f8f.3
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 04:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694691680; x=1695296480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJrmtIdyNgkWRQXMOwgX0SfKmYd1et+026FQ2JOXjug=;
        b=DGbInWmJpFzR+f+ItEb0wr6veTWczDQzkTZ9q94raz8LWWXXkLjxJ/zLp6IcRov4pg
         4+pzbAIRGOQA5MWswK3Fe5woRTbDXv8uuMeGBzEnL/9iFURRb96YEyeEQ3aSBMTvtU3u
         OhMwkcNIXwxLhGPqw+c4z6XvWbttPhe8/JfrGNq/PyXQSL5RCo6ozr+Rm+L2zBWiv7Hr
         IaMfhlcfP5wXmKmgHkazxUdhChiUIML8eBBTDwfN7Mw1F4xw3CisocZNv0GfVa+sxafe
         hL98lRarf466I8pZ/u+o2en8BUJg/137rGf1zUnl2+/NsQD4Tl0SjMNbY1/GnsTacP9Y
         mOPw==
X-Gm-Message-State: AOJu0YwhC7feMCA7tBdKhycCJ95+FsUaB4Ibs3iecxGgSpHIQwvfKksd
	75hwM8yDe8/F/tlf5va0DAox0188lEkeiD6id4vWDXNtDJPlFAffH1Wu6lqK22d3PkMeTb6uVZL
	Dp6SUUFMzfX9dLfJ4LXIbEpXj
X-Received: by 2002:adf:eb49:0:b0:319:867e:97cb with SMTP id u9-20020adfeb49000000b00319867e97cbmr3675547wrn.42.1694691680762;
        Thu, 14 Sep 2023 04:41:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaHKMq9aoOQqmOMxQMNoWGmNMavsseBP1aoCVtRAlGdHS/Vtcmut69buWcGxBAfD0lx6OwPQ==
X-Received: by 2002:adf:eb49:0:b0:319:867e:97cb with SMTP id u9-20020adfeb49000000b00319867e97cbmr3675532wrn.42.1694691680427;
        Thu, 14 Sep 2023 04:41:20 -0700 (PDT)
Received: from localhost (net-2-34-76-254.cust.vodafonedsl.it. [2.34.76.254])
        by smtp.gmail.com with ESMTPSA id b17-20020a5d4d91000000b0031c855d52efsm1537350wru.87.2023.09.14.04.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:41:19 -0700 (PDT)
Date: Thu, 14 Sep 2023 13:41:17 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 3/3] NFSD: add rpc_status netlink support
Message-ID: <ZQLxXaJN7Qh9PCpn@lore-desk>
References: <cover.1694436263.git.lorenzo@kernel.org>
 <ac18892ea3f718c63f0a12e39aeaac812c081515.1694436263.git.lorenzo@kernel.org>
 <20230912151340.GH401982@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x4v+jESRyiFTaBAa"
Content-Disposition: inline
In-Reply-To: <20230912151340.GH401982@kernel.org>


--x4v+jESRyiFTaBAa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]

> > +
> > +#ifdef CONFIG_NFSD_V4
> > +			if (rqstp->rq_vers =3D=3D NFS4_VERSION &&
> > +			    rqstp->rq_proc =3D=3D NFSPROC4_COMPOUND) {
> > +				/* NFSv4 compund */
>=20
> nit: compound

ack, I will fix it.

>=20
> > +				struct nfsd4_compoundargs *args;
> > +				int j;
> > +
> > +				args =3D rqstp->rq_argp;
> > +				genl_rqstp.opcnt =3D args->opcnt;
> > +				for (j =3D 0; j < genl_rqstp.opcnt; j++)
> > +					genl_rqstp.opnum[j] =3D
> > +						args->ops[j].opnum;
> > +			}
> > +#endif /* CONFIG_NFSD_V4 */
> > +
> > +			/*
> > +			 * Acquire rq_status_counter before reporting the rqst
> > +			 * fields to the user.
> > +			 */
> > +			if (smp_load_acquire(&rqstp->rq_status_counter) !=3D
> > +			    status_counter)
> > +				continue;
> > +
> > +			ret =3D nfsd_genl_rpc_status_compose_msg(skb, cb,
> > +							       &genl_rqstp);
> > +			if (ret)
> > +				goto out;
> > +		}
> > +	}
> > +
> > +	cb->args[0] =3D i;
> > +	cb->args[1] =3D rqstp_index;
>=20
> I'm unsure if this is possible, but if the for loop above iterates zero
> times, or for all iterations (i < cb->args[0]), then rqstp_index will
> be used uninitialised here.

ack, thx for spotting it, I will fix it.

Regards,
Lorenzo

>=20
> Flagged by Smatch.
>=20
> > +	ret =3D skb->len;
> > +out:
> > +	rcu_read_unlock();
> > +
> > +	return ret;
> > +}
>=20
> ...
>=20
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index 11c14faa6c67..d787bd38c053 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -62,6 +62,22 @@ struct readdir_cd {
> >  	__be32			err;	/* 0, nfserr, or nfserr_eof */
> >  };
> > =20
> > +/* Maximum number of operations per session compound */
> > +#define NFSD_MAX_OPS_PER_COMPOUND	50
> > +
> > +struct nfsd_genl_rqstp {
> > +	struct sockaddr daddr;
> > +	struct sockaddr saddr;
> > +	unsigned long rq_flags;
> > +	ktime_t rq_stime;
> > +	__be32 rq_xid;
> > +	u32 rq_vers;
> > +	u32 rq_prog;
> > +	u32 rq_proc;
> > +	/* NFSv4 compund */
>=20
> nit: compound
>=20
> > +	u32 opnum[NFSD_MAX_OPS_PER_COMPOUND];
> > +	u16 opcnt;
> > +};
> > =20
> >  extern struct svc_program	nfsd_program;
> >  extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_ver=
sion4;
>=20
> ...
>=20

--x4v+jESRyiFTaBAa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZQLxXQAKCRA6cBh0uS2t
rH4WAQCZ9aO76dxbPEDOT0LnbGtY44bJLs75LQpah1fXEtIVzwEAwdUezPCVhQf6
JlbKo+oF6sfUgv8XAV3aCME0dVJo5QQ=
=wjTQ
-----END PGP SIGNATURE-----

--x4v+jESRyiFTaBAa--


