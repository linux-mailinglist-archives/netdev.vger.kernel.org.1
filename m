Return-Path: <netdev+bounces-20957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A85B76200B
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 19:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4679628185A
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 17:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF5125903;
	Tue, 25 Jul 2023 17:25:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE291F932
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 17:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C55CC433C8;
	Tue, 25 Jul 2023 17:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1690305911;
	bh=frHNyIcinIpmwAciC31Q9QcrQ0+n4l7/X8fZGj2IHJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JMauvZ19ALA+OupcIfHyDZyqQw/ELOPRiCGbCqXsAEOzvP168eoah5kOknt939xwr
	 tb1ru9mPdsemdswVGLZ0CbmOnr8+fsypeioPpKrnuh57DD7BjV33KSwtoYdzcT4L+c
	 myT+GJKnsUGorxYLPxgTVXjD5Ll+NC4h/+eCL0KY=
Date: Tue, 25 Jul 2023 19:25:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: krzk@kernel.org, joe@perches.com, geert@linux-m68k.org,
	netdev@vger.kernel.org, workflows@vger.kernel.org,
	mario.limonciello@amd.com
Subject: Re: [PATCH] scripts: checkpatch: steer people away from using file
 paths
Message-ID: <2023072507-smugness-landslide-bd42@gregkh>
References: <b6ab3c25-eab8-5573-f6e5-8415222439cd@kernel.org>
 <20230725155926.2775416-1-kuba@kernel.org>
 <2023072555-stamina-hurray-b95c@gregkh>
 <20230725101051.7287d7cf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725101051.7287d7cf@kernel.org>

On Tue, Jul 25, 2023 at 10:10:51AM -0700, Jakub Kicinski wrote:
> On Tue, 25 Jul 2023 18:53:48 +0200 Greg KH wrote:
> > > This script may break people's "scripts on top of get_maintainer"
> > > if they are using -f... but that's the point.  
> > 
> > Ok, I'll go fix up my local scripts,
> 
> Which one? I spotted this in your repo but it already seems
> to use patches:
> 
> https://github.com/gregkh/gregkh-linux/blob/master/scripts/generate_cc_list

Oh yeah, it does work on patches.  Nevermind, I think I just use the -f
version manually when trying to figure out who to blame for a bug report
in a specific file :)

> How do you use this, BTW?

I do:
	- git format-patch to generate the patch series.
	- run the generate_cc_list script which creates XXXX.info files
	  (the XXXX being the patch number) that contain the
	  people/lists to cc: on the patch
	- git rebase -i on the patch series and edit the changelog
	  description and paste in the XXXX.info file for that specific
	  patch.

Yeah, it's a lot of manual steps, I should use b4 for it, one of these
days...

thanks,

greg k-h

