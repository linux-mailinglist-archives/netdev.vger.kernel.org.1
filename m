Return-Path: <netdev+bounces-204976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B2CAFCBB2
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C45C16F6DA
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867FC2676DE;
	Tue,  8 Jul 2025 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDnboWJh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D181C6FF6
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980749; cv=none; b=cgscBMtYJHbduVB8Ne0G3PqCyuBF7hdT+5Om1AtpShoe9j6KtGjj1ldpxs133QzhKWAFNrnGi5b284eEn/sNyrbKPn87EP0R46Z9xuDMsGM5OUjLpD4bWPTdGuNvYdScuU63kISp0U32VuIXkWfG74NMk5rUPv9bqEEeHCWvYe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980749; c=relaxed/simple;
	bh=H/7z0zl0K4yEmE1YViXotFIu2wusYnpEy/Xu/89tMoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neKxQeETt9H4saNUUOQf3haAbWwOUuA/w19QJg3WACTnYnxuni/0r1mqEkmqxZocXmdaxmQREbDGvYv5ZK7wclmETdxBMzqgg92Z8IzTXz09/q6EZljd1aqGFi4Pi/05od0hZgRzbbIJ9jCRTqCsZVcRt9hM3TWUObX+esW5p6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDnboWJh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8A5C4CEEF;
	Tue,  8 Jul 2025 13:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751980749;
	bh=H/7z0zl0K4yEmE1YViXotFIu2wusYnpEy/Xu/89tMoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RDnboWJhf874hi+RCgkumJnz/u0qZEnG7bqQHA5SNHA+q4OgggTxgp5CUSutKqOnL
	 QIihnFCXooo2umRO8BR9+fe2MGPBfH0PBEtMroa+7okdaOlBcqsREQ0l8UoSxYIVYr
	 cxCJyyTuFVF96nJF/eBXvRxFr4kCRzOV/Z1jx/6M/0CPBmJkOWE1u2rlcTFPtFLnBm
	 YkK1BqIaCZ8mbpCgTDs3PfpTPD577KWFUgkxqtKiDsI8PuiFGu0sEvlIrG3lG3KTRG
	 DXqfheFUMnPl1FX1zI+9PfmMTdkOKxA2XJG1TohWJU9BQVMKF0PLScdJioF94JXDeA
	 yRN+yIaE7zoyQ==
Date: Tue, 8 Jul 2025 14:19:05 +0100
From: Simon Horman <horms@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, will@willsroot.io,
	stephen@networkplumber.org
Subject: Re: [Patch v2 net 2/2] selftests/tc-testing: Add a nested netem
 duplicate test
Message-ID: <20250708131905.GK452973@horms.kernel.org>
References: <20250707195015.823492-1-xiyou.wangcong@gmail.com>
 <20250707195015.823492-3-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707195015.823492-3-xiyou.wangcong@gmail.com>

On Mon, Jul 07, 2025 at 12:50:15PM -0700, Cong Wang wrote:
> Integrate the reproducer from William into tc-testing and use scapy
> to generate packets for testing:
> 
>  # ./tdc.py -e 1676
>   -- ns/SubPlugin.__init__
>   -- scapy/SubPlugin.__init__
>  Test 1676: NETEM nested duplicate 100%
>  [ 1154.071135] v0p0id1676: entered promiscuous mode
>  [ 1154.101066] virtio_net virtio0 enp1s0: entered promiscuous mode
>  [ 1154.146301] virtio_net virtio0 enp1s0: left promiscuous mode
>  .
>  Sent 1 packets.
>  [ 1154.173695] v0p0id1676: left promiscuous mode
>  [ 1154.216159] v0p0id1676: entered promiscuous mode
>  .
>  Sent 1 packets.
>  [ 1154.238398] v0p0id1676: left promiscuous mode
>  [ 1154.260909] v0p0id1676: entered promiscuous mode
>  .
>  Sent 1 packets.
>  [ 1154.282708] v0p0id1676: left promiscuous mode
>  [ 1154.309399] v0p0id1676: entered promiscuous mode
>  .
>  Sent 1 packets.
>  [ 1154.337949] v0p0id1676: left promiscuous mode
>  [ 1154.360924] v0p0id1676: entered promiscuous mode
>  .
>  Sent 1 packets.
>  [ 1154.383522] v0p0id1676: left promiscuous mode
> 
>  All test results:
> 
>  1..1
>  ok 1 1676 - NETEM nested duplicate 100%
> 
> Reported-by: William Liu <will@willsroot.io>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


