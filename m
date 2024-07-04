Return-Path: <netdev+bounces-109088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8655926D81
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 04:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67BB6B22947
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 02:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30F912E47;
	Thu,  4 Jul 2024 02:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqBsuwD5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B636F107A0;
	Thu,  4 Jul 2024 02:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720060520; cv=none; b=tRZZ/pIdIImXYPSJL5EiwILYFx+75AYH56bnKjYoE9ZAGImhTv4o5kXstLwfS9JgIlpGTjFdETnyfitHnMigK0aI796+Rk/pGpDujtnFGvnooSNCClVIUjbOoNCDEY6bzASrdENND9MF+La8gVISwB4tnPQovwM/QMwLFLISTBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720060520; c=relaxed/simple;
	bh=8Fv71y8ApjSv7SwqKUCznU/B66WZ3an2HyT3ky5LgwU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bioOZCKcF4aPN5dYKM5l0aRtrhi/wkh28GbapW3F/BAhVqvtaKMP7DoKgXkeWadtoJ0KtWGDG7974T9hUBZ+43wQvwfn70Q90YtOGfK27bJvV6ODRJQOtLykxvIpmLHB70Q7i4ByAkxusft6WCHtE83jJs01tas2PvhXpyGADuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqBsuwD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E3AC2BD10;
	Thu,  4 Jul 2024 02:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720060520;
	bh=8Fv71y8ApjSv7SwqKUCznU/B66WZ3an2HyT3ky5LgwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TqBsuwD5F2boX1wyYMNICbW/7CBb5d8+TfRU1bdFhb43NhUciugDHR2fGm70DhYHi
	 xNanMn8sJwIL5yskyH+J55JwmNaGiEGWEmMumWyl6MeBMR7zLGVcwrCjeuyjj0ZzMn
	 B5k91VkxRWt/s9qmFWSplki8VDlbiAjVuvta5BgCzU5qOJ8G3PuaOfpjB4Zs/Rd9BV
	 zFMHdcHk6dp0pk1ndgB9yaM9OMNti7ViUMSjvOiODAG3KcgA34k/D6qeBW3UgqI9w2
	 Sadc8lf5/jF4h9R8B1TV5OJn16xVwCASTpD2Ezu8ElfFQK6XA8Vnnw3IJJSW6XJIwp
	 4uC8xtMvGbOew==
Date: Wed, 3 Jul 2024 19:35:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 horms@kernel.org, i.maximets@ovn.org, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v8 00/10] net: openvswitch: Add sample
 multicasting.
Message-ID: <20240703193519.16305196@kernel.org>
In-Reply-To: <20240702095336.596506-1-amorenoz@redhat.com>
References: <20240702095336.596506-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Jul 2024 11:53:17 +0200 Adrian Moreno wrote:
>   selftests: openvswitch: add psample action
>   selftests: openvswitch: add userspace parsing
>   selftests: openvswitch: parse trunc action
>   selftests: openvswitch: add psample test

Sorry for applying things slightly out of order but without Aaron's
patches we can't check if these work in our CI. Unfortunately, they
conflict, could you respin one more time?
-- 
pw-bot: cr

