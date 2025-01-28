Return-Path: <netdev+bounces-161298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE698A2088E
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 11:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D7D1680C5
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 10:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4534119CC06;
	Tue, 28 Jan 2025 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="O/llAech"
X-Original-To: netdev@vger.kernel.org
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC69A19340D;
	Tue, 28 Jan 2025 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738060227; cv=none; b=QVtXg2/pkXH+cFDfHYNSNRNaFgKUGCkaClZavSsPgOKPcZCv3+kEGQOx41lBgUbgRFMTnHlxyePFHk0O7WbUIyHvLjfP3Y7d4RO4xGermcVeoHAjhMNb9GIpOrmrf0ENqwuVGpDub6DrdJAc3Nm/2N6sSR7p1XzpFW913SS5fyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738060227; c=relaxed/simple;
	bh=Gu0SMikx9E+aiSkI/kCZrt9NpgxCNeOd+8Ljhdb64a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F0ysY9baUSRAqQW+3N0vUyRssXTHyRoES0r45xWnrLfkluvoRX1ntl48mhh+l33PBU65J1BoNCz/m1haNCRM6kXuxUsvea9IG3jXPtZeTccxqNpGwI8BKgFvlDz3cV806DQwOFvXIKVD6vG3jzr+IOi+rG6kmtHfUCPZrwloMeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=O/llAech; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1738060222; bh=Gu0SMikx9E+aiSkI/kCZrt9NpgxCNeOd+8Ljhdb64a8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O/llAechEAjYWFD9brL31+6agHvPNqdWFBmh/MLFy4SYAlT7tRsuZAMhRQUJVr55I
	 B7fYNhDvymBjOr89lKoMgv0EBKhH9+ewl8ASX8SUHyme5XJ6G4+24nO8vSxqHckg0Q
	 8PxiC8V3Ly3wQgKyjPM/nz6xVZKrxq0F/d0bY32A=
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com
Subject: Re: [PATCH v9 4/8] rust: time: Introduce Instant type
Date: Tue, 28 Jan 2025 11:30:21 +0100
Message-ID: <74FCCB7F-3906-4576-B0EB-DB98E76B5822@kloenk.dev>
In-Reply-To: <20250125101854.112261-5-fujita.tomonori@gmail.com>
References: <20250125101854.112261-1-fujita.tomonori@gmail.com>
 <20250125101854.112261-5-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 25 Jan 2025, at 11:18, FUJITA Tomonori wrote:

> Introduce a type representing a specific point in time. We could use
> the Ktime type but C's ktime_t is used for both timestamp and
> timedelta. To avoid confusion, introduce a new Instant type for
> timestamp.
>
> Rename Ktime to Instant and modify their methods for timestamp.
>
> Implement the subtraction operator for Instant:
>
> Delta = Instant A - Instant B
>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

