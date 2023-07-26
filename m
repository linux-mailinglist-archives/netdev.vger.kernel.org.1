Return-Path: <netdev+bounces-21474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06050763ACA
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 17:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65F2280D2A
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CA1F9E2;
	Wed, 26 Jul 2023 15:20:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719EE1DA3F
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:20:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A4C94
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 08:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690384818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TfB4MnHU7wOaq39Gfi79NM8bvabdTimuYGs0f51W0MI=;
	b=VkB5Y4HpiA/a95EdnxnygzTtsLC+5WR5I7cwgEvqsTc7OkLJKMUlphhER39mp7p9gNfpkM
	kPZgzGGJ1JsQ0VjF/augzsTgdogSba0MkHjunIFnmuZAWHnljCjJZldOGpVHgBw7cu+ks1
	TkX7zS5AyPiNNemTLvqzZYiz2XRpCJA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-_8IniA0WPEugBaepjQhEAA-1; Wed, 26 Jul 2023 11:20:17 -0400
X-MC-Unique: _8IniA0WPEugBaepjQhEAA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-63c9463c116so17479166d6.0
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 08:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690384817; x=1690989617;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TfB4MnHU7wOaq39Gfi79NM8bvabdTimuYGs0f51W0MI=;
        b=JB08p682bMl73BdAQKcaxzgOjLB4g0izhz1JzS5IlIHqT9MSc25LNXytvBMWCFHGgz
         LsMvdV8tcjUxftSTsaEBaCcHoOflSnato4ph9u4eMB7u8L9Qp4HhaREDqZj1H/iM1WfI
         zgTKFjVNMWLcvIAp8Pqii8guJwZjXyU2e7KH22mgFO204GH/5jybTbJDI6Ecvvw3v11v
         8WMgLtB+mYmi4vijTmAT0ae23Ee6wIIq8Zc66ZJnDSq2tktkKTVRl/ygCh7NkPNQ5gbs
         uGSVboKU4MC+XDAQTIP2Xyng2XGQmrhkJkHW6qxGwDPdp9KWXvVJhc7AYuTJ8WMWF1Ff
         jbkQ==
X-Gm-Message-State: ABy/qLYazI6n2xmmPUbOmYeQDv/LIKRbTlpvju4xbAa3puUbNxzwsH++
	SUAhqYBH0gMUa1WWuYXFgfBl0axuabtiAxo2OsqbiPaMqY1m56s3Do0t+FXkFnD0vLmIBkO9GKe
	K2zhX3muZ+JLU9zah
X-Received: by 2002:a05:6214:509b:b0:63d:2d7e:39f1 with SMTP id kk27-20020a056214509b00b0063d2d7e39f1mr1618585qvb.2.1690384816924;
        Wed, 26 Jul 2023 08:20:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE+h7yvFNeBANsn2r2QuvZPeWcHmYPmNYg397zB+UR7jYKmOTyAoiGJaCdczG6Mv8Nk/O/Fjw==
X-Received: by 2002:a05:6214:509b:b0:63d:2d7e:39f1 with SMTP id kk27-20020a056214509b00b0063d2d7e39f1mr1618560qvb.2.1690384816586;
        Wed, 26 Jul 2023 08:20:16 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-81.dyn.eolo.it. [146.241.225.81])
        by smtp.gmail.com with ESMTPSA id i5-20020a0cf485000000b0063d03e59e07sm2236356qvm.130.2023.07.26.08.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 08:20:16 -0700 (PDT)
Message-ID: <a3870a365d6f43491c8c82953d613c2e69311457.camel@redhat.com>
Subject: Re: [PATCH 09/11] ice: implement dpll interface to control cgu
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, Jonathan Lemon
 <jonathan.lemon@gmail.com>,  "Olech, Milena" <milena.olech@intel.com>,
 "Michalik, Michal" <michal.michalik@intel.com>, 
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>, mschmidt
 <mschmidt@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Bart Van Assche
 <bvanassche@acm.org>
Date: Wed, 26 Jul 2023 17:20:12 +0200
In-Reply-To: <20230725154958.46b44456@kernel.org>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
	 <20230720091903.297066-10-vadim.fedorenko@linux.dev>
	 <ZLk/9zwbBHgs+rlb@nanopsycho>
	 <DM6PR11MB46572F438AADB5801E58227A9B3EA@DM6PR11MB4657.namprd11.prod.outlook.com>
	 <ZLo0ujuLMF2NrMog@nanopsycho>
	 <DM6PR11MB46576153E0E28BA4C283A30A9B3FA@DM6PR11MB4657.namprd11.prod.outlook.com>
	 <ZLpzwMQrqp7mIMFF@nanopsycho> <20230725154958.46b44456@kernel.org>
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
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-07-25 at 15:49 -0700, Jakub Kicinski wrote:
> On Fri, 21 Jul 2023 14:02:08 +0200 Jiri Pirko wrote:
> > So it is not a mode! Mode is either "automatic" or "manual". Then we
> > have a state to indicate the state of the state machine (unlocked, lock=
ed,
> > holdover, holdover-acq). So what you seek is a way for the user to
> > expliticly set the state to "unlocked" and reset of the state machine.
>=20
> +1 for mixing the state machine and config.
> Maybe a compromise would be to rename the config mode?
> Detached? Standalone?

For the records, I don't know the H/W details to any extents, but
generally speaking it sounds reasonable to me that a mode change could
cause a state change.

e.g. switching an ethernet device autoneg mode could cause the link
state to flip.

So I'm ok with the existence of the freerun mode.

I think it should be clarified what happens if pins are manually
enabled in such mode. I expect ~nothing will change, but stating it
clearly would help.

Cheers,

Paolo


