Return-Path: <netdev+bounces-243166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A851EC9A362
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 07:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2273A4356
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 06:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AC22FFDF0;
	Tue,  2 Dec 2025 06:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPfVR3re"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCA42F6189;
	Tue,  2 Dec 2025 06:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764656151; cv=none; b=HghiilGeCME0JirC0nKmiude1BwJ5bSmF+udkwjSSvAxFL2BH7oQBzK15GoCl57oVH8NEznMZkP+9sOFZDAjlTR4Qhjr+Yj2p+LksaNup0I9X7OpGC+nZ5AnHz0VbR7ZaMgywX83vhvLUMxSPXh41fHQg6FWsATlkoyenzuByVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764656151; c=relaxed/simple;
	bh=qsTYuZd3FTP5N3RouZG5CmvZzfqSmT0ch3VUuBsKyZ4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=VH0nvOBGDdkISlwjY4nfKgcJoelZ5/BDpIXz4FPWWlrXuIrN8ZvuBDidEdCOovJ2rDVdY7GrFVvSFQZ0jVoARbPtP0dXOFDgoeSHtTn8+y3MoTrCYBdmKOFNI4lm5qel1LYD9xFEt5K9WUfBZnIBp2UlTZ1h6Uk494RmXAveG2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPfVR3re; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA14C4CEF1;
	Tue,  2 Dec 2025 06:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764656150;
	bh=qsTYuZd3FTP5N3RouZG5CmvZzfqSmT0ch3VUuBsKyZ4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=JPfVR3rep/KEkUtsWT9W5hLtit9cXbj5eT8S2fcwSKTLezs5A7LdxEIAJj6VrUyvV
	 gzDau+Ey80ruCjtQig2Ie5Sp4eiNX88Jmc7bSZF2h11ZsazD7wLwiovURfFlkrMuTD
	 lJewT9DAeo/EA/rZGA4XEeFfBXq7h0g83UcU3HhBWVInmhyaQ/HdwhLJbQJ0ZHGuZn
	 b7xpW+Bye+bgbJRjSGeVKrDIUB1y+eSTyl2Va5QYD+GZno/Sx/AO7oiUfqMVY551Pb
	 b45nqkv3H8M99ymad+7PyEWFWlwi7gZ7Gn/c7VZI06P9FJ6TS/9LJdsfCdnP1t7eEt
	 4qymQxm37u3rA==
Date: Tue, 2 Dec 2025 07:15:43 +0100 (GMT+01:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
	MPTCP Linux <mptcp@lists.linux.dev>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Message-ID: <a92d7456-67a0-44bd-be03-99f17846a213@kernel.org>
In-Reply-To: <23baf995-080d-4457-b089-a88a317425d2@kernel.org>
References: <20251124-iproute-mptcp-laminar-v1-0-e56437483fdf@kernel.org> <23baf995-080d-4457-b089-a88a317425d2@kernel.org>
Subject: Re: [PATCH iproute2-net 0/6] mptcp: new endpoint type and info
 flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <a92d7456-67a0-44bd-be03-99f17846a213@kernel.org>

Hi David,

2 Dec 2025 03:34:42 David Ahern <dsahern@kernel.org>:

> On 11/24/25 4:19 AM, Matthieu Baerts (NGI0) wrote:
>> Here are some patches related to MPTCP, mainly to control features that
>> will be in the future v6.18.
>>
>> - Patch 1: add an entry in the MAINTAINERS file for MPTCP.
>>
>> - Patch 2: fix two minor typos in the man page.
>>
>> - Patch 3: add laminar endpoint support.
>>
>> - Patches 4-6: display missing attributes & flags in 'ip mptcp monitor'.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Matthieu Baerts (NGI0) (6):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAINTAINERS: add entry for mptcp
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 man: mptcp: fix minor typos
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp: add 'laminar' endpoint support
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp: monitor: add 'server side' info
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp: monitor: add 'deny join id0' info
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp: monitor: support 'server side' as =
a flag
>>
>> MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++=
+++++
>> ip/ipmptcp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 20 ++++++++++++=
+++++---
>> man/man8/ip-mptcp.8 | 20 ++++++++++++++++++--
>> misc/ss.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 2 ++
>> 4 files changed, 44 insertions(+), 5 deletions(-)
>> ---
>> base-commit: 2a82227f984b3f97354e4a490d3f172eedf07f63
>> change-id: 20251124-iproute-mptcp-laminar-2973adec2860
>>
>> Best regards,
>
> applied to iproute2-next.

Thank you!

> Patches should always be against top of tree - no assumptions. I had to
> fixup the first patch of this set which puts work on me.

I'm sorry about that!

These patches were on top of iproute2.git (not next) because they were
controlling features available in v6.18 (or older), but not only in net-nex=
t.

Should I maybe next time not prefix such patches with [iproute2-net] but
only [iproute2]?

Cheers,
Matt

