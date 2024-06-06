Return-Path: <netdev+bounces-101434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C438FE835
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F82BB26707
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 13:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CAE195FDA;
	Thu,  6 Jun 2024 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urQh44tk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AB7EEC5
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717681951; cv=none; b=rrcSN7LdWpOq+KMoWVG7K3fnROxdpw6wL3M1zroIG7N2H4+H2JzKSnSSMzTNp3pMqIyyzIFTy8rMETaf9K3Uc9dqhtDkkGiFyccZNvNoYbwV+8TKyei9qtzDq7f4ujRzrgbojycEA8BbVfa0mphzs/LAk9i/xt0fVfqh1Ss9gJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717681951; c=relaxed/simple;
	bh=hNwBv6OwpSk26mDkpZJqV4SwBMbJaMitj49hn17ikLM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BEQmVUeedwpDO2rAQditxma4b+XyE22pMPDiG4LF94n2BxsO38BTjbR+IO2xJQ2ibu9ZJB2DVv/txQGNxrrBixK9xcu2jQ0oCjB7r0+RCyZd7ON1Osoxx+Et+2wdOa+/kAxZNVvnaHv+BjX746U13NEglln1R7XOaDxEekfi9f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urQh44tk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DD5C2BD10;
	Thu,  6 Jun 2024 13:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717681951;
	bh=hNwBv6OwpSk26mDkpZJqV4SwBMbJaMitj49hn17ikLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=urQh44tkun5DEuRQ6NFpEGWMXSortRArsACCB5MquFk0mBrDkARuykSfTfCxUuKNJ
	 YxWdLuTaRYEDwVAqYxE0JToqze9Wl6IU+sPYAGgUot7W8vMULELMd5VW7Pk+vbi9V8
	 SIzJnwh85aV3hLahCT7/e5+cEaW7SIjspf6hZM7ze7nI3z1b/KPewJfBdV6EBu9cEq
	 qcL6w4NGrqAJBf+w+sLJC8MntL0o92//+lxPPrtHs4qubRII3WCAv2c25/sxnTiq2i
	 a0LpN2YZZ2dNU0/vAqtC8ztB0jGIocPS0RhxoeA77fryHGm8GJ6wcWFVGNh1Zk6OAt
	 +vyIPsXWGLu7A==
Date: Thu, 6 Jun 2024 06:52:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, Jiawen Wu <jiawenwu@trustnetic.com>,
 =?UTF-8?B?5rip56uv5by6?= <duanqiangwen@net-swift.com>
Subject: Re: [PATCH net-next v4 0/6] add sriov support for wangxun NICs
Message-ID: <20240606065229.125314db@kernel.org>
In-Reply-To: <EED7EF04-3358-4E91-BBC5-7B09370F9025@net-swift.com>
References: <3601E5DE87D2BC4F+20240604155850.51983-1-mengyuanlou@net-swift.com>
	<20240605174226.2b55ebc4@kernel.org>
	<EED7EF04-3358-4E91-BBC5-7B09370F9025@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Jun 2024 18:13:07 +0800 mengyuanlou@net-swift.com wrote:
> > You have cut out the ndo_set_vf_* calls but you seem to add no uAPI
> > access beyond just enabling the PCI SR-IOV capability. What's your plan
> > of making this actually usable? It's a very strange submission.  
> 
>  Vf driver(wxvf) will be submitted later, uAPI for virtual network devices will
> be added in it.

I mean the configuration API equivalent to the legacy NDOs.

