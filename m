Return-Path: <netdev+bounces-115683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4E994784E
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 11:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD811C20E96
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 09:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E7614A609;
	Mon,  5 Aug 2024 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXmul6It"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21B622309;
	Mon,  5 Aug 2024 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850130; cv=none; b=q7QVnttNpL3nSixKzMHdAfNR2LOn7IMkqYjnKol3AdKi/gVw+tqaOk5+3e3CCdt+57YXhxZG56tRlTsyghQgXrCWmQfKKube8+gmRwyHejtnoAgJvaHFqa76isaHbzG75Z3ZVCrl1UcbvKzHUtuiXKFuPX6hNpe/QKBR0yjiBzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850130; c=relaxed/simple;
	bh=y26axP4JKUvXZJXcke8RVR5AeL04n4oU22P76jsEH/w=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=njMsWq93pQijfEiCAkd4P6R/fKzf9QSoYV9P7gAx8RE63kxfs3mwCdjVTWGcWk4wTwXFESQXf9xqbVCZahKM544NJW7O8rQCHvl18utjQCnrnuQKmrn3QKKrljITo67FaGcG4xLjIn2IrcZpoyIS4wW5VwIcmnNhWW/Dbl/pTmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXmul6It; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C6DC32782;
	Mon,  5 Aug 2024 09:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722850129;
	bh=y26axP4JKUvXZJXcke8RVR5AeL04n4oU22P76jsEH/w=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=pXmul6It5kL8o+0ij0aLAoA50BEeIAfv2IJSmR9kC1wDElFsbNRNAprpDH//wKe9I
	 DB+x5TclGFUlFthV44GaLM4TWMaReJ922k2s08LETPRpsbCQPHyaD7fy9SH+wO4+f4
	 wVxhNkzUytoW2zANCbHr/X/pIfSMEDAPtzZsNg2WwXhAU/lZ4aA91VhO09oZTmzokZ
	 iTtfgnIg5zhuuT4aVC1HwHq6xS7JgPwEni+C9ca57S5y3fyhFRtBxvdJHvw7vMERNb
	 uQtwUHOK04hJ9hHISrQKPwrnfDUsIdc5i+HRpi+2ETfEbgxJpfNokArVWZhfirXyic
	 HcpceUo9zcGXg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: use 128 bytes aligned iova in transmit path
 for
 WCN7850
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240715023814.20242-1-quic_bqiang@quicinc.com>
References: <20240715023814.20242-1-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>, <kernel@quicinc.com>, <netdev@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172285012623.3144432.10455609105773618485.kvalo@kernel.org>
Date: Mon,  5 Aug 2024 09:28:48 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> In transmit path, it is likely that the iova is not aligned to PCIe TLP
> max payload size, which is 128 for WCN7850. Normally in such cases hardware
> is expected to split the packet into several parts in a manner such that
> they, other than the first one, have aligned iova. However due to hardware
> limitations, WCN7850 does not behave like that properly with some specific
> unaligned iova in transmit path. This easily results in target hang in a
> KPI transmit test: packet send/receive failure, WMI command send timeout
> etc. Also fatal error seen in PCIe level:
> 
>         ...
>         Capabilities: ...
>                 ...
>                 DevSta: ... FatalErr+ ...
>                 ...
>         ...
> 
> Work around this by manually moving/reallocating payload buffer such that
> we can map it to a 128 bytes aligned iova. The moving requires sufficient
> head room or tail room in skb: for the former we can do ourselves a favor
> by asking some extra bytes when registering with mac80211, while for the
> latter we can do nothing.
> 
> Moving/reallocating buffer consumes additional CPU cycles, but the good news
> is that an aligned iova increases PCIe efficiency. In my tests on some X86
> platforms the KPI results are almost consistent.
> 
> Since this is seen only with WCN7850, add a new hardware parameter to
> differentiate from others.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Cc: <stable@vger.kernel.org>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-current branch of ath.git, thanks.

38055789d151 wifi: ath12k: use 128 bytes aligned iova in transmit path for WCN7850

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240715023814.20242-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


