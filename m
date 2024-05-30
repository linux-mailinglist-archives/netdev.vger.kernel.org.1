Return-Path: <netdev+bounces-99507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6603A8D5128
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 19:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 058041F22C6F
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB9047A6A;
	Thu, 30 May 2024 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vChPCKvt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F65047A48;
	Thu, 30 May 2024 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717090884; cv=none; b=aQCcKrLpesilZVAOwRsozapbQP3S6e0cqq24eF7FXFs2XQDa6sT6+1XN+0zSxinyaORe8bbTNbWIvwOeOxq6bXlXqEEtzIOci/Ki8SKBf1DZ6Ukwto/KN3DaCjqHB9PPIW3t5RGohkb1ZqCY4sIsgBEWff5EKIktEEBAoDqnFvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717090884; c=relaxed/simple;
	bh=roopk3FiU1nx6Bdq/8QcRdRvLfPTi/USsK3xuA13g84=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pC9Aoup+Xqh+DxTGL4WEVAPmms/+i/oYLjoiMsQO7OfZqVSL6pLQyM+zyTtQX0fyPyWayG91KhqdW8VtvosSOUPebfjL6/ZCfCF89pPuqaRk0mkwr4X00O9oxdAWOlD6hwSOi8xjlXm/tZUlo0m85zalOWlGTQbjlU+USPJ0UPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vChPCKvt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B2DC2BBFC;
	Thu, 30 May 2024 17:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717090884;
	bh=roopk3FiU1nx6Bdq/8QcRdRvLfPTi/USsK3xuA13g84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vChPCKvtPCAaZ+7nEOZQWZ90NoIQzTq2+Hq9CSPOefEkG5Ff8l1CCtVhwE2NnQIbS
	 PcojaCkUYT73x3yPltxqaaMQRoZ7hpbcFOpkBeWMgaKx1hYYgNc8QH/zmCklwDgPjg
	 MkWULHEKtJGdA62HdwRMrtGGNRX19gszgtMzQetge0wIyoEBYf0tKUJ0NdJLear5lM
	 H8/27hSYU7plgnUAxmIg6EhteyWdi/XtAG38SeLLWy3FKIBMFT6C531et7WjSfPFia
	 x11HfTWjx4SpOVdClHeYrW0OzrvWJDScA8MODPf7aj2G184Uq48qiO7qoIeNOK0z2f
	 XS3Qm+fiaijQQ==
Date: Thu, 30 May 2024 10:41:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [TEST] Flake report
Message-ID: <20240530104123.72ab528b@kernel.org>
In-Reply-To: <7e443c56-129e-4421-8dd8-adb57e9e6193@kernel.org>
References: <20240509160958.2987ef50@kernel.org>
	<11ff9d2b-6c3e-4ee5-81c0-d36de2308dbd@kernel.org>
	<7e443c56-129e-4421-8dd8-adb57e9e6193@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 19:35:56 +0200 Matthieu Baerts wrote:
> > Yes, we need to find a solution for that. It is not as unstable on our
> > side [1]. We will look at that next week. If we cannot find a solution
> > quickly, we will skip the flaky subtests to stop the noise while
> > continuing to investigate.  
> Now that the flaky MPTCP subtests results have been ignored, the results
> look better:
> 
>   https://netdev.bots.linux.dev/flakes.html?br-cnt=88&tn-needle=mptcp
> 
> Do you think we could also stop ignoring them on NIPA side?

Thanks for take care of it, done!

