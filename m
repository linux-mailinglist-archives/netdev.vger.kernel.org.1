Return-Path: <netdev+bounces-198808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2091AADDE48
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031A03BBCC4
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 21:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC9C28ECE5;
	Tue, 17 Jun 2025 21:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYDuo+Zg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F98C2F5302;
	Tue, 17 Jun 2025 21:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750197281; cv=none; b=ipaCq7LPVPMJR5JPtxgC1EJKM5dQN0Tp0v7OpQHS0pnhu0isDIleXIO5t1IKCgxXGluwbOw40nmAAa06hKX4Enu1qSRIARKRCJjcEP8Wl77NEXEN3ERp9yYTL4JgLIQYTzsxpnylIEeSxzJf3O3+qu0GINhZE8sYVXE1qkPpqI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750197281; c=relaxed/simple;
	bh=5M1HEcJyTJuu1F59f68ilmv5yp2Y6nlva/IKYtBlbh0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mzZissYYmzSPwb+M4fKuv9w47+BiMG+INgokJWJOX6kkq/ceoQUT5nOV87GxQDrWYu//U6rqvqwAyecpES0wMIRVIObPqbP0ZChNQdaoWEYMcXBaKJqL0iCXz2KLiyxBKin2qKpQlkm/DE+5NbBrsjBMLOfru5pazqSc484u4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYDuo+Zg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7E9C4CEE3;
	Tue, 17 Jun 2025 21:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750197281;
	bh=5M1HEcJyTJuu1F59f68ilmv5yp2Y6nlva/IKYtBlbh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gYDuo+ZgJi7GSun7R7BodLYas/DpBzNrCKE2kdvwI9RuY5Khsg1i/qL54VAijq+FE
	 OjM2Mbe7d8WCsTU7VQvaACZUCwVoAG6IzjT4P4HkYD+98StFE/1yeaLLbwAfdGgXkO
	 YvaRa6L7cCNEovSKTRQN4LpK6Sgu/PMIlEfKjsYbEiWK1oC0jXcG8swFoG4FtwTwGc
	 B7W8gMMax2lNRiRvCIcuCf/xrdIE3fI7v+XlVkccIq0xfAtQm005iGlJkkshYUA7cc
	 iVdOlJCoAZsGDnQ6XfUR4g8k6ahULsqoI9QA8/CpG+2e5JXKaSUQMN0LvqY/0pnOAA
	 CNeJrJgpsH39g==
Date: Tue, 17 Jun 2025 14:54:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ethernet: alt1: Fix missing DMA mapping tests
Message-ID: <20250617145440.0a055536@kernel.org>
In-Reply-To: <CA+eMeR2yEa4wsozLP94Zb2gQ67=xhC58PEdOKL8=RzaZotYhSQ@mail.gmail.com>
References: <20250613074356.210332b1@kernel.org>
	<20250616140246.612740-2-fourier.thomas@gmail.com>
	<20250616104619.75f4fd74@kernel.org>
	<CA+eMeR2yEa4wsozLP94Zb2gQ67=xhC58PEdOKL8=RzaZotYhSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Jun 2025 17:47:50 +0200 Thomas Fourier wrote:
> On 16/06/2025 19:46, Jakub Kicinski wrote:
> > On Mon, 16 Jun 2025 15:59:55 +0200 Thomas Fourier wrote:  
> >> According to Shuah Khan[1]  
> > Sorry for a non-technical question -- are you part of some outreach /
> > training program? The presentation you linked is from 2013, I wonder
> > what made you pick up this particular task.  
> 
> I am doing a master thesis on static analysis and I am writing a checker
> with

I see.

> Smatch to test if error codes are well-checked.  My supervisor suggested
> that
> 
> I look at DMA mapping errors checks to see if people were interested in such
> 
> patches and because they are quite easy to statically assert.

Given the community's mixed experience with researches, would you
be willing to share the name of the institution ?

