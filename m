Return-Path: <netdev+bounces-131585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8363B98EF41
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B491F2270C
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A913C1714B9;
	Thu,  3 Oct 2024 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZfhK8W2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C4C16F8E9;
	Thu,  3 Oct 2024 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727958557; cv=none; b=pCH/q24qdUIDhQUSLOZN0eMweDCBpcPrZgsGT1AUmbHL0aLYlUl3zHiMk4cBKnGfz6r1VdJse6jJWwXp8EEOgVuk8abZVi4fT2rOUnZtxYtt7MnF4D3C5sJ84kwQSnw+yyTQydsk4OkjpabUZx+h6KpnfimcC7RdJnYOl4vgAag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727958557; c=relaxed/simple;
	bh=Vj++WQvFX4PKlPxArCe7FjN8DsiLXmm4J+HA8iStU1o=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nclqy9YrhOgIm2oJdxnOHqPAwBlpBXojWo5Vi59zINml/DeheieClug/ihqgo3YBhzFxpbF7BGlWkWNC+IrQUh0CG0jVEs7yDLkEr94HBZsF0EBj8LEMuqE9AEH8u9y6L37k4d3ienZaS/aQvJoBG4FVdBDgUAcC+jEyFeYYHhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZfhK8W2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09409C4CEC5;
	Thu,  3 Oct 2024 12:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727958557;
	bh=Vj++WQvFX4PKlPxArCe7FjN8DsiLXmm4J+HA8iStU1o=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=hZfhK8W2e7omNm+CE5FfYP//aE+1uCs3NKR5nvo86OcJGUOAXuLqjMORGfZyZ+aab
	 a+JGvIF3WWRe7tpiaCG0i/jcZP2rmJLI5hhZWyROHNXb6sdEzRLgiXCXbL2KLgSpdX
	 tqC3wZjEAznSLlHtC3osCAmAd8ospgBrR0zYyi4NKKZU7FY1cnpgBzxXmJHNy33O1n
	 0FKrFeSNhMrOhKUiuwl1OaTdlCaJsEz/1gq+m8SgdJ7l8StSIMT5MlM7jnvmUtL2nC
	 quIpA7uQkedWM2zA4pBP4GQFn/PpbFNEglnG5o5hzEVxSxQmRFTI7zSYPQxMeLhaHv
	 KcuctJG8cv6NA==
Date: Thu, 3 Oct 2024 05:29:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] Reminder: deadline for LPC and netconf 2024 submission
 approaching
Message-ID: <20241003052915.66dae746@kernel.org>
In-Reply-To: <20240725165102.4e1b55cb@kernel.org>
References: <20240725165102.4e1b55cb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 16:51:02 -0700 Jakub Kicinski wrote:
> netconf is a great opportunity to discuss proposals and challenges with
> the maintainers and key contributors, refer to materials from previous
> editions to get a sense of the topics:
> https://netdev.bots.linux.dev/netconf/
> Submissions of LPC are via the website, for netconf please send me
> a few sentences over email. Don't be shy!

Hi! We have uploaded the notes and (some) slide decks from netconf: 
https://netdev.bots.linux.dev/netconf/2024
Until the next time!

