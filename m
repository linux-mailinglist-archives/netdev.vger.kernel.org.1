Return-Path: <netdev+bounces-250365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5580FD2971D
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 01:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 722D23010CCD
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 00:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F7A259CB6;
	Fri, 16 Jan 2026 00:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGuPUjDQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF1518024;
	Fri, 16 Jan 2026 00:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768524550; cv=none; b=kXiwqbzsNK71kXTjwEPAtX33qkqVgprZPqMfjIs3Ae2/mSlyK+wX5bmM1CoNk6d35JTHwi9+63Yrcm/K3JQKs4grR1GL8QlrnUfxz1JQMZMRVDP0Va4KKTxcM8YCEbehhi5y2R1ihCU9Nr/UbuAVi3+evLfwWoDPtnknnFWgjDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768524550; c=relaxed/simple;
	bh=c/iR+WuctXgCv8wSCh30Fb2j7NHxGjCYQkGC2UPAJBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDAA4IRJh4RtDMkRzZbD16I/dcKjrLFIT6FKy4n58J545faVQNl5TyuZkA8l/5lTIiyZa+T+FH4D6KuM3JC1cbqbCUKqyzhZhV5Dp3k6771JSI97ik79VMfWpMhQB7FARwXyPiM/A0qnFFQduT4YcB/IHyGcFVpEZVrzfufLyUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGuPUjDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED476C116D0;
	Fri, 16 Jan 2026 00:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768524550;
	bh=c/iR+WuctXgCv8wSCh30Fb2j7NHxGjCYQkGC2UPAJBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KGuPUjDQZ6nOjt0uvjTMfeI5ARIpeyZZjFgiywpIkEo/Eah0KxeawvfQVrHrBcTqx
	 MWUyjarLMhAbU+7d9Qw3LlzJ/j5lcueS+ZDcsZTBayTQL9lwBzII5iT9SpHwMM7FnB
	 Ds7xDH0E0VQlfVurmkmedThcU7Ubn+JWwV1XyrIwCV4Gj4MSS+rsHY5ft/KO5KZu7U
	 0paXfa7DTgaOPTXHPXqSYYKCHi4Sy2TU7OCy0RQKR5dIuUDHinQV6QLCS9PRDE4Cck
	 fvv1/qMuhmlOKvfBgJDp8cn4xghTg+utoV9eVznn2Xt1+P9eVC6PTavVGaZc8bECFv
	 Ixoim0pv09W+A==
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	oss-drivers@corigine.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] nfp: tls: Avoid -Wflex-array-member-not-at-end warnings
Date: Thu, 15 Jan 2026 16:48:49 -0800
Message-Id: <176852452747.3062255.8603964657157273318.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aSfDqouLFcA4h8JX@kspp>
References: <aSfDqouLFcA4h8JX@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 27 Nov 2025 12:21:14 +0900, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> So, in order to avoid ending up with flexible-array members in the
> middle of other structs, we use the `struct_group_tagged()` helper
> to separate the flexible array from the rest of the members in the
> flexible structure. We then use the newly created tagged `struct
> nfp_crypto_req_add_front_hdr` to replace the type of the objects
> causing trouble in a couple of structures.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] nfp: tls: Avoid -Wflex-array-member-not-at-end warnings
      https://git.kernel.org/kees/c/cfbb53d25cfa

Take care,

-- 
Kees Cook


