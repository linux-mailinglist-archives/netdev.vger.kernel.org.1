Return-Path: <netdev+bounces-160985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9112A1C818
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 14:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 573083A538B
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 13:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DFE71747;
	Sun, 26 Jan 2025 13:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="q6O9fmyJ"
X-Original-To: netdev@vger.kernel.org
Received: from mr85p00im-ztdg06011801.me.com (mr85p00im-ztdg06011801.me.com [17.58.23.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A3825A65E
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737899080; cv=none; b=DgaYVd/LA1XX04Xtll24AE3j7e2+D96futIZDQ0sZTPtDumbmTiZY6ZwuyriBYKDWKbkIvuchzhT3KVemFSp1D6Ur00jpTZzl9FSic+3dslHkO8mBa0l9fS0nPRMhVoyjcGHYViJczgjNEwppC+Hx7l0js6JS+5xe0DVdPxE/Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737899080; c=relaxed/simple;
	bh=Shh8jGPuR3jJ2oyxFmWnHU3XbHklss/0sxvyrbuOJko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XfqLwatz0dTfqP5lrQVTyFF6xZSFi8kezIFHyBlJ1qUNfTv/Feo/ZCoJzYpVAOyTOJH0dOs9IGx0XxSJrS/bh5/JC32rAd0qk8Ze+/HF3PPq6PZfBzQ3k94kyHlDzioezjdElW+tkTyD0c0Hzm/Ow0ptlDSZaKXNRNkCHQTRt+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=q6O9fmyJ; arc=none smtp.client-ip=17.58.23.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	bh=R8YAi+n0hdsouUjtiX4H1meBEkdZee7Sm+x3qSzKNTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=q6O9fmyJwU5yoV1RB/lxQEFHhH1czbf/ogxOOYJuk1+FVAXm1qopesj7okikmEtQi
	 hRPmBhD07wTsVc+7xzH+0O/U4EL8dRMvfoVJG2aEUz+r4iSJtFBfQVmG2p+ZZApPc7
	 byEWNqIyXqhKtxKQID5BeaOjWGr8WSjLHlblS5fE/ALKFDFqmoZuK5QGNBRq/9ADsY
	 j9N1NJR9FF2nLe4YlPvBthgMCbJtg3uwBMP4MwuPCAYA3WOAKdy7R4P605GhRDPgcE
	 p7Ixxo3BSY7tPX1Z/cQ56SqCZ3f3K73dO41RhCO/c9IBN21XRu8lHl8eNJXxdbEp60
	 8xqcCcvZYwdyQ==
Received: from [192.168.40.3] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011801.me.com (Postfix) with ESMTPSA id 41EEAAC592B;
	Sun, 26 Jan 2025 13:44:34 +0000 (UTC)
Message-ID: <916462f9-0fff-41f2-a187-a3a4fa57f7e1@pen.gy>
Date: Sun, 26 Jan 2025 14:44:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v5 0/7] usbnet: ipheth: prevent OoB reads of NDP16
Content-Language: en-GB
To: =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Georgi Valkov <gvalkov@gmail.com>,
 Simon Horman <horms@kernel.org>, Oliver Neukum <oneukum@suse.com>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org
References: <20250125235409.3106594-1-forst@pen.gy>
 <db1WBhyDv-AxjFbxHYQCy-5_FnPscCdcjkKSDx6zaMeGJ-LzOgWh7g8uarW5kXwPkUlzPy8AugRq-rgPdjeUHw==@protonmail.internalid>
 <87r04pzut1.fsf@miraculix.mork.no>
From: Foster Snowhill <forst@pen.gy>
In-Reply-To: <87r04pzut1.fsf@miraculix.mork.no>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8h0Ots8A4QcrjtnHew7jfzyrqD0ii_2d
X-Proofpoint-GUID: 8h0Ots8A4QcrjtnHew7jfzyrqD0ii_2d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-26_05,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=955 malwarescore=0
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501260110

Hello Bjørn,

Thank you very much for the feedback! In my opinion, it's never late.

On 2025-01-26 12:19, Bjørn Mork wrote:
> We did a lot of that when prepping it for cdc_mbim
> reuse. Some of it, like supporting multiple NDPs, is completely useless
> for NCM.  We still added code to cdc_ncm just to be able to share it
> with cdc_mbim. I think the generalized solutions still adds value to
> cdc_ncm by making the shared code targeted by more developers and users.
> 
> And the huawei_cdc_ncm driver demonstrates that cdc_ncm can be reused
> for non-compliant vendor-specific protocols, so that's not a real
> problem.

Very much appreciate the pointers to look at how `cdc_mbim` and
`huawei_cdc_ncm` share code with `cdc_ncm`, I'm definitely interested
and will have a look.

> Sorry for taking this up at such a late stage, and it might already been
> discussed, but I'm not convinced that you shouldn't "mess" with the
> `cdc_ncm` driver.
> 
> ...
> 
> What I can understand is that you don't want to build on the current
> cdc_ncm code because you don't like the implementation and want to
> improve it.  But this is also the main reason why I think code sharing
> would be good.  The cdc_ncm code could certainly do with more developers
> looking at it and improving stuff.  Like any other drivers, really.
> 
> Yes, I know I'm saying this much too late for code that's ready for
> merging.  And, of course, I don't expect you to start all over at this
> point. I just wanted to comment on that "messing with" because it's so
> wrong, and I remember feeling that way too.  Messing with existing code
> is never a problem in Linux!  Existing code and (internal) interfaces
> can always be changed to accommodate whatever needs you have.  This is
> one of may ways the Linux development model wins over everything else.

I call it "mess with it" not because I see something wrong with the
existing CDC drivers (I don't), but rather because of my own skill
level. This patch series is fixing mistakes I originally made when
implementing NCM mode in `ipheth`, so you can tell I still have a lot
of learning to do. Especially before touching better maintained and
afaik more widely used drivers like `cdc_ncm` and co.

I should've mentioned in the cover letter perhaps that I see this
series as more of an interim set of fixes to the issues I found
in my existing code. For longer term, I already have some ideas and
questions on further improving the `ipheth` driver, in particular:

1. Can I make `ipheth` use the `usbnet` framework, rather than it
   re-implementing lower-level things like USB interface handling?
2. How can I reuse parts of `cdc_ncm` to parse incoming URBs?
   Does it require complying with the `usbnet` framework?
3. How can I make use of multiple parallel USB transfers to improve
   throughput? Does `usbnet` support this already, or would it have
   to be implemented?
   Last time I checked, the official driver on macOS does 16 parallel
   transfers. This results in a significant useful throughput increase
   on RX on newer devices over 10 Gbps USB-C: from 650-850 Mbps on
   Linux with `ipheth` to ~3.1 Gbps on macOS.
4. How far back do I keep driver compatibility?
   So far all the changes have been non-breaking, I've been asking
   Georgi Valkov <gvalkov@gmail.com> to test on devices as old as
   iPhone 3G with iOS 4.2.1, which pretty much covers all iOS devices
   and versions capable of internet sharing.
5. Even longer term, would be interesting to investigate the unknown
   control transfers that the official driver does. I avoid doing any
   reverse engineering myself ("clean room" principle), so thinking
   of maybe somehow emulating an iOS device and trying to return
   different values and observing how macOS behaves. Alternatively
   just asking someone else to do the reserve-engineering part, but
   not sure there's any interest in that.

To be clear, these questions are not for you specifically, Bjørn, just
my own notes on what I'd like to investigate next. But if you have any
insight or opinion on any the above, it's absolutely welcome.

These haven't been discussed before, so you didn't miss anything.
I didn't mention it in the cover letter because I'm not sure when I'll
be able to work on these items, didn't want to make promises.
Excuses-excuses, I know. :)

