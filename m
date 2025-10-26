Return-Path: <netdev+bounces-233026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FEEC0B72F
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 00:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89AA54E285A
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 23:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300FF3002B3;
	Sun, 26 Oct 2025 23:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzmWetfP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092E8287257
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 23:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761521090; cv=none; b=biAqXM3f8iMCUU0y3A9sPUP0TYjxZW2NELrlWLaNgClLoIsFc0Ot5YBvzYhy58EPbpU4UUlpqTXuJYUjuvaiehHRkFyjSJm8vWYtm7e+ZE7afkB26N3j1D0G9iXNzbF3TWDyar2wmn+JalFFTOdasM4ri6NZ9Kb267Dj7UJabHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761521090; c=relaxed/simple;
	bh=FYcHDEe9tmCQhIKijo3QqbUVdmZ9pXos+CRdJnpFJW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ihvLqxyhuJjaCcKKJ8T6ZNInZmTfI4vhqgR3hEN5OZ+hJ904UTkb8TYM2DmoojdZ+Q3JEsfpkm0tHPUQDgXHJhW/0dmt/KZBJcM8lhyqKZOsR0pdajvgB2ha3468uHVzs3JHdp6u72aDN6VhYYIgDcaC8b18/7VCcooY2kf1wo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzmWetfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8610EC4CEE7;
	Sun, 26 Oct 2025 23:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761521089;
	bh=FYcHDEe9tmCQhIKijo3QqbUVdmZ9pXos+CRdJnpFJW8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tzmWetfPNeiJfz0lrdKf4dz+ebkq15nflIw/U8ITE0KYE65TYJd9Tz7nMzPTfvUOV
	 c+Q6j/plUPjjB0YCzPMHAV2BASFu+SwrJ8WaLUgmNvn+FFSQL9OmAyE20t30iX83AV
	 rrk27QmxYq7Lp5MbFG8QNUr7SrHb88dp0QT7LFMY/+vcFqEP2q0mdqDfwmcNGqW7YD
	 bhALA9kTD+ktBYOYUwfGznRzla4u3/nimyC5FgJYBflLR7AJUOMwgpTaVnHLFytY9G
	 woG2dZxCCNrNGK2c9+pHR2Cfbcj/455hjPM/1K3ZCdKjIOyoKKvSsgmrUyfGCt/zyf
	 rWGogMwjcmSYw==
Message-ID: <b7443cef-ca2a-4833-bb76-e4f527a98aad@kernel.org>
Date: Sun, 26 Oct 2025 17:24:48 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 0/3] misc: convert to high-level json_print
 API
Content-Language: en-US
To: Andrea Claudi <aclaudi@redhat.com>, netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
References: <cover.1761078778.git.aclaudi@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <cover.1761078778.git.aclaudi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/25 2:39 PM, Andrea Claudi wrote:
> This patch series converts three utilities in the misc/ directory
> (ifstat, nstat, and lnstat) from using the low-level json_writer API to
> the high-level json_print API, ensuring they use the same json printing
> logic of all the other iproute2 tools.
> 
> The JSON output before and after these changes remains the same.
> 
> Andrea Claudi (3):
>   ifstat: convert to high-level json_print API
>   nstat: convert to high-level json_print API
>   lnstat: convert to high-level json_print API
> 
>  misc/ifstat.c | 85 ++++++++++++++++++++++-----------------------------
>  misc/lnstat.c | 17 +++++------
>  misc/nstat.c  | 48 +++++++++++++----------------
>  3 files changed, 65 insertions(+), 85 deletions(-)
> 

applied to iproute2-next; thanks for working on cleanups.

