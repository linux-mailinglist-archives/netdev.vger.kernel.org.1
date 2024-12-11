Return-Path: <netdev+bounces-150966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5414E9EC34A
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 04:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD5716775C
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D118320C493;
	Wed, 11 Dec 2024 03:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rpl2i1vO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7177F9E6;
	Wed, 11 Dec 2024 03:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733887612; cv=none; b=Y0yfo5D1HXqi/0aXTItlHg624oXgf7i0/UNntg8azh7H3qmQI7UvM2F2Q/RzMCnMASnZ9FzBh+RTFLNfsUaHlG5lV+wFms1ia/OtAC2mkGFR1hzswAfQejCDTrG/6oWpXa+Zrd/kHibexoboe28sCKLlBlP7gDVTirZzGEHiisw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733887612; c=relaxed/simple;
	bh=Q1kVpqhvGvq7h0HQfZsX/GFYg3+eN9/ciKegJkNWrLg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MvOy2Ou1KNvaCSVK/wu8RvXBuu5FR1E/kKNi+69jPH5GlcllAkw1HtMvFeaOAnFqm+5r2uVheStal6UYjOtDpS2FfVqbQdRK43B9LD6NVx6OUwu1RzCRdqurzzjqpcfkJ2YwqSkFAC9aiG3uAN9xepRhruUtYbLO0oc2wajAP/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rpl2i1vO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90ADC4CEDD;
	Wed, 11 Dec 2024 03:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733887612;
	bh=Q1kVpqhvGvq7h0HQfZsX/GFYg3+eN9/ciKegJkNWrLg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rpl2i1vOFzg/iMnL1B3BKxSAVVEF8Cb6Sdr1zK0jbNbstML3OQcIM0MWUnGiElZLw
	 0SMFS0ygf7nZIAH5ifPh8e8fMZOO62LJDmxSp4I6dO7rAZyvt4c3SOtpvjNpO7q2bI
	 yWb4FwbFLNzEfcDBZdnvCnPkVvMFW/e8KN4VieHAQioLE6dl5djmfix7gI+L6ArCfU
	 7bBOHebfQgrYpClEJ7DbDcggyLhQ1cxQvbdgggT3stPSIAinbuq1b5FHHfw79Uc+gx
	 6j/cw5cVD4ZYa7Pga+llW7Y8SgHl/sPTZEoBGdSPqEkGTLRgknYqVB62qoELbJ2OfN
	 hFY0eaJNSTGsw==
Date: Tue, 10 Dec 2024 19:26:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jan Stancek <jstancek@redhat.com>
Cc: donald.hunter@gmail.com, stfomichev@gmail.com, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] tools: ynl: provide symlinks to user-facing
 scripts for compatibility
Message-ID: <20241210192650.552d51d7@kernel.org>
In-Reply-To: <ce653225895177ab5b861d5348b1c610919f4779.1733755068.git.jstancek@redhat.com>
References: <cover.1733755068.git.jstancek@redhat.com>
	<ce653225895177ab5b861d5348b1c610919f4779.1733755068.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Dec 2024 15:47:14 +0100 Jan Stancek wrote:
> For backwards compatibility provide also symlinks from original location
> of user facing scripts.

Did someone ask for this? Does everything work without the symlinks?
If the answers are "no", "yes" then let's try without this patch.
In tree users should be able to adjust.

