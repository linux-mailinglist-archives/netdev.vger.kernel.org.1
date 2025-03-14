Return-Path: <netdev+bounces-174830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA115A60DA6
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 10:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB875176D60
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 09:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3AC1EFFA9;
	Fri, 14 Mar 2025 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0VVVm/W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132481EF0B7;
	Fri, 14 Mar 2025 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945434; cv=none; b=Qn3I8mcXxbUv1k0I2BuyuIGi2Hy2CktiLAiXSC9JV+iEC76c0wsEygUygLemxrgkot4XVJNQ0FW4RUFMqcR5CgELpvkXQkjwXTwu1F2qHTgH22zAFwlUGsBs3tTaxgIqWXYQi3yg2N2ihhsBmtw/E1h4SWJqjoxpoBp7PLIhxfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945434; c=relaxed/simple;
	bh=mlY2b2HgrmfsorgpH4s9txd6vsQ31pPOu9TWoaOtQRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oqx2CCyKn0qDE5n9IBen5KT+Nto3QQbjVheVVJxRgZ6QGI4eg/Asr8O7rnRh3SnpxuAy28E1n8HfW5nH0VBaUbmeXC3ppPY1YZQoLw2l/mzX99ndmadYvBN/miXKuUxcRwBVzgo/FA/iwgHwczDJKTF5ur4h/1CFjpzX9/gZgqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0VVVm/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90CA3C4CEE3;
	Fri, 14 Mar 2025 09:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741945433;
	bh=mlY2b2HgrmfsorgpH4s9txd6vsQ31pPOu9TWoaOtQRo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E0VVVm/WkmdDl6vyBekWkpNcEsEYmsdrOzphvICYLmN3uYgmekZCN9gQU1ZLRaCU3
	 0JyJwRM7WfOxfDgQUzYbS8xrk/whFQYEqZSC8FeTrRKbJ5yq14LOYkiQl49kdv//ml
	 xGIYAfnl38DElxOVe8kDEeJ2JSIcsjnuzWxv2tund5Hkk3S0FNVr2WSP6/v7FRFG6K
	 oBiRN5w9u/hRXi8DdukIb4lOR7yfffIA5R3eYhKqnRwSNaXxxUz2U2QPwhMtmEItrJ
	 /IumpVFbi2ZNaTsRCWnop7Ip97pNiqVgMO1ll2jfm1KM5JQfmo5JoHg89WdtDbJtXg
	 9a6DnlPWTXuMg==
Message-ID: <6f8bb99f-1f3c-4ace-8fc4-6868cf56147b@kernel.org>
Date: Fri, 14 Mar 2025 10:43:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net] mptcp: Fix data stream corruption in the address
 announcement
Content-Language: en-GB
To: Arthur Mongodin <amongodin@randorisec.fr>, Paolo Abeni <pabeni@redhat.com>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, mptcp@lists.linux.dev,
 hanguelkov@randorisec.fr, Davy Douhine <davy@randorisec.fr>,
 netdev@vger.kernel.org, kuba@kernel.org
References: <81b2a80e-2a25-4a5f-b235-07a68662aa98@randorisec.fr>
 <2f11274e-de22-4291-9172-4ad96d215a41@kernel.org>
 <91657d20-3a3e-495a-a725-6724ecf6ac65@randorisec.fr>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <91657d20-3a3e-495a-a725-6724ecf6ac65@randorisec.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Arthur, Paolo,

On 13/03/2025 18:18, Arthur Mongodin wrote:
> Hi Matthieu,
> 
> On 3/13/25 18:10, Matthieu Baerts wrote:
>> On 13/03/2025 17:26, Arthur Mongodin wrote:
>>> The DSS and ADD_ADDR options should be exclusive and not send together.
>>> The call to the mptcp_pm_add_addr_signal() function in the
>>> mptcp_established_options_add_addr() function could modify opts-
>>> >addr, thus also opts->ext_copy as they belong to distinguish entries
>>> of the same union field in mptcp_out_options. If the DSS option
>>> should not be dropped, the check if the DSS option has been
>>> previously established and thus if we should not establish the
>>> ADD_ADDR option is done after opts->addr (thus opts->ext_copy) has
>>> been modified.
>>
>> It looks like you forgot to wrap this long line. I guess checkpatch.pl
>> should have complained. (Tip: 'b4' is a good handy tool to send patches)
> 
> Sorry, I did a last minute change and I forgot to rerun
> checkpatch.pl.
> 
>> Also, it is a bit difficult to understand this line. If that's OK, I can
>> update this when applying this patch to our MPTCP tree first. I will
>> send it back to netdev later on.
> 
> It's OK with me.

@Arthur: Your patch is now in our tree -- fixes for -net -- see the
details below. I will send it to netdev later on.

@Paolo: for this fix, should I exceptionally target net-next to be part
of the next PR? Or should I target -net as usual, and we will see later
where it is best to apply it?

-------------------------------- 8< ------------------------------------
New patches for t/upstream-net and t/upstream:
- 3d5c1fa05e61: mptcp: Fix data stream corruption in the address
announcement
- Results: b9209d9d7724..125af774622b (export-net)
- Results: 9facbd5c1495..489b5d421ce3 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/7f47a4004c06ccbde79474c4d7c2df7c8e82c739/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/e03be8fef79062df04f9f32a7ca2e4404524b5b4/checks
-------------------------------- 8< ------------------------------------

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


