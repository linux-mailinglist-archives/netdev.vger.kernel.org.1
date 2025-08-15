Return-Path: <netdev+bounces-214107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1E2B284CA
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 19:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A77620676
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 17:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DA630FF3B;
	Fri, 15 Aug 2025 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efXXM/Pg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8105A30FF33
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 17:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277917; cv=none; b=eOkkLASOiCwtUV18JVQXSwAMG+6XjUSLD7fxroPPnZJBXfjP6YQO3Qz7D06e5lhIDf3F2RpxEaifmJ4nGHCXlJ83/D+3hoL7b7JsQfKnsc4roqhwvMntqRb4Ogk49VJL6Jdd6F2ikIOK/I4HId+PzRT7sZLtjd75Tem07V7p28w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277917; c=relaxed/simple;
	bh=JIDg/zXfWZb5HPlYQhF1XdzN4BXKBXkUxXfCaxFgE4E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=etZx16r1GbnuMaa/0fI+Wr/KyRsOj51Z/zL919pinJq6gZr7+EQbNw2DS8iGZjREpqYAZ8e1d0fzR8Di6zkvZ4XnrBO4nGztGeL5tvLx7INqPI9M2qTbj+mBp0P7fL5bSUogbySJC0LI1HQ83X6hifuiNOAxPbXQcgPyl/7OMzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efXXM/Pg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B94CC4CEF1;
	Fri, 15 Aug 2025 17:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755277916;
	bh=JIDg/zXfWZb5HPlYQhF1XdzN4BXKBXkUxXfCaxFgE4E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=efXXM/Pg8b8NjqYpw8KYggIghQoGSTx5ic1kWDvKmX4QyAsywqQdHHfQaRYP09kS7
	 I4UVO5ta+SKU/Gly8pE9H4A16958UbKH1cmbFCnd36dZQfMxjH83dWz03Hw+fDwB+D
	 Rpb5BHkImVR7Rjs23jPbH01PTdkStm39FsfQYtlPZNkJcK9NgjoDuO3JWFO7bZER7Z
	 ulQOwXQVlD25reedSmd2ATTHCtKqi196aySgVNXdrf4MwmjtsY5ZJ28y2pkYSWCgD0
	 mLtp7VJBWsQtoTl9AL+1LVioPHcQTAfgXOrp4a6vuG40/Qc5Wo/1ZRwc5HyFSBEeas
	 d8Obuv5+WlRDQ==
Date: Fri, 15 Aug 2025 10:11:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Guilherme Novaes Lima <acc.guilhermenl@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: Seeking guidance on Rust porting for network driver as a
 learning project
Message-ID: <20250815101155.0c777734@kernel.org>
In-Reply-To: <355E9163-9274-49C3-98AB-7354B9C091B7@gmail.com>
References: <355E9163-9274-49C3-98AB-7354B9C091B7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Aug 2025 12:05:14 -0300 Guilherme Novaes Lima wrote:
> I=E2=80=99m a computer science student working on a graduation project
> focused on learning more about the Linux kernel and Rust. I
> understand that the kernel maintainers have been cautious about
> integrating Rust, and my intention is not to push for any immediate
> changes, but rather to explore Rust porting as a learning exercise.
>=20
> Specifically, I=E2=80=99m interested in working with a network driver to =
get
> hands-on experience. My goal is to comply fully with the community=E2=80=
=99s
> expectations and guidelines, and to better understand the technical
> and cultural aspects before considering any real contributions in the
> future.
>=20
> If there are any maintainers or experienced folks willing to offer
> guidance or suggest a suitable driver for this kind of project, I=E2=80=
=99d
> be very grateful. I=E2=80=99m not asking anyone to do the work, just hopi=
ng
> to learn and engage respectfully with the community.

You are specifically asking about in-kernel network driver code,
which, well, perhaps this is too blunt but personally feels like
a significant waste of community/reviewer time.

If you're open to kernel-related but user space coding - a port of YNL
to Rust would be most useful:
https://docs.kernel.org/next/userspace-api/netlink/intro-specs.html#ynl-lib
We have sort-of-a-port from C to C++ here:
https://github.com/linux-netdev/ynl-cpp
But nobody to my knowledge attempted a Rust version.

