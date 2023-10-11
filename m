Return-Path: <netdev+bounces-39904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719717C4CC7
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 10:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3D7282047
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 08:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8435B19BCC;
	Wed, 11 Oct 2023 08:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pz4t2y1U"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F1619BBB
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 08:15:04 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CBF9C
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 01:15:00 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4056ce55e7eso61219065e9.2
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 01:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697012099; x=1697616899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vtpagy2FOAC+A5GQkeyxkxyJtI+owSgz6W8MfKmR89U=;
        b=pz4t2y1UiskQpLcGhsbTsrF16V7Kyf1HXEd56nBXlVdKfmGiI06BaByidA1HhhokTV
         r8wxkysmhnyCxIdaEgOJtI9AeTp3kR37I99Iqoze9TENa+L4ldSOsaiV8VX9/awiiWJf
         Ms1NuqqrVK1GKVZ5t/tmOqHTV+MZUbyP6Y6pdvJ4BUJ7nCARXiQM4+Ce9ITD17XDKBTj
         cP2mV9h5KFayo9zKGfyQQbmEkK4w4O0sD4O/V2k/FhWGG2s8YfDq3Ciq2qyTAORv2qxB
         1ebmbjGbWpKczc9+nPmiZIWpy6zCoZJtXkW/y/lEFqEaIE1hp46X1+GwFkZ6d03y9X73
         8QYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697012099; x=1697616899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtpagy2FOAC+A5GQkeyxkxyJtI+owSgz6W8MfKmR89U=;
        b=WQdVkpKEK92NgcfgHydly3zzhzwBbsuLvKFrjWNkdI8lj9D7Yo46axH84iTFhps9vi
         FRRBk6YkJkEzGJo5r1LaPPdOTLOvsufedbXCzcZbl9Hdy0p2bfHqP+ytAbf6vv6Z+ntm
         GnCMPkfyeuNZMRj0TtAzeqy5rqd2Tgma7k4YqYBIqaqiq4wQmyu2xRGHgX4O7ILDZV+p
         758sSUVlEYcfDigPecIxBEAAz1JR7DCdyqXZQjrns/mkXYnOOOYByDOrhhnAXUyCtyTS
         g2vndNoSX03tr7YGLZFp6mUW81EUOp+6M4quXtgA2QS/RRs8UGGhDenZEyM60DRdbdMl
         hxOA==
X-Gm-Message-State: AOJu0YwlZt281a7GIlebcyClJQ7Ha1Qyj6GR3IshjjXqL4kqRbl9kQQh
	u3jF7TyYaNwJ9vXfCJZKFnBLQw==
X-Google-Smtp-Source: AGHT+IH+nFbUIrVmTEv6gMfTbmCrdI4fJezaJJy9xkJMds1ntqxtbKt+3p2wLJX84bwnz9RfZSqaUg==
X-Received: by 2002:adf:f641:0:b0:31f:b6ea:af48 with SMTP id x1-20020adff641000000b0031fb6eaaf48mr17486391wrp.49.1697012098954;
        Wed, 11 Oct 2023 01:14:58 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v6-20020adff686000000b0031980294e9fsm14561839wrp.116.2023.10.11.01.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 01:14:57 -0700 (PDT)
Date: Wed, 11 Oct 2023 11:14:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Xin Tan <tanxin.ctf@gmail.com>, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-XXX] SUNRPC: Add an IS_ERR() check back to where it
 was
Message-ID: <38b1b94c-3ab1-4fb5-ad8c-946756262bdb@kadam.mountain>
References: <356fb42c-9cf1-45cd-9233-ac845c507fb7@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <356fb42c-9cf1-45cd-9233-ac845c507fb7@moroto.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Obviously net-XXX is not what I intended.  This applies to the nfs tree
I think.

regards,
dan carpenter


