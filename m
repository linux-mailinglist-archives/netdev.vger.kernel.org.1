Return-Path: <netdev+bounces-180788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 621F3A8285B
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065C1464476
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CD5266567;
	Wed,  9 Apr 2025 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDPJ+PyY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBAA265CC8;
	Wed,  9 Apr 2025 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209584; cv=none; b=hSE3lU7BdDpEKmAguPVIzjr/Bgzeek+5ASK5dk0RkpP9Irt67sVTiMZf4HsIBASKG2rBkk4dx6XFzH2z4V60TmXCDHbVVFdx64CHdGqifdGIvD2ASWV0XXuV6IfTUkCli/+mhbnRdIHtkN5c7g1PJdscxD/rhRh/btq8ja6FQVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209584; c=relaxed/simple;
	bh=eavIfudAxkQ0CDQau8Hia0v1E+MVOHyrbHbwzaV3J3s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owZl2NJQx6xqPhpDZdsH86KRESECK/YWkBcoSWTbToqgW/T1jPh7DSZgZ7Ngj5VSiqC9dsa68PrNVq5f6iKnNvDRQVJGMskOqYBUbdZtaVGbTGOgzXRzCE2NugWoNBxosXnpzIvjvKESqsbvtmBXjIlgIKsacPGs0eLE21cepwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDPJ+PyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AD8C4CEE2;
	Wed,  9 Apr 2025 14:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744209583;
	bh=eavIfudAxkQ0CDQau8Hia0v1E+MVOHyrbHbwzaV3J3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZDPJ+PyYJ7v5LlekieDdtXa/9JtPsnS46YRyqKRUgyHqOADYuP6sJ5qK64yRgHq2C
	 5Q7/sGYoAVToeYqmTUmL4rq8vbp/jr8KuRf3o0TXajXsuxrU6ndC334mA4y0pIIPIi
	 9w0Wlay9YgL+ciWQrzDZ4MdJq6ke23izETElJ/OHO3IA2Wnr5dILwPWQUuYB84DVY/
	 r081psyofHgIpm+3RNnhDCNQ2YAWvlCCjvh9bj6vQckNTzq2AuC/vfwoIEUhDYPJmq
	 4B4+k54kH/q+Opa//PJViA7Jur9L+r2iLKae+vGlt2dZfdKrRtXxjuqrnT2nFeZU3j
	 5h0rMRYs1cADA==
Date: Wed, 9 Apr 2025 07:39:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
Cc: "Nelson, Shannon" <shannon.nelson@amd.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "Dumazet, Eric"
 <edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
 "horms@kernel.org" <horms@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Kalesh AP
 <kalesh-anakkur.purayil@broadcom.com>, "R, Bharath" <bharath.r@intel.com>
Subject: Re: [PATCH net-next 01/15] devlink: add value check to
 devlink_info_version_put()
Message-ID: <20250409073942.26be7914@kernel.org>
In-Reply-To: <DS0PR11MB7785945F6C0A9907A4E51AD6F0B42@DS0PR11MB7785.namprd11.prod.outlook.com>
References: <20250407215122.609521-1-anthony.l.nguyen@intel.com>
	<20250407215122.609521-2-anthony.l.nguyen@intel.com>
	<d9638476-1778-4e34-96ac-448d12877702@amd.com>
	<DS0PR11MB7785C2BC22AE770A31D7427AF0B52@DS0PR11MB7785.namprd11.prod.outlook.com>
	<7e5aecb4-cb28-4f55-9970-406ec35a5ae7@amd.com>
	<DS0PR11MB7785945F6C0A9907A4E51AD6F0B42@DS0PR11MB7785.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Apr 2025 14:14:23 +0000 Jagielski, Jedrzej wrote:
> No insisting on that but should empty entry be really presented to the user?
> Especially unintentionally? Actually it's exposing some driver's shortcomings.
> That means the output was not properly validated so imho there's no point in
> printing it.

+1, FWIW, I don't see the point of outputting keys without values.

