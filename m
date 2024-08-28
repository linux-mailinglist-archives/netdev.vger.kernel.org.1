Return-Path: <netdev+bounces-122883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F96962FAF
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65CD71C22B72
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 18:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A72156649;
	Wed, 28 Aug 2024 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUG+bdGN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1324114D71E
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 18:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869098; cv=none; b=HGRgOqxnQaAmWXxS2UkRnAahA5h3K20yjDe/lOv5vGyNHNInX2sdqhw22K2OZ8O+ZvLEHHshNnzv6wTGdyrquLJDz/k+sSzGhe+bNXNEy8J3fmmHIPe+PlYHwGyf9XbsbTnDjbMEHg2rhXcbVHBd6tyHlR0UkzIETp72DYCoTco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869098; c=relaxed/simple;
	bh=xVp5pTeBHR5e+XMvuVLL3Pw6+1VNmMwCpEYX9NAFYnA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZjCFDEgwwM6cDAiF6p5KK3hW3dMFxFoLFAEUsMVghrGTzD2F1EalgZ4p5e0n/06VFRRqvgNlQi1c7KTQjEb0onyvvUVU4gpC4rpb+fLdGakAPnv4GvS/IFOARkWmY7/pGrNZl9GpMfcHbaAza+eSHizR1hLSiDwR+ePcgzDf+vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUG+bdGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4ABC4CEC0;
	Wed, 28 Aug 2024 18:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724869097;
	bh=xVp5pTeBHR5e+XMvuVLL3Pw6+1VNmMwCpEYX9NAFYnA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HUG+bdGNP3FzjrnP+y5Bj1WH/UYrTkc6Gd9C6bYBjHPqkQsgyWailsS2Yt9oNmey6
	 P0KRa5tvYlXgvWBsynpcsx5WdTfikkR+TtBHMMZbF8MqC3bjBow0/agVSRZurX45JF
	 kPd4pQvTqYapE/Ta1yKQhkwST4Sk79s86oHS95gteO5NBXUeNMhV5Zv855oGd0s7XD
	 eC1GjjktJBhOmZAoPmOH4vf5kx5uV7bQdnYkf0jRbf8pkb7W8htFTDXSX+YqXndaSM
	 5AoovE//yuDEzCkFOy+TigzY+l84aLaKcjg6H/mnrAu8XbcNAQa+acGmftk1qRdBLh
	 KEvycpJSg8HZQ==
Date: Wed, 28 Aug 2024 11:18:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 alexanderduyck@fb.com, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, kernel-team@meta.com,
 sanmanpradhan@meta.com, sdf@fomichev.me, jdamato@fastly.com
Subject: Re: [PATCH net-next v2 1/2] eth: fbnic: Add ethtool support for
 fbnic
Message-ID: <20240828111816.5749db28@kernel.org>
In-Reply-To: <34c52e04-00aa-4507-9150-0230ce760c9a@gmail.com>
References: <20240827205904.1944066-1-mohsin.bashr@gmail.com>
	<20240827205904.1944066-2-mohsin.bashr@gmail.com>
	<Zs7D5hij6gQOiEGc@mev-dev.igk.intel.com>
	<34c52e04-00aa-4507-9150-0230ce760c9a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 10:49:06 -0700 Mohsin Bashir wrote:
> > Isn't it cleaner to have it in sth like fbnic_ethtool.h file? Probably
> > you will have more functions there in the future.
>
> It would definitely be cleaner if have a large number of functions which 
> isn't the case hence, did not add fbnic_ethtool.h

To further clarify, if I'm grepping right - the more fully featured
"prototype" driver out of tree only exposes this one function from 
fbnic_ethtool.c

Most ethtool functions get hooked in via ops, and ethtool code calls
out, rather than getting called by the driver itself. So it's probably
fine (and I only mean in this particular case, IDK if all the headers
in fbnic are well organized, it's been a while.)

