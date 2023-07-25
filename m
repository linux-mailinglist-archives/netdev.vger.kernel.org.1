Return-Path: <netdev+bounces-20632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC8A760491
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 03:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3FC1C20491
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 01:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A2BEA4;
	Tue, 25 Jul 2023 01:04:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798097C
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 01:04:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4690C433C8;
	Tue, 25 Jul 2023 01:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690247069;
	bh=k0+Q7F/uZHsflIOAaWgAaLqYda6TVmmp+S/0I3sWSCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P+DUYEJ5KB6/L2c/yXGBpkbsWb3OmbEqyvdR8CQn8TMmASqIHzg548JtS63kSE80P
	 lCOaF6qjmq9gSCwO5nOhQkGO1IjwyvU2Ku6oEDwzYUsnmaTkXUZM9KP1cKtD/yE9hZ
	 2KEaQRm9N9Tk0XqdQPIe2xsdEDsc0UksZ74xK2E8U7uLYuQTeKSooMN2OjzuuZNF/Y
	 niPhk5Uky7RvT5sy2BiQ5fO5slG5AhcYn7tEAARX9JUiI8dPiOiGEwJA14VqDZThHN
	 jrYTPqQuzHfcofbP8hZDk9GNXPeHpXqOZ9+mD0H8lM3z4XIPuDHz8/nUw0jXsAu/KM
	 h6Xmcybjye22g==
Date: Mon, 24 Jul 2023 18:04:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, workflows@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Enable Designware XGMAC VLAN Stripping Feature 1/2]
 dt-bindings: net: snps,dwmac: Add description for rx-vlan-offload
Message-ID: <20230724180428.783866cc@kernel.org>
In-Reply-To: <c690776ce6fd247c2b2aeb805744d5779b6293ab.camel@perches.com>
References: <20230721062617.9810-1-boon.khai.ng@intel.com>
	<20230721062617.9810-2-boon.khai.ng@intel.com>
	<e552cea3-abbb-93e3-4167-aebe979aac6b@kernel.org>
	<DM8PR11MB5751EAB220E28AECF6153522C13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
	<8e2f9c5f-6249-4325-58b2-a14549eb105d@kernel.org>
	<20230721185557.199fb5b8@kernel.org>
	<c690776ce6fd247c2b2aeb805744d5779b6293ab.camel@perches.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

[clean up the CC list]

On Fri, 21 Jul 2023 20:32:44 -0700 Joe Perches wrote:
> On Fri, 2023-07-21 at 18:55 -0700, Jakub Kicinski wrote:
> > On Fri, 21 Jul 2023 18:21:32 +0200 Krzysztof Kozlowski wrote:  
> > > That's not how you run it. get_maintainers.pl should be run on patches
> > > or on all files, not just some selection.  
> > 
> > Adding Joe for visibility (I proposed to print a warning when people 
> > do this and IIRC he wasn't on board).  
> 
> What's the issue here?  Other than _how_ the script was used,
> I don't see an actual problem with the script itself.

I just CCed you on another case. If people keep using get_maintainers
wrong, it *is* an issue with the script.

> I use the scripts below to send patch series where a patch series
> are the only files in individual directories.

The fact that most people end up wrapping get_maintainers in another
script is also a pretty strong indication that the user experience is
inadequate.

To be clear - I'm happy to put in the work to make the changes.
It's just that from past experience you seem to have strong opinions
which run counter to maintainers' needs, and I don't really enjoy
writing Perl for the sake of it.

