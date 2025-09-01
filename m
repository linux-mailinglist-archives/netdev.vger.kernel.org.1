Return-Path: <netdev+bounces-218844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD941B3ECEA
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 19:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B19AF4E31D6
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 17:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB85C320A05;
	Mon,  1 Sep 2025 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDs2aYC6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B31320A03;
	Mon,  1 Sep 2025 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756746339; cv=none; b=AxEVN9lr0w2/3d8MglWCSHXZGm/qFQzBdraMHPIsHRAzY+2feyBBopVXQPAwxo4hdGb1TnOFYshpXJSJawGNU0LSYW1cx6NY5YIxhvIkg2u1pDYzyaCo5K0lvRAROl32Zrbw3Tv+26q1Zhx/XIQjpBBaCUiBNlWVk6GtZnN6++Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756746339; c=relaxed/simple;
	bh=3SkoNn/o/FjTxi5s9+HexncXthA3P0meTbPdq9Pqarw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uA2uEI4gTUFuyGCW3JgY3nELJCIPjBp7GBeYlORuC+ToKzQO/dsReONM432pYxkcpXxF89uPY37ZD0iXdSACspe2+Hq+JfYdHgZqKiDblR0abmViXebl7LOtHCR+XE0OtybJbatr/bvqXlJEkb70z1XKInPNNiooi4iMFTPL8EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDs2aYC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79476C4CEF0;
	Mon,  1 Sep 2025 17:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756746339;
	bh=3SkoNn/o/FjTxi5s9+HexncXthA3P0meTbPdq9Pqarw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MDs2aYC6KZMmzTW+rt748f0O+Fe9Ar1WeWycuCJyT5TUnKbYLHsGpkXS0sVhxHJAP
	 +WSXHdqr9RIDsg8y9IeA4a0IaqZnNHVdf9TLJNL5kZO8zR2l4XK82sFgYqfqi+tDYq
	 /W1K5Py3J58KvRwLovIq09KPR6wXlpx5uAf3UnCgNL0pcmHzlcVLwYrkirw2Qn3Zds
	 LAQ3QSbe+hblhdZhY0VJSwM5u7eYQUDxf3nmkF7LrlNjeB1gVkq2jeQvKrogSBOnnU
	 wU0BXFVlwNA9GGNB9jchHBsyXlFmjK0XYq3IcmToxFdU4i+Px8AayjqWrQ6rM8FQoI
	 p/KiZo5fx2wFQ==
Date: Mon, 1 Sep 2025 10:05:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Schmidt
 <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v3 5/5] dpll: zl3073x: Implement devlink flash
 callback
Message-ID: <20250901100537.23a0903e@kernel.org>
In-Reply-To: <e6cd77a7-bc18-4e0c-9536-5fb107ec4db4@redhat.com>
References: <20250813174408.1146717-1-ivecera@redhat.com>
	<20250813174408.1146717-6-ivecera@redhat.com>
	<20250818192943.342ad511@kernel.org>
	<e7a5ee37-993a-4bba-b69e-6c8a7c942af8@redhat.com>
	<20250829165638.3b50ea2a@kernel.org>
	<e6cd77a7-bc18-4e0c-9536-5fb107ec4db4@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Sep 2025 18:34:14 +0200 Ivan Vecera wrote:
> 4. Keep my original approach, fix the ignored error code reported by
>     Jakub and pass "re-start normal operation failure" via devlink
>     notification.

4 is fine, we can revisit when another such device appears (tho I
believe this is an increasingly common way to implement FW update).

