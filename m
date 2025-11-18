Return-Path: <netdev+bounces-239346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA327C67080
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 03:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3FA14E06D4
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D3A1D2F42;
	Tue, 18 Nov 2025 02:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbEkU+vK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6E41A9F9D;
	Tue, 18 Nov 2025 02:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763433309; cv=none; b=UNJygIuu2ghLjRYHSK6qhhySmOe/71zi9OaYTVVP9n5Iufy5d8kqt5f4INA8wcVoDfcPffMo3qZywc6yqbJ0bmGNAMSSK0b4Yh1Gevt/Z3ciL+0pZcq0GkwOXIv8E4S5Ep5WBK9t8mB75mPftBwL3Du/KbnDYrr0mS90iWcMvkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763433309; c=relaxed/simple;
	bh=unEI2uhhjW5eYfpjHH3xZyxUa780fWtiM4vIAPvgu0s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=oArwIEOAE7y6oc/bm9NtqsNxJBY0a+NiGfVOTl28l5OJCIfBGEdWn9OKGlD/4i4PU73X6LkoU6/+h9hG3q3/Bs3UYORIhIkBqaPnJH15sUPsQhc6ez5T3J991BaoEhdo2/YM8eVjRdPzbxctbvZJA9awHhvxfZ1LXphk0SJDjm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbEkU+vK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC38C2BCAF;
	Tue, 18 Nov 2025 02:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763433309;
	bh=unEI2uhhjW5eYfpjHH3xZyxUa780fWtiM4vIAPvgu0s=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=KbEkU+vKBZPRe4ynAmIGePSLWzkRnccklCwaTHYUWfu6JsaxVMNtlqeiVGQeDtFB8
	 VBOCY0BygSA9fSxAMLzEhZCA31fNtH7hcbK1gTvxgLdAfpwDVnYXEb5PmhD2YcF7E5
	 2XayufdDzN8QTADIdopwIxh6su98tFZDRSlwdWQs5MascbQ7knp1zfK3kqM0kNd2yT
	 gOu9vdR027RDvpEwz72C7uv8SM5lTvcvzU+wnafBGWbpZQQYJ4CjsJSu5Vex7ufo9s
	 E7N83+BkeQut/+UUEcvIFIrOl5kG3a7kooIb2WNXmBaJv83RQ/tVZ1Dauc8XS7KmWU
	 riX9AQ+tuGNFw==
Date: Tue, 18 Nov 2025 03:35:00 +0100 (GMT+01:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang.tang@linux.dev>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	syzbot+2a6fbf0f0530375968df@syzkaller.appspotmail.com,
	Geliang Tang <geliang@kernel.org>,
	MPTCP Linux <mptcp@lists.linux.dev>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>
Message-ID: <e7200954-ce62-42fe-853a-49127b2f129d@kernel.org>
In-Reply-To: <20251117170508.4ffe043f@kernel.org>
References: <20251117100745.1913963-1-edumazet@google.com> <c378da30-4916-4fd6-8981-4ab2ffa17482@kernel.org> <CANn89iLxt+F+SrpgXGvYh9CZ8GNmbbowv5Ce80P1gsWjaXf+CA@mail.gmail.com> <a155bf8b-08cd-4cd9-91d9-f49180f19f6c@kernel.org> <20251117170508.4ffe043f@kernel.org>
Subject: Re: [PATCH v2 net] mptcp: fix a race in mptcp_pm_del_add_timer()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <e7200954-ce62-42fe-853a-49127b2f129d@kernel.org>

Hi Jakub,

Thank you for your reply!

18 Nov 2025 02:05:12 Jakub Kicinski <kuba@kernel.org>:

> On Mon, 17 Nov 2025 11:42:31 +0100 Matthieu Baerts wrote:
>>>> Out of curiosity, is it not OK to reply to the patch with the new
>>>> Reported-by & Closes tags to have them automatically added when applyi=
ng
>>>> the patch? (I was going to do that on the v1, then I saw the v2 just
>>>> when I was going to press 'Send' :) )=C2=A0
>>>
>>> I am not sure patchwork has been finally changed to understand these tw=
o tags.=C2=A0
>>
>> Ah yes, thank you! If there is a dependence on Patchwork, I think
>> indeed, it doesn't recognise the 'Closes' tag (but I think 'Reported-by'
>> is OK).
>>
>> While at it, I forgot to add: this patch can be applied in net directly.
>
> FWIW I have a local script which extracts them from patchwork comments
> and applies them (same for Fixes tags).

Great, good to know, thanks!

(So similar to what "b4 shazam -Msl" would do then.)

> But it's always safer to resend.

Indeed.

Cheers,
Matt

