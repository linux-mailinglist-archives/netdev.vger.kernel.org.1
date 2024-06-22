Return-Path: <netdev+bounces-105859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB7791347F
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 16:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8ACB2837D9
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 14:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BD816F859;
	Sat, 22 Jun 2024 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEgBHuIo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB80A16C445;
	Sat, 22 Jun 2024 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719067257; cv=none; b=EeWItNg4n6lEdI3nEs+G3lSX2mGTWrpR/hXN/LdXIl2fBtwRGemITyndJcfa1nfxozjis17QgU+EDwOQimpFFBrysr1iaSwjQd1FklUy+FIzsU6OGtoJAWU+TiOdYDv7TKO9kdA25bav1P3DPiqwFpuMwDvLihz8hG1Er+GmP8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719067257; c=relaxed/simple;
	bh=vq98sH94Pp5ZZZ4Zj0kRxD4MHCwJr9PTtWONlriLyKE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=TLvqXlp4RmmO40KFHDJitKq6p13dIU+Q4deRhZvYnq4tLAqu5PnHZeim+EFu+WG78AXU/XP9WEDZ/DhdUvP3aN+/3qHI4skWr8i/N0kESDCTvM8xn0rObdQmoF49s87yihozovJ+dwEMZvalBdpNqcB3bchjS3Wyo84yCogVuZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEgBHuIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27076C3277B;
	Sat, 22 Jun 2024 14:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719067257;
	bh=vq98sH94Pp5ZZZ4Zj0kRxD4MHCwJr9PTtWONlriLyKE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=uEgBHuIoBlARcmUd+XkQlKOaZQqKHE3hDqpua3dl29rr+fz+LT17/eciyj+DxJZiF
	 SlgfTD+p7orMh/ZVTdNTlonfW/L11f6tU7OGdQZdb0+49i/vC38/+brc74AUGWMurS
	 0Ea2UOQ4zBT0ZF+EG7srr+cUldAIPcGMEETCy2hda51lipGX4j7p5ObO7vllQU5OyK
	 +1KuwDNsoS28XAoz8VVnKEYkKey3EhujL4CY+Q2/k7V3EZIQYp2sFmXZ80ir+2rNRr
	 quCKbh35cOuwArM0Igiz/6ZwhHhpT6XNT3QfEeVnYD0pYKSXxqs6TaGR2yS4UBnNJU
	 lGbnEjUXnTBJg==
Date: Sat, 22 Jun 2024 07:40:55 -0700
From: Kees Cook <kees@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 ksummit@lists.linux.dev
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_2/2=5D_Documentation=3A_be?=
 =?US-ASCII?Q?st_practices_for_using_Link_trailers?=
User-Agent: K-9 Mail for Android
In-Reply-To: <87v821d2kp.fsf@mail.lhotse>
References: <20240619-docs-patch-msgid-link-v2-0-72dd272bfe37@linuxfoundation.org> <20240619-docs-patch-msgid-link-v2-2-72dd272bfe37@linuxfoundation.org> <87v821d2kp.fsf@mail.lhotse>
Message-ID: <0BD32B85-22CF-45DF-A70E-FFE8E24469A4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On June 21, 2024 9:27:34 PM PDT, Michael Ellerman <mpe@ellerman=2Eid=2Eau>=
 wrote:
>Konstantin Ryabitsev <konstantin@linuxfoundation=2Eorg> writes:
>> Based on multiple conversations, most recently on the ksummit mailing
>> list [1], add some best practices for using the Link trailer, such as:
>>
>> - how to use markdown-like bracketed numbers in the commit message to
>> indicate the corresponding link
>> - when to use lore=2Ekernel=2Eorg vs patch=2Emsgid=2Elink domains
>>
>> Cc: ksummit@lists=2Elinux=2Edev
>> Link: https://lore=2Ekernel=2Eorg/20240617-arboreal-industrious-hedgeho=
g-5b84ae@meerkat # [1]
>> Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation=2Eorg>
>> ---
>>  Documentation/process/maintainer-tip=2Erst | 30 ++++++++++++++++++++++=
--------
>>  1 file changed, 22 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/process/maintainer-tip=2Erst b/Documentation=
/process/maintainer-tip=2Erst
>> index 64739968afa6=2E=2Eba312345d030 100644
>> --- a/Documentation/process/maintainer-tip=2Erst
>> +++ b/Documentation/process/maintainer-tip=2Erst
>> @@ -372,17 +372,31 @@ following tag ordering scheme:
>> =20
>>   - Link: ``https://link/to/information``
>> =20
>> -   For referring to an email on LKML or other kernel mailing lists,
>> -   please use the lore=2Ekernel=2Eorg redirector URL::
>> +   For referring to an email posted to the kernel mailing lists, pleas=
e
>> +   use the lore=2Ekernel=2Eorg redirector URL::
>> =20
>> -     https://lore=2Ekernel=2Eorg/r/email-message@id
>> +     Link: https://lore=2Ekernel=2Eorg/email-message-id@here
>> =20
>> -   The kernel=2Eorg redirector is considered a stable URL, unlike othe=
r email
>> -   archives=2E
>> +   This URL should be used when referring to relevant mailing list
>> +   topics, related patch sets, or other notable discussion threads=2E
>> +   A convenient way to associate ``Link:`` trailers with the commit
>> +   message is to use markdown-like bracketed notation, for example::
>> =20
>> -   Maintainers will add a Link tag referencing the email of the patch
>> -   submission when they apply a patch to the tip tree=2E This tag is u=
seful
>> -   for later reference and is also used for commit notifications=2E
>> +     A similar approach was attempted before as part of a different
>> +     effort [1], but the initial implementation caused too many
>> +     regressions [2], so it was backed out and reimplemented=2E
>> +
>> +     Link: https://lore=2Ekernel=2Eorg/some-msgid@here # [1]
>> +     Link: https://bugzilla=2Eexample=2Eorg/bug/12345  # [2]
>
>Does it actually make sense to use the Link: prefix here? These sort of
>links are part of the prose, they're not something a script can download
>and make any sense of=2E
>
>I see some existing usage of the above style, but equally there's lots
>of examples of footnote-style links without the Link: tag, eg:

I moved from that to using Link: because checkpatch would complain about m=
y long (URL) lines unless it had a Link tag :P

>commit 40b561e501768ef24673d0e1d731a7b9b1bc6709
>Merge: d9f843fbd45e 31611cc8faa0
>Author: Arnd Bergmann <arnd@arndb=2Ede>
>Date:   Mon Apr 29 22:29:44 2024 +0200
>
>    Merge tag 'tee-ts-for-v6=2E10' of https://git=2Elinaro=2Eorg/people/j=
ens=2Ewiklander/linux-tee into soc/drivers
>
>    TEE driver for Trusted Services
>
>    This introduces a TEE driver for Trusted Services [1]=2E
>
>    Trusted Services is a TrustedFirmware=2Eorg project that provides a
>    framework for developing and deploying device Root of Trust services =
in
>    FF-A [2] Secure Partitions=2E The project hosts the reference
>    implementation of Arm Platform Security Architecture [3] for Arm
>    A-profile devices=2E
>
>    =2E=2E=2E
>
>    [1] https://www=2Etrustedfirmware=2Eorg/projects/trusted-services/
>    [2] https://developer=2Earm=2Ecom/documentation/den0077/
>    [3] https://www=2Earm=2Ecom/architecture/security-features/platform-s=
ecurity
>
>
>The above style is standard markdown style for reference links (or as
>standard as markdown gets)=2E

It's a good point=2E If we're formalizing this, why not literally use mark=
down instead? (I guess the answer is that out-of-line links/footnotes isn't=
 standardized=2E)

Playing devil's advocate, outside of the kernel, these are the two most co=
mmon styles I've seen:

Foo[1]
=2E=2E=2E
[1]: https://=2E=2E=2E=2E

and

Bar[^1]
=2E=2E=2E
[^1] https://=2E=2E=2E

Personally, I only want to have a single official way to do this, and don'=
t care much what it is=2E I have a minor preference for what you've describ=
ed:

Baz[1]
=2E=2E=2E
[1] https://=2E=2E=2E

-Kees

--=20
Kees Cook

