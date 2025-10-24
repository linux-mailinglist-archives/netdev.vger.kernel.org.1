Return-Path: <netdev+bounces-232729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3EEC085AA
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 01:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29FA33B543D
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 23:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F55430E83A;
	Fri, 24 Oct 2025 23:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B66In4xN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E3D30B514;
	Fri, 24 Oct 2025 23:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761349969; cv=none; b=rtoa6gyLg0L8xAuV4Oz8YAfNvonkDERuoE/D7FZlR6T0BWOdND3mpn2kIulOi1pB/dpxybDTa0hIR4g+RPHZGcMxGMwkr91QbzOyqbaDLyn0KqAtfMBugZdWgmO3Lqx/FcqhoZBCVIKvVZMpwy2FO6M/U5bCcWBcca06nHgwwig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761349969; c=relaxed/simple;
	bh=b0jfHYj44WW3Zp+PPuXiv/hESxuovunxR5Sto+KsZP8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J3FzNb1ucG97+WJIl4rs2x/LTzspE0y6i4PsnHsft/Pzo4uTVmFLeRLQw7+SGhehdtrE+Mpuo5ZN3bL65QUQ8RK5gCWfx4Q7BI0/LFkRjvdQEkR6FmTxAmJnKWf/dN7pDAKQb19yndWWTjt8dkz/nV797ABUKomrofxd8dzIHdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B66In4xN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3827AC4CEF1;
	Fri, 24 Oct 2025 23:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761349969;
	bh=b0jfHYj44WW3Zp+PPuXiv/hESxuovunxR5Sto+KsZP8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B66In4xNCNxVEDQGPF8TPmdcO39k0bqwoxFirR2qqcGP05m9QpA8T+NoWo0XO4ppM
	 tTwWLWDqeCSudvqHzVtXygwe7c9d0NxMbTwW2KzwJSJ9ySzFXjAVL7MSy/cd8zpz3t
	 eJGeaFzaEwJKyGGiDSE0nOzPrRQLE+G6IuAqmyf45ycjXD95HubYAOcrXvm4DXocmV
	 ZCEHtqQyQc1xTy0mcqzDYdlQPetyOmmHxZeHArhWGS8m0dMqYaMf0KYBkBPqkZiugG
	 n+qC5RCRrFL9Z2sYkqbPA/GWZlmkwJY3HhUqo7kdpS4dWWtmNDNl2llAWZwkDyrzpZ
	 dH85M0c66uWUg==
Date: Fri, 24 Oct 2025 16:52:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Chia-Yu Chang
 <chia-yu.chang@nokia-bell-labs.com>, Chuck Lever <chuck.lever@oracle.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Simon Horman
 <horms@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "Jason A. Donenfeld"
 <Jason@zx2c4.com>, Zahari Doychev <zahari.doychev@linux.com>
Subject: Re: [PATCH net-next 0/7] ynl: add ignore-index flag for
 indexed-array
Message-ID: <20251024165247.5494ea93@kernel.org>
In-Reply-To: <ee3b6ed7-a00d-4679-9aa6-482b8064d18f@fiberby.net>
References: <20251022182701.250897-1-ast@fiberby.net>
	<20251022184517.55b95744@kernel.org>
	<f35cb9c8-7a5d-4fb7-b69b-aa14ab7f1dd5@fiberby.net>
	<20251023170342.2bb7ce83@kernel.org>
	<ee3b6ed7-a00d-4679-9aa6-482b8064d18f@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Oct 2025 19:19:10 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> Do we wanna do the same for sub-type nest in the python client?

> as the WG/Jason bandwidth seams pretty limited atm.

Please focus on what's needed to get WG implemented.

My "bandwidth" for pondering cleanups that may not matter in practice=20
is also limited. Main goal for YNL is new families. Polishing the old
stuff is a huge time sink.

