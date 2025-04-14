Return-Path: <netdev+bounces-182357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A5AA888A5
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72F71899465
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CB625E813;
	Mon, 14 Apr 2025 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEOWyo0z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8615C2DFA3D;
	Mon, 14 Apr 2025 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744648438; cv=none; b=YLWArqWQpxK1XaeDqc7+/p5uEN8bLmIbQjYTfeSrpEZvFSVclV5kXQSptqL8WDFjieY5xHRMM/HRV5k0lT3kFmW1uWaJXWz+TFdwBqsy3W2n0bT1e1Anz37UjEB9VN7eWewtVDwBG3qPZl1UNP8xabVj+WYWYK76qnuKGmlfDzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744648438; c=relaxed/simple;
	bh=d+ZRTx+RD81P0rFTl+nUP/1QZulDzYY8KvICn1C4bls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=igg0AQOaJHTXiwiW2k+D/QT4AIQdyC8xbW77EihBcZ5nLwj7BoAhS0nYbaNG21gRe2j8mu29mbtPLr8kvKBt/4NTKCzwzqeK+sBDLwrAsi0BFn6Fa9xXjqd4bD1oHlmWKgfrRMCq6cZHbidVCz/bj1vRr7HNsS2meonWJf00Kv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEOWyo0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC6BC4CEE2;
	Mon, 14 Apr 2025 16:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744648438;
	bh=d+ZRTx+RD81P0rFTl+nUP/1QZulDzYY8KvICn1C4bls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uEOWyo0z3Vhi0x3jgeHCXbWlBHnpp14a2akmPJ27kwkZ+ubwypzexMevHalO8+W96
	 uwIAagW/Q5Z+e31k1HDBDYRXeEvK/lxpcRjRDuossGwwcv05iWkmWSBtX2Iqqx5/vd
	 BZ0ExtPCm4Rh4LG9s3Kvc9UjHyjsuNLbm74rPthBFXIJxeqjxCZV/NCtLTJ9MVYwtG
	 4oLB9j6PQj6msOYPtE2gLOyd1TNgdyjrDWbbFL9uDx+sboRHl7Qux8xGZE86oeA9us
	 sdhoTuSql7goYtmhhj3J/hlpu9aUW0SeFj6nP6cHemuQUPlGAAsXd+rkxIhbm5hiBi
	 +2DD3I3V6c1Kw==
Date: Mon, 14 Apr 2025 09:33:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>, "Nelson, Shannon"
 <shannon.nelson@amd.com>, "Jagielski, Jedrzej"
 <jedrzej.jagielski@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "Dumazet, Eric"
 <edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jiri@resnulli.us"
 <jiri@resnulli.us>, "horms@kernel.org" <horms@kernel.org>, "corbet@lwn.net"
 <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, "R, Bharath"
 <bharath.r@intel.com>
Subject: Re: [PATCH net-next 01/15] devlink: add value check to
 devlink_info_version_put()
Message-ID: <20250414093356.52868a1d@kernel.org>
In-Reply-To: <69a0bf15-5f52-4974-bbaf-d4ba04e1f983@intel.com>
References: <20250407215122.609521-1-anthony.l.nguyen@intel.com>
	<20250407215122.609521-2-anthony.l.nguyen@intel.com>
	<d9638476-1778-4e34-96ac-448d12877702@amd.com>
	<DS0PR11MB7785C2BC22AE770A31D7427AF0B52@DS0PR11MB7785.namprd11.prod.outlook.com>
	<7e5aecb4-cb28-4f55-9970-406ec35a5ae7@amd.com>
	<DS0PR11MB7785945F6C0A9907A4E51AD6F0B42@DS0PR11MB7785.namprd11.prod.outlook.com>
	<20250409073942.26be7914@kernel.org>
	<5f896919-6397-4806-ab1a-946c4d20a1b3@amd.com>
	<20a047ba-6b99-22d9-93e0-de7b4ed60b34@gmail.com>
	<69a0bf15-5f52-4974-bbaf-d4ba04e1f983@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 14:28:31 +0200 Przemek Kitszel wrote:
> On 4/11/25 13:11, Edward Cree wrote:
> > On 09/04/2025 18:25, Nelson, Shannon wrote:  
> >> On 4/9/2025 7:39 AM, Jakub Kicinski wrote:  
> > AFAICT the argument on the other side is "it makes the driver look bad",
> >   which has (expletive)-all to do with engineering.
> > Value often comes from firmware, anyway, in which case driver's (& core's)
> >   job is to be a dumb pipe, not go around 'validating' things.  
> 
> that way we will stick with the ugly, repetitive, overly bloated code,
> repetitive and hard to fix in all places, (and repetitive) drivers
> 
> yeah, good that we bikeshed on something so simple :)
> If anyone is "strongly opposed", please say so once more, and we will
> drop this patch. Otherwise we are going to keep it.

Unrelated (I think?) this is a relatively big series so I don't want 
to race with it, but I think we should rename the defines. 

DEVLINK_INFO_VERSION_GENERIC_x -> DEVLINK_VER_x ?

You did some major devlink refactors, maybe you want to take this on? :)
The 40 char defines lead to pretty ugly wrapping, and make constructs
like:

	if (something)
		devlink_info_version_running_put(...

impossible. We could also rename the helpers to s/_version// ..

