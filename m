Return-Path: <netdev+bounces-40059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 033747C5969
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 18:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA22B281277
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BFC1BDF4;
	Wed, 11 Oct 2023 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNnlo3EU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96DA1B29B
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05384C433C7;
	Wed, 11 Oct 2023 16:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697042645;
	bh=YySPYrJ/MfP9LrleDaoRd1fbQGRt2BgrKgAh+p0DdmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fNnlo3EUauZZN2Hjz0mrjshE7icIMgPSaC0eGM5NvlfiZ26OrqO3Sg84FgNFcW969
	 4Q/JIgj2BGhMwScQJCiUM2szrL6mkWAvGnpL95eemR/ICjO2DYTk9MnA2FJrQtEC5l
	 Q/DVxOZlLnlhG5KQtSYlz8xV7u6wNRGtL50wpCBGirSCEkdpNOYzlGh/4vdNJMU7E4
	 Ot9DfKbGycDSOpxEWiX4XO0A1qSlwzTJuZm9/EiDJqrfYOyLqAY0KpQL27OImXOfBf
	 YqEcEIXb9UJcG8WLRmOCUWoPlFwM9Y098VVzaWqEwHrmECIyeu9K3by3zOBGlrc0zt
	 jJuEtol2xoFNA==
Date: Wed, 11 Oct 2023 09:44:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com, johannes@sipsolutions.net
Subject: Re: [patch net-next 05/10] netlink: specs: devlink: fix reply
 command values
Message-ID: <20231011094404.0acb9c0a@kernel.org>
In-Reply-To: <ZSY666H7J9eq/Ext@nanopsycho>
References: <20231010110828.200709-1-jiri@resnulli.us>
	<20231010110828.200709-6-jiri@resnulli.us>
	<20231010115935.58b4b2ea@kernel.org>
	<ZSY666H7J9eq/Ext@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Oct 2023 08:04:27 +0200 Jiri Pirko wrote:
>> Still, I think this needs net.  
> 
> It affects only userspace generated code, that's why I didn't bother. 
> If you insist, I can send separate patch to net.

Yes, please.

