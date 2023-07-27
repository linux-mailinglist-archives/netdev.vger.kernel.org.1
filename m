Return-Path: <netdev+bounces-21994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C84E765926
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7B01C2138A
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 16:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB3427139;
	Thu, 27 Jul 2023 16:49:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8542327124
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 16:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3590C433C8;
	Thu, 27 Jul 2023 16:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690476554;
	bh=OYDXDKg0rlI8h168Z17mNBf3Ii1Pysw4lkEhQ3MuAJo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nVjs37CWWMxDNqFgKoAHt/a1O47WUsuLoufDWDEUwl1Rnb57J3in8dub7U1JoY3T7
	 tZumNG6IBRt4bmr4jtF0lcpvdq71YQG4SonN5hMfngtUj4C7ozcN86mSbiqDLYSAkF
	 ZbkXgJ7CCXp/SfJVScfKQboEBuoBGaF+Kokq2X7mgR+iH62h1O8rlPMaUFVNYDYy18
	 rlUS6ziU+bKSnCqC83CTzPrhqeUUD5iCP7utBnffWIweYAC7dZrypLfK5attiH/ETc
	 AcURW6Dbp4KVvoSMQVL601w+JBa0zsfstpRSNoBy/MfP9D6wRbleKRR1SlzfxIXPBS
	 PV0lcBQGM9MVQ==
Date: Thu, 27 Jul 2023 09:49:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next v2 0/4] ynl: couple of unrelated fixes
Message-ID: <20230727094913.2d50b4f3@kernel.org>
In-Reply-To: <20230727163001.3952878-1-sdf@google.com>
References: <20230727163001.3952878-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jul 2023 09:29:57 -0700 Stanislav Fomichev wrote:
> - spelling of xdp-features
> - s/xdp_zc_max_segs/xdp-zc-max-segs/
> - expose xdp-zc-max-segs
> - add /* private: */
> - regenerate headers
> - print xdp_zc_max_segs from sample

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

