Return-Path: <netdev+bounces-19420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8634475A992
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 10:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70F11C21333
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 08:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6421719A1D;
	Thu, 20 Jul 2023 08:43:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CEE199EF
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 08:43:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CF62707
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 01:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689842595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nnk1H/qBOY4QMmc2l3158C9DrB3sL4CY48lgJzt2VdM=;
	b=Cgcf2sJTpr4cml3gAXgBrTgEJhL46v/QeOhs9hCLm05YJwVNeE8QpHq9+4RCZzyGV2l1G8
	PgpzubxQvxoYScd5rmYSlPUaLMQELMaWkNpwrcyVqXZmqQPlMDUHkK3vKhN/0qBo/mzXHK
	Q2Qr+77Cp0qrWizecaqEz7GU9D+eUqQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-tTCmxZMdNDanyGnel3HRFA-1; Thu, 20 Jul 2023 04:43:12 -0400
X-MC-Unique: tTCmxZMdNDanyGnel3HRFA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-635de6f75e0so1586106d6.1
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 01:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689842592; x=1690447392;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nnk1H/qBOY4QMmc2l3158C9DrB3sL4CY48lgJzt2VdM=;
        b=UPH+bmc+cG/u9ILnEWyxHzlsUWvDIFuwGl/61P8RHAf30SLCC+flxbgQ/R2Kv4EL1F
         tX31HXFrAGCvAvJtJ44ndc+4Fq1CDu5idbydCB9ti6uU2KP4lmkqNuEDkwEMkMB4Rv/x
         QPBf9afaf/Eyhqo6MOeHGLRIlh0biXOsPYEv7ptGmtGoMsQDN1H/ldWSj6uwavCN6gnk
         aV+TGlpfN5a5UkRcTlWRCp8xelrhoyqt82/P9yUWuvrKSSV/pqqKP7wn9m4ZXKosWvRo
         qGgHS7s/mmPY/WN+mChiAQ8qrev5I/10jucUV5S1nqKp+BBS9QEkpaRr0IiY9uP8u96F
         7R2g==
X-Gm-Message-State: ABy/qLZP6A5eaTuznAzDRHXSWuXlhjbM2mUDRrpjh94NyJfB46Fqtk/a
	evDTQ6N5BSccRGVVPWEfX8JeCrlX4/vXdtrcqSVMbUr3K1yZzdaqQ9MeIjPaoT8BqFg1ronm+mK
	ipxZDAHj5UjtNeAAA
X-Received: by 2002:a05:6214:1305:b0:626:2305:6073 with SMTP id pn5-20020a056214130500b0062623056073mr2135866qvb.4.1689842592425;
        Thu, 20 Jul 2023 01:43:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFzWkjbEhZryHgB22Z8OcOqTllSVtiB4/F69cIOU68y4IaYcd3DyIiJn/XbNGn9PkK3WQKaMA==
X-Received: by 2002:a05:6214:1305:b0:626:2305:6073 with SMTP id pn5-20020a056214130500b0062623056073mr2135862qvb.4.1689842592126;
        Thu, 20 Jul 2023 01:43:12 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id q11-20020a0ce20b000000b0062ffbf23c22sm179977qvl.131.2023.07.20.01.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 01:43:11 -0700 (PDT)
Message-ID: <1b4b4012e3349c3aef60b676845ece172fd2eefa.camel@redhat.com>
Subject: Re: [PATCH net] vxlan: calculate correct header length for GPE
From: Paolo Abeni <pabeni@redhat.com>
To: Jiri Benc <jbenc@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 20 Jul 2023 10:43:09 +0200
In-Reply-To: <20230720101743.0318684d@griffin>
References: 
	<0699747bc9bd7aaf7dc87efd33aa6b95de7d793e.1689677201.git.jbenc@redhat.com>
	 <20230719210828.2395436f@kernel.org> <20230720101743.0318684d@griffin>
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

On Thu, 2023-07-20 at 10:17 +0200, Jiri Benc wrote:
> On Wed, 19 Jul 2023 21:08:28 -0700, Jakub Kicinski wrote:
> > On Tue, 18 Jul 2023 12:50:13 +0200 Jiri Benc wrote:
> > > This causes problems in skb_tunnel_check_pmtu, where incorrect PMTU i=
s
> > > cached. If the VXLAN-GPE interface has MTU 1464 set (with the underly=
ing
> > > interface having the usual MTU of 1500), a TCP stream sent over the
> > > tunnel is first segmented to 1514 byte frames only to be immediatelly
> > > followed by a resend with 1500 bytes frames, before the other side ev=
en
> > > has a chance to ack them. =20
> >=20
> > Sounds like we are overly conservative, assuming the header will be
> > larger than it ends up being. But you're saying it leads to oversized,
> > not undersized packets?
>=20
> Sorry for not providing enough details. The packets are actually
> correctly sized, initially. Then a lower, incorrect PMTU is cached.
>=20
> In the collect_md mode (which is the only mode that VXLAN-GPE
> supports), there's no magic auto-setting of the tunnel interface MTU.
> It can't be, since the destination and thus the underlying interface
> may be different for each packet.
>=20
> So, the administrator is responsible for setting the correct tunnel
> interface MTU. Apparently, the administrators are capable enough to
> calculate that the maximum MTU for VXLAN-GPE is (their_lower_MTU - 36).
> They set the tunnel interface MTU to 1464. If you run a TCP stream over
> such interface, it's then segmented according to the MTU 1464, i.e.
> producing 1514 bytes frames. Which is okay, this still fits the lower
> MTU.
>=20
> However, skb_tunnel_check_pmtu (called from vxlan_xmit_one) uses 50 as
> the header size and thus incorrectly calculates the frame size to be
> 1528. This leads to ICMP too big message being generated (locally),
> PMTU of 1450 to be cached and the TCP stream to be resegmented.
>=20
> The fix is to use the correct actual header size, especially for
> skb_tunnel_check_pmtu calculation.
>=20
> Should I resend with more detailed patch description?

I guess there is not such a thing as a "too verbose commit message", so
I would say: yes please!

Thanks!

Paolo


