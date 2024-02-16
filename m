Return-Path: <netdev+bounces-72261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E34EA85739A
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 02:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A21BB21625
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 01:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A1ADDA8;
	Fri, 16 Feb 2024 01:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIve6HRn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D623BC2D6
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 01:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708048717; cv=none; b=qXsLDFPWE9p/kQUw08lXbyjf7OkGGspyhC13k1/26ULglTohH6VwAl4jBCyrmcbwka4bsbzjNm75BFx2QfRxIw+1lW1+3LpS7PgRu9WXV06sMnxmfRIF3XF5Kig4e7AaIQnlkrO36rI79xPb6pbdq+ZoI6QQynRmUyizlR+AWXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708048717; c=relaxed/simple;
	bh=tEh2zZwjK0JrJdOAP2kYw1ZzF9s03vpMkYi+kmy6awk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lVL8crW81QZaFhIveXtYW0bdi178zgpOBt98oSR7Ht41Z+vxrU2Y8O2oXMn1XrTNpg9VSo1PGf3cV585tz/AqyuUkEatQetjQ1EBvSehn/Mb0Qka9KV9G62pI6yFzFsG1UF27E+tRudOvbV3bY/xpUD6byLh+Ua3pOXvBtbSJzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIve6HRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8E9C433F1;
	Fri, 16 Feb 2024 01:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708048717;
	bh=tEh2zZwjK0JrJdOAP2kYw1ZzF9s03vpMkYi+kmy6awk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PIve6HRnzi5Y3XiFr1kZYGjH9ACHEZg1Gr12EJK7vLb4ovZE48CY32A4RlPKAGHMK
	 oHFJyx70Gkx0JsSJjndYTfT2Yg4Z+mMP35yuqsiGUtVUPFO5Fj3DNtjpSIgeK9Xstd
	 Yyz6SrqpKZnhRHWhxQoKcEBUYNP6pqi8DHV5k3vGPXMrp3kg5GHnp7Iy7caYzsRBXk
	 H2mBwPlth4t03YtAIw0o5ISIn2W/G0h5MbaMIY7TNKeDP6I6AhykvRluhvxJmucgKB
	 85sDu2a9UAe8QA93I7Iq/Et0eHpFrviyhhPuPHO0ESTaP9lxK5Ezp2f4avO1dGvwd0
	 IWEoUOT1QOt6g==
Date: Thu, 15 Feb 2024 17:58:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: William Tu <witu@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>,
 bodong@nvidia.com, jiri@nvidia.com, netdev@vger.kernel.org,
 saeedm@nvidia.com, "aleksander.lobakin@intel.com"
 <aleksander.lobakin@intel.com>
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Message-ID: <20240215175836.7d1a19e6@kernel.org>
In-Reply-To: <Zc4Pa4QWGQegN4mI@nanopsycho>
References: <20240131124545.2616bdb6@kernel.org>
	<2444399e-f25f-4157-b5d0-447450a95ef9@nvidia.com>
	<777fdb4a-f8f3-4ddb-896a-21b5048c07da@intel.com>
	<20240131143009.756cc25c@kernel.org>
	<dc9f44a8-857b-498a-8b8c-3445e4749366@nvidia.com>
	<20240131151726.1ddb9bc9@kernel.org>
	<Zbtu5alCZ-Exr2WU@nanopsycho>
	<20240201200041.241fd4c1@kernel.org>
	<Zbyd8Fbj8_WHP4WI@nanopsycho>
	<20240208172633.010b1c3f@kernel.org>
	<Zc4Pa4QWGQegN4mI@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 14:19:40 +0100 Jiri Pirko wrote:
> >Maybe the first thing to iron out is the life cycle. Right now we
> >throw all configuration requests at the driver which ends really badly
> >for those of us who deal with heterogeneous environments. Applications
> >which try to do advanced stuff like pinning and XDP break because of
> >all the behavior differences between drivers. So I don't think we
> >should expose configuration of unstable objects (those which user
> >doesn't create explicitly - queues, irqs, page pools etc) to the driver.
> >The driver should get or read the config from the core when the object
> >is created.  
> 
> I see. But again, for global objects, I understand. But this is
> device-specific object and configuration. How do you tie it up together?

We disagree how things should be modeled, sort of in principle.
I think it dates all the way back to your work on altnames.
We had the same conversation on DPLL :(

I prefer to give objects unique IDs and a bunch of optional identifying
attributes, rather than trying to build some well organized hierarchy.
The hierarchy often becomes an unnecessary constraint.

