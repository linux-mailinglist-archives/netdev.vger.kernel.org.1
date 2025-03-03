Return-Path: <netdev+bounces-171420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B532EA4CF3A
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 00:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF22172145
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 23:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3845A1F0E5F;
	Mon,  3 Mar 2025 23:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jy0df6qt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7FA20EB;
	Mon,  3 Mar 2025 23:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741044683; cv=none; b=ua9yo+Pntt6UkE5naG8TSD/sYySMwbPIZz5E15523mafXyjmkF11MQiWOtQcaSZAKsej6zToMDFhRECDXicduu/Au2Bg9NqLurwHRvejvGEA1ho9TQZ2VskyXiAIbQpb0fC97TbhnTpkI3NYdRqebae50K7i6R4KPVLdtwPq68I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741044683; c=relaxed/simple;
	bh=jLdoRInvvwEShuEFZWsnPRdGs0cSl04n78oihRgyXK4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9mI/0bIxYmHk9nxW/ZOAXzfG0jMjmmukk0k1/IFDSkRlTm2iHt+MgXlrZkMoAaT09w+7epD9A3kwdvUONxq/jRR10xNa2zAFnt913I4zCWaozgnx88tSvQFtuBo57SijZYlhqB4Uusd1N8opzdurcIbnjZrT0HR9TlNohVUjWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jy0df6qt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D14FC4CEE8;
	Mon,  3 Mar 2025 23:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741044682;
	bh=jLdoRInvvwEShuEFZWsnPRdGs0cSl04n78oihRgyXK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jy0df6qtKrL7i3bQBfYZTd7mEnIg+/dWHfRx7hj06WDikx5ze4XICXn/EOqMmQrEZ
	 4H338XgrQE0BTmBgW+XbAXvNfvN98QnrD4OYnrzwqP/0aBLNRfQIfnyHdrG3Msu1gt
	 Zhtn4juPholfxhfVtS5ai8ndINTcZskpMe3s6VthCLrG20CJmH+p/IP652kXL5SvsA
	 wi+Zxi50JCOo9189onKkCEUE61zU4mo3dOUk+cNA52Z7DiRygjNK1hiK0f+R8sIkbz
	 JyDnAEKBd8AkLgvwxj1tPIe0kG9x05RpebgVmEDhMOqDWmz5XuO9TPcuUNqlNvcYLa
	 nwZYw9JuQN6gg==
Date: Mon, 3 Mar 2025 15:31:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: joaomboni <joaoboni017@gmail.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] e1000: Adicionado const para melhorar a
 =?UTF-8?B?c2VndXJhbsOnYQ==?= do =?UTF-8?B?Y8OzZGlnbw==?=
Message-ID: <20250303153121.7c730c7c@kernel.org>
In-Reply-To: <de6bcb17-964e-475d-b535-ce153760d9dc@lunn.ch>
References: <20250303131155.74189-1-joaoboni017@gmail.com>
	<de6bcb17-964e-475d-b535-ce153760d9dc@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Mar 2025 14:48:46 +0100 Andrew Lunn wrote:
> Sorry, but the Subject: line needs to be in English.
> 
> And the name in Signed-off-by: needs to be a real name.
> 
> The code change itself looks sensible.

If only we were also LLMs, not just humans, we could read commits 
in any language!

