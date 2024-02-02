Return-Path: <netdev+bounces-68656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 333D5847784
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 19:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCFCD1F2B2EA
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBAB14AD03;
	Fri,  2 Feb 2024 18:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiGftXBD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF5F328AC;
	Fri,  2 Feb 2024 18:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898861; cv=none; b=IP4YPam5CTrQFH6fR2fz88RQARtao24KwUv4rAxFZeEzrXGDTrQZrl3ftPzG5dGSHSua0c8C2aWV5VF9o2y30RcRiAKUYZe5nKhpI+/QnbE2vwL5X0SZ3Ak8LhMYmYYZyeL1mU9lPTcqV/zo+7k35K85/uH1HIMzwZBcpKHkdFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898861; c=relaxed/simple;
	bh=vX6D9+slYxC1tY7rccFNiVvkllB8eXggC//tc7iYTWg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ELPY06sHmURsqyTqzgTGIR946EUh/ozITFrLqKavqNbS9qnx8bP0G1Vs7vsRg9vd/0FzTgdl4CsdYOni+BXzGSez+EyxILpaICjnB3enTiwjBR7y8wXkfnqwtxWfdTLSmOx/KhqR/kdocmQ3Pb+GiUWbbzdJL4mEkNvbZrdjyUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiGftXBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE94C433C7;
	Fri,  2 Feb 2024 18:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706898861;
	bh=vX6D9+slYxC1tY7rccFNiVvkllB8eXggC//tc7iYTWg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WiGftXBD6tcvIj70BNriqMYTQmRVZoZqidkupMM8dDxw0o0MUNTJHLWXziFkRs1UU
	 u1pOU0pEU7ZyFGiIX680Oq7JWAjfH8xzoXRZa4sBlm9r/Lsb48D/vvARuZeyQ/twmM
	 831UNWgK5pEQvHA7EtQ62pmDlF5Y8XfUZFo8bA0O5KiU3LuP04BJafTxF53HzLYNVL
	 28ah5fDr5tcgjfE1tOeAGXdHlOl19I+8auYnDrJFMZ+v4Ao+KXG/rIUKvOIMicYjp3
	 m/ZE8+1zxRjaNv/NG7OnwarcY9C2A6HXys+MxDayCPj5A0Q6UAB6gcX8UPeJ8ep697
	 DvNZS7QNgwqHQ==
Date: Fri, 2 Feb 2024 10:34:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, jiri@resnulli.us, ivecera@redhat.com,
 netdev@vger.kernel.org, roopa@nvidia.com, razor@blackwall.org,
 bridge@lists.linux.dev, rostedt@goodmis.org, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/5] net: switchdev: Add helpers to display
 switchdev objects as strings
Message-ID: <20240202103419.4e58d521@kernel.org>
In-Reply-To: <87zfwjs3vs.fsf@waldekranz.com>
References: <20240130201937.1897766-1-tobias@waldekranz.com>
	<20240130201937.1897766-3-tobias@waldekranz.com>
	<20240201204940.5f5b6e85@kernel.org>
	<87zfwjs3vs.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 02 Feb 2024 08:48:39 +0100 Tobias Waldekranz wrote:
> > Are you printing things together into one big string?
> > Seems like leaving a lot of features on the table.
> > trace point events can be filtered, not to mention attaching
> > to them with bpftrace.   
> 
> My thinking was that __entry->msg was mostly for use by the tracepoint's
> printf, and that if you are using some dynamic tracer, __entry->info
> points to the verbatim notification which you can use to apply arbitrary
> filtering.

Ah, I see. That works.

