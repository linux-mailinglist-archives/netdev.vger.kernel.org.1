Return-Path: <netdev+bounces-211736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A2EB1B63B
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 16:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734B71881819
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 14:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED253242D70;
	Tue,  5 Aug 2025 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eevpzFOU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB261922F5;
	Tue,  5 Aug 2025 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754403588; cv=none; b=JEIFRyHNUDvFopWk23Jg0l+yAsDlClGPan13ptLyGjHmEMDtTfVLlxJO23H6AhCqDgw8IO3jPMWz3wTPTMex2flf0/+dnST2XQe285QvAd5sw0DFC8Y2oJagSioGx4Nrqo/7eSjMRDJhi3939MBjWnrKYgX0h+BauesnmbI+mEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754403588; c=relaxed/simple;
	bh=qTEZUer1H4ZcprZzz70kBbVa9sj/l90KNdD+ATD283U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=gAoHfyEgYvre4CnTSvT1Tn8Z7qJwDcqojsuQ4J0Eh1SlmTW2T1ilibuonRn8eqQEwzPmv3YFG+18kLbjNx6KGGGajpqMoJ1Aij/nRJ9/ncDPi3uihy1awOY78Eh+qpk8+ZGxlA1Jk1DOGzlqUTm0EcA1Ji5ymxHQmuyKQhElDus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eevpzFOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF2EC4CEF0;
	Tue,  5 Aug 2025 14:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754403588;
	bh=qTEZUer1H4ZcprZzz70kBbVa9sj/l90KNdD+ATD283U=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=eevpzFOU5YTn+zpYFCLQEjUpyujZJSUGwCRRgqeVciUuMoqskMySCUzXbHR68zIRY
	 pRVUBpL/GUTfxhY0o3p6+cN6cTdjCc30nl9fBqm/9qOAL7QQrO6p0dYFnDVSIUkn0r
	 0DwByh6tXYVlm6Ii7SNC3jznakiiQ1KMvRTX7MvaahvBw/EJlmkFsGiGivntk6odRQ
	 Ili0RviuBrwJFGZMZiQX8bJq/9sjo1KR2kDzzFi3i5wMf/2fDrTem6fGjIVtw/t5Da
	 63fKpgk4gygpKDNRU/o2L4sL3xzJRsYKozTBV7LIQGZdYSaqQKpq0U1CBUZEXJMOpb
	 2r+kAqMM8a7Pw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Aug 2025 16:19:40 +0200
Message-Id: <DBUK5YDTU8BH.3676DH8N0WQ6Y@kernel.org>
Subject: Re: [PATCH v11 7/8] rust: Add read_poll_timeout functions
Cc: "FUJITA Tomonori" <fujita.tomonori@gmail.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <netdev@vger.kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
 <tmgross@umich.edu>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <benno.lossin@proton.me>,
 <a.hindborg@samsung.com>, <aliceryhl@google.com>,
 <anna-maria@linutronix.de>, <frederic@kernel.org>, <tglx@linutronix.de>,
 <arnd@arndb.de>, <jstultz@google.com>, <sboyd@kernel.org>,
 <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
 <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
 <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
 <vschneid@redhat.com>, <tgunders@redhat.com>, <me@kloenk.dev>,
 <david.laight.linux@gmail.com>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
 <20250220070611.214262-8-fujita.tomonori@gmail.com>
 <DBNPR4KQZXY5.279JBMO315A12@kernel.org>
 <20250802.104249.1482605492526656971.fujita.tomonori@gmail.com>
 <DBRW63AMB4D8.2HXGYM6FZRX3Z@kernel.org>
 <DCB831D1-8786-41BC-A95B-44F0BEE71990@collabora.com>
In-Reply-To: <DCB831D1-8786-41BC-A95B-44F0BEE71990@collabora.com>

On Tue Aug 5, 2025 at 4:01 PM CEST, Daniel Almeida wrote:
> Perhaps it=E2=80=99s worth it to clarify that in the docs for the future =
versions?

If you mean the documentation that is given out to users of the API I disag=
ree.

We should not explain the implmentation details or the reasons for them to
users. Instead we should explain the constraints and what users can expect =
from
the API and what's the best practice to use it.

If you meant to add a comment to the implementation itself, that's fine of
course.

