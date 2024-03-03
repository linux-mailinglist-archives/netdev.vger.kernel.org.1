Return-Path: <netdev+bounces-76931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7BC86F77C
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 23:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E256E1F2104A
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 22:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEFB79DCD;
	Sun,  3 Mar 2024 22:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioy5Jujd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A3879DC9
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 22:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709505717; cv=none; b=LZIz+SZK0zsov2xNpyWE3GWXPHGNSV21UvLw2qVY8bMoPodnuAPdVx7iD7b8Y5gcaL3F575mvXAAEIo7LjDGQ/ZXeE7meMHf3TW1HnHEH9QPeBXhSAspY0bZVnBTV46MpJjxyj7St1r+njG/L/V/8QP6E2sqKnhfQ6JHassIhqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709505717; c=relaxed/simple;
	bh=qrGTOKQZrz3rPqv3dgAhs4uWyQz0wTgNlIr7TmOlNNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1cGTgMGKipKP/awPuVZXL+bA5GZR6M/kLRP4uaTBTNQtKCZGPwVvpXfnn5Vh7KWVKiEeZI2OGexMKzDUQwv87MYU1uC/rbRq2gmAV51GSzuc0mRDkIWaeSjvX0+l2U1DEDQqD8CGIv+X0wQVWcQOA8YdIQ82gbpk7bF+cG48Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioy5Jujd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13917C433C7;
	Sun,  3 Mar 2024 22:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709505717;
	bh=qrGTOKQZrz3rPqv3dgAhs4uWyQz0wTgNlIr7TmOlNNA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ioy5JujdaaLJ+VKA0UsbqhbmpDEgwTdAfMD2lGZJnB5Y+ary4JQw/ffz9TgQ+jKA3
	 joJKoq65z+N10K6Zh9byiAY92oWrVsj7Dv/nkDEHJFryVJXyV9TEYPaDS+xxMi3yNS
	 jIo85hyBvQ1pKv8he1A85Gydnnlkfcpku4aJJnMj2LxSdIiFxQ7CUjrAzQj8rGt2gX
	 6v8pAdaTLzwjivYISJ3fzIHtPjeyUHpBy5Y+RhZMXBPDLVlEdeT1KIFCQzLp5/WaGj
	 ihI7oYYmqBNoYL01z45CEB3tIK2q7u32mtyFNwBoeOzrK0/qlEUES7Mt31tlcOvyEA
	 DsJvvL5q43Rsw==
Message-ID: <c8d8bf47-85fd-46d9-ac7e-814bac461c73@kernel.org>
Date: Sun, 3 Mar 2024 15:41:55 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2 v2] iproute2: move generic_proc_open into lib
To: Denis Kirjanov <kirjanov@gmail.com>, stephen@networkplumber.org
Cc: netdev@vger.kernel.org, Denis Kirjanov <dkirjanov@suse.de>
References: <20240229125449.3268-1-dkirjanov@suse.de>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240229125449.3268-1-dkirjanov@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/29/24 5:54 AM, Denis Kirjanov wrote:
> the function has the same definition in ifstat and ss
> 
> v2: fix the typo in the chnagelog
> 
> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> ---
>  include/utils.h |  2 ++
>  lib/utils.c     | 14 ++++++++++++++
>  misc/nstat.c    | 29 ++++++++---------------------
>  misc/ss.c       | 13 -------------
>  4 files changed, 24 insertions(+), 34 deletions(-)
> 

does not apply to iproute2-next.

Please cc me on iproute2 patches; I process netdev mailing list in my
spare time.


