Return-Path: <netdev+bounces-242091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E575C8C2D6
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 23:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 13BCB354B87
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 22:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB77341AAF;
	Wed, 26 Nov 2025 22:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggMmjrh4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FE1341657
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 22:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764195422; cv=none; b=ZCPKZug++Tg/i4SP+6WGHMQ3tYTHqt7DaUHriDDBYWiI8WwKqK4qJQTsUXaJZY1g36qioy9VKkvDyd2MfmOzxvrKF+AgZSBIbKkLCwZCzJPJRIYqgaNpiSn50Mw2J0FPK0K0FkK7+p3fSmtuNwrTryIHdyIxLlUB4oz5Sp0QjCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764195422; c=relaxed/simple;
	bh=aAxGd23yGdRGx/torS4QjMNOgGUoIR+/FGbNgug9Nvc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rGBbNb6ZEjA7UfWs8OLsUgv2u7WJrpedR74ocIjL4bXW20axGnTYx2oKbe/EedmlbEsw48mZovoAi0Wz9ZfeKZxUM0SM2E8Rfd15t5dK7RuaJNXmM57f4xv16CiF2GXuqTdP8YuYpT0np2JO0m+KsBYabIwAMQiBTfX53YBFj5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggMmjrh4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C7DC116D0;
	Wed, 26 Nov 2025 22:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764195421;
	bh=aAxGd23yGdRGx/torS4QjMNOgGUoIR+/FGbNgug9Nvc=;
	h=Date:From:To:Cc:Subject:From;
	b=ggMmjrh4DEOfDI4XQVBg2Kc26wFHh7tLfffRP6C4i71z/ukc8EDnTOdCZXgWEqzJJ
	 mD/HiJrAtmR0wmUfyHjArifZGxz8AahCgF/a3W4vxJuCg7SH27sO8onOebojOSiUgm
	 la53vrtnk7PlMUTVtzo8TEdOfbxEdwZN3IErF/lP94WAyA/dTSPECXgHjreBXjchzN
	 fQGw/dNG4x+TjzBIOOM2Yv0v5qWrwVLWm3suOFCjM/E8af7OI3MOu4krmlx87C9sWY
	 0KX8GePuaYWn4fgXfhyherYUDvv+I3DkQ5D3yc8lQfTTkk1IDgF02dIOxPuKXZC9Y5
	 mHgb05vDHwS/w==
Date: Wed, 26 Nov 2025 14:17:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>
Subject: [ANN] netdev foundation TSC meeting notes - Nov 25th
Message-ID: <20251126141700.25c097cb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi!

The netdev foundation TSC meet on Nov 25th.

Lab update
 - NF machines are not racked and running (replacement of existing NIPA set=
up)
   - HW meets our needs, so order for a couple more machines was submitted
 - DNS entries and certs added
 - Migrated build and VM/ksft testing; control and DB bits still remaining
   - build is noticeably faster which is nice
     - old AWS build system has been shut down
   - kselftests are flaky in new ways on new setup (virt-X remotes)
     - we need to stabilize them before shutting down the AWS system
 - SSH access granted to a few folks but in general pending appropriate
   automation

Funding: PHY Testing SoW
 - Approved.
 - 7 yes from 8 present from 9 members
 - Quorum is 50% (reached); Votes are made by simple majority (also reached=
)=09

New project suggestion:
 - Paolo suggests improving / re-implementing AF_ROSE
 - Simon will create ticket

AI review-prompts now live in netdev CI, for now reporting to patchwork
only as "warning". Need more confidence before email reporting.

LPC: should we have a =E2=80=9Cmaintainer talk / Q&A=E2=80=9D? 30min in the=
 AM?
 - Will hold before official start at 10am
 - Paolo will =E2=80=9Csquash=E2=80=9D schedule into remaining time

Next meeting canceled due to LPC and Xmas break.

