Return-Path: <netdev+bounces-85385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6D289A8E8
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 06:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEFAE1C20ED4
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 04:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F012019479;
	Sat,  6 Apr 2024 04:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihk7jvBd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6342914
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 04:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712379384; cv=none; b=ZPSoBtBHxP1L827iThM037SEYSC4xJToD5RvOCHvyXewJTNGDmWXoJNRDrOtokH0vLYFWXD/dk4fCgdbiY5iDl3wef4Fb9PSwbOdwjmk6FQJQA/pi8/ngsXQNamLpNSzepDQuRJZPYl+NRIbqbyuKNXQ9zTlmFVYwY8dQRuyK9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712379384; c=relaxed/simple;
	bh=NPXN6wuI435nnF+gsEURsTVr62WTlc8UCiEsfT4uRHY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Am6AABN5JRRaATcC3TENn3jzwC6gnvMcNU1RsXo/bJquu1XG1y9t+ULXBQ1jks6YWj2NQN45sO49di8jKewi75R0+/ZVHFIPAbuuJS1uh668FFOOgZ/jM2lKzR7SHgNySjalafIk3PRQHDE75qwaeOEcRKzA/IejJ1j37fKgeto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihk7jvBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5706C433F1;
	Sat,  6 Apr 2024 04:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712379384;
	bh=NPXN6wuI435nnF+gsEURsTVr62WTlc8UCiEsfT4uRHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ihk7jvBdNxnQS1PQFX34WG+vDA280p013anLW0KaLsEhuMGgX7Nv/qPixFNPLT4fP
	 H/+M4W9KXz3oyud2B7doVh6ePnLD4GLtSzUYpaQNZNZAQK2dFDXbVKw7cl0CD7k0X/
	 O8bKMjB8fgy1QeOQjvkyB1+nEr1uxWxnPqn9Bx0VwgE11spbpnhRNtGbplB2Edi+Zn
	 hB7h02YUx+CvVzaRYiruTnESk/3zkxUD3TD42H8eLfmUON02AeUPcgq9CxWSSP0hQm
	 moEhgEwFNy3Pg7LDU9ZZPZYGejBBG0Fx413Sn5QcTIva8fOIOmBKzZdth9BJJz1eqK
	 yMKAhzQkDRxYw==
Date: Fri, 5 Apr 2024 21:56:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net-next 0/5] mlx5e rc2 misc patches
Message-ID: <20240405215622.0ee75f66@kernel.org>
In-Reply-To: <20240404173357.123307-1-tariqt@nvidia.com>
References: <20240404173357.123307-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 20:33:52 +0300 Tariq Toukan wrote:
> Patches 1-2 by Cosmin implements FEC settings for 100G/lane modes.

> Patch 5 is a simple cleanup.

Don't wanna hold these patches hostage to the stats conversation
so let me take these already. LMK if that's not helpful.

