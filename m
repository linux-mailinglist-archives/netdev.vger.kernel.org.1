Return-Path: <netdev+bounces-19665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F04E75B9B8
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 23:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE6571C21542
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 21:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2401D1BE8F;
	Thu, 20 Jul 2023 21:45:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75B91BE60
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 21:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D149C433C7;
	Thu, 20 Jul 2023 21:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689889505;
	bh=e1310xhq8DUzL3X6BmVQoKMIBVFp6CTMKurK2dIpPiE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kEIQVSafgL15jTNPmvRTSrZP4uvo1vrUWTTaS/Fyw/gJHPHty3uo5OkjyO48kqxei
	 LZqAE4GmOLjYIl65FVRa5czbzzz7DgxlNHBT6SJX+uyIpcAKf21EKJTD7ARVcFLyXQ
	 OXmWie2HW+bRIkVpH6hgNOQYe8vAFMXE4AT6pYqh3oW80mVLE9N1xzhKVOSvIAOhig
	 FgMhExZWooNnbuxsOPQUq4EPL5fh4mpO2v7Ht9+DSN2rrZBkGUOhE2Zz0zwhpoBSBu
	 K9p/aWNOcOxQ+UQBoYXkWi9Nq3YNq4BJWRmWx+Gr+yrWiXpwvcueiH7OtOMwVzeegz
	 LyiBNb6yjof2g==
Date: Thu, 20 Jul 2023 14:45:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: pull-request: bluetooth 2023-07-20
Message-ID: <20230720144504.5f14f58b@kernel.org>
In-Reply-To: <CABBYNZL9puVzX7ELtR7UQGSU1=YFVWfdKWBmcGf4X5m3bRCS3w@mail.gmail.com>
References: <20230720190201.446469-1-luiz.dentz@gmail.com>
	<20230720142552.78f3d477@kernel.org>
	<CABBYNZL9puVzX7ELtR7UQGSU1=YFVWfdKWBmcGf4X5m3bRCS3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jul 2023 14:30:02 -0700 Luiz Augusto von Dentz wrote:
> > One bad fixes tag here, but good enough.
> > Hopefully the big RCU-ifying patch won't blow up :)  
> 
> Weird, I'd run verify-fixes and it didn't show up anything. 

I think it works by checking the git database. If the commit exists 
in your git it will not complain. So you need a somewhat pristine
repo instance to avoid false negatives.

