Return-Path: <netdev+bounces-61947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0D4825518
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 15:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB17283BFF
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 14:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B0F2D62A;
	Fri,  5 Jan 2024 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9vYfjit"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964DB2D7A2
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 14:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2045C433C7;
	Fri,  5 Jan 2024 14:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704464495;
	bh=8enhakZTz/ugbIGJcaVBJaRu1kjL0j+bqGmopUE6lmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z9vYfjit+aL0VBg0376Mo2XtP4MwEXGHBHZ+1cD59RKhEkOdaiCA0EfZO9K0jdTH+
	 BIdiVOR0PdefwXlASWS/ITIZEBhdOdKOHFJEH/GXWRDPGJ1f3e8h7mgALX3vIkWd9Y
	 WgCXp3tJEbEldBEzORtTpfo/00w/5aQvX3Bj16gn//Tj9YD2ZdNsGnS3HKHXhWDSPy
	 LjF1iR4cNyNZJmRu9SJ1dNjhNP5rXuejM9MX8tHAiCEv3Mfx/nfJK0EDfghFLoo12q
	 sj0PuhNJ/RrYddZqtGlDaOmOUD8n6bUG8IeBWYx/YJYmVpjbSZYM1EBvrMrPdN18ej
	 62YC2ANblqOWA==
Date: Fri, 5 Jan 2024 06:21:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "vadim.fedorenko@linux.dev"
 <vadim.fedorenko@linux.dev>, "M, Saeed" <saeedm@nvidia.com>,
 "leon@kernel.org" <leon@kernel.org>, "Michalik, Michal"
 <michal.michalik@intel.com>, "rrameshbabu@nvidia.com"
 <rrameshbabu@nvidia.com>
Subject: Re: [patch net-next 1/3] dpll: expose fractional frequency offset
 value to user
Message-ID: <20240105062133.17456a14@kernel.org>
In-Reply-To: <DM6PR11MB46575D0FFEE161D2C32D26C99B662@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20240103132838.1501801-1-jiri@resnulli.us>
	<20240103132838.1501801-2-jiri@resnulli.us>
	<DM6PR11MB46575D0FFEE161D2C32D26C99B662@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jan 2024 13:32:00 +0000 Kubalewski, Arkadiusz wrote:
> But one thing, there is no update to Documentation/driver-api/dpll.rst
> Why not mention this new netlink attribute and some explanation for the
> userspace in the non-source-code documentation?

Now that we generate web docs from the specs as well:
https://docs.kernel.org/next/networking/netlink_spec/dpll.html
I reckon documenting in the spec may be good enough?

