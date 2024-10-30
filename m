Return-Path: <netdev+bounces-140566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D08F89B70A9
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 00:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9624528295D
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 23:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD061E47A6;
	Wed, 30 Oct 2024 23:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAZ0+DEf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525961CB532;
	Wed, 30 Oct 2024 23:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730331958; cv=none; b=bcK+mvMl+J/g6frTS7a1mlsF3b9swjTXG0N9+6hL9VwIAfiryK/md6/CEWHn1y6WiNBbtlPPJgU6Ca2NEHd1NhpHvk+keuXkiobZ0Bk+hp8UTc53INnZhLo3uUwHdPFoIVYO9wLZ5smbdky//XQ8dQtjhO4p8rK8py+vVvxoc4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730331958; c=relaxed/simple;
	bh=uVKYHCM+Y+Nu5MS3tgRaHVxBWJmGqWzpaCVqVuHRkdU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fwjG52RYapS9bKc4ic0Rwx/FONN1YXgB6pSUnjCkyfhmDYRatpFBAtLQg7bEKFJ8aANdmG56jjPAbd+H0CerNAxkImGBA6ROwZhCBxLrkU0B+gyzPvVp9QwTLGHGfm2hFb5sF7paRZY0tQAemdzlVZkXxXc6s3IzFBRyp4ATWYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAZ0+DEf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF94C4DDFC;
	Wed, 30 Oct 2024 23:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730331957;
	bh=uVKYHCM+Y+Nu5MS3tgRaHVxBWJmGqWzpaCVqVuHRkdU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aAZ0+DEf2BxcmWkF70tcn+PVE8tYIBcy1bLklkajzODaNrn6ZLgmOtqptWnY3Q5vJ
	 OYgUgQEGnm2dYcpq/7N2DRky5+DAXaj48Arg6ZPMamCTGOb+UxlmGRA0p8eVFDcqAd
	 TJ+gYcTdxRau42jY72fpjXSmZ3NctJQIhPShqRlTh5vKrpQEtd8W5N0XBzCv4aylA1
	 ns7JSE+i494O1O5NYo1u+MPIXhrtBrv8L6hwMs6KqC4w6wmy6UJAEc1o7EY7jPQnZ7
	 6OxhLKdZdx1VhwSUCuGCnFOfbnItVUvm6oOAOzZ8pxut6obxbwxb0xhezhl4ITdGAT
	 9fzRy8Rar1F8w==
Date: Wed, 30 Oct 2024 16:45:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
 andrew@lunn.ch, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] MAINTAINERS: Remove self from DSA entry
Message-ID: <20241030164556.6fcd9af9@kernel.org>
In-Reply-To: <a66b52f3-f755-47ae-858d-ec784c985a06@gmail.com>
References: <20241029003659.3853796-1-f.fainelli@gmail.com>
	<20241029104946.epsq2sw54ahkvv26@skbuf>
	<20241029003659.3853796-1-f.fainelli@gmail.com>
	<20241029104946.epsq2sw54ahkvv26@skbuf>
	<d7bc3c5f-2788-4878-b6cc-69657607a34c@gmail.com>
	<d7bc3c5f-2788-4878-b6cc-69657607a34c@gmail.com>
	<20241030145318.uoixalp5ty7jv45z@skbuf>
	<a66b52f3-f755-47ae-858d-ec784c985a06@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 09:37:38 -0700 Florian Fainelli wrote:
> > I kinda wish there was a way for people to get recognition for their work
> > in CREDITS even if they don't disappear completely from the picture.
> > Hmm, looking at that file, I do recognize some familiar names who are still
> > active in other areas: Geert Uytterhoeven, Arnd Bergmann, Marc Zyngier...
> > Would you be interested in getting moved there? At least I believe that
> > your contribution is significant enough to deserve that.  
> 
> OK, if you feel this is deserved, sure why not, thanks!

Makes perfect sense to me FWIW, could you make it part of a v2 patch?

