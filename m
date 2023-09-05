Return-Path: <netdev+bounces-31993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D387279203A
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 05:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8CF01C2087F
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 03:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BD864D;
	Tue,  5 Sep 2023 03:53:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670EA7E
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 03:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5106C433C7;
	Tue,  5 Sep 2023 03:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693886011;
	bh=2Tt27aPoIM/AL822212rYJakGr4phaOlrKxLY65dfRc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ZE8jq185aVpuTpfi+0B6tJcOKYA00muUdT5zw+lm6Nn3hB14/6s02yAKZ/lc6rjqi
	 ATB3gPKpaXlRhKC1d0hYGbjMZ71NJYGc7RZnLG29md81GpQHJQ0MvC6tuuN/V4FAZF
	 S9v/ngEvOzn5Kpc90pZhsc7oWpem4pK9LEWBW1pYBAGBqp6APYA2KvzV7MgHJCITrx
	 D5s17RmA9zBIUoQAwuEu3nOoLcJfv7pnq+WgYo3yYA3r8Xqi6us9LyztbH740mYcKI
	 F3AknOE6u+9xXvEIusbCD3PsQmDi2JjYgfoCHDU8XPE4/4B0PQcqqXHU2/qFf8qB62
	 L0thO6iB7hRDg==
Date: Mon, 04 Sep 2023 20:53:27 -0700
From: Kees Cook <kees@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
CC: Kees Cook <keescook@chromium.org>, Jacob Keller <jacob.e.keller@intel.com>,
 intel-wired-lan@lists.osuosl.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-hardening@vger.kernel.org, Steven Zou <steven.zou@intel.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Anthony Nguyen <anthony.l.nguyen@intel.com>,
 David Laight <David.Laight@ACULAB.COM>
Subject: Re: [RFC net-next v4 0/7] introduce DEFINE_FLEX() macro
User-Agent: K-9 Mail for Android
In-Reply-To: <20230904123107.116381-1-przemyslaw.kitszel@intel.com>
References: <20230904123107.116381-1-przemyslaw.kitszel@intel.com>
Message-ID: <78830434-CCE0-4DF5-829C-F0D78AE35E79@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On September 4, 2023 5:31:00 AM PDT, Przemek Kitszel <przemyslaw=2Ekitszel@=
intel=2Ecom> wrote:
>Add DEFINE_FLEX() macro, that helps on-stack allocation of structures
>with trailing flex array member=2E
>Expose __struct_size() macro which reads size of data allocated
>by DEFINE_FLEX()=2E
>
>Accompany new macros introduction with actual usage,
>in the ice driver - hence targeting for netdev tree
>- please me know if it is best approach here?

Yes, I'm fine with this=2E The changes to the string headers are relativel=
y localized=2E


--=20
Kees Cook

