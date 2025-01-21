Return-Path: <netdev+bounces-159987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8B8A17A3F
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 10:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE3816A154
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 09:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB711BEF91;
	Tue, 21 Jan 2025 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXXBL5LX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063AA1BEF82
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737452039; cv=none; b=KjVeuD5yiHYfxySOz2F9FqIEL5UJyoEUt2KroUhN36CnixTeERlMk1xwa0+WSDGWpDgQM6qRe6SLOQQ5rykz6ZhpQK3jy5szrDWXItiVqJ5tb6kGX0XFOIPuvQ/V22BCJSU7TII/3MtS/Ta7oWTxzP2FHzdBas+QSACwlzzwfGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737452039; c=relaxed/simple;
	bh=e6TimPx7ouec9YtTSSuiajrV4fB+uxQXs8SL/4d1m2U=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=kf25bsXxENbfqmazca5JeddIzLEiQQRGdEBMrKEK34JpNwN5rtA3/VhoSISFScscLmEb3hODRGGBG11/Q7x4Ban+/eTu/r8cTjQleqW9VEs0OyUvrGg5PRbhUzsaFsz9Kz6FMyfrFVU3eBs3isRV2kABy6+UgGO614e29IBUjhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXXBL5LX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70A0C4CEDF;
	Tue, 21 Jan 2025 09:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737452038;
	bh=e6TimPx7ouec9YtTSSuiajrV4fB+uxQXs8SL/4d1m2U=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=UXXBL5LXiG6uXYL40VozBZpEwwQnmRjbwVx+/umlISY1dgek7WzgW2w36qx4zhBgA
	 Ev2ZLvhKuv+3eFt8iHKsIPa6UtAUdOK2AZebqskqPzWMQg5q/EVBvMLFCORXD/s+M/
	 YCjJVOdGPXf1RqvE1XB23rQyg1Mbom1527Mj+fTd0Upw7lhHn1ukH2YDuf4peWCSMi
	 FfXZY1RTSgx3ZyhiZhEw8SRHb5pvYFLStnSKcZOmnn4jHFJebV1XRIGlXfpA2C1tn4
	 T0F1cOZczp2pwmgY0qu+lUK2bpeA2nwOlbu20lUzEjQwIzrnnFVJw70hJtg+4SIuo7
	 06+Odug/N2Ivg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250120114400.55fffeda@kernel.org>
References: <20250117102612.132644-1-atenart@kernel.org> <20250117102612.132644-4-atenart@kernel.org> <20250120114400.55fffeda@kernel.org>
Subject: Re: [PATCH net-next 3/4] net-sysfs: prevent uncleared queues from being re-added
From: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, stephen@networkplumber.org, gregkh@linuxfoundation.org, netdev@vger.kernel.org
To: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 21 Jan 2025 10:33:54 +0100
Message-ID: <173745203452.4844.5509848806009835293@kwain>

Quoting Jakub Kicinski (2025-01-20 20:44:00)
> On Fri, 17 Jan 2025 11:26:10 +0100 Antoine Tenart wrote:
> > +     if (unlikely(kobj->state_initialized))
> > +             return -EAGAIN;
>=20
> we could do some weird stuff here like try to ignore the sysfs=20
> objects and "resynchronize" them before releasing rtnl.
> Way to hacky to do now, but also debugging a transient EAGAIN
> will be a major PITA. How about we add a netdev_warn_once()
> here to leave a trace of what happened in the logs?

I'm not sure as the above can happen in normal conditions, although
removing and re-adding queues very shortly might be questionable? On the
other hand I get your point and that might not happen very frequently
under normal conditions and that's just because I'm hammering the thing
for testing.

It feel a bit weird to warn something that is not unexpected behavior,
but if you still prefer having a warn_once for better UX I can add it,
let me know.

