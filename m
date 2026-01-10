Return-Path: <netdev+bounces-248640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42407D0C9B8
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 01:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 641B43029C3E
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 00:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADF519F137;
	Sat, 10 Jan 2026 00:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0sIwM/U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444A86BB5B;
	Sat, 10 Jan 2026 00:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768004453; cv=none; b=ZCZJZgabrPU0WvASOoUMLk+pHzVueDSZZeZFGyPr0uwfbWE4LEBSJyO3n9HIX7Ii61AFDMuTgKjfdb89JOOSqM9OqICehR/sWT+laPYXSWJfLenIgiRRY/kz+JMqb6NW6wBray6n4kkY8TR8KXIRdr9xIyZBAJEu5j+kawsS5AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768004453; c=relaxed/simple;
	bh=199lcRC5FzLZNKfgfCdzu0QKp+m3jCY2InNRphRCo1U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XsW5H2rUKDRYrUukTQUOoXaAK+Nh62VE+Ly1CixmkOsyM3HLyw8hQ06uc7jmz7RszlgB2Ae0QtkkGY3mYMj+oOc8rbW0ATgdKOcY4S4TecXNPZ11o9nc6Lv7bez4Ny+eIw2/6fPJiwg5HI+M3Rwx6GLjpB7ptt9XPxATlX1Dmos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0sIwM/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B922C4CEF1;
	Sat, 10 Jan 2026 00:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768004452;
	bh=199lcRC5FzLZNKfgfCdzu0QKp+m3jCY2InNRphRCo1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X0sIwM/UdQwZpy+j6pF8GlIvKxDwcpbsCa+Ie9glba15cwsUtxmrUMuz6PUTn6lZ1
	 fxB1AJE7WAW6esYhYxQwpQibsdZYXf3P5w+zrpACAHt5YAHBF+nVlw58WxKVBIgWEv
	 b9ESm9ar4kRRVjHkBVrjj+oaEG1FpocVNOl7t1f1xQT6/VUjg1xmsPgtvutCm8yIEx
	 5sdCQ3INCXyBOXx4EpbBCNYIJ5JGecmJeQpxWuzcmiudCWom99eFc6uLpC9wEb5f1+
	 +A5yXUN7GLUuDpvx4Cp7yPwFJFp54oboOeP+XYkcq6TB4t0gJjzq9iJjvGheG1MLc/
	 RAox2qmyJ5uDQ==
Date: Fri, 9 Jan 2026 16:20:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, linux-doc@vger.kernel.org, lorenzo@kernel.org,
 pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev,
 lukas.bulwahn@redhat.com, edumazet@google.com, linux-kernel@vger.kernel.org
 (open list)
Subject: Re: [PATCH v2 net-next 00/15] nbl driver for Nebulamatrix NICs
Message-ID: <20260109162051.42f71451@kernel.org>
In-Reply-To: <20260109100146.63569-1-illusion.wang@nebula-matrix.com>
References: <20260109100146.63569-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Jan 2026 18:01:18 +0800 illusion.wang wrote:
>  61 files changed, 43278 insertions(+)

No way anyone can review 45kLoC.
Please cut this down to a minimal driver - ~5kLoC + patch 4.

