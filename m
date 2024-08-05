Return-Path: <netdev+bounces-115874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDCE94839A
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 22:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674ED1F2145F
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 20:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7340D14A4C9;
	Mon,  5 Aug 2024 20:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gH/gyd0M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD4D13E881
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722890224; cv=none; b=o7AhC3LUNdeLMiPLD/rU1o/zkJGXiEf+x8q0PjUygmp/M3/d3Gw0+0KaKtEqfSiHJicWpzKjc37kVKuM+KC6s2J+rtPEodbBk3BcW4NEUHoRWGXuUVh0FiBJfnuQmt672HS0CZ0C+ZFQri51WSrMIOBer1DxwVYVI49vp3Bb/O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722890224; c=relaxed/simple;
	bh=FZXrL5H/ygeKGitASkUubBdqJ+TA33dLAOi7WhcmGak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TXBacsE84ZFvyq5J3TrBZ38XEDVSad6v9VKomzJkk2Un2YRn2ut5mIgfSagTS32vhbVAYxxPQXJwxpfCI3AY0pPFt1/7iSFEY8YSXlS7HeJRJmVfReLXrOHK5h0C4zvmCmWgElbeLzNpMOhpe9QgVaonj1cZfT1fszbj8wnEuBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gH/gyd0M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4E3C32782;
	Mon,  5 Aug 2024 20:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722890223;
	bh=FZXrL5H/ygeKGitASkUubBdqJ+TA33dLAOi7WhcmGak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gH/gyd0MEmby1fwbrxEGaL4Ow4m/qEXQV2pI3hzq1U21qOCKsJ/cvLG9IBsXfv3wR
	 fKhOslsdF6vwpvOFM9IcUm1u50skhX7w9FyWsUMYbj7bV/Z9gZXCwcDxkia9hNsHcA
	 6a1mu0Nns8zbjDIZxrK3ujiC1cE02sZIdoFvTp+PyT45Uf89xBnA/R/wW3CQVgyjC9
	 uBLcDL06o+cbLyBiLmKTFcQNipnOQ0grE0G+1LlGCk+RIFhARWMQSMzSYvMCC29/lV
	 adjlGfgMwmNNaqM5TgfuXDtt+QB/7mPOgNr6iihrbl0PXopP8wF9PsZjNRrJhCJyai
	 uxQv7sx+Djsww==
Date: Mon, 5 Aug 2024 13:37:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org, Jiri
 Pirko <jiri@resnulli.us>, Madhu Chittim <madhu.chittim@intel.com>, Sridhar
 Samudrala <sridhar.samudrala@intel.com>, Simon Horman <horms@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Sunil Kovvuri Goutham
 <sgoutham@marvell.com>, Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
Message-ID: <20240805133702.0f7f222c@kernel.org>
In-Reply-To: <e971cd64-9cbf-46d2-89fc-008548d1d211@redhat.com>
References: <cover.1722357745.git.pabeni@redhat.com>
	<13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
	<m25xslp8nh.fsf@gmail.com>
	<07bae4f7-4450-4ec5-a2fe-37b563f6105d@redhat.com>
	<m2v80jnpkd.fsf@gmail.com>
	<e971cd64-9cbf-46d2-89fc-008548d1d211@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Aug 2024 16:35:29 +0200 Paolo Abeni wrote:
> > Perhaps the API would be better if you had:
> > 
> > - shaper-new
> > - shaper-delete
> > - shaper-get/dump
> > - shaper-set
> > - group-new
> > - group-delete
> > - group-get/dump
> > - group-set
> > 
> > If you went with Jakub's suggestion to give every shaper n x inputs and
> > an output, then you could recombine groups and shapers and just have 4
> > ops. And you could rename 'detached' to 'shaper' so that an attachment
> > is one of port, netdev, queue or shaper.  
> 
> I'm unsure I read the above correctly, and I'm unsure it's in the same 
> direction of Jakub's suggestion. AFACS the above is basically the same 
> interface we proposed in the past iteration and was explicitly nacked 
> from Jakub,

To be clear I was against the low level twiddling APIs, where one has to
separately create a mux/group/scheduler and "move" all its children
under it one by one. (due to the problems it creates with atomic
transitions between configurations).

Having shapers separate from the scheduling hierarchy doesn't seem bad,
tho I haven't gone thru all the considerations in my head.

> Additionally, one of the constraint to be addressed here is allowing to 
> setup/configures all the nodes in a 'group' with a single operation, to 
> deal with H/W limitations. How would the above address such constraint?

FWIW I think the naming is the major source of confusion :(

