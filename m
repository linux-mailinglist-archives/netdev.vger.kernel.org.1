Return-Path: <netdev+bounces-103430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EA290801C
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 02:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5AF51C20D79
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 00:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD1810E4;
	Fri, 14 Jun 2024 00:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNXnfVxo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164F8383;
	Fri, 14 Jun 2024 00:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718324382; cv=none; b=n2KaSUTWpeZvnHXxK51Sz34AJuyOmlybFOsc8JtU1Y2b7Zt6huRffTrs1K5tcs/jzdiYDQQZdbAcQ8+uRTsAn7GLYfq0y7JkLOqqUDpu2uHmHI92sRTlIz+ngphe/fH5fwqecVRp8bb8Km+PfnnVvlzwNwFlOEIAytCEX5E9BBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718324382; c=relaxed/simple;
	bh=vu5c06wCCPqcJntiay2+o51T4EjuO26wW+VC2Y5qSCY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4Ekmj208SoVF+8sEx2lPjPxC76AWwOnECKwQPcEfmelryhCYnkmZAJfuW/DsBGRjZGuwzwAQ3H5jRxwPqEUxgPhBTk5FO8mvCmzHZyp1xmF7P1MhrOnUAKFCVnWiZJmBOJci2RUVYvONsNMQIKXdleqehsmYWOQlQ0ynBb8c7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNXnfVxo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CB2C2BBFC;
	Fri, 14 Jun 2024 00:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718324382;
	bh=vu5c06wCCPqcJntiay2+o51T4EjuO26wW+VC2Y5qSCY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JNXnfVxoXT/7RqzuwyHlshRza2Ox5vp7z5djAI6Gzmy0Jha9qqgyYxcOsiIbtPnO1
	 Sb94upfCdGbBrtruOxruaWRh3TxJrWJzXVD5cKpl3fZfVeUCYTJ8YW63c2wimAtTBj
	 dPXUfvZuRh5ZcWx4zdQyO0yj14zLoEOJetEg+tb+Zlvoptd4K3K8rOHp9vM29fBNF3
	 P0AWL160hK7GtSLEfBchmvEU5uiDYS43tEIWRjLlc3tlRmItRus2WUKJQm5zzfEiCx
	 OK3aS1l4StBHPhEhnG/77tKQepsDgOkuKP4OjaJt+ENh5/2jnH53ISg8hzqThoBqz5
	 Ym31+8PToZL8g==
Date: Thu, 13 Jun 2024 17:19:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Sunil Goutham
 <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, hariprasad
 <hkelam@marvell.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [net-next PATCH v2] octeontx2: Improve mailbox tracepoints for
 debugging
Message-ID: <20240613171940.2966d680@kernel.org>
In-Reply-To: <1718201878-28775-1-git-send-email-sbhatta@marvell.com>
References: <1718201878-28775-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jun 2024 19:47:57 +0530 Subbaraya Sundeep wrote:
> v2:
>  Fixed build error

Don't think so? This can't build on branch since the 6.10 merge window
-- 
pw-bot: cr

