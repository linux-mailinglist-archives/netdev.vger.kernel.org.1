Return-Path: <netdev+bounces-34040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C877A1BA5
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 12:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 439BF28271E
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 10:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC704DF45;
	Fri, 15 Sep 2023 10:03:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673E13229
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 10:03:39 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6CA2D5B
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 03:02:15 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c4194f769fso11901805ad.3
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 03:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694772130; x=1695376930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3KH2+YW7v4I8wYSBljbGut77OcKuVoFvUpQBFbW2nrs=;
        b=ggsondxNU8sqmkDev0+SJWfj/stmkjj/4yv6BWvi9r7Grqu7NF0+hU3OesfJqMTbnz
         OWlMlMYq1VSB+cvbPVdklP6gPnQeEMpCpXjElXAo26orrEeHOEN3mnD/iCz2rB/8Gf2b
         8Xd1mIWq0/qkisHsKJIqwtz0XZ1Lnsum1UwcKRQceaIEIa/QqP1/BAUun6rBcBuiYUE0
         AWjObNlJ+QbDbIQwCo/aTXqBEZWT0ruKza3FqtIGvWctGwdjDhbyZPoB1bbFVh4F1Aod
         RIjxejT5UqxbQvThyAopgQItkGzRqH4gEUCuVTQHluvHcmdIx9CLb4FYXvW0KBlq//yv
         mmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694772130; x=1695376930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KH2+YW7v4I8wYSBljbGut77OcKuVoFvUpQBFbW2nrs=;
        b=wh70mhi/452eCd37NtXc8okLw2ptqWBFgSIWpwEU5AYTE4zn2O/c8m5RzjhKMr3/q6
         wYCr2Xu9fXS6Ue5V27Vim3pQ2iHRn/m/39DBnN5LcLZ1JzFNnBx4lG0jfqPrKV9JLIXh
         ojqMy/mJ7ZPy1PkiXddFNVLfAhPHvf3cf0UxPVxCdG7fi24fe3jCQN5lZ/Z31tkYOEac
         eW3HWKDQvPxA694f9ebrthYM3oV0Zr0TZk7NPMnS7tgQyH9PaIdk9v1DS9/72PrQ/jLz
         ZW4SuPZGZbpJPiiVfwAjJFgZOnsOjK4aR9X7cYbfuVtLvQiZZw4e3zFTxrB7M6xuuMwS
         /4Qg==
X-Gm-Message-State: AOJu0Ywz5FaSNGUdXYE55qGs00wK0etwpH8+t86yIVoF2yfmA2ndgqDn
	a8bfVJW05Q84rd3QNGvbgHc=
X-Google-Smtp-Source: AGHT+IHzJJ9Q8969Tf1W9BN5gtW+npKAfHINHCN19UcjxvcV3CdKDEEjopps9gUHSavQ7FJTIogW7Q==
X-Received: by 2002:a17:902:d512:b0:1b8:525a:f685 with SMTP id b18-20020a170902d51200b001b8525af685mr1175970plg.37.1694772130378;
        Fri, 15 Sep 2023 03:02:10 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902e54a00b001bf10059251sm3085867plf.239.2023.09.15.03.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 03:02:07 -0700 (PDT)
Date: Fri, 15 Sep 2023 18:02:02 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: David Ahern <dsahern@kernel.org>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCH net-next] ipv6: do not merge differe type and protocol
 routes
Message-ID: <ZQQrmiLREiNYtakK@Laptop-X1>
References: <20230830061550.2319741-1-liuhangbin@gmail.com>
 <eeb19959-26f4-e8c1-abde-726dbb2b828d@6wind.com>
 <01baf374-97c0-2a6f-db85-078488795bf9@kernel.org>
 <db56de33-2112-5a4c-af94-6c8d26a8bfc1@6wind.com>
 <ZPBn9RQUL5mS/bBx@Laptop-X1>
 <62bcd732-31ed-e358-e8dd-1df237d735ef@6wind.com>
 <2546e031-f189-e1b1-bc50-bc7776045719@kernel.org>
 <bf3bb290-25b7-e327-851a-d6a036daab03@6wind.com>
 <ZQPAL84/w323CgNT@Laptop-X1>
 <c5a71b96-30aa-4543-2d8e-196a37693254@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5a71b96-30aa-4543-2d8e-196a37693254@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 14, 2023 at 09:08:18PM -0600, David Ahern wrote:
> On 9/14/23 8:23 PM, Hangbin Liu wrote:
> > On Fri, Sep 01, 2023 at 11:36:51AM +0200, Nicolas Dichtel wrote:
> >>> I do agree now that protocol is informative (passthrough from the kernel
> >>> perspective) so not really part of the route. That should be dropped
> > 
> > I'm not sure. Is there any user space route daemon will use this info? e.g. some
> > BGP route daemon?
> 
> It is passthrough information for userspace to track who installed the
> route. It is not part of the route itself, but metadata passed in and
> returned.

Thanks. I will drop this info.

Hangbin

