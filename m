Return-Path: <netdev+bounces-144567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE999C7CB1
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 21:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B081F21942
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 20:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50002064E9;
	Wed, 13 Nov 2024 20:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMDWorSW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E26D204F66;
	Wed, 13 Nov 2024 20:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731528887; cv=none; b=iGFwmlgF4Q57kpLgpn7dgSt1AfvjMo35jqI6Y0S40SCLUJJoouVKile/ZK8i2NjftpmJizpwSG7yeenIrxcuUUr7ZcrS/C+gtz7set4IPX+U5Abo8VTS6CA+0PkHyv2HeIb4ZVR8qOqJdoRluQo4EO4QFhL2q8NyzAp4IZ7wKzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731528887; c=relaxed/simple;
	bh=4KOzCR/6/uot43apjvnkzhZKyIj22nkrtQR5roVfvW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pHqAWEJ1xhBDIrhmG4LBDp0V/eBy9IWPBhPBQ4mGrEyroeLe4LDMIr8THUsWvaW4pK70CeAv1Q0iq36tX0YXvkU3Qy/O7ZsnyII8SHr8MDM9SG+jWZ4jo88p6RESe0u8ls5qYYucQx59BBx0g0tyzsVl8NDEv/OPG/48yJuUTng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMDWorSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CC3C4CEC3;
	Wed, 13 Nov 2024 20:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731528887;
	bh=4KOzCR/6/uot43apjvnkzhZKyIj22nkrtQR5roVfvW8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gMDWorSWbQlNE7du1pMgjamCWXHp81rQft/hvP5SwBg0yQUvZ1pTjlbMylirp25ie
	 Kb6AiEQ2sZetofLqr1dZGKrNkhkBuDftWvTRTXE5kMR1dLjhz+YRAxTBrOFFbUDBLB
	 l64TDGg0N5vpZY+HPJWD4p2g465d5mXvA6ecY2bkoTtfj+R4HLnxdpXngTi/DLII4E
	 9mAkTxQqhgLfSDR80FArQJDgtSIzZckdQCi/63b33P7I3su0skLr/3Lz0JIIudESJZ
	 U5+fJKoI5JRSheYbUhV6ZUVZfqHzRsi8cx0EEg51ffbNebpnEPjHiEXD+g7D9pO/ou
	 bNMFjlitEScpA==
Date: Wed, 13 Nov 2024 12:14:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, horms@kernel.org,
 donald.hunter@gmail.com, andrew+netdev@lunn.ch, kory.maincent@bootlin.com,
 nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 4/7] ynl: add missing pieces to ethtool spec to
 better match uapi header
Message-ID: <20241113121445.08cdb25f@kernel.org>
In-Reply-To: <20241113181023.2030098-5-sdf@fomichev.me>
References: <20241113181023.2030098-1-sdf@fomichev.me>
	<20241113181023.2030098-5-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 10:10:20 -0800 Stanislav Fomichev wrote:
> +    attr-cnt-name: __ETHTOOL_UDP_TUNNEL_TYPE_CNT

--ethtool-udp-tunnel-type-cnt ?
or possibly
__ethtool-udp-tunnel-type-cnt

but let the codegen do the char conversion via c_upper()

