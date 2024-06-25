Return-Path: <netdev+bounces-106315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302CE915BC7
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 03:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620451C21500
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6C21862F;
	Tue, 25 Jun 2024 01:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+jUKneQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862761B806
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719279607; cv=none; b=anyzM395OPSDUp8loyBzT8rFv9HVUuBr6HjBFz0AwRgihRGVsaercx9kmKs/I9WwfOmYmar4rcse71bBV+eCJkj1uxEJbQPF4ZaAEllPuGQquhi7Kv7fPft36stNLsehPPjajNTRqXGI2+v1HTPaWKgMPdI20C9meMyrGA1ukMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719279607; c=relaxed/simple;
	bh=gEMk1n73Wb3oUO8qNzTRjivoXpQVt0yt6g8Ics0pzlo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/kUE88klLCVBARH9WYeAXI9V7Da1Uf6cSneAuTVxSVNwGbazBEI4kbO5Au00c3VB3ncd2ZzviotN3IpeppCLo2pt+pH742rPBoqlcpevd6aNJYtwVHslJ5gx1+Px/ND+PIrI9oJZrKYOZAfiVdYuJDt5q4xRt5rt66xIxxoi+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+jUKneQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B90C2BBFC;
	Tue, 25 Jun 2024 01:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719279607;
	bh=gEMk1n73Wb3oUO8qNzTRjivoXpQVt0yt6g8Ics0pzlo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y+jUKneQ+o9lWvKe8RwEp0PtThIRtKSgJQVYjikWPkxsEr5aoCKb/5Zu2YgiZ1uEH
	 RzF5ElaBrbUW2qF0a06q3RTbj9ay1fFaNqZiVKHYRX0/sL33icWyoxgBzszzIgUYU8
	 Z5mxKVBNulRkF2zHQFEczWtdcQ3BGNywvmVkQSh74vC0PK0XArwD7fF+uIoc+brVAK
	 RtRGcETDDbZ8qv4700bjOFXsqG15/cKVD0s7j9fXQ1NR6LX0n5hK5LFZrhyhOrVXkd
	 l29d/IXqFn6BGo7BMdVjWaqQiMtsAXdzRAp/mEgOqRwkAP0Vwnv0IYTCydlcg9Rv8B
	 5AxO0hXZLC+hg==
Date: Mon, 24 Jun 2024 18:40:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 willemdebruijn.kernel@gmail.com, ecree.xilinx@gmail.com, dw@davidwei.uk,
 przemyslaw.kitszel@intel.com, michael.chan@broadcom.com,
 andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v2 0/4] selftests: drv-net: rss_ctx: add tests
 for RSS contexts
Message-ID: <20240624184005.5725f01c@kernel.org>
In-Reply-To: <20240625010210.2002310-1-kuba@kernel.org>
References: <20240625010210.2002310-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 18:02:06 -0700 Jakub Kicinski wrote:
> v2 adds a test for removing contexts out of order. When testing
> bnxt - either the new test or running more tests after the overlap
> test makes the device act strangely. To the point where it may start
> giving out ntuple IDs of 0 for all rules :S

FWIW if I create the context with an indirection table, and then change
the key (without touching the indirection table) - it all works as
expected. So really seems like bnxt has a problem with setting the
indir table when context is created. That said I don't see anything
obviously wrong with the driver code.

