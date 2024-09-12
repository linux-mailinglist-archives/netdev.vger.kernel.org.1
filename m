Return-Path: <netdev+bounces-127848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD8A976DE7
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40DE51F227FE
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 15:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774901BB6A7;
	Thu, 12 Sep 2024 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7hjT542"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7DF53365;
	Thu, 12 Sep 2024 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726155468; cv=none; b=HtUdiSdEjwWJScPkdeT2ddqHarV5zg+qkL2kbpIDmXFUOn60GOjF0mlFhq5KSoE/7e7X3FMiVvB+pp+IbLULu840Zj0yjHb2yaGucJfA3b3KyfQ/qwXAT+TQ49vdpwuwTEzluyaSoSnqVYCNgrFa6lDIj5DY97VUWUIeQbCw2oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726155468; c=relaxed/simple;
	bh=VDEkcdKckh9mPuSApnR6EFdrLs0vpu+n/LBlESm4vi8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jAFTqpL/9npNbuz0n6S0XuNvSwsG0JQFRTz8QpkPk34zdMvBy5h7zhRHKIvuq5cawuGv71lbxlPeBOYQLNWhwvqyEz3Z3bDRW/t05slxhykJZIOmtmS38bM3PMT457vf0X97FRzJWkBVKw/so1EouOo4C+BzWqrufhAR51diud4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7hjT542; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8905DC4CEC3;
	Thu, 12 Sep 2024 15:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726155467;
	bh=VDEkcdKckh9mPuSApnR6EFdrLs0vpu+n/LBlESm4vi8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p7hjT542MlZrTY4Z6loWP4DsEIRjTOEyV/pgDOCs8Z/Wetc+L5eAsMCHhrmPm4hV4
	 kQ5Rz51v1chPfSPPjatsbr2MHr1YQswS6zzsxAFiXd+Jo2H0b07ynmKHekNxS85k7k
	 jrFvE2vUiEu/agtHg4G6H5BhpU4ZykA8nPyApKsM4gbJ8QGWoaWXutuWqAwz1Qg5Oi
	 OZ7Mh4zcyUZA5mmRXIZrSZLnl9zyZU5B2x9Cr69aOKqzdbM9CwGaE/V42u2x9g3ZW/
	 BTK7rOaA5kDI26HRtjQiguo0EMVNPCI5L+M9K16an0JtYerEMw4FRLPflHbiPDOJMG
	 2PnKzcEAQLfGQ==
Date: Thu, 12 Sep 2024 08:37:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Juhl <jesperjuhl76@gmail.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: igc: Network failure, reboot required: igc: Failed to read reg
 0xc030!
Message-ID: <20240912083746.34a7cd3b@kernel.org>
In-Reply-To: <CAHaCkmddrR+sx7wQeKh_8WhiYc0ymTyX5j1FB5kk__qTKe2z3Q@mail.gmail.com>
References: <CAHaCkmfFt1oP=r28DDYNWm3Xx5CEkzeu7NEstXPUV+BmG3F1_A@mail.gmail.com>
	<CAHaCkmddrR+sx7wQeKh_8WhiYc0ymTyX5j1FB5kk__qTKe2z3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 15:03:14 +0200 Jesper Juhl wrote:
> It just happened again.
> Same error message, but different stacktrace:

Hm, I wonder if it's power management related or the device just goes
sideways for other reasons. The crashes are in accessing statistics
and the relevant function doesn't resume the device. But then again,
it could just be that stats reading is the most common control path
operation.

Hopefully the Intel team can help.

Would you be able to decode the stack trace? It may be helpful
to figure out which line of code this is:

  igc_update_stats+0x8a/0x6d0 [igc
22e0a697bfd5a86bd5c20d279bfffd131de6bb32]

