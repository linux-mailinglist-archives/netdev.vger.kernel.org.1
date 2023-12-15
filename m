Return-Path: <netdev+bounces-57901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A74B81473F
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF012B20E8E
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69076250F3;
	Fri, 15 Dec 2023 11:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OCsZhha1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B572724B57
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 11:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702640846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PV5PO6XaRHGl6j8FZmI00SMb/OM7VurjhwlFY4KX9Mw=;
	b=OCsZhha1gWDGBjMZcvdZEw5OZC5ZyDUjF0dDV6yjq78s2zjW0xpXa0frPsdFnRODieWMos
	zdrSXaLNaZ49U/8v2fRlz/6dSH6lOakc/K6JfCEDp1A76UepyWOMl4CwBphPXEYjrQth6o
	0QVSpo9OVAPJnnNh8pDEJlnmmrifdhc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-Fy9xKDx0PsaPJBo8inMI2g-1; Fri, 15 Dec 2023 06:47:25 -0500
X-MC-Unique: Fy9xKDx0PsaPJBo8inMI2g-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1ef5c7f80cso12076666b.1
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:47:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702640844; x=1703245644;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PV5PO6XaRHGl6j8FZmI00SMb/OM7VurjhwlFY4KX9Mw=;
        b=wpcKlWMWCAu8gmQmK6l5GMRmpVym240oDFAzOogV6v6ludCb1km1z/mq9S8jRSYykR
         Mfd6Xo1bMPjyd1TdTkpY/qAFpHFJWlNuBbFLpLKLlC1sz9oBWUgeDfuRmgddZEmhJXiP
         4Y8TJXvraSKrUtvkGLZ2eMS36px5TlhoQdPnxfCPKNBplxOd/YrW1eQ87QSzJnlm6IRk
         Mopzn6imvuFroGWEfn7v/W7JpUXaUzIhB0CDVEswLcNJnMkJ8RTMR+vW2/fTWIKW1bJ1
         lPR5GGMj0NYLeUpJoQqGTL3ytmV3VAB/sJgR9hQjoFk6IjEbRAVZfhKAGEg46m0QeDct
         Aiqg==
X-Gm-Message-State: AOJu0Yz8V4PMfMWuGqEKkzrvRTK8doOmb78UZaH7ycg4kBruVKL221Ha
	11MB/xjEAwCOXYqwpx7WygduKoEpxKKWcs6JfgUZ1foKFWtov+M0ojyr+Hz3TdbKDgY92HjnYy5
	ZLflEW8uFDrmi4mFe
X-Received: by 2002:a17:907:c003:b0:a1d:6d:1392 with SMTP id ss3-20020a170907c00300b00a1d006d1392mr13164558ejc.1.1702640843996;
        Fri, 15 Dec 2023 03:47:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPygyxbOj1lWrl7m8EK2d8BmH++5xkgLBF6oVmiERRiUftAoRmP26PffAgucb8v5DeVeZkxw==
X-Received: by 2002:a17:907:c003:b0:a1d:6d:1392 with SMTP id ss3-20020a170907c00300b00a1d006d1392mr13164546ejc.1.1702640843656;
        Fri, 15 Dec 2023 03:47:23 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-255-162.dyn.eolo.it. [146.241.255.162])
        by smtp.gmail.com with ESMTPSA id so7-20020a170907390700b00a1f747f762asm9976547ejc.112.2023.12.15.03.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:47:23 -0800 (PST)
Message-ID: <340b7306b5adbdba468c1cf719c912cbeeb12df6.camel@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/5] iavf: Add devlink and
 devlink rate support'
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com, 
 intel-wired-lan@lists.osuosl.org, qi.z.zhang@intel.com, Wenjun Wu
 <wenjun1.wu@intel.com>, maxtram95@gmail.com, "Chittim, Madhu"
 <madhu.chittim@intel.com>, "Samudrala, Sridhar"
 <sridhar.samudrala@intel.com>,  Simon Horman <simon.horman@redhat.com>
Date: Fri, 15 Dec 2023 12:47:21 +0100
In-Reply-To: <7b0c2e0132b71b131fc9a5407abd27bc0be700ee.camel@redhat.com>
References: <20230727021021.961119-1-wenjun1.wu@intel.com>
	 <20230822034003.31628-1-wenjun1.wu@intel.com> <ZORRzEBcUDEjMniz@nanopsycho>
	 <20230822081255.7a36fa4d@kernel.org> <ZOTVkXWCLY88YfjV@nanopsycho>
	 <0893327b-1c84-7c25-d10c-1cc93595825a@intel.com>
	 <ZOcBEt59zHW9qHhT@nanopsycho>
	 <5aed9b87-28f8-f0b0-67c4-346e1d8f762c@intel.com>
	 <bdb0137a-b735-41d9-9fea-38b238db0305@intel.com>
	 <20231118084843.70c344d9@kernel.org>
	 <3d60fabf-7edf-47a2-9b95-29b0d9b9e236@intel.com>
	 <20231122192201.245a0797@kernel.org>
	 <e662dca5-84e4-4f7b-bfa3-50bce30c697c@intel.com>
	 <20231127174329.6dffea07@kernel.org>
	 <55e51b97c29894ebe61184ab94f7e3d8486e083a.camel@redhat.com>
	 <20231214174604.1ca4c30d@kernel.org>
	 <7b0c2e0132b71b131fc9a5407abd27bc0be700ee.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-15 at 12:06 +0100, Paolo Abeni wrote:
> 1) AFAICS devlink (and/or devlink_port) does not have fine grained, per
> queue representation and intel want to be able to configure shaping on
> per queue basis. I think/hope we don't want to bring the discussion to
> extending the devlink interface with queue support, I fear that will
> block us for a long time. Perhaps I=E2=80=99m missing or misunderstanding
> something here. Otherwise in retrospect this looks like a reasonable
> point to completely avoid devlink here.

Note to self: never send a message to the ML before my 3rd morning
coffee.

This thread started with Intel trying to using devlink rate for their
use-case, apparently slamming my doubt above.

My understanding is that in the patches the queue devlink <> queue
relationship was kept inside the driver and not exposed to the devlink
level.

If we want to use the devlink rate api to replace e.g.
ndo_set_tx_maxrate, we would need a devlink queue(id) or the like,
hence this point.

Cheer,

Paolo


