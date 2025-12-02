Return-Path: <netdev+bounces-243143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A73C9A046
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 05:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BCE64E0666
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 04:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AD91DE2A5;
	Tue,  2 Dec 2025 04:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmClQCsn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AA62AD35
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 04:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764650235; cv=none; b=bI21tq3xzcWNftIDrlICM36IjJHnDd+/PBjn3wfQ0PMy4ldfOgci/RdTOY6BjaHXX1HkDSa9+l7CGBYRfGJcvDc0VHkI++daiAdrv3I7N3SmIr1aAkfyP2pENiIRYJfXC/tN5LtZkQNU8XKmX817BSB5QQeg8qf8EzmwM11HTFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764650235; c=relaxed/simple;
	bh=S6Xt23V0jPucA5Cjtx7tCokqfDY9IXspCSvNW7i/kC8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AbqULO94rfI/UlT7ImOnrWIqKX0sSlLaKe8aGbvsPWqP0scn4WUOdKaOOt1zPSJivqAE72+cODTmfazbrWa/YNEK6nsgB1xY3tjWVD3D9pxZwgZ3aR4oQHpxgM1rr5u82/jo8EungoQ9yotVDv64UrnFeDIyRg81nzZ3qr+67II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmClQCsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B88C4CEF1;
	Tue,  2 Dec 2025 04:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764650234;
	bh=S6Xt23V0jPucA5Cjtx7tCokqfDY9IXspCSvNW7i/kC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MmClQCsnJfR5VJ4rC2Ty0uUOtFwEOcG45CQMd2EDIRsN9jllqRWoqVa6kymEBPg0L
	 vujaNkzHIR/xq5RYays1407GrV3EM7ZC4ge01ab8sjQpJBnc4djbmQaWR8Kgjcw3Da
	 Zfs3fOlmm9PFj1MpaeaTbGeqxJ08Hz+3x7ID1TjJLnqskcSRvq35wkdLDK0qPuZ/uX
	 oahdaxsPPJ84QJqjkWkgHRsmeZpCiwjehtADo9S+BN6BtBc5v/2hUTQSYlyeARzZVF
	 rXNBZs+V6pLhQmt20U6h7ISs5PECGVymcJ61stQtbXngx8rQ2wfGy/+C4S08Ip2zQc
	 EnSbkNzDBdEDw==
Date: Mon, 1 Dec 2025 20:37:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next 00/11] wireguard updates for 6.19
Message-ID: <20251201203713.58118d7e@kernel.org>
In-Reply-To: <aS5av6CuCukeFO3G@zx2c4.com>
References: <20251201022849.418666-1-Jason@zx2c4.com>
	<20251201150729.521a927d@kernel.org>
	<aS5av6CuCukeFO3G@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Dec 2025 04:19:27 +0100 Jason A. Donenfeld wrote:
> On Mon, Dec 01, 2025 at 03:07:29PM -0800, Jakub Kicinski wrote:
> > On Mon,  1 Dec 2025 03:28:38 +0100 Jason A. Donenfeld wrote: =20
> > > Please find here Asbj=C3=B8rn's yml series. This has been sitting in =
my
> > > testing for the last week or so, since he sent out the latest series,
> > > and I haven't found any issues so far. Please pull! =20
> >=20
> > Hi Jason! Thanks for the quick turn around! You say "please pull"
> > did you mean to include a PR in this or should I apply the patches=20
> > from the list? =20
>=20
> I meant from the list, because this is what Dave preferred way back
> when, when WireGuard was a young pup. I actually prefer sending pulls,
> as it feels less redundant and generally unifies my flow with how I
> submit my other trees to Linus, and plus it means you can check a signed
> tag. So I'll make a pull here, below. That gives me the opportunity to
> drop the buggy 10/11 patch too.

FWIW we do still ask for patches to be posted to the list. But some
folks like to do _both_ that and include a branch/signed tag in the
cover letter to pull.

Pulled now, thanks!

