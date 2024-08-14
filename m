Return-Path: <netdev+bounces-118497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6581951CCE
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92FB1C20BEE
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1784A1B32D0;
	Wed, 14 Aug 2024 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKfD58OF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64FA1B32CD
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644769; cv=none; b=aovkBDkOLiAU4iC+EgbKVd6DoV61x5xZSCh7JOlhFP031J5lVkncyy/jsTBFFNkl7uz6bqXz0Vi6/EZPgxqkV3DaHvFSQ99S3S+SYX4GdfHu4IXei8UocDFPYY+EQcxbEy6Q44h/+QQFiqnIfK7K2vROIW05Jf7HsjrBwoXXK3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644769; c=relaxed/simple;
	bh=QtOrxtHHWDDt8+8dPdJugVWMtw0UPwj1AxRqqn7M3cg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q4+hhsnq8ln00b/sU7sohyDNgKyglxpVhil2X0jz3XL+SIgzZzFGmuPOpWF9JzupEQ1V2TVNEkDX8WcgxVUgJjTNaat/AQKaKhjGkeJScFmyYzizfQMwQRcdhILpICFoqMeN4gY6HkNdUDeddAYvzUUuKsJNxBgup3gg4z4PBpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKfD58OF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745D8C4AF09;
	Wed, 14 Aug 2024 14:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723644768;
	bh=QtOrxtHHWDDt8+8dPdJugVWMtw0UPwj1AxRqqn7M3cg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DKfD58OFeGadyEftJXoyjUhsJ9uZxxy7ANL5qtrD37ooQEugGI8xf/Mq12n8jL2/w
	 pvLNuH5r5ARfBtWN0HX7VDoNQ4ieHDj8VWxLNAM4fymHFDKUBrY0lgxlkV2ROKT+Dp
	 ZhKHuj5ajbTEsOJWdtwICxxR4ErXcu37ZDJRVyjwJ88p6DiAftkH8+7eSyNHS/Zmfk
	 BTLomihlLFhznymlyW7nXvxV03nGR3iP7vG9k95ONOZhYP9PX3ppruXgmPJXeqNFGN
	 CUCNZ9JLINZE0nSdVzfS2JhOo7aSmQh6oARuwI6UCmTzIqrXG8LTNbTQHEchtuByGf
	 Imx2AcM0dyfCw==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8079214AE014; Wed, 14 Aug 2024 16:12:45 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: =?utf-8?B?TMawxqFuZyBWaeG7h3QgSG/DoG5n?= <tcm4095@gmail.com>,
 stephen@networkplumber.org
Cc: netdev@vger.kernel.org, =?utf-8?B?TMawxqFuZyBWaeG7h3QgSG/DoG5n?=
 <tcm4095@gmail.com>
Subject: Re: [PATCH iproute2 v2 1/2] tc-cake: document 'ingress'
In-Reply-To: <20240812044234.3570-1-tcm4095@gmail.com>
References: <20240812044234.3570-1-tcm4095@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 14 Aug 2024 16:12:45 +0200
Message-ID: <87mslfchwi.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

L=C6=B0=C6=A1ng Vi=E1=BB=87t Ho=C3=A0ng <tcm4095@gmail.com> writes:

> Linux kernel commit 7298de9cd7255a783ba ("sch_cake: Add ingress mode") ad=
ded
> an ingress mode for CAKE, which can be enabled with the 'ingress' paramet=
er.
> Document the changes in CAKE's behavior when ingress mode is enabled.
>
> Signed-off-by: L=C6=B0=C6=A1ng Vi=E1=BB=87t Ho=C3=A0ng <tcm4095@gmail.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org>

