Return-Path: <netdev+bounces-167122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4618AA38FBC
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 00:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A90A3AB215
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 23:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246A61A8F89;
	Mon, 17 Feb 2025 23:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyeONvhg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E0B7404E;
	Mon, 17 Feb 2025 23:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739836084; cv=none; b=u9sIzqnszzShqzJEZydmhEhgkgcfVkrFPI+KCV9C1u/6DJdhFaf/HIlkkY7L3Wiota/YxYs7GMNOLoPOZ2dKGB+5Cfw4CVbhw1laXwjrr96g7mMQRtk4OvO/CftZYVMzHBmV9wF3em/LWGPR0jlVba5J7WyTF2jTDZHG/rmojjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739836084; c=relaxed/simple;
	bh=Ec/oz3AfnETndpRHCs7Z69waq5sKF9/Av7l587y2Qp0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmQ5eQFVxIo3KSqJCPVTWCyycgsa40E5GWZLmcQQ5/MuZha5X5EGGCsGhi50XCu/NfjlHH/NzkZHGun0h9Sw9qgi5Y15AKCiYYIdpNIus2OWE5E9ZhQm4TrCWATgCORq/hf8tCl7J4uPbUZM0TnUtMs+msujMpQouvCVVSC8Wgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyeONvhg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DDEC4CED1;
	Mon, 17 Feb 2025 23:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739836083;
	bh=Ec/oz3AfnETndpRHCs7Z69waq5sKF9/Av7l587y2Qp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IyeONvhg7qcvLkCd8JGbNQyO1gcfkNb0fKmCust+WEBSfG+UhbjMyKXwQpCXgheMM
	 NNkwkm4BIy+V5Y0R8GEW9iugbbDJpsMJRIeF0CtLyr777bTTj8RFDvLy2GHErKvWUn
	 YURvKZV+QxGLQdntsJ4HjyjBM6sXVTpvTMjP3LW3vbFKBGz/nua8ybRm2v7uLVUKwl
	 8yWL77sGbH+f+rerYCR7r1eVgv8li0gr+eY4nukCUf5x6yTGOtnBChj+tBfGi5XghB
	 UWT8Ca92Iqegc0h2uv4F1s9+tVsjRaMBzZxLnN/8bIol6TXALZxvLC7w2e/8TukhOO
	 e0ALtJOHZZM7g==
Date: Mon, 17 Feb 2025 15:48:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v3] net: ethernet: mediatek: add EEE support
Message-ID: <20250217154801.338f2de4@kernel.org>
In-Reply-To: <20250217033954.3698772-1-dqfext@gmail.com>
References: <20250217033954.3698772-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 11:39:53 +0800 Qingfang Deng wrote:
> Add EEE support to MediaTek SoC Ethernet. The register fields are
> similar to the ones in MT7531, except that the LPI threshold is in
> milliseconds.

Please wait 24h before reposting next time.
-- 
pv-bot: 24h

