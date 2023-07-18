Return-Path: <netdev+bounces-18539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA24757912
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 12:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9079E28135F
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 10:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBABFBF0;
	Tue, 18 Jul 2023 10:14:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404A2F9D4
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 10:14:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC51F7
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 03:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689675280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=844ov7fXLoP9/IuPStd5omVh+mpqH7/UKWuKSrw2194=;
	b=KGmeL34MrH4E1bDeETUv1PYl8HTxre1OrEyxHg3bsIv6iZDOdVsz/AVRPLBF1Erm7w77gA
	6cwxPcpck8glT01uXx8TE9lyY7x2pQsllI9WffBj3gK3rma2hu26flCenuj76yJZTLA12f
	5e17VKky36KuK3fsDbTdvoas3Uaj6nE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-Cy8SPlm8O-WJjKmlOaNtww-1; Tue, 18 Jul 2023 06:14:39 -0400
X-MC-Unique: Cy8SPlm8O-WJjKmlOaNtww-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-63c9463c116so5327796d6.0
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 03:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689675278; x=1690280078;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=844ov7fXLoP9/IuPStd5omVh+mpqH7/UKWuKSrw2194=;
        b=c6DraloTJ9e1fp1ax17hI5I2fGjb+MA7MxGHja7nMh9opuBAP/3Jv69C3Je5bX705B
         gxiTdZ3autb/FTqs2KX00eKJR1p9NXULNic5u6ke+xR3V1ROtC42Ijx835NjrM38ztBk
         BOqFVBgwQc+75BqUTDB56yDnhIi3FQTEPSlvDado91yauvEkR+S5d/PJjl3knzb0D4uo
         wCDEWIv2uYGF2mNIXnTG5klrTQY/chUaSHJU6DCho8uBrGQ+ul9KQPlDEORM1fgS/iwW
         VGaNPrAJ9U9KNmgwBzYbyTC1bsAUT187w6itGr/SDxje385Va03Fx/4CdXLkG2/H0t/k
         3dlw==
X-Gm-Message-State: ABy/qLZMYaulS1c+bz8wDmr/7L/CPLAluSbhDYa/xlwaLsB2eyHG8FGS
	DNafIOE5k/CkItPVJdCUD1NnGVuORd9P0P2R8OTikvtQk+QPo9ZzRy3fxOUIxVRqP9It2+EhimC
	9N8DSQ/5qTM9erMzX2AFhlXJr
X-Received: by 2002:a05:6214:29ca:b0:625:77a1:2a5f with SMTP id gh10-20020a05621429ca00b0062577a12a5fmr15917909qvb.5.1689675278529;
        Tue, 18 Jul 2023 03:14:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHwf8L12LE+n6hxqurqCgV0IPAkdE+SF3urayBVDuXv3fBzCwpMeIqcDMFTx3/zWe/K0zj9RQ==
X-Received: by 2002:a05:6214:29ca:b0:625:77a1:2a5f with SMTP id gh10-20020a05621429ca00b0062577a12a5fmr15917903qvb.5.1689675278223;
        Tue, 18 Jul 2023 03:14:38 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id d26-20020a0caa1a000000b0062119a7a7a3sm630705qvb.4.2023.07.18.03.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 03:14:37 -0700 (PDT)
Message-ID: <8261532fc0923d3cd9a8937e66c2e8c7e2e1d3b2.camel@redhat.com>
Subject: Re: [PATCH net-next v2 0/2][pull request] Intel Wired LAN Driver
 Updates 2023-07-14 (i40e)
From: Paolo Abeni <pabeni@redhat.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, netdev@vger.kernel.org
Date: Tue, 18 Jul 2023 12:14:35 +0200
In-Reply-To: <20230714201253.1717957-1-anthony.l.nguyen@intel.com>
References: <20230714201253.1717957-1-anthony.l.nguyen@intel.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Fri, 2023-07-14 at 13:12 -0700, Tony Nguyen wrote:
> This series contains updates to i40e driver only.
>=20
> Ivan Vecera adds waiting for VF to complete initialization on VF related
> configuration callbacks.
>=20
> The following are changes since commit 68af900072c157c0cdce0256968edd1506=
7e1e5a:
>   gve: trivial spell fix Recive to Receive
> and are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 40GbE
>=20
> Ivan Vecera (2):
>   i40e: Add helper for VF inited state check with timeout
>   i40e: Wait for pending VF reset in VF set callbacks
>=20
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 65 +++++++++++--------
>  1 file changed, 38 insertions(+), 27 deletions(-)
>=20
The series LGTM, but is targeting net-next while it looks like -net
material to me (except for the missing Fixes tag ;). Am I missing
something? Could you please clarify?

Thanks!

Paolo


