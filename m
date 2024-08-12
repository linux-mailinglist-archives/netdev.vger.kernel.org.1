Return-Path: <netdev+bounces-117767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7439B94F1C8
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 17:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3101B2845DF
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D5F184537;
	Mon, 12 Aug 2024 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yn8CIW1m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F4317C9FC
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476721; cv=none; b=Zy/m0GIk6MmnSvUqqFM04akQKJhY5wssdBbs9+fsh1MwyhwnFq+irFndQM3TbHz92dL+7LianJ7GdFSnv7Ov7NJQmOfI9Tul9u8DXN/V8Eei+dTE0Eq36jhdYuJeYCrbACJHrEx/wRGeTPCZVXyyx2rhxwUIlDyjZ8W09QA5hpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476721; c=relaxed/simple;
	bh=UcWR2CusCaByZobWp/WeaHcehioAaExDFFfsnzfLUf8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uSdAh1Q1Z9NtYjbVxp0XB9IfO/3eLY5ElTQypI3Vxgc5v0uy1r0RE1A5+vZ5ZeLM/cJKnSiwQmEfwy/WLiDeR2TD7PRM4PwbA+wdNuc0e8M2sucXzWIs3TPnb2x+tMlErEbZn0wqJ2SRLaWGmAbEkC04fOe0W8R29sFRj9vBgpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yn8CIW1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0D6C32782;
	Mon, 12 Aug 2024 15:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723476721;
	bh=UcWR2CusCaByZobWp/WeaHcehioAaExDFFfsnzfLUf8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yn8CIW1mPaosK7nHGtfnaMSVA9pNs2ep7hvikxobLX3WUGzXBWHH7eXk+RrjvvEMM
	 rS3vkCRf4+wFJ9nGtaipsAhuS9wQQsspceP/pQuccjerptYWWRyGzfK5E6JUduFBcd
	 BOvFfDeC9qqjxu7v55vRRB1xGhLdzdo+twq4T2GIIYRN6MrRgHVYYzpyOV3kWHl3/o
	 rwZ1A5BGGeS8w26kHqIIlDvVMeUqFJe4lHzkVCNDK1ADen1SnKHt/QrsdRByQdrmxY
	 uYsjI3ISXxXYzHwV14UGwqbdqEQIc5j3JM8XXB3rprqzFr6uhVIiiGIQxvMpTuFLgs
	 CkjQnLM68nOtA==
Date: Mon, 12 Aug 2024 08:31:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Jiri Pirko
 <jiri@resnulli.us>, Madhu Chittim <madhu.chittim@intel.com>, Sridhar
 Samudrala <sridhar.samudrala@intel.com>, John Fastabend
 <john.fastabend@gmail.com>, Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 08/12] testing: net-drv: add basic shaper test
Message-ID: <20240812083159.574940d8@kernel.org>
In-Reply-To: <20240811124053.GI1951@kernel.org>
References: <cover.1722357745.git.pabeni@redhat.com>
	<75fbd18f79badee2ba4303e48ce0e7922e5421d1.1722357745.git.pabeni@redhat.com>
	<29a85a62-439c-4716-abd8-a9dd8ed9e60c@redhat.com>
	<20240731185511.672d15ae@kernel.org>
	<20240805142253.GG2636630@kernel.org>
	<20240805123655.50588fa7@kernel.org>
	<20240806152158.GZ2636630@kernel.org>
	<20240808122042.GA3067851@kernel.org>
	<20240808071754.72be6896@kernel.org>
	<20240808143443.GI3006561@kernel.org>
	<20240811124053.GI1951@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Aug 2024 13:40:53 +0100 Simon Horman wrote:
> > > Excellent idea, let's try it! Could you send a PR to NIPA?  
> > 
> > Yes, can do.  
> 
> For reference, the PR is here:
> https://github.com/linux-netdev/nipa/pull/35

Deployed now, thank you!

