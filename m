Return-Path: <netdev+bounces-37751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7B07B6F68
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 19:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CFC49281307
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 17:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C413AC3F;
	Tue,  3 Oct 2023 17:17:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8FB30CF2
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 17:17:39 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FEA95
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 10:17:36 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9b2a3fd5764so209955166b.3
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 10:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696353455; x=1696958255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C8Wb6o9Aox30mr6sxib0iHqveLi8E4bOqA781oZiJdY=;
        b=e7J1v4Z0EWgV6ypwSML7QbinRrKKfVZmoyS5xdTbL9FkMH5Wbt1EgPQQ/T9Yx4GZ8A
         9WBwt9bWdm2/lrahFMb7IPUHlF91lYrFCYX9rxfUJGMk5PUcTCGiidiVO0LOD879k5qs
         IrpdKiWnVHd+VLjskUHwJPGFxJcc7ncrz1aX937i3HjqBWwKnVMh/7ou2Hp+pbjkHLyP
         kFjSLcZAQucAT2OUsFaAxTAxWVLj/sCWVYYYxqr42rjxn1NQfZDADkZugcRZRxQKltg3
         Vgkqe3B8jCAhyez75+XaqyJ8WQNs2TO1j4vx/OrfWxYcXlMG3LvfBwiyxB+upqByWcvO
         mJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696353455; x=1696958255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8Wb6o9Aox30mr6sxib0iHqveLi8E4bOqA781oZiJdY=;
        b=a1FtykSu/6LC6uyi23tbwnBmWsmsczLOe1v4CZdQTErIrPTq0tsRRv+jF62/Dexf8Z
         TpkgrdK0XSICY9YMwxO+6xW5d8UR57lfR5htJvXUKvTcpZSgzJv0Hd/w/2xKVtpga9K9
         J+GwrRfV1vb4VoYsOERn9MYRUvbUdDMgYEj4+J9rcLvS6CgGagZvViotaWIjiiA/Jmmq
         /tmsW0/eybgYRZkPThLNO63qgxbUbtn1Viqfy/HUP0V8mywap+X2ZzEKiv1S0lJzA8z2
         fK3sIFsAdh6b1pxFe68lgEO01YcQc8X6N3B+h37+3hxKcTr0AYwuHKLrQwhEyUnZBlgU
         fFwA==
X-Gm-Message-State: AOJu0YxR7iYGnEmAhqAM6w/slnVl1VepM12DXzTHvl0IxsQd6Kaawitz
	JFnhHAtqiRg0ouOGx4h8wjykLA==
X-Google-Smtp-Source: AGHT+IHzMk2YkgHCuwsoCUV0nHZmFSA+esWbcBTXN0DB93ZNr0246mnYzaJY269L5lIxxf2MdGLqFw==
X-Received: by 2002:a17:907:2cf8:b0:9ad:ae3a:ed01 with SMTP id hz24-20020a1709072cf800b009adae3aed01mr11850728ejc.2.1696353455047;
        Tue, 03 Oct 2023 10:17:35 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id i14-20020a170906698e00b009930308425csm1358019ejr.31.2023.10.03.10.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 10:17:34 -0700 (PDT)
Date: Tue, 3 Oct 2023 19:17:33 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org,
	daniel.machon@microchip.com
Subject: Re: [patch iproute2-next v2 3/5] devlink: introduce support for
 netns id for nested handle
Message-ID: <ZRxMrelhKF9QHGrj@nanopsycho>
References: <20230919115644.1157890-1-jiri@resnulli.us>
 <20230919115644.1157890-4-jiri@resnulli.us>
 <3652856a-1cda-c050-04da-fe2204949ff5@gmail.com>
 <ZQnYDVBeuIRn7uwK@nanopsycho>
 <5476af84-7f3d-2895-3be3-83b5abc38485@gmail.com>
 <ZQqfeQiz2OoVHqdS@nanopsycho>
 <ZRa1cu4TlCuj51gD@nanopsycho>
 <ca25c554-4fd9-5db2-655d-a30ffca11d8d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca25c554-4fd9-5db2-655d-a30ffca11d8d@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Oct 03, 2023 at 06:37:31PM CEST, dsahern@gmail.com wrote:
>On 9/29/23 5:30 AM, Jiri Pirko wrote:
>>>> The attribute is a namespace id, and the value is a namespace id. Given
>>>> that, the name here should be netnsid (or nsid - we did a horrible job
>>>> with consistency across iproute2 commands). I have not followed the
>>>> kernel patches to understand what you mean by nested devlink instance.
>>>
>>> Please do that. Again, the netnsid is related to the nested instance.
>>> Therefore I put the "nested_devlink" in the name. Putting just "netnsid"
>>> as you suggest is wrong. Another possibility would be do nest this into
>>> object, but:
>>> 1) I didn't find nice way to do that
>>> 2) We would break linecards as they expose nested_devlink already
>
>well, that just shows I make mistakes as a reviewer. These really long
>command lines are really taxing.

So what do you suggest?

