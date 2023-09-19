Return-Path: <netdev+bounces-34975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A5D7A648B
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 15:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961B528187A
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 13:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3019218641;
	Tue, 19 Sep 2023 13:13:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495FB37C88
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 13:13:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC62F0
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 06:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695129220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RckHjxKJ/DBwzz6iC1sFaYDrVOyjnLoFmkRy7jkyvQ=;
	b=jRLMS/wPCacC/wQHCj7gFWzgIa4dt0Vp+miDbcvbsjj16bACG60f5rP1wRBDkPB0ki0RhE
	73OWaFjTi21mxqH8g+tkYuehJCRF4QC7Own3Urry5U2yCvVsUGGLvkYmZTtyaLMUI5Cyih
	VqnR1/aD45fRbrVxC5195SavUzmdvX0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-abVaxPd8MMGVvRIHGMi3JA-1; Tue, 19 Sep 2023 09:13:38 -0400
X-MC-Unique: abVaxPd8MMGVvRIHGMi3JA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9ae3c044655so6829766b.1
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 06:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695129217; x=1695734017;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2RckHjxKJ/DBwzz6iC1sFaYDrVOyjnLoFmkRy7jkyvQ=;
        b=qIi0enFn4WxbWHmbcK0k5tEb6mPBUwjiHF1rjDRkb45K4cEH3WtKcAFu6HH/ERuGhZ
         ekMolfEfjxIFftticJym4sV8gMiIzgQ0ma+0EuJ3Qa58MLs1CpWZjYeXeGtMA5+YZsL4
         j9fMuSZ9ZwFM0bh+QC7AjIyzhHWTM9XYjr5Qu+kRXdPIQIedT8pwn1NF0f3/RG+Zqmhg
         RpfLcQ+dPQgT5ajPKJ4rqoVc2gvZqAwZ6xd2HW09qbaeW6nCAvhaC29fpDvxHoxG6/HL
         wYe5bBet1lK36cyVmYApoigzSYSrcFV3NOqtEBghH7yRmsSPOV3r0un9ktZXoSz+YkVf
         yb1A==
X-Gm-Message-State: AOJu0YzG3P3o9N+2A3ka500k+Pk2uyMaRD9aoxN0Vai0MMPL1DS+DcMI
	oqHuHRxDKi8RvgtFqaZ8zX+vBL5lvQ5+ySoZHMMQjWQb4DB2lHAgDnBgxu4pSpsrLaDVM15qJY1
	5wiIkpYPc/CdOuYG5
X-Received: by 2002:a17:906:5341:b0:9ad:e66a:413f with SMTP id j1-20020a170906534100b009ade66a413fmr7926872ejo.3.1695129217556;
        Tue, 19 Sep 2023 06:13:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOjZRtj5oGUym5VCX6sEBFHCi1p8R7yHSbCfnhmWdHIxrPoDeN11gLmXKuoL1heM5zbA5+kw==
X-Received: by 2002:a17:906:5341:b0:9ad:e66a:413f with SMTP id j1-20020a170906534100b009ade66a413fmr7926845ejo.3.1695129217203;
        Tue, 19 Sep 2023 06:13:37 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-221.dyn.eolo.it. [146.241.241.221])
        by smtp.gmail.com with ESMTPSA id jx10-20020a170906ca4a00b009ae3e6c342asm145816ejb.111.2023.09.19.06.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 06:13:36 -0700 (PDT)
Message-ID: <ad0a961c523aa50f25380b339e1cb6f50109a5fe.camel@redhat.com>
Subject: Re: [PATCH v3] net: ethernet: ti: am65-cpsw-qos: Add Frame
 Preemption MAC Merge support
From: Paolo Abeni <pabeni@redhat.com>
To: Roger Quadros <rogerq@kernel.org>, davem@davemloft.net,
 edumazet@google.com,  kuba@kernel.org, vladimir.oltean@nxp.com
Cc: horms@kernel.org, s-vadapalli@ti.com, srk@ti.com, vigneshr@ti.com, 
	p-varis@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 19 Sep 2023 15:13:35 +0200
In-Reply-To: <20230918095346.91592-1-rogerq@kernel.org>
References: <20230918095346.91592-1-rogerq@kernel.org>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-09-18 at 12:53 +0300, Roger Quadros wrote:
> Add driver support for viewing / changing the MAC Merge sublayer
> parameters and seeing the verification state machine's current state
> via ethtool.
>=20
> As hardware does not support interrupt notification for verification
> events we resort to polling on link up. On link up we try a couple of
> times for verification success and if unsuccessful then give up.
>=20
> The Frame Preemption feature is described in the Technical Reference
> Manual [1] in section:
> 	12.3.1.4.6.7 Intersperced Express Traffic (IET =E2=80=93 P802.3br/D2.0)
>=20
> Due to Silicon Errata i2208 [2] we set limit min IET fragment size to 124=
.
>=20
> [1] AM62x TRM - https://www.ti.com/lit/ug/spruiv7a/spruiv7a.pdf
> [2] AM62x Silicon Errata - https://www.ti.com/lit/er/sprz487c/sprz487c.pd=
f
>=20
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 150 ++++++++++++
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c    |   2 +
>  drivers/net/ethernet/ti/am65-cpsw-nuss.h    |   5 +
>  drivers/net/ethernet/ti/am65-cpsw-qos.c     | 240 ++++++++++++++++----
>  drivers/net/ethernet/ti/am65-cpsw-qos.h     | 104 +++++++++
>  5 files changed, 454 insertions(+), 47 deletions(-)
>=20
> Changelog:
>=20
> v3:
> - Rebase on top of v6.6-rc1 and mqprio support [1]

I'm unsure if this will require a rebase for the next revision of the
mqprio support. Anyhow the two patches are related, it's probably
better bundle them in a series so that the dep is straight-forward.

When reposting, please insert the target tree in the subject profix
(net-next in this case).

Thanks!

Paolo


