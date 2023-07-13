Return-Path: <netdev+bounces-17639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AB27527CB
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 17:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC54B281D75
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 15:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0076B1F16B;
	Thu, 13 Jul 2023 15:55:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28EB1F163
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 15:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05263C433C8;
	Thu, 13 Jul 2023 15:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689263720;
	bh=aTDQFeJnCth4yhiGkdJtIbFRpdsRRx4M6qGsTSEIjsE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aytymDobKFwO7OsH8ByDpS0qD4T329WMNw35oErlz+OdHzWiCpx8pCt6R4LtgUx1Y
	 KAoqNSJEL6fOnIF3W4jK61tASR3tEOnfYud5qIwssqXHlLvQNov3+FN+3dGDtf5RS6
	 zmCE2TvAcrOfSb1h7DLWBxr5qGYvD9eregs05Z+RfRpVkVK5oCfeIpA+4kaXiLognv
	 I6y+/YiH0VStbO6jqhGRmLzmb1e+PyWvbq0/iEKWwRqJccaTONVGrX6es3fbD4gExJ
	 SYcDB88+YCdnEly0rjzU/qEW393lc8exwmxbV056m2OVVXqxRQdt9fmmFB0j39bYV0
	 BNodIXYB1833g==
Date: Thu, 13 Jul 2023 08:55:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 moshe@nvidia.com
Subject: Re: [patch net-next] devlink: remove reload failed checks in params
 get/set callbacks
Message-ID: <20230713085519.1297db1a@kernel.org>
In-Reply-To: <ZK+9Q/5NC7/eNGH8@nanopsycho>
References: <20230712113710.2520129-1-jiri@resnulli.us>
	<ZK6u8UFXjyD+a9R0@shredder>
	<ZK7EyBcE7sFVvYvh@nanopsycho>
	<20230712122103.4263c112@kernel.org>
	<ZK+9Q/5NC7/eNGH8@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jul 2023 11:00:51 +0200 Jiri Pirko wrote:
> >Feel free to toss in
> >
> >pw-bot: changes-requested  
> 
> I see, is this documented somewhere?

Aha, recently. I try to mark emails with important stuff with [ANN]
maybe we need a better form of broadcast :S

Quoting documentation:

  Updating patch status
  ~~~~~~~~~~~~~~~~~~~~~
  
  Contributors and reviewers do not have the permissions to update patch
  state directly in patchwork. Patchwork doesn't expose much information
  about the history of the state of patches, therefore having multiple
  people update the state leads to confusion.
  
  Instead of delegating patchwork permissions netdev uses a simple mail
  bot which looks for special commands/lines within the emails sent to
  the mailing list. For example to mark a series as Changes Requested
  one needs to send the following line anywhere in the email thread::
  
    pw-bot: changes-requested
  
  As a result the bot will set the entire series to Changes Requested.
  This may be useful when author discovers a bug in their own series
  and wants to prevent it from getting applied.
  
  The use of the bot is entirely optional, if in doubt ignore its existence
  completely. Maintainers will classify and update the state of the patches
  themselves. No email should ever be sent to the list with the main purpose
  of communicating with the bot, the bot commands should be seen as metadata.
  
  The use of the bot is restricted to authors of the patches (the ``From:``
  header on patch submission and command must match!), maintainers of
  the modified code according to the MAINTAINERS file (again, ``From:``
  must match the MAINTAINERS entry) and a handful of senior reviewers.
  
  Bot records its activity here:
  
    https://patchwork.hopto.org/pw-bot.html
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#updating-patch-status

