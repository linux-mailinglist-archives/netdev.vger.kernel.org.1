Return-Path: <netdev+bounces-169496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E83A4438C
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 15:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E3D1882B9C
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 14:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691A421ABB4;
	Tue, 25 Feb 2025 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbxfEbNU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EC521ABA3;
	Tue, 25 Feb 2025 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494872; cv=none; b=kXgFHSMx8ejDWhrW7R8FQ7rJhqlxSMAMoTHbcPX+1MQV02wiofx+G45WsUT7K+hcX8qI627PCQlUUVWmh+a1m0jxsobl3wh0Sv6gDteproJxXs/ZUmZV9JzZUFkN3pZrc1WFVpCJT4PLRaGcU1Ryxb15bluqrF4r31lmS9Qilws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494872; c=relaxed/simple;
	bh=VCZ/I8KoKPBzmSTW5CQsvmCV3fHXykJRON3/kqU5Aig=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/cql0yg8LWMtak9SRjJNigTDBxBV378MFxpLzulysSZ4w8bQ3JXLyU5vjHbeCyLH6mPR0XfarAPzPoeLLJVlrH5Ovw4fTOse9/b5ACJDjkoNGsILowvqk0mneZQpA7loBUs3WKKeS7RC0prYIteoSj/2GQdQMpH0k2g8Nm66ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbxfEbNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C647C4CEE8;
	Tue, 25 Feb 2025 14:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740494871;
	bh=VCZ/I8KoKPBzmSTW5CQsvmCV3fHXykJRON3/kqU5Aig=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=EbxfEbNUU2TNJecB5YbGelOQ4EgjyWOl5EdahTHM1V6nBarZlY8qstaPQ2TUb80ir
	 aSiqQHKjwX+rNpylKg13WDYj8Tnh/J8alBq9iB/2BkU+BkLPOYsY7wlsx9cQI6AWa/
	 TVO+Oce7rMoay5Ltf04mRCiHLdfb0VuVQzkZw2m1/FaBvdntzPjJB6bFwL0BtB9jt6
	 KbszOvQSDkkDZOlwURJPPupjvY9hffJ9d7ialZJIv49qE7tOMcDOeMluHCCaizRWjH
	 KPa3rVzyuD3BFtZF9F83DwFUKKEETqAyXBWNx6OIJD/gb7ul+CLSnh7r0NbHwl5Zau
	 H2/ppaIcT/1mA==
Date: Tue, 25 Feb 2025 06:47:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - Feb 25th
Message-ID: <20250225064750.65001b90@kernel.org>
In-Reply-To: <20250224081110.08be687d@kernel.org>
References: <20250224081110.08be687d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 08:11:10 -0800 Jakub Kicinski wrote:
> Hi!
> 
> The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
> 5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join
> 
> I'm not aware of any topics so please share some, if nobody
> does we'll cancel.

No topics, so canceled.

