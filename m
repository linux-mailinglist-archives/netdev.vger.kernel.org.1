Return-Path: <netdev+bounces-154601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6AD9FEC13
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 02:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E04B162075
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 01:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47592FC0B;
	Tue, 31 Dec 2024 01:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQdKUv6s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A76747F
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 01:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735607477; cv=none; b=IxDwbsPJHu3AB76FfQFiRR1PkBQZAHkBOhsZRYWM0+AHz8RSeM8k9Vh+IBi4NhRJqEN37uOU2IeMQa08iuVqYaxHXDnq2XfK9AlGhl4SN9JLUziUu0bSTirNbWP+53HLychL485xxEDW29yGCU2xFjUx2w/NcqFRJwB3iePN3U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735607477; c=relaxed/simple;
	bh=1cU6+uyAOhBXw7YlM5sW9smvgaZX/aodJamflWbUWDs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6/5QMVUeYRYiQxcheAkt2FsS+V892Adot4/Et/D4OBzKbcfvOY0lnHt0+eGKJsmkdlxr31/9O8AnoodTdsP3R/3v/GNy8wWTlbxlKTFp116cMSGVYnGEuwUAUjVu9laRvy20OlAuPLP3w3daCqjoSyMaIEBFyCN0aLdShHiRgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQdKUv6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C16BC4CED0;
	Tue, 31 Dec 2024 01:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735607476;
	bh=1cU6+uyAOhBXw7YlM5sW9smvgaZX/aodJamflWbUWDs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JQdKUv6sGlhDLQB+IlLmA4fda+eyku4VFDLJrMjSR0u+DBeet73BnDqtrBn/8SWzU
	 1TGZj2ancPcG/VFiYoBeJJ+J8l3MpMVUq82PC4I4GYGlNXMwth3nKQWN4CYvkmGsfC
	 hgZOgmoYRulpRetwYqKryIuDXu5aAesAv+ZdofK9u3CBRgIM8NP7Emg+FHNCxb4Q5J
	 1lmSHofvduQ/Q4XcQsHqIlAQ4H9FQLc8a+ivOilVUkCXQrUbD1Fss4VcFOgiWvAmAz
	 rfbl589Dah21Y6wcMj1ZbhLkxkJm+oePO/lpz+NAHUCiQlxnZTyZ3zMS2V5PkSB/WH
	 Pe+29aGDdSaQA==
Date: Mon, 30 Dec 2024 17:11:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Xin Tian" <tianx@yunsilicon.com>
Cc: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <pabeni@redhat.com>,
 <edumazet@google.com>, <davem@davemloft.net>,
 <jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>,
 <weihg@yunsilicon.com>, <wanry@yunsilicon.com>
Subject: Re: [PATCH v2 00/14] net-next/yunsilicon: ADD Yunsilicon XSC
 Ethernet Driver
Message-ID: <20241230171115.7ee9318f@kernel.org>
In-Reply-To: <20241230101513.3836531-1-tianx@yunsilicon.com>
References: <20241230101513.3836531-1-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Dec 2024 18:15:46 +0800 Xin Tian wrote:
> The patch series adds the xsc driver, which will support the YunSilicon
> MS/MC/MV series of network cards. These network cards offer support for
> high-speed Ethernet and RDMA networking, with speeds of up to 200Gbps.

## Form letter - winter-break

Networking development is suspended for winter holidays, until Jan 2nd.
We are currently accepting bug fixes only, see the announcements at:

https://lore.kernel.org/20241211164022.6a075d3a@kernel.org
https://lore.kernel.org/20241220182851.7acb6416@kernel.org

RFC patches sent for review only are welcome at any time.
-- 
pw-bot: defer
pv-bot: closed

