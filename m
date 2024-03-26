Return-Path: <netdev+bounces-81866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B338D88B6FF
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 02:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90FB7B22C75
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 01:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CDF21362;
	Tue, 26 Mar 2024 01:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlQ3rYgb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CA61CFB2;
	Tue, 26 Mar 2024 01:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711417359; cv=none; b=TgrV4ZL9Rkbkz/KKf9nS6PUsBaEZ9GR3rxyaCHcnUvdO47fdnmSwRU40CROgtB1EO7UvSl5qZvZHvZu5l5frtDIrLwyZ/lJfx6Npp14CCTHy9NwMFvLCDSHXs6sM1jZPwNbwGblNOjNA/J8xxQayJpQbccZGT23wykIKNaSm7EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711417359; c=relaxed/simple;
	bh=cZ6v5V99Dnf667GHfXx8dOjxbW4TM7gnOeT0ksyBVqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EQ8mpafxZK5YPUfP8rahCWsPvBtkSnC9+5pKVMkfoizZpzg7Icdo6FqPIRcg3vN/s44mOZyi5fi/wZXWv91nclGSIJeLOpArGdwC1/VVIwnNSu8MYodRERaGSB95PqVc7lyaltDORtU6yCFN63fOhSyrFyG0hWrfQs+3rWWQgc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlQ3rYgb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530B9C433F1;
	Tue, 26 Mar 2024 01:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711417358;
	bh=cZ6v5V99Dnf667GHfXx8dOjxbW4TM7gnOeT0ksyBVqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TlQ3rYgbJ3LMZZnOVGxKUABZh9uIxKr4TMeCJD/n2r5JDuW2XpKXcqVyIldARUlXO
	 Ucw5O/68hD5W0ceblsbOjvZhUWk9XQTvNcnYEgkohCiQX3MyQEv57v2n1NFZiFo9p9
	 uo2n5RzuP8poCt+YB0WK3w2gkNh0aG3/09Gexjpw9MIvFPZSP2TT7DLpdsqHAp5DeM
	 51YxXru+CauNpBl8iP1+IzaQz3RbT8AdDc+WsxAWRqSwXfzg7KZDbRwTr1JP7DUZ5N
	 FwHPu39Cl6c1JhNg9IL7TSG9SCJqMUdmT15hbEW6iUgmcKeXyNqW8Go7T3KYcqOfUd
	 1SwbfIgT3NxNg==
Date: Mon, 25 Mar 2024 18:42:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [TEST] VirtioFS instead of 9p (was: net-next is OPEN)
Message-ID: <20240325184237.0d5a3a7d@kernel.org>
In-Reply-To: <34e4f87d-a0c8-4ac3-afd8-a34bbab016ce@kernel.org>
References: <20240325064234.12c436c2@kernel.org>
	<34e4f87d-a0c8-4ac3-afd8-a34bbab016ce@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 17:32:54 +0100 Matthieu Baerts wrote:
> With 'virtme-ng' used by NIPA, it is possible to use VirtioFS or
> OverlayFS instead of 9p.
> 
> VirtioFS seems to perform much better than 9p [1]. All you need is to
> install "virtiofsd" daemon in userspace [2]. It looks like Nipa is still
> using 9p for the rootfs, it might be good to switch to VirtioFS if it is
> easy :)

"All you need is to install" undersells it a little :)

It's not packaged for silly OS^w^w AWS Linux. 
And the Rust that comes with it doesn't seem to be able to build it :(


error[E0658]: use of unstable library feature 'is_some_and'
  --> /home/virtme/.cargo/registry/src/github.com-1ecc6299db9ec823/vhost-user-backend-0.14.0/src/bitmap.rs:87:14
   |
87 |             .is_some_and(|bitmap| bitmap.dirty_at(self.base_address.saturating_add(offset)))
   |              ^^^^^^^^^^^
   |
   = note: see issue #93050 <https://github.com/rust-lang/rust/issues/93050> for more information

For more information about this error, try `rustc --explain E0658`.
error: could not compile `vhost-user-backend` due to previous error
warning: build failed, waiting for other jobs to finish...


Onto the ToDo pile it goes :)

> If you want to use OverlayFS (e.g. to mount the kselftests dir), you can
> use "vng --overlay-rwdir". If you use "vng --rwdir" (or "vng --rodir"),
> 9p will be used. Maybe better to recommend that on the wiki [3]?
> 
> (The MPTCP CI didn't hit the bug with 9p, because it now uses vng with
> VirtioFS.)

