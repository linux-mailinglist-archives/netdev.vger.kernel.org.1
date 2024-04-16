Return-Path: <netdev+bounces-88367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F08988A6E49
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 16:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800A8281F1E
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 14:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62A738DE8;
	Tue, 16 Apr 2024 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHdpc4bl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AC61CAA6
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277904; cv=none; b=HQUsVg2J39I/P1dliDRxiQQYRLVJ7p29JSFGAtKzmknopVeQmIL7RqZs24d9D08GcWQu6diip1i7SyGQQZpFNK9hQdeLbBca69CLEY8AcvO5Bk3R5bZCarV3s5uWn3F4itT4ze0DJ5DMVLDktupwZGRiXA2QV03JAF5HRf2WHgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277904; c=relaxed/simple;
	bh=n6qs9LjIi04AReiV2pJvW/dGAVlfRkYMDDsBHcp2zk0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MkUPGbPXMTbUqi0E1Fy/duSPqMpdiAt3d2ZsFJNxL6aVFvpWc25EsZgwUq1x861Lwq4ngf2ldgJXGC2Fx/mxOg6ti++oI2QG8u9v2iTmnkHLXpSfu2NUjkOj30nGhsrRI2lxsWsi9UrX5QSg7axF4wEf49oVa2MLKdPf4Fn1XMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHdpc4bl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13987C113CE;
	Tue, 16 Apr 2024 14:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713277904;
	bh=n6qs9LjIi04AReiV2pJvW/dGAVlfRkYMDDsBHcp2zk0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LHdpc4blkmFqGlZCTuO5OJ7TOEy3/acrVFwhy+Pmt7RQ1nw8CwXPLcQJvbZzfdQH/
	 qQzNoZhGBzdFeYWkseSCtE2yyfaZNiHYZVYlvQxjoUuooD1dVfdwKLQ+THcek/MxVG
	 wv5lyKoR5+8wTDumCndD2JZx532d2yE87kj4KZgdZ9hejZHYUIDA/3F9FHWNs5vVdJ
	 Qqg3rqjEfPyDJh9qRpx3Sj0NAU4QXv1swkCU/bbgxv+TLtp8lAWfMu/8Rz7vGqC2e2
	 Bn4dckxLEq1bu8ygBmbNcF3wS3etGF6xHDloNdlj4HlXttsKL/CPYufW3Ounk7igSG
	 zuVoAoBwvCHKg==
Date: Tue, 16 Apr 2024 07:31:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, Jiawen Wu <jiawenwu@trustnetic.com>,
 =?UTF-8?B?5rip56uv5by6?= <duanqiangwen@net-swift.com>
Subject: Re: [PATCH net-next v3 0/6] add sriov support for wangxun NICs
Message-ID: <20240416073143.581a56c5@kernel.org>
In-Reply-To: <36569F35-F1C1-44DB-AC46-4E67158EEF0A@net-swift.com>
References: <587FAB7876D85676+20240415110225.75132-1-mengyuanlou@net-swift.com>
	<20240415112708.6105e143@kernel.org>
	<36569F35-F1C1-44DB-AC46-4E67158EEF0A@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Apr 2024 10:55:16 +0800 mengyuanlou@net-swift.com wrote:
> > On Mon, 15 Apr 2024 18:54:27 +0800 Mengyuan Lou wrote:  
> >> Do not accept any new implementations of the old SR-IOV API.
> >> So remove ndo_vf_xxx in these patches.  
> > 
> > But you're not adding support for switchdev mode either, 
> > so how are you going to configure them?  
> 
> Do you mean .sriov_configure?
> Had implement it in patch2 and add it patch5/6.

No, I mean configuring the forwarding, VF MAC addrs, getting stats, etc.

