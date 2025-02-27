Return-Path: <netdev+bounces-170381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F742A486A1
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 18:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133143B60E1
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E331C8636;
	Thu, 27 Feb 2025 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="JL52TaCD"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9452F136351;
	Thu, 27 Feb 2025 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740677477; cv=pass; b=Fuo6VdumJvj8w6YDNF3yr8LyIFZcgLtEvU8HEU7BFCIL4hcCxUalp79sXDLsxoDtOtzieu0ha9ALZ1L1vDO1kII4nu5FgL8VWYfY4rAppRpZFba0pmr2Y5STzUcHCIVLxkKgUD3Px3frrrr2/dSOTaZ5Cdk/Av/GaHD8yTGb+hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740677477; c=relaxed/simple;
	bh=pY0h9Uqj3mrF8jCMF8B0UPDavohCQ9bLCBbrtld9yos=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HM/4GydM6ZonVA6S4ZuUnJ8hsP/3csIzwjyMPsulgiAM1zLeVHLfnp71VK+N8DVh7Ha5lOXmmT8eEbFN0cbdU9pl8KJajDlTS1RiXfJgzWT6FI4HjHHdBe9M6t5JvoriKjs85F2gu2GoCYQhchE/QBOpMzJSe/O8CP+IRFpMqIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=JL52TaCD; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740677409; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FTN4iejmJbD3zVMnol9SB/PeFykB9egs/6XaEr/QRjdTPaUdScVFt6lCZY6KEANYdHHDJy7fCZuRPdBEpKhrEFG7SHykfe5UPS7hwBGtm0xkzcnKbd5SR/flZeOajo7BsHmUaYtj9Oy6dqmuWmfeWKJ/d+BDkF/l/rqtyKNJqSg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740677409; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pY0h9Uqj3mrF8jCMF8B0UPDavohCQ9bLCBbrtld9yos=; 
	b=OU4vLbh9z0Wy5rSJIPqAAiv0qNUjz4AmXUiLWpQ6fsJ4kSSGuqcfvGLDSTn8l8rsgKSm+TYNAJvdbiFXFpff2EF+3lU9XW0t1n3J8Dt0zKrNbhbPtRxzDCmO/xocviDo06i+l3xHHXTQomiq4gfIwGQ8FnbThMVrM0Ysr0rng5E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740677409;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=pY0h9Uqj3mrF8jCMF8B0UPDavohCQ9bLCBbrtld9yos=;
	b=JL52TaCD/b1D2zQ/WgtmajSca6k2sVDq6Nnt4Hj57q3CcJEGAv4w7b1HwGEUjIJr
	xVwrhtV/sA5C2hjR/uK6oo5gsYD3G5J5JLwnyLLVnxa42ojnl2h8udtN5mKbNquqzsD
	VGlODyRoOomK1FPb5kIcGn0UJJHSCdPZqrNCSB/E=
Received: by mx.zohomail.com with SMTPS id 1740677406210259.24822276471855;
	Thu, 27 Feb 2025 09:30:06 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH v11 0/8] rust: Add IO polling
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250220070611.214262-1-fujita.tomonori@gmail.com>
Date: Thu, 27 Feb 2025 14:29:45 -0300
Cc: linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org,
 andrew@lunn.ch,
 hkallweit1@gmail.com,
 tmgross@umich.edu,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 benno.lossin@proton.me,
 a.hindborg@samsung.com,
 aliceryhl@google.com,
 anna-maria@linutronix.de,
 frederic@kernel.org,
 tglx@linutronix.de,
 arnd@arndb.de,
 jstultz@google.com,
 sboyd@kernel.org,
 mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 tgunders@redhat.com,
 me@kloenk.dev,
 david.laight.linux@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4647720C-28CA-4E18-AD1E-55844CF078E6@collabora.com>
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External

Hi Fujita,

Would you be interested in working on read_poll_timeout_atomic() as =
well?

There would be a user for that.

=E2=80=94 Daniel=20=

