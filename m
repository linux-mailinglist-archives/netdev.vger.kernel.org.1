Return-Path: <netdev+bounces-14960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92BA744981
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 16:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCD881C208D1
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 14:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45EAC138;
	Sat,  1 Jul 2023 14:04:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE66BE61
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 14:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CB9C433C7;
	Sat,  1 Jul 2023 14:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688220292;
	bh=0a1wkf4GkN7YqEKDNpJPawNYSozTD0sDD+H2t8RHceM=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=aMncBe0VSmxeusUZeIgGx4gUCKD/0t2v7nOgvwWenADjRK56VhBvzT2z8pV9pQvli
	 QB8F3vSwpWhzje62Sw/zgsrd65ZjbB2ECoPXaRswE0lpXnfU9SVCB9QMpF1QHQkhOe
	 OsjBaN1M4hrjfcobckwSDNTCNN/gqAnkdLbQeqqazVzPnD8ttghF8pRJc9cqDG/baI
	 Xa+IVZn8YC2QXExmB4W4PbeVacsGpwhe5qJUV7smvrdPaNPD6bPfX4AhzxaLjL7+nf
	 b/WbahouV9D4+MfQl6oKzmoiijV3kd49jlJkvYqB4nv/iAXDOiR1YLHgRF7pgP7JBA
	 cG2T4AUyjvERA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4126FBC0943; Sat,  1 Jul 2023 16:04:50 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [ANN] pw-bot now recognizes all MAINTAINTERS
In-Reply-To: <20230630085838.3325f097@kernel.org>
References: <20230630085838.3325f097@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Sat, 01 Jul 2023 16:04:50 +0200
Message-ID: <871qhreni5.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Hi!
>
> tl;dr pw-bot now cross references the files touched by a *series* with
> MAINTAINERS and gives access to all patchwork states to people listed
> as maintainers (email addrs must match!)
>
>
> During the last merge window we introduced a new pw-bot which acts on
> simple commands included in the emails to set the patchwork state
> appropriately:
>
> https://lore.kernel.org/all/20230508092327.2619196f@kernel.org/
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#updating-patch-status
>
> This is useful in multiple ways, the two main ones are that (1) general
> maintainers have to do less clicking in patchwork, and that (2) we have
> a log of state changes, which should help answer the question "why 
> is my patch in state X":
>
> https://patchwork.hopto.org/pw-bot.html
>
> The bot acts automatically on emails from the kbuild bot. Author of 
> the series can also discard it from patchwork (but not bring it back).
> Apart from that maintainers and select reviewers had access rights
> to the commands. Now the bot has been extended to understand who the
> maintainers are on series-by-series basis, by consulting MAINTAINERS.
> Anyone who is listed as a maintainer of any files touched by the series
> should be able to change the state of the series, both discarding it
> (e.g. changes-requested) and bringing it back (new, under-review).
>
> The main caveat is that the command must be sent from the email listed
> in MAINTAINERS. I've started hacking on aliasing emails but I don't
> want to invest too much time unless it's actually a problem, so please
> LMK if this limitation is stopping anyone from using the bot.

Very cool! Follow-up question: are you expecting subsystem maintainers
to make use of this, or can we continue to rely on your benevolent
curation of patchwork states and only consider this an optional add-on? :)

Also, this only applies to the netdevbpf patchwork instance, right?

-Toke

