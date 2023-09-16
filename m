Return-Path: <netdev+bounces-34322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340F07A317B
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 18:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FE2F1C209AF
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 16:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C5A18E27;
	Sat, 16 Sep 2023 16:48:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55EB12B9A
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 16:48:00 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C70ECE0
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 09:47:58 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52c4d3ff424so3780884a12.0
        for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 09:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1694882876; x=1695487676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ejZyk1D+Wp2SXvuf4rFgBU6uIbrjoPbkU5t2XjSkEwU=;
        b=JeqG/bZH297Z8e0o62CRFFd2qPh9cq8katULmy1/Fbv8oQykcXQmifh6mmHz0HVVVr
         VNbONpKqqlVyCgn0tojmsFCrU8s7nliY68xKubvjyNonkXRqGCA9RvlkSqzm7eQxXTwk
         ANfAOb32C3Kxtq7R8IQlZdm14WKO03eVY4LHlCKwyAniqoZKtq6vYJR+EnlT7c6oQOZA
         3/wlF1JnB16y1MxbSy4pD1dmqD0bfSAq8KKm15LbJUBvwwR68ocIPW69dseAJYjd7tDc
         5pkRszmw3MqcMDYn3+inatTkBnoDuoTSSzHEK3GDXIax1IlVphNdoSooFxzJIY/392TH
         PXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694882876; x=1695487676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejZyk1D+Wp2SXvuf4rFgBU6uIbrjoPbkU5t2XjSkEwU=;
        b=xUf5pywqrC04n0lCNSU/gK6WrpupjshSUwiijgaxgtoo5/8Mpaev8pw6P1iKF8dQEv
         HOyE26QxdGXs499XJE7nhInwOSRPNtQvBL16nxzTBAsnzDxcwZ5Hb035j2b/HJtO0yOq
         wff7zAc+k2MF+JvpMNSsulIMIlBb4hD3PcsYbLrR3nM/vKh1+bPcr9Y0NvBVBrprZFS3
         AZfe1K57I/Ldv/04qt53hR7MjFMVwJ9CiJ058z/NLNMmNV1o8eHl9QcU40wWjtG4fj7B
         G/3qBFfb+lgWBmX/I9m9BazriLBUbBzIy22XPsfdSmn2AfgfXUZD+HzV8Ym8jRJmaf7p
         45tg==
X-Gm-Message-State: AOJu0YxszJy1PjC6aqb67vY/cYwZcCeFCatUQjYQ1qaVjYIBsf1Okhtl
	KpaZZtO4HLjEQsVbx2JZ+DZGmQ==
X-Google-Smtp-Source: AGHT+IHV1Cr/15N093RlXPwD11x1/13mxPo2WpxyyCCTPnijQVC7KlL4vLJlaf015N6YMmQuCxKH4w==
X-Received: by 2002:aa7:df07:0:b0:525:ce69:b52d with SMTP id c7-20020aa7df07000000b00525ce69b52dmr4380676edy.39.1694882876100;
        Sat, 16 Sep 2023 09:47:56 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id m24-20020aa7d358000000b005231e1780aasm3649224edr.91.2023.09.16.09.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 09:47:55 -0700 (PDT)
Date: Sat, 16 Sep 2023 18:47:54 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com,
	syzbot+1c71587a1a09de7fbde3@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] net: team: get rid of team->lock in team module
Message-ID: <ZQXcOmtm1l36nUwV@nanopsycho>
References: <20230916131115.488756-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230916131115.488756-1-ap420073@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sat, Sep 16, 2023 at 03:11:15PM CEST, ap420073@gmail.com wrote:
>The purpose of team->lock is to protect the private data of the team
>interface. But RTNL already protects it all well.
>The precise purpose of the team->lock is to reduce contention of
>RTNL due to GENL operations such as getting the team port list, and
>configuration dump.
>
>team interface has used a dynamic lockdep key to avoid false-positive
>lockdep deadlock detection. Virtual interfaces such as team usually
>have their own lock for protecting private data.
>These interfaces can be nested.
>team0
>  |
>team1
>
>Each interface's lock is actually different(team0->lock and team1->lock).
>So,
>mutex_lock(&team0->lock);
>mutex_lock(&team1->lock);
>mutex_unlock(&team1->lock);
>mutex_unlock(&team0->lock);
>The above case is absolutely safe. But lockdep warns about deadlock.
>Because the lockdep understands these two locks are same. This is a
>false-positive lockdep warning.
>
>So, in order to avoid this problem, the team interfaces started to use
>dynamic lockdep key. The false-positive problem was fixed, but it
>introduced a new problem.
>
>When the new team virtual interface is created, it registers a dynamic
>lockdep key(creates dynamic lockdep key) and uses it. But there is the
>limitation of the number of lockdep keys.
>So, If so many team interfaces are created, it consumes all lockdep keys.
>Then, the lockdep stops to work and warns about it.

What about fixing the lockdep instead? I bet this is not the only
occurence of this problem.


>
>So, in order to fix this issue, It just removes team->lock and uses
>RTNL instead.
>
>The previous approach to fix this issue was to use the subclass lockdep
>key instead of the dynamic lockdep key. It requires RTNL before acquiring
>a nested lock because the subclass variable(dev->nested_lock) is
>protected by RTNL.
>However, the coverage of team->lock is too wide so sometimes it should
>use a subclass variable before initialization.
>So, it can't work well in the port initialization and unregister logic.
>
>This approach is just removing the team->lock clearly.
>So there is no special locking scenario in the team module.
>Also, It may convert RTNL to RCU for the read-most operations such as
>GENL dump but not yet adopted.
>
>Reproducer:
>   for i in {0..1000}
>   do
>           ip link add team$i type team
>           ip link add dummy$i master team$i type dummy
>           ip link set dummy$i up
>           ip link set team$i up
>   done
>

