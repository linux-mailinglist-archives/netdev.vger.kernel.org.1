Return-Path: <netdev+bounces-82543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B6088E84A
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 16:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A610E1C29EB8
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 15:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC6913D513;
	Wed, 27 Mar 2024 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oD5PkY21"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A3313CFB4
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711551016; cv=none; b=NtPlO0KhtGp4ZcFH71C4R3uo4Wa0el83RNTn2UjbEQP4b4K24ASNUiZYkGEugROaAOUfGnEWpvWPeQh9kCM3xJ64RODw24+lB5G2LH6zGohmeTLsJ3Qt4k3mrvi7kKShf3kt0XBwUoRanQ6Tkp7vrhTgnprVXF09vTIaV43fnTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711551016; c=relaxed/simple;
	bh=lxcOWeusmPSxt7j/dpCPZEwYKj+CCXjeiAYCqK4Aj40=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=crYPQekPqDMboy2C6Us7P7EhTJLaXr8QWSDBmFKlmnL2ddntpNIsY/Ct6HPNpLP8+YCQjIE3M+n4KJXtQQAGRfXQpBkoKuETEN9wFgg8JjNIYORzrAEjGJxePXbucPy49kHYDayYtvjQyiEsMldLQSWxvKr9FL1B0K8cQBKnXXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oD5PkY21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED60C433C7;
	Wed, 27 Mar 2024 14:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711551016;
	bh=lxcOWeusmPSxt7j/dpCPZEwYKj+CCXjeiAYCqK4Aj40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oD5PkY21xIbvo7zIlxtygT9UAXEPoV3R6qKI27CeDj3xo8vXgnDPNrGGQ6+m2faHG
	 VYAIklWFHx+DMBmpy5MHdZ8TPnNvafESLc/jEdESTkr75Tc5sF0Q8m9XtJ4UOsRehY
	 JnlqnA8QM0zOWp+lFTRfQ16B/+RU695u0zRgn4yk/hLO5+q8yngLHkskXcrGz20NPR
	 ytCO9hVkLuGc2NnIAHI8P1IQlHyBgrINyFO5jqArev7BuKFtMqauW+1/Mc7zgTD4ti
	 qRfU4u7EkR3DCqdxQVYsO0c6cCFI4wVFviNKI1TbqxDBKIn2238Ev2GiutYSqfNuko
	 Rq5xJ+73xpZGA==
Date: Wed, 27 Mar 2024 07:50:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 00/12] Add support for Rx
 timestamping for both ice and iavf drivers.
Message-ID: <20240327075015.7c13a71b@kernel.org>
In-Reply-To: <20240327132543.15923-1-mateusz.polchlopek@intel.com>
References: <20240327132543.15923-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 09:25:31 -0400 Mateusz Polchlopek wrote:
> v2:
> - fixed warning related to wrong specifier to dev_err_once in
>   commit 7
> - fixed warnings related to unused variables in commit 9

You posted this yesterday and got no feedback.
You're not posting to the list just to get the code build tested, right?
There's a lot of code getting posted, give people more time to take 
a look. v2 feels a bit rushed.

