Return-Path: <netdev+bounces-84072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F4889576A
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 16:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F97285381
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AD8134416;
	Tue,  2 Apr 2024 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBO7aKuV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BB113440F
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712069153; cv=none; b=MRU5slb8oxuQTGQAz/UtfFlTdWau6VKMZtKChRxQXxqyQKYYHpvtfv5DB0ErRl/lPd1IWQVaiyuDdSdV8yzkMBKP1j+VH+Utq8zW7Vd1AH818i/QTYPifLaHY+fV3n58x4kW3cCVFGDa8aQFGBhU0koBJLl6SvjP2DYKUbDDySI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712069153; c=relaxed/simple;
	bh=UibyGtVWrz9+9BrNAPSIy1+uIzqyQ/4PeWRC+1FUCYo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGF2TlaTWN6+jpjU2RBgUxebmtPlI2u1APpymaLUdSQ3RrXfy9W+Gf5dPsaOXW8D92XBiaUCIQc9Gy+YmvvGQKzF+tisu3YSSzH7zE2/pozSBLkc4NkFpxhHb/MhRAnFIS00wmngfpxUPW02c4CRnesTz7wKMb+zF01eRS0CxWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBO7aKuV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9793C43394;
	Tue,  2 Apr 2024 14:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712069153;
	bh=UibyGtVWrz9+9BrNAPSIy1+uIzqyQ/4PeWRC+1FUCYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cBO7aKuV28iHdZ/JiNN2sCm7izxC6E5W2NcVbhYZvCMSlvwlm6YOtelSks5NUEG4q
	 2jzbmvvxuRN1T8CM4TWMwDg7rmwsS5rL27mVUlyRqe2rmf3wLPVw/Jqqq6iUI4be59
	 kapHnclbph+qcKEEneWhgHh9oyIVMD4YOYdv3Int+aMnRPaTFvXAPTnDouDT8dvrn4
	 BDwtzn3ZLsxj5KYX5OklMqKzHMX6aPYMnfvN0iIPImcHXh9zRGzzkEkPIwRgq9hln/
	 DuQrazumJTFxtriQ7TJ8wjK2wqXTctXNGhjHu9pqW8zhRVLizWjZ9SIxVciZhLwyaU
	 rw/CdxXtkjbEw==
Date: Tue, 2 Apr 2024 07:45:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Jacob
 Keller <jacob.e.keller@intel.com>, Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCHv4 net-next 1/4] Documentation: netlink: add a YAML spec
 for team
Message-ID: <20240402074551.12c4fa03@kernel.org>
In-Reply-To: <Zgv4nfZzH1mXAByx@nanopsycho>
References: <20240401031004.1159713-1-liuhangbin@gmail.com>
	<20240401031004.1159713-2-liuhangbin@gmail.com>
	<Zgv4nfZzH1mXAByx@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Apr 2024 14:22:53 +0200 Jiri Pirko wrote:
> For the record, this is incomplete as this is not of type "binary" but
> rather a type determined by TEAM_ATTR_OPTION_TYPE.
> My rejected patch:
> https://lore.kernel.org/all/20240219172525.71406-7-jiri@resnulli.us/
> Makes that possible to be implemented in ynl.
> 
> Jakub, still not willing to pull this in?

Yes, I think I said this in the first LPC talk about YNL.
My main goal is to make support for higher level languages seamless.
That means someone needs to write a code gen or ynl.py-like
integration for Go, Rust or C++ (proper C++ one not just a copy
of the C code gen). Complicating the specs makes that less likely.

