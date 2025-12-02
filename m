Return-Path: <netdev+bounces-243231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FAEC9BF94
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 16:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B6241348F98
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 15:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D2524E4AF;
	Tue,  2 Dec 2025 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ch16VV2e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7223BD02;
	Tue,  2 Dec 2025 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764689768; cv=none; b=dL7YD2XOOFL4VY3RAbNyksH6ksZ4CnBbWv4NkKntJH8FxFmy+zmXDYysVX04vbc54HBvqR6APIdMcOcnFdpDsG977YNXg6z2GDFB2w9BUTIw2EPgXPgX83LcFfXVQwDMdurAegMOXLzt74ysC3IKHuMrwZ+GhO5rdMRq12jn35I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764689768; c=relaxed/simple;
	bh=xEhRuhOj5hVUBnVWY4sv5vu3mMC8XAC/Jgo24DkfT9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qw55FA68bzsT4eyVSEnHNli7MOMfMf07CNFbDkkZCadtP11KJOeVJ3Pguikmdv9g3YToHMzVLrmHI1gYsJh5tD7coI3E+Uxqh9d7M4RlNWk+v5dOZCjGdgOCIaUXbUY02M0etwrOkwVGvWYT9IVADRU6arsQ+gxFqsxGCWu1nAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ch16VV2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B31C4CEF1;
	Tue,  2 Dec 2025 15:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764689766;
	bh=xEhRuhOj5hVUBnVWY4sv5vu3mMC8XAC/Jgo24DkfT9o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ch16VV2eXtgzG4SMtVDrZYg+jZ/992dhRAr3q89bAcbYEs4tAJ+FiS87Moo71PCGu
	 BqpSrIdTDe8zCHapzuxfNCy3RWmbCRxaQs1qeh+8uPq7rBeI9QLEB3XvQKc53A20i/
	 kegkjk8mSbT9YTyHarRhFKy3munMRnDNAeAv/mYR7aaMFmD2KPhu8tqZWAr3552/US
	 OUG9r6idJRPOFpGzn10zGOu7Na/DNjVpgFTQrghbR+M5Ff6V2jZo+yHPO7+2PkCluk
	 MFVJHR6eQwtyHpjNRHo77jBfvwOhRkd6VsAN/UwfBipbukUQb6C43GjqZaWUGkoNSV
	 UUke/xJRUHsvg==
Message-ID: <55505373-ca59-400c-8d66-2f4b73c89830@kernel.org>
Date: Tue, 2 Dec 2025 08:36:05 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-net 0/6] mptcp: new endpoint type and info flags
Content-Language: en-US
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
 MPTCP Linux <mptcp@lists.linux.dev>, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>
References: <20251124-iproute-mptcp-laminar-v1-0-e56437483fdf@kernel.org>
 <23baf995-080d-4457-b089-a88a317425d2@kernel.org>
 <a92d7456-67a0-44bd-be03-99f17846a213@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <a92d7456-67a0-44bd-be03-99f17846a213@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/1/25 11:15 PM, Matthieu Baerts wrote:
> I'm sorry about that!
> 
> These patches were on top of iproute2.git (not next) because they were
> controlling features available in v6.18 (or older), but not only in net-next.
> 
> Should I maybe next time not prefix such patches with [iproute2-net] but
> only [iproute2]?
> 

iproute2-main is the bug fix and release tree. It is not for features.

iproute2-next is the development and feature tree. If features are to
sync with kernel side merges, then the patches need to show up at the
same time.


