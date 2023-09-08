Return-Path: <netdev+bounces-32505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 877227980E4
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 05:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0737F2817AA
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 03:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0B8111B;
	Fri,  8 Sep 2023 03:15:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4231112
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 03:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FDAC433C8;
	Fri,  8 Sep 2023 03:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694142930;
	bh=YI9oy4JFUGjJHtvztst5BjGjDkEa1NQqE3QJ0zjGm0c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pa9U0DEx5lWJNe7GiEA3tf4iH1ObCZmmXnF8NTshEvJbUzfQ5bexbNCDDw4i5UmiP
	 W5OjcrfaKjb2bbRbYAhMBGRHo3yBBAKOTcVpozbvRP2iE408NpBVfxW2AXOU5Q7Xt0
	 23K/ph0e9zGB82uMIj2f/lshiAEF1jiFUserwS/MC3hV1JMnUZ9p37JasOZOHXa71f
	 Vjm+fZnZw4e/cfNjkG7xIX2OFCOI8Bt+Euz+Ap5fh2YgB2LP/Yd3mcXeh7BL07mr0Y
	 Fo15NIlqr5GUOqZa6PHUyQDc1+gsJdGjHdFBuh3kw7wbvQ+JwVgK9dloLii7dvcgiH
	 +bqnI2hL2537g==
Message-ID: <335e2969-db4c-f48d-7316-b4aa66c769ff@kernel.org>
Date: Thu, 7 Sep 2023 21:15:29 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] don't assume the existence of skb->dev when trying to
 reset ip_options in ipv4_send_dest_unreach
Content-Language: en-US
To: Kyle Zeng <zengyhkyle@gmail.com>, Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, ssuryaextr@gmail.com
References: <ZPk41vtxHK/YnFUs@westworld>
 <ecde5e34c6f3a8182f588b3c1352bf78b69ff206.camel@redhat.com>
 <ZPpUfm/HhFet3ejH@westworld>
 <CADW8OBuq2y8txXKXkVJSbKFFs5B3LDX667OAJHn-p0BeOZDy5Q@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CADW8OBuq2y8txXKXkVJSbKFFs5B3LDX667OAJHn-p0BeOZDy5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> 
> Sorry for the typo in the previous patch. I fixed it and tested it.
> My proof-of-concept code can no longer trigger the crash.
> The patch is attached to this email.
> 

Send as a standalone patch, not an attachment.


