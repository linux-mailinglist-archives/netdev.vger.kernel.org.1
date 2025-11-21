Return-Path: <netdev+bounces-240860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 630BDC7B790
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 20:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 875B03475D9
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 19:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E192D2398;
	Fri, 21 Nov 2025 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOAlVnFG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF42822B584
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 19:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763752711; cv=none; b=KX+wW2OxrSoBeH29ONLe4M8mnxXT44zCzq42kUEMSHI0RypJCAGnffiq7OyFFVfpaI1BABmkeXfboECRmw1otJ8tesMXIltBlQ7ML2eFpsvEf0ebqthyZG/UY+ABdFI7EIdX22mOJaO0ZqtUfyu/NNvOYb2jH/18zm4YUY7Wquw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763752711; c=relaxed/simple;
	bh=tdJuNaQ7FQbkvlGny5oggUNN5IH+iniRXZEiWIKGVa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtiVslsRrs4cqvsV56Y8zH05aBhcFpWWHLoDdqTJuDouFtRMFns9CMeZLX8xDXFcCR9TnZAWnJXeYB9clXX6KePWPv3ru/iXDIQhR9ZR+G3eOr5rR6rAN9pkZramZYBAEXj+84QQ8WHjyBN5TNDMszVDJTtzI4uvPhsp02xkTPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOAlVnFG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F18FC4CEF1;
	Fri, 21 Nov 2025 19:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763752710;
	bh=tdJuNaQ7FQbkvlGny5oggUNN5IH+iniRXZEiWIKGVa0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GOAlVnFG89t47Lkaj7pC6Cn62c8LHq4KXj5r7EGHwLGjBE4bs8l8Oxl0nkrS5W5vG
	 Z8Ws0dq5j9LKjxQ1Am5BJMpRaQx7OIIxItHZD1rugTdtyNGu2J+jaH0YzDUMaUIVY+
	 vNk7fqRgFkFzF7qGIcr+PP5NYu234L0Mo/KgWmd2hNI8wXsxx4t9e07nEJc+7p9n2m
	 lKRgikQKSfG25dAyLh6vvcQ1mREGWbCEntjvKSSoAyzKvFkG4vN/FSa/cftj1xCfGm
	 Brty43lNOoC+8BEUQMKWsckJ8aSr7IPWPmptQQ2kNqG3JPAP7lTBmNyIflIYtCkcoH
	 Z1NlZS/oz4TMw==
Message-ID: <437c2cc9-37ce-40f1-91a2-cbfeb667da5c@kernel.org>
Date: Fri, 21 Nov 2025 12:18:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] uapi: ioam6: adjust the maximum size of a schema
Content-Language: en-US
To: Justin Iurman <justin.iurman@uliege.be>, davem@davemloft.net
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20251120163342.30312-1-justin.iurman@uliege.be>
 <69709e39-a6e2-4289-9202-f5776109f42e@uliege.be>
 <6d950048-4647-4e10-a4db-7c53d0cfabd9@kernel.org>
 <55c4c96e-c11f-49d7-8207-4f5179d380a7@uliege.be>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <55c4c96e-c11f-49d7-8207-4f5179d380a7@uliege.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/25 11:55 AM, Justin Iurman wrote:
> 
> You're right, it might be too risky. Besides, the current code (i.e.,
> IOAM6_MAX_SCHEMA_DATA_LEN=1020) doesn't break anything per se, it was
> mainly for convenience. Do you think it would be OK to introduce a new
> constant in the uapi, as suggested above? Or did your comment also apply
> to that part?

You cannot break any existing implementation which means kernel side you
have to allow the current DATA_LEN. Given that there is little point in
trying to change it now. If the spec has a 240B limit, you could return
a warning message telling users when they exceed it. UAPI wise I think
we are stuck with what exists.

