Return-Path: <netdev+bounces-26446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA031777CAE
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95512282247
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C72220CA9;
	Thu, 10 Aug 2023 15:51:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B084200BC
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 15:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE67C433C8;
	Thu, 10 Aug 2023 15:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691682664;
	bh=1mLxM2cwBzu4CEmkaRoNn++ZOQ+dvHOMD8BKuKYi7Kc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LOtc26X0gHudlfZPsfmYzARQM6dXUgefeDu+UloaMVozEXo+spTAPZ006pWnm+WOu
	 sAHF3v8KuruVNB58VfDLVM6Fy24KMe7Ozjq3ilks643alEKW+RJExad4HBy+5AkVAA
	 /feh/E+z4e5HxhbgxSLngRSCk9b/3Ab1avAh2AE3ux4NHCeuTdXRPilAwwOVCK5Snc
	 w/xLsiMcgWVs/ADwjpVxOb/P5gXe0q6qGvWONb0UpYGh4MCy1abD0lf52Ubi5s/2p4
	 MZKyX2IY0pg2192tT2TamGqfh8mCNqouZFne9WRepRrlCPuTLBBF/3SK6S/YrouTFE
	 kNXWvHuU36NOA==
Date: Thu, 10 Aug 2023 08:51:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Petr Oros <poros@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, "Maziarz, Kamil" <kamil.maziarz@intel.com>,
 "dawidx.wesierski@intel.com" <dawidx.wesierski@intel.com>, "Palczewski,
 Mateusz" <mateusz.palczewski@intel.com>, "Laba, SlawomirX"
 <slawomirx.laba@intel.com>, "Zulinski, NorbertX"
 <norbertx.zulinski@intel.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>
Subject: Re: [PATCH net v2 0/2] Fix VF to VM attach detach
Message-ID: <20230810085102.30b01d62@kernel.org>
In-Reply-To: <38f4dcfd-ccee-3481-a862-58b269bc0acc@intel.com>
References: <20230809151529.842798-1-poros@redhat.com>
	<38f4dcfd-ccee-3481-a862-58b269bc0acc@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Aug 2023 14:52:33 +0200 Przemek Kitszel wrote:
> You have forgot to propagate reviewed-by tags from v1 (Simon's, Jake's, 
> mine)
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> (I'm not sure if I should copy-paste not mine RBs here?)

Not 100% sure either but most of the time I reckon it'd be a good thing.
Higher probability that we may miss a tag than that the person intended
to withdraw it. Just make sure the person who's tag you're copying is
on CC and that you add a link to where the tag was provided.

