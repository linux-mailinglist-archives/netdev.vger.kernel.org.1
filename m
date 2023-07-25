Return-Path: <netdev+bounces-20952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A290761FD7
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 19:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD1B1C20C66
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 17:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E488125140;
	Tue, 25 Jul 2023 17:10:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2AC3C23
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 17:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2E7C433C7;
	Tue, 25 Jul 2023 17:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690305052;
	bh=0xkL2VzyJE8XpaEm9sLuKZsPT9jlQHS1SEOkHKt2KFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YFK1yFSHufm1PnMxIdC2E1W1jnyd2zckONOEj2SfrQ1zkYxqMz+BfGGWNVDoIhfJ1
	 Vf7mf9ficOMGg4/XvjI5UkrshMK1m4fLlYAvfyesFa7xi3vYYzh8LF3NxvHZzzs9xH
	 V+uQ+2ZqCc3lmKNVoEv0taxPf+kgSTfcKaHM7t2JUKROVES55vG+f15+O69Y8whocT
	 5ITRNjkYUZHctuIPxzi0YklOkAr9BkK7WDYbtq6MjrRxjcV5Vv1BOZ4ewxcd8YYgZL
	 CE6gJuxDaXurqJdXQ2wwv6gvJq9c5CW9WJBntavX/yFRFSe1SnwKl39J8E68eJfha4
	 gTRDcXCKv+y3w==
Date: Tue, 25 Jul 2023 10:10:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: krzk@kernel.org, joe@perches.com, geert@linux-m68k.org,
 netdev@vger.kernel.org, workflows@vger.kernel.org,
 mario.limonciello@amd.com
Subject: Re: [PATCH] scripts: checkpatch: steer people away from using file
 paths
Message-ID: <20230725101051.7287d7cf@kernel.org>
In-Reply-To: <2023072555-stamina-hurray-b95c@gregkh>
References: <b6ab3c25-eab8-5573-f6e5-8415222439cd@kernel.org>
	<20230725155926.2775416-1-kuba@kernel.org>
	<2023072555-stamina-hurray-b95c@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 18:53:48 +0200 Greg KH wrote:
> > This script may break people's "scripts on top of get_maintainer"
> > if they are using -f... but that's the point.  
> 
> Ok, I'll go fix up my local scripts,

Which one? I spotted this in your repo but it already seems
to use patches:

https://github.com/gregkh/gregkh-linux/blob/master/scripts/generate_cc_list

How do you use this, BTW?

> but you should change your subject
> line to say "get_maintainer", not "checkpatch" :)

Ugh, will do :)

