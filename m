Return-Path: <netdev+bounces-37982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 630677B829E
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 16:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id F15131F2277C
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 14:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15D514010;
	Wed,  4 Oct 2023 14:46:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C7AD279
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 14:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FC5C433C7;
	Wed,  4 Oct 2023 14:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696430808;
	bh=naCZsxAcYmOPjb1jywP+4alIhYI/eZspEZwVwCeRJys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RXUMxPKWkH7mXUHVPePZPxTKVpW/uFGpZuBvPCS1X9usF9DsC26B7IBb42bp6HPCp
	 3dtQYxdntZSHESmPX94jHKCID8FLIOu88QttXc9QMvLr5xQIU4hdnyGlDVFhLrEJ5Q
	 82iDnBHMTZRtTATJX0GvIqvM2mz7RtuivvKjiD+2rI/MZz37l8PpSovNWOL6or61gj
	 PTd6057XDBNfTESqzbifPMlWRegZNGaTjoszA9nnITYky+HL7Hp1WIjHEucu6CIFwQ
	 jUlW/HV1rr4eSwXyDVTP4x8z7ahoRzpJ+GzxW0fA6Ix84sMC8eI2gYrfPmojpvqqwd
	 Xed4Jwrk/Coqw==
Date: Wed, 4 Oct 2023 07:46:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: <esben@geanix.com>, Harini Katakam <harini.katakam@amd.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <jsc@umbraculum.org>, <christophe.jaillet@wanadoo.fr>,
 <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <harinikatakamlinux@gmail.com>,
 <radhey.shyam.pandey@amd.com>
Subject: Re: [PATCH net-next] MAINTAINERS: Add an obsolete entry for LL
 TEMAC driver
Message-ID: <20231004074646.6fd564a6@kernel.org>
In-Reply-To: <4b8361e5-08f8-4cf8-a277-769647fb9c4c@amd.com>
References: <20230920115047.31345-1-harini.katakam@amd.com>
	<878r8qxsnf.fsf@geanix.com>
	<4b8361e5-08f8-4cf8-a277-769647fb9c4c@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Sep 2023 08:06:46 +0200 Michal Simek wrote:
> > Ok. But while that might mean that no new designs should use LL TEMAC
> > IP, why do we need to declare the driver for it obsolete?
> > 
> > Existing designs using LL TEMAC IP might need to upgrade Linux kernel
> > also.  
> 
> If you want to take responsibility for keeping that driver alive then feel free 
> to send a patch on the top and declare it publicly. We are not able to test it 
> on these old platforms that's why we are publicly saying that it is end of us.

Why Obsolete tho? There's no other driver for this IP, so Orphan sounds
more accurate. Please change it to Orphan.

