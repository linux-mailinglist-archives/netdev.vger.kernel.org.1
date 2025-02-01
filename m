Return-Path: <netdev+bounces-161915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D12EA24976
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 14:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF7E61888256
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 13:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2501C1BDA9B;
	Sat,  1 Feb 2025 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="jHNJ1Pm4"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBE01BD004
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738417937; cv=none; b=QU9BWCr33l9YyWb1nvcMkb8rWzpj6nRNmek7+fvD4T/WtvrEt+NwdZDTs/uFM4PWSbxUN+GzhCSRAPBBhjrlMyTztN718GmZvq2o5fBtWVnNDlcEzVhaRphpgXu9JOtvnwR/isD4+T+76YZUnHx/Qz/wht/MQPy1LlS7NtToIN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738417937; c=relaxed/simple;
	bh=2lB45wCFkz/1RaLDu8YXC1f1ezm8W1TvsQwqjQ7Lw2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFcqQHgjYPCI+bxdFzL40Fz5SgWM7deQj9XcFyScptdFBommJnC5bEaeIwO7XbtQp+a/Xra7fE/3/sumuARF2Py9jvEwb0bPWdaxx/+xgAYEv68YyY278GUbsw6+T1ijv3KUkRuws+GFd19RJGGjLlFtTbUQAt5TG13fDGRzExw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=jHNJ1Pm4; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.27] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 8A385200EEBF;
	Sat,  1 Feb 2025 14:52:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 8A385200EEBF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1738417925;
	bh=uCg4W4wdlI3EmD2bZ+nkMoLBYY03ne39c9o/duftHsc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jHNJ1Pm43C3gqad9e4PXIE8ujIJ6g8JD6DAZZb2nCtJ1nMzd9J/JMwNq9rHBRDN7v
	 +JvfeNom5UJR5HTGGtNXV6h5rlOlnFIj2a9m511dymCWxwp9+C2MRU/Ge8te5oYo98
	 UKed7pz9YPKyMCVOKs/0IaqIw+tIud2QJFrWiX6M/6xTOdfDpddjVV0KOnakJwmBNH
	 xkh2U4UsmfUAFLry4BXhCHk9wKUOD1FiAWvE2a9SJz9IF7vHBS4dNuzIrR2alGbUfy
	 LyfFTtgB7tXfrvl8sT07VxDAmFg9b/MuUFjtdfhkmb/30HLRoKc8AtahcCS/LMVBZV
	 nWj5llw+uxyrg==
Message-ID: <4b8d9c6e-cbe6-4c75-b709-c732db0cf331@uliege.be>
Date: Sat, 1 Feb 2025 14:52:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] net: ipv6: fix dst ref loops in rpl, seg6 and
 ioam6 lwtunnels
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, dsahern@kernel.org
References: <20250130031519.2716843-1-kuba@kernel.org>
 <20250130031519.2716843-2-kuba@kernel.org>
 <21027e9a-60f1-4d4b-a09d-9d74f6a692e5@redhat.com>
 <cc9dd246-e8f8-4d10-9ca1-c7fed44ecde6@uliege.be>
 <20250130065518.5872bbfa@kernel.org>
 <59f99151-b1ca-456f-9e87-85dcac5db797@uliege.be>
 <20250130085341.3132a9c0@kernel.org>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20250130085341.3132a9c0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/25 17:53, Jakub Kicinski wrote:
> On Thu, 30 Jan 2025 16:12:23 +0100 Justin Iurman wrote:
>>> And perhaps add a selftest at least for the looped cases?
>>
>> ioam6.sh already triggers the looped cases in both inline and encap
>> tests. Not sure about seg6 though, and there is no selftest for rpl.
> 
> Right! To be clear I meant just for seg6 and rpl. The ioam6 test
> is clearly paying off, thanks for putting in the work there! :)

Got it. Of course, I'll see what I can do. And glad the ioam6 selftest 
helped :-) Not sure what the current SRv6 selftests are doing though, 
but it looks like the "looped cases" were not caught. Probably because 
the first segment makes it so that the new dst_entry is not the same as 
the origin (I'll have to double check). I could just add a test with a 
route matching on a subnet, so that the next segment matches too (i.e., 
old dst == new dst). Overall, both seg6 and rpl selftests to detect the 
looped cases would look like "dummy" tests, i.e., useless without 
kmemleak. Does it sound OK?

