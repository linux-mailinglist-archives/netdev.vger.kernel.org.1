Return-Path: <netdev+bounces-149864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFC79E7DB7
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 02:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197182857AB
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 01:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290E13FF1;
	Sat,  7 Dec 2024 01:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKVE07T1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0253C1C687
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 01:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733534677; cv=none; b=Xs8SuR+vsDzMhdciJz1FAALcy3CMZ91/+hgVCNkUngPEUv+Bg5rr7Mls5zjbgE9cYVNL3InXQ9NLSwdu8GmirKQJ9YRB/LtPeGZ+9Qcdl8xN/YOEGvt9j4VODr7B1YpgF8Z8kvEgcktHuT0f/wVWBbnrGOgGa8i0XQ3i5+4YbIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733534677; c=relaxed/simple;
	bh=T9bk7BGTh380Su1WT+BBGupsIGfyw5JRLAQO/JZSSNw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I5KXoNiHo+HdSQgjhxtW2KVetpso3DlSReOQVVEvNLasA6uKdmrapkDPBNxb+3ogNcSf1Kdda6JNGMDgwOlRoaZUsBhLgAy4U2kgMyVKsn0q693qUJrJztJ2fmTEhHLbMX5czu3qzYzuPiI76o+zAzZg7C5iprDgwqpCiSQml8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKVE07T1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1ACC4CED1;
	Sat,  7 Dec 2024 01:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733534676;
	bh=T9bk7BGTh380Su1WT+BBGupsIGfyw5JRLAQO/JZSSNw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EKVE07T15AXDtiFL8mMDieop4Ml5+OLsH9hpZUdSpvonkhOvuU4Od0GiA4073EdTW
	 0YwRleJ67Ft7D7TNXyUjeip9aqI2109VOKD8ZqLJyRhbbE6W1uug/D+0xDBI4w7H5+
	 MGD8G6QiLlTwAvnha43RX7vga/pOvLo3I3dJBkqrZpUNG/8iQgvxBPcAbmyec1ShBq
	 Z00v8+dDNlTOgxGy3Ij6zAnAALCf5MUnchTUjDT57Ain1v5WadnQeqpzMtCDmTMmiy
	 5+WxPfHCMakhVegMVaS7wFKG7TlRDJG0L3KVx9fDMZ7Py2IAMHPt6FxmQwPSdLG+CH
	 /vJInqIKMhO/Q==
Date: Fri, 6 Dec 2024 17:24:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jesse Van Gavere <jesseevg@gmail.com>
Cc: netdev@vger.kernel.org, woojung.huh@microchip.com,
 UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com, Jesse Van
 Gavere <jesse.vangavere@scioteq.com>, Tristram.Ha@microchip.com
Subject: Re: [PATCH] net: dsa: microchip: KSZ9896 register regmap alignment
 to 32 bit boundaries
Message-ID: <20241206172435.23d9091c@kernel.org>
In-Reply-To: <CAMdwsN8iXqhBW4y7WOBT1WAdhfoKhmndmODzVihkvfmmzuOj6w@mail.gmail.com>
References: <20241127221129.46155-1-jesse.vangavere@scioteq.com>
	<20241130140659.4518f4a3@kernel.org>
	<CAMdwsN99s2C=qvxEO=hmpRfvjRH6E7tww0Mfp-Q044ufi8Rn-w@mail.gmail.com>
	<CAMdwsN8iXqhBW4y7WOBT1WAdhfoKhmndmODzVihkvfmmzuOj6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Dec 2024 23:12:56 +0100 Jesse Van Gavere wrote:
> A quick ping on this, how do I best proceed here?
> Do I keep the original commit and take in account the feedback for the
> commit message or should I e.g. like Tristram recommended just modify
> it to 2 regmap reg ranges for these PHY registers?

I don't have enough practical regmap experience to understand Tristram
suggestion, TBH. Is he saying to collapse multiple ranges into one by
extending it to register that are currently not used? Or to somehow
ignore high bits? Rhetorical question, see below..

> In that case I might just as well modify this commit to make this
> modification for all the existing regmap reg range arrays defined.
> (There's probably also something to say about enforcing these ranges
> across more chips but that's a bit outside the scope of what I'm
> trying to do here)

Whatever makes the changes easier to review. If the combined commit is
small (per stable rules) and easy to review follow the feedback. If
it's easier to review the fix and then cleanup separately - separate.

