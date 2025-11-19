Return-Path: <netdev+bounces-239758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E75BDC6C356
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD7A04EBCD8
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 01:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D138B1EB1AA;
	Wed, 19 Nov 2025 01:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByKHzKNV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82F71A9F84;
	Wed, 19 Nov 2025 01:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763514049; cv=none; b=IvPr+DBNyF7MLv449Zk1ypgI3gE8XpvlQrvFaKPc8j1rgoGPIjiRztWMNbcWU9aK3o0VPY0SLx4u34Gwto/7LQ4hmyeGRLGl9Sd6p3AIuWiVDLNfEIIvBh954gqxumLKK5rIsROMEayFMea/dGsWCz8tXZMI1ee8IJJnGc/ULkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763514049; c=relaxed/simple;
	bh=CQjZ0N89SVdwQBbPJ9aCn3Gqm4WwXY0obje6FxdqVi4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=smMPWgaGdS7s0qHhwI7P6CZnmTj1nsRTR6GOzDGyctZbWBoBcAdd9JJprXA/+6JuzhX9ogrMIqbXHFr0BgraCOvJEWdJ9jrrU4iODB6D+T18sVCj6KNFUJd5dm2jzA5MrS85aaMd1NAvhjJlamsbeqP+5ASRkhhJITxCeF4ZqIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByKHzKNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBA8C16AAE;
	Wed, 19 Nov 2025 01:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763514048;
	bh=CQjZ0N89SVdwQBbPJ9aCn3Gqm4WwXY0obje6FxdqVi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ByKHzKNVLOSLn5LEw/fWzSjuif5JJLGakx1Tgrd8qkQe2MPOT3tQ6mow1lI+10WE0
	 8bGknq3Y1JL6fh17+RlVvn6pak65A9gpgOW4nTaCB/thLahgGL98lucmYQR9PPwFf4
	 pPhsme4RVZhMDlnc9I6Jh7IdZkCrIkgzl0TQFyY7nZBXIrIDtw5A3SFUV4BBDcNCUl
	 E27Bi3x7+HfH0GSgOFvSUyrNAOu7nku315vyMQ0oaoAa5dEpG1FfeQSg0ObytjWJjD
	 KCfoE6AqWjoLj4DVY6KuoAUvTxO8i1dkNyLBlexQiolgPPSimIreBiyS6pL378bPRh
	 XdZGFKOHdEGiA==
Date: Tue, 18 Nov 2025 17:00:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>, Donald Hunter <donald.hunter@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jacob Keller
 <jacob.e.keller@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jordan Rife <jordan@jrife.io>
Subject: Re: [PATCH net-next v3 11/11] wireguard: netlink: generate netlink
 code
Message-ID: <20251118170045.0c2e24f7@kernel.org>
In-Reply-To: <aRz4eVCjw_JUXki6@zx2c4.com>
References: <20251105183223.89913-1-ast@fiberby.net>
	<20251105183223.89913-12-ast@fiberby.net>
	<aRyNiLGTbUfjNWCa@zx2c4.com>
	<d2e84a2b-74cd-44a1-97a6-a10ece7b4c5f@fiberby.net>
	<aRz4eVCjw_JUXki6@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Nov 2025 23:51:37 +0100 Jason A. Donenfeld wrote:
> I mean, there is *tons* of generated code in the kernel. This is how it
> works. And you *want the output to change when the tool changes*. That's
> literally the point. It would be like if you wanted to check in all the
> .o files, in case the compiler started generating different output, or
> if you wanted the objtool output or anything else to be checked in. And
> sheerly from a git perspective, it seems outrageous to touch a zillion
> files every time the ynl code changes. Rather, the fact that it's
> generated on the fly ensures that the ynl generator stays correctly
> implemented. It's the best way to keep that code from rotting.

CI checks validate that the files are up to date.
There has been no churn to the kernel side of the generated code.
Let's be practical.

