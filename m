Return-Path: <netdev+bounces-210066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79B9B1209F
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 17:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D2A4E29F7
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 15:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A692ED152;
	Fri, 25 Jul 2025 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t69suO+u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9EB2E975D;
	Fri, 25 Jul 2025 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753456100; cv=none; b=di80xmoV9x9nq6JnQxC7THsVcTRibDODmyvPAkRSoWkh7YOmIETcA3ZWoWFvXVyX//yomB4GK6WJpyq8EVoste+dMd91wvhbPGIvAzAoCcOTw5/3z3VTp84XUXdFDj54xO8av9YvuhdeHkB9DFiWKchi5oBG+2pEt9wO6biLIuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753456100; c=relaxed/simple;
	bh=RgP/I5xzFjHokNJb2q0Vr3LX2nhBVZvuO6jEeTUvmi8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ARwSHQVyk3WVUsztSy+Q47cy3CoRf5uURSt+s0zSdj6mCT3i7t5OgwURf7BpBuRlAvUDEvMC8UM8bKCOMldgXw+WFApab71wwtYIGK0b5A5+ZE0V8AKNB23rzNlbrA0za9FeQF1v9dEWtLSvvMWkft8j2d+4H9p5IRBXHCj75Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t69suO+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC46C4CEEB;
	Fri, 25 Jul 2025 15:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753456099;
	bh=RgP/I5xzFjHokNJb2q0Vr3LX2nhBVZvuO6jEeTUvmi8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t69suO+ugCmAN4V0i0ihJYjYA5wxZLSAzzPaPo2FyiW2grf/gfby8L4+y11uf/p30
	 ceIi/CnOXoJqtd5FULOEVl9VWhKZYZ9L95HhCOyiYEXPVw28cbkGQEBhTEu2/NjQ0Y
	 P0SibnvlKAL9Adr+e97i7vaa5lCGP6o/s9JYP0ejpvW1HRGo88Zlkbclg2NY6icVYq
	 URFI8Wz/w5Xu9wneTkDIlhWDiz6HiQssTwB632H7PWjDxnWiJRf3LVQEpUD4zgKTZl
	 0VLA+Tm6j7HOWDijUae7sTCKd1aVEjNLD9TmSfdVNYH91SMklECQHGicaQ6+zpQEHo
	 UFI3e492dg6RQ==
Date: Fri, 25 Jul 2025 08:08:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Carolina Jubran <cjubran@nvidia.com>, <oe-lkp@lists.linux.dev>,
 <lkp@intel.com>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 <netdev@vger.kernel.org>
Subject: Re: [linux-next:master] [selftest]  236156d80d:
 kernel-selftests.drivers/net/netdevsim.devlink.sh.rate_test.fail
Message-ID: <20250725080818.3b1581c5@kernel.org>
In-Reply-To: <202507251144.b4d9d40b-lkp@intel.com>
References: <202507251144.b4d9d40b-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Jul 2025 20:34:58 +0800 kernel test robot wrote:
> kernel test robot noticed "kernel-selftests.drivers/net/netdevsim.devlink.sh.rate_test.fail" on:
> 
> commit: 236156d80d5efd942fc395a078d6ec6d810c2c40 ("selftest: netdevsim: Add devlink rate tc-bw test")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master 97987520025658f30bb787a99ffbd9bbff9ffc9d]

This is not helpful, you have old tools in your environment.

Ideally you'd report regressions in existing test _cases_ 
(I mean an individial [ OK ] turning into a [FAIL]).

The bash tests depend on too many CLI tools to be expected
to pass. Having to detect the tool versions is an unnecessary
burden on the test author. Tools usually get updated within
3 months and then all these checks become dead code for the
rest of time...

