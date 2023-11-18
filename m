Return-Path: <netdev+bounces-48949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F71E7F01EC
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 19:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21F4F280E35
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 18:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1301E6AAD;
	Sat, 18 Nov 2023 18:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxO1gP6A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8452199C0
	for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 18:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D603C433C8;
	Sat, 18 Nov 2023 18:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700331848;
	bh=YJOyDYoBvJYlyHinYRJxLvMdQVW1GoiV+MJuWYW3UKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YxO1gP6AwCC8ehLB+fI4QKTXo0BqHI3RGrIKtsfo2dx/q2/jWkf4aBvVuOtiQdCOv
	 lkhfcnoFS+i875r+Whpf4AnAzGrnVkzmqYs3+gblablX2O/PggT+mdfSunAkfq26F+
	 hBfl8DkaNNrHlHOudCm3TanxkIVYF/PjDiHFnTaJXLL+ZDap+sB2r4UAAGVDAkgQQN
	 SOzpBuaklBfFN85lIwIAcadOIYw+o+TsuC+ENaS5UEzdExaD4F6ztIIqkEiNSMYCem
	 PI2SfCi2L4uNNAqJZON2wvE7NGlRJ3/SKsOVg9PR2NgVDJWCDePqmdjh78NGmVxOh+
	 vQrfCTyTvbWqQ==
Date: Sat, 18 Nov 2023 10:24:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Realtek linux nic maintainers
 <nic_swsd@realtek.com>
Subject: Re: [PATCH net-next] r8169: improve RTL8411b phy-down fixup
Message-ID: <20231118102407.3943cf17@kernel.org>
In-Reply-To: <2c3087b1-706e-4b8c-839c-1db1b99c5080@gmail.com>
References: <f1a5f918-e9fd-48e6-8956-2c79648e563e@gmail.com>
	<2c3087b1-706e-4b8c-839c-1db1b99c5080@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Nov 2023 07:43:04 +0100 Heiner Kallweit wrote:
> Is there a specific reason why patch has status "Deferred" in patchwork?

No idea :S

pw-bot: new

