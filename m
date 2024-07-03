Return-Path: <netdev+bounces-108880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9880C92622A
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443041F20DD4
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23555178CF5;
	Wed,  3 Jul 2024 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frAIqJHx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0019914D44E
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014551; cv=none; b=B0HMZew+X560veyU82/3yyzv1Gy6OGbaiRw3WGqB5+Tbb4tEZ2+RW5ZTbzV2Em6+PzFUB6DJsHQcq+fV/UU7LIGfvZ1qTIF5JE5QT9p8sbb8rhVGNX/uFLk86RS8jfck4LmKEhGhypO7Lp1TajOLmj3Payuw3QpLrqtXmeebXS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014551; c=relaxed/simple;
	bh=lKMGUGIF2XlHBXgWMTKxTf4PaugKUa1XsQRC8W5gf2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBkyGisjYTrw2eFau8Kj95IynaoXyHaMV9kRzwvMLHR/x5jPJinGXum0BEJ8f6atB+iafmKitYm+K+mPLYdfZ1Y7py7IIomFlsEl9ORayJVlqOwmITPLSSf2JKDy/J/sx4AakAkU8/9nBuOhRVKa4+wj6PDH8bE0iZuj1SSudws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frAIqJHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9DEC3277B;
	Wed,  3 Jul 2024 13:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720014550;
	bh=lKMGUGIF2XlHBXgWMTKxTf4PaugKUa1XsQRC8W5gf2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=frAIqJHxXMTtKeQKdrJrKI1EquhIx3g8aUlUZ93v846S/Tm/Y6DNxRHjajLAA9WOg
	 sXOMPLloExOUs+5EeS5IMsdwJPuNcKkGhYcejeYVQJqMA3ZU374kvLvsllfMsoxVCS
	 vpryLQQQw69dwM4U8UtENh2KYlp/Sgb+o4RnLT4M/FZeDlCdkwprkjX0tSKCXLKgaL
	 71RE85eENx/sE47sFq7Tw/3SsPRD975gMcDca8Q44/08PsaEuO3nq5hDhgOVDncw9U
	 GCHujPSluQDBwAClc1QSEpTA5w9m0UUJCE4b2mp8TUMFaQea+I6Ub5THTOTO+Jl4MF
	 3udildc67ceUw==
Date: Wed, 3 Jul 2024 06:49:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: <netdev@vger.kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <ecree.xilinx@gmail.com>, <michael.chan@broadcom.com>
Subject: Re: [PATCH net-next 09/11] eth: bnxt: bump the entry size in indir
 tables to u32
Message-ID: <20240703064909.2cbd1d49@kernel.org>
In-Reply-To: <0a790e16-792b-448c-abaa-a4bf8cc9ebb0@intel.com>
References: <20240702234757.4188344-1-kuba@kernel.org>
	<20240702234757.4188344-11-kuba@kernel.org>
	<0a790e16-792b-448c-abaa-a4bf8cc9ebb0@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Jul 2024 12:51:58 +0200 Przemek Kitszel wrote:
> OTOH, I assume we need this in-driver table only to keep it over the
> up=E2=86=92down=E2=86=92up cycle. Could we just keep it as inactive in th=
e core?
> (And xa_mark() it as inactive to avoid reporting to the user or any
> other actions that we want to avoid)

Do you mean keep the table for the default context / context 0
in the core as well?

