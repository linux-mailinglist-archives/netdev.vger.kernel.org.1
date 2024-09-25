Return-Path: <netdev+bounces-129841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FCD986767
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 22:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5D24B211F5
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 20:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1A3145B2D;
	Wed, 25 Sep 2024 20:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdYteVlQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B3F145A11;
	Wed, 25 Sep 2024 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727294743; cv=none; b=KBd2yBNyLZqnMRDsdTMHxh1Ys8KxYpaH+Aeb/6N0rwskTydfDd7+lZsv2OS91ewbL5panV92KRoDGz/4QDEUUrv/+aOZjH9sl263qUphuLLqOPf3pF7eNSj6CKa4lmFxWBOFc1lotPe87LK3b+7IbVIYo6QGcTVxyi9/ZKwQz5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727294743; c=relaxed/simple;
	bh=Mxz2xKAw2ldGvwQwQrMlXkI1Xib/A80r96ylBjo9bNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bjz66Yj49GhgLJEjIQVZwUCnOmwU+oxJ7JlMqYzRN613qRdv36iLjBN1LagS4DZtcxKDjFahI2jt5LMyp29V3ycS+3Aoz4hwTMcJvLkjjOskrqe0fe63d7uZGaWXKAu4stjV6R3vZuBeZpEYKREuu3aefYPYSBX/+/243EONocM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdYteVlQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27810C4CEC3;
	Wed, 25 Sep 2024 20:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727294742;
	bh=Mxz2xKAw2ldGvwQwQrMlXkI1Xib/A80r96ylBjo9bNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UdYteVlQ6xDfUbnxuV76ClVfNkvR4WNtoNW+JNGWteroqeE7Lw9c4H+ifkKbSIKBL
	 T/2LXrXp0gVopVoT9v3HWhNbXcTS6ipUqRDQpImOXXgPMvpbaCoXSpulTg6KwWRE/D
	 ml64xTAGnnby2hscViImWW+Lj1Fk+Kl4vorZiTYsSaOuzmYtlqbemvtwB0oTHDjmxZ
	 zI9WJWo0MhE9VdHlHWqGU1mbxPPNTRc16xyr3w8r/Ag+tSVC8rsSrzHDO2lBvcpcNq
	 V1+sJIt/SX2HDHqUbdJGozgkyWZ2n/qihXUYHrlxyMcJo6C315Gend2pftvp4Cs1R3
	 4wWca1z6zBc1w==
Date: Wed, 25 Sep 2024 21:05:39 +0100
From: Simon Horman <horms@kernel.org>
To: Yan Zhen <yanzhen@vivo.com>
Cc: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] atm: Fix typo in the comment
Message-ID: <20240925200539.GA4029621@kernel.org>
References: <20240925105707.3313674-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925105707.3313674-1-yanzhen@vivo.com>

On Wed, Sep 25, 2024 at 06:57:07PM +0800, Yan Zhen wrote:
> Correctly spelled comments make it easier for the reader to understand
> the code.
> 
> Fix typos:
> 'behing' ==> 'being',
> 'useable' ==> 'usable',
> 'arry' ==> 'array',
> 'receieve' ==> 'receive',
> 'desriptor' ==> 'descriptor',
> 'varients' ==> 'variants',
> 'recevie' ==> 'receive',
> 'Decriptor' ==> 'Descriptor',
> 'Lable' ==> 'Label',
> 'transmiting' ==> 'transmitting',
> 'correspondance' ==> 'correspondence',
> 'claculation' ==> 'calculation',
> 'everone' ==> 'everyone',
> 'contruct' ==> 'construct'.
> 
> 
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>

Hi,

I am curious to know which tree is this based on?
I don't seem to be able to apply it to net-next, linux-net,
or Linus's tree.

