Return-Path: <netdev+bounces-249493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D550D19EDF
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1BF23033F6F
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 15:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925F931ED6E;
	Tue, 13 Jan 2026 15:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abOhX19m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9CB31076A;
	Tue, 13 Jan 2026 15:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318316; cv=none; b=oRoj19Sy5DDbK0iolVuthz04RhitgoXgF5Yf6+lTgMlavb3J7/UuYR43WUeMg+/pQ5pi9XDs22kshFo5lqjw8mhqjKzutvXJCHrjRmYL6Xfsapq5C7Ey88zhJr0cnA9w0XpHwoDP0sY//1BeKsMgOXDIE5Z+PDTj4Os0WYsUbgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318316; c=relaxed/simple;
	bh=i6JP4XEqUgKRaInZrKdhDeeJ/745+kZJGTeJoDR8YzE=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZ60JdX48pWzgprMQ/RE817Gp4iID+UtZEa8d742CPJCnMe8Kjs8uikZyLv8gaC3lZL0j7lw73C7VYztytC/JEyD0P23BHaj2tJvEE0D+hFlq4lH/JmLLpG2xqm341Q1uBq3yLwxxvx0Vf7iMpDDr8deUPyEv/CRi7DU4WPMyp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abOhX19m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205CEC116C6;
	Tue, 13 Jan 2026 15:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768318316;
	bh=i6JP4XEqUgKRaInZrKdhDeeJ/745+kZJGTeJoDR8YzE=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=abOhX19mp460XrhrkhwjzbAu27Mym9OYzjPtp7YiD2g1xep43RzUmGUiVMaiUTKd0
	 Rmz5grGp+dn21hA5qjPdP9x/QOmzcPsgKInBXZ+ZosK0gJDcUpLshhE5lqsxxuN11F
	 jZFZSfYJiSi/gHLKZfpLagDc4JR+8knqdRZJeBw9ydaBZJnLPm7oAF353XO3QD6JnH
	 pj6q2g5gSfb1qUK4CBuzkjDZ/dAE5agfwswIsJKXtmXKZPMdejVjYefVV/88v6JMKT
	 r82ff7XjBhAB8fZxV4AFQwRWze0KnWQyY8DxBOS6wzDgSsdokHuKPsaD8Dj0eA9ThF
	 8xa+Lh9kjNwOg==
Date: Tue, 13 Jan 2026 07:31:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - Jan 12th
Message-ID: <20260113073154.1945d895@kernel.org>
In-Reply-To: <20260112065324.1f8fb086@kernel.org>
References: <20260112065256.341cbd65@kernel.org>
	<20260112065324.1f8fb086@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Jan 2026 06:53:24 -0800 Jakub Kicinski wrote:
> On Mon, 12 Jan 2026 06:52:56 -0800 Jakub Kicinski wrote:
> > Subject: [ANN] netdev call - Jan 12th  
> 
> Sigh, of course I meant Jan 13th!

No topics, consider it canceled!

