Return-Path: <netdev+bounces-211735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE42B1B5F9
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 16:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E8618A3504
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 14:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF7827874A;
	Tue,  5 Aug 2025 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1NE9DSs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A96278143;
	Tue,  5 Aug 2025 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754402638; cv=none; b=AVzedSzvW0eSJF+cCfAC5ZcSMmaaHobREsadIi/oNQ8Mm3OePo3cE6m1hCrxMvqnbOhiVyEVqXR+O60MACzxdBW9yq6lImrsBfVEf7nfhUW9WZqGJunOG13SBkBSrQjQ3VEcEW3Xbasa2vv8zBbX+oWCxJmMoBoxaINJGJxq44s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754402638; c=relaxed/simple;
	bh=a//RMkT7QxB02c4HlMWI/+kv14S5DssakZHwqBJWWZk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=AHcwZV5h4DthSqC/UObUYX8BgoJsryHH4uxwAmUqubQplj+bsWEqZ/hClflQ3qBUT9Hs8OJbLuC4SUFhC/xrt6IHpYA646zIp3s2LMQJWOKqqadbukvZUplxmJzJAtY4hYo/8VnDnvnTxeA7JswR/Nnng/MwnP63VKFn+nalUFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1NE9DSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09E6C4CEF0;
	Tue,  5 Aug 2025 14:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754402638;
	bh=a//RMkT7QxB02c4HlMWI/+kv14S5DssakZHwqBJWWZk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=d1NE9DSshfhbYDTNXm+5NbN6aUpYBAQdm3bKJU0MD+xVAEWDbmfPaJJzGOhYIZvI0
	 wpa6r765xkC3RhDGnM0uLB+tu/uok6Z+TlAlEdF+swOx3nhITBA4oxUxXxoTGjet/G
	 TypCJ7y+mnQTcCVLLE48pXOId3Nml8P/j/bBBqLLTjUiEpNqHYy3aw5At6yRdKhJDB
	 s16joxFp5GulzVFOi6h0eCbUk0hID0a8SyXb6PMWdQAbnJNBOLGjDT0604BuzPQUHC
	 7fcyJsbe2PtQhQ1/GOZEc0N8EQrDUeDFWmPS1fFoz0rtkz2lfW7/ZT2JvuclP9EISG
	 I/+LfEn80FqTQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Aug 2025 16:03:50 +0200
Message-Id: <DBUJTTW31QCI.9EJMRC5RPYLK@kernel.org>
Subject: Re: [PATCH v11 7/8] rust: Add read_poll_timeout functions
Cc: "FUJITA Tomonori" <fujita.tomonori@gmail.com>,
 <linux-kernel@vger.kernel.org>, <daniel.almeida@collabora.com>,
 <rust-for-linux@vger.kernel.org>, <netdev@vger.kernel.org>,
 <hkallweit1@gmail.com>, <tmgross@umich.edu>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <benno.lossin@proton.me>, <a.hindborg@samsung.com>, <aliceryhl@google.com>,
 <anna-maria@linutronix.de>, <frederic@kernel.org>, <tglx@linutronix.de>,
 <arnd@arndb.de>, <jstultz@google.com>, <sboyd@kernel.org>,
 <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
 <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
 <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
 <vschneid@redhat.com>, <tgunders@redhat.com>, <me@kloenk.dev>,
 <david.laight.linux@gmail.com>
To: "Andrew Lunn" <andrew@lunn.ch>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <DBNPR4KQZXY5.279JBMO315A12@kernel.org>
 <20250802.104249.1482605492526656971.fujita.tomonori@gmail.com>
 <DBRW63AMB4D8.2HXGYM6FZRX3Z@kernel.org>
 <20250805.223721.524503114987740782.fujita.tomonori@gmail.com>
 <a843788e-80f4-49d3-96f1-1da092ee318c@lunn.ch>
In-Reply-To: <a843788e-80f4-49d3-96f1-1da092ee318c@lunn.ch>

On Tue Aug 5, 2025 at 3:53 PM CEST, Andrew Lunn wrote:
>> I also prefer the example that can be compiled however I can't think
>> of a compilable example that is similar to actual use cases (for
>> example, waiting for some hardware condition). Do you have any ideas?
>
> Does it have to be successfully runnable? Just read from address
> 0x42. If it actually gets run, it will trigger an Opps, but it should
> be obvious why.

No, we have all three options.

  (1) Don't do anything with the code.
  (2) Compile it, but don't run it.
  (3) Compile it and run it as kunit test.

In this case we want to compile it, but not actually run it.

- Danilo

