Return-Path: <netdev+bounces-222787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 025DEB560F0
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 14:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E64E1BC0BE9
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 12:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6E42EC0AB;
	Sat, 13 Sep 2025 12:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+M1I8iM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877A4DDD2;
	Sat, 13 Sep 2025 12:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757768067; cv=none; b=jx/hzB04Qn72EvGg0c5tuZHohfldiy3CQB23F5TwJe1ccOwhhlsba3Gkfa8xDnWfQZQZATM30umo6CxkCuyXwqpdGgFy4rvfZUGrp7YGye0UhufxDwrdfdr9ehxCAO4AallO2/XAlLjdNXkD9D/uIRv8SRJvONw7vo9FGC82NGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757768067; c=relaxed/simple;
	bh=5kZch37YLxnV/FLcAbcomFjzaUi7yAZ3rioG5zfcjPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4CYMTqgPeuWLwg9WhScPx1cUfUs/vXyFy0dW4vPHGx8FGJPSdE1wKnDwSTvlFl5xjvRcgm4s2BUUsqPt9yeVmTmtqI4ukp2/TVl8UxPjEg9hRgnkZDC3YXJAq820ikJH38Kd0lsVAL0/Bf+tqYjNSHKkd9LcRJ+YCc0meZaV2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+M1I8iM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73A3C4CEEB;
	Sat, 13 Sep 2025 12:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757768067;
	bh=5kZch37YLxnV/FLcAbcomFjzaUi7yAZ3rioG5zfcjPA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m+M1I8iMxy7O1gG9pJ8jomsV+kgs7Y/ARiQZwk1/rzpS9Wh4NmxPAZ4sol7h+VODn
	 YUqMJVR3+AjvceUoX1lprtpFVYED27wBNixgAZbcLlAJN1vJXEZn7QUBEOo5X227vy
	 NIX2ZnMHO7k9z2gCGF5yToM8MXs1XA70EAHSrzhQcpPbzyHV5QQhj5rtXuvGzmhger
	 vTGqu1sQ5F2sAxGrTIqeDvY941gDF/ipcgdz/snbIse/fb56FrMFJ6Ykp9CLzy/1c+
	 jjMhp/jJ9yRNuUlzmHtp2q/wwl+STwWJPWSMnwOFIUkiJw6GN4K4/M1CdPKkFIgZO7
	 Xhn0oVWLIN0qQ==
Message-ID: <50d79030-9e45-4890-9fee-c0027caf07c9@kernel.org>
Date: Sat, 13 Sep 2025 14:54:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v2 2/3] netlink: specs: team: avoid mangling
 multilines doc
Content-Language: en-GB, fr-BE
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250912-net-next-ynl-attr-doc-rst-v2-0-c44d36a99992@kernel.org>
 <20250912-net-next-ynl-attr-doc-rst-v2-2-c44d36a99992@kernel.org>
 <20250912123518.7c51313b@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250912123518.7c51313b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

Thank you for the reply!

On 12/09/2025 21:35, Jakub Kicinski wrote:
> On Fri, 12 Sep 2025 15:23:00 +0200 Matthieu Baerts (NGI0) wrote:
>> By default, strings defined in YAML at the next line are folded:
>> newlines are replaced by spaces. Here, the newlines are there for a
>> reason, and should be kept in the output.
>>
>> This can be fixed by adding the '|' symbol to use the "literal" style.
>> This issue was introduced by commit 387724cbf415 ("Documentation:
>> netlink: add a YAML spec for team"), but visible in the doc only since
>> the parent commit.
>>
>> Suggested-by: Donald Hunter <donald.hunter@gmail.com>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  Documentation/netlink/specs/team.yaml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/netlink/specs/team.yaml b/Documentation/netlink/specs/team.yaml
>> index cf02d47d12a458aaa7d45875a0a54af0093d80a8..fae40835386c82e934f205219cc5796e284999f1 100644
>> --- a/Documentation/netlink/specs/team.yaml
>> +++ b/Documentation/netlink/specs/team.yaml
>> @@ -25,7 +25,7 @@ definitions:
>>  attribute-sets:
>>    -
>>      name: team
>> -    doc:
>> +    doc: |
>>        The team nested layout of get/set msg looks like
>>            [TEAM_ATTR_LIST_OPTION]
>>                [TEAM_ATTR_ITEM_OPTION]
>>
> 
> htmldoc is not super happy :(
> 
> Documentation/netlink/specs/team.yaml:21: WARNING: Definition list ends without a blank line; unexpected unindent.
> Documentation/netlink/specs/team.yaml:21: WARNING: Definition list ends without a blank line; unexpected unindent.

Arf, I looked at the HTML version, I forgot to look for new warnings...

> Shooting from the hip -- maybe throwing :: at the end of the first line
> will make ReST treat the attrs as a block?

Indeed, I guess it is better to declare a code block instead of a list.
I will fix that in the next version.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


