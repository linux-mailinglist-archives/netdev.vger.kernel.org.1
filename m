Return-Path: <netdev+bounces-40565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E17A7C7AD2
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 02:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D757AB207D0
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 00:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2891536C;
	Fri, 13 Oct 2023 00:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qs9C+NF0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0233A807
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 00:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DAAC433C7;
	Fri, 13 Oct 2023 00:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697156710;
	bh=vYkp6S4mPHu+UOe0+k56WulsJR2DvdGtmQXagstNZWM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qs9C+NF0wHnG3RoCkga8h1Ie6rkHFdgrs9DYr0AXo2276uGFB/iI0MrnzolpsHp6w
	 DcDITQaRxHyiLzKSJiHR9xWZPB73KE2toKZH7xII4J/++AeOn+3U6NO1oRIa/pXkw6
	 VxuT6/5lsR9vnJYHWUdAmkgcYLbSpkjZqlTLAnP4cgItEBb6dN8GBLK1mYnfgRr5cr
	 wg6biH39YQkTLNrn2+EnL0EmhNtrS1L3m0lZRu8WY5kHyzkoEkNUsVO6IsH1r0u/Ft
	 T/RFyXLhGdqU4Nn0/jG1lrRuI3IcnVMgWEcoZLNmf6lEnxNhGQp9bDXPeFfTXyeSGD
	 IqDmCCxH5hggg==
Date: Thu, 12 Oct 2023 17:25:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com, johannes@sipsolutions.net
Subject: Re: [patch net-next 02/10] tools: ynl-gen: introduce support for
 bitfield32 attribute type
Message-ID: <20231012172509.6750c116@kernel.org>
In-Reply-To: <ZSe8SGY3QeaJsYfg@nanopsycho>
References: <20231010110828.200709-1-jiri@resnulli.us>
	<20231010110828.200709-3-jiri@resnulli.us>
	<20231010115804.761486f1@kernel.org>
	<ZSY7kHSLKMgXk9Ao@nanopsycho>
	<20231011095236.5fdca6e2@kernel.org>
	<ZSbVqhM2AXNtG5xV@nanopsycho>
	<20231011112537.2962c8be@kernel.org>
	<ZSe8SGY3QeaJsYfg@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Oct 2023 11:28:40 +0200 Jiri Pirko wrote:
>> all in all there aren't very many new uses. So I think we should
>> put it in legacy for now. Maybe somehow mark it as being there due
>> to limited applicability rather than being "bad"?  
> 
> I think it is odd, but if you insists, sure. Your the boss.

Just to be clear here - we're talking about what goes into which
level of compatibility within YNL. So yes, I wrote YNL, I'd prefer 
to retain the ability to make some decisions about it :(

