Return-Path: <netdev+bounces-137385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F211D9A5E86
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 10:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FA0FB21624
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 08:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A6C1E1C31;
	Mon, 21 Oct 2024 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="CUgVjrKj"
X-Original-To: netdev@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34061C69A;
	Mon, 21 Oct 2024 08:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729498973; cv=none; b=KKfsK2XrwjUxphbdZCLw8Jm17OXqxGlWjhJLT7eaC3RvxmrIv5BdqSy4b63muUxJ++PyHrU9M48JYuQ7MNshM3OKibtQDFL8GT7GKzQTRSKLEzoPw979s45eI0nEdIkIHCy8BlN/yR2f2tr5n5CCszBhNiywvxCWh1d+M5X8f2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729498973; c=relaxed/simple;
	bh=kSklYcRQfCui9u2mDUZWU2ikk/GY50Pz/d23LE194K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePcr8HAdKGcwK1pTxDcksPyWuHNkgQ+mgRrCKOm7F94ZDyYV41yZhj1QW9I+09376njKKhub4OJZPLxKsf/FBEhB1AkiaDvBl0icvKuYr+RyDkWid+bcRErUVpcQFWKGgE8fgj3+IP/qD9b5Dlm3j2dCtmmlyQrT5Ng43QPEXuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=CUgVjrKj; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=N5EpxOQva6Z69i9hsu18STwV7GLHJRxR1G+PmvQGu9c=; t=1729498971;
	x=1729930971; b=CUgVjrKjpdGx3DEVKdeuln0BCz4pNdxf+6ul+zw/Empmld5nE4yHmZnQubYzO
	yeQD3APfLwoQYh36/LXGSVL7AEq84UyHl8R3SgI2BJFXfbt2ve/pjfBnywEl2SylMa1P1nbxUzl7C
	7oKPadRFpusfjcq8YIiWRXmTPj7KgRwSVhmuO36aNucB2F3ExBl2/TerRubN/+55iZBZ49leBUEB+
	6ZrzG/4jV/B/bgCZvGe3kW7Aiqdz9adL2LJQr9fauZZoUCZCoRDDWxstls98MucKgwpvRp4UTBZkG
	uoEKRBF/EgV3AKGegOat+7Ndt0csFxK0OzmfA8pueyB2cyJgzw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1t2ngY-0007fi-AP; Mon, 21 Oct 2024 10:22:42 +0200
Message-ID: <9e03dba5-1aed-46b3-8aee-c5bde6d4eaec@leemhuis.info>
Date: Mon, 21 Oct 2024 10:22:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull request: bluetooth 2024-10-16
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20241016204258.821965-1-luiz.dentz@gmail.com>
 <4e1977ca-6166-4891-965e-34a6f319035f@leemhuis.info>
 <CABBYNZL0_j4EDWzDS=kXc1Vy0D6ToU+oYnP_uBWTKoXbEagHhw@mail.gmail.com>
 <CAHk-=wh3rQ+w0NKw62PM37oe6yFVFxY1DrW-SDkvXqOBAGGmCA@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <CAHk-=wh3rQ+w0NKw62PM37oe6yFVFxY1DrW-SDkvXqOBAGGmCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1729498971;c8b84f34;
X-HE-SMSGID: 1t2ngY-0007fi-AP

On 20.10.24 23:25, Linus Torvalds wrote:
> On Fri, 18 Oct 2024 at 09:45, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>>
>> I really would like to send the PR sooner but being on the path of
>> hurricane milton made things more complicated, anyway I think the most
>> important ones are the regression fixes:
>>
>>       Bluetooth: btusb: Fix not being able to reconnect after suspend
>>       Bluetooth: btusb: Fix regression with fake CSR controllers 0a12:0001

BTW, Luiz, thanks for backing up my request, especially given the Milton
aspect!

> I cherry-picked just those, but then I ended up looking at the rest
> just to see if duplicating the commits was worth it.
> 
> And that just made me go "nope", and I undid my cherry-picks and
> instead just pulled the whole thing.

Thx!

> IOW: I've pulled the bluetooth fixes branch directly, but sincerely
> hope this won't become a pattern.

Just to clarify: I assume it's the "taking things directly and thus
bypassing -net" that is the problem here? So if the -net maintainers
would have pulled this on say Friday[1] and sent a second PR that week
it in a case like this would have been totally fine?

Ciao, Thorsten

