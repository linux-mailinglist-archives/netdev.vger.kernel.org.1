Return-Path: <netdev+bounces-151271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E6F9EDD6D
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 03:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7CF52826A8
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 02:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2303613B791;
	Thu, 12 Dec 2024 02:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gq7lkd7j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFDE139D1B
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 02:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733969510; cv=none; b=bIb5lCzIcq8af5rYFKLxklU00uBg2dwxvkSVx9v8wD0IF4Fhyf/FltbbgIWCJozITdjnPiHO6Ti7EvPdZNbYRx2ny6bv51J6G21/a7mqhm1nTe0ax5x42KR8wQl5MOLBwj0AWyqb445FPqL+J7tjSEtUQh6Wxs5dHfmKRhPzM4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733969510; c=relaxed/simple;
	bh=u4Ab/RrhNENWre9NH1ASUMwA1i2WxPNZzyYljqFy7zU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPjylq9EvQcVw3fA1/TZ933BiDrDAEZm6Fo+qJTPQ+4miXtUaiCZSlyyTG0iRzZMWhmo9Ri8KmAwwWVg3sNVLNHTKkHTT5UXqSBH1+Np+IbJPm2/qZJhUX0SfnJ5Dutj3SChCi4IQY19C4uh8nCDf8p0dAHvxl0bl7fONH+ymTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gq7lkd7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CFEC4CEDD;
	Thu, 12 Dec 2024 02:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733969509;
	bh=u4Ab/RrhNENWre9NH1ASUMwA1i2WxPNZzyYljqFy7zU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gq7lkd7jPGIBym0vqjBJiH0mvdOTP7DSLDCUrdIql9yYLAk32kzuz18q6xCIkJda5
	 fdcDyi8Se8xk84BktYyvSYt6/8Xqf/Ai965mzhwUEOeb1oyj1N41cc14UbFCq0eGLx
	 LRbL9YSnJMzHSjpHKh4g2TpUtM6U8qdF8M1RCPYMMOiKFQUYmkd0QQIhlSYGh6Hct5
	 6BpAzIcltwqDlauibhGFOWgqtgeoNeciSroGCWIIaMJ1YYFW4FWGsVCNZ9Kv112bCx
	 7KDeMmwcZEkLfYGNeQyPszWk5TDsGUz1+S2pnRsgGG1QZ0lKcCx0yyYsbrwXhNoHB+
	 yVGF0+CSZpjtg==
Date: Wed, 11 Dec 2024 18:11:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Szapar-Mudlaw, Martyna" <martyna.szapar-mudlaw@linux.intel.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, horms@kernel.org,
 jiri@resnulli.us, stephen@networkplumber.org, anthony.l.nguyen@intel.com,
 jacob.e.keller@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org
Subject: Re: [RFC 0/1] Proposal for new devlink command to enforce firmware
 security
Message-ID: <20241211181147.09b4f8f3@kernel.org>
In-Reply-To: <b3b23f47-96d0-4cdc-a6fd-f7dd58a5d3c6@linux.intel.com>
References: <20241209131450.137317-2-martyna.szapar-mudlaw@linux.intel.com>
	<20241209153600.27bd07e1@kernel.org>
	<b3b23f47-96d0-4cdc-a6fd-f7dd58a5d3c6@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 13:15:06 +0100 Szapar-Mudlaw, Martyna wrote:
> This patch does not aim to introduce a new security mechanism, rather, 

What I was referring to when I said "devlink doesn't have a suitable
security model" is that we have no definition of what security guarantees
we provide. Nothing in devlink is authenticated at all. 

Anti-rollback is fundamentally about preventing FW compromise.
How do you know that the FW is not compromised with devlink?

> it enables users to utilize the controller's existing functionality. 
> This feature is to provide users with a devlink interface to inform the 
> device that the currently loaded firmware can become the new minimal 
> version for the card. Users have specifically requested the ability to 
> make this step an independent part of their firmware update process.

I know, I've heard it for my internal users too. Vendors put some
"device is secure" checkbox and some SREs without security training
think that this is enough and should be supported by devlink.

> Leaving in-tree users without this capability exposes them to the risk 
> of downgrades to older, released by Intel, but potentially compromised 
> fw versions, and prevents the intended security protections of the 
> device from being utilized.
> On the other hand always enforcing this mechanism during firmware 
> update, could lead to poor customer experiences due to unintended 
> firmware behavior in specific workflows and is not accepted by Intel 
> customers.

Please point me to relevant standard that supports locking in security
revision as an action separate from FW update, and over an insecure
channel.

If you can't find one, please let's not revisit this conversation.

