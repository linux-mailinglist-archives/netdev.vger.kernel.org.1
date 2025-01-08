Return-Path: <netdev+bounces-156104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD15A04E89
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 02:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A1A3A41FF
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 01:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF49259497;
	Wed,  8 Jan 2025 01:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Djzgf8Lf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0803A1FC3
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 01:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736298277; cv=none; b=rmSp+kfhN/1pxfp87ZDKtcs05ixhJM3EC7w8ea7ri/syVNkI+L546P0dkvDit4OtaWxH+cI6AkKGWrHNsLKVldYx6AbHQpaZ5812gwbAzdARtF9k5fWxw3WO/06A9uXKH4Y62DqR1Gp7EyJMoSorjAVom3VZvweSr5aIGvq/M8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736298277; c=relaxed/simple;
	bh=AtCOh6V4J2hXXnvrrXpqy1hoH95QuV2a3m4ipplKz2U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/nyCTeMLf440Akl9cBiiTYLB1Qv4FI9AnvCu8P1UoVUpZ4/YBn3cby8mIR27kvqGHC5zSvtujtaSGmaPw2pgYnVoIyJrdMjd5PuuL8xO4fIVovImfimrvtHJBV4Tb9oWSsIHnxQVsVZIKIsRlATQU9bFuxI7pNnMrS/DIYZcr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Djzgf8Lf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E870C4CED6;
	Wed,  8 Jan 2025 01:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736298276;
	bh=AtCOh6V4J2hXXnvrrXpqy1hoH95QuV2a3m4ipplKz2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Djzgf8LfIuYJOMQZ1BBXv4VfdYQQ7Mj6OBXRZ5BKO72xiQ6g3jzxswiOrvdBpQT0y
	 T+G89+TK8/G5W2GfHI7TO6unIi8y4I3J3zZNeMRTIK3BVUJkoxdmu6kUnKYSCa+yTH
	 rGndr4vE37xC1EnCzVuEYT7HAhzZbO+KtHreGTutCxawOugGVwufkZJU99hcr2r/dz
	 wPvN0PHJ3ldkttRcREGnk+iosmPXBg2r3aScvdb8iVkougcVFbQ4tyebNU2bMbFNPd
	 DUC+/kxYdhnwUsfcSQvvzKENAln8BtUzolCUGawuyBlCSoN342TEgjtTcGrCilhll8
	 uU03EaM4v5HEg==
Date: Tue, 7 Jan 2025 17:04:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Etienne Champetier <champetier.etienne@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] ipvlan: Support bonding events
Message-ID: <20250107170435.57edc458@kernel.org>
In-Reply-To: <20250105003813.1222118-1-champetier.etienne@gmail.com>
References: <20250105003813.1222118-1-champetier.etienne@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  4 Jan 2025 19:36:19 -0500 Etienne Champetier wrote:
> This allows ipvlan to function properly on top of
> bonds using active-backup mode.
> This was implemented for macvlan in 2014 in commit
> 4c9912556867 ("macvlan: Support bonding events").

Would you be able to parametrize:

tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh

to run over macvlan and ipvlan? It would be great to have some
test coverage for this setup. Currently:

$ git grep ipvlan -- tools/testing/selftests/drivers/net/bonding/
$
-- 
pw-bot: cr

