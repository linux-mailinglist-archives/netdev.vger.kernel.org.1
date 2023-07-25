Return-Path: <netdev+bounces-20941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995DF761FA0
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CCE92814BF
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 16:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDDF24190;
	Tue, 25 Jul 2023 16:53:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078ED1F927
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 16:53:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DC2C433C8;
	Tue, 25 Jul 2023 16:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1690304031;
	bh=/A0lTAhkNgSmTXQ0kK7d1Uu8VK32mRbVOq6O0UhXz78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aBgnUHCJLbZN0YsBf/nocQSBJ5MqVJjBTcDslrwRRGnSc3Urhr6kDR3T6CPEkM2pA
	 OIcmZT8hjkweL1uv1zq4zZZRfe5ARMSkS1a+2r9VW4wju/k97YqWLjnV0MPQ0WOL0L
	 WgGoCDoZKVbOEucl9aolF+nvVGOxCewfi+SudSYU=
Date: Tue, 25 Jul 2023 18:53:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: krzk@kernel.org, joe@perches.com, geert@linux-m68k.org,
	netdev@vger.kernel.org, workflows@vger.kernel.org,
	mario.limonciello@amd.com
Subject: Re: [PATCH] scripts: checkpatch: steer people away from using file
 paths
Message-ID: <2023072555-stamina-hurray-b95c@gregkh>
References: <b6ab3c25-eab8-5573-f6e5-8415222439cd@kernel.org>
 <20230725155926.2775416-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725155926.2775416-1-kuba@kernel.org>

On Tue, Jul 25, 2023 at 08:59:26AM -0700, Jakub Kicinski wrote:
> We repeatedly see noobs misuse get_maintainer by running it on
> the file paths rather than the patchfile. This leads to authors
> of changes (quoted commits and commits under Fixes) not getting
> CCed. These are usually the best reviewers!
> 
> The file option should really not be used by noobs, unless
> they are just trying to find a maintainer to manually contact.
> 
> Print a warning when someone tries to use -f and remove
> the "auto-guessing" of file paths.
> 
> This script may break people's "scripts on top of get_maintainer"
> if they are using -f... but that's the point.

Ok, I'll go fix up my local scripts, but you should change your subject
line to say "get_maintainer", not "checkpatch" :)

thanks,

greg k-h

