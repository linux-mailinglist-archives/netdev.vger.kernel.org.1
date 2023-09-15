Return-Path: <netdev+bounces-33997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDB67A13CB
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 04:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7554F281AAA
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 02:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326D97F8;
	Fri, 15 Sep 2023 02:23:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC970A48
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 02:23:51 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0CC2130
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 19:23:50 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c0c6d4d650so14934115ad.0
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 19:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694744630; x=1695349430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1cdP7F3B0fJT11nTRmQGNfjx5Q98729ZE49xkqjuwcM=;
        b=Yf4tMJtc/kfIHct3oRtwJKut9Vi2D0qDQccku+jqMQz9JKGOvC72weIV6EnBZszPkw
         5Hl53ASQmWetJSWqLecCwh0Gk7LEwJZV+HiDxfjop9Tcx3t1opEv9p4N91E028Rn4ryX
         yWHgdQIzEDSwSMn127yaeWAR+06IGeVUkbMnaZT77y0Ap0TGF0rmMVhkMbraS5h85Eev
         l4FDxsA0gKsaw0ovh5ZuNUp8sH+Q8RJbwbg8u2BGrtlbjsADJUm3oPYZz6hSSqi1ymRP
         jv/5xRFM05TIPGImVsqHKjFMeMRkzFEJ9OSiROlQrWhIioolD9R+LUyH8vIdLU6JBgLn
         7noQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694744630; x=1695349430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cdP7F3B0fJT11nTRmQGNfjx5Q98729ZE49xkqjuwcM=;
        b=LaAFe3OZQY+SIf0eYErR6xBfwGrhXVs6XH3Z+LXx0Z9xqIhruJsAA90n62tW7/2G56
         F9Obh3YZBx7/Tp++OREuBnjwAAgf+yPFtR0q1/QuYJct1x745Z5EHSA0ZUMqd54bt03+
         45MzbLhddVpGU+G5Bv34f3OPU7WBqlG/c1jyzQOMHCzp81O6cvlF/AmhKpI6jQpNavlJ
         wMOR2gNGn4LyxQUOr4c0+GYPe4OJuQgnBa3NrHdpiWwDwrWgsIrFbTBVxJis1hMQ97QI
         c9uKXEzA6v0vgG8EyEd5iJJyqpW2cW0anvIYnuVig1Utm5RkvlMKNILkdr0En/8b1mHQ
         Nz/w==
X-Gm-Message-State: AOJu0Yy/F9gbDNwmcU2CeQbn+3RnLMC5KzIvsH6rHu5X9nWFEcufHet4
	wPnHMwklY2EnVjloNKvSqpo=
X-Google-Smtp-Source: AGHT+IF5pgDYQydgphb4ydZrEEdWi5jRYWvPClNRwvAV+n9exWTp5nDQdPXYOQ1o1PDypcw3fvFT4A==
X-Received: by 2002:a17:902:f682:b0:1c2:1068:1f4f with SMTP id l2-20020a170902f68200b001c210681f4fmr405863plg.17.1694744629492;
        Thu, 14 Sep 2023 19:23:49 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902eb4d00b001b04c2023e3sm2245027pli.218.2023.09.14.19.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 19:23:48 -0700 (PDT)
Date: Fri, 15 Sep 2023 10:23:43 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCH net-next] ipv6: do not merge differe type and protocol
 routes
Message-ID: <ZQPAL84/w323CgNT@Laptop-X1>
References: <20230830061550.2319741-1-liuhangbin@gmail.com>
 <eeb19959-26f4-e8c1-abde-726dbb2b828d@6wind.com>
 <01baf374-97c0-2a6f-db85-078488795bf9@kernel.org>
 <db56de33-2112-5a4c-af94-6c8d26a8bfc1@6wind.com>
 <ZPBn9RQUL5mS/bBx@Laptop-X1>
 <62bcd732-31ed-e358-e8dd-1df237d735ef@6wind.com>
 <2546e031-f189-e1b1-bc50-bc7776045719@kernel.org>
 <bf3bb290-25b7-e327-851a-d6a036daab03@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf3bb290-25b7-e327-851a-d6a036daab03@6wind.com>

On Fri, Sep 01, 2023 at 11:36:51AM +0200, Nicolas Dichtel wrote:
> > I do agree now that protocol is informative (passthrough from the kernel
> > perspective) so not really part of the route. That should be dropped

I'm not sure. Is there any user space route daemon will use this info? e.g. some
BGP route daemon?

> > from the patch leaving just a check on rt_type as to whether the routes
> > are different. From there the append, prepend, replace and change
> > semantics should decide what happens (ie., how the route is inserted).
> Right. What can guide us is the meaning/concept/benefit of having this kind of
> routing table:
> local 2001:db8:103::/64 via 2001:db8:101::10 dev dummy1 metric 1024 pref medium
> 2001:db8:103::/64 via 2001:db8:101::10 dev dummy2 metric 1024 pref medium
> 
> I don't understand how this is used/useful. It's why I ask for the use case/goal
> of this patch.
> How does the user know which route is used?

I'm not sure how user will use it. Maybe just block/forward some traffic to
local first and remove the local route later to unblock them. IPv4 can also
do like this. e.g.

+ ip link add dummy1 up type dummy
+ ip link add dummy2 up type dummy
+ ip addr add 192.168.0.1/24 dev dummy1
+ ip addr add 192.168.0.2/24 dev dummy2
+ ip route add local 192.168.3.0/24 dev dummy1 table 100
+ ip route append unicast 192.168.3.0/24 dev dummy1 table 100
+ ip route append unicast 192.168.3.0/24 dev dummy2 table 100
+ ip route show table 100
local 192.168.3.0/24 dev dummy1 scope host
192.168.3.0/24 dev dummy1 scope link
192.168.3.0/24 dev dummy2 scope link

Thanks
Hangbin

