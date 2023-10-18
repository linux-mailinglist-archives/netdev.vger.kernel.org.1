Return-Path: <netdev+bounces-42175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4037CD780
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 11:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C71281D23
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 09:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2662016427;
	Wed, 18 Oct 2023 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXlHpxGb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2A611723
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 09:05:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6C3FA
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 02:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697619943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gEm71X05WQCyygZ0rmv92ezDsyn3wLuZrAD37Y+vW98=;
	b=WXlHpxGb6ScPRMwmInPxXeAfOvsR9xstsUKspY7eE5CGBCAm3nlH1qSe4t+lBXOtLwjALy
	3Uf/0cPFCMOWctn1WyLnXBZgdNkuELquxXAtryuoQhC3fOBB8fI3zIJModx1MsJhCgxHOQ
	o8KWyeM0VllLX9f9YcwMMd0v53fg290=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-UlJKYVkJMmSAmRhfMpijvg-1; Wed, 18 Oct 2023 05:05:42 -0400
X-MC-Unique: UlJKYVkJMmSAmRhfMpijvg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-66d3f71f49cso9978106d6.1
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 02:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697619941; x=1698224741;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gEm71X05WQCyygZ0rmv92ezDsyn3wLuZrAD37Y+vW98=;
        b=SoHdNLPT3jHvZVTF8zlzlpwTGEOJITUBlS43aTa32WoJ10OwZ0PeeaPdjmQxLdWX/1
         uEPZvmZ9kdD8raZIZtdaFrOmKjqhN7psb/8HtT1om1DB7F108tJLCfPPVpH0/8KOt972
         WrYlFHkLRTGr/Wz+gCpT0LlefLsVIiPnBCBkA7dC5bTv2dKOkY1JB9yTFxl9/z2tGOX7
         He2DxXCBXMxEui8Z18cvpACcAK6W7uMhoLkjC4FhO1HZbLh402RfO8ud9mdta0daTDjI
         UhPBHWSOFBSXHm/o2jgEVLSA245d7/Ahhe6YVItElu0Kb3h8zYtjUiTPf0zWBN0kqo1P
         K0rg==
X-Gm-Message-State: AOJu0YxJF2c+6nz5YZm6rTd21GUe//LJnrqNUOQFqWrZRFaF6gOO0gfe
	Nltj0TlWatcxtfxsh0KkzAvSnY1ITbX5h1y0T9Fgha57stdYhB6JdOQN9eGn/8fXwKkmUDV3nuU
	lmD2b1Toy/j4NDuHn
X-Received: by 2002:a0c:f7c7:0:b0:66d:1bbb:e9f8 with SMTP id f7-20020a0cf7c7000000b0066d1bbbe9f8mr4770819qvo.6.1697619941404;
        Wed, 18 Oct 2023 02:05:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKS7qvA0SdVIifPNG1JkmCV1vJXnefb9EK4cxDwGzoc929Nn43NfbeAkPWGwCvjkfURYgBIg==
X-Received: by 2002:a0c:f7c7:0:b0:66d:1bbb:e9f8 with SMTP id f7-20020a0cf7c7000000b0066d1bbbe9f8mr4770810qvo.6.1697619941068;
        Wed, 18 Oct 2023 02:05:41 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-239-50.dyn.eolo.it. [146.241.239.50])
        by smtp.gmail.com with ESMTPSA id mg8-20020a056214560800b0066cf6f202cdsm1207893qvb.122.2023.10.18.02.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 02:05:40 -0700 (PDT)
Message-ID: <f586e275750b33feb347e2ba8484a338bc5a8585.camel@redhat.com>
Subject: Re: [PATCH iwl-next v4 0/5] iavf: Add devlink and devlink rate
 support'
From: Paolo Abeni <pabeni@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, Wenjun Wu <wenjun1.wu@intel.com>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	madhu.chittim@intel.com, qi.z.zhang@intel.com, anthony.l.nguyen@intel.com, 
	"Zhang, Xuejun" <xuejun.zhang@intel.com>
Date: Wed, 18 Oct 2023 11:05:37 +0200
In-Reply-To: <ZOcBEt59zHW9qHhT@nanopsycho>
References: <20230727021021.961119-1-wenjun1.wu@intel.com>
	 <20230822034003.31628-1-wenjun1.wu@intel.com> <ZORRzEBcUDEjMniz@nanopsycho>
	 <20230822081255.7a36fa4d@kernel.org> <ZOTVkXWCLY88YfjV@nanopsycho>
	 <0893327b-1c84-7c25-d10c-1cc93595825a@intel.com>
	 <ZOcBEt59zHW9qHhT@nanopsycho>
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
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

please allow me to revive this old thread...

On Thu, 2023-08-24 at 09:04 +0200, Jiri Pirko wrote:
> > Wed, Aug 23, 2023 at 09:13:34PM CEST, xuejun.zhang@intel.com wrote:
> > > >=20
> > > > On 8/22/2023 8:34 AM, Jiri Pirko wrote:
> > > > > > Tue, Aug 22, 2023 at 05:12:55PM CEST,kuba@kernel.org  wrote:
> > > > > > > > On Tue, 22 Aug 2023 08:12:28 +0200 Jiri Pirko wrote:
> > > > > > > > > > NACK! Port function is there to configure the VF/SF fro=
m the eswitch
> > > > > > > > > > side. Yet you use it for the configureation of the actu=
al VF, which is
> > > > > > > > > > clear misuse. Please don't
> > > > > > > > Stating where they are supposed to configure the rate would=
 be helpful.
> > > > > > TC?
> > > >=20
> > > > Our implementation is an extension to this commit 42c2eb6b1f43 ice:=
 Implement
> > > > devlink-rate API).
> > > >=20
> > > > We are setting the Tx max & share rates of individual queues in a V=
F using
> > > > the devlink rate API.
> > > >=20
> > > > Here we are using DEVLINK_PORT_FLAVOUR_VIRTUAL as the attribute for=
 the port
> > > > to distinguish it from being eswitch.
> >=20
> > I understand, that is a wrong object. So again, you should use
> > "function" subobject of devlink port to configure "the other side of th=
e
> > wire", that means the function related to a eswitch port. Here, you are
> > doing it for the VF directly, which is wrong. If you need some rate
> > limiting to be configured on an actual VF, use what you use for any
> > other nic. Offload TC.

I have a doubt WRT the above. Don't we need something more/different
here? I mean: a possible intent is limiting the amount of resources (BW
in the VF -> esw direction) that the application owing the VF could
use.

If that is enforced via TC on the VF side (say, a different namespace
or VM), the VF user could circumvent such limit - changing the tc
configuration - either by mistake or malicious action.=20

Looking at the thing from a different perspective, the TX B/W on the VF
side is the RX B/W on the eswitch side, so the same effect could be
obtained with a (new/different) API formally touching only eswitch side
object.=C2=A0WDYT?

Thanks,

Paolo



