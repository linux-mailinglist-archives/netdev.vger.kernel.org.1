Return-Path: <netdev+bounces-95604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5978C2C88
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 00:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30D41F22BBC
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 22:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859CC13CFA8;
	Fri, 10 May 2024 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vp5I/vqt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD5913CF92
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 22:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715379565; cv=none; b=n5Njf1QUYzGcqPhsVfNHkn99kqXcjhG7QcUlcJecG3lL0NV7LiVL3IH/GxfM0PgaBRS/MGEB59Y434oEuXe9Bi1F7KC9X7AEJlUiWvOJKZWgWA5tUlEId7PMkUejlRFjbfxXwFWPSlxc4k1QnMKFO/7s3tZ0PQBd8yj8De8Z6Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715379565; c=relaxed/simple;
	bh=P6LZgUfn8EsQd61zA1klV7El2DjPzYvWkadKS5OylZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLZY02l1+WjvZTNzRkRyCJuzi+tgSnfZ9nRzuMZfKv0AvS4jTAW4B1WGDllgLHe+hTwPneZ/1FvIPpnVY/p+hH5BLmGM3CYpX7XcYkbhBO0UCG3S7AfwEQs4xVKI8X+je5wQklealOb19B3IZLWIW9peLLOkQf/9BcMM5+HI+QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vp5I/vqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96A0C113CC;
	Fri, 10 May 2024 22:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715379564;
	bh=P6LZgUfn8EsQd61zA1klV7El2DjPzYvWkadKS5OylZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vp5I/vqtR9nIAwaQTuntzPUwoAr6G3VZITwbIylviRMuj+Kub+XAkD+2addUqiXMz
	 X9T1Frv9XyQFFnMbd/2b1/IDkgGiuLx4BPTstMOUpKLr9a3c5OnmdgnByF5vCwGsgU
	 KxlBbq/sZuXt94FagxoVgbxoHXw34TKwkFBfLl8DIChgbOhMD5Dk0hxYX4NG1Klm/a
	 4N9FG60BGsfPvnRdPC8ao45rADZg/avCFqphfR5hho4oIkihtju8l/+a+Yv90UC31d
	 DGjb6nYpLvN5eoqGyJZbwsjyAMwE44fgIzM8DEiPet46stOj3l5jyvK0mFkefKZHnK
	 h9petVXoqwWZg==
Date: Fri, 10 May 2024 15:19:23 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com, borisp@nvidia.com, gal@nvidia.com,
	cratiu@nvidia.com, rrameshbabu@nvidia.com,
	steffen.klassert@secunet.com, tariqt@nvidia.com
Subject: Re: [RFC net-next 01/15] psp: add documentation
Message-ID: <Zj6da1nANulG5cb5@x130.lan>
References: <20240510030435.120935-1-kuba@kernel.org>
 <20240510030435.120935-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240510030435.120935-2-kuba@kernel.org>

On 09 May 20:04, Jakub Kicinski wrote:
>Add documentation of things which belong in the docs rather
>than commit messages.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>---
> Documentation/networking/index.rst |   1 +
> Documentation/networking/psp.rst   | 138 +++++++++++++++++++++++++++++
> 2 files changed, 139 insertions(+)
> create mode 100644 Documentation/networking/psp.rst
>
>diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
>index 7664c0bfe461..0376029ecbdf 100644
>--- a/Documentation/networking/index.rst
>+++ b/Documentation/networking/index.rst
>@@ -94,6 +94,7 @@ Refer to :ref:`netdev-FAQ` for a guide on netdev development process specifics.
>    ppp_generic
>    proc_net_tcp
>    pse-pd/index
>+   psp
>    radiotap-headers
>    rds
>    regulatory
>diff --git a/Documentation/networking/psp.rst b/Documentation/networking/psp.rst
>new file mode 100644
>index 000000000000..a39b464813ab
>--- /dev/null
>+++ b/Documentation/networking/psp.rst
>@@ -0,0 +1,138 @@
>+.. SPDX-License-Identifier: GPL-2.0-only
>+
>+=====================
>+PSP Security Protocol
>+=====================
>+
>+Protocol
>+========
>+
>+PSP Security Protocol (PSP) was defined at Google and published in:
>+
>+https://raw.githubusercontent.com/google/psp/main/doc/PSP_Arch_Spec.pdf
>+
>+This section briefly covers protocol aspects crucial for understanding
>+the kernel API. Refer to the protocol specification for further details.
>+
>+Note that the kernel implementation and documentation uses the term
>+"secret state" in place of "master key", it is both less confusing
>+to an average developer and is less likely to run afoul any naming
>+guidelines.
>+

[ ... ] 

>+User facing API
>+===============
>+
>+PSP is designed primarily for hardware offloads. There is currently
>+no software fallback for systems which do not have PSP capable NICs.
>+There is also no standard (or otherwise defined) way of establishing
>+a PSP-secured connection or exchanging the symmetric keys.
>+
>+The expectation is that higher layer protocols will take care of
>+protocol and key negotiation. For example one may use TLS key exchange,
>+announce the PSP capability, and switch to PSP if both endpoints
>+are PSP-capable.
>+

The documentation doesn't include anything about userspace, other than
highlevel remarks on how this is expected to work.
What are we planning for userspace? I know we have kperf basic support and
some experimental python library, but nothing official or psp centric. 

I propose to start community driven project with a well established
library, with some concrete sample implementation for key negotiation,
as a plugin maybe, so anyone can implement their own key-exchange
mechanisms on top of the official psp library.



