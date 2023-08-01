Return-Path: <netdev+bounces-23399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A03376BC73
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 20:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9460281B95
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 18:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD33125171;
	Tue,  1 Aug 2023 18:27:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E42200AC
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 18:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19B3C433C8;
	Tue,  1 Aug 2023 18:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690914425;
	bh=mosc7i7TrFKlVAqRUEEd2D4Rc4OD9vWmQ24pw0g4E2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lg40y4nhaey64qQ0nqfY6Gl1fv8wqVElGcjOwPIGfc8cyyq8KMHVLZUWh60uYZDlW
	 fYET+SqVD/0a4UVcf9HBH7Hg1d00pFgOuOqhpD9JOoM13WaHpCR1RjEvv05CgxDyjG
	 Gf88ZfKXGlRCb0N3GpDRwgfAO2OGyn+fQupkGszG/ie5+gk/hChgRRaSJ1lRw4QmaV
	 V5PYzOIr6eDu5LCgZ+s9EcIxPrX4ZWumK4m3+YX6Rros1J3M3Lbg9hRiAMuU/NYkQK
	 MPNjYMc0t0gefZGhpvjjOj6SqgorxnQj+iEUSiRw6GePjtg7iGg86C4awIOV8WFZ7S
	 TwC4w7hXWMynw==
Date: Tue, 1 Aug 2023 11:27:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
 idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next 2/8] ynl-gen-c.py: allow directional model for
 kernel mode
Message-ID: <20230801112703.2690f706@kernel.org>
In-Reply-To: <20230801141907.816280-3-jiri@resnulli.us>
References: <20230801141907.816280-1-jiri@resnulli.us>
	<20230801141907.816280-3-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Aug 2023 16:19:01 +0200 Jiri Pirko wrote:
> Directional model is only considered in uapi mode. No reason to forbid
> directional model for kernel mode, so lift the limitation.

I mean, the reason is that it's not tested so this way
I don't get people sending "fixes" claiming stuff that's
not supported is broken :)

